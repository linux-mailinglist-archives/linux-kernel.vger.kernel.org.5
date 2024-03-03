Return-Path: <linux-kernel+bounces-89900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349086F70D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5CA1F214F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7F79DA2;
	Sun,  3 Mar 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSMFmx5B"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEB26AE8
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709498285; cv=none; b=oMASFM3my7lBl+S697pml/yEianK/xJVRaW52q6C5mHlkFTqsPxPfKtslM7WrtBhb7lXnALg3DwM/Oub0iXE0b4z105ghWrxuaRbqUQmSd/7ps8LS8pS/4RBQPZiXOynyxf2Str+s6hCoKc8Rlfwf/MlsSIIukSUJWm7x786x5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709498285; c=relaxed/simple;
	bh=Wvylty1eh+1a44Idstu2nddKPTGw6bCzsFT5HOlscmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6GbmmDuCyLvjg5IabOi593c7X1j8Vkt10S7yk+7Bh8gb2KBn4JjhxbBZIJoLBnMsRDI7VTOs+isJ9MGTpJ95tx/+UKLo2y7MpxUM9nujOlF4qEDv8xI2b2hDZJOie2T9rxQrawgHl23DwYDGiQdShr0d7xrxlHrYohiR1ByOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uSMFmx5B; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607e54b6cf5so24978157b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709498283; x=1710103083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dTEJxntvNcBZ56iY+D/YvQDXi/WrmMk0Lilb5w4ab2I=;
        b=uSMFmx5BBgDsLB5jCPVGkpAcBos83RaPq+dAfZUn4YJKqsFmzBWSX4o+kbXROGDE3S
         oj7+5Ci/yQb+1lKEMQVTCNjuOnI4jCyXUkfjKyGnPNlCpDhrFFbKUXBCLMOg/gOxKmX2
         C/4qQWieQF4Jb7uoXXq4RJmNLaG96/Ew/aC830yM3rBbMJee8plZSXhDA5aWlpgWS5jN
         zP1stKVdf6E8B+ThAKbDL4IP1o5UnzAktKIAR28fuTfP8NYR51wsbqt2omDvtaF+yN6Z
         agAXndU9wqtcZnD1R4AMU7zopgSgxGrRxiGHPTcKLWt2DJHp+/KEWoby7+qSCGB34xEr
         9SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709498283; x=1710103083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTEJxntvNcBZ56iY+D/YvQDXi/WrmMk0Lilb5w4ab2I=;
        b=oEmq63lkiOFN9rKIPYMnz+D+Lge7ADPF1adEWFNSHTZd3Fq/yuLeedPobrXptuFt0t
         nNWOHm8ByamyDLRkAMbyf6aWBzYOPsQd7ycybSkdf10QjfzRGw8Bg26UtCCHHmauWLFb
         pg559UP5mgHV8Vha/c02IN8ft10PyO2Pv+Bm9mSrZhbt4paCQec49aXW346v3aOTslDc
         /Az8shxZIKBCVHpfjmVI9Ah+9iCIOoHA2HXnehNYmDHl3NIQQ51jNxgZzx/R6xK7wxmT
         xcrtPJPp0dmMJsrNXtHtYcc4UoCTnNYK6xmXZigGEPvqA+bZBnaVJvyP4iq1MWw6xnzE
         3NIA==
X-Forwarded-Encrypted: i=1; AJvYcCUHvDRpGbbVtBle76U6rJCaEXkYwGBgu2w4w1wXYGoS6T6rf78XD0pZLMDvexlFCiXs/JLItHRw4uqoDjlG8Lr/sm0tERp7aQd72r93
X-Gm-Message-State: AOJu0Yz0cNphYQKyZs/GB9m6ILhKRGkqkt5JaFz4oeytTC092xtdXg20
	d7qcnIzes88B4VH+vkKC3ljWMnR1xnMtSnwSrBIQbkRmV87DqowhfSDlx7L/PoMp2udtY7+Kido
	Xs0z5dlm/nwWPDGxRdODfLrIjePwjPwJcCG1UCw==
