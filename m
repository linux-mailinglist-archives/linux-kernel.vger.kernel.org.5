Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FEF7C5A94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJKR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjJKR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:56:08 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B68B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:56:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c08b7744so1308467b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697046964; x=1697651764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWtaFijWyvVuvqNr4fXwM0s6fDs1JkHJ0F4b/NTx6Fg=;
        b=QEuX5kE2NCe1N3mjYDcDbxTH5FHvBsVBVKZ314v00PCGhcLcAyJgifwL8pGcgNlkIv
         WLEmQfoT8uwIV/fUtOozq3ULJi8OKeyrKst3ADmVbEjkmcS3HdPi3MPqB+dJhUuk4IiM
         KtctoegdjUY33cU0O8E8xfjNo5guPC3xVCeXX8unqsYIo6NnVj8lWO5Uz2bz0JQUXyRT
         DzMLZMo9+HkDMOQdRnM4aH3J32Tm990H6kf+DhK6TDQk6wVhx2j4S9zV6Nd8uQMLI5yu
         iMVuWvnCnVH7/lIbTKPhllTLhqEhMcHz7dILExZ5Ny9N0KV0yR8DPTGf3MLT2NUM3cHv
         TJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046964; x=1697651764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWtaFijWyvVuvqNr4fXwM0s6fDs1JkHJ0F4b/NTx6Fg=;
        b=nW5e7H5VO/gQ1p+8PCEKlykW4kRMeM0qQeUQcxli/e3iKXrBpqr813M+EndkNA8bDe
         U1UkFU1rdVzDmmOxqz/gDJRa1yzooyBFOQ6mXucOT4RIRK+CSGr+5yxldyWfGkRO1FAZ
         XcDyw1L0ol94iwW0iflrZEGrHDWD2CC1RiAVW4xX+cHDahGBbjNN56YwsHFQaQarBc4B
         ehUCkBCfvY9Vh8YFFO57lPjZfOLDjL73oApQxvzzT4Vv5ctnPiz9/OwkH10RHR2VCQwP
         FHpXYMnoh7P0Ogcl5Q0iyTu7YvG5qpFG3GlM/kwbJJfRk8kRsySO1vT70umuxLa63Mcp
         R0Cg==
X-Gm-Message-State: AOJu0YxZkUEnsNrmgnoqEcR36DolHOTj+vWaLmd+yMZOIBj0c1HG83ju
        RntRyFpF9O2YlRyWwEcxlA8anOdnB5Uo7q0dCx4f
X-Google-Smtp-Source: AGHT+IFJX+L5WIMd3iESlAGt+fefkGByy73bo4LOCcsfpjWkp6Ld2fU8oxPp98jSySiVcpcElpI3G9Vijd7B0lotooU=
X-Received: by 2002:a25:938b:0:b0:d15:e204:a7be with SMTP id
 a11-20020a25938b000000b00d15e204a7bemr21290595ybm.8.1697046963771; Wed, 11
 Oct 2023 10:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922152749.244197-1-chris.riches@nutanix.com>
In-Reply-To: <20230922152749.244197-1-chris.riches@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Oct 2023 13:55:52 -0400
Message-ID: <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:28=E2=80=AFAM Chris Riches <chris.riches@nutanix=
.com> wrote:
>
> When auditd_set sets the auditd_conn pointer, audit messages can
> immediately be put on the socket by other kernel threads. If the backlog
> is large or the rate is high, this can immediately fill the socket
> buffer. If the audit daemon requested an ACK for this operation, a full
> socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
> socket.
>
> To avoid this race and ensure ACKs get through, fast-track the ACK in
> this specific case to ensure it is sent before auditd_conn is set.
>
> Signed-off-by: Chris Riches <chris.riches@nutanix.com>

Thanks for looking into this and submitting a patch Chris!

I think the basic approach is good, but I think we can simply things
slightly by using a resettable boolean as opposed to an integer flag
for the ACK.  I've pasted in a quick, untested patch (below) to better
demonstrate the idea, let me know what you think.  Further thoughts
below ...

> This mail is more of an RFC than a patch, though the included patch is a
> useful illustation and might even be suitable for inclusion.

Regardless of any other issues, I think you brought up a good point
about there being socket buffer contention when the queues are
full(ish) and an audit daemon connects to the kernel and while I'm not
sure that this patch will fully resolve that issue, I do think it
would be good to have (I'm doubtful if it can be fully resolved
without some really awful hacks).

> We are experiencing strange failures where the audit daemon fails to
> start, hitting an ENOBUFS error on its audit_set_pid() call. This can be
> reproduced by repeatedly restarting the audit daemon (or just doing a
> tight loop of audit_open(), audit_set_pid(pid), audit_set_pid(0),
> audit_close()) while the system is under heavy audit load. This also
> seems to be dependent on the number of CPUs - we can reproduce this with
> 2 CPUs but not with 48.

The ENOBUFS errors are coming from the netlink layer and are likely a
sign of extreme load.  I'm not very familiar with the audit userspace
code, but it might be helpful to see if you can increase the socket
buffer size for the audit daemon.

