Return-Path: <linux-kernel+bounces-76205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F585F425
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F4E1C20F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E437710;
	Thu, 22 Feb 2024 09:20:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBB23747
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593639; cv=none; b=uPXC9+FT3b6l09futZAYbPQIppq/WeXuPtNzt/FVslbFi9FmOpmOGc81XhmWSyPOm/AxjQ4c+foJ8qC79kG3M3jsRTvS+epSZG2KWHGAdYD+6wKhMh6tPU495IdgJwfnjuCauxMoJyJs80yY7tddardCChbNUa3oIuyU+hiGvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593639; c=relaxed/simple;
	bh=byqQ+miQFAMaSNxicqvQ7KvSvqCEAe9uJ7FOZx/tCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIjSN0ueB7/UsKqgzr/q6x4GmTjtw8qVE7eXFqxLUvDiMLX9c3x8QRTX9F0hIJ/XJQgyAA6FmjIoBVKSBY8A8OVSzf/6lMywbwUBFhJDAQQry3W95wYrfzkUk/SN2xIwvUmMlwy3bXn42A3MEVYQEaibHDn5BUdd0GX8k5R1Kj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71B471007;
	Thu, 22 Feb 2024 01:21:14 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 891273F766;
	Thu, 22 Feb 2024 01:20:34 -0800 (PST)
Date: Thu, 22 Feb 2024 09:20:32 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Add support for multiple vendors
 custom protocols
Message-ID: <ZdcR4Auf0zMgBE7P@pluto>
References: <20240221220426.1205146-1-cristian.marussi@arm.com>
 <DU0PR04MB941736B537D71D920C8434AA88562@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941736B537D71D920C8434AA88562@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Thu, Feb 22, 2024 at 08:32:05AM +0000, Peng Fan (OSS) wrote:
> Hi Cristian,
> 
> > Subject: [PATCH] firmware: arm_scmi: Add support for multiple vendors
> > custom protocols
> 
> Do you have an example how to test this? Could this be used for pinctrl imx?

Hi Peng,

as an example usecase for this, you can consider your upcoming series
which adds 2 NXP SCMI vendor protocol (which I hope to review today)
that you numbered as 0x81, 0x84: in order to avoid clashes with other
vendors potentially registering in the future their own vendor protocols
while using the same numbers as yours, you will have to add a vendor_id
string specification to your scmi_protocol definition, so that it matches
the vendor_id string reported by your SCMI server at runtime via the Base
protocol.

This mechanism basically allows a vendor to own the whole space of
vendor protocols numbers, since the numbers are really now referred to a
specific vendor namespace at runtime.

You can also optionally add a sub_vendor_id and implementation version
if you want to use different protocols of you own with the same number
but different capabilties on different platform of yours...but I am
doubtful about the opprtunity of this further customization...lets see 
what the review process bring up...

BUT, all of this stands true for custom vendor protocols, pinctrl-imx does
use the standard 0x19 Pinctrl protocol, and the clash is really on the
device node underlying the device which is created...re-implementing and
duplicating fully a std protocol as a vendor one, just with a different
number to workaround this issue it is not something can go upstream...
..so at this point you will be better off with just that couple of
downstream pinctrl-imx patches that you have, until we get creative and
found a better way to support your specific usecase...or you move to the
generic Linux Pinctrl subsystem that is supported by the pinctrl-scmi
driver originally by Oleksii (but I understand this is problematic for you
in other ways too...)

Thanks,
Cristian

