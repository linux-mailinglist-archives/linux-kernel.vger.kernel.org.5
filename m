Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE57A5475
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjIRUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIRUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826D130
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695070277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nT84wNH1C0jGv/eCN9m7OxqXSype8Vk+lhVL/RUEMPU=;
        b=hVmgHntZ26mvJzfWCNe05R+k8EMArH0aveOLv+xt/B8L8LSJ8iM18TK/K/BUH2KefoTdmt
        xAKJ+b4AJlqn4BkSR0ft2Q3GEpSRCZePVLLp92UDwcPEQAoifcSkI8nAWBA/9VvlgH6USV
        6Bk7wGD42p6A1BLU8m77pHOFwxQQ46o=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-McnsvPcAOiC01gPzgq8F3Q-1; Mon, 18 Sep 2023 16:51:13 -0400
X-MC-Unique: McnsvPcAOiC01gPzgq8F3Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34f2cb006c9so40888795ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070272; x=1695675072;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nT84wNH1C0jGv/eCN9m7OxqXSype8Vk+lhVL/RUEMPU=;
        b=qONoT8twO2kUKcrBzc8E+L3OrkojyCrV/pob3Q1qUrHXovEZZz86RR4Evp1QHsVMpU
         jVJn20FonSLZTB88n9Jcx/VrXMicKlbm5FXjCCNiWAze7jLIWlbIACZ0uD1VAblRVbQt
         j76SawsuvKg0K+ubfRh/HCWs85zDBnhiZFulEQq4sm1O56VANmJT6o6tnVLrWEuLbySZ
         xAPztiXd2gmMBl1mt5pFjNG5o/6tAbrXsDJNinjBxyuUqX/MFZiLEAA5ta0eKFhd2rTg
         f5T3Od6ijuwCEOPz3nizTx8UHzzju6YQOg4q/WuRtRJIrC4BV0mcj3Dk9lEIPbskyr07
         Uv/A==
X-Gm-Message-State: AOJu0Yx705z2pMd32wVpp9WLz9KWh7AOQsY6+m7QwHiwJjCg0UAWz5YV
        AK2xCjHKYJPek6VsrRfHB9RGYM9KryRBd4seSgOEvpOKI7o4SGBUjZ5Fz0aFgvG6e1yr0z5yqYd
        x1Ua/8JN2G6PG4AWFY9hh6/CK
X-Received: by 2002:a05:6e02:1244:b0:34c:b992:58b1 with SMTP id j4-20020a056e02124400b0034cb99258b1mr11804152ilq.2.1695070272573;
        Mon, 18 Sep 2023 13:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM9F8BsBGdHa/2ijEI1FYBJ2o5B6O2oYDjh+f9Bi4r/BYEo7dTEBtR8axeWPhngsR/w7nEvg==
X-Received: by 2002:a05:6e02:1244:b0:34c:b992:58b1 with SMTP id j4-20020a056e02124400b0034cb99258b1mr11804135ilq.2.1695070272342;
        Mon, 18 Sep 2023 13:51:12 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id x59-20020a0294c1000000b0042bae96eba7sm333838jah.7.2023.09.18.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:51:11 -0700 (PDT)
Date:   Mon, 18 Sep 2023 14:51:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Brett Creeley <brett.creeley@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pds: Add missing PCI_IOV depends
Message-ID: <20230918145111.6473b148.alex.williamson@redhat.com>
In-Reply-To: <20230906014942.1658769-1-oushixiong@kylinos.cn>
References: <20230906014942.1658769-1-oushixiong@kylinos.cn>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Sep 2023 09:49:42 +0800
oushixiong <oushixiong@kylinos.cn> wrote:

> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> If PCI_ATS isn't set, then pdev->physfn is not defined.
> it causes a compilation issue:
>=20
> ../drivers/vfio/pci/pds/vfio_dev.c:165:30: error: =E2=80=98struct pci_dev=
=E2=80=99 has no member named =E2=80=98physfn=E2=80=99; did you mean =E2=80=
=98is_physfn=E2=80=99?
>   165 |   __func__, pci_dev_id(pdev->physfn), pci_id, vf_id,
>       |                              ^~~~~~
>=20
> So adding PCI_IOV depends to select PCI_ATS.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/vfio/pci/pds/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to vfio for-linus branch for v6.6.  Thanks,

Alex

>=20
> diff --git a/drivers/vfio/pci/pds/Kconfig b/drivers/vfio/pci/pds/Kconfig
> index 407b3fd32733..6eceef7b028a 100644
> --- a/drivers/vfio/pci/pds/Kconfig
> +++ b/drivers/vfio/pci/pds/Kconfig
> @@ -3,7 +3,7 @@
> =20
>  config PDS_VFIO_PCI
>  	tristate "VFIO support for PDS PCI devices"
> -	depends on PDS_CORE
> +	depends on PDS_CORE && PCI_IOV
>  	select VFIO_PCI_CORE
>  	help
>  	  This provides generic PCI support for PDS devices using the VFIO

