Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FB8115DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442248AbjLMPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442095AbjLMPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B7B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702480407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
        b=PeC1Cg86T813cTyTKLQh38RDl9q1rmAVFG9Tv9pA1wAG2X78hQh+uBkfbkGig06Ma9fgi7
        orJN6Z9sBo/pGVT6tuXdqxz12eW2j0iA+C3Z4IXVmxRCwBoDCo+5vp8RFN8rBASiln3k6T
        5s8uLnw+DV3Y86Dy1KqfVkXbnIa1020=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-lmafaidlNKSErLhEQQ0lPQ-1; Wed, 13 Dec 2023 10:13:25 -0500
X-MC-Unique: lmafaidlNKSErLhEQQ0lPQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d38492da7so427255966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480404; x=1703085204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2OWzLPbe7fefjvMfxhIYzTmKhON3iT9TY5UrL/jTLs=;
        b=j7pKAnyonKJA2aFfSYO/Sz6ybU7qijbHt2hJ1f+O/lYIBjaK2CLUbDDZpDSbvLK00L
         ARRnvhDgwrCySy+6s1DTUdQ0KA73CDAduuNsctO2XW1aGZuUUavKaI0c0gJ0AYfllOmL
         d3Q2q6yHF41Kh8whWlDV6lzChjSYLCUSQGmeGgBfATAF+p7Oj3JqCPXml6ZJ24OISiRw
         8qFfzIcvbX0yS6d1VOevjMBqx3u5+1IwnaspWL6XqL+s5QUKRdWzPyBvqfLKFcfJ7h1B
         DxoEQpi4QzozIhVWm8VYrltOY9m03sjVc1xg3+Xc/kSZfpzDiAyKVcHehgNpUVJmT29S
         sa0w==
X-Gm-Message-State: AOJu0YxiUEbmcV/RQIOMa2vAdPomri54+LdE4IaEGdVoHPWGU5Ql2F6g
        qCOH0MY1LYeZEi/8WIMSmpq5KELZ6D8l68EggZ6WrG+vT2lPfM2oDVQ0cLAZ9frrOctyUcbs5QL
        ayUWEQHJcb25rOjj+15FZV9hq
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353776ejd.5.1702480404100;
        Wed, 13 Dec 2023 07:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVEHNhpEpNkKjGAhK/XWOUUTGGv28PciIr/kdbCXWcbETJTEaPRgwgaTCSAZtVYbJ3/DARkA==
X-Received: by 2002:a17:906:209:b0:a1c:966c:2962 with SMTP id 9-20020a170906020900b00a1c966c2962mr2353768ejd.5.1702480403779;
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a1e27e584c7sm7934486ejn.69.2023.12.13.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:13:23 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:13:15 -0500
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
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <20231213100957-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213100518-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> > 
> > 
> > On 13.12.2023 11:43, Stefano Garzarella wrote:
> > > On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> > >>
> > >>
> > >> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> > >>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> > >>>>
> > >>>>
> > >>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > >>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>>                                DESCRIPTION
> > >>>>>>
> > >>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> > >>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> > >>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> > >>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> > >>>>>
> > >>>>>
> > >>>>> Patchset:
> > >>>>>
> > >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > >>>>
> > >>>> Thanks!
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> But I worry whether we actually need 3/8 in net not in net-next.
> > >>>>
> > >>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> > >>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> > >>>> have strong opinion. I guess @Stefano knows better.
> > >>>>
> > >>>> Thanks, Arseniy
> > >>>
> > >>> Fixes means "if you have that other commit then you need this commit
> > >>> too". I think as a minimum you need to rearrange patches to make the
> > >>> fix go in first. We don't want a regression followed by a fix.
> > >>
> > >> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> > >> patch fixes problem that is not related with the new patches from this patchset.
> > > 
> > > I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> > > I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> > > for every bytes we read, so we should not have this problem, right?
> > 
> > Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> > 
> > Thanks, Arseniy
> 
> 
> hmm why not net-next?

Oh I missed your previous discussion. I think everything in net-next is
safer.  Having said that, I won't nack it net, either.

> > > 
> > > So, maybe all the series could be "net".
> > > 
> > > Thanks,
> > > Stefano
> > > 

