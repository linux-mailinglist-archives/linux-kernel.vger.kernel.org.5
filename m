Return-Path: <linux-kernel+bounces-145324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F38A52B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B316BB212AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED200745C0;
	Mon, 15 Apr 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDorWm6J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59507353F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190169; cv=none; b=ey58Y6MR6xNTszcnEDhFbvgeQRejz2hV4x+cwD9fh4ghwFSck8G8RjyP3xbhVqJk828Cs5HCfdpJN4koBtssEsX5HFFnkzwj6XtshnnyMahjn9u7d5oWjPDA08raNjEhVwnaTyr+VLq8nSqpX9Hl262jkQGE6J1cTUi9XK96Z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190169; c=relaxed/simple;
	bh=K9QbWezbtWYvGJPwTu4MnuX3yivJudEWc0TQrrbVKZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fls36b/ZXlexqSUX1osugvDLOxC5UWxwY/USs0y3Z6ZkZvq5r68p8mfyM+dMk0f0bfuRvCC6L7xjA4ZT2+K9X2soEO0Cr3WwYF1TJ/6Wn5jGISMFwsT0mcGwBSGJL94XcvXYf8TE0y4w7ueu/0rdl3J82l/jVTRT5Fgx1ZrTaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDorWm6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713190166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59OYK1dKNmJ+Wab1v4wRFM9PkaPOIoUi0FsclgE1vnw=;
	b=MDorWm6JhLwjXLao+0Z54NZm1Gzf2jXXdfXRN5En0Och12lVyqJlt7JHB9dlGuBNEimYK3
	BojBQ6LVRxQhDWduAjzkls1FfGqBDW3wWrHlbQ15S01Mkj+VR2PeZw5ZVcodPH+PySFZ89
	XbyeditBS3u2Cd7NifGVmsWhyoLoHhM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-GVznS1zxMCe9YHc5Td1saQ-1; Mon, 15 Apr 2024 10:09:24 -0400
X-MC-Unique: GVznS1zxMCe9YHc5Td1saQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-518cdf156fbso824256e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190162; x=1713794962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59OYK1dKNmJ+Wab1v4wRFM9PkaPOIoUi0FsclgE1vnw=;
        b=DdwCNkv/qzvb9RLvdzeE0qn6qR+V90KIE9l4wzcIMlz9KZT4JyM5n+qSy5UJ949M/j
         k17pts+lxJIuVeveHWOKAmhaaEQy2bIw4DGnOHIixAvxQvtl5K4vLOMJLD4hlXNyEzzs
         o53/ORllD1uLSwn3mQYWOfWHntMMkSnDa/iKaf65BG6mfUCf7YI8jYBlpePKQucykqdJ
         GYW2Z8mTD/e8U2SF9MmBpEVREoGqhm756if/y0PyP90nCNexj9veNVVk/Y9+2pEFsNQE
         2wLqzsN97QLGP5191b37yRfbgYIJZw4PA3Sc8481nTC8K1aWUuC1zUZ0E9gOYwxoSb8a
         IuXA==
X-Forwarded-Encrypted: i=1; AJvYcCU5wYWVZxyVsJyM0ZUjcVNIno9MWdCANkUDfQeo7snxPnq768sOJ4Vc7JV8yMktoiqF/Fe2f0cgSX5YU2+UXgrxcvO1vZNWAL6XDGIO
X-Gm-Message-State: AOJu0YwloybJUaxvTO4AglDHCKdV3B/US9uSLHgih+zcYX+RdbXCiz1d
	N5TZEvkRuKtwb7EGRMtEV+kaMfxzOWErlsKsLljanBAemoYtkJUliTuLk78vz+7+LFNQZ/RVsC0
	RZSbZBFT0WPOvy5b1QisGTQWW/fzJasB4YqsgBw/Rk/cMewZqYS05y+zBTeVF/hNd9vRYNm+s
X-Received: by 2002:a05:6512:15a9:b0:518:dc5b:6f5f with SMTP id bp41-20020a05651215a900b00518dc5b6f5fmr3519861lfb.15.1713190162564;
        Mon, 15 Apr 2024 07:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQBdaJCzssMbFDWYfjpDXeFVU3rFR4JfnHVug2GQ38jGI9pB/5b2x7pGjZ7zo9KD5SBaywUQ==
X-Received: by 2002:a05:6512:15a9:b0:518:dc5b:6f5f with SMTP id bp41-20020a05651215a900b00518dc5b6f5fmr3519837lfb.15.1713190162238;
        Mon, 15 Apr 2024 07:09:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lo17-20020a170906fa1100b00a466af74ef2sm5458053ejb.2.2024.04.15.07.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:09:21 -0700 (PDT)
Message-ID: <5bf08002-f1b5-46d7-be48-c81fde16906a@redhat.com>
Date: Mon, 15 Apr 2024 16:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/9] Intel On Demand changes
To: "David E. Box" <david.e.box@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240411025856.2782476-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/11/24 4:58 AM, David E. Box wrote:
> Adds driver and tool support for a new "current" meter that allows reading
> the most current, but not attested, value of the meter counters. Also adds
> fixes for the intel_sdsi tool.
> 
> David E. Box (8):
>   platform/x86/intel/sdsi: Set message size during writes
>   platform/x86/intel/sdsi: Combine read and write mailbox flows
>   platform/x86/intel/sdsi: Add attribute to read the current meter state
>   tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
>   tools/arch/x86/intel_sdsi: Fix meter_show display
>   tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
>   platform/x86/intel/sdsi: Simplify ascii printing
>   tools: intel_sdsi: Add current meter support

Note the subject prefixes of these last 2 are wrong and should
both have been "tools/arch/x86/intel_sdsi" I have fixed this
up while merging this series:

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> 
> Kuppuswamy Sathyanarayanan (1):
>   platform/x86/intel/sdsi: Add in-band BIOS lock support
> 
>  drivers/platform/x86/intel/sdsi.c      | 118 ++++++++++++++++---------
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 108 +++++++++++++---------
>  2 files changed, 144 insertions(+), 82 deletions(-)
> 
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095


