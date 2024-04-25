Return-Path: <linux-kernel+bounces-158347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8E8B1EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4593128652F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41628614D;
	Thu, 25 Apr 2024 10:02:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1A85937;
	Thu, 25 Apr 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039370; cv=none; b=BMap8+O7uPz7AS5uW0TaO7N72b5VoRP7S4uGXYBhUAmMVqP95HEkchA0v+r7ln+9OP1VLYYZFiNgDgJG/gf4XFZ7VtisVgtQrda9DqzuADx34C6QDIuAUI7sVcGLQAuJFQE84hXVeG3+qS3icWhp1TkP9D+9bmIT1s7CP9zz3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039370; c=relaxed/simple;
	bh=bc9Wcx0YrqoGT173loLL71by9HSXOJAyO9bDyHK3DMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Auuiy5eHTdP7hFvLZOTuDRuW4fGEHB1ouZc2XjfQsVVts5rHsNxQGAqtjZy88dsGtYTlxKBawwYjMrPFcNOiClP/4obLtAl7sphHZ2eniNh4M0l2JPZVnpgCWbvyaleDm50VkDtqh1Sr+Bd6fR79LytjJyie8SoYB/HDNM1cdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D7D1007;
	Thu, 25 Apr 2024 03:03:15 -0700 (PDT)
Received: from [10.57.74.218] (unknown [10.57.74.218])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80523F64C;
	Thu, 25 Apr 2024 03:02:46 -0700 (PDT)
Message-ID: <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com>
Date: Thu, 25 Apr 2024 11:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to
 thermal_debug_cdev_add()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2181352.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/23/24 19:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If cdev_dt_seq_show() runs before the first state transition of a cooling
> device, it will not print any state residency information for it, even
> though it might be reasonably expected to print residency information for
> the initial state of the cooling device.
> 
> For this reason, rearrange the code to get the initial state of a cooling
> device at the registration time and pass it to thermal_debug_cdev_add(),
> so that the latter can create a duration record for that state which will
> allow cdev_dt_seq_show() to print its residency information.
> 
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c    |    9 +++++++--
>   drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
>   drivers/thermal/thermal_debugfs.h |    4 ++--
>   3 files changed, 19 insertions(+), 6 deletions(-)
> 

I'm trying to test it on my board and do the review, but faced issue.
For some reason I couldn't apply that patch on the latest bleeding-edge
branch.
Could you help me in this please? Is there something missing in the
patch set (like one more fist patch)?

Regards,
Lukasz

