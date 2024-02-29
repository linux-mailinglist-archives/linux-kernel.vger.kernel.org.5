Return-Path: <linux-kernel+bounces-86808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABC86CB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DC91F24518
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FBB1350EC;
	Thu, 29 Feb 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bni4TUGv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D612A177;
	Thu, 29 Feb 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216016; cv=none; b=nsv88/XW57MpGFf6w/1bM849kk+OgIWgsUhO2PlA2zFf5ZtE7roCNKCg/Us6WeWIynJM+rBUhgzc7owADaoqNGQpLP5hnHo/wHrvPR0eHkhJ8RZS60P1qyYta8fcmrNNf5KyZP0qrsOqjUhDnJJ2rcW8rb+zz0ldJICC1LK+k3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216016; c=relaxed/simple;
	bh=iCZdo/s1EV0f2wP+WPv++bHWWJIugZid5cGsPf+2lMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arHVp/4nX8Ovz4t2VRB9NuzwB/faNAblf4QwKlCetve+3D/mjchDDwQib9dhLQ/a6b1pqnfZeDPd3JsRK4QjqlqfVkkZXu6R1oO/Y8C8BuJvPeZXGTGYjZigzjbMy8fSiDILLOql11AAN26XJm5Jq7wWDtSuLeewfx3OWMkZo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bni4TUGv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709216015; x=1740752015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iCZdo/s1EV0f2wP+WPv++bHWWJIugZid5cGsPf+2lMo=;
  b=Bni4TUGvyXJHLmZa6MlnfpFXimgkjjf5J9IUkmuX60Z1zihoywd5RBsI
   LXYZ9Xu6+OHKsaGt8QX3Ha2jUzfcayPE1gIYOD2ogTDQRYR8hTfCyfVvs
   WhRtu/8QlPVN3GfW/9dG6G91/e+UlVhCVwd5Ye3tsp/igyCuFWdwZpzUY
   9URy8tmq/1RZeEU5PGJl9rsdu9d5pkGVPhsad6qWIGEd0mojakDrYmTLS
   1d4xWwqCW1ERyLe7rtbMQCGFuGoOXIJNXQfhzldoIXRuiWf4ZLDcOnsAi
   vuEIRj+3OHyQGyz555S4JvfK+Y3iZMYBFm36YR8PbVVI5bcnVT5WHoNiL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3609436"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3609436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937036000"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036000"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 06:13:32 -0800
Message-ID: <97824098-21a6-8dd9-8be5-e2a40debe0f8@linux.intel.com>
Date: Thu, 29 Feb 2024 16:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [v2] usb: xhci: Add error handling in xhci_map_urb_for_dma
Content-Language: en-US
To: Prashanth K <quic_prashk@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240228125724.1527491-1-quic_prashk@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240228125724.1527491-1-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.2.2024 14.57, Prashanth K wrote:
> Currently xhci_map_urb_for_dma() creates a temporary buffer
> and copies the SG list to the new linear buffer. But if the
> kzalloc_node() fails, then the following sg_pcopy_to_buffer()
> can lead to crash since it tries to memcpy to NULL pointer.
> So return -ENOMEM if kzalloc returns null pointer.
> 
> Cc: <stable@vger.kernel.org> # 5.11
> Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---

Thanks.

Added

-Mathias


