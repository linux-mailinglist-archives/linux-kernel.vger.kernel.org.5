Return-Path: <linux-kernel+bounces-118910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353C88C10A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574EE1C3BFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3895C602;
	Tue, 26 Mar 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJwPKU5O"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B5481A5;
	Tue, 26 Mar 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453421; cv=none; b=t/EcXv7u9bc9yn/WhJ6moxj+1lq2tW1XbA57c/1SAQmmp6+wnbFQVSO3cIjW47K1vkuF4+1aNDfJvCv4ga1412CHk0vlfaxi0z7Dufw/Kykh/fHjIOjR4ZeVRaSvzYq1RJSJD8FMI/Qqycg17/K2uoeVjzKjHKz7RRbApEJowwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453421; c=relaxed/simple;
	bh=fv/O+QB1AUPw06AYNUVw/D5uh8D1/D/a8qN4ZfjXcXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiPOV1gZxyL+4xzB4CeOFpqwCtyBkMnqjJ2nqPe3ecqA+BRb5vRWKqJjNeiYRQakzyyAplU3Usky0idJHt7VtNq8ciDStIwBX12tWBpTgBt9k3wv3olARI0AluGu9ngJtFR8ro7f1VsoXixAB2J1sJw5e3NJMn30atVxyeRwhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJwPKU5O; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3148148a12.3;
        Tue, 26 Mar 2024 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711453418; x=1712058218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JJfNLPGXQjdD5E+CQgcIovMfTBNJAPrFsXk8DSz3Bc=;
        b=bJwPKU5OuQ3ewtM4QuLyzTiSsKY2bHUn8hCJTikPSKnNM79caY7mgaahyiieCPTkLH
         IShrx+4bdGjTvyHWxknXZ9h92OlSrPrnxpdb4GK755o9oQOwTxubMGkUuPauaUpp19i+
         XMKgyZm5ua6EkOS2Cg+Oz/7Y5FYWQpo5ieP6bplkiqLP4WiltH9X/N3MXVhZRwovFaZ2
         +3KIDI6p4v2eFiFP5wRKQdcd6SyfJ6wsdm+Z5RxiKaZTgGPs7g5QyuJp64q89G+rB6KN
         tWYHaD/6g5qXMOxH908vFSn3VWJhbKP61oStwwzg0GXWiv0Mj+/svEIye60p8+x5700y
         5ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453418; x=1712058218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JJfNLPGXQjdD5E+CQgcIovMfTBNJAPrFsXk8DSz3Bc=;
        b=PsoEPhAsUDl/7BkLJZK6/2pmQOLra27fr/nHnQI2IGPsAM92SvK7ujOOa0fSfQXhIX
         eTj+xtj44qovi611C3rqS0XgBv8PMxEko06VQPTPQXOfrQvxtkU43bn3TNZjLKhB861D
         u6VbuCYQS7TrNqPfSaul7t1nhneZpVwvUUAM/Q/RxAFwa6wSGpHXmT+2o8ywNDxipElP
         y/ZKvZbiztnbF2FC5RvMv4m+xfEcir44tJSWhXOUyp3sac0gCbta4Z4+LvVgrTKueXEe
         KRz6Ovl383dY0Y7MkXga5eNnKSl35KlJWaP1rhW/i4Wl1QxdPI2JWWJqEQCifWPK6JXX
         9Svg==
X-Forwarded-Encrypted: i=1; AJvYcCXEdOB5Oi1TBi/vUIRzLgwobOB1q0vikqtdplLuuRNeiv0XsO7NEDSwRn/OdEaNM4LhmqU8SyDfkvqWcA550tId4oF37eTAX/j0jCdieanjxzOgr/jWog9yiDaO9+WkXrOJfVWsq/ph/Uw5pr852FTFeI9KGtwv6Gbb37/RcOV9MqsJ
X-Gm-Message-State: AOJu0YxAzJBi0q+Yk1NGrGRTnZBjuSIIPlN0CPR17Btok/ddcq07WO+O
	1Wkbm2V2NOoP589WVxAxKw1mjDHJzfVactHlUudDgqHFrIDx6X+J9V/EJfyxKq5O0C7ePqcS1lf
	n4wwkKS9A4ZMe/UNB83mDQUrTrus=
X-Google-Smtp-Source: AGHT+IFJr4BwXlddlBEjDngUlpX7zK9gcwzqV6NzPa916601f5z9OcCg5f1L0di5ibf8HMxg/xfxr8hQHHEfl93yHwc=
X-Received: by 2002:a17:90a:4a0c:b0:2a0:3dc1:2926 with SMTP id
 e12-20020a17090a4a0c00b002a03dc12926mr7088214pjh.17.1711453418128; Tue, 26
 Mar 2024 04:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20240325220338.GE23988@pendragon.ideasonboard.com> <ZgJ9P3Wx2A2n9Gt+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
