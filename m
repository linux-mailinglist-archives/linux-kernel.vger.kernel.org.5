Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD51792819
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjIEQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353785AbjIEIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A794CD2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693901390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxz+8eCTkxEOHGidOvFv8Aj94pooA+xm4HPyOHRACMo=;
        b=YTCGxqkAKT6k6/OXG6khFduaJJqItKP2060lsUjVZQShEvJlZ4LbpHxoFyasx4ae4+EzNx
        igJpX3k49VSQ0838dBUZZBC9tzzd0sjgSMyzd49TA/CFIDtlMmgLp8f3zxJ4EEaTXgwF7m
        HPpzMxXPH9bHpD63UrVXSJ4RK55KmC4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-CPhjkGm6P6eBBFlPe_ZHoQ-1; Tue, 05 Sep 2023 04:09:46 -0400
X-MC-Unique: CPhjkGm6P6eBBFlPe_ZHoQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-525691cfd75so311283a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693901386; x=1694506186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxz+8eCTkxEOHGidOvFv8Aj94pooA+xm4HPyOHRACMo=;
        b=loJzsVIGTMGx6qrjpr++dIlnWDPrS1MzS7CvMEy8abHSRfHMPJnFqr+xZ0xFuF8fr+
         zOOkPQJJ9cJyQoVckBgLcLY1ENuLYSj/mD5WSH6ZZZX3aSi0fR9rfEek0fVTdib13GsP
         nXU2bq1OGcTV+tWEOOhQs1tPQ8LTJvLVYR1+WMcWDn8DiB6nmokf08IfoaMiA9+KCAS1
         SYor4rQ9JgAOmH2VuBIoMcIqCyWuD/pChfmgv84b/lZtor3LnlZOwQnatvJ4wPUpeZBM
         Q9ttWPE3ot5GE6IwA7qVpPQcvsV2CCB1SKmqSz2C/goA6WtWaRgFGnpW/y/WxKDB4tcM
         o+5w==
X-Gm-Message-State: AOJu0Yz2tpgJja4kSMS1Q7IkVbhIS6aVpAMM9I9L4ANCfKaOEdv8gRH1
        CkiutfEdspsUpyna/PMhkhRi6szrI2NZ1EO5HeLn+5as7Zi3ZtU/1bm3r//o6hX0J6q4oELpxFb
        BF9uW59WWRzGeFkZHuVWZlPHV
X-Received: by 2002:a05:6402:5191:b0:523:37cf:6f37 with SMTP id q17-20020a056402519100b0052337cf6f37mr8515192edd.4.1693901385904;
        Tue, 05 Sep 2023 01:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp5vySoMRlvjLb2rntCU9VeYWU42eXy2n6MkRFMnPRU9gWL6Mq0jqfLFqUlxt7M1SUBUQyYA==
X-Received: by 2002:a05:6402:5191:b0:523:37cf:6f37 with SMTP id q17-20020a056402519100b0052337cf6f37mr8515175edd.4.1693901385595;
        Tue, 05 Sep 2023 01:09:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b005257da6be23sm6873549eds.75.2023.09.05.01.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:09:45 -0700 (PDT)
Message-ID: <279a856aa6710becf9ebb13ab74e7afb6add0045.camel@redhat.com>
Subject: Re: [PATCH net] kcm: Fix memory leak in error path of kcm_sendmsg()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Date:   Tue, 05 Sep 2023 10:09:43 +0200
In-Reply-To: <20230902165216.1721082-1-syoshida@redhat.com>
References: <20230902165216.1721082-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2023-09-03 at 01:52 +0900, Shigeru Yoshida wrote:
> syzbot reported a memory leak like below [1]:
>=20
> BUG: memory leak
> unreferenced object 0xffff88810b088c00 (size 240):
>   comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
>   hex dump (first 32 bytes):
>     00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
>     [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
>     [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
>     [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
>     [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
>     [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
>     [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
>     [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
>     [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> In kcm_sendmsg(), newly allocated socket buffers can be added to skb->nex=
t. If
> an error occurred and jumped to out_error label, those newly allocated so=
cket
> buffers can be leaked. This patch fixes this issue by remembering the las=
t
> allocated socket buffer in kcm_tx_msg(head)->last_skb.

I think the root cause should be clarified a little more.=C2=A0When the
'head' skb will be freed, all the frag_list skbs will be released, too.

AFAICS the issue is that in case of error after copying some bytes,
kcm_tx_msg(head)->last_skb is left unmodified and such reference is
used as the cursor to append newly allocated skbs to 'head'.

A later kcm_sendmsg will use an obsoleted 'last_skb' reference,
corrupting the 'head' frag_list and causing the leak.

The fix looks correct, but could you please send a v2 with an
updated/more extensive commit message?

> Link: https://syzkaller.appspot.com/bug?extid=3D6f98de741f7dbbfc4ccb [1]
> Reported-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Additionally please feed the patch to syzbot, so it can verify the fix,
and add the relevant tag.

Thanks,

Paolo

