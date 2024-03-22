Return-Path: <linux-kernel+bounces-111614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE5886E97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749141F237FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866247A60;
	Fri, 22 Mar 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vb2tIA0m"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1300433B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117839; cv=none; b=VcjfRjTmF/5XmYa06uYlP7vECC2wpg90SwylkQ+NxXgV1IbFt3R0mTqaIxcHZc5u6RvexHFEPZoyZf+oPlosQr4DSUiqUgDEIVNALL69tkmO/jclaf5mEfaQ1en7J4r31gGObRP2tvuq2V4x7l5H6nxQWV1+lzwCcr/kiIewO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117839; c=relaxed/simple;
	bh=ckkugpHgNe8GIeIYxkb7EhPuXOw/jTJIfXFSmMpb8YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igo+doRLDkJeF1Bvx9PVRmAgmDQXgCVEq5UNun2yqkBoxYy0Cye0B715whOWc/aNSgGUk2AYeP9PrHBIsfaEsgH3z7YkS1e08LC6Qr3KtfzCzE/Tcf61jfHW5CcVfdUR2ldmliq+ULM80RgSOHpvqOyodnx8F1cUw4JmJW72vsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vb2tIA0m; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe4ea866-5485-4041-9a06-5441c429b150@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711117835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IllocFnwNiXVGU+HouNFbx0kAsYD151iYbY5EqUrK60=;
	b=vb2tIA0mE3RjQRmFtwRGeRNWtPVle8xwPuGz3k0mXmPbxA9+rb6RH0etsFkHhWQAK0DPpa
	g5mehHDk0VOcMpylaYKuk/GPkLTeV+eLrTyDxbPhCe5wLBDOUZZwHJnSVNO/KTYtRNTvk5
	0YVP778XwUltNtoGBLyTwJ0FFHUEiCo=
Date: Fri, 22 Mar 2024 22:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v10,20/27] drm/connector: hdmi: Add Infoframes generation
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240321-kms-hdmi-connector-state-v10-20-e6c178361898@kernel.org>
 <07125064-2a78-4515-bb48-655f2aec140f@linux.dev>
 <20240322-loose-resourceful-bullmastiff-92cfaf@houat>
 <7835e928-7d09-446e-91dd-13a0fa549bc2@linux.dev>
 <20240322-steadfast-tanuki-from-mars-b5ea5f@houat>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240322-steadfast-tanuki-from-mars-b5ea5f@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/22 20:31, Maxime Ripard wrote:
> On Fri, Mar 22, 2024 at 07:13:54PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>>
>> On 2024/3/22 18:31, Maxime Ripard wrote:
>>> Which default config are you talking about? This compiles fine with all
>>> drm-misc defconfig, x86 defconfig and allmodconfig.
>> The drm_hdmi_avi_infoframe_colorimetry() function is belong to the drm_display_helper.ko
>> kernel module, it get called from hdmi_generate_avi_infoframe() in drm_atomic_state_helper.c.
>> While drm_atomic_state_helper.c belongs to drm_kms_helper.ko. Therefore drm_kms_helper.ko
>> is dependent on drm_display_helper.ko implicitly. So we probably should select it.
> Right. I was asking which config are you using to generate that build error


I'm using the arch/riscv/configs/defconfig, with the following module de-selected.

CONFIG_DRM_RADEON
CONFIG_DRM_NOUVEAU
CONFIG_DRM_SUN4I

  

> Maxime

-- 
Best regards,
Sui


