Return-Path: <linux-kernel+bounces-138128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F94389ECE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEE1C20D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896213D29E;
	Wed, 10 Apr 2024 08:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C772AE6A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736084; cv=none; b=tDLyT+C/7h31hMK+/+vl41J9EO2tjXJTYg6L6/0RhG+mUg/iyS4fUBc9/zyrILMaU0EZd4o8jBqJBQSCrKPt86OdfpaYvgl8FugvcDv6d3svmBaP652zmNtw4hBOKFkx8mVWuJdGAV4qkebRTlSABW8x+ZgTx/CEqvadKGfvphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736084; c=relaxed/simple;
	bh=VTwZMXnYIbWR0MWJwZOA1x+kDKtOjvRESHbBhhqjrGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx4ofAJ/mjTbyCh/ksXhNOKytWo+t54ZZMFRvayxlWpXhhHEFUZDT4zQV331W50srX+L+SdsuSllyv2Nllgh8FndqcbPywu6vyT/Kh8WpBck8rJ9ztEbVrxUe52M7/gn1IJmMXxnY8J0cap0v/e7iEXVp8mxITY/j+Hk9Yo+iwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C1271480;
	Wed, 10 Apr 2024 01:01:52 -0700 (PDT)
Received: from [10.57.17.166] (unknown [10.57.17.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87FBA3F766;
	Wed, 10 Apr 2024 01:01:18 -0700 (PDT)
Message-ID: <1d317158-f9a4-48b8-bc29-5a1d75c6493d@arm.com>
Date: Wed, 10 Apr 2024 09:01:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix wrong flag passed to
 set_rd_overutilized()
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <0afb160788a297f8cda63b70385de5f6bddec11e.1712693356.git.hongyan.xia2@arm.com>
 <4370fce5-323e-4f03-87e1-89632e724e2c@linux.ibm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <4370fce5-323e-4f03-87e1-89632e724e2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 07:11, Shrikanth Hegde wrote:
> 
> 
> On 4/10/24 1:43 AM, Hongyan Xia wrote:
>> In update_sd_lb_stats(), sg_overloaded is passed to
>> set_rd_overutilized(). This seems to be a typo during refactoring, which
>> breaks many of my local EAS tests because overutilization is mistakenly
>> triggered.
>>
>> This fix makes those EAS tests work again.
>>
> 
> Yes. This is a needed fix.
> 
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>   
> 
> FYI, Same patch has been posted by Vincent a week ago.
> https://lore.kernel.org/all/20240404155738.2866102-1-vincent.guittot@linaro.org/

Thank you. Somehow I missed it in my inbox.

