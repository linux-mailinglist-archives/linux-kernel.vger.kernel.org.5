Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B57623D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGYUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGYUoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:44:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C22125;
        Tue, 25 Jul 2023 13:44:15 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65EAE6606EEE;
        Tue, 25 Jul 2023 21:44:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690317854;
        bh=l0QdiZLVFikXd6djh9oMfl+C2ChjeqPpqf7ac5R2fis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it21CKyA7WekFPItXvp7zTV3pDdq7MTw11C+d6Is0wunsHAzgQejIaLMW1dys51cx
         +OfSQ7YlmutsGoj53fpg/NrFVhxHMK34h8dJBprpBewiLkzYVFrv6FL44P9pehWXUq
         KoxEtTIKIkHDt3tmM0EjxGGmrDM8b0etKHAWFyHf3oGkbKQ9l9p4IruVoUCtDavvbm
         jPSTj2Yx2jLAbDstlibyw3qu+WxzlZfaw5oHtFeOZnQ63BAP1cB7zdy7PD5VoRIIOS
         SR16Wuo4/DxpM8rSzTNHgsZsewEfLoGqqDYAfNuaB4Wmnru+cRqQ43MTGyLOFFsHJj
         o8FxFs63Pw7UA==
Date:   Tue, 25 Jul 2023 16:44:08 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 5/7] media: mediatek: vcodec: Read HW active status
 from syscon
Message-ID: <b5ba26b8-7c03-4ead-97ff-8ee3ae0efa26@notapiano>
References: <20230630151436.155586-1-nfraprado@collabora.com>
 <20230630151436.155586-6-nfraprado@collabora.com>
 <b5fd2dff-14a5-3ad8-9698-d1a50f4516fa@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5fd2dff-14a5-3ad8-9698-d1a50f4516fa@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:15:03PM +0200, Hans Verkuil wrote:
> Hi Nicolas,
> 
> On 30/06/2023 17:14, Nícolas F. R. A. Prado wrote:
> > Remove the requirement of a VDEC_SYS reg iospace for both MT8173 and
> > MT8183. To achieve that, rely on a vdecsys syscon to be passed through
> > the DT, and use it to directly read the VDEC_HW_ACTIVE bit during IRQ
> > handling to check whether the HW is active. Also update the VP8 stateful
> > decoder to use the syscon, if present, for writes to VDEC_SYS.
> > 
> > The old behavior is still present when reg-names aren't supplied, as
> > to keep backward compatibility.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> > Changes in v5:
> > - Added explicit linux/bitfield.h include for FIELD_GET(), following
> >   0day report
> > 
> > Changes in v4:
> > - Added new helper and updated VP8 stateful decoder to use it, so the
> >   syscon can also be used by mt8173
> > - Made handling cleaner
> > - Reworded commit
> > 
> > Changes in v3:
> > - Switched handling of VDEC_HW_ACTIVE to use a syscon instead of the
> >   'active' clock
> > - Reworded commit
> > - Removed changes to subdev part of driver, since they aren't used by
> >   MT8183
> > 
> >  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 77 ++++++++++++++++---
> >  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
> >  .../mediatek/vcodec/mtk_vcodec_util.c         | 15 ++++
> >  .../mediatek/vcodec/mtk_vcodec_util.h         |  2 +
> >  .../mediatek/vcodec/vdec/vdec_vp8_if.c        | 10 +--
> >  5 files changed, 87 insertions(+), 18 deletions(-)
> 
> This patch introduced this new smatch error:
> 
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:143 mtk_vcodec_get_reg_bases() error: buffer overflow 'mtk_dec_reg_names' 11 <= 11
> 
> I think it is due to:
> 
> if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE) {
> 
> in mtk_vcodec_get_reg_bases(): the '>' should probably be '>='.
> 
> Can you post a follow-up patch fixing this?

Hi Hans,

sorry about that, and thanks for noticing it.

I've just sent the fix:
https://lore.kernel.org/all/20230725204043.569799-1-nfraprado@collabora.com

Thanks,
Nícolas