X-Google-Smtp-Source: AGHT+IFBO5gSa9X30AT+NFRPbWSXLFEUtICo9UN0O47OM1rGMJBVkS/RT7uCPfNYDTSDuVQFKmwjyXClyQjTFs/3AYQ=
X-Received: by 2002:a81:b34a:0:b0:609:456e:683b with SMTP id
 r71-20020a81b34a000000b00609456e683bmr5138328ywh.14.1709498283167; Sun, 03
 Mar 2024 12:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <b1da07f9-7e15-4d83-bef3-d0ce157654bc@linaro.org> <CYGUWBAM3D62.35CPP5HGEYJ3Y@fairphone.com>
 <CZHGFD9QYM82.371U2DPG1AEGQ@fairphone.com>
In-Reply-To: <CZHGFD9QYM82.371U2DPG1AEGQ@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 3 Mar 2024 22:37:52 +0200
Message-ID: <CAA8EJppZRABYGuoDc-6e6VMwtAo3LvEyDpsHdkHFckrR=q+0ig@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 11:27, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Wed Jan 17, 2024 at 9:59 AM CET, Luca Weiss wrote:
> > On Mon Jan 15, 2024 at 9:43 AM CET, Neil Armstrong wrote:
> > > Hi Luca,
> > >
> > > On 11/01/2024 13:38, Luca Weiss wrote:
> > > > Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> > > > bridge/panel.o to drm_kms_helper object, we need to select
> > > > DRM_KMS_HELPER to make sure the file is actually getting built.
> > > >
> > > > Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
> > > > be properly available:
> > > >
> > > >    aarch64-linux-gnu-ld: drivers/phy/qualcomm/phy-qcom-qmp-combo.o: in function `qmp_combo_bridge_attach':
> > > >    drivers/phy/qualcomm/phy-qcom-qmp-combo.c:3204:(.text+0x8f4): undefined reference to `devm_drm_of_get_bridge'
> > > >
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > > I can see "depends on DRM_KMS_HELPER" was removed with commit
> > > > 3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS")

Could you please make sure that the usecase described in the mentioned
commit message doesn't get broken by your change?

> > > >
> > > > I'm not too familiar with Kconfig but it feels more correct if
> > > > PHY_QCOM_QMP_COMBO selects DRM_PANEL_BRIDGE that that's enough; and it
> > > > doesn't also has to explicitly select DRM_KMS_HELPER because of how the
> > > > objects are built in the Makefile.
> > > >
> > > > Alternatively solution to this patch could be adjusting this line in
> > > > include/drm/drm_bridge.h:
> > > >
> > > >    -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
> > > >    +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE) && defined(CONFIG_DRM_KMS_HELPER)
> > > >     struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
> > > >                                              u32 port, u32 endpoint);
> > > >
> > > > .. and then selecting DRM_KMS_HELPER for PHY_QCOM_QMP_COMBO.
> > > >
> > > > But I think the solution in this patch is better. Let me know what you
> > > > think.
> > >
> > > I think this is no more the case after on linux-next:
> > > 35921910bbd0 phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE
> > >
> > > But could you still check ?
> >
> > On next-20240117 the error happens in the aux-bridge file instead then.
> >
> > aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_probe':
> > drivers/gpu/drm/bridge/aux-bridge.c:115:(.text+0xe0): undefined reference to `devm_drm_of_get_bridge'
> >
> > I'm attaching the defconfig with which I can reproduce this but it's
> > really just DRM_KMS_HELPER=n and PHY_QCOM_QMP_COMBO=y I believe.
>
> Hi Neil,
>
> Ping on this patch
>
> Regards
> Luca
>
> >
> > Regards
> > Luca
> >
> >
> > >
> > > Neil
> > >
> > > > ---
> > > >   drivers/gpu/drm/bridge/Kconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > > index ac9ec5073619..ae782b427829 100644
> > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > @@ -8,6 +8,7 @@ config DRM_BRIDGE
> > > >   config DRM_PANEL_BRIDGE
> > > >           def_bool y
> > > >           depends on DRM_BRIDGE
> > > > + select DRM_KMS_HELPER
> > > >           select DRM_PANEL
> > > >           help
> > > >             DRM bridge wrapper of DRM panels
> > > >
> > > > ---
> > > > base-commit: b9c3a1fa6fb324e691a03cf124b79f4842e65d76
> > > > change-id: 20240111-drm-panel-bridge-fixup-5c2977fb969f
> > > >
> > > > Best regards,
>


-- 
With best wishes
Dmitry

