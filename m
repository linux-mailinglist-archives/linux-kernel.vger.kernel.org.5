Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972EA77B406
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjHNIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjHNIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:22:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF72108
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:21:49 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-447684c4283so1456667137.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692001302; x=1692606102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbBAnYMt1osAjSLgXwXsESE/Ht4xXirnV0hpDFYwchU=;
        b=e4LMTIUNziY8qEE/vVzl4NROTCVHR7aXx9zPn6XfabWgcXmD3ItQX7KheWh5RqNX/C
         B1785uX0YjD3RLGQQpgcUznX21kaVF8L81c0H0l2+v9sTtvd2YL1GvL8ObB8z97zdh5r
         ND87Zd2Q8MsbZL4GJNG+eZxgsP3C9idBC5obk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001302; x=1692606102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbBAnYMt1osAjSLgXwXsESE/Ht4xXirnV0hpDFYwchU=;
        b=cjsaaVrfUbsfUoCVvkLNi6+eqMOOdfGkoEQy2TRFq5qFP8k0azhuKpWrQfRnjlkjeN
         OJ6yLZ0LxhQDaLLyxoJ/ouyVA1quN4DLmflb5vrQqz+Me5W7OujabjYJMwtE0qDFN0hK
         mCEEYNvsuQ/zeKIIGDRS1kzxrXMwZhg3QD4Iz9gpAcTwR1I5pksY30Ft7gyK/MAamLwa
         LbJuILUumeNSiHTi2ZtoaX7CQ81Z66HHQsWegEAotzSJFlRuwUcnXSDnidDvsEUkygg9
         3KGcj5Bv017uGOd2txuiG/U/b6GkfnI6jmBnAcHGI2iAs+ciEJb8wWb8bmQVVpJnGY5O
         AhIA==
X-Gm-Message-State: AOJu0YwP9Uw+UM6Ck5zKUqHbxYWcroKGUD1DP3W+U5phvPl3CGwig9en
        6GRKoVo0GepkWtuwstK37Gw05c98NkVA+93abz9EAQ==
X-Google-Smtp-Source: AGHT+IEkqfirYS9rl9kYl1DneeftF4z9DIfsIMYPKU+dbFWSnA065ws9D799j3wglgRmTIWdm1P/MIbQT4YO4g8SbYU=
X-Received: by 2002:a67:fd03:0:b0:447:4c30:cb68 with SMTP id
 f3-20020a67fd03000000b004474c30cb68mr8236981vsr.32.1692001302415; Mon, 14 Aug
 2023 01:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230602090227.7264-1-yong.wu@mediatek.com> <20230602090227.7264-6-yong.wu@mediatek.com>
 <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com>
 <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
 <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com> <810a3cbca7e837925b5750fd2eb1d1a261e865dc.camel@mediatek.com>
In-Reply-To: <810a3cbca7e837925b5750fd2eb1d1a261e865dc.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 14 Aug 2023 16:21:31 +0800
Message-ID: <CAGXv+5G=CM9203GR42szWXx8K7F+swkvKJ_M3ev5_bGTk_zjGg@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:14=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=87) <Yong.=
Wu@mediatek.com> wrote:
>
> On Fri, 2023-08-11 at 11:30 +0800, Chen-Yu Tsai wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Aug 10, 2023 at 8:23=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=87) <=
Yong.Wu@mediatek.com>
> > wrote:
> > >
> > > On Tue, 2023-08-08 at 17:53 +0800, Chen-Yu Tsai wrote:
> > > >
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  On Fri, Jun 2, 2023 at 5:04=E2=80=AFPM Yong Wu <yong.wu@mediatek.c=
om>
> > wrote:
> > > > >
> > > > > From: "Chengci.Xu" <chengci.xu@mediatek.com>
> > > > >
> > > > > MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the
> > > > other
> > > > > is for vpp. and 1 INFRA IOMMU.
> > > > >
> > > > > Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > > ---
> > > > >  drivers/iommu/mtk_iommu.c | 49
> > > > +++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 49 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iommu/mtk_iommu.c
> > b/drivers/iommu/mtk_iommu.c
> > > > > index 9c89cf894a4d..5c66af0c45a8 100644
> > > > > --- a/drivers/iommu/mtk_iommu.c
> > > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > > @@ -170,6 +170,7 @@ enum mtk_iommu_plat {
> > > > >         M4U_MT8173,
> > > > >         M4U_MT8183,
> > > > >         M4U_MT8186,
> > > > > +       M4U_MT8188,
> > > > >         M4U_MT8192,
> > > > >         M4U_MT8195,
> > > > >         M4U_MT8365,
> > > > > @@ -1593,6 +1594,51 @@ static const struct mtk_iommu_plat_data
> > > > mt8186_data_mm =3D {
> > > > >         .iova_region_larb_msk =3D mt8186_larb_region_msk,
> > > > >  };
> > > > >
> > > > > +static const struct mtk_iommu_plat_data mt8188_data_infra =3D {
> > > > > +       .m4u_plat         =3D M4U_MT8188,
> > > > > +       .flags            =3D WR_THROT_EN | DCM_DISABLE |
> > > > STD_AXI_MODE | PM_CLK_AO |
> > > > > +                           MTK_IOMMU_TYPE_INFRA |
> > > > IFA_IOMMU_PCIE_SUPPORT |
> > > > > +                           PGTABLE_PA_35_EN |
> > > > CFG_IFA_MASTER_IN_ATF,
> > > >
> > > > FWIW, CFG_IFA_MASTER_IN_ATF should not be tied to the compatible
> > > > string,
> > > > but set via a DT property. The IOMMU controls are secured by
> > > > firmware.
> > > > It is not a property intrinsically tied to the hardware.
> > >
> > > The flag CFG_IFA_MASTER_IN_ATF means the registers which
> > enable/disable
> > > iommu are in the secure world. If the master like pcie want to
> > enable
> > > iommu, we have to enter secure world to configure it. It should be
> > HW
> > > intrinsical, right?
> >
> > If I understand correctly, this is forced by setting some registers.
> > The registers are set by the firmware at boot time.
>
> The register will be set before the masters that have the "iommus=3D"
> property probe. If the master doesn't have "iommus=3D" property in its
> dtsi node, this register won't be set, then its iommu will be disabled
> and it has to access continuous buffer.
>
> >
> > So if a different firmware that doesn't set the registers is used,
> > then the IOMMU is available to non-secure kernel, correct?
>
> No. The meaning of this register is whether to enable iommu. If the
> register are not set, the IOMMU for that master is disabled.

For clarity, I'm referring to PERI_MST_PROT [1], not the registers in the
IOMMU or LARBs. So not any of the registers used in this patch.

If that register doesn't restrict access to IOMMU register space to secure
only, then I assume it is controlled by fuses?

[1] https://review.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmwar=
e-a/+/be457248c6b0a7f3c61bd95af58372938d13decd/plat/mediatek/drivers/iommu/=
mt8188/mtk_iommu_plat.c#93

> >
> > That's why I said that it should not be tied to a particular hardware
> > platform, but set using a boolean device tree property.
> >
> > > >
> > > > If on some other project there is no such security requirement
> > and
> > > > the
> > > > IOMMU is opened up to non-secure world, and ATF not even having
> > > > support
> > > > for the SMC call, this becomes unusable and hard to rectify
> > without
> > > > introducing a new compatible string.
> > > >
> > > > ChenYu
> > > >
