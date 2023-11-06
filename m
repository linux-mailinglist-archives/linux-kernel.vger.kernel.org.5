Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCFC7E1EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjKFKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0556FA1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699267433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tt2ufQi3V0WzCPqFhIfFg69WryxcO+HVUXT9JipxxcY=;
        b=Ux4XiRTB3P4EYpDP6g2Nc1UaZM0lJ85NuTBORbBlrwQnj/O5u9jR/4F1DYbt1XpqBEfDzq
        qDqoO8I4C8Q4M//TD0sx1cgfBvhyv/+zyU0Nv7TryJ3LtyjW1Jy83qkQUPu07CuGvPBnIo
        vmTkalm8sN7OBix394ovD7BLTGC0z2Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-RnD7Cq6dNQabioSgeB9MIw-1; Mon, 06 Nov 2023 05:43:52 -0500
X-MC-Unique: RnD7Cq6dNQabioSgeB9MIw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41bf9a5930aso47787481cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267431; x=1699872231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt2ufQi3V0WzCPqFhIfFg69WryxcO+HVUXT9JipxxcY=;
        b=UmvjvfDHBcKdMG37mro9n1EGTV1YBCXmwSSdmuj7ChrtZRykVALUd1h2epHzsD/NLV
         DBXMu4ZHwv1a+C9cEpbBOE2rERdc9MrRzyRoerF5yc+pqXSf7/eKEt/40kK3DBE6kMw0
         KKIlBzMdpF0p1ZKXI14CeVCLzQozr06YM8eJfLv0mT4A+k8XTUaOCeWHh7L5pAlAQeHV
         86EEpPfQJO8keXOOMolB0PIXNicM3xZLzqR6pVjRPMrfTS7yKGawgCVAsrOu9O87I1AG
         781DdMHHuMwDe5sA7jTHG1eCXFlhnvnr0vfXjdtMISPSkvUzEQiTi1eciw+jr1QWiAI1
         cEkg==
X-Gm-Message-State: AOJu0YwLUxXfH/LgnJOJqNtVOWYMUARS3XKSgMrCmf0EdBu7d41DjOOZ
        wUtOKRnDmdoSBEllBpo1UULc3P5AYS3VuhZ9EE/sc7CroiMIvhhxtujzJTLs0F9hpvPoPiEXtd9
        sSPfo0MmNrocsmUcaq7r2okBD
X-Received: by 2002:a05:622a:170f:b0:41e:1fea:8a49 with SMTP id h15-20020a05622a170f00b0041e1fea8a49mr33316914qtk.65.1699267431514;
        Mon, 06 Nov 2023 02:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpuzj6aF53BZWIRx0q0bbK7VrzzNhPJJTleXguDnfuNabXjh8InW8/+0AEmmiTq79rP6tdsQ==
X-Received: by 2002:a05:622a:170f:b0:41e:1fea:8a49 with SMTP id h15-20020a05622a170f00b0041e1fea8a49mr33316894qtk.65.1699267431238;
        Mon, 06 Nov 2023 02:43:51 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id bw7-20020a05622a098700b004181f542bcbsm3295696qtb.11.2023.11.06.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:43:50 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:43:25 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     f.storniolo95@gmail.com
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net 1/4] vsock/virtio: remove socket from connected/bound
 list on shutdown
Message-ID: <rpawubezrb23ktdzs4odz36lcyc7onyyyadcij3jxvw3sfb7yh@vawgl5x2ueoe>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-2-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-2-f.storniolo95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:55:48PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>If the same remote peer, using the same port, tries to connect
>to a server on a listening port more than once, the server will
>reject the connection, causing a "connection reset by peer"
>error on the remote peer. This is due to the presence of a
>dangling socket from a previous connection in both the connected
>and bound socket lists.
>The inconsistency of the above lists only occurs when the remote
>peer disconnects and the server remains active.
>
>This bug does not occur when the server socket is closed:
>virtio_transport_release() will eventually schedule a call to
>virtio_transport_do_close() and the latter will remove the socket
>from the bound and connected socket lists and clear the sk_buff.
>
>However, virtio_transport_do_close() will only perform the above
>actions if it has been scheduled, and this will not happen
>if the server is processing the shutdown message from a remote peer.
>
>To fix this, introduce a call to vsock_remove_sock()
>when the server is handling a client disconnect.
>This is to remove the socket from the bound and connected socket
>lists without clearing the sk_buff.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Tested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e22c81435ef7..4c595dd1fd64 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1369,11 +1369,17 @@ virtio_transport_recv_connected(struct sock *sk,
> 			vsk->peer_shutdown |= RCV_SHUTDOWN;
> 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
> 			vsk->peer_shutdown |= SEND_SHUTDOWN;
>-		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
>-		    vsock_stream_has_data(vsk) <= 0 &&
>-		    !sock_flag(sk, SOCK_DONE)) {
>-			(void)virtio_transport_reset(vsk, NULL);
>-			virtio_transport_do_close(vsk, true);
>+		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
>+			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
>+				(void)virtio_transport_reset(vsk, NULL);
>+				virtio_transport_do_close(vsk, true);
>+			}
>+			/* Remove this socket anyway because the remote peer sent
>+			 * the shutdown. This way a new connection will succeed
>+			 * if the remote peer uses the same source port,
>+			 * even if the old socket is still unreleased, but now disconnected.
>+			 */
>+			vsock_remove_sock(vsk);
> 		}
> 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
> 			sk->sk_state_change(sk);
>-- 
>2.41.0
>

Thanks for fixing this issue! LGTM.

Just to inform other maintainers as well. Daan reported this issue to me
at DevConf.cz, I shared it with Filippo and Luigi who analyzed and
solved it.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