In-Reply-To: <ZgJ9P3Wx2A2n9Gt+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 26 Mar 2024 06:43:26 -0500
Message-ID: <CAHCN7xKWUQwfNmTB_bu4Kqm-b6PSPBHvyf8yfRbL53rB20-=DQ@mail.gmail.com>
Subject: Re: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, 
	marex@denx.de, alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 2:46=E2=80=AFAM Tommaso Merciai <tomm.merciai@gmail=
com> wrote:
>
> Hi Laurent,
>
> On Tue, Mar 26, 2024 at 12:03:38AM +0200, Laurent Pinchart wrote:
> > Hi Tommaso,
> >
> > On Mon, Mar 25, 2024 at 10:48:56PM +0100, Tommaso Merciai wrote:
> > > Hi Adam, Lucas,
> > > Thanks for this series.
> > >
> > > This series make HDMI work on evk.
> > > All is working properly on my side.
> > >
> > > Tested on: Linux imx8mp-lpddr4-evk 6.9.0-rc1.
> > > Hope this help.
> > >
> > > Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> >
> > The DRM side has been merged already. The only missing patches are for
> > the PHY, and the latest version can be found in
> > https://lore.kernel.org/linux-phy/20240227220444.77566-1-aford173@gmail=
com/.
> > You can test that series and send a Tested-by tag. I'm crossing my
> > fingers and hoping it will be merged in v6.10.
> (same here :) )
>
> Thanks for sharing! :)
>
> To be honest I test all this series rebasing my alvium next branch on top=
 of media_stage/master (6.9.0-rc1)
> All is working properly on my side.
> I found v8 into the commit msg here: https://patches.linaro.org/project/l=
inux-pm/patch/20240203165307.7806-9-aford173@gmail.com/
> then I'm thinking this is the latest.
>
> I'm going to switch to your suggestion that looks more recent :)

Sorry about the confusion.  I was confused by the versioning too when
I pulled from different parts of Lucas' stuff.  Since varying
components were applied at different times, and the remaining part was
based on the wrong starting point and not applied, I reverted back to
the versioning of the PHY which was the only remaining part other than
device tree stuff.

adam
>
> Thanks again,
> Tommaso
>
> >
> > > On Sat, Feb 03, 2024 at 10:52:40AM -0600, Adam Ford wrote:
> > > > The i.MX8M Plus has an HDMI controller, but it depends on two
> > > > other systems, the Parallel Video Interface (PVI) and the
> > > > HDMI PHY from Samsung. The LCDIF controller generates the display
> > > > and routes it to the PVI which converts passes the parallel video
> > > > to the HDMI bridge.  The HDMI system has a corresponding power
> > > > domain controller whose driver was partially written, but the
> > > > device tree for it was never applied, so some changes to the
> > > > power domain should be harmless because they've not really been
> > > > used yet.
> > > >
> > > > This series is adapted from multiple series from Lucas Stach with
> > > > edits and suggestions from feedback from various series, but it
> > > > since it's difficult to use and test them independently,
> > > > I merged them into on unified series.  The version history is a
> > > > bit ambiguous since different components were submitted at differen=
t
> > > > times and had different amount of retries.  In an effort to merge t=
hem
> > > > I used the highest version attempt.
> > > >
> > > > Adam Ford (3):
> > > >   dt-bindings: soc: imx: add missing clock and power-domains to
> > > >     imx8mp-hdmi-blk-ctrl
> > > >   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
> > > >     domain
> > > >   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> > > >
> > > > Lucas Stach (9):
> > > >   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
> > > >   phy: freescale: add Samsung HDMI PHY
> > > >   arm64: dts: imx8mp: add HDMI power-domains
> > > >   arm64: dts: imx8mp: add HDMI irqsteer
> > > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
> > > >   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
> > > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
> > > >   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
> > > >   arm64: dts: imx8mp: add HDMI display pipeline
> > > >
> > > >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
> > > >  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
> > > >  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
> > > >  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
> > > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
> > > >  arch/arm64/configs/defconfig                  |    1 +
> > > >  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
> > > >  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
> > > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
> > > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
> > > >  drivers/phy/freescale/Kconfig                 |    6 +
> > > >  drivers/phy/freescale/Makefile                |    1 +
> > > >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++=
++++
> > > >  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
> > > >  14 files changed, 1876 insertions(+), 13 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/bridg=
e/fsl,imx8mp-hdmi-tx.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/display/imx/f=
sl,imx8mp-hdmi-pvi.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8m=
p-hdmi-phy.yaml
> > > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > > >  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> >
> > --
> > Regards,
> >
> > Laurent Pinchart

