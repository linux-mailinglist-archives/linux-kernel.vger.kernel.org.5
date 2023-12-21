Return-Path: <linux-kernel+bounces-7873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E611A81AE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E75B2307C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A8B647;
	Thu, 21 Dec 2023 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqwjj4oX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A16BA2F;
	Thu, 21 Dec 2023 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703138235; x=1734674235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q7xMvSItx2ksMDOvKsjxR17eYh2ozzldS7CGKU1ltVs=;
  b=Dqwjj4oXQwpPfjXSAYH/mC3l8UeWBSGFEuk8vXPco+nOwtIUmZPNoi9C
   k18pXjWyFAQS+527ajOvC7UZN1cKORbcB28d2XBCqdjFbC6DG/GSlEhhH
   +dq1Qh9SBZVi2iYFLD3q2iQHmGelG3XNySL+EdQhDEWMOfTqlvOCL/ktt
   0kCmiEv/zNBFvgoWnJBuCRs1vPp0UmT+/1egP/dVLOYx+7dyaENFXgX1c
   /iARRYLmVQjSkFcoNIB1PjzkPL90K+6tkbhV1uEMN8VmkAtLi/MFEg1Nl
   ZN3a7msBy95dBnvvICmCP51r1THr0xcN+2hw0JW7S9imSNf24dG5phyjm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="394816071"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394816071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 21:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="24848961"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.215.242.241]) ([10.215.242.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 21:57:11 -0800
Message-ID: <173386ab-d0d3-4563-b1be-c06108506a82@linux.intel.com>
Date: Thu, 21 Dec 2023 13:57:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
 <CANn89iJvbXKgT3OSyLYMXpvoOXc+OEUt1eTzbHnZ0wG8ibvqcw@mail.gmail.com>
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <CANn89iJvbXKgT3OSyLYMXpvoOXc+OEUt1eTzbHnZ0wG8ibvqcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/12/2023 1:02 am, Eric Dumazet wrote:
> On Tue, Dec 19, 2023 at 9:17 AM Faizal Rahim
> <faizal.abdul.rahim@linux.intel.com> wrote:
>>
>> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
>> the Cycle Time Extension variable allows this extension of the last old
>> cycle to be done in a defined way. If the last complete old cycle would
>> normally end less than OperCycleTimeExtension nanoseconds before the new
>> base time, then the last complete cycle before AdminBaseTime is reached
>> is extended so that it ends at AdminBaseTime.
>>
> 
> Hmm... Is this series fixing any of the pending syzbot bugs ?

Not really I think ? I found some bugs in this area when I tried to 
enable/fix software QBV cycle time extension for my project.

