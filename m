Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF080A257
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573631AbjLHLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjLHLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D841B10F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702035341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56LbxjAYxWjvG44Vq3GcHH61dclQGaGcbqQRT67zl+k=;
        b=MlculCWyMVXemfKf27DvP/Pc4105SQsOrzLpUcszZG3whP95aa4fB36yKfqbVKpG6Eq6DI
        0oUjEEGF4VQR2xbnq/hN91MYVIbP5DycOodHCRqYFO/5DM7eRl8qUdBx4gdXX4mnTXF/Ps
        5Wt5ahGd8M+WONd9fYxoW+yClWPVWcs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-S3xx4JosPCemsg0XSGUmnA-1; Fri, 08 Dec 2023 06:35:39 -0500
X-MC-Unique: S3xx4JosPCemsg0XSGUmnA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1c989d460eso125873466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035338; x=1702640138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56LbxjAYxWjvG44Vq3GcHH61dclQGaGcbqQRT67zl+k=;
        b=Xi58vyya73hdKNg/+T6qeeORUZIQLOi9sb3LuoDVHOZot0JzXMXKz6I8hE4WQdjqbV
         C+7rFOiVxn6n0a+YZH92UUyHjERCj4SCKGNy36V575tt5daL6N17VOAZTg3SuGD+dwSY
         WaQWeZlaM4LWpj8U+UEQTdLE1FepVdTvwR8D943RD0+Q15J4/IEYE1+HkBQTRytUBjkM
         rK9YuOz/eNenCnFNaLQr+N3bE1bNuJ17eSubnVdJKKJsmsB5oQhSAlZadVvwPUWapAXj
         2axdrmXcwmgIjJAJ5dOCzBcndGg8/GEMyA6KiP9e47z7pDiGse6DEKqMAg/8NUlldzTq
         CpSQ==
X-Gm-Message-State: AOJu0YxTY4Rgro3HCc3H2Q+QXmr6dv7IDiyrHj59d2y/JkhDoSnUtZVy
        UWUYczhaIE/EtbjlscvV+KEelVy56hN8smyHhX0nKbHp3BqooKv5FsUvLnXTyGThD/HtXvKQDhH
        HEO1CycxrDDEpiR9zvn1Iq4Wo
X-Received: by 2002:a17:906:189:b0:a02:a2cc:66b8 with SMTP id 9-20020a170906018900b00a02a2cc66b8mr2833873ejb.14.1702035338424;
        Fri, 08 Dec 2023 03:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIwMj2tOIobb8zgpJMmlUrCA0d6r8aJyQc86j4Rx04MnRIR+/iDl1ClyT7OuhvjQNv/lzFpQ==
X-Received: by 2002:a17:906:189:b0:a02:a2cc:66b8 with SMTP id 9-20020a170906018900b00a02a2cc66b8mr2833871ejb.14.1702035338098;
        Fri, 08 Dec 2023 03:35:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm898831ejd.20.2023.12.08.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:35:37 -0800 (PST)
Date:   Fri, 8 Dec 2023 06:35:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa: Fix an error handling path in eni_vdpa_probe()
Message-ID: <20231208063520-mutt-send-email-mst@kernel.org>
References: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
 <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
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

On Thu, Dec 07, 2023 at 10:13:51PM +0100, Christophe JAILLET wrote:
> Le 20/10/2022 à 21:21, Christophe JAILLET a écrit :
> > After a successful vp_legacy_probe() call, vp_legacy_remove() should be
> > called in the error handling path, as already done in the remove function.
> > 
> > Add the missing call.
> > 
> > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> > index 5a09a09cca70..cce3d1837104 100644
> > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > @@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	if (!eni_vdpa->vring) {
> >   		ret = -ENOMEM;
> >   		ENI_ERR(pdev, "failed to allocate virtqueues\n");
> > -		goto err;
> > +		goto err_remove_vp_legacy;
> >   	}
> >   	for (i = 0; i < eni_vdpa->queues; i++) {
> > @@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> >   	if (ret) {
> >   		ENI_ERR(pdev, "failed to register to vdpa bus\n");
> > -		goto err;
> > +		goto err_remove_vp_legacy;
> >   	}
> >   	return 0;
> > +err_remove_vp_legacy:
> > +	vp_legacy_remove(&eni_vdpa->ldev);
> >   err:
> >   	put_device(&eni_vdpa->vdpa.dev);
> >   	return ret;
> 
> Polite reminder on a (very) old patch.
> 
> CJ


Tagged now, thanks!

