Return-Path: <linux-kernel+bounces-132560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0938996A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E99B22E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D24AEF4;
	Fri,  5 Apr 2024 07:35:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99D481B5;
	Fri,  5 Apr 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302554; cv=none; b=WXfPgVj+ZfRTN/4j8UaD0bKpiaKpsz8bI1CjU9q5Tg1bnvvj/tWYKA9lKC9QE1OxChtajg0fZOpkHcE9pKMX8ZF9aciLkabsUkI95GG5axbqSX4s24fAMTaDlPzuFlq3Lq1LNb6zFCNHxZdpWzPYTJK+BSaJjB1Jyp0rQUg/GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302554; c=relaxed/simple;
	bh=KMKzpMcRFQlWChDCPVjmGk8tQMq9E4Qn6CQPXuiAy9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFltD4PkDjBnREyKfs9n9pcodiCfo83F5fzeDda0HQxdtmCDTL6Y69/qsY0W4jd8OCOLOtVx6RimJNtmMTDE5R/DHdT//W8Dqc3v4EINyZlZhU7FV9A9+Xvy8q7It9XWKzYM7IAtiEEF8UzDLuVOhil1CmMqm6s516nZ0WtPKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784F1FEC;
	Fri,  5 Apr 2024 00:36:16 -0700 (PDT)
Received: from [10.57.74.176] (unknown [10.57.74.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4DD53F64C;
	Fri,  5 Apr 2024 00:35:44 -0700 (PDT)
Message-ID: <a4e421d2-7279-4b03-9113-db0776dd5355@arm.com>
Date: Fri, 5 Apr 2024 08:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] thermal: core: Relocate critical and hot trip
 handling
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
References: <4558251.LvFx2qVVIh@kreacher> <3556878.iIbC2pHGDl@kreacher>
 <CAJZ5v0j0jKi9=w_RiYqSZuQtveskcE8jKZHDwaP1EmNOxLk-RQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0j0jKi9=w_RiYqSZuQtveskcE8jKZHDwaP1EmNOxLk-RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 4/4/24 10:03, Rafael J. Wysocki wrote:
> On Tue, Apr 2, 2024 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Modify handle_thermal_trip() to call handle_critical_trips() only after
>> finding that the trip temperature has been crossed on the way up and
>> remove the redundant temperature check from the latter.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This change is premature, as it will cause handle_non_critical_trips()
> to be called for hot/critical trips which is questionable, so I'm
> withdrawing it for now.
> 
> The rest of the series is still applicable, though.
> 
> 

Could you explain your concerns about this, please?
Is about the extra execution time for the non-critical trip,
while we are in section of handling critical ASAP?
(also it would require that extra sorting there IMO)

Regards,
Lukasz

