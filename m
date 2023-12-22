Return-Path: <linux-kernel+bounces-9358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C881C490
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4B31F24C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AF8C14;
	Fri, 22 Dec 2023 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F6DfyCUL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69406FC2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qv/4WGiqI5RbZ8+yGA8HWT/rnQNhck+h6ELpLX3MmQY=; b=F6DfyCULg5XHnTy+4wuTpM9wxk
	Hs3AwZ8tRZmisefjBm9ibPINppADr01EN3dIf8uRAFUuP4DBjeA+7ynMnzxqeacrR2tX8v4s5jo9e
	vb6dERMHAZ2x97TqbnpuX2IhTomk+qv5m4e7i3heCEwRgv+2pSxR9aHM3juS1LqyCSjzvWmsGD5u4
	3SGUcjunrW73kUvkJ12ONNDmLxPSK2HjB+Olh5PDI4kEXwT5IaNRsu7lesJlrdCwQQcgWdyq1yIdl
	WfSgdNhghRnmBAQ8Sn8CuEU0feM/A4x6qQPU1ZzIHI6t6rHr3OgN3Ac5//7p/Y5jWWjGqn2I/es/n
	+YrrZrkg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXmO-004wFX-1m;
	Fri, 22 Dec 2023 05:09:00 +0000
Message-ID: <536a5850-34af-4a7d-b65d-82147895ef04@infradead.org>
Date: Thu, 21 Dec 2023 21:08:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: avoid stringop-overflow warnings for
 dp_decide_lane_settings()
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Wenjing Liu <wenjing.liu@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, George Shen <george.shen@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Michael Mityushkin <michael.mityushkin@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alan Liu <haoping.liu@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20231122221421.2944301-1-arnd@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231122221421.2944301-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/22/23 14:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc prints a warning about a possible array overflow for a couple of
> callers of dp_decide_lane_settings() after commit 1b56c90018f0 ("Makefile:
> Enable -Wstringop-overflow globally"):
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_sequence_legacy':
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
>   426 |                         dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   427 |                                         lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
> 
> I'm not entirely sure what caused this, but changing the prototype to expect
> a pointer instead of an array avoids the warnings.
> 
> Fixes: 7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS link training at DP1 rates")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 +-
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 90339c2dfd84..5a0b04518956 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -807,7 +807,7 @@ void dp_decide_lane_settings(
>  		const struct link_training_settings *lt_settings,
>  		const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
>  		struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
> -		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
> +		union dpcd_training_lane *dpcd_lane_settings)
>  {
>  	uint32_t lane;
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> index 7d027bac8255..851bd17317a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> @@ -111,7 +111,7 @@ void dp_decide_lane_settings(
>  	const struct link_training_settings *lt_settings,
>  	const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
>  	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
> -	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
> +	union dpcd_training_lane *dpcd_lane_settings);
>  
>  enum dc_dp_training_pattern decide_cr_training_pattern(
>  		const struct dc_link_settings *link_settings);

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

