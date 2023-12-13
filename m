Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1898115C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442166AbjLMPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442216AbjLMPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B49D4D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702479949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IALMnPT1Pn+mCAgvupcIeg/euyf0UU0goFir4mrBYA0=;
        b=Feq1RoEs9TvRAaMGteajN8wQAkiviMNc99iTpVVZrq7rs+Lgjbs8iHPWBVU1Si0mgHX9g7
        UFilTLe9lF2sp9przzNXXCE5GAWC03hFbqRqNG/GU1ZftS5wKT3tJ5QOo8x6EGXS1e7PwU
        C4ZPFCyWqFKRKxuhd8tYACuA/CsJxAg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-hbr6SFhwPrSerYBCugCAxQ-1; Wed, 13 Dec 2023 10:05:45 -0500
X-MC-Unique: hbr6SFhwPrSerYBCugCAxQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a018014e8e5so392445366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479944; x=1703084744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IALMnPT1Pn+mCAgvupcIeg/euyf0UU0goFir4mrBYA0=;
        b=ZfX9CQNG8cCySttPLK4oHQwtfpgvW32QFmlxT2vGX5GQekgUiaqZ07o3wNLHa8wCZF
         JULHgWqo2oFXaxHULw21LA+UpQ1EdfguQPk6eaGwsDG4HJm28z+YIpixhvvaZCctzcN6
         /2L0gJLs6MIyZfqfOLApjTaqAEJ/VOhShfEzRb/qxsH0SfVY5Z1QBcj373XQ+rOy6DNb
         PSIGTG1jDHwHRv/Zrc5x/Y7tRWOB+5g9IJN96AuZkpltzkxsMCPTZOdhZXUGOhSbpLyx
         nnKfCCtp5uNqEMtwhD179L5WnC0NidaxPCfFJE1R3ezjcEOXr3bXEidVRqpcFaqPAPS9
         H2Bg==
X-Gm-Message-State: AOJu0Yyl4QPpL1CjRuKCntbHErsP5ziIOWVuEOP7ROpfS34gIUdV7w6B
        6CL23wP2JVx8WShGHOcbnofs0bZm/xAstEhfy6OBME3Smr6mhvtBOkX/cD38xYLG//G7E9PTbu2
        kj1v/LXVa0Yvl/5m3sxajgrZ/
X-Received: by 2002:a17:907:bcf:b0:a19:a19b:789f with SMTP id ez15-20020a1709070bcf00b00a19a19b789fmr3597389ejc.98.1702479944247;
        Wed, 13 Dec 2023 07:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZkaTVx2I2WnVbfMFnlq6Ewpkn6ejNgpIAppfp1qF9bmTmBolwTuhqkmoUq1qGvz3Weq6q9g==
X-Received: by 2002:a17:907:bcf:b0:a19:a19b:789f with SMTP id ez15-20020a1709070bcf00b00a19a19b789fmr3597373ejc.98.1702479943907;
        Wed, 13 Dec 2023 07:05:43 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a1caa9dd507sm7941199ejd.52.2023.12.13.07.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:05:42 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:05:37 -0500
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
Message-ID: <20231213100518-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 13.12.2023 11:43, Stefano Garzarella wrote:
> > On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
> >>
> >>
> >> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
> >>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> >>>>
> >>>>
> >>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> >>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>>                                DESCRIPTION
> >>>>>>
> >>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
> >>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
> >>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
> >>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> >>>>>
> >>>>>
> >>>>> Patchset:
> >>>>>
> >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>
> >>>> Thanks!
> >>>>
> >>>>>
> >>>>>
> >>>>> But I worry whether we actually need 3/8 in net not in net-next.
> >>>>
> >>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> >>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
> >>>> have strong opinion. I guess @Stefano knows better.
> >>>>
> >>>> Thanks, Arseniy
> >>>
> >>> Fixes means "if you have that other commit then you need this commit
> >>> too". I think as a minimum you need to rearrange patches to make the
> >>> fix go in first. We don't want a regression followed by a fix.
> >>
> >> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
> >> patch fixes problem that is not related with the new patches from this patchset.
> > 
> > I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
> > I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
> > for every bytes we read, so we should not have this problem, right?
> 
> Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
> 
> Thanks, Arseniy


hmm why not net-next?

> > 
> > So, maybe all the series could be "net".
> > 
> > Thanks,
> > Stefano
> > 

