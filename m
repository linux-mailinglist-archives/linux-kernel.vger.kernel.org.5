Return-Path: <linux-kernel+bounces-12643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DE81F83C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE61C21D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70221749D;
	Thu, 28 Dec 2023 12:47:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B0747D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 120FD2F4;
	Thu, 28 Dec 2023 04:47:44 -0800 (PST)
Received: from bogus (unknown [10.57.74.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FBC3F5A1;
	Thu, 28 Dec 2023 04:46:56 -0800 (PST)
Date: Thu, 28 Dec 2023 12:43:48 +0000
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
Message-ID: <20231228124348.mmtceqeuean7ly6y@bogus>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
 <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
 <20231228102801.fzaubcjq5thfwgxg@bogus>
 <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>
 <20231228115053.zlypgc5uxxvghi4a@bogus>
 <376d3040-b9ed-4574-90d7-fb864d694e3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376d3040-b9ed-4574-90d7-fb864d694e3c@linaro.org>

On Thu, Dec 28, 2023 at 01:16:28PM +0100, Konrad Dybcio wrote:
> On 28.12.2023 12:50, Sudeep Holla wrote:
> > On Thu, Dec 28, 2023 at 12:47:51PM +0100, Konrad Dybcio wrote:
> >> On 28.12.2023 11:28, Sudeep Holla wrote:
> >>> On Wed, Dec 27, 2023 at 11:15:31PM +0100, Konrad Dybcio wrote:
> >>>> Most Qualcomm platforms implementing PSCI (ab)use CPU_SUSPEND for
> >>>> entering various stages of suspend, across the SoC. These range from a
> >>>> simple WFI to a full-fledged power collapse of the entire chip
> >>>> (mostly, anyway).
> >>>>
> >>>> Some device drivers are curious to know whether "the firmware" (which is
> >>>> often assumed to be ACPI) takes care of suspending or resuming the
> >>>> platform. Set the flag that reports this behavior on the aforementioned
> >>>> chips.
> >>>>
> >>>> Some newer Qualcomm chips ship with firmware that actually advertises
> >>>> PSCI SYSTEM_SUSPEND, so the compatible list should only grow slightly.
> >>>>
> >>>
> >>> NACK, just use suspend-to-idle if SYSTEM_SUSPEND is not advertised. It is
> >>> designed for such platforms especially on x86/ACPI which don't advertise
> >>> Sx states. I see no reason why that doesn't work on ARM platforms as well.
> >>
> >> Not sure if I got the message through well, but the bottom line is, on
> >> Qualcomm platforms the "idle" states aren't actually just "idle" (read:
> >> they're not like S0ix). All but the most shallow ones shut down quite a
> >> chunk of the entire SoC, with the lowest ones being essentially S3 with
> >> power being cut off from the entire chip, except for the memory rail.
> >>
> > 
> > No I understood that and S2I is exactly what you need.
> > Have you checked if S2I already works as intended on these platforms ?
> Yes, simple CPU idling works OOTB and the SoC power collapse only works
> given the developer doesn't cut corners when bringing up the platform
> (read: works on some of the ones we support, trying hard to expand that
> group!)
> 
> > What extra do you achieve with this hack by advertising fake S2R ?
> Uh.. unless I misunderstood something, I'm not advertising s2ram..
> Quite the opposite, I'm making sure only s2idle is allowed.
>

Right, I didn't notice that in suspend_valid_all(), it can be rename
suspend_valid_s2i or something. "All" indicates all state is valid.

Anyways that is not the main point. IIUC S2I must still work if there is
at-least one CPU idle state other than WFI without these changes. Right ?

If all these changes is to support S2I wih WFI only, then we can look at
some generic solution as there were previous attempts to do something
similar on other platforms IIRC.

-- 
Regards,
Sudeep

