Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9388F7FF873
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjK3RiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjK3Rh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF521730
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701365881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbZ5P+nGgfAbJb3fpnTGprfWggeghoTX11Iv3xmxV90=;
        b=eX1KMwsGILi9rz8v0tG59nsque67nP2sK+0+omId4sZCIYC+A7TzI7u+8dlSyL725B8X70
        yAF6UgCrtHYeAah+Xyb+PMfnv86up/d98jYjjUCfKbVPAALNOFIKLJDGYkNr3ZZmUDvLDX
        vnbKuk0CcU8IK9lZc3wrzAU8VseyV2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-maJkLx5JPgi5vwuuj_A7sA-1; Thu, 30 Nov 2023 12:38:00 -0500
X-MC-Unique: maJkLx5JPgi5vwuuj_A7sA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b40234b64so9530345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365879; x=1701970679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbZ5P+nGgfAbJb3fpnTGprfWggeghoTX11Iv3xmxV90=;
        b=JAOfjCvgTtdf9bloQg0V560MmNZQc5CSLZk4OzOZqy0Xh4aG6yC+H2z9e3uXWktA42
         UtD/DinqsAAhqRzFEH8fyDb9whc4Ju/r993EFGRqleZL0R0Ok6dr5DEHpifJ+1r1+oVl
         b9zqEB8nCEG2r+pUqsuuXauogHVWuzgwMB+tIOUI7qLAfufaqng0kTGdtMFs2/q/99D2
         H0KpuxSYEYN8uyW/+CrtkKLIgXPojLIbHk//jqaRFe5VZoOxM35nf8bCi3X+k7h+Lw6f
         UYtL9wvw0qz6j4Ej+Ugs0ZzMlPUh0CBOfqJsf72EW9gbHsnKa5ljvOlPZ0CwdU7n8VNd
         pgZQ==
X-Gm-Message-State: AOJu0YztyUj0dGVt+fXFcEH1ff1C8SEGYCxn2GvfW6h2DN8e74t7dnl2
        dqcaJvip2syaWBFcTeVwXMPASVCsVj5gWVm4ihjDYL9V5GoLmoFeKRc2XYPTmVcXEREvoJ/f8oF
        B1EEs2hgw1E6xbAyK+mJcIlE9
X-Received: by 2002:a05:600c:46d1:b0:40b:4be4:738c with SMTP id q17-20020a05600c46d100b0040b4be4738cmr946wmo.37.1701365878569;
        Thu, 30 Nov 2023 09:37:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZQwuNJ0/UhUbwbnkOIMnJanuql2BfMQsxOxJaRRWODRHGQtzOtahnevlp3tHT1VPV7tWsWA==
X-Received: by 2002:a05:600c:46d1:b0:40b:4be4:738c with SMTP id q17-20020a05600c46d100b0040b4be4738cmr833wmo.37.1701365878002;
        Thu, 30 Nov 2023 09:37:58 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id x1-20020adfdd81000000b0033318b927besm2096494wrl.42.2023.11.30.09.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:37:57 -0800 (PST)
Date:   Thu, 30 Nov 2023 12:37:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <20231130123653-mutt-send-email-mst@kernel.org>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-3-avkrasnov@salutedevices.com>
 <20231130084044-mutt-send-email-mst@kernel.org>
 <02de8982-ec4a-b3b2-e8e5-1bca28cfc01b@salutedevices.com>
 <20231130085445-mutt-send-email-mst@kernel.org>
 <pbkiwezwlf6dmogx7exur6tjrtcfzxyn7eqlehqxivqifbkojv@xlziiuzekon4>
 <b3fa2aaa-9fdc-30a2-4c87-53eb106900ee@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3fa2aaa-9fdc-30a2-4c87-53eb106900ee@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:41:56PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 30.11.2023 17:11, Stefano Garzarella wrote:
