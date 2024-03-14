Return-Path: <linux-kernel+bounces-103084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D144187BAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881742832A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A6D1B9;
	Thu, 14 Mar 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKjMAc4H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE96CDC1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410391; cv=none; b=UElZeybge2FgcsI1zTChuTiJlT8vSkItu3SU1ozhs1l2EIP0e+6FQc2snKYDchbnVSI+smqKXjcdh8JhZ5YbYpGt9qUr/QdxzCwgSTICMo2GBYuQYq7D9jw3KnonzgBxncCpfYyvNsiR4gYhCJANO1mn9QPYJTL6cVc5PwSXc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410391; c=relaxed/simple;
	bh=khQOvVvScyocEKpmA+aGIJ5kiWLTdxRa5DbV0xstMCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdB5RM1+1ftnL2A7zTDL168vxTFUp77umPayzboAoqq9mvtBl94h+lbQc6KTNbgbY6Sh6qTfnp68ZH7Ioed3FZEIHD+kTPYNPL7TWCsBV3Lrmi4lfVnn9Am7JU/KSBzMHyO5G62n3+jjREAodrbk48L9xiPul/tZSq2GdJ5q/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKjMAc4H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710410388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyvx3Vc8lOvBxjpooHTJrUQfdPzNhnJB8jAjrA6m8B0=;
	b=RKjMAc4HfiRp/x65yrqPNkt0BiD9C8sW2sRkftH+dzU4M/MYsV9tKHItaayz43oTViNQt4
	rgBvNy6mg6WIQKne9Vy8194zFK+n7FmwV+rios4NGmmG94CzjugifBUTOhLcwzTQmd9iHi
	mP9EcvoqHKjIlrHMjLG9oareLvmzd1U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-0Uq6WxMtOG27GVMyMHFhPw-1; Thu, 14 Mar 2024 05:59:46 -0400
X-MC-Unique: 0Uq6WxMtOG27GVMyMHFhPw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e5c81df328so658065b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410385; x=1711015185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyvx3Vc8lOvBxjpooHTJrUQfdPzNhnJB8jAjrA6m8B0=;
        b=QGBa/mytUcCIyeGxtP9aQ5eeaD4mNYP6m4t7b4LL7MPaDzNjfJaToXYs1x8nxb6R0b
         XvTI0aJAwY0IanPq9vXgRMa7ARMZF1YU8Zdoi0k1yxjNpyy/TyPOdjf3PJZmjphedT4D
         6XbP+K5UISVDUhHJszh+m2931XtMYhAZmvxxusQIOXNhOmJrB5uKy5/b2LJ4SzL13NSM
         9ICnYySGS8OhKfk5CLWbgnw4FSEqpyEc4312+Q3RAhuepo4hDzSYzb3igwrnDFzDrqDF
         7cN8/4tvUGpeddLhK8fH0FnkyGodxwa66Ox/pbh+0E55x3O7e5asgNPjn0Q4g/VgsNnT
         CVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj5tUtQcUa6+qovpOo2k8DmqVucLKzo4tEPFkSyg63OZGboN7o9LnvBzrl8F8Nbd9VCHkClu6BOc1UXvZ10K8tUJOQXhwjHZ84LG+n
X-Gm-Message-State: AOJu0YwUaVSwsLMKZSpoLyH+NVeHWJ5CpEgQRgq+7qdjVPh0pqt8GXQk
	LMN4FhAYDfV6IjkeuYEgeqChbj8cwc71He7pNgi85Dp5RHzC/Qz13iw3gLIqoEWp8aXsWBRyBer
	dsKW82muBwmqYsT0Azxt9H574Kg7sKGzNXUV1aFpTJXT4GfqpuVcZuO2FypYSjw==
X-Received: by 2002:a05:6a00:22ca:b0:6e6:98a0:49ac with SMTP id f10-20020a056a0022ca00b006e698a049acmr1366563pfj.16.1710410385440;
        Thu, 14 Mar 2024 02:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYg8mczSJLVRdH5V982goMFwxRT8+cRJVhbVMQNjTJ/zF6xjhwao9R0JVAR2yxUGmZQPdgcw==
X-Received: by 2002:a05:6a00:22ca:b0:6e6:98a0:49ac with SMTP id f10-20020a056a0022ca00b006e698a049acmr1366546pfj.16.1710410385022;
        Thu, 14 Mar 2024 02:59:45 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm1082367pfb.51.2024.03.14.02.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:59:44 -0700 (PDT)
