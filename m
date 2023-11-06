Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A77E1C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjKFInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKFInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B78CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699260185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2V4SrKmDXM7Q2ya/olfBds0kRGyhozqRxAHHZYjEaw=;
        b=GeICvC9cS0oavNbL80sw0chDc/BqwZU4se9E30Yp6H94R50fxNNKV64Ae41458yBgIeHfY
        AaxW7plsaGNkExIiyfSubEhjz2F8uBbUAojRAE55z6ZpTupcPKrpuikBqkHtemHZShTQQo
        zH3F1cl4o3ilrm1m54/7dTshZn/dLXY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-wYTKZQ-cMii9FEMzKIbxYQ-1; Mon, 06 Nov 2023 03:43:03 -0500
X-MC-Unique: wYTKZQ-cMii9FEMzKIbxYQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32fa25668acso2128697f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260182; x=1699864982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2V4SrKmDXM7Q2ya/olfBds0kRGyhozqRxAHHZYjEaw=;
        b=IAYLZtTzL8DuDKP4F+ppY0+fKp8vzMfT+MTiw5XJaLtfqZ8IUJ3CQGtKV47OOOQEkw
         Jx6Y8mBBg00OilMFjuXdpkTjnGIV4EQc+UOyw36wwDGeOC6wR4lvfOOm0D5UTb+9DOq2
         fH4VMzrxFW6vX7ncWZDNIrIUvjmNedwvTYF9PmykYCQa3u7d3CZUZq7iQSKBflbO8viM
         laZfMBymrWyO23TPX2SimR/lS3tNN8G3Bmgr/AYZWeisbUBF/RdPcE1IK/qmtHghben6
         0t8P9wiy5m5ttBTm1SXngtY6NMxcNlhdDoxzimE/vRCHxhL7jQqw2cYCfBGLPeteLMFP
         x4hA==
X-Gm-Message-State: AOJu0YwHbQTwcRdZ0qjE8k8LorKRhdFD2bf+hmqAqx9OR1wVP7NPQ8dJ
        sh3WGk0nEA8FBZB1+07t5ldPr8uQGfIaaTDLo8vAzD+YmDhIWJ/SdC2wBAWYm52h9ZweWdQDM4w
        H0JmbXALMuM65fONT89WvyPXt
X-Received: by 2002:a05:6000:1b09:b0:31f:a256:4bbb with SMTP id f9-20020a0560001b0900b0031fa2564bbbmr19083183wrz.71.1699260182719;
        Mon, 06 Nov 2023 00:43:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX7O05rSfYP8gnU/IJPVZ20H/dR30/gVHdp15QL98NSczZRPr1cdg4L3jI9YQeK5n1BcwYMw==
X-Received: by 2002:a05:6000:1b09:b0:31f:a256:4bbb with SMTP id f9-20020a0560001b0900b0031fa2564bbbmr19083166wrz.71.1699260182307;
        Mon, 06 Nov 2023 00:43:02 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0032f7f4089b7sm8733539wrp.43.2023.11.06.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:43:01 -0800 (PST)
Date:   Mon, 6 Nov 2023 09:42:56 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     stefanha@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <pqynwprcnwpg5febbvz2z5gdjkayri6tm2azorkdhgnedyzpln@o7bgedbhmjfn>
References: <20231104150531.257952-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231104150531.257952-1-syoshida@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 12:05:31AM +0900, Shigeru Yoshida wrote:
>KMSAN reported the following uninit-value access issue:
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>
>The following simple reproducer can cause the issue described above:
>
>int main(void)
>{
>  int sock;
>  struct sockaddr_vm addr = {
>    .svm_family = AF_VSOCK,
>    .svm_cid = VMADDR_CID_ANY,
>    .svm_port = 1234,
>  };
>
>  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
>  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
>  return 0;
>}
>
>This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
>`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
>in `virtio_transport_init_hdr()`. This patch resolves the issue by
>initializing these fields during allocation.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Reported-and-tested-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
>v1->v2:
>- Rebase on the latest net tree
>https://lore.kernel.org/all/20231026150154.3536433-1-syoshida@redhat.com/
>---
> net/vmw_vsock/virtio_transport_common.c | 2 ++
> 1 file changed, 2 insertions(+)

The patch remained the same, so you could bring back my R-b ;-)
In any case:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e22c81435ef7..dc65dd4d26df 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -130,6 +130,8 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
> 	hdr->dst_port	= cpu_to_le32(dst_port);
> 	hdr->flags	= cpu_to_le32(info->flags);
> 	hdr->len	= cpu_to_le32(payload_len);
>+	hdr->buf_alloc	= cpu_to_le32(0);
>+	hdr->fwd_cnt	= cpu_to_le32(0);
> }
>
> static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>-- 
>2.41.0
>

