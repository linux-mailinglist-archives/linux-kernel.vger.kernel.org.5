Return-Path: <linux-kernel+bounces-98625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2D877CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728D6281091
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4771802E;
	Mon, 11 Mar 2024 09:33:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11017548;
	Mon, 11 Mar 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149616; cv=none; b=sMcrXfppvahX/zKAK2KF9lWJovcQDYPZ0B4Y/hOE7Am3y64qJdOQz2xG8gIAvcni8d9ubAS9g7GFVerT6S23WL+qrAbb4m27kWAHUqF7ZpS2VrHFucGw0wkk2UjINePqCm3MVYhoRYrRgPiz2jTrkZgpnJAOEaxYBtuVdNfE/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149616; c=relaxed/simple;
	bh=5h2/ErZoU+OYJlydwEWZQA4nPorm3Yj7oMA72BmjzmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hup9LCrGMy2iSGhdj53K5Qjp5eT+8eL7w9f8Qfn9dhTGMy+T8CS818ZrpTkJFAHZ/rQ/mOnCWOzboC4u/ZTKf8ViXNEbJuvXpijmw4gFyrWnUnBvlH98Ifgba2m2WL5HGJ795KMGnV3xMHlgeiKMhCsuuZcW+SiUJLTUuXhu/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86557FEC;
	Mon, 11 Mar 2024 02:34:10 -0700 (PDT)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBC03F762;
	Mon, 11 Mar 2024 02:33:30 -0700 (PDT)
Message-ID: <081eef3f-3b19-42d1-b70d-8916b867f766@arm.com>
Date: Mon, 11 Mar 2024 15:03:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/11] coresight: Move remaining AMBA ACPI devices into
 platform driver
Content-Language: en-US
To: James Clark <james.clark@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
 <8ef57dd9-a16d-4847-89f5-a309c4ccb849@arm.com>
 <379bf6df-3568-43c0-9a68-4a5693bf5ccc@arm.com>
 <828d2109-7413-ffe5-da6a-56f15ed2f562@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <828d2109-7413-ffe5-da6a-56f15ed2f562@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/24 14:55, James Clark wrote:
> 
> On 11/03/2024 06:04, Anshuman Khandual wrote:
>>
>> On 3/5/24 23:55, Suzuki K Poulose wrote:
>>> On 22/02/2024 08:21, Anshuman Khandual wrote:
>>>> This moves remaining AMBA ACPI devices into respective platform drivers for
>>>> enabling ACPI based power management support. This series applies on kernel
>>>> v6.8-rc5 release. This series has been built, and boot tested on a DT based
>>>> (RB5) and ACPI supported coresight platform (N1SDP).
>>> Please rebase your series on coresight next and fix build failures with the extra warnings turned ON (should be on by default with next).
>> I did rebase the series (which required some rebase related changes for some) on
>> coresight next i.e with the following commit as HEAD.
>>
>> a4f3057d19ff ("coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits")
>>
>> Although did not see any warning either with = m or = y based coresight options.
>> Is there any other particular config which needs to be enabled for these warnings
>> to come up ?
>>
> It doesn't apply cleanly on a4f305 for me, maybe you sent an old version
> after rebasing?

Ohh, I was not clear enough earlier. This series is NOT rebased against coresight next.
I am preparing V6 series respin which is rebased against the above mentioned commit on
coresight next branch instead.

> 
> This change in patch 5 is a warning for example, because not all members
> of the struct are initialised. No special config is required:
> 
> +	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */"

Right, will change the above as follows and fix other affected places as well.

	{"ARMHC98D", 0, 0, 0}, /* ARM CoreSight Dynamic Replicator */

