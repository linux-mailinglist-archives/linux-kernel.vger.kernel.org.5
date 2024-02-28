Return-Path: <linux-kernel+bounces-84420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222986A699
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ACF287C87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574F1C2BC;
	Wed, 28 Feb 2024 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc6QfN4V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588A36F;
	Wed, 28 Feb 2024 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087654; cv=none; b=GQhclDmp1br1LO6EvKgUGNUhUERfS2zc/pnQODvH0ban7a+74+uXm4oTEBNflj8W6Q3uqsEvHgOCxbNAyp0yo4qKm7C0eEB/yUSTpzOE50ImLgoF5hR3LfJXX/kvgdWaYTIEwvN+LPBRIgKpgLaRUnHYTcjSQX5swST41eEfDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087654; c=relaxed/simple;
	bh=IDdzOE4h2Jcy3KcQIL5z1ZTCpLdPiIyPM1FOw8I43M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IsNHOgfOIxmQjjfD8ODYby5CAfhn4r/0rlIaS13z7LCGdOQlYDyb5S//oFUjCMgYv4Dmr0qwIUZc9P4ahvdQLYvJWLA/DONswUw3wG23L82uLsNqojKJPLCCyMlm1zL6Rg/yQX7u5sshn0AIS4QbqyzYFEljQbNCzesifTya6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc6QfN4V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709087652; x=1740623652;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IDdzOE4h2Jcy3KcQIL5z1ZTCpLdPiIyPM1FOw8I43M8=;
  b=Tc6QfN4VqMkjreoS9p7k5YAUUR/LLaBHlp+7wjF0jHOUPqyT9x2EQUkD
   fhB+p15XgJIbDApITpa1By71DEkD8gDSGz/Njf0QDJgWy13p7cVGqxLq1
   UesVh6pNDUQaLZ2/YfqWp8KkukyIldUKMt/Wirf5d6PM0RAmkMBYd6/Xd
   aHW389QNn0wLY6KuHwsNNwljfw+UtwnJT4bYQ8IIP/h4dXLhpf3VxH92W
   E5L61ntvXHmCLvsutJlVQ58u7ViXkEcEdP+es3rdUP2hDQ6z9Hgr+laGq
   lz7v8bLJgais96MYeaWHR/alD+0fGv817d8UtYkAVI9bDmHSIo/5PffMz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3630424"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3630424"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="38300690"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:34:08 -0800
Message-ID: <47f6e2a1-5b78-456d-a5c2-87421162b4dc@linux.intel.com>
Date: Tue, 27 Feb 2024 18:34:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/9] platform/x86/intel/sdsi: Set message size during
 writes
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-2-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/27/24 4:00 PM, David E. Box wrote:
> New mailbox commands will support sending multi packet writes and updated
> firmware now requires that the message size be written for all commands
> along with the packet size. Since the driver doesn't perform writes larger
> than the packet size, set the message size to the same value.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> V2 - no changes
>
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


