Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02496778603
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHKDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKDbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:31:10 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667672D6D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:31:09 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-447d6748aacso675868137.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691724668; x=1692329468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQYON+sk+YoDUmSygKnXKh+XGqs62+U//VTWTOy9M5E=;
        b=jxBh7pOn7yLgPCIG2YXxI0//3oA+/pThxQC4mdd9ML0q5RvXhW8KTgnNKvmYwoXBRG
         DThAUcfHYd08GFowYSo322YQxEUblTQK09SoW5kE0c9+CUpWVa9AZ1L0RQAPLeuspSm4
         v0NRslaSiIC3D82hXEqGm0CucqCepjdLOZSFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724668; x=1692329468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQYON+sk+YoDUmSygKnXKh+XGqs62+U//VTWTOy9M5E=;
        b=PlpVEOYlSfYDvNvU8/E3sYO40Es+EQ98hnXGqouggNl6QVj1c0FJ05kLUduXnJSW9n
         GwO7X0NWszHqp5NwVJD2bM/1uNJc1u4Y4EVfL0TyAXXVvg9nz9kSY2jybNcR23Fjud1O
         Iwx9u4/Gp/gB5ILVhxV7zGPx6oFITX4pZ4rUia/3694vWgGsmkItYjjfTcxF5HoTX15I
         6s1tcBcY5kWWCKkUbQpz2jUSxyyGGURxhMz4nA/RlIbGPPuigQbm9jph+jjz0A/Bmp2F
         ZYgyzjfZT3tuynbWXsW41TjMbyIMW0MipMC1lyO9mJk1D72ZldwAAuhsE8h+BVerH1f/
         XBHg==
X-Gm-Message-State: AOJu0YyF795S0PMWwETJmKcpi9gccqbO82oGD9srdZArGxt3r8NoFQkP
        0wMDomGfu5e+76mZRtCSdLu8mSxWXVw/d3hERSP0Kg==
X-Google-Smtp-Source: AGHT+IH+n/o66olPcYqU6dZDtkzs3QMHqa4XhdD+e9Yvl0xOcc5I/pNGVpcuircQyOiFWYpBl1Blo6Vc37PagqIihP4=
X-Received: by 2002:a05:6102:3bd3:b0:447:ad77:f027 with SMTP id
 a19-20020a0561023bd300b00447ad77f027mr559375vsv.6.1691724668480; Thu, 10 Aug
 2023 20:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230602090227.7264-1-yong.wu@mediatek.com> <20230602090227.7264-6-yong.wu@mediatek.com>
 <CAGXv+5EKwvn-axETPcuxTpxRkUGLroymeDYL+kr4QW8duAymmQ@mail.gmail.com> <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
