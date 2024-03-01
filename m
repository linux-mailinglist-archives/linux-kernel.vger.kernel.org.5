Return-Path: <linux-kernel+bounces-89063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D7686EA1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A569A1F24344
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED43C49A;
	Fri,  1 Mar 2024 20:13:40 +0000 (UTC)
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E57EC;
	Fri,  1 Mar 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324019; cv=none; b=Ir0V9Bo4msHa+o+lDzw4XUZifydg8uym72nR/dAKRGMJij2kb2TTqCydsQUKqgna7+CwvvC6wxmlBiy5HQPyGaVYb+Lbru7LAsZKFkhlAHqHHy2SPQNiVSWVgrAqXQaFBwn3qsARAQMUknSiaJYXyemHGh/dWnXzRO2aRYofkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324019; c=relaxed/simple;
	bh=qsTCsmAF3I9S9oSBSGdZteZ9eWDoMSLbY3Z0xeS0S9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=grd85gljeFW9Z0z2Wxc/jPSzjQuP/6dt3YK7Ab59+2WG25hOnKQ1pd0VzYXL3R0hwgk07hyuVDZMY4whDJ9W5Rfoq1H71jiD5/27qnVnN94uL3xOc50y6Z1crfUr7oGnexEHtdGPWbHNOkv41XtdqwuOcuOoQFpDZWSfKy0IHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.19] (port=5690 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rg8wl-00053b-8I;
	Fri, 01 Mar 2024 22:53:32 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1106.mail.hosting.nic.ru (Exim 5.55)
	with id 1rg8wl-000Kr6-1b;
	Fri, 01 Mar 2024 22:53:31 +0300
Message-ID: <1d6c298a-81d5-4ffd-becb-3a796690f4be@ancud.ru>
Date: Fri, 1 Mar 2024 22:53:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] staging: sm750fb: Remove unneeded setting of
 info->screen_size
References: <>
Content-Language: en-US
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


In lynxfb_set_fbinfo info->screen_size is set twice, the first value is
never used and then overwritten.

Remove the first time the value is set.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/staging/sm750fb/sm750.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c 
b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..70d1c8292df0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -845,7 +845,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, 
int index)
  	info->pseudo_palette = &par->pseudo_palette[0];
  	info->screen_base = crtc->v_screen;
  	pr_debug("screen_base vaddr = %p\n", info->screen_base);
-	info->screen_size = line_length * var->yres_virtual;
   	/* set info->fix */
  	fix->type = FB_TYPE_PACKED_PIXELS;
-- 
2.34.1


