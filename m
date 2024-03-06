Return-Path: <linux-kernel+bounces-93515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3358730E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0651C21CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432645D8FA;
	Wed,  6 Mar 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYIh9gPa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A255D730;
	Wed,  6 Mar 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714322; cv=none; b=gaEif7Cm0nVA0BX+NXq7nJp5xCWvtn0apKxulVLDruFRZ9aZwiEZn6KUAtwpTPD7je4iaZbgLESli1nbnjQVqQy4mVsCB3nIE/KRFh88IUg1D8Kabk1LPLOOwF9ticgOD12FOyV9P2zHH6QkvQSQtCY6pfK9ALnx+0mssVp+SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714322; c=relaxed/simple;
	bh=L6Cn4uTVTBHKqlz1yW8rNDu318FD8WsCh6wVNeDEbwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py43/CT1vw3kQUJPZ1qpxj7crDRCjN6DJVC/gcqT/b215nkwI7YNjlRwFXdQgSe7UgvpzKRzyQr0GAgpJcNOkJnJjLRWX8uaYoUqwYAPbgh4mRi5hs/z1NftPUHe5enGUe/qq7Jkc7xK5AJug3+x1QTa5+m5ri0O9JN4ZTUGDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYIh9gPa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709714321; x=1741250321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L6Cn4uTVTBHKqlz1yW8rNDu318FD8WsCh6wVNeDEbwk=;
  b=MYIh9gPa+lsUr9CMkOtLvXf2zJRusP9o/CxLdSbrkexdFrPSxntY4rM6
   6PP94mIcTQFklmtQ6foJY1K1y1NJHCmCEOv+Rpkj17ZHHpcyaRWq5lfry
   G9I1nfs5JYsQxV8Zq+xIsmfKOQ/9WhZr3CMYR8Zd/BxHgRAgnBSnouRNu
   MeAog+Q4B5qnyd6d257cR9cBoSQeiyTUq4E0EgsBVP11AhKRlYEbDulA6
   Y7iEEVxS/QnnaSUMMmvxisbIdd39ncRj0U5EabLWLl6yycjq+dwrC4+vh
   njn9QXdTguyvom7O9bkR3HUeJ5bpowj/l7oKiyF3wK9XaryTwT+4vOvO+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21837365"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21837365"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="47210936"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215]) ([10.12.48.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:38:36 -0800
Message-ID: <3d984c02-0154-4c72-92ee-16fa34d4b537@linux.intel.com>
Date: Wed, 6 Mar 2024 10:38:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-net v2 1/2] igc: Fix missing time sync
 events
Content-Language: en-US
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: sasha.neftin@intel.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 kurt@linutronix.de, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 anthony.l.nguyen@intel.com, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240220235712.241552-1-vinicius.gomes@intel.com>
 <20240220235712.241552-2-vinicius.gomes@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240220235712.241552-2-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/2024 01:57, Vinicius Costa Gomes wrote:
> Fix "double" clearing of interrupts, which can cause external events
> or timestamps to be missed.
> 
> The IGC_TSIRC Time Sync Interrupt Cause register can be cleared in two
> ways, by either reading it or by writing '1' into the specific cause
> bit. This is documented in section 8.16.1.
> 
> The following flow was used:
>   1. read IGC_TSIRC into 'tsicr';
>   2. handle the interrupts present in 'tsirc' and mark them in 'ack';
>   3. write 'ack' into IGC_TSICR;
> 
> As both (1) and (3) will clear the interrupt cause, if the same
> interrupt happens again between (1) and (3) it will be ignored,
> causing events to be missed.
> 
> Remove the extra clear in (3).
> 
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