> > On Thu, Nov 30, 2023 at 08:58:58AM -0500, Michael S. Tsirkin wrote:
> >> On Thu, Nov 30, 2023 at 04:43:34PM +0300, Arseniy Krasnov wrote:
> >>>
> >>>
> >>> On 30.11.2023 16:42, Michael S. Tsirkin wrote:
> >>> > On Thu, Nov 30, 2023 at 04:08:39PM +0300, Arseniy Krasnov wrote:
> >>> >> Send credit update message when SO_RCVLOWAT is updated and it is bigger
> >>> >> than number of bytes in rx queue. It is needed, because 'poll()' will
> >>> >> wait until number of bytes in rx queue will be not smaller than
> >>> >> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
> >>> >> for tx/rx is possible: sender waits for free space and receiver is
> >>> >> waiting data in 'poll()'.
> >>> >>
> >>> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >>> >> ---
> >>> >>  Changelog:
> >>> >>  v1 -> v2:
> >>> >>   * Update commit message by removing 'This patch adds XXX' manner.
> >>> >>   * Do not initialize 'send_update' variable - set it directly during
> >>> >>     first usage.
> >>> >>  v3 -> v4:
> >>> >>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> >>> >>  v4 -> v5:
> >>> >>   * Do not change callbacks order in transport structures.
> >>> >>
> >>> >>  drivers/vhost/vsock.c                   |  1 +
> >>> >>  include/linux/virtio_vsock.h            |  1 +
> >>> >>  net/vmw_vsock/virtio_transport.c        |  1 +
> >>> >>  net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
> >>> >>  net/vmw_vsock/vsock_loopback.c          |  1 +
> >>> >>  5 files changed, 31 insertions(+)
> >>> >>
> >>> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >>> >> index f75731396b7e..4146f80db8ac 100644
> >>> >> --- a/drivers/vhost/vsock.c
> >>> >> +++ b/drivers/vhost/vsock.c
> >>> >> @@ -451,6 +451,7 @@ static struct virtio_transport vhost_transport = {
> >>> >>          .notify_buffer_size       = virtio_transport_notify_buffer_size,
> >>> >>
> >>> >>          .read_skb = virtio_transport_read_skb,
> >>> >> +        .notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> >>> >>      },
> >>> >>
> >>> >>      .send_pkt = vhost_transport_send_pkt,
> >>> >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >>> >> index ebb3ce63d64d..c82089dee0c8 100644
> >>> >> --- a/include/linux/virtio_vsock.h
> >>> >> +++ b/include/linux/virtio_vsock.h
> >>> >> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> >>> >>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> >>> >>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> >>> >>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> >>> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> >>> >>  #endif /* _LINUX_VIRTIO_VSOCK_H */
> >>> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >>> >> index af5bab1acee1..8007593a3a93 100644
> >>> >> --- a/net/vmw_vsock/virtio_transport.c
> >>> >> +++ b/net/vmw_vsock/virtio_transport.c
> >>> >> @@ -539,6 +539,7 @@ static struct virtio_transport virtio_transport = {
> >>> >>          .notify_buffer_size       = virtio_transport_notify_buffer_size,
> >>> >>
> >>> >>          .read_skb = virtio_transport_read_skb,
> >>> >> +        .notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> >>> >>      },
> >>> >>
> >>> >>      .send_pkt = virtio_transport_send_pkt,
> >>> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >>> >> index f6dc896bf44c..1cb556ad4597 100644
> >>> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >>> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >>> >> @@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> >>> >>  }
> >>> >>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
> >>> >>
> >>> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, >> int val)
> >>> >> +{
> >>> >> +    struct virtio_vsock_sock *vvs = vsk->trans;
> >>> >> +    bool send_update;
> >>> >> +
> >>> >> +    spin_lock_bh(&vvs->rx_lock);
> >>> >> +
> >>> >> +    /* If number of available bytes is less than new SO_RCVLOWAT value,
> >>> >> +     * kick sender to send more data, because sender may sleep in >> its
> >>> >> +     * 'send()' syscall waiting for enough space at our side.
> >>> >> +     */
> >>> >> +    send_update = vvs->rx_bytes < val;
> >>> >> +
> >>> >> +    spin_unlock_bh(&vvs->rx_lock);
> >>> >> +
> >>> >> +    if (send_update) {
> >>> >> +        int err;
> >>> >> +
> >>> >> +        err = virtio_transport_send_credit_update(vsk);
> >>> >> +        if (err < 0)
> >>> >> +            return err;
> >>> >> +    }
> >>> >> +
> >>> >> +    return 0;
> >>> >> +}
> >>> >
> >>> >
> >>> > I find it strange that this will send a credit update
> >>> > even if nothing changed since this was called previously.
> >>> > I'm not sure whether this is a problem protocol-wise,
> >>> > but it certainly was not envisioned when the protocol was
> >>> > built. WDYT?
> >>>
> >>> >From virtio spec I found:
> >>>
> >>> It is also valid to send a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet without previously receiving a
> >>> VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows communicating updates any time a change
> >>> in buffer space occurs.
> >>> So I guess there is no limitations to send such type of packet, e.g. it is not
> >>> required to be a reply for some another packet. Please, correct me if im wrong.
> >>>
> >>> Thanks, Arseniy
> >>
> >>
> >> Absolutely. My point was different - with this patch it is possible
> >> that you are not adding any credits at all since the previous
> >> VIRTIO_VSOCK_OP_CREDIT_UPDATE.
> > 
> > I think the problem we're solving here is that since as an optimization we avoid sending the update for every byte we consume, but we put a threshold, then we make sure we update the peer.
> > 
> > A credit update contains a snapshot and sending it the same as the previous one should not create any problem.
> > 
> > My doubt now is that we only do this when we set RCVLOWAT , should we also do something when we consume bytes to avoid the optimization we have?
> 
> @Michael, Stefano just reproduced problem during bytes reading, but there is already old fix for this, which we forget to merge:)
> I think it must be included to this patchset.
> 
> https://lore.kernel.org/netdev/f304eabe-d2ef-11b1-f115-6967632f0339@sberdevices.ru/
> 
> Thanks, Arseniy


I generally don't merge patches tagged as RFC.
Repost without that tag?
Also, it looks like a bugfix we need either way, no?

> > 
> > Stefano
> > 

