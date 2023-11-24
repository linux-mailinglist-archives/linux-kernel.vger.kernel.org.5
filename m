Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C37F6C47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjKXGXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43942D5C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700806999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBsn2i0nliFo+phWtl46j5XfLoBPy3pcywVKmodl4XE=;
        b=D4G6ZEfiI7sb7Q1opI0dF4se4oWNvD6soqIsEnaOACGZUZQXUBZ0x8GJigDYTT+2aNiDYp
        opKEwQs9jPCFjBolRMKhwC1sS0I+Suas7pVNznWHIUdJERZarJbZY80SbIvrMNRoECQIRl
        GflyqdllodmjuKQIdf6THPq8LtEhjlk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-0iJpElyQP2i96o4mjZq6CQ-1; Fri, 24 Nov 2023 01:23:17 -0500
X-MC-Unique: 0iJpElyQP2i96o4mjZq6CQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b99999614bso1595639a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700806996; x=1701411796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBsn2i0nliFo+phWtl46j5XfLoBPy3pcywVKmodl4XE=;
        b=O0B3qk1im6xFMrLToPTtV79T81uMUwcnmAaNDpQlEKzsQxLnvKizS1oKndBtq7TAgR
         1fnuOavTOuwy4rwAgoE5XPqlL/MGs/25VwnQVS3wz1/8XTOmJYwuPiWFxiceoCUfkD1W
         tOPkn1+9eR15wyZElfLtyZfWX/a7B8f+6vm7AMOVAQaL3Znr9ZYLCtJfYsIGVtbY+l+u
         GX0RC7CUQD3W4IeaPPTNVUGY4Z48TOYl3jXGNTb2c61QAL5Pv/oxfwZ4/jSjtxkIZ03L
         ACAwgyEQBjCwb7KT4BxQ5l+i/UnQmXKi8gxMkV1FgCjs6WYZdV1rAW0JHePZqqQlZktC
         qISg==
X-Gm-Message-State: AOJu0YwcuENh5LBwoz6BdPch3HKlv1tPlH8KYcwUl/O+DZOu/E6C/C3r
        9wLsDfBvhRDaqbjM7FwKfB4XGawjNneQ2jtWXiEjk2B0lVTTHWY40Fz5ljQQ5FHuqrkMy1Tm18b
        aWPzldXdmva27dIf7AmuzXn2sXUSMfwmV/5vJvIfo
X-Received: by 2002:a05:6a21:2711:b0:187:8eca:8dc6 with SMTP id rm17-20020a056a21271100b001878eca8dc6mr1882344pzb.34.1700806996660;
        Thu, 23 Nov 2023 22:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHurVLY0iGJEBlzGiDzqMf52lCg1ORWNYsJKiEEd38ufrVuquai65EsJ4/P9zUrgJnhnYuiGXQnp1IxQ0PULu8=
X-Received: by 2002:a05:6a21:2711:b0:187:8eca:8dc6 with SMTP id
 rm17-20020a056a21271100b001878eca8dc6mr1882334pzb.34.1700806996387; Thu, 23
 Nov 2023 22:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20231123183835.635210-1-mkp@redhat.com> <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
 <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com> <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
From:   Mike Pattrick <mkp@redhat.com>
Date:   Fri, 24 Nov 2023 01:23:04 -0500
Message-ID: <CAHcdBH4aMJwkR7fVP=Brwb-4=gon-pwh0CbjbFxsoEiGj4XjVA@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 7:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mike Pattrick wrote:
> > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Mike Pattrick wrote:
> > > > Af_packet provides checksum offload offsets to usermode application=
s
> > > > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on th=
e
> > > > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > > > af_packet will include the link level header and so csum_start need=
s
> > > > to be adjusted accordingly.
> > >
> > > Is this patch based on observing an incorrect offset in a workload,
> > > or on code inspection?
> >
> > Based on an incorrect offset in a workload. The setup involved sending
> > vxlan traffic though a veth interface configured with a vlan. The
> > vnet_hdr's csum_start value was off by 4, and this problem went away
> > when the vlan was removed.
> >
> > I'll take another look at this patch.
>
> This is a vlan device on top of a veth device? On which device and at
> which point (ingress or egress) are you receiving the packet over the
> packet socket?

Just for maximum clarity I'll include the extracted commands below,
but roughly there is a vlan device on top of a vxlan device on top of
a vlan device on top of a veth, in a namespace.

ip netns add at_ns0
ip netns exec at_ns0 ip link add dev at_vxlan1 type vxlan remote
172.31.1.100 id 0 dstport 4789
ip netns exec at_ns0 ip addr add dev at_vxlan1 10.2.1.1/24
ip netns exec at_ns0 ip link set dev at_vxlan1 mtu 1450 up
ip link add p0 type veth peer name ovs-p0
ethtool -K p0 sg on
ethtool -K p0 tso on
ip link set p0 netns at_ns0
ip link set dev ovs-p0 up
ip netns exec at_ns0 ip addr add "172.31.2.1/24" dev p0
ip netns exec at_ns0 ip link set dev p0 up
ip netns exec at_ns0 ip link add link at_vxlan1 name at_vxlan1.100
type vlan proto 802.1q id 100
ip netns exec at_ns0 ip link set dev at_vxlan1.100 up
ip netns exec at_ns0 ip addr add dev at_vxlan1.100 "10.1.1.1/24"
ip netns exec at_ns0 ip link add link p0 name p0.42 type vlan proto 802.1q =
id 42
ip netns exec at_ns0 ip link set dev p0.42 up
ip netns exec at_ns0 ip addr add dev p0.42 "172.31.1.1/24"
ip addr add "172.31.1.100/24" dev p0
ip link set dev p0 up
ip netns exec at_ns0 ping 10.1.1.100

An AF_PACKET socket on ovs-p0 receives the incorrect csum_start.
Setting up the same with a geneve tunnel and udpcsum enabled produces
the same result. Removing vlan 100 also yields an incorrect
csum_start. Removing only vlan 42 yields a correct csum_start.

>
> From a quick glance, in all cases that I see the VLAN tag is kept in
> skb->vlan_tci, so is never part of the packet payload.
>
> But checksum offload with VXLAN can be non-trivial on its own. If
> type & SKB_GSO_UDP_TUNNEL_CSUM | SKB_GSO_TUNNEL_REMCSUM, say. Then
> csum_start will point to the checksum in vxlanhdr.
>

