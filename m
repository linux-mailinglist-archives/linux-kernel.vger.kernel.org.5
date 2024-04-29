Return-Path: <linux-kernel+bounces-161664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C438B4F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE13EB21D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4807EB;
	Mon, 29 Apr 2024 01:19:09 +0000 (UTC)
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD57F;
	Mon, 29 Apr 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353548; cv=none; b=t2AUDE1KW4aZIX3py7FTrowlnCG6Fa20PZ7dh4dA5efjyn8vTAI3pjI5U9uQS7bX3BJ9QJR3SrR+x+ZTEIEOmkRMf8LW5eYwwMkp+2FpmSilQqbUeKNWGcYGdDqwJ8Pem4GtrG3pMBmqWNQBphcy9S3OOKQn6k6gJrLr1Hk2GqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353548; c=relaxed/simple;
	bh=CKS3du/7e+GPCqzNT8eSGOvRiJ/GyU/R+Cz7M5rCuiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8CZujzCRQKEV+Pbi+PR3ZUc5vyxrB5ykttw/yIIzkmUUYKkcZzd0LM2SQ1mB6UV1JHg6fdpRSrNS3DFA5TR5b2jbIbTUqDnZf0UlgZK3/5a0FK0GhukW+8N2Y3pkJAmQP3f/ztqlZfi1netBduOW8quFhJ/3qdD2wIen5tadEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 43T102D7008874
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 29 Apr 2024 10:30:03 +0930
Date: Mon, 29 Apr 2024 10:30:02 +0930
From: Jonathan Woithe <jwoithe@just42.net>
To: Szilard Fabian <szfabian@bluemarch.art>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH] platform/x86/fujitsu-laptop: Replace sprintf() with
 sysfs_emit()
Message-ID: <Zi7xEp5Gs4qtzB5p@marvin.atrad.com.au>
References: <20240428192548.113261-1-szfabian@bluemarch.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428192548.113261-1-szfabian@bluemarch.art>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Sun, Apr 28, 2024 at 07:26:33PM +0000, Szilard Fabian wrote:
> As suggested by Documentation/filesystems/sysfs.rst sysfs_emit() should be
> used when formatting the value to be returned to user space.
> 
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>

This seems entirely reasonable.

Acked-by: Jonathan Woithe <jwoithe@just42.net>

> ---
>  drivers/platform/x86/fujitsu-laptop.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 94480af49467..968fc91bd5e4 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -386,11 +386,11 @@ static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_LID))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_LID)
> -		return sprintf(buf, "open\n");
> +		return sysfs_emit(buf, "open\n");
>  	else
> -		return sprintf(buf, "closed\n");
> +		return sysfs_emit(buf, "closed\n");
>  }
>  
>  static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
> @@ -399,11 +399,11 @@ static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_DOCK))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_DOCK)
> -		return sprintf(buf, "docked\n");
> +		return sysfs_emit(buf, "docked\n");
>  	else
> -		return sprintf(buf, "undocked\n");
> +		return sysfs_emit(buf, "undocked\n");
>  }
>  
>  static ssize_t radios_show(struct device *dev, struct device_attribute *attr,
> @@ -412,11 +412,11 @@ static ssize_t radios_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_RFKILL))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_RFKILL)
> -		return sprintf(buf, "on\n");
> +		return sysfs_emit(buf, "on\n");
>  	else
> -		return sprintf(buf, "killed\n");
> +		return sysfs_emit(buf, "killed\n");
>  }
>  
>  static DEVICE_ATTR_RO(lid);
> -- 
> 2.44.0
> 
> 