> Tracing showed a race between the kernel setting auditd_conn and sending
> the ACK, as described in the commit message. The included patch attempts
> to fix this by ensuring the ACK is sent before any audit messages can be
> put on the socket. This seems to fix the problem for auditd starting,
> but strangely I still hit it when running my minimal repro (the tight
> loop mentioned above), albeit less frequently. I'm not sure if the patch
> or the repro is at fault.

Sending a zero PID value, e.g. audit_set_pid(0), is going to cause the
kernel to reset/drop the connection with the audit daemon; it's
essentially the same as an orderly shutdown of the audit daemon.
However, if you do it in a tight loop alternating between
audit_set_pid(X) and audit_set_pid(0) you are basically thrashing the
audit daemon connection state in the kernel which is in turn likely
causing odd things to happen both with the kernel's audit queues and
the auditd socket buffer.

While the userspace reproducer is valid, it isn't something I would
expect in normal use as simply starting and stopping the audit daemon
adds a significant delay between disconnecting and reconnecting.

I'm also not surprised to hear that as you increase the number of CPUs
the problem goes away.  With more CPUs the system is able to schedule
more threads simultaneously to maintain the kernel's audit queues and
execute the audit daemon to drain both the netlink socket buffer and
audit queues.

> We may also want to look at this from the userspace side in the audit
> daemon itself (or more specifically, libaudit). The ACK handling is a
> little odd - check_ack() will happily return success without seeing an
> ACK if a non-ACK message is top of the socket queue, but will fail if no
> message arrives within the timeout. It also of course fails if ENOBUFS
> is set on the socket, but this failure only seems to matter when doing
> audit_set_pid() - similar failures during main-loop message processing
> are logged but otherwise ignored, as far as I can tell.

I suggest bringing this up with the audit userspace developer if you
haven't already.  While we can, and should, improve things on the
kernel side (e.g. the patch we are discussing), it also sounds like
the userspace side has room for improvement as well.

Here is the patch I mentioned above:

diff --git a/kernel/audit.c b/kernel/audit.c
index 16205dd29843..49f18003c1ac 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -487,15 +487,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
 * @pid: auditd PID
 * @portid: auditd netlink portid
 * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
 *
 * Description:
 * This function will obtain and drop network namespace references as
 * necessary.  Returns zero on success, negative values on failure.
 */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid,
+                     struct net *net, struct sk_buff *skb, bool *ack)
{
       unsigned long flags;
       struct auditd_connection *ac_old, *ac_new;
+       struct nlmsghdr *nlh;

       if (!pid || !net)
               return -EINVAL;
@@ -507,6 +511,13 @@ static int auditd_set(struct pid *pid, u32 portid, str=
uct n
et *net)
       ac_new->portid =3D portid;
       ac_new->net =3D get_net(net);

+       /* send the ack now to avoid a race with the queue backlog */
+       if (*ack) {
+               nlh =3D nlmsg_hdr(skb);
+               netlink_ack(skb, nlh, 0, NULL);
+               *ack =3D false;
+       }
+
       spin_lock_irqsave(&auditd_conn_lock, flags);
       ac_old =3D rcu_dereference_protected(auditd_conn,
                                          lockdep_is_held(&auditd_conn_lock=
));
@@ -1200,7 +1211,8 @@ static int audit_replace(struct pid *pid)
       return auditd_send_unicast_skb(skb);
}

-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+                            bool *ack)
{
       u32                     seq;
       void                    *data;
@@ -1293,7 +1305,8 @@ static int audit_receive_msg(struct sk_buff *skb, str=
uct n
lmsghdr *nlh)
                               /* register a new auditd connection */
                               err =3D auditd_set(req_pid,
                                                NETLINK_CB(skb).portid,
-                                                sock_net(NETLINK_CB(skb).s=
k));
+                                                sock_net(NETLINK_CB(skb).s=
k),
+                                                skb, ack);
                               if (audit_enabled !=3D AUDIT_OFF)
                                       audit_log_config_change("audit_pid",
                                                               new_pid,
@@ -1538,9 +1551,10 @@ static int audit_receive_msg(struct sk_buff *skb, st=
ruct
nlmsghdr *nlh)
 * Parse the provided skb and deal with any messages that may be present,
 * malformed skbs are discarded.
 */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
{
       struct nlmsghdr *nlh;
+       bool ack;
       /*
        * len MUST be signed for nlmsg_next to be able to dec it below 0
        * if the nlmsg_len was not aligned
@@ -1553,9 +1567,13 @@ static void audit_receive(struct sk_buff  *skb)

       audit_ctl_lock();
       while (nlmsg_ok(nlh, len)) {
-               err =3D audit_receive_msg(skb, nlh);
-               /* if err or if this message says it wants a response */
-               if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+               ack =3D nlh->nlmsg_flags & NLM_F_ACK;
+               err =3D audit_receive_msg(skb, nlh, &ack);
+
+               /* if audit_receive_msg() clears @ack then we never want to
+                * send an ack here, otherwise send an ack on error or if
+                * requested */
+               if (ack && (err || (nlh->nlmsg_flags & NLM_F_ACK)))
                       netlink_ack(skb, nlh, err, NULL);

               nlh =3D nlmsg_next(nlh, &len);

--=20
paul-moore.com