In-Reply-To: <b695962fa3c3baac08f8be5202e6a5697e7826a0.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 11 Aug 2023 11:30:57 +0800
Message-ID: <CAGXv+5EVqODJJ4Ck+EcB9sn1bTjG5yFrWLi9mHTfVa0sB4wsug@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 8:23=E2=80=AFPM Yong Wu (=E5=90=B4=E5=8B=87) <Yong.=
Wu@mediatek.com> wrote:
>
> On Tue, 2023-08-08 at 17:53 +0800, Chen-Yu Tsai wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Fri, Jun 2, 2023 at 5:04=E2=80=AFPM Yong Wu <yong.wu@mediatek.com> =
wrote:
> > >
> > > From: "Chengci.Xu" <chengci.xu@mediatek.com>
> > >
> > > MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the
> > other
> > > is for vpp. and 1 INFRA IOMMU.
> > >
> > > Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 49
> > +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 9c89cf894a4d..5c66af0c45a8 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -170,6 +170,7 @@ enum mtk_iommu_plat {
> > >         M4U_MT8173,
> > >         M4U_MT8183,
> > >         M4U_MT8186,
> > > +       M4U_MT8188,
> > >         M4U_MT8192,
> > >         M4U_MT8195,
> > >         M4U_MT8365,
> > > @@ -1593,6 +1594,51 @@ static const struct mtk_iommu_plat_data
> > mt8186_data_mm =3D {
> > >         .iova_region_larb_msk =3D mt8186_larb_region_msk,
> > >  };
> > >
> > > +static const struct mtk_iommu_plat_data mt8188_data_infra =3D {
> > > +       .m4u_plat         =3D M4U_MT8188,
> > > +       .flags            =3D WR_THROT_EN | DCM_DISABLE |
> > STD_AXI_MODE | PM_CLK_AO |
> > > +                           MTK_IOMMU_TYPE_INFRA |
> > IFA_IOMMU_PCIE_SUPPORT |
> > > +                           PGTABLE_PA_35_EN |
> > CFG_IFA_MASTER_IN_ATF,
> >
> > FWIW, CFG_IFA_MASTER_IN_ATF should not be tied to the compatible
> > string,
> > but set via a DT property. The IOMMU controls are secured by
> > firmware.
> > It is not a property intrinsically tied to the hardware.
>
> The flag CFG_IFA_MASTER_IN_ATF means the registers which enable/disable
> iommu are in the secure world. If the master like pcie want to enable
> iommu, we have to enter secure world to configure it. It should be HW
> intrinsical, right?

If I understand correctly, this is forced by setting some registers.
The registers are set by the firmware at boot time.

So if a different firmware that doesn't set the registers is used,
then the IOMMU is available to non-secure kernel, correct?

That's why I said that it should not be tied to a particular hardware
platform, but set using a boolean device tree property.

> >
> > If on some other project there is no such security requirement and
> > the
> > IOMMU is opened up to non-secure world, and ATF not even having
> > support
> > for the SMC call, this becomes unusable and hard to rectify without
> > introducing a new compatible string.
> >
> > ChenYu
> >
> > > +       .inv_sel_reg      =3D REG_MMU_INV_SEL_GEN2,
> > > +       .banks_num        =3D 1,
> > > +       .banks_enable     =3D {true},
> > > +       .iova_region      =3D single_domain,
> > > +       .iova_region_nr   =3D ARRAY_SIZE(single_domain),
> > > +};
> > > +
> > > +static const struct mtk_iommu_plat_data mt8188_data_vdo =3D {
> > > +       .m4u_plat       =3D M4U_MT8188,
> > > +       .flags          =3D HAS_BCLK | HAS_SUB_COMM_3BITS |
> > OUT_ORDER_WR_EN |
> > > +                         WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE
> > |
> > > +                         PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
> > > +       .hw_list        =3D &m4ulist,
> > > +       .inv_sel_reg    =3D REG_MMU_INV_SEL_GEN2,
> > > +       .banks_num      =3D 1,
> > > +       .banks_enable   =3D {true},
> > > +       .iova_region    =3D mt8192_multi_dom,
> > > +       .iova_region_nr =3D ARRAY_SIZE(mt8192_multi_dom),
> > > +       .larbid_remap   =3D {{2}, {0}, {21}, {0}, {19}, {9, 10,
> > > +                          11 /* 11a */, 25 /* 11c */},
> > > +                          {13, 0, 29 /* 16b */, 30 /* 17b */, 0},
> > {5}},
> > > +};
> > > +
> > > +static const struct mtk_iommu_plat_data mt8188_data_vpp =3D {
> > > +       .m4u_plat       =3D M4U_MT8188,
> > > +       .flags          =3D HAS_BCLK | HAS_SUB_COMM_3BITS |
> > OUT_ORDER_WR_EN |
> > > +                         WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE
> > |
> > > +                         PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
> > > +       .hw_list        =3D &m4ulist,
> > > +       .inv_sel_reg    =3D REG_MMU_INV_SEL_GEN2,
> > > +       .banks_num      =3D 1,
> > > +       .banks_enable   =3D {true},
> > > +       .iova_region    =3D mt8192_multi_dom,
> > > +       .iova_region_nr =3D ARRAY_SIZE(mt8192_multi_dom),
> > > +       .larbid_remap   =3D {{1}, {3}, {23}, {7},
> > {MTK_INVALID_LARBID},
> > > +                          {12, 15, 24 /* 11b */}, {14,
> > MTK_INVALID_LARBID,
> > > +                          16 /* 16a */, 17 /* 17a */,
> > MTK_INVALID_LARBID,
> > > +                          27, 28 /* ccu0 */, MTK_INVALID_LARBID},
> > {4, 6}},
> > > +};
> > > +
> > >  static const unsigned int
> > mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] =3D
> > {
> > >         [0] =3D {~0, ~0},                         /* Region0: larb0/1
> > */
> > >         [1] =3D {0, 0, 0, 0, ~0, ~0, 0, ~0},      /* Region1:
> > larb4/5/7 */
> > > @@ -1701,6 +1747,9 @@ static const struct of_device_id
> > mtk_iommu_of_ids[] =3D {
> > >         { .compatible =3D "mediatek,mt8173-m4u", .data =3D
> > &mt8173_data},
> > >         { .compatible =3D "mediatek,mt8183-m4u", .data =3D
> > &mt8183_data},
> > >         { .compatible =3D "mediatek,mt8186-iommu-mm",    .data =3D
> > &mt8186_data_mm}, /* mm: m4u */
> > > +       { .compatible =3D "mediatek,mt8188-iommu-infra", .data =3D
> > &mt8188_data_infra},
> > > +       { .compatible =3D "mediatek,mt8188-iommu-vdo",   .data =3D
> > &mt8188_data_vdo},
> > > +       { .compatible =3D "mediatek,mt8188-iommu-vpp",   .data =3D
> > &mt8188_data_vpp},
> > >         { .compatible =3D "mediatek,mt8192-m4u", .data =3D
> > &mt8192_data},
> > >         { .compatible =3D "mediatek,mt8195-iommu-infra", .data =3D
> > &mt8195_data_infra},
> > >         { .compatible =3D "mediatek,mt8195-iommu-vdo",   .data =3D
> > &mt8195_data_vdo},
> > > --
> > > 2.25.1
> > >
> > >
> >