Date: Thu, 14 Mar 2024 18:59:40 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
Message-ID: <ZfLKjD6aMrGPEgHh@zeus>
References: <20240312145658.417288-1-ryasuoka@redhat.com>
 <413249a5-13b0-4a06-9819-650eb4e82b37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413249a5-13b0-4a06-9819-650eb4e82b37@linaro.org>

On Wed, Mar 13, 2024 at 10:01:27AM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2024 15:56, Ryosuke Yasuoka wrote:
> > syzbot reported the following unitit-value access issue [1]:
> 
> If there is going to be any new version then: typo, uninit-value

Thank you for pointing out. I'll fix it.

> > 
> > nci_ntf_packet() calls each ntf operation parsed from skb->data. When
> > the payload length is zero, each operation handler reads uninitialized
> > payload and KMSAN detects this issue. Such notification packet should be
> > silently discarded since it is unexpected for any notification handlers.
> > 
> > This patch resolved this issue by checking payload size before calling
> > each notification handler codes.
> > 
> > BUG: KMSAN: uninit-value in nci_init_req net/nfc/nci/core.c:177 [inline]
> > BUG: KMSAN: uninit-value in __nci_request net/nfc/nci/core.c:108 [inline]
> > BUG: KMSAN: uninit-value in nci_open_device net/nfc/nci/core.c:521 [inline]
> > BUG: KMSAN: uninit-value in nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
> >  nci_init_req net/nfc/nci/core.c:177 [inline]
> >  __nci_request net/nfc/nci/core.c:108 [inline]
> >  nci_open_device net/nfc/nci/core.c:521 [inline]
> >  nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
> >  nfc_dev_up+0x26e/0x440 net/nfc/core.c:118
> >  nfc_genl_dev_up+0xfe/0x1d0 net/nfc/netlink.c:770
> >  genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
> >  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
> >  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1067
> >  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
> >  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
> >  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
> >  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg net/socket.c:745 [inline]
> >  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
> >  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
> >  __sys_sendmsg net/socket.c:2667 [inline]
> >  __do_sys_sendmsg net/socket.c:2676 [inline]
> >  __se_sys_sendmsg net/socket.c:2674 [inline]
> >  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > 
> > Uninit was stored to memory at:
> >  nci_core_reset_ntf_packet net/nfc/nci/ntf.c:36 [inline]
> >  nci_ntf_packet+0x19dc/0x39c0 net/nfc/nci/ntf.c:782
> >  nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
> >  process_one_work kernel/workqueue.c:2633 [inline]
> >  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
> >  worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
> >  kthread+0x3ed/0x540 kernel/kthread.c:388
> >  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > 
> > Uninit was created at:
> >  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> >  slab_alloc_node mm/slub.c:3478 [inline]
> >  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
> >  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
> >  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
> >  alloc_skb include/linux/skbuff.h:1286 [inline]
> >  virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
> >  vfs_write+0x48b/0x1200 fs/read_write.c:588
> >  ksys_write+0x20f/0x4c0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > 
> > CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> 
> These two lines are not really relevant, it's a virtual platform, so
> whether this is Google or Amazon it does not matter, and your log paste
> is already quite long. If there is going to be any resend, I propose to
> drop.

OK. Do you mean all these log messages that syzbot reported should be
dropped or I should leave only relavant messages?

> > 
> > Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> > Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  net/nfc/nci/ntf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> > index 994a0a1efb58..56624387e253 100644
> > --- a/net/nfc/nci/ntf.c
> > +++ b/net/nfc/nci/ntf.c
> > @@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
> >  		 nci_opcode_oid(ntf_opcode),
> >  		 nci_plen(skb->data));
> >  
> > +	if (!nci_plen(skb->data))
> > +		goto end;
> 
> Looks reasonable, however wouldn't there be the same issue in
> nci_rsp_packet() and other cases from nci_rx_work()? I wonder why only
> NTF packets could be constructed without payload.

Yes, I can reproduced very similar bug reported by syzbot [2] in my lab.
When the MT is NCI_MT_RSP_PKT (0x2), KMSAN detects the following bug in
nci_rsp_packet().

