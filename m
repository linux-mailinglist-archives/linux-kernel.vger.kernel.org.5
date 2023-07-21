Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF175CAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGUOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGUOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:52:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF3F0;
        Fri, 21 Jul 2023 07:52:29 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 780E16606EE0;
        Fri, 21 Jul 2023 15:52:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689951148;
        bh=98bysGy+AeVi9wthSW3bKoLCU2PN4QMkm22+kvUMnWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joUUPWHADFpPK77514Ek71bf5t5zpKD6tvYcIO0gvGc+G4FTMiFstL89i+PqFIx39
         DX4FxMvrMdEcbmQKdXjwh+d7PWhx2Ii7bKGvx5TAzwkF5M6Xsz/PLiS1wmywRn6ZQP
         Pt0Nct/1ZoNTTGziCUvbEGm4+F5bwYZlC113Wj+fs9ckiFX2yhDN1N9CiyJ1cE9af2
         N73I8Vr3lNHHNft8iDK9VSike47aLodpcoJyU1nVw7Ok7R7iQrIm7L3B7QB16CBEDE
         vTjEFDOJMblL5MEZtQHxnE9Ay1QvqW9bLUcxtxcJcfbIgCK4zw4Kk/JgpXbFPTGws4
         LaFb5BxvYn3DA==
Date:   Fri, 21 Jul 2023 10:52:23 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 5/7] media: mediatek: vcodec: Read HW active status
 from syscon
Message-ID: <08fab56b-c938-4509-940e-eab503f87740@notapiano>
References: <20230630151436.155586-1-nfraprado@collabora.com>
 <20230630151436.155586-6-nfraprado@collabora.com>
 <fe9b6ee0-4661-ec0d-a49f-5986e00cb355@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe9b6ee0-4661-ec0d-a49f-5986e00cb355@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:44:10PM +0200, Hans Verkuil wrote:
> On 30/06/2023 17:14, Nícolas F. R. A. Prado wrote:
[..]
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > @@ -489,6 +489,7 @@ struct mtk_vcodec_dev {
> >  	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
> >  	const struct mtk_vcodec_dec_pdata *vdec_pdata;
> >  	const struct mtk_vcodec_enc_pdata *venc_pdata;
> > +	struct regmap *vdecsys_regmap;
> 
> You forgot to add the kerneldoc documentation for this new field.
> 
> If you just give me the documentation of this field then I can modify the
> patch. That's actually easier for me.

Sorry about that. Seems like I'm not getting a kerneldoc warning due to that,
I'll look into why so I can catch this next time.

This is the documentation:

@vdecsys_regmap: VDEC_SYS register space passed through syscon

Or if a patch that applies on top would make it easier to fixup:

cat 0001-media-mediatek-vcodec-Add-missing-kerneldoc-for-vdec.patch
From ee6a6d619dbe60c8f4947188a9b9bbeafc3616f7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Fri, 21 Jul 2023 16:33:54 +0200
Subject: [PATCH] media: mediatek: vcodec: Add missing kerneldoc for
 vdecsys_regmap
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 0b430936f67d..c38eb62bc72a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -441,6 +441,7 @@ struct mtk_vcodec_enc_pdata {
  * @reg_base: Mapped address of MTK Vcodec registers.
  * @vdec_pdata: decoder IC-specific data
  * @venc_pdata: encoder IC-specific data
+ * @vdecsys_regmap: VDEC_SYS register space passed through syscon
  *
  * @fw_handler: used to communicate with the firmware.
  * @id_counter: used to identify current opened instance
--
2.30.2

Thanks,
Nícolas
