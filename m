Return-Path: <linux-kernel+bounces-39755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEF83D5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4A1C26309
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5C74E2D;
	Fri, 26 Jan 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIIJkC6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9B1BF29
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257134; cv=none; b=qVixFf54ts4p3E23aOSpVGOLiKvaf/YM1+mDz7dCjac/c5YQ9JzuwJTko1w8KXqk6MbQ/wlUK5CiHkxHKIiBrapoPBhwkOHIKSLamKCJx4mzxO2BlXb4yO/1M1E6C7MX51RpOc4wyZm4vEUn62/YtqphQx698NcvqnLEDq5Jmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257134; c=relaxed/simple;
	bh=0cBNOD+N57fuoS2i/Us0tGku1g2RRfTv8uymhAwQcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHly7XDY0+6QPJ2D3G3cxlod80eKfCLuU0j6Od0i8FegofzaiycY2/WvA2SjTXCpLnl/iuLK7RUrZOxDqX5IpuHkBudYlgpbEbevdrhqbps8NUBDJRlbjK8Rc4SC0IYwxqvUErkP9yGUqe6rV56m2dHVN0HMhNAsp5RSGKEKgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIIJkC6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07228C433C7;
	Fri, 26 Jan 2024 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706257134;
	bh=0cBNOD+N57fuoS2i/Us0tGku1g2RRfTv8uymhAwQcwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIIJkC6igqbtk5IK1szVD/znFbk0Rlxyh2X18O/mbq4ElwmMqcv9KvQbqE6jq4eTQ
	 F0JI/w7lev2EtxW7pna5IbUXKMAbdAl4HHEhoZIS1aSkOt4WWqNKLBCziYz9PL2NBl
	 zS+5FMHfyR1Y/iWcrixFOO4V/x4uZiOPe9ucGRlZYdcngpTvWjjGTSdxDa2md/9QL4
	 K3bplki90blzV5vCouu9QXSKs//W4iwMKSj+Jqsr/7bVnckS66OFi3mT8kI14300PK
	 0VdWWz4tGL5zz9M+VwbTQIEF6TO8w1Ohuv9TvKW+Y0HnJgudNe4DioR3IKqj4rwC9S
	 6rxaXLCXlumNQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTHQU-000000002rv-48Qc;
	Fri, 26 Jan 2024 09:19:03 +0100
Date: Fri, 26 Jan 2024 09:19:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Vamshi Gajjela <vamshigajjela@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH v1 RESEND] spmi: hisi-spmi-controller: Fix kernel panic
 on rmmod
Message-ID: <ZbNq9q5mM6kRq7c3@hovoldconsulting.com>
References: <20240126061153.2883199-1-vamshigajjela@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126061153.2883199-1-vamshigajjela@google.com>

On Fri, Jan 26, 2024 at 11:41:53AM +0530, Vamshi Gajjela wrote:
> Ensure consistency in spmi_controller pointers between
> spmi_controller_remove/put and driver spmi_del_controller functions.
> The former requires a pointer to struct spmi_controller, while the
> latter passes a pointer of struct spmi_controller_dev, leading to a
> "Null pointer exception".
> 
> 'nr' member of struct spmi_controller, which serves as an identifier
> for the controller/bus. This value is assigned a dynamic ID in
> spmi_controller_alloc, and overriding it from the driver results in an
> ida_free error "ida_free called for id=xx which is not allocated".

No Fixes tag?

> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> ---
>  drivers/spmi/hisi-spmi-controller.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
> index 9cbd473487cb..af51ffe24072 100644
> --- a/drivers/spmi/hisi-spmi-controller.c
> +++ b/drivers/spmi/hisi-spmi-controller.c
> @@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&spmi_controller->lock);
>  
> -	ctrl->nr = spmi_controller->channel;
>  	ctrl->dev.parent = pdev->dev.parent;
>  	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
>  
> @@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platform_device *pdev)
>  
>  static void spmi_del_controller(struct platform_device *pdev)

This function does not exist in mainline so presumably this is some bug
you've introduced in your downstream driver that you're trying to fix.

So this patch looks all bogus.

>  {
> -	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
> +	struct spmi_controller_dev *spmi_controller = platform_get_drvdata(pdev);
> +	struct spmi_controller *ctrl = spmi_controller->controller;
>  
>  	spmi_controller_remove(ctrl);
>  	spmi_controller_put(ctrl);

Johan

