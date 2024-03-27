Return-Path: <linux-kernel+bounces-121613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0288EAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057FC1C31CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA513B285;
	Wed, 27 Mar 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfKe9Umm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E712EBEE;
	Wed, 27 Mar 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555751; cv=none; b=q71nmb8lmwKrRpmVBtN0O/kgglyv4TashyrueNMX/FAqYcZFpge49Bg3AHgK6MD414XKB6kvbnWkfTHnsrKSl4RK0MsrwqRS2PG+RvLcYuN1RNJsLgHdl71deqEzmePM62++ixky8AdbaabSWxTexsiJszeiKiPVUwcCJAqIvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555751; c=relaxed/simple;
	bh=7T5BGCgr9wS3JyIXUuZj45o2W4RjyxGPRlRV3KjkiR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9kLJ6LFfWK47WXG3itkmVlvh8LxQUWZs6UZKWNSlQ3iSsb/RxjgMBmXng2Vvj86mceDib/skeQh0TC4Z1PWgWwRVfkkXsep502Qmddz1L5YpbaT/oBGjC0Do4bhzvRmSaErrFbxZUqwVMI5i0a4pDo9NZMaclQalCswJHI/QYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfKe9Umm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1317C433F1;
	Wed, 27 Mar 2024 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555751;
	bh=7T5BGCgr9wS3JyIXUuZj45o2W4RjyxGPRlRV3KjkiR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfKe9Ummb1Wuiv7L+kpncdWozSCKk+PB5D7rWUWkaFNAYfRZn+DbpcVO8s3vi7eib
	 keLxWh1PKWe1ExQ5TlqVM3uIoz7SWDP//aVLfwNcdej7PmjfdMSr2s5N/8jacJDsFQ
	 F0O7zMTBXtsW2CVAMdGb4b8792vbVzKZ1F6Mp9ah1dmHgaqsl7QjS139fzp+SmOVPA
	 YJyXd7N01LS1PLAyLV35txUfhWcm44u/suRDKJuE0azWKWY+acumVfleERK4obiicW
	 76MqOyHrAFAzNK7zdJEFXasTxmGDMk9ZJ2j4UxXapOCz49IN/Ey6r/pc42SlIiXyVN
	 M1cdgflipBJ8w==
Date: Wed, 27 Mar 2024 11:09:08 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: add the Hot-plug MIPI
 DSI connector
Message-ID: <20240327160908.GA3460963-robh@kernel.org>
References: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
 <20240326-hotplug-drm-bridge-v1-1-4b51b5eb75d5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-hotplug-drm-bridge-v1-1-4b51b5eb75d5@bootlin.com>

On Tue, Mar 26, 2024 at 05:28:11PM +0100, Luca Ceresoli wrote:
> Add bindings for a physical, hot-pluggable connector allowing the far end
> of a MIPI DSI bus to be connected and disconnected at runtime.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../bridge/hotplug-video-connector-dsi.yaml        | 87 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml
> new file mode 100644
> index 000000000000..05beb8aa9ab4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/hotplug-video-connector-dsi.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/hotplug-video-connector-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hot-pluggable connector on a MIPI DSI bus
> +
> +maintainers:
> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> +
> +description:
> +  A bridge representing a physical, hot-pluggable connector on a MIPI DSI
> +  video bus. The connector splits the video pipeline in a fixed part and a
> +  removable part.
> +
> +  The fixed part of the video pipeline includes all components up to the
> +  display controller and 0 or more bridges. The removable part includes one
> +  or more bridges and any other components up to the panel.
> +
> +  The removable part of the pipeline can be physically disconnected at any
> +  moment, making all of its components not usable anymore. The same or a
> +  different removable part of the pipeline can be reconnected later on.
> +
> +  Note that the hotplug-video-connector does not describe video busses
> +  having native hotplug capabilities in the hardware, such as HDMI.
> +
> +properties:
> +  compatible:
> +    const: hotplug-video-connector-dsi

Got a spec for this connector? How do I know if I have one or not?

The problem here is what else is on this connector? GPIO controls, 
power rails, etc.?

If this is some kind of standard connector, then we need to be able to 
remap everything on the connector not just DSI signals. And for that, 
it's not just DSI signals, so I'd say we would need some sort of generic 
graph remapping that the core graph code handles transparently.

 If it is not standard, then you don't need any remapping and can just 
use an overlay that connects the ports directly.

Rob

