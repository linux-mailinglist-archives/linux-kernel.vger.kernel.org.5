Return-Path: <linux-kernel+bounces-107728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8E8800D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E72834DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391765BA1;
	Tue, 19 Mar 2024 15:38:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5551F608;
	Tue, 19 Mar 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862735; cv=none; b=cILXwHRiOevBBWGgAAIYtdH5CZJW4qedFJjPiQrdiC6tTzWLnu9cOFMyigTmXepSHSGW1kjg/rYCupug4GcsZtx8sAtH5ra/7esGzS6jZ9ddgRW7D7jqODVvxrpLuMAzuGkF+/rD1Fh6lVxyasopsvkz6cUJaO1du0jTvvzPnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862735; c=relaxed/simple;
	bh=Ab+zULn2IP9jCO5eMIYobOnMG4LfbJA7u/jzgOg8EEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIdgEBFHiTYVrOpammpTIUorQf0t/pbO7rAbAYuX7QIN67rRWXxEUOtF/Yz43BtfSNJNzajH7Qta22Vxw3q8ZNo8yF8YdbhENjPj0el/WQrgFBkonILene+ywpch6d1aeIPJSKkI/JAFhzXQLMx8bO63NVVJmdNLsA6biKRT6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86CBC106F;
	Tue, 19 Mar 2024 08:39:27 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AED93F762;
	Tue, 19 Mar 2024 08:38:49 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:38:46 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sriram Dash <quic_sriramd@quicinc.com>
Cc: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
	<Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
	<linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
	<quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
	<ulf.hansson@linaro.org>, <quic_shazhuss@quicinc.com>
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Message-ID: <Zfmxhn9-uTo-6zyD@bogus>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>

On Tue, Mar 05, 2024 at 10:27:35PM +0530, Sriram Dash wrote:
> Some target systems allow multiple resources to be managed by firmware.
> On these targets, tasks related to clocks, regulators, resets, and
> interconnects can be delegated to the firmware, while the remaining
> responsibilities are handled by Linux.
>
> To support the management of partial resources in Linux and leave the rest
> to firmware, multiple power domains are introduced. Each power domain can
> manage one or more resources, depending on the specific use case.
>

Currently it is just 2 IIUC. Better to be specific with more details and
point to the exact binding.

> These power domains handle SCMI calls to the firmware, enabling the
> activation and deactivation of firmware-managed resources.
>
> The driver is responsible for managing multiple power domains and
> linking them to consumers as needed. Incase there is only single
> power domain, it is considered to be a standard GDSC hooked on to
> the qcom dt node which is read and assigned to device structure
> (by genpd framework) before the driver probe even begins.
>
> fw-managed dt property allows the driver to determine whether
> device resources are managed by Linux or firmware, ensuring
> backward compatibility.
>

And provide the reason why this additional property is a must ? Why can't
the implementation deal with absence of it on these systems ?

Not sure if you have seen/followed this[1] discussion before, but please
do now if not already and contribute. It is definitely related to this
patch set and all possible very similar patch sets Qcom might have in the
future across various subsystems in the Linux kernel.

In general, Qcom must stop pushing such changes to individual drivers
in isolation and confuse the reviewers to some extent without giving
the complete view(or rather providing partial view) which may result in
them agreeing with proposed solution without considering the overall
impact on various subsystems and DT bindings.

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/be31801e-bb21-426b-f7aa-2b52727de646@quicinc.com/

