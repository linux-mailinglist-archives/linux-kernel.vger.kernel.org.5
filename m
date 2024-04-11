Return-Path: <linux-kernel+bounces-139864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051668A089A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44DC28794F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC613D634;
	Thu, 11 Apr 2024 06:38:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BD13D61D;
	Thu, 11 Apr 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817494; cv=none; b=riTQwwZyDsiLJjAD6/oRyxrH2LfVPNXCGxhcZ3WjkdPFk2Xxupyxo0IQigLQlgLF5igSyF40W9+2meHg8zFYy5s+EbWOnmn2DIouDDzZ29KGPmM/2LaUgFYxJ9WlyO89N/SEoKQPn8DDcErztN/DfZ/JGoKrBCGKR2NIP/A4MMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817494; c=relaxed/simple;
	bh=mJ1CB+RoXP30bHck8GaTLhPwnlpSAOOixSCBOUxut7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcaPmsS3nJHnr+SzGdHjTI9bnKd3q3jub1L2iJw8mIgUgFawdWB0IEnEhXpK1M233TgK6cF3+PdZz28FEzDl2/vT2P3uBxjOiMqI57QgQyvLOGW9urVraC2j6Wy95ZXGvN9V1n0DcJwyQc/jDBYLhZKyXrBSAhfEx8e18s3l0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03237113E;
	Wed, 10 Apr 2024 23:38:41 -0700 (PDT)
Received: from [10.57.75.96] (unknown [10.57.75.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5DC63F766;
	Wed, 10 Apr 2024 23:38:09 -0700 (PDT)
Message-ID: <222ad2f9-6d0a-4183-82dc-a90ab71b6266@arm.com>
Date: Thu, 11 Apr 2024 07:38:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gov_power_allocator: Allow binding before cooling
 devices
Content-Language: en-US
To: Nikita Travkin <nikitos.tr@gmail.com>, Leonard Lausen <leonard@lausen.nl>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <594fdc5a-3b09-40df-98a0-43671665e55f@lausen.nl>
 <CAN_S-bXxKBjB5knjcUXW=rVwhCx0f1-pDMjmf9V9+ZLYSGZxvg@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAN_S-bXxKBjB5knjcUXW=rVwhCx0f1-pDMjmf9V9+ZLYSGZxvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/24 15:46, Nikita Travkin wrote:
> вт, 9 апр. 2024 г. в 19:42, Leonard Lausen <leonard@lausen.nl>:
>>
>> Hi Nikita, Hi Łukasz,
>>
>> thank you for fixing the e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier") and 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()") regressions as part of v6.9-rc3. As the regression was introduced in v6.8, would it be possible to include the fix in a v6.8 patch release?
>>
> 
> Hi! I think these both have already been picked for stable:
> 
> https://lore.kernel.org/r/20240408125314.939341866@linuxfoundation.org
> https://lore.kernel.org/r/20240408125314.969670696@linuxfoundation.org/
> 

Correct

