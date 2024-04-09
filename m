Return-Path: <linux-kernel+bounces-136737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B156E89D7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BC71C21090
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E586269;
	Tue,  9 Apr 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUOi5ZuL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D18563F;
	Tue,  9 Apr 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661626; cv=none; b=athfG+dH3wg1bli2Z60zKT9OvbgMTatjzcQkFp66JddfEw12AxFQwoh7PrztwbIQFtvJRYegXPG3776izvdx7DEmODS8UDdmBqnOztWwc385njzx+5EivzWvJEKE6DTKz9UCgtyRZJgqGLMaPz436TXN5arZacHMNKon0zwooTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661626; c=relaxed/simple;
	bh=91UpDteffSdyg8FH2DDrKcFH4H9dq42CgEub79FQGEY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Mmauo0KfPCTiHZ/WWWqDtGPWwBcObEEZYxs64LtgRS1uK1OXhWbXr0JluvHXZbDlf61/wXFT3p9CTBvQ4GF9EX/S/DikV4I2Xi/z+obZq+g7HQQUnSVOXBtnrEcrbQ7ifOXvXTLN/X2qiYK0hD54/H4e21TxVLTikeCTOWINUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUOi5ZuL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712661624; x=1744197624;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=91UpDteffSdyg8FH2DDrKcFH4H9dq42CgEub79FQGEY=;
  b=ZUOi5ZuL7V0m+96U0jJxW5EoFdSD4A0zSN8bIcK+uAwnjpTmCPp3Fyit
   FxCq3wxoWMC9prDfz22/gZIOFciCyzwQQbsf2dHkT0+5m1HNnSjbDuL8t
   qza8zhx01+mzLY/LxNwmcathOmfDw5Hzb7/GBqOkxodOEyou7fM562vRw
   ESMiFDWyRBHvshh9LRaohHiMiVAL5JaL1P6+ICX+E39sy4CwFB4cBetu4
   SWYrtHUITIFyOjU8uqJNHVGiB2C/LhIxRrGG9lxA4uztq4Ytl4fdatU4U
   xMHjtZ6kgJ48dfNqAYqoW6a/sGs8VTTe6d05BXqbok+iwucnIyILJU83L
   Q==;
X-CSE-ConnectionGUID: 9UELNt9pTj+mzcWUP0U9tA==
X-CSE-MsgGUID: rcuY2B98THaNTR3YGD6EWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8127095"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8127095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093297"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093297"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 04:20:21 -0700
Message-ID: <82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
Date: Tue, 9 Apr 2024 14:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Micha=c5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Mathias Nyman <mathias.nyman@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
 <20240405113247.743e34b2@foxbook>
 <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
 <20240406183659.3daf4fa0@foxbook>
 <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
 <20240407142542.036fb02f@foxbook>
 <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
 <20240408210541.771253ff@foxbook>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
 of current TD ep_index 1 comp_code 1
In-Reply-To: <20240408210541.771253ff@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8.4.2024 22.05, Michał Pecio wrote:
>> It's also possible this TD/TRB was cancelled due to the disconnect.
>> Could be that even if driver removes the TD from the list and cleans
>> out the TRB from the ring buffer (turns TRB to no-op) hardware may
>> have read ahead and cached the TRB, and process it anyway.
> 
> I thought about it, but my debug patch says that the missing TD was
> freed by finish_td(), which is called on TDs considered completed by
> hardware. A cancelled TD would show giveback_invalidated_tds().
> 
> 
> Anyway, we now have new information from the reporter. My v2 patch
> keeps a log of the last five events processed on each transfer ring
> and dumps the log on TRB mismatch errors.
> 
> Unfortunately, it looks like the host controller is broken and signals
> completion of those transfers twice. The log below shows two distinct
> events for TRB 32959a1c0 and that the coresponding TD has just been
> freed by finish_td().

The trace confirms this, we get double completion events for several Isoc TRBs.
These double completions are seen after a transaction error on the same device (different endpoint).

Transfer events for TRB ..a1c0 twice, with a transaction error in between:
  <idle>-0       [000] d.h2. 33819.709897: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
  <idle>-0       [000] d.h2. 33819.709904: xhci_handle_event: EVENT: TRB 000000041547d010 status 'USB Transaction Error' len 4 slot 6 ep 15 type 'Transfer Event' flags e:c
  systemd-journal-395     [000] d.H1. 33819.711886: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c

Transfer events for TRB ..a1d0 twice (the next TRB)
  systemd-journal-395     [000] d.H1. 33819.712001: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
  systemd-journal-395     [000] d.H1. 33819.712059: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c

Transfer events for TRB ..a1e0 twice
  systemd-journal-395     [000] d.H1. 33819.712139: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
  systemd-journal-395     [000] d.h1. 33819.712871: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c

etc..

Driver can cope with these extra events, but if this is common we should
probably handle it silently and not concern users with that ERROR message.

We are actually at the moment looking at improving handle_tx_event() with
Niklas (cc), and will take this into consideration.

Thanks
Mathias

