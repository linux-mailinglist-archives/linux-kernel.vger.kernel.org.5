Return-Path: <linux-kernel+bounces-98540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD919877BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2720E281D30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735B11724;
	Mon, 11 Mar 2024 08:32:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023E8830
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145931; cv=none; b=n97l9rZORGzkRiPuytElxJbrMlhVtnE63IeJJ7jXBqXxR3mcWmyJZ89vcO7OZ9Z/A4OV2ne6PHLcOSPm4PLKUN/1Tq0AcAUIZRhAxJ07DGKM0eEuMbEAWbbBhYAFWRmyPedbxFCrzOmvWNsjsLjg+377Vm002GtwZjCeYS0GvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145931; c=relaxed/simple;
	bh=adlxxrwe/Ug7EKq0Ocr9zXe7YLn2kKjkKP4V2VhRkdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8CbZ8go5uHVxf+sJOmNIvc/lPS5FaRQPHOOSEGanPvysNDxUXQgEjhelWrWzc1x/e2tU/xb5PEARmDLXrriy9vbROOJdC5yij2j0Q2SxYjTlLwcSre10GkRfXlZjeqmJgOBMti+hqKSvoi/FUsDA5rKCE6+3riiBcULSiSI7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7EFFEC;
	Mon, 11 Mar 2024 01:32:43 -0700 (PDT)
Received: from [10.163.76.138] (unknown [10.163.76.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1069B3F762;
	Mon, 11 Mar 2024 01:32:04 -0700 (PDT)
Message-ID: <149881d7-f14d-4a63-9a65-f64788d42516@arm.com>
Date: Mon, 11 Mar 2024 14:02:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/arm/komeda: Fix komeda probe failing if there are
 no links in the secondary pipeline
Content-Language: en-US
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch
References: <20240219100915.192475-1-faiz.abbas@arm.com>
 <20240219100915.192475-2-faiz.abbas@arm.com>
 <ZehzHJonrS7dLSHn@e110455-lin.cambridge.arm.com>
From: Faiz Abbas <faiz.abbas@arm.com>
In-Reply-To: <ZehzHJonrS7dLSHn@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/6/24 7:13 PM, Liviu Dudau wrote:
> Hi Faiz,
>
> On Mon, Feb 19, 2024 at 03:39:13PM +0530, Faiz Abbas wrote:
>> Since commit f7936d6beda9 ("drm/arm/komeda: Remove component framework and
>> add a simple encoder"), the devm_drm_of_get_bridge() call happens
>> regardless of whether any remote nodes are available on the pipeline. Fix
>> this by moving the bridge attach to its own function and calling it
>> conditional on there being an output link.
>>
>> Fixes: f7936d6beda9 ("drm/arm/komeda: Remove component framework and add a simple encoder")
> I don't know what tree you're using, but the commit that you're quoting here is
> actually 4cfe5cc02e3f. I will fix it when I merge the patch.

Whoops. That would have been tough to fix. Thanks for catching it. I will be more careful in the future.

Thanks,

Faiz


