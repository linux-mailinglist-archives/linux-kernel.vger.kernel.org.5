Return-Path: <linux-kernel+bounces-85541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11C86B744
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A4228BAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A871EB0;
	Wed, 28 Feb 2024 18:38:42 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15279B79
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145522; cv=none; b=St0U6VfDpMkL4WWjyTpiQ6+fQgZDV6Jq7lV9ZhDdt4NK5zOCm5iOpd7RpWuRrM9XjROtILVafBNuvPuVbUqwJyL3Jk4fgiGv0Ccz/5usU6IzBqTYyUMyBl8uGvmTyisJI9aUX3Du6F4EpmTGfo5U4XLpQZt95cww/FpuKxTu4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145522; c=relaxed/simple;
	bh=MsJjh7TXS8JgWzGdB0v4jRwOparhSbtOtRlvrf4J/gU=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=A2LGTywGplfT0AX8CmV0yTt9tEFv+uSUod+qkAIjo1tWu3miBF+6C3oOqGZq4BnMYHIabkIHLlTcXWG26rWMefMFM5Wix9qhEvZJz6I2A10vgJydg3Xiq9tOZXO0uavHF+Jvhl6kRgG35v0GF8OcGz9DHbT4L6NWqiYuGhdnj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.149] (port=32378 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rfOja-00034v-6A;
	Wed, 28 Feb 2024 21:32:51 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1rfOja-000Yz9-2h;
	Wed, 28 Feb 2024 21:32:50 +0300
Message-ID: <79c92cfa-cf5a-4a23-8a93-11c1af7432fc@ancud.ru>
Date: Wed, 28 Feb 2024 21:32:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] drm/i915: Remove unneeded double drm_rect_visible call in
 check_overlay_dst
Reply-To: Nikita Kiryushin <kiryushin@ancud.ru>
References: <>
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Manasi Navare <manasi.d.navare@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 project@linuxtesting.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


check_overlay_dst for clipped is called 2 times: in drm_rect_intersect 
and than directly. Change second call for check of drm_rect_intersect 
result to save some time (in locked code section).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8d8b2dd3995f ("drm/i915: Make the PIPESRC rect relative to the 
entire bigjoiner area")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/gpu/drm/i915/display/intel_overlay.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_overlay.c 
b/drivers/gpu/drm/i915/display/intel_overlay.c
index 2b1392d5a902..1cda1c163a92 100644
--- a/drivers/gpu/drm/i915/display/intel_overlay.c
+++ b/drivers/gpu/drm/i915/display/intel_overlay.c
@@ -972,9 +972,8 @@ static int check_overlay_dst(struct intel_overlay 
*overlay,
  		      rec->dst_width, rec->dst_height);
   	clipped = req;
-	drm_rect_intersect(&clipped, &crtc_state->pipe_src);
  -	if (!drm_rect_visible(&clipped) ||
+	if (!drm_rect_intersect(&clipped, &crtc_state->pipe_src) ||
  	    !drm_rect_equals(&clipped, &req))
  		return -EINVAL;
  -- 2.34.1


