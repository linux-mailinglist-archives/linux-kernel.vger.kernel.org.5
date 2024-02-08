Return-Path: <linux-kernel+bounces-58738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A884EAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382D41C21B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3034F5F2;
	Thu,  8 Feb 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Epw1u4gG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256184F1FA;
	Thu,  8 Feb 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428953; cv=none; b=EPTPEyUUdIq5BwSbQAQp8A1WCLRdzN5JzwFpwlEiDW6qPnKVVcSxniPqFl9YxVALXWo/6KPRZU/xEgzuOzfpvk5K6kPDXjeDSSoC16gIqR63B0v67Zg4hzCnt9xYrakExdGfWMGePPsPMH2LkiodH23B1dgZMGzGLKmbZYazWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428953; c=relaxed/simple;
	bh=W9H1dMPgPIL5i1UR+hwxooAFq6EmFfqz+7/zm6pmdQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWcNLucocmUeWRLP9VYe3gIErxFY1B0j2QTbZH3yfvrn2lSF9YDo7qYaLLBFvyr1MC/EwViP+2ud2K5ail9dEU1OOkMr+FLgUERfPJRCYpPOMB0OS5mUSjvpz05ns3TfmkbmunWt5v0McogeMUV0iWSmFc5PM+Ahr36KAHzLlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Epw1u4gG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707428951; x=1738964951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9H1dMPgPIL5i1UR+hwxooAFq6EmFfqz+7/zm6pmdQQ=;
  b=Epw1u4gGWLBr7Nd+OqgUYmFhoEYBpFrbFJczibMFYnLcAOiaSVXCCPqA
   WJBEdg5CHO/2G/gLuFu3fp/7RYS6mN8BpS8J02YulKyJSUPIYYTX7JhcT
   qBT4PgLFXUT6i49jg/uz5S9KTyWkatMFSdbH1yj3KKrdKn/5WWwgHoAjo
   5yFt76O2bzt4cgC0eNCrrkwuVOnY0YEBNF0fcvcMw5dGGXv/nxWq0Cxqb
   c6MmgF53ftbgXlfLL6wL1woTDE9svfz6T1ywd7JIORHHxqFwUgbN61Bva
   kB97HqhXN9DiAv/kbwnaObWOYksD4WIoZP+P6MdtM5YolHIhfH8iAqQu1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1212227"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1212227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6543608"
Received: from millermi-mobl1.amr.corp.intel.com (HELO [10.255.229.182]) ([10.255.229.182])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:49:09 -0800
Message-ID: <fa57daac-c59f-4d4a-a4bf-83cf584dc099@linux.intel.com>
Date: Thu, 8 Feb 2024 13:49:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] platform/x86/intel/sdsi: Set message size during
 writes
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>, netdev@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
 <20240201010747.471141-2-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240201010747.471141-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/31/24 5:07 PM, David E. Box wrote:
> New mailbox commands will support sending multi packet writes and updated
> firmware now requires that the message size be written for all commands
> along with the packet size. Since the driver doesn't perform writes larger
> than the packet size, set the message size to the same value.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/intel/sdsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 556e7c6dbb05..a70c071de6e2 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
>  		  FIELD_PREP(CTRL_SOM, 1) |
>  		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
>  		  FIELD_PREP(CTRL_READ_WRITE, 1) |
> +		  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
>  		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
>  	writeq(control, priv->control_addr);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


