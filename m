Return-Path: <linux-kernel+bounces-163028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444D8B63DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667281C21A98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA41779B7;
	Mon, 29 Apr 2024 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HfiYmPro"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192E12880A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423849; cv=none; b=q7vlX9FEtKj4Fz0Evui/di4WpJIWqD+CsjUTUibxHiD+J5+JWoVGgt0Uk/PxI27BUVeeqiO7NQteQUgbZhVhFxZ23VAQPiVtjQw66eCEDgHbsuZx9x6vOr5Obm05lcie8Vp1IzseBt8f7J66pv6Ttf7NyOvSJlzSaq9anNf89MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423849; c=relaxed/simple;
	bh=oA3pNVMu3ph/x+3CP8Soo+EMFxQMfXRTtXuXeFRlJ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9741IZavkBmANHrptVtf/Th+GEwJYBERA4lm/LPosqoyRNhgU9Ij+fMBayCF47PzLQOl4ELWHMlCNN057sutCL9PTeaand9VdpdnfafbKF4SVVDP9jNFjXRRDc5RLFrFxjD7kGX5niWGB7mL1D3sPkJkSHIEFG51jWplG9Ys0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HfiYmPro; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 13:50:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714423844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dSYf8bDUi8CDapBoIgY0P+r9k4UykKnLksKFmnm038=;
	b=HfiYmProeO/sZmEHrB4CKisoeixgSvTPmYcvfJe4dW870G7ntgAfF0j2u5z1AHesg+1c26
	Ma9tHcWb7EjI9x73PI7tBT9cj1vrocdhAFmpng+NoqIgvzgH7PahSKRcoiRm+MTLMqOt7m
	J0fhD4o5ZJvmjsMwlbN0vgS5KqsgWSc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	hust-os-kernel-patches@googlegroups.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Replace simple_strtol() with kstrtoint()
Message-ID: <20240429205031.27tpfij7mlrt3a46@4VRSMR2-DT.corp.robot.car>
References: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 27, 2024 at 04:25:32AM +0800, Haoyang Liu wrote:
> simple_strtol() is obsolete, use kstrtoint() instead.
> 
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/base/firmware_loader/sysfs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
> index c9c93b47d9a5..4de1cb243bee 100644
> --- a/drivers/base/firmware_loader/sysfs.c
> +++ b/drivers/base/firmware_loader/sysfs.c
> @@ -47,8 +47,12 @@ static ssize_t timeout_show(const struct class *class, const struct class_attrib
>  static ssize_t timeout_store(const struct class *class, const struct class_attribute *attr,
>  			     const char *buf, size_t count)
>  {
> -	int tmp_loading_timeout = simple_strtol(buf, NULL, 10);
> +	int tmp_loading_timeout;
> +	int res;
>  
> +	res = kstrtoint(buf, 10, &tmp_loading_timeout);
> +	if (res < 0)
> +		return res;
>  	if (tmp_loading_timeout < 0)
>  		tmp_loading_timeout = 0;
>  
> @@ -157,8 +161,12 @@ static ssize_t firmware_loading_store(struct device *dev,
>  	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
>  	struct fw_priv *fw_priv;
>  	ssize_t written = count;
> -	int loading = simple_strtol(buf, NULL, 10);
> +	int loading;
> +	int res;
>  
> +	res = kstrtoint(buf, 10, &loading);
> +	if (res < 0)
> +		return res;
>  	mutex_lock(&fw_lock);
>  	fw_priv = fw_sysfs->fw_priv;
>  	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
> -- 
> 2.25.1
> 

