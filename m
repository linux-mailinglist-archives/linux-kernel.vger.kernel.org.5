Return-Path: <linux-kernel+bounces-162131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FC8B565B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BE0B24686
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E54502A;
	Mon, 29 Apr 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/4rIN+w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D540841
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389569; cv=none; b=A0IMd85HPnpzWF3y4jYT940LD3J8KMKpsGxS7IXnvHG3hWy1YoUouE++VpyiUEqTY+686dvByS6dxZk0N6pKuRIkYmyhEK+R0GwNpstuxA65pmE0A30vaLa+UFZk0VWKCGPnJf8F0vqYjX8MujwGzyP61FJyhVa2tfTvh8S3flI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389569; c=relaxed/simple;
	bh=uc8fZD0FgkiuFrmM+zTkY3EJ5uswfCLNhaUN7kiz+u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RHhjv4eBo1RCLqr9e81HGWbHe0w0Auh5wpe2Zd0ztzC7kuYTREyGE/NXLPJQIoVpTeqySdPggBAkELtPJsP/d3IexOMOtG5zJk4Cj0GGHh8118XSmqq3kMgRzDfwbFqTr24gbZlawKjmuzwFBQOE3XH+xya2CQi5jDVFqSj/V+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/4rIN+w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714389565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsGVa9o8qT3FtTk1JJcj3dSycDw3DJKarsMjnDP28I8=;
	b=M/4rIN+wG54I54JWue1ZA7O1sT5JzFbi4WvbOGZPiTmAOCaH2jj2ny/YPlV3Y5nAOorDtJ
	CPqqr7XOjWK8CXCyDpNlAi190dQ8Xb1LyW42amDFUknc9QTPEg9CCM7L2w2GEBQlOQuPHb
	by0/FwDyUdleKE0ojCHAZ5UX5CzrDos=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-TteJ0nSuOkGkCrweLyOh8g-1; Mon, 29 Apr 2024 07:19:23 -0400
X-MC-Unique: TteJ0nSuOkGkCrweLyOh8g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51d6630a5ebso925933e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389562; x=1714994362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsGVa9o8qT3FtTk1JJcj3dSycDw3DJKarsMjnDP28I8=;
        b=hYO34wd73PmVAvViSXiY2DEqp3lu1sdZzbtcSC6k9+yRC1KdmJoG+T3kl1tx+X1wNs
         1GG1cUfvOBwwyVDSyAZ9EknzLxWzJUGMcLbm5TAXJkYdm/G13sspmcH5Le9uDm69PpwJ
         qTZadZ4BA1XDj+NG4VyE90qHYgO6m2G2yKsK6gH0egbIBOjVtZFgNzT31bZ0dEPe3tV/
         l/mURQA66aOzbzjc9qHtXuvRFbWT4IyOJkWPRx/ZFfBp6Gsz/ayjop3WSEx9J/WVDjOd
         zks7nIcY0IAFSL7FJHH834McZhVdiRHJNkRN40/SF7t8kiyN9IuQukTpZOYAF5W7nZUI
         W3GA==
X-Forwarded-Encrypted: i=1; AJvYcCUpiljSck60Hx+UwFSTEJIEyWCImtno8+3PbCxej4Y95XuIC4K8tO/UQuYhcOtvKsTkcSU/tr829CcwxRO3lyJWB10YoAppRKfLvMPz
X-Gm-Message-State: AOJu0Yy849Oe0w5Y4e+43a0Pr8Ju0ag9GSfhO0dEGpTj0T3AAuNkGrbS
	Y5V3Y6+ypLcFv8MRqqTJixlyqS02lmdbmXKWtIL9nieI2vEcvE6oE3wX0YqmFtx5TnuAtmN/rRV
	zGm1ry2pNl0HO7JnEA3+rmV8dyaBwQJQsEiZdG+j2uZ/JRu0hF/sJxyZ7Sq0N8Q==
X-Received: by 2002:a05:6512:3c85:b0:51d:aaf7:a92e with SMTP id h5-20020a0565123c8500b0051daaf7a92emr2745775lfv.47.1714389562536;
        Mon, 29 Apr 2024 04:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpSLHvKn6jmPWI+pLiuUxLJGCFDpqAagPPX0NsOX65Cx6076zyc/jL3yxvYX8meFmeySxYGw==
X-Received: by 2002:a05:6512:3c85:b0:51d:aaf7:a92e with SMTP id h5-20020a0565123c8500b0051daaf7a92emr2745750lfv.47.1714389562123;
        Mon, 29 Apr 2024 04:19:22 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rn2-20020a170906d92200b00a55a67a81c8sm10284416ejb.126.2024.04.29.04.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:19:21 -0700 (PDT)
Message-ID: <f3d4eb47-7dd7-4d53-ac7f-3b3f442347da@redhat.com>
Date: Mon, 29 Apr 2024 13:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Show Lunar Lake S0ix blocker counter in PMC Core
To: Xi Pardee <xi.pardee@linux.intel.com>, irenic.rajneesh@gmail.com,
 david.e.box@intel.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/26/24 2:27 AM, Xi Pardee wrote:
> This patch series adds support to show S0ix blocker counter values
> in debugfs and enables it in Lunar Lake platforms.
> 
> Xi Pardee (3):
>   platform/x86:intel/pmc: Update LNL signal status map
>   platform/x86:intel/pmc: Add support to show S0ix blocker counter
>   platform/x86:intel/pmc: Enable S0ix blocker show in Lunar Lake

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>  drivers/platform/x86/intel/pmc/core.c |  38 +++
>  drivers/platform/x86/intel/pmc/core.h |   9 +
>  drivers/platform/x86/intel/pmc/lnl.c  | 475 ++++++++++++++------------
>  3 files changed, 311 insertions(+), 211 deletions(-)
> 


