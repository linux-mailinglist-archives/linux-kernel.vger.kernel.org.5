Return-Path: <linux-kernel+bounces-8643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F3A81BA90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E70B25BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6021B53A18;
	Thu, 21 Dec 2023 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiXWHsxb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27E53A07
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD30DC433C8;
	Thu, 21 Dec 2023 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703172140;
	bh=fIzTo/3ZIFLscG9120jiMuLgIKbdUgfY95NTKVNWc2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiXWHsxbux1U66A3/iBqKJuVtr88OwG8hxr8tVAtccivNiAux37QlStIetM8OOr5m
	 N3mSqY3f+o1f3gXYrw02MdbwukjCaCt0Ib2ERPDDPsyLCdIT84LBo/l9IBhyGn6dLY
	 MT69mc3IWtblKrQ8KwzgkWEMK9nmHHqRxUs4PbLK+37mW+iZDG4AElEdzJFt339j0z
	 ibMSftTRmmcTAU6wHUWtPSlZ/zYOsFOxW2ta56TY0b5BJlz6X7cZqv030Gt1Hq3E7q
	 XMPAjR/zFOPEuAuVmqCI9tvGejvEt5qgifAiivW0UGnwhAmu3arXmflOqHr0gYlTB5
	 Hp8SbjizqAgHA==
Date: Thu, 21 Dec 2023 15:22:14 +0000
From: Lee Jones <lee@kernel.org>
To: yang.guang5@zte.com.cn
Cc: jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: wm8994: Switch to use dev_err_probe() helper
Message-ID: <20231221152214.GL10102@google.com>
References: <202312201059100522230@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202312201059100522230@zte.com.cn>

On Wed, 20 Dec 2023, yang.guang5@zte.com.cn wrote:

> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> dev_err() can be replace with dev_err_probe() which will
> check if error code is -EPROBE_DEFER.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  drivers/mfd/wm8994-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

How did you create and send this patch?

When I try to apply this, I get:

  ERROR: patch seems to be corrupt (line wrapped?)
  #37: FILE: drivers/mfd/wm8994-core.c:384:
  2.25.1
  
  ERROR: Missing Signed-off-by: line by nominal patch author 'Yang Guang <yang.guang5@zte.com.cn>'
  
  total: 2 errors, 0 warnings, 14 lines checked
  
  NOTE: For some of the reported defects, checkpatch may be able to
        mechanically convert to the typical style using --fix or --fix-inplace.
  
  "[PATCH v2] mfd: wm8994: Switch to use dev_err_probe() helper" has style problems, please review.

AND:

  Applying: mfd: wm8994: Switch to use dev_err_probe() helper
  error: corrupt patch at line 22
  error: could not build fake ancestor
  Patch failed at 0001 mfd: wm8994: Switch to use dev_err_probe() helper

Please fix and resubmit.

> diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
> index d5ac066f9db4..c43273527425 100644
> --- a/drivers/mfd/wm8994-core.c
> +++ b/drivers/mfd/wm8994-core.c
> @@ -378,10 +378,8 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
>  	 */
>  	ret = regulator_bulk_get(wm8994->dev, wm8994->num_supplies,
>  				 wm8994->supplies);
> -	if (ret != 0) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(wm8994->dev, "Failed to get supplies: %d\n",
> -				ret);
> +	if (ret != 0) {
> +		dev_err_probe(wm8994->dev, ret, "Failed to get supplies\n");
>  		goto err;
>  	}
> 
> -- 
> 2.25.1

-- 
Lee Jones [李琼斯]

