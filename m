Return-Path: <linux-kernel+bounces-12628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C581F7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B967D281D64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91279C7;
	Thu, 28 Dec 2023 11:54:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6279C6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A2072F4;
	Thu, 28 Dec 2023 03:54:49 -0800 (PST)
Received: from bogus (unknown [10.57.74.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71CFC3F5A1;
	Thu, 28 Dec 2023 03:54:01 -0800 (PST)
Date: Thu, 28 Dec 2023 11:50:53 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 2/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() on qcom
Message-ID: <20231228115053.zlypgc5uxxvghi4a@bogus>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
 <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
 <20231228102801.fzaubcjq5thfwgxg@bogus>
 <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>

On Thu, Dec 28, 2023 at 12:47:51PM +0100, Konrad Dybcio wrote:
> On 28.12.2023 11:28, Sudeep Holla wrote:
> > On Wed, Dec 27, 2023 at 11:15:31PM +0100, Konrad Dybcio wrote:
> >> Most Qualcomm platforms implementing PSCI (ab)use CPU_SUSPEND for
> >> entering various stages of suspend, across the SoC. These range from a
> >> simple WFI to a full-fledged power collapse of the entire chip
> >> (mostly, anyway).
> >>
> >> Some device drivers are curious to know whether "the firmware" (which is
> >> often assumed to be ACPI) takes care of suspending or resuming the
> >> platform. Set the flag that reports this behavior on the aforementioned
> >> chips.
> >>
> >> Some newer Qualcomm chips ship with firmware that actually advertises
> >> PSCI SYSTEM_SUSPEND, so the compatible list should only grow slightly.
> >>
> > 
> > NACK, just use suspend-to-idle if SYSTEM_SUSPEND is not advertised. It is
> > designed for such platforms especially on x86/ACPI which don't advertise
> > Sx states. I see no reason why that doesn't work on ARM platforms as well.
>
> Not sure if I got the message through well, but the bottom line is, on
> Qualcomm platforms the "idle" states aren't actually just "idle" (read:
> they're not like S0ix). All but the most shallow ones shut down quite a
> chunk of the entire SoC, with the lowest ones being essentially S3 with
> power being cut off from the entire chip, except for the memory rail.
>

No I understood that and S2I is exactly what you need.
Have you checked if S2I already works as intended on these platforms ?
What extra do you achieve with this hack by advertising fake S2R ?
S2I will have less latency compared to S2R and the mem_sleep will be
automatically set to S2I if S2R is not supported, so no userspace impact
as well.

So please let us know what this change provide extra over S2I ? Until
then my NACK still stands.

--
Regards,
Sudeep

