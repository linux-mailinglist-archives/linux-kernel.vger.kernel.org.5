Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1E7999D4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjIIQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjIIPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:37:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12388138;
        Sat,  9 Sep 2023 08:37:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [80.194.85.162])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B40E3B1;
        Sat,  9 Sep 2023 17:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694273731;
        bh=PUBdnMzQWjybgAphbuDj9Jlrd9yGtqWsPZzqidBnMyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ft7bIvZ0/fpYIbYc8e2rLGyX8E2XpLc8YQUhuVHSLkFrAxBrOa24VYgg8CX8KUPkj
         D1ZwHL228SitOvlHMUJuudTxcwG3b8BoyrCFp+3Axeq8hPIo1n+cYx4JLYGnsQkQ10
         oV99kmV1ubblBg2m3Hb0ibZg345RE+/oeSlNEJEs=
Date:   Sat, 9 Sep 2023 18:37:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Message-ID: <20230909153714.GA21014@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <20230908205222.GA320762-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908205222.GA320762-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:52:22PM -0500, Rob Herring wrote:
> On Wed, Sep 06, 2023 at 08:31:18AM +0900, Paul Elder wrote:
> > Add overlays for the Pumpkin i350 to support THP7312 cameras.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
> >  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
> >  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
> >  4 files changed, 173 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 20570bc40de8..ceaf24105001 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> >  
> > +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> > +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
> >  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
> 
> This has no effect. You are assigning the same variable 3 times. It 
> needs to be every overlay applied to its base is a *-dtbs variable and 
> then those are all added to 'dtb-y'. IOW, we don't allow overlays which 
> can't be applied at build time.
> 
> Assuming the overlays aren't mutually exclusive, you could do:
> 
> mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
> mtk-mt8365-pumpkin-dtbs += mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> mtk-mt8365-pumpkin-dtbs += mt8365-pumpkin-csi1-thp7312-imx258.dtbo
> 
> This works the same way as '-objs' variables to group .o files into a 
> module.
> 
> > +
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
> 
> Looks like mtk-mt8365-pumpkin.dtb failed to get built before. In any 
> case, that's a terrible name. What's the difference between 
> mt8365-pumpkin.dtb and mtk-mt8365-pumpkin.dtb? There's no clue.

That's a bad name indeed. The cover letter indicates that this patch
depends on currently out-of-tree DT changes, including a
work-in-progress commit that adds mt8365-pumpkin-ethernet-usb.dtbo. The
commits order makes this patch look weird.

Paul, in your v2, please indicate in the commit message of this patch
that it isn't intended to be merged yet. A "[DNI]" prefix in the subject
line will help.

-- 
Regards,

Laurent Pinchart
