Return-Path: <linux-kernel+bounces-117279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1588A98E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B4E2A40BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2F16EC1A;
	Mon, 25 Mar 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alp/n1IY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C854224DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377768; cv=none; b=ugEDlhi+X7GNluzEmX/spZ9URkoVwF9cVPTLEsjlhj8OGG3uqLCOYCGCfnUscpHfkY1cQy3la3UDQsxdKCv42wm8TTlG2UQECAul2MIgmaJ7G0G5f8Fex1r1rhypYLbolkEvfN4XvXuHVz4znxGI9a3ujgWmg+aqMv9+aexJ2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377768; c=relaxed/simple;
	bh=mA/+DxCC3ihFJ1zYlS33xrreGKwqQ4RqaLfQBqH+EWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZA1xtd6aY7uQ3y0SZXcLtwgzmsGG69PHV2ejEVn167M/Cg+hFqJl03p7+6X4r0MPP20AubHsI12nR3bhIYpyXFjdBYA4KtMb4QZHuN1rsfVt++ukXMx2NqeT+PWMZma6m6Y2gT60ZbZ4xOWf4SA7GRpCK/3DS7noMog1d3G4bCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alp/n1IY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711377764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6IrLlIE3Da2db17jeCkesXkCWvY/kCb5MtDYcPSqDA=;
	b=alp/n1IYZGRPYcdQJtAt2jEZHLtKiMltENtXKFW2Kf5gEeJJ83uNwpKYNULawO2LDa88Ry
	3yPHyLkI0vPqOpf0nFQxWyfTgPwV82gvZuynykiuPhR+CYqED1uTBwMLr38z4s85akJEDD
	nInil1O2xNd5RKMHLZTORmcAjOCQLVg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-ThOugWVyPAylvimIznhmWg-1; Mon, 25 Mar 2024 10:42:42 -0400
X-MC-Unique: ThOugWVyPAylvimIznhmWg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5158aed7076so3774133e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377760; x=1711982560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6IrLlIE3Da2db17jeCkesXkCWvY/kCb5MtDYcPSqDA=;
        b=WOYP9LGOLEfRBDZ8lo3OX5Uor1WX3+7cAcJH9TwnM3cTsS+FRzA+zKoYKxmzjsZVJL
         z4zTe0nV4k5BNkH6bH+9e3vQPr3jPWB78JOaxMOnQoruALiZSX3ggtmae4e3oKjVp7+4
         IxjntRnAWKrihVQTHhatycHMEM5/ALHIyo35RMMoY6wEor+nwPEqOXNFQPjSlLHip6f0
         +k2nCAw96w3CygwGUYy+YeSDxKI17HX5EK5Zypm16MLyux1rNfEbmFUjh83q1PeNyQxv
         5/luxtCBd+XjBeisG6FmK53Ex7TGa5z2lCeFiICZj3Ic1zWWy7n2XI9oNga5f9eor4UD
         SXVA==
X-Forwarded-Encrypted: i=1; AJvYcCXBZXw7fT8mPQLstybA66KX78wg/r55v9wmxo7DeKM42zjpq2EjUaUwq5UZ5v3YY6doxCa7qvTchqsrvroK9qy46WjfdTxbYZGczP2T
X-Gm-Message-State: AOJu0Yxh+vYrp+g0D+QFMRtZv4Uu0nZZchmKqTJ6qyXqQuq/aTzHecE+
	iyGV8x9UW3+QWqcXk35EZkwHoFAXrloXZWuTfLfNXNU8eyRHDBFBD+Ji9XRCGeAifH9qjGBDGeC
	VL6yzNOCR4533Tj4R+ijC4MbJppXzbkS3suVdA3od1nh3Zi/xSrSRHIMY5hNsdkgtTYUrPQ==
X-Received: by 2002:a05:6512:29b:b0:515:afa8:ae7 with SMTP id j27-20020a056512029b00b00515afa80ae7mr1101739lfp.31.1711377760330;
        Mon, 25 Mar 2024 07:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG5RBNgmHdsXz6C+hHNh4VMkcoaC1us5TFtqUbGOGEuu51671qBAGuaYZzesHPmPltIhJ2tw==
X-Received: by 2002:a05:6512:29b:b0:515:afa8:ae7 with SMTP id j27-20020a056512029b00b00515afa80ae7mr1101724lfp.31.1711377759916;
        Mon, 25 Mar 2024 07:42:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402320700b0056c0996bf72sm1794239eda.83.2024.03.25.07.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:42:39 -0700 (PDT)
Message-ID: <7d7c3357-48a1-4479-9365-19fb3e9ddf0a@redhat.com>
Date: Mon, 25 Mar 2024 15:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86: huawei-wmi: use sysfs_emit() instead of
 sprintf()
Content-Language: en-US, nl
To: Ai Chao <aichao@kylinos.cn>, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240319064243.297320-1-aichao@kylinos.cn>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240319064243.297320-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/24 7:42 AM, Ai Chao wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/huawei-wmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index dde139c69945..09d476dd832e 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -379,7 +379,7 @@ static ssize_t charge_control_start_threshold_show(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	return sprintf(buf, "%d\n", start);
> +	return sysfs_emit(buf, "%d\n", start);
>  }
>  
>  static ssize_t charge_control_end_threshold_show(struct device *dev,
> @@ -392,7 +392,7 @@ static ssize_t charge_control_end_threshold_show(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	return sprintf(buf, "%d\n", end);
> +	return sysfs_emit(buf, "%d\n", end);
>  }
>  
>  static ssize_t charge_control_thresholds_show(struct device *dev,
> @@ -405,7 +405,7 @@ static ssize_t charge_control_thresholds_show(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	return sprintf(buf, "%d %d\n", start, end);
> +	return sysfs_emit(buf, "%d %d\n", start, end);
>  }
>  
>  static ssize_t charge_control_start_threshold_store(struct device *dev,
> @@ -562,7 +562,7 @@ static ssize_t fn_lock_state_show(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	return sprintf(buf, "%d\n", on);
> +	return sysfs_emit(buf, "%d\n", on);
>  }
>  
>  static ssize_t fn_lock_state_store(struct device *dev,


