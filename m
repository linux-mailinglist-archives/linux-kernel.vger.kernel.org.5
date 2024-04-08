Return-Path: <linux-kernel+bounces-134881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708589B82E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102D1283939
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839123772;
	Mon,  8 Apr 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zah+m34p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A725761;
	Mon,  8 Apr 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560547; cv=none; b=E/6XX8mMqFckMHgAgWKw2mfLw0+HMoDJ4pnnfR6T0bpJUssMBb37wXPLKoTa7Im8BAn7SklA3f4sQHfVeOxVUL1icUmuwAhgRToAMRdUmZMt8AnjomQFZEPgbSmtyRLOVR3JdCjNiVoUFusmR7/g0a5g1D5AU38TlYicAcOWt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560547; c=relaxed/simple;
	bh=wfBI0w2ix2dYMyVPgP0IE0+1KgiAiSMym15kBzlE+OM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=ns4zDvQk/ePJsymgs2NMpfu/5LSEHaFR34Z2UqQhHwwnAlNLSOQKARo9vD6EZs47monumBF8Vpul80Krp9veP5JQ0TEVYDXjlmuX9v52VysR7wbIXK4YFvET8KBCglouhicCtgxMtOnAZ+PMWk2H9nEf9iz9HmbGW1UmhZ1V84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zah+m34p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712560545; x=1744096545;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=wfBI0w2ix2dYMyVPgP0IE0+1KgiAiSMym15kBzlE+OM=;
  b=Zah+m34p/0ICxFjDEMGmVBdCDOhXtOyhSmPqnJi38NF8H+FICffpw6tx
   oYfCnvPhLUz2Czxgoy5RCXn6BB4SDMO15im3iHJDgKENfFGrVp1x4e28F
   1jt/knTUCHeleBAnGhTVOLh+0GhtuLtowZRX6B+VV01tujhsXCsd4UwrP
   2b9MIvCHKuR92ekdR0dagSGWNb7hvK19tW1CNqxE239yoGS4ydVVO0T0d
   GnVpVQaQeQnisUzOkZwwrZ1+p/0BXAV2gsDlY0WlsAHUQtXZL7jnZwpFK
   fnCn2Bw+VNMF/z/oZ8EcNsC7JsIwWy+R3Hv3+LA5OnGo/ju4kt1ceycRa
   Q==;
X-CSE-ConnectionGUID: 12evUH+ASCW3LOwcH28DAw==
X-CSE-MsgGUID: xkvrBBI4TFeALn6BhJyMMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8007779"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8007779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="937090989"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="937090989"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 00:15:27 -0700
Message-ID: <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
Date: Mon, 8 Apr 2024 10:17:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Micha=c5=82_Pecio?= <michal.pecio@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
 <20240405113247.743e34b2@foxbook>
 <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
 <20240406183659.3daf4fa0@foxbook>
 <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
 <20240407142542.036fb02f@foxbook>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
 of current TD ep_index 1 comp_code 1
In-Reply-To: <20240407142542.036fb02f@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7.4.2024 15.25, Michał Pecio wrote:
> This (and the absence of any earlier errors on the endpoint) looks
> like the hardware may be confirming a "successful" transfer twice or
> the driver may be processing one such confirmation twice.

It's also possible this TD/TRB was cancelled due to the disconnect.
Could be that even if driver removes the TD from the list and cleans out the TRB
from the ring buffer (turns TRB to no-op) hardware may have read ahead and cached the TRB,
and process it anyway.

> 
> [   94.088594] usb 1-2: USB disconnect, device number 8
> [   94.089370] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 1 comp_code 1
> [   94.089403] xhci_hcd 0000:00:14.0: Looking for event-dma 00000001250310f0 trb-start 0000000125031100 trb-end 0000000125031100 seg-start 0000000125031000 seg-end 0000000125031ff0
> [   94.089427] xhci_hcd 0000:00:14.0: last xhci_td_cleanup: first_dma 1250310f0 last_dma 1250310f0 status -115 from finish_td
> 
> (I say "successful" but it really isn't - the device is no longer
> listening. But there is no delivery confirmation on isochronous OUT
> endpoints so the xHC doesn't suspect anything.)
> 
> Could you try again with this updated debug patch to get more info?

Would also be helpful to add xhci dynamic debug and xhci tracing (two separate logs)
These will show in detail everything that is going on.

Steps:

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
< Reproduce issue >
Send output of dmesg
Send content of /sys/kernel/debug/tracing/trace

please copy the /sys/kernel/debug/tracing/trace file somewhere as soon
as possible after reproducing the issue. It grows fast.

Thanks
Mathias


