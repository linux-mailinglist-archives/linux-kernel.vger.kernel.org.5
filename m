Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5157F21AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKTXx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:53:55 -0500
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DFBE;
        Mon, 20 Nov 2023 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700524431; x=1732060431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mg4p26py9pHGYuitsXG9evIpxpd/jBytLWDUhd8t3KA=;
  b=LTHK5K0LG4ZFP+TZI+9XQDkvx1kHwzawRE2A7gC8Omw76Fd+GYp2sWAg
   vqSsMnJZGXyj/PFZcgS24UKpQm4LKzyZm6JI4vu2KIkDYdCWsvgm7DfNT
   dm7grb7B8V2avifQCUcwQ7w69+XNsuvLWysQ/fdxhXCHG0n1PRBO8hel5
   E=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="45092405"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:53:49 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 61E58100E2C;
        Mon, 20 Nov 2023 23:53:49 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:15239]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id f93ebc59-f30e-41a4-b33f-beb97486a1f1; Mon, 20 Nov 2023 23:53:49 +0000 (UTC)
X-Farcaster-Flow-ID: f93ebc59-f30e-41a4-b33f-beb97486a1f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 23:53:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 23:53:39 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <ivan@cloudflare.com>
CC:     <edumazet@google.com>, <hdanton@sina.com>,
        <kernel-team@cloudflare.com>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date:   Mon, 20 Nov 2023 15:53:30 -0800
Message-ID: <20231120235330.60326-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABWYdi31mJmLhKUnCmFpJoEfO8F03tQhDoLxCuu6sJn3Tytbng@mail.gmail.com>
References: <CABWYdi31mJmLhKUnCmFpJoEfO8F03tQhDoLxCuu6sJn3Tytbng@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 20 Nov 2023 14:30:52 -0800
> > > A bit of a problem here is that unix_gc is called unconditionally in
> > > unix_release_sock.
> >
> > unix_release_sock() calls gc only when there is a inflight socket.
> >
> >
> > > It's done asynchronously now and it can only
> > > consume a single CPU with your changes, which is a lot better than
> > > before. I am wondering if we can still do better to only trigger gc
> > > when it touches unix sockets that have inflight fds.
> > >
> > > Commit 3c32da19a858 ("unix: Show number of pending scm files of
> > > receive queue in fdinfo") added "struct scm_stat" to "struct
> > > unix_sock", which can be used to check for the number of inflight fds
> > > in the unix socket. Can we use that to drive the GC?
> >
> > I don't think the stat is useful to trigger gc.  Unless the receiver
> > is accessible via sendmsg(), it's not a gc candidate and we need not
> > care about its stats about valid FDs that are ready to be processed
> > and never cleaned up by gc until close().
> 
> I'm not quite following why it's not useful, could you elaborate? The
> GC call today is conditioned by 16k system-wide inflight unix fds:
> 
> * https://github.com/torvalds/linux/blob/v6.7-rc2/net/unix/af_unix.c#L2204
> * https://github.com/torvalds/linux/blob/master/net/unix/garbage.c#L191
> 
> The only way checking for inflight fds is worse is if there non-unix
> fds inflight. This can be easily alleviated by checking for non-zero
> inflight fds on the socket + system-wide unix fds check, making it
> better than just checking the system-wide gauge. What am I missing?

unix_tot_inflight is the number of inflight AF_UNIX socket, excluding
non-unix fds.  (See unix_inflight())

Let's say sk-A passes its fd to sk-B, and vice versa, and then, we
close sk-A and sk-B.  Each fd passing increments the refcnt of both
"file", so unix_release_sock() is not called for _both_ sockets.

And if we check each socket's inflight fd to trigger gc, and no one
sends fd, we never trigger gc for sk-A and sk-B.  In other words,
unix_gc() call in unix_release_sock() is basically for _other_ sockets,
not for the socket being destroyed there.

So, here we need to check the number of inflight fds in other sockets.
We needed to clean up all inflight dead fd when we close() all AF_UNIX
sockets (because AF_UNIX could be modulised and unloaded).

It can no longer be a module, so technically, we need not run gc at
close() now, but it would be better to not leave the dead fd so long.
We need not wait gc though.

> 
> > > I think we can:
> > >
> > > * Trigger unix_gc from unix_release_sock if there's a non-zero number
> > > of inflight fds in the socket being destroyed.
> >
> > This is the case of now.
> 
> It's not, unless I'm misunderstanding something.

Sorry, I just skipped "in the socket being destroyed", but as mentioned
above, we need to check the system-wide unix_tot_inflight anyway.


> The check today is
> for any inflight fds _system-wide_:
> 
> * https://github.com/torvalds/linux/blob/v6.7-rc2/net/unix/af_unix.c#L684-L685
> 
> My suggestion is to check this _per socket_, making sockets that do
> not pass any fds (likely an overwhelming majority) unaffected.
> 
> > > * Trigger wait_for_unix_gc from the write path only if the write
> > > contains fds or if the socket contains inflight fds. Alternatively, we
> > > can run gc at the end of the write path and only check for inflight
> > > fds on the socket there, which is probably simpler.
> >
> > I don't think it's better to call gc at the end of sendmsg() as there
> > would be small chance to consume memory compared to running gc in the
> > beginning of sendmsg().
> 
> There is no guarantee that GC frees any memory either way.

Right.

> 
> > > GC only applies to unix sockets inflight of other unix sockets, so GC
> > > can still affect sockets passing regular fds around, but it wouldn't
> > > affect non-fd-passing unix sockets, which are usually in the data
> > > path.
> >
> > I think we can run gc only when scm contains AF_UNIX sockets by tweaking
> > a little bit scm processing.
> 
> That's even better than what I'm proposing (all inflight fds -> just
> unix inflight fds being the difference), but probably requires a bit
> more code changes. I'm happy to test a patch when you have it.
> 
> > > This way we don't have to check for per-user inflight fds, which means
> > > that services running as "nobody" wouldn't be punished for other
> > > services running as "nobody" screwing up.
> >
> > If we do not check user, a user could send 16000 AF_UNIX fds and
> > other innocent users sending fds must wait gc.
> 
> In my proposal we check for infight fds per socket and if there are
> none, there is no GC at all.

Again, we need to check the system wide unix_tot_inflight at least
for other sockets that is already close()d and not accessible from
user.  (If we can check the per-socket stat in sendmsg(), the receiver
socket must have its valid fd and is not a gc candidate.)

So, we need to schedule gc when unix_tot_inflight > 16K anyway, and
we need to decide who should wait.  If user has not-yet-received fd,
it could be in the dead fd's recv queue, so the user should wait.

OTOH, the fds that you are suggesting to check are still valid and
not dead at least.

  * if the process is sending AF_UNIX fds
  * if the receiver has inflight fds in recv queue

Botth cases could contribute to trigger gc, but there is less certainty
than user's inflight count.


> 
> > I think isolating users would make more sense so you can sandbox
> > a suspicious process.
> 
> Sure, but that's somewhat beside the point. Ideally things should work
> well outside the box.
> 
> > Probably we can move flush_work() in the preceding if.  Then, the
> > number of gc invocation in the "nobody" case is the same as before.
> 
> Just to make sure I get my point across: I want to have no GC if a
> socket does not possibly contribute any garbage to be collected. If my
> program just passes bytes back and forth and churns through unix
> sockets, it shouldn't be penalized with GC and it shouldn't try to
> schedule GC, no matter what else is going on in the system
> 
> Hope this makes sense.

Yes, that makes sense, and I understnad that sendmsg() with no fds need
not wait, but the point is who is responsible to wait for gc to finish.