[How to reproduce]
(gdb) b net/nfc/nci/core.c:1516
Breakpoint 2 at 0xffffffff8eba68bc: file net/nfc/nci/core.c, line 1516.
(gdb) c   <<<--- Run the reproducer provided in [1]
..
1516                    switch (nci_mt(skb->data)) {
(gdb) p skb->data
$2 = (unsigned char *) 0xffff88802e75d400 "`"
(gdb) p/x *(unsigned char *)0xffff88802e75d400
$4 = 0x60
(gdb) p/x *(unsigned char *)0xffff88802e75d400 = 0x50
$5 = 0x50
(gdb) c
..

[  370.186593][ T8135] =====================================================
[  370.188107][ T8135] BUG: KMSAN: uninit-value in nci_dev_up+0xfb4/0x1590
[  370.189016][ T8135]  nci_dev_up+0xfb4/0x1590
[  370.189642][ T8135]  nfc_dev_up+0x281/0x520
[  370.190312][ T8135]  nfc_genl_dev_up+0xf1/0x1c0
[  370.190990][ T8135]  genl_rcv_msg+0x1220/0x12c0
[  370.192189][ T8135]  netlink_rcv_skb+0x542/0x670
[  370.192865][ T8135]  genl_rcv+0x41/0x60
[  370.193426][ T8135]  netlink_unicast+0xf43/0x1220
[  370.194118][ T8135]  netlink_sendmsg+0x1242/0x1420
[  370.194801][ T8135]  ____sys_sendmsg+0x98b/0xd10
[  370.195509][ T8135]  ___sys_sendmsg+0x271/0x3b0
[  370.196163][ T8135]  __x64_sys_sendmsg+0x2ee/0x4b0
[  370.196849][ T8135]  do_syscall_64+0x6d/0x140
[  370.197511][ T8135]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  370.198362][ T8135]
[  370.198681][ T8135] Uninit was stored to memory at:
[  370.199392][ T8135]  nci_dev_up+0xfad/0x1590
[  370.200011][ T8135]  nfc_dev_up+0x281/0x520
[  370.200608][ T8135]  nfc_genl_dev_up+0xf1/0x1c0
[  370.201669][ T8135]  genl_rcv_msg+0x1220/0x12c0
[  370.202332][ T8135]  netlink_rcv_skb+0x542/0x670
[  370.203012][ T8135]  genl_rcv+0x41/0x60
[  370.203563][ T8135]  netlink_unicast+0xf43/0x1220
[  370.204250][ T8135]  netlink_sendmsg+0x1242/0x1420
[  370.204914][ T8135]  ____sys_sendmsg+0x98b/0xd10
[  370.205525][ T8135]  ___sys_sendmsg+0x271/0x3b0
[  370.206041][ T8135]  __x64_sys_sendmsg+0x2ee/0x4b0
[  370.206552][ T8135]  do_syscall_64+0x6d/0x140
[  370.207106][ T8135]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  370.207841][ T8135]
[  370.208160][ T8135] Uninit was stored to memory at:
[  370.208749][ T8135]  nci_rsp_packet+0x1daf/0x3b30
[  370.209295][ T8135]  nci_rx_work+0x1e8/0x530
[  370.209746][ T8135]  process_scheduled_works+0x1174/0x1e20
[  370.210449][ T8135]  worker_thread+0xea3/0x1490
[  370.210989][ T8135]  kthread+0x3d1/0x530
[  370.211932][ T8135]  ret_from_fork+0x66/0x80
[  370.212580][ T8135]  ret_from_fork_asm+0x11/0x20


345 void nci_rsp_packet(struct nci_dev *ndev, struct sk_buff *skb)
346 {
347         __u16 rsp_opcode = nci_opcode(skb->data);
..
370         switch (rsp_opcode) {
371         case NCI_OP_CORE_RESET_RSP:
372                 nci_core_reset_rsp_packet(ndev, skb);

 28 static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
 29                                       const struct sk_buff *skb)
 30 {
 31         const struct nci_core_reset_rsp *rsp = (void *)skb->data;
 ...
 36         if (skb->len != 1) {
 37                 if (rsp->status == NCI_STATUS_OK) {
 38                         ndev->nci_ver = rsp->nci_ver;   <<<---

So it means we should check the payload length in not nci_ntf_packet()
but in nci_rx_work(). Like this. (Note that it has not tested.)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..f9880d6ad2b2 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
                nfc_send_to_raw_sock(ndev->nfc_dev, skb,
                                     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);

+               if (!nci_plen(skb->data)) {
+                       skb(free);
+                       break;
+               }
+
                /* Process frame */
                switch (nci_mt(skb->data)) {
                case NCI_MT_RSP_PKT:

Let me know if you have any idea.

https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
https://syzkaller.appspot.com/bug?extid=685805de744584f4d24b [2]

Best Regards,
Ryosuke


