Return-Path: <linux-kernel+bounces-12531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180481F643
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16448282EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804F63CD;
	Thu, 28 Dec 2023 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPL99FjM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724163A8;
	Thu, 28 Dec 2023 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703755469; x=1735291469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0BnRPGjZ08Szibrn+c+3PaPkhu55oPawbz2u9zwgUAU=;
  b=SPL99FjMfJSlEk42JVfx4MRHUILI78BFRQU7ki0D9mw2x+2n/i2TxNSo
   gYkV/7oO5OgkNmUX2h9yBqEw9wSNnpK2lsjzVnjfJ1XVllRCcMs9pqJJH
   F0vJtpDDS1+nAw3EpCoH+213eRcE83ObswjPkhtk4CVcj9e9k4bOvefZp
   8BCMT8GTtU0SXoSq+N5C168KTxsbr3pJHwF+LNZcOJLSd1zs24JfMyfZr
   1DJ9Qs7TJho7RTCMLLX3x8D/DHlvRTl8GmarR73U4Jekw1tILuohN8Mxi
   WpWXIKAb+I1g3vbe9iIutwq2gFf5hGz4s2OqPN6m6ghO7GZ6Q1CuKVc/o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="9924249"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="9924249"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 01:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="771675446"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="771675446"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.129.232]) ([10.245.129.232])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 01:24:23 -0800
Message-ID: <02414651-df89-48cf-ac13-25f581f3e34f@linux.intel.com>
Date: Thu, 28 Dec 2023 11:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igc: Fix hicredit calculation
To: rodrigo.cadore@l-acoustics.com,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
 Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/2023 16:58, Rodrigo Cataldo via B4 Relay wrote:
> From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
> 
> According to the Intel Software Manual for I225, Section 7.5.2.7,
> hicredit should be multiplied by the constant link-rate value, 0x7736.
> 
> Currently, the old constant link-rate value, 0x7735, from the boards
> supported on igb are being used, most likely due to a copy'n'paste, as
> the rest of the logic is the same for both drivers.
> 
> Update hicredit accordingly.
> 
> Fixes: 1ab011b0bf07 ("igc: Add support for CBS offloading")
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
> ---
> This is a simple fix for the credit calculation on igc devices
> (i225/i226) to match the Intel software manual.
> 
> This is my first contribution to the Linux Kernel. Apologies for any
> mistakes and let me know if I improve anything.
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

