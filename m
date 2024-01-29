Return-Path: <linux-kernel+bounces-44213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335D841EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991C21F2B322
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1ED5A796;
	Tue, 30 Jan 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APd92PAP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382558AB8;
	Tue, 30 Jan 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605888; cv=none; b=R0fGWHniJodI2YSdwvsWOhF86ek48JUoBN+r+iMORYGk4ZZThCFC2zqNOX+gKF40E8TVALMHBTdph0xidprlcP7UhFO+xJmWf4SY641l3R//sNbvYz9gXX4pM7h/WPWfeYknnQNEBlsFzavzGMlyJ0fTgNnk9yIBnqvmmMsTa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605888; c=relaxed/simple;
	bh=+alcMqWzoqRZ7JJ8HhnU4GL4SH7uxxmtulwhpdyc7mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD+QtBzZP+SvJE5WDudIlNhoF6GLdBCXkgdkNMrBCB8q37Rt/XzMJNrWLrR1piERcOxgBxs1NyQHRtL+HQlaFEPGyPLjXgXF/f7qMI/Pm5yUz4N8CoCk/4KZ90T1hfK8bo5V5uJ47cnLGkh9DxHCfWVtN5s1DBt2q8BFlx2hEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APd92PAP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706605887; x=1738141887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+alcMqWzoqRZ7JJ8HhnU4GL4SH7uxxmtulwhpdyc7mE=;
  b=APd92PAP2Gw4u2Xh2liTbhLin/SU7To85sf0mIdPxMF1cHrzIb9Vovhm
   mAHNwGE034sC8OYBg0Xluu1yD+E/Mvxie4J9Y4SQPnvgVCkcSrWCMPZPJ
   72+0SGK59A1j2AKdhL6guvhBNbIhserkBc0jxqJdGJ5m5I6NKSr25jFny
   bSdukDJWOTa49qnhSH9pUfUPxsRMaKLzzbrU1zus79Ko6eKtg7ok47s2a
   UafIHYX/hNGnia174lyz+klwac4Gi/zekomgpY2Dk+xakQefE3l5/SnCS
   Xccy0T6e4n+2V8HY1fZ08HgqOjDyG3F/rna0DR6OFxRq4e8C/VlBoYUC4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3055992"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3055992"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:08:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931378672"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931378672"
Received: from vkamysba-mobl1.amr.corp.intel.com (HELO [10.254.116.178]) ([10.254.116.178])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:07:21 -0800
Message-ID: <fb5e670d-1814-4f96-96a0-ea14bdd551bf@linux.intel.com>
Date: Mon, 29 Jan 2024 18:10:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for
 MTL
Content-Language: en-US
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123113246.75539-1-mstrozek@opensource.cirrus.com>
 <Zbe0yi5Qo1eG5yCk@ediswmail9.ad.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zbe0yi5Qo1eG5yCk@ediswmail9.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 15:23, Charles Keepax wrote:
> On Tue, Jan 23, 2024 at 11:32:46AM +0000, Maciej Strozek wrote:
>> The layout is configured as:
>> - Link0: CS42L43 Jack and mics (2ch)
>> - Link2: 2x CS35L56 Speaker (amps 3 and 4, right)
>> - Link3: 2x CS35L56 Speaker (amps 1 and 2, left)
>>
>> Corresponding SOF topology:
>> https://github.com/thesofproject/sof/pull/8773
>>
>> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
>> ---
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


