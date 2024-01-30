Return-Path: <linux-kernel+bounces-44465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0B842267
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FEA1F245FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E01B664D5;
	Tue, 30 Jan 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoUzgfh9"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4E66B20;
	Tue, 30 Jan 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613176; cv=none; b=IRwttsR/wEoNlGkSdddJcgmHBOAm6lZhB+yBOsV9iKYTIUM4uTOl2Fup848hqeQ4A5PVcKvx2hNzXVGiZMLOf8xMquQ+lH1RHfXqgmbcMXs02XuzW/ZqXsr+RyH1cQ7dAtBXw7laUjQyezg/hRXwptduxhE+nsQVEtVgl0jCzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613176; c=relaxed/simple;
	bh=M0lpIKLgHsHcpNnO2aKdjqw9uhZZRpl1IB/C3sBX9co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPNZhvvftTEWEl1WmyD4vThAivgCkvIPthvCbw1DyG0nYw/I2zZ8o3CAuYTIZ/t13Q9zRq9TTYr9q5Bp4atpERLhZpqiT5S4WJBOigXthEmFpieb1yNYZ7WlyNX2crNSEOFpObUOya0QxOadl2EWzXpquXEoYT5E8B18K+pkguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoUzgfh9; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706613175; x=1738149175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M0lpIKLgHsHcpNnO2aKdjqw9uhZZRpl1IB/C3sBX9co=;
  b=KoUzgfh9n8A2B8Ev1opiuLvvxA/A14oG+L2zWA6sgDIJ2vgLrhO7lC7D
   t6Gf15bj/59NoFqmVCfG+7XxcmEAtmpiAYsuqdtoCKSai2iqYUzm1G7Lr
   sQ9wcOMnv4h5lmQF76647gGThtUoz00hEcyeTV0CvSPfTgGdmq2OQSaMq
   7t9n0aFvkdjUwVZz1QNsEEZ2JnhfJgS4c45Yp9kp5CxB8/rBwrCx+tD6w
   VtMRxJjDTpyBSJxpxd5G5fwYBKLrwzCfOWtGpnrUR7he862KhB5qZhq6K
   aU9ShgOZrjvYZubc7EBn4lsZOjN84Qn/WetcSLH+3Jm+neLBsJRmlKovz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467503953"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467503953"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29873042"
Received: from aravikum-mobl1.amr.corp.intel.com (HELO [10.209.88.191]) ([10.209.88.191])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:12:53 -0800
Message-ID: <11280dec-cf3d-1694-d837-2bf263ad148a@linux.intel.com>
Date: Tue, 30 Jan 2024 12:12:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 08/18] ASoC: cs35l56: Fix default SDW TX mixer registers
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
 tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20240129162737.497-1-rf@opensource.cirrus.com>
 <20240129162737.497-9-rf@opensource.cirrus.com>
 <4f54a12c-c8a3-414c-b4df-3f7b25e6d524@linux.intel.com>
 <a8432725-6dc6-4765-831f-178dcee8b829@opensource.cirrus.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <a8432725-6dc6-4765-831f-178dcee8b829@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> CS35L56 is designed for SDCA and a generic SDCA driver would
>>> know nothing about these chip-specific registers. So the
>>> firmware sets up the SDW TX mixer registers to whatever audio
>>> is relevant on a specific system.
>>>
>>> This means that the driver cannot assume the initial values
>>> of these registers. But Linux has ALSA controls to configure
>>> routing, so the registers can be patched to silicon default and
>>> the ALSA controls used to select what audio to feed back to the
>>> host capture path.
>>
>> humm, which has the precedence then?
>> a) the values set by firmware
>> b) the default values set by the driver?
>>
>> Also if the firmware touches those registers shouldn't they be marked as
>> 'volatile'?
>>
> 
> The firmware was designed to work with Windows, so it looks a bit
> strange if you are coming at it from ALSA. There's not really any
> defined 'precedence'. The firmware will setup the feedback monitor paths
> to something that satisfies SDCA and Windows expectations.
> 
> We don't care about that in Linux, the firmware on the Intel DSP
> probably isn't running the same algorithms for Linux, and we have ALSA
> controls to configure those paths. So we patch the mixers back to their
> silicon defaults and take over complete control of them.
> 
> The firmware only writes them during its power-up sequence so they
> will only change when we are rebooting the firmware or coming out of
> low-power standby, which is under the control of the driver. When that
> happens regmap will re-apply the patch and then sync up the registers
> again. The firmware won't touch them after boot, so we can avoid having
> to mark them volatile (which would mean implementing our own manual
> caching of the settings).

ok, thanks for the explanations.


