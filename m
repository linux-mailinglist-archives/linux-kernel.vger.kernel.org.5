Return-Path: <linux-kernel+bounces-125289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E2892384
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB52F1C21AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC93B2A6;
	Fri, 29 Mar 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6EIrmYL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FD39FEB;
	Fri, 29 Mar 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737845; cv=none; b=jvyiv3pNgt0izDJ9CWuvTf9bHpmcx/soBXtkmdJ0UPuCaFxZc1ASIyjFJ/xBHqD9gVcbffAnr4svtvzBBUqmiyx2zcrvY09SAQNh69EMNklnZHupP3meALKvKKBSzMifG1FM8PMAC4gvz+T8Bi60DHqYbbeUmYdzn/bsa6231x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737845; c=relaxed/simple;
	bh=ZCOrHPZQEY/ZxoW8xV3nSUzQw+HtbRBeSSDPIpMAlzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V24Nd2QTUkdHLHyjnMuduJWmrw6OHOxKTW5968eMpnbdLVx49PXSYeb3EO66IBATavx0k014Tz3lZiNFuLQ8Adw/gK5Wz/EegJunMntA8EbaV4IocbmBiA3qzcGbXWXkpmUixNjHGHHQuAYOZTPrjjkYEiSLkFzyLwN+7YeCxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6EIrmYL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711737844; x=1743273844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZCOrHPZQEY/ZxoW8xV3nSUzQw+HtbRBeSSDPIpMAlzY=;
  b=Q6EIrmYL41wfF4mXq8PvOI7wq2OhStNDCuxuAXeWYET1R0JR2rmy24i+
   I8U6XKuXM3gdxUpcMB+rJ3CESselHKX5gN2swxq6Bk+bLBG74agyLHY8Y
   ouLJ+Itk1NXrriZ0010BxGrI3YZX6mqM/Za3/brxqVpKn/DLh7jgWdNQi
   R6TtRymBM6F852l6d1IroiuNKsucFZALBFbQ+hG4RV21rUgbdSsf1luXj
   Fj5oSn3L+XT2Xfyjxb2v82Qh4jvayGh0P9Aj0P7UYCtdjAhoZUryzgAU6
   oGmC0BAbsvUTxr0QyY3L+UONjOPmR15Q577G4HXdlfNAVAzvkgBv8oRDr
   A==;
X-CSE-ConnectionGUID: npl/EPFrQJ6GrTP6UtKj2g==
X-CSE-MsgGUID: TReNy+fSRKK8ZMb73XKXBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6789481"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6789481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21506818"
Received: from hkannan-mobl.amr.corp.intel.com (HELO [10.209.48.27]) ([10.209.48.27])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:44:02 -0700
Message-ID: <dd57b239-6270-42be-ae74-5e364fa46aed@linux.intel.com>
Date: Fri, 29 Mar 2024 11:44:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 Kenneth Chan <kenneth.t.chan@gmail.com>
Cc: Len Brown <len.brown@intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Harald Welte <laforge@gnumonks.org>, Matthew Garrett <mjg@redhat.com>,
 Ivan Kapranov <i.kapranov@securitycode.ru>, lvc-project@linuxtesting.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
 <da442a04-9db8-4951-98b4-3e149ea06415@gmx.de>
 <9c4cfaf8-7738-4ba8-951e-5b91a3414f37@gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9c4cfaf8-7738-4ba8-951e-5b91a3414f37@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/29/24 1:20 AM, Maxim Korotkov wrote:
> Hi,
> On 29.03.2024 03:21, Armin Wolf wrote:
>>> Added a pointer check to ensure that it is valid
>>> before using it for pcc initialization.
>>
>> Hi,
>>
>> is this check even needed? I think the ACPI driver core takes care
>> of passing a valid ACPI device pointer to acpi_pcc_hotkey_remove().
>>
>> Thanks,
>> Armin Wolf
>
> I proceeded from the assumption that the current check was not redundant.
> Kuppuswamy correctly noted in the message that the device would most likely be valid for the function of removal.
>
> However, in my opinion, checking for NULL is a good coding practice, and has now been implemented incorrectly in this case.
>
> Eliminating NULL checks could potentially cause bugs in this context.

Usually such checks are added when dealing with input that can change dynamically (like user input).

Since, as per the current usage, there is no chance for this device to be NULL, I don't think we need it.

>
> Best regards, Max

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


