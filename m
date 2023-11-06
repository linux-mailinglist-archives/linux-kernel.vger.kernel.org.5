Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151997E1B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjKFHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjKFHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:36:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191A134
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:36:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso6994168a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699256211; x=1699861011; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Y2aGthN1YDrgbuoXhH81nEgX3ffno/slnIsK/Qu8E=;
        b=WM1bujhhHfdMll9lUCNd1LAebpINkmiT+/j6ENA0WjAcyOE77yYokL1fE2uT8VY2Fr
         kg3x2AgYyNTrINlniYHLeLVIk0n96eopDHX7m135BzNDoR5PZOsbDs9BucKu1KEQGtgo
         KhpVhSlrfAFB06vBOvlIuh2Q6CqY0QoxHc3BAxw050IpNivKMfdu4xwz2GSQ3IuC2fiS
         zefTpHpwMLetDC8phsP9DFSiTdjwF4A7RIt/r57nftmihlX5YbPstEIKkGAKM+3OND/N
         D/ZE0WaktzZm7jQKJvzGq7Po+jTifwhQC+oDbd8V1Hex6V0qKRzkUzzvho5Egrdyo0aZ
         JsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699256211; x=1699861011;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5Y2aGthN1YDrgbuoXhH81nEgX3ffno/slnIsK/Qu8E=;
        b=roO4Bk3KMwwu0VVSoC6orpl5LgGYI00B/xjMY/MNy2XomUJF36jbvBxOfWpacvz+bq
         AzgqaWdnQO1Xfs1KnZcvbwyw17YUn1QW/Z1PTxakNfgjo4p1iwvWmOfOq0VI18GsO4tg
         WkA2ivSuHZ8g2aNi2jLYfUlh8lDQl3arJYPLMaXQHDCYNfCLBdvses8rGevvns90CyNT
         RHiGWAeFZRtDNlUmR9CCttLGgUQODnrdPTQOmILvqrTjh8bLfw6Un0wZgkKWOq2mVCVh
         CrnUEcSH9aj1wSvwn96uICwAngl4wRAgx1vkJZpguMQYpMWt1gRNSkPxpm0p2TV7G/7U
         xa/w==
X-Gm-Message-State: AOJu0YwPF7K7Mhyr8mSEXXUv+Dk83SKVeHcQps1nTlMk3wRKV3vvpEdL
        MoOMxohBn3SHUEoLeXdaoch54A==
X-Google-Smtp-Source: AGHT+IHRdxgPLaEB/Ys53FpvH5+8AW9GdamUpHFdhxBifRJQyJEUpUrJUUSKnvQ3gtRK2DIDINCsrg==
X-Received: by 2002:a17:907:1def:b0:9d6:d78f:cdd9 with SMTP id og47-20020a1709071def00b009d6d78fcdd9mr10689622ejc.35.1699256211299;
        Sun, 05 Nov 2023 23:36:51 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906190900b009a5f1d15642sm3794096eje.158.2023.11.05.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 23:36:50 -0800 (PST)
Date:   Mon, 6 Nov 2023 08:36:48 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com
Cc:     Steve French <smfrench@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: smb cifs: Linux 6.7 pre rc-1 kernel dump in smb2_get_aead_req
Message-ID: <ZUiXkPPP1TuOgmmf@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com,
        Steve French <smfrench@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>, CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain>
 <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
 <20231105201516.GC91123@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105201516.GC91123@sol.localdomain>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.6.0)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05. Nov 12:15, Eric Biggers wrote:
> On Sun, Nov 05, 2023 at 08:40:03PM +0100, Damian Tometzki wrote:
> > On Sun, 05. Nov 11:36, Eric Biggers wrote:
> > > On Sun, Nov 05, 2023 at 11:05:30AM -0700, Steve French wrote:
> > > > maybe related to this recent crypto patch?
> > > > 
> > > > https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=783fa2c94f4150fe1b7f7d88b3baf6d98f82b41b
> > > > 
> > > > On Sun, Nov 5, 2023, 10:32 Damian Tometzki <damian@riscv-rocks.de> wrote:
> > > > > [   83.530503] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W
> > > > >     6.6.0 #61
> > > > > [   83.530508] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W
> > > > > (1.62 ) 07/12/2023
> > > 
> > > The above suggests that this warning occurred on 6.6, not on 6.7 pre rc1.
> > > 
> > > - Eric
> > Hello,
> > 
> > is little bit missleading but it is 6.6 from linus mainline git with all
> > the pull request. 
> > 
> > Damian
> > 
> 
> Okay, next time please mention the actual commit ID.  Anyway, the warning is
> 'WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter))', so maybe take a look at
> changes from 
> 
>     commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74
>     Author: David Howells <dhowells@redhat.com>
>     Date:   Mon Sep 25 13:03:03 2023 +0100
> 
>         iov_iter: Derive user-backedness from the iterator type
>
Hello Eric,

the revert of f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 solved the issue of the kernel dump.

diff --git a/include/linux/uio.h b/include/linux/uio.h
index b6214cbf2a43..02a8e5e6c458 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -43,6 +43,7 @@ struct iov_iter {
        bool copy_mc;
        bool nofault;
        bool data_source;
+       bool user_backed;
        size_t iov_offset;
        /*
         * Hack alert: overlay ubuf_iovec with iovec + count, so
@@ -139,7 +140,7 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
-       return iter_is_ubuf(i) || iter_is_iovec(i);
+       return i->user_backed;
 }
 
 /*
@@ -358,6 +359,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
        *i = (struct iov_iter) {
                .iter_type = ITER_UBUF,
                .copy_mc = false,
+               .user_backed = true,
                .data_source = direction,
                .ubuf = buf,
                .count = count,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..a077c15727b2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -168,6 +168,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
                .iter_type = ITER_IOVEC,
                .copy_mc = false,
                .nofault = false,
+               .user_backed = true,
                .data_source = direction,
                .__iov = iov,
                .nr_segs = nr_segs,
 
> and the pull request that contained it:
> 
>     commit df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d
>     Merge: 3b3f874cc1d07 b5f0e20f444cd
>     Author: Linus Torvalds <torvalds@linux-foundation.org>
>     Date:   Mon Oct 30 09:24:21 2023 -1000
> 
>         Merge tag 'vfs-6.7.iov_iter' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> 
>         Pull iov_iter updates from Christian Brauner:
>          "This contain's David's iov_iter cleanup work to convert the iov_iter
>           iteration macros to inline functions:
