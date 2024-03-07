Return-Path: <linux-kernel+bounces-94987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876018747BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F3C1C21989
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E11BDE2;
	Thu,  7 Mar 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwbYADVn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1B800
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790541; cv=none; b=jlyE/TENX/pGHLMYRVlkOMkMJtDG4n02d3kPrvU4wy694R3GOoeNErkw7mnWyl1tdiFDNgoJHxmhnBN2HdEEN0qfERHn7Zw8Igm6Mn42VUb1krdVUjygmcBeGux5A4yArkfig1FbV/W3dHCGbr8lg1zwPjhZm8/tT1pKKXamdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790541; c=relaxed/simple;
	bh=NmtOM3FJyTFZ5u6Qv4SY9w3MCF+Id+mJl8TxUsvqVPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLs6mN4ogqATsq8Y5lDJ/JT1ZlFaSFIzkBXJ9eX2t7KCD5oIPJehYq27HsAbNp6FTsE9ZJbj63CAeDlHCTBrd0CHmlmKbrOI7oxnOksOm+99Xt6pRHuEujqvyOvt5Zl1B6qQjoNtdJam+ch0qhcyv53VbH+4epTPqDBMRPAGIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwbYADVn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709790540; x=1741326540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NmtOM3FJyTFZ5u6Qv4SY9w3MCF+Id+mJl8TxUsvqVPQ=;
  b=AwbYADVn05ljO0b+vDFyzQfVGptm+G/ZL6ExVmA1QlXFDUA5pfxWQ6yB
   RwB36ZS04HplhH2641osRHYKHg1eUjIFNtCZe8cZYD9ecpMmj6CMcpEld
   MnVVkHYup+Z8S4vwhw7zv6tdYpN6ElTFGmPC/UHeleyb03dH3+bg43815
   hVZi6tCIwHKOG1eVnEM0Q89YgTVV6mVGa+QRxzSFtdCr6uLbocjCJ+khe
   9HyfFGWEiT0J6NcqYGiTPZhzki8atKR3Tx8DU1lx2o96tt9IAD+7td8/I
   Xk9TS/IfRGmu5RCf0s5m2U6vO47NOxTk0P3AKGvoA/rmJJ5KLSXfnv16F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8261552"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="8261552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="10422377"
Received: from rulin.ccr.corp.intel.com (HELO [10.238.4.104]) ([10.238.4.104])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:48:56 -0800
Message-ID: <654d9312-85df-4f57-8151-1ad802d5201e@intel.com>
Date: Thu, 7 Mar 2024 13:48:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional change
 happened
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
 colin.king@intel.com, hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lstoakes@gmail.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, wangyang.guo@intel.com, zhiguo.zhou@intel.com,
 rulin.huang@intel.com
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com> <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <140860ab-59f2-4633-8a55-fb6cfa854250@intel.com>
 <Zek1ZVmCtddF7f3y@MiWiFi-R3L-srv>
From: "Huang, Rulin" <rulin.huang@intel.com>
In-Reply-To: <Zek1ZVmCtddF7f3y@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for your guiding and encouragement!

On 2024/3/7 11:32, Baoquan He wrote:
> On 03/07/24 at 11:01am, Huang, Rulin wrote:
>> We have made changes based on your latest suggestions.
>> 1.Removed bugs_on.
>> 2.Removed adjustion of macros.
>>
>> We submitted patch v8 based on this. Thanks to Baoquan for the
>> discussion, and could you please help to review and confirm if there are
>> any problems on the latest version?
> 
> Looks good to me, I don't want to exhaust a newcomer's enthusiasm and
> patience before you get used to this :-). Will ack, thanks for the
> awesome work.
> 

