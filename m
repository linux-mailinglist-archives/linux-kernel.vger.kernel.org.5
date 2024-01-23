Return-Path: <linux-kernel+bounces-35522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303183926A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956311C22A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102365FEE9;
	Tue, 23 Jan 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UddWVSR6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D455FF00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022985; cv=none; b=D8NTi8QYRNsa1f2XdYLIYkZZoubEMNK2KO2t3bwMsDta/1gqUjnX32V+3kG9c0fYlyZa2dz83NCqsvgLjhAHdMTI9a7hiBFmqQwxvLvo/PCY/ACr9Eu5AGSsxjEEjdjyKGnwc9naAPpkLQzFCg7Kifr2qYdEyCDrZVI5hAhM3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022985; c=relaxed/simple;
	bh=2FhW9gTePfaDvmlTVNZYpdZiCIBNlL9w99OhMpgdvfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcME/HW+3ycLXn86kHY5OQ25Jo/nnwCPlvMcXouh31xo4XwG9Bl5Cy4AWNzOv53QGJXRrfBts2qilOM8kd3/XW27cO1gkiETRVFADjFMoVZcXKZwySNF17d61rZ1QNrjVQFYikXHclaW68OpqyvyR/LSSbKHk1gFWG8fIycQSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UddWVSR6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75847BEB;
	Tue, 23 Jan 2024 16:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706022908;
	bh=2FhW9gTePfaDvmlTVNZYpdZiCIBNlL9w99OhMpgdvfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UddWVSR6bIs3iFwxw8o2Tsn1HSBMpOIAdYPwGp7EnJZigXRL2QL7Dp+pjmm4fxswX
	 tSFyEPhSI7RKp0ipqGjRP9e94/rQmDmmRbzLfJP9tHRK0oFoYxHZo3t0FTDILmg/RV
	 YzcVhLp8Jv09g0hbnj7GYpbWhjT4xAQOLanAt4Ng=
Date: Tue, 23 Jan 2024 17:16:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for
 non-DT based systems
Message-ID: <20240123151620.GN10679@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-3-sui.jingfeng@linux.dev>
 <20240123012139.GD22880@pendragon.ideasonboard.com>
 <95a7a0b2-615d-49ca-b568-1376a35493c4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95a7a0b2-615d-49ca-b568-1376a35493c4@linux.dev>

On Tue, Jan 23, 2024 at 04:20:04PM +0800, Sui Jingfeng wrote:
> On 2024/1/23 09:21, Laurent Pinchart wrote:
> > On Tue, Jan 23, 2024 at 12:32:17AM +0800, Sui Jingfeng wrote:
> >> Which is intended to be used on non-DT environment, where the simple-bridge
> >> platform device is created by either the display controller driver side or
> >> platform firmware subsystem.
> >
> > Could you give an example of a platform where you intend to use this ?
> 
> For example:
> 
> 1) USB based display adapter, such as FL2000DX[1] which use
>     the it66121 HDMI transmitter to convert the RGB888 to HDMI.
> 
> 2) Simple 2D PCIe display controller, such as SM750(EMPV-1201)
>     which using sii9022 HDMI transmitter to convert the RGB888
>     to HDMI.
> 
> 3) Some FPGA PCIe Board (sil9136)
> 
> 4) Be able to run unit test of drm bridges on X86.

Thank you, those are useful examples. It would be nice to capture at
least some of them (first instance the first two) to the commit message.

> [1] https://github.com/FrescoLogic/FL2000

-- 
Regards,

Laurent Pinchart

