Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56807D911D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjJ0ITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjJ0IT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9C1B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698394716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfITEsiltCW1D4ziBTO0kE6Y9MiSeu2U9dsQlUHf3Iw=;
        b=bHwZZeYwiQEsRRfU/d4epJ2XH0PNd2JCFMsIOJamEKycoDEVrKBHYbz/TrjPAI+vU6y1cR
        UBhJpqaJFKOSgWN4bDw7FxNhSronpR2SrEho/9cJzok7uEaud4balYSYh5mI/z6xfU86Ha
        GecFEiEQCXN+zS5oSF0/APdWI4kPLXc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-aw_bgI32O5C7_PO2tw0mGQ-1; Fri, 27 Oct 2023 04:18:34 -0400
X-MC-Unique: aw_bgI32O5C7_PO2tw0mGQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084e263ec4so13650255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698394713; x=1698999513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfITEsiltCW1D4ziBTO0kE6Y9MiSeu2U9dsQlUHf3Iw=;
        b=eNRTmL9F9Q9WmFuDlbCvQVC6vzMaKBD12dNjXRIUr7ipPsiqD7pWEaKpfXKRp1kKTC
         dgQcV13+Izp8ZWGwV5sDxCIF2OvIwn0T4AdBHxRik8PxxbbPKB5wsT2IItyPnfq95gmq
         ij3OemXvXOaE/WoSjQHuxa+5hWbcACJKmw4Gb+ROK4lyz76gGpwLIxzJupwautjFkEwq
         CRdZo5vHPOupm0HuMbWRVhwRzFWc5k/k9C120nQl/gbV+fPw2rWNx+M2GeEpLQcQyF2l
         IUtVJQcgqwhzKor7OXGodldRCiARNidz2ImriXqMyd9QxwcYgSG0gENjFOlGU2SVmJ30
         nnPA==
X-Gm-Message-State: AOJu0YyTqN1iVyzBtjUZVvGkwgNtcszrs9ELqhyGl7GzErgI/A/LSLfl
        uQzsI8KcPPMAyanKEH1IBW1fs6n71ZhSSsslcK95ZzaQubeAiMLFriRy8/GsIKZ4IepYUoOJlFQ
        VH1qGqz/Bws52pzaXIQo/t0wO
X-Received: by 2002:a05:600c:259:b0:407:5a7d:45a8 with SMTP id 25-20020a05600c025900b004075a7d45a8mr1874918wmj.31.1698394713569;
        Fri, 27 Oct 2023 01:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd30H/q/ARe1qEofpRvdVhPCQXiC4/86WnpM7ULemfc8NYPGWUdTDK3eFZJVoncrARpqPh2Q==
X-Received: by 2002:a05:600c:259:b0:407:5a7d:45a8 with SMTP id 25-20020a05600c025900b004075a7d45a8mr1874889wmj.31.1698394713124;
        Fri, 27 Oct 2023 01:18:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id d17-20020adff851000000b0031ad5fb5a0fsm1211238wrq.58.2023.10.27.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:18:32 -0700 (PDT)
Date:   Fri, 27 Oct 2023 10:18:26 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     stefanha@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bobby.eshleman@bytedance.com,
        bobbyeshleman@gmail.com
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <CAGxU2F6VAzdi4-Qs6DmabpPx+JKVHtCP1FJ2sSZ9730Kq-KLuQ@mail.gmail.com>
References: <20231026150154.3536433-1-syoshida@redhat.com>
 <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:01 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Oct 27, 2023 at 12:01:54AM +0900, Shigeru Yoshida wrote:
> >KMSAN reported the following uninit-value access issue:
> >
> >=====================================================
> >BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> > virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > process_one_work kernel/workqueue.c:2630 [inline]
> > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > kthread+0x3cc/0x520 kernel/kthread.c:388
> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> >
> >Uninit was stored to memory at:
> > virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> > virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
> > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > process_one_work kernel/workqueue.c:2630 [inline]
> > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > kthread+0x3cc/0x520 kernel/kthread.c:388
> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> >
> >Uninit was created at:
> > slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> > slab_alloc_node mm/slub.c:3478 [inline]
> > kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> > kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> > __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> > alloc_skb include/linux/skbuff.h:1286 [inline]
> > virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> > virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
> > virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> > virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
> > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > process_one_work kernel/workqueue.c:2630 [inline]
> > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > kthread+0x3cc/0x520 kernel/kthread.c:388
> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> >
> >CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
> >Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> >Workqueue: vsock-loopback vsock_loopback_work
> >=====================================================
> >
> >The following simple reproducer can cause the issue described above:
> >
> >int main(void)
> >{
> >  int sock;
> >  struct sockaddr_vm addr = {
> >    .svm_family = AF_VSOCK,
> >    .svm_cid = VMADDR_CID_ANY,
> >    .svm_port = 1234,
> >  };
> >
> >  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
> >  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
> >  return 0;
> >}
> >
> >This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
> >`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
> >in `virtio_transport_alloc_skb()`. This patch resolves the issue by
> >initializing these fields during allocation.
> >
> >Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>
> CCin Bobby, the original author, for any additional comments/checks.
>
> Yeah, I see, before that commit we used kzalloc() to allocate the
> header so we forgot to reset these 2 fields, and checking they are
> the only 2 missing.
>
> I was thinking of putting a memset(hdr, 0, sizeof(*hdr)) in
> virtio_vsock_alloc_skb() but I think it's just extra unnecessary work,
> since here we set all the fields (thanks to this fix), in vhost/vsock.c
> we copy all the header we receive from the guest and in
> virtio_transport.c we already set it all to 0 because we are
> preallocating the receive buffers.
>
> So I'm fine with this fix!
>
> >Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 352d042b130b..102673bef189 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -68,6 +68,8 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> >       hdr->dst_port   = cpu_to_le32(dst_port);
> >       hdr->flags      = cpu_to_le32(info->flags);
> >       hdr->len        = cpu_to_le32(len);
> >+      hdr->buf_alloc  = cpu_to_le32(0);
> >+      hdr->fwd_cnt    = cpu_to_le32(0);
> >
> >       if (info->msg && len > 0) {
> >               payload = skb_put(skb, len);
> >--
> >2.41.0
> >
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

syzbot just reported the same [1], should we add the following tag?

Reported-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com

[1] https://lore.kernel.org/netdev/00000000000008b2940608ae3ce9@google.com/

Thanks,
Stefano

