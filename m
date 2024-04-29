Return-Path: <linux-kernel+bounces-162393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF628B5A88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291861C21548
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17574E26;
	Mon, 29 Apr 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/KvCXXg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E838396;
	Mon, 29 Apr 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398667; cv=none; b=adxZkuDyTVHMZrIxAj71AZNP/YVeJpjw290x/tKPqPq2u/PHES0LGXB9zW/MsM0AnpnlbgvAZvSP9OpoW8PQzC64pYe7lBS01/2yt1z/M2XqOWk1kzovbIj7//9Vw1UjkzExnJ2Nz43wYx6/iuuD7blzh4VWONxDj2fOElbRos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398667; c=relaxed/simple;
	bh=SfcHmwJ9/qeOnlINiA2lp6iCE7NPd5EAtSbkcuF48oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNp/szrrb6Hhi8Fp0z2qBvEUf9k7pvoILNcvSAWh+21Cx/PBbfCtdNBvZnwrXf1gqH7Tkka01ZLK0pP4tHBgKdroNsv99ZMIukheRRiL1rAemHUaoWkJ0RU7HZ8XoTkYe1eIqdGTnZ1aOXwFN/ThW0o/zo/FSmXsD0+mYzEA3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/KvCXXg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714398666; x=1745934666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SfcHmwJ9/qeOnlINiA2lp6iCE7NPd5EAtSbkcuF48oU=;
  b=d/KvCXXgn1bxVo8E/u7aAky5RXSYghs3tMX3E3LcloFeFYRE2w575nzD
   2KTpJSVpNefpDcLU2a2FBh/baa1scVBoR9oUYYsGhshX58glU0Odz9LxD
   /sPzC8j0hJI3xz6XDn30W7NHnJONyRXb77UWvipvrvDAO64d8xCOsRKSQ
   8c54JpitntSWgxIqs7E8hFf939nnhwUsEc1Y4dLQi6Gf3Kk8FnFUSOMGg
   Ymy6Xbmh7sp17x/yrGiTzgsI0u2POKdJHy0cU011ojhECigA1Kfru1kxF
   PF0xRAHpizDVLnpLFA3WbPexDXst9ltqqks1TqDpftjFlm2io7Up+o4G+
   Q==;
X-CSE-ConnectionGUID: Q9gMaagBRGOaWMj6x1fDCw==
X-CSE-MsgGUID: T0X1xRoZTteH4U5I2Vxn0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="35451181"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="35451181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:51:05 -0700
X-CSE-ConnectionGUID: msfFMoLeQ4G5ddfShgcwpw==
X-CSE-MsgGUID: DBnAue/DRauazKeYDE7axw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30569070"
Received: from pingchan-mobl.amr.corp.intel.com (HELO [10.212.49.248]) ([10.212.49.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:51:04 -0700
Message-ID: <c0120da6-ac95-46c6-94d5-471f31e7c857@linux.intel.com>
Date: Mon, 29 Apr 2024 08:51:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Brady Norander <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Mark Hasemeyer <markhas@chromium.org>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
 <20240418110453.10efcb60@sal.lan>
 <848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
 <87edaopdlt.wl-tiwai@suse.de> <Zi-RpauZjcWg0t_q@smile.fi.intel.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zi-RpauZjcWg0t_q@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 07:25, Andy Shevchenko wrote:
> On Mon, Apr 29, 2024 at 02:17:34PM +0200, Takashi Iwai wrote:
>> On Thu, 18 Apr 2024 15:24:10 +0200,
>> Pierre-Louis Bossart wrote:
>>> On 4/18/24 05:04, Mauro Carvalho Chehab wrote:
> 
> ...
> 
>>> Andy, what do you think and what would be your recommendation?
>>
>> This one is still pending, and I'd like to hear the decision from
>> Intel people.  Let me know if this hack is acceptable.
> 
> IIRC it was resolved on GitHub by Pierre, anything else I need to contribute?

This initial patch was replaced by the one I sent on Friday
"[PATCH] ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection"

I should have made it clearer in the commit message, sorry.


