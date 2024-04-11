Return-Path: <linux-kernel+bounces-139858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E68A0887
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837272878A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1413D258;
	Thu, 11 Apr 2024 06:35:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39E41AAC;
	Thu, 11 Apr 2024 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817339; cv=none; b=hkgbJ5lDHv2NKLW69+JgcD1xA+GPnXaQIHWhnWs2bi+pIcexv9ERkX83JsE97W4zyMMdGfgiCr+xq/aTXcRrsJgRlrPApCQuQQIOjhgsCtlzREKui94KXH7M8hYqymddEOLRd1nuR6Qtm4Hxw+rMyYflHu+rWWuW1tXl7syV94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817339; c=relaxed/simple;
	bh=1MPVI2kYWj1qJxWiiW5osq9U4UgjXlkSWpkwjxb/RRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0/uA8fblqwa6HcpHaeF6otPx+TQQXBrnOczdD2ZqA5gbLhR9gl8ESofF9lMG/mhRv/5lJtxwpLmGiQXsf7+3ze50bK9jbWj9BgxXSb4wNQPC7uXVHO+B6/hDSq8e/hYn3AIJq8avbMG05K6u1RHH8T0TSJtmsQ0aCCOZMaDYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEBC1113E;
	Wed, 10 Apr 2024 23:36:04 -0700 (PDT)
Received: from [10.57.75.96] (unknown [10.57.75.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ED863F766;
	Wed, 10 Apr 2024 23:35:33 -0700 (PDT)
Message-ID: <1080e95f-f0ff-471e-b265-8bfd1355ebd8@arm.com>
Date: Thu, 11 Apr 2024 07:35:37 +0100
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
 <a4e421d2-7279-4b03-9113-db0776dd5355@arm.com>
 <CAJZ5v0igWeyW=x0DOeUVAvgUp4O+_QrXfwy=o3nj1+KAQ+B8pw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0igWeyW=x0DOeUVAvgUp4O+_QrXfwy=o3nj1+KAQ+B8pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/10/24 16:56, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Fri, Apr 5, 2024 at 9:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 4/4/24 10:03, Rafael J. Wysocki wrote:
>>> On Tue, Apr 2, 2024 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Modify handle_thermal_trip() to call handle_critical_trips() only after
>>>> finding that the trip temperature has been crossed on the way up and
>>>> remove the redundant temperature check from the latter.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> This change is premature, as it will cause handle_non_critical_trips()
>>> to be called for hot/critical trips which is questionable, so I'm
>>> withdrawing it for now.
>>>
>>> The rest of the series is still applicable, though.
>>>
>>>
>>
>> Could you explain your concerns about this, please?
>> Is about the extra execution time for the non-critical trip,
>> while we are in section of handling critical ASAP?
>> (also it would require that extra sorting there IMO)
> 
> No, it is mostly about exposing the critical and hot trips to the
> governor code that may not be ready for seeing them and get somewhat
> surprised.  In particular, this would cause the User Space governor to
> send uevents regarding critical and hot trip points which it has not
> been doing so far and so user space may get confused.

Got it, thanks!

