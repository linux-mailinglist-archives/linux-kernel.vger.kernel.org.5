Return-Path: <linux-kernel+bounces-80584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50C8669F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C44E1F22725
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E71BC4A;
	Mon, 26 Feb 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0hvMlj6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79282C95
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928175; cv=none; b=uPk/cd28C7rKZVuLLMhu0GiMiJuES9WCT9CtvR7j1L2jo0Mz/RzXiLA5+fLvEPoOXzLSc4vm2LdPgkGPojWVhNSAjruu532BPDCYjyUmQj02pSYwTOZ/UNAE8wRPPtkBVNEMLr3p5ZwKcbHEiiOznlmOSXFzqedidhgvngA5yaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928175; c=relaxed/simple;
	bh=6YR3K8NMuUzqh39Zc1JfQbYtft5iWJwFgxclWEU7HyY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uAXOdoHv+uw/oCqlegn2NKSB/eAe4ywe+dp3K3oaCjJxmxnF9wXp/gYOuFZSFGxGxyE9TaHSDIkwvdAxH70k11nyYZEeTm35e5RJkL2fDwFLz00ruyLlJGeMlJ6HmdCjcOh7vy8OvpOkTT+iSlFjzTZcRMxkXXr6JwhYT+sMbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0hvMlj6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708928173; x=1740464173;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6YR3K8NMuUzqh39Zc1JfQbYtft5iWJwFgxclWEU7HyY=;
  b=T0hvMlj6T+Ugjee45+wujCl2O/AHIWIAwozIf8XD3lZe8H8enf5XLTrt
   jUHjsE3t0zKNhTiDHDBZKlRV+B0a0tmD8e9wSLZ77f28ktdKyy8iL52Ea
   auV4dEzV+eEqtH4NLFCKwYLdRNpxWkuabi58hGG5M2rSVordb5k+VFOj4
   aRIVw0/XQrabruBHMNZ9Ci9P8sYv4AhCc0opzQsuGi4/I+qdSLFetm099
   gTIhRLXTwVJ7BjZH+g+pwlbIUI85JtfcOQAzm2xlIMo56abPpEFVutdss
   YrqeRZ3lhpd7USYZap+BhcBLkj662ipyJmXF3m2wLNUZLOkcJweZkoG8Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3738539"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3738539"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11130350"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2024 22:16:08 -0800
Message-ID: <0b30b737-65b3-415e-a3a6-d18393873e22@linux.intel.com>
Date: Mon, 26 Feb 2024 14:10:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PACTH v3] Documentation: iommu/vt-d: Add the document for Intel
 IOMMU debugfs
Content-Language: en-US
To: Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
 Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240207090742.23857-1-Jingqi.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240207090742.23857-1-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 5:07 PM, Jingqi Liu wrote:
> This document guides users to dump the Intel IOMMU internals by debugfs.
> 
> Signed-off-by: Jingqi Liu<Jingqi.liu@intel.com>
> ---
> Change log:
>   v3:
>    - Add this change log per Baolu's comments.
>   v2:http://lore.kernel.org/lkml/20240126064704.14292-1-Jingqi.liu@intel.com
>    - Remove the use of private data field according to VT-d specification
>      changes in v4.0.
>   v1:http://lore.kernel.org/lkml/20231220132519.11077-1-Jingqi.liu@intel.com
> ---
>   Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
>   1 file changed, 276 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu

I have queued this patch for v6.9.

Best regards,
baolu

