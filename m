Return-Path: <linux-kernel+bounces-48551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6C845DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21031C2886A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327635242;
	Thu,  1 Feb 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6dK53CM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AD4C6C;
	Thu,  1 Feb 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806166; cv=none; b=MwXePXUTOkhgIhIXO3LJPxhgUYFT7DdHGMsE6j/+d9gtGg5WkQ/eInO655af5NF0YGfBEf6cV+KmyGV0aKAEpHm8f6sBAYw5H8Kq3ZhRuMcU3Qs3yrRWm6hzQKcZICAEO4uv312ugGa9zi/fUokFR59lIf5Pi2fwmnj3PeBQ/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806166; c=relaxed/simple;
	bh=iNwIgCxueiSubhh6aaDWCe0zkEEitgzyfnX3oZSXMHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhguefMTYe2JI42QoUQNvIanIvS/BUIUMiZItb3vnUBBxI7JzXEJA9Mo1qpyGUHINhsyEBB2FK1h8XDFVm+xq7+Z/qBJOqkLwS4qf0o2Bh9GWVA6if7laLwr3RtyyxVl0SSkzr+fqQDskrrPc/nKpmF2JOrYC1PN3Te1b8e6LRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6dK53CM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706806165; x=1738342165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNwIgCxueiSubhh6aaDWCe0zkEEitgzyfnX3oZSXMHw=;
  b=g6dK53CMcXhX7r7qO7MfyIcn9hjpP7fOoPtpyqySO20TeZ6kIqpVK3Y8
   unYTnGjf6271OrzHcTVaWvxahqAOLYaWLkVxaGcYc2mAthjcfHD9Phnvy
   Y2bDN9Dfv7cfe6zpPwRbrkHCJoFfRA2wlpyn/jOGxxckCjl7xQYwEBesM
   ThjlYqwPSTLpnHkwxAvmc4DNNWQIDfURw9oMhkW+6CeOKx6XwB4LKFdYc
   W2LZFotA3fpxKb6+vknNtP2A8dh7GsDbmhbb+gcI2XXjA9KS0JQo1wNDf
   NihB8k+NUTf3F/w8q+YOodjDUTbbpgbAIDZ+aq/Z07pW3lsuvyCN19Exg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11041377"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11041377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822962532"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="822962532"
Received: from cacasing-mobl1.amr.corp.intel.com (HELO [10.209.102.228]) ([10.209.102.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:49:23 -0800
Message-ID: <468e87a2-c50f-4146-8519-16b4317313e6@linux.intel.com>
Date: Thu, 1 Feb 2024 08:49:23 -0800
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

Can you include some spec reference to new mailbox commands?

What about updated firmware mean? Like a particular version?

> along with the packet size. Since the driver doesn't perform writes larger
> than the packet size, set the message size to the same value.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
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


