Return-Path: <linux-kernel+bounces-109806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C098855EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E18284D16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E15200D9;
	Thu, 21 Mar 2024 08:45:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13A1CD1E;
	Thu, 21 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010700; cv=none; b=dPJWc3HhFK/Kch14ebJVvrj3kQt7FnXdwGsRPWg1ngrqY/UbVcFBm8tOxy1zCZiS/dbxUpuUF/JPe/hX2HVjKCMh+OnZRREuxMxh6OEM69d4saBwXwR7aujkY8Y70PoVZo+3NrtcwjZbBY9x04/3CVwG9pZsUFwJfU8sEoykdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010700; c=relaxed/simple;
	bh=5PL0FOqgSLRcQLeMbWOwS8bEyOSQwYf2t/O+B+Vwrb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3NdJqKINmdY5g7zIA0a2qMfkJ6a7YLNawa8kVb2oCJWl0C9EMEmGXyxOhBL5DNI/0LvrXRz0zt4d6VeD9I+8VHvTsQE5qXMc9KJPz/a3CWGrCLzan6gYg9hxiC4it/0T85ORoKf4ros4YuItT5xiAowsxZ/3fxl2IaC9K7EI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 284091007;
	Thu, 21 Mar 2024 01:45:26 -0700 (PDT)
Received: from [10.57.72.138] (unknown [10.57.72.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BC9F3F67D;
	Thu, 21 Mar 2024 01:44:49 -0700 (PDT)
Message-ID: <3afdba54-2a85-46a6-a0f1-a61b4d0d8930@arm.com>
Date: Thu, 21 Mar 2024 08:44:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: devfreq_cooling: Fix perf state when
 calculate dfc res_util
Content-Language: en-US
To: =?UTF-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Cc: "tao.huang" <tao.huang@rock-chips.com>, heiko <heiko@sntech.de>,
 "rui.zhang" <rui.zhang@intel.com>, "finley.xiao"
 <finley.xiao@rock-chips.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-pm <linux-pm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "daniel.lezcano" <daniel.lezcano@linaro.org>, rafael <rafael@kernel.org>
References: <fb9b21f6-4c73-4a85-93cc-56e7c44359cb@arm.com>
 <ANIAEAAdHuSn9iPJ6HkLiaq2.3.1711010230402.Hmail.ye.zhang@rock-chips.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ANIAEAAdHuSn9iPJ6HkLiaq2.3.1711010230402.Hmail.ye.zhang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/21/24 08:37, 张烨 wrote:
> 
> Hi Lukasz,
> 
> Regarding your question about how I triggered the issue andifI have a 
> driver that provides the get_real_power() callback:
> 
> I encountered thisissue whilecalculating the GPU power consumption onthe 
> Rockchip RK3399 platform. The GPU model isMali T860, which isan ARM 
> Midgard GPU. The driver version isr18p0-01rel0, andit provides the 
> get_real_power() callback.Best regards, Ye Zhang

Yes that would trigger the issue. Thank you Ye for
sharing that.

BTW, I also use RK3399 for my mainline kernel development.
I use the Rock Pi 4SE with the mainline GPU driver
'panfrost'. That GPU driver doesn't support the get_real_power()
callback, but maybe it would be worth to add it...

Please send the v2 and I will add my reviewed-by tag for it.

Regards,
Lukasz


