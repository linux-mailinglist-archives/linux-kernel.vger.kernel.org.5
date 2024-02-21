Return-Path: <linux-kernel+bounces-74937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5B85E03B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746781C22FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6C7FBC0;
	Wed, 21 Feb 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgWRcekg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8527FBA6;
	Wed, 21 Feb 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527033; cv=none; b=pp1ZAEr9VNdUTL2b57eDieK0l8ANbhWWGjEGmNFc5evJhYEZC3frSmO9eTxvcoi0scCXxFaa0o6Hma/EQD6X6/wBqtKgBCycWITRpEf3TIEdJgXzpiYYj8taibrd/4HAmriCl3Crlc1B0dUiZ6PR1575c41ono7070+WIc19enY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527033; c=relaxed/simple;
	bh=qbUVDRq1sTiEeH5NjYGofdTZsYOvTMvZCIFACRNBirg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhPVk14pU/6VK2kqZupepRJbD1I17qBVyVxZEpM9N6icT1Q38RIQ8QRqHuK+hR/TUXzK8y0Rrwpkbd8Y0fy6BvZK8RWJc7zpn//uODULckYUjN7SuVJTc4qKbN0RXSCBmaMR+ED8QpN2kIdHK543HCcl7fgs82eNNZCf9cwAcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgWRcekg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708527033; x=1740063033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qbUVDRq1sTiEeH5NjYGofdTZsYOvTMvZCIFACRNBirg=;
  b=IgWRcekgrfegu8A53FqRkEMFwzvcL+oH9PYZ2caqaed/7Ec4eXxl2vXD
   9Df0/4Xpg4jdh//r0i9eBHr4xj0lPcgvaoiyebfBC1u0UXw/gyl1vYk6S
   si+bl9yaXNONOE/OKbcyLu6jObt/uCWr+rq062WZETFrY6A1llfxQcn+y
   Q3pU9Z89rgkeoO8j49eXCrnkggiYUoNyvEjMKLATxkehuDB8NREchDj9Z
   zMvS1cfKjk9vsyRwDBRbjTnQhiWZbGr3HsRHQNDGV2BnT2FWz0pghpDs6
   +Iej4LMm+W1ovWhgF4ynj62B+vH/anr+LX6h1V2bFd7ZtgEc68Wkl3ywM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20124566"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="20124566"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5325538"
Received: from mkusiak-mobl1.ger.corp.intel.com (HELO [10.246.34.229]) ([10.246.34.229])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:50:29 -0800
Message-ID: <2b5daa31-af66-4297-932b-d2fd341b63e6@linux.intel.com>
Date: Wed, 21 Feb 2024 15:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: junxiao.bi@oracle.com, Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, regressions@lists.linux.dev, song@kernel.org,
 stable@vger.kernel.org
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
Content-Language: pl
From: Mateusz Kusiak <mateusz.kusiak@linux.intel.com>
In-Reply-To: <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.02.2024 00:15, junxiao.bi@oracle.com wrote:
>
> The thing is we can't reproduce this issue at all. If you can generate 
> a vmcore when the hung happened, then we can review which processes 
> are stuck.
>
Hi,
don't know if that be any of help, but I run below scenario with SATA 
and NVMe drives. For me, the issue is reproducible on NVMe drives only.

Scenario:
1. Create R5D3 with native metadata
     # mdadm -CR /dev/md/vol -l5 -n3 /dev/nvme[0-2]n1 --assume-clean
2. Create FS on the array
     # mkfs.ext4 /dev/md/vol -F
3. Remove single member drive via "--incremental --fail"
     # mdadm -If nvme0n1

The result is almost instant.

Thanks,
Mateusz

