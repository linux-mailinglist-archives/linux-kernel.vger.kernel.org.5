Return-Path: <linux-kernel+bounces-92322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A3871E71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488CC285215
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369A5A110;
	Tue,  5 Mar 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiA+knFa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AD5B200
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640045; cv=none; b=qJp8YVYDoQmFpkd0MZOYtJw77OZZILR8mtm11xEbf3ZeugmFsca1X/x3zeu73UsxAxlnu1z90PzgFHWaWDmwHPZ+4EUxFiHa4jrqz4Sc/vJs2ep/CgmV/Cw3jMl1+lAgWFVhJHU0kGGQaHijRpXaC1InzJiuYPvMkBnB6Hi1x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640045; c=relaxed/simple;
	bh=sRvqQdB8kRs9Wd4XZ5XIBXVpsTGVVIckK00iEDJ5uJQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l06IEnKWGbyew8JHpkGgOpMWuvtKwhvpqTcNxMxityrZspiDc3ZIa8GaZANxUERkjXZKkTS59wX0UR69OW55JXsgYe14aKpT7pLGaFGNK4CY0sqDXs657PtigBNmXBD6BaNoqICp4lEgZQCqkdfpxbG+nUHKPyYaSShaWeeXv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiA+knFa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709640043; x=1741176043;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sRvqQdB8kRs9Wd4XZ5XIBXVpsTGVVIckK00iEDJ5uJQ=;
  b=kiA+knFaFQeo1D8JIvnhBU3HlcFgU41T8vt7yBebA6/uKGztbDZE/0ZC
   a+fL71Igfk04Q9+nHk0JJdq7zR9XJhI/i+nZmhndCpVQuwg7+OTvBJ4EE
   eWwTuqUDn6vs4vPAb5+hm8TjUK2QtWJ1nq0rpiJwohMm8SlRSNV9cinn/
   sizESEMyze5yWOybm7cE7zvOezwpTnt21RIF4dfLipgNKYeNMaiiPf3N7
   d2qJoo4aRLBajHoxh6gC36PSATE3PeQOz/BWXrp1+6kz4Z0QPH2o+Wr4Z
   nobExL+px2ZorVcFN2mxaSXJW0dlYyZ50NNv+j4sCcaKTd4gtLRRDxcr2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4044098"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4044098"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9218674"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.205]) ([10.249.173.205])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:00:39 -0800
Message-ID: <65479314-39e8-432e-8b9f-daf6c4aea72a@linux.intel.com>
Date: Tue, 5 Mar 2024 20:00:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, dwmw2@infradead.org,
 will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
 dan.carpenter@linaro.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 0/3] fix vt-d hard lockup when hotplug ATS capable
 device
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 robin.murphy@arm.com, jgg@ziepe.ca
References: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/1 16:07, Ethan Zhao wrote:
> This patchset is used to fix vt-d hard lockup reported when surprise
> unplug ATS capable endpoint device connects to system via PCIe switch
> as following topology.
> 
>       +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
>       |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
>       |           +-00.2  Intel Corporation Ice Lake RAS
>       |           +-00.4  Intel Corporation Device 0b23
>       |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0
>                                             NVIDIA Corporation Device 2324
>       |                                           +-01.0-[19]----00.0
>                            Mellanox Technologies MT2910 Family [ConnectX-7]
> 
> User brought endpoint device 19:00.0's link down by flapping it's hotplug
> capable slot 17:01.0 link control register, as sequence DLLSC response,
> pciehp_ist() will unload device driver and power it off, durning device
> driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or
> 'ATS Invalidation' in PCIe spec) request issued to that link down device,
> thus a long time completion/timeout waiting in interrupt context causes
> continuous hard lockup warnning and system hang.
> 
> Other detail, see every patch commit log.
> 
> patch [1&2] were tested byyehaorong@bytedance.com  on stable v6.7-rc4.
> patch [1-3] passed compiling on stable v6.8-rc4 (Baolu's rbtree branch).

This series has been queued for iommu next.

Best regards,
baolu

