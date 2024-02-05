Return-Path: <linux-kernel+bounces-53813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B784A6CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F8B1C26247
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2A5732C;
	Mon,  5 Feb 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uliqqw4+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2A57311;
	Mon,  5 Feb 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160816; cv=none; b=hhA2r1uWGlVArWrNJRKmDmbGDp9ml2PmLWWj8WdAIk1S4ZDooiriPNAOKcvRpCETw92YhJED9nlvzJkNeAeiCQLhSPDt7Z2MYiwitQlDQMKQYvgXEEB3wGtMmlHSe+/ZnApRcLI0NZsWJCyJrXzlZ0KfaTLkvlXk6JaPX2DMKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160816; c=relaxed/simple;
	bh=s0Ew5ecoJsNDIWSfzyv3ipC7x1Zl6BcBXiliBSmeUkY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJX7ZaF6U25DU1KdNSj1Svpw6dtnKDrFffAw26kgsIR7JSy950IieTQ1KF8TzhEAvDTPR++q+ak6CP8kQn2gcIOWw4W3MBygxL4MFmULpa3wyPdTKi1Ph2lrDlp5UcSPbNcO5OzCT2y57qlBfiaRsB4wihyMIeSpU1lnCCWTl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uliqqw4+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JK4Oj096960;
	Mon, 5 Feb 2024 13:20:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707160804;
	bh=hmu7rA5AWP7lWQ4A3GoshAXuo8HFdVfcgt72YBYfPYs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uliqqw4+lSlhDVfB1gaNtN02LYlAFmin2n4Jbrin64ZLv94aHIK/b8krbXINFwwmq
	 571zlsEbH6XakB4PN6SJEd9S2qabLHs3pgDLmwWb/ZYj6k6ARG0Kk5BBvbZFcGaG3N
	 CxrUGGrK9v9bTKcEmgJW2wX5w0geCMxG18ehrGX0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JK4gG047380
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:20:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:20:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:20:04 -0600
Received: from localhost (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JK3cm128183;
	Mon, 5 Feb 2024 13:20:03 -0600
Date: Mon, 5 Feb 2024 13:20:03 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nas Chung
	<nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Message-ID: <20240205192003.3qns6cxqurqnnj7c@udba0500997>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
 <20240202155813.szxvi7bfp5xh7rvw@babble>
 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
 <20240205141255.z5kybm42qld44tdz@portfolio>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240205141255.z5kybm42qld44tdz@portfolio>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:12-20240205, Nishanth Menon wrote:
> On 17:08-20240202, Krzysztof Kozlowski wrote:
> > On 02/02/2024 16:58, Nishanth Menon wrote:
> > > On 14:56-20240202, Krzysztof Kozlowski wrote:
> > >> On 02/02/2024 13:52, Nishanth Menon wrote:
> > >>> On 11:47-20240202, Krzysztof Kozlowski wrote:
> > >>>> On 01/02/2024 19:42, Brandon Brnich wrote:
> > >>>>> Wave521c has capability to use SRAM carveout to store reference data with
> > >>>>> purpose of reducing memory bandwidth. To properly use this pool, the driver
> > >>>>> expects to have an sram and sram-size node. Without sram-size node, driver
> > >>>>> will default value to zero, making sram node irrelevant.
> > >>>>
> > >>>> I am sorry, but what driver expects should not be rationale for new
> > >>>> property. This justification suggests clearly it is not a property for DT.
> > >>>>
> > >>>
> > >>> Yup, the argumentation in the commit message is from the wrong
> > >>> perspective. bindings are OS agnostic hardware description, and what
> > >>> driver does with the description is driver's problem.
> > >>>
> > >>> I will at least paraphrase my understanding:
> > >>> In this case, however, the hardware block will limp along with
> > >>> the usage of DDR (as is the current description), due to the
> > >>> latencies involved for DDR accesses. However, the hardware block
> > >>> has capability to use a substantially lower latency SRAM to provide
> > >>> proper performance and hence for example, deal with higher resolution
> > >>> data streams. This SRAM is instantiated at SoC level rather than
> > >>> embedded within the hardware block itself.
> > >>
> > >> That sounds like OS policy. Why would different boards with the same
> > >> component have this set differently? Based on amount of available
> > >> memory? This, I believe, is runtime configuration because it might
> > >> depend on user-space you run. Based on purpose (e.g. optimize for
> > >> decoding or general usage)? Again, run-time because same hardware board
> > >> can be used for different purposes.
> > >>
> > > 
> > > Why is this OS policy? It is a hardware capability.
> > 
> > How amount of SRAM size is hardware capability? Each hardware can work
> > probably with 1, 2 or 100 pages.
> > 
> > > Traditionally
> > > many similar hardware blocks would have allocated local SRAM for
> > > worst case inside the hardware block itself and don't need to use
> > > DDR in the first place. However, for this hardware block, it has
> > > capability to use some part of one of the many SRAM blocks in the SoC,
> > > not be shared for some part of the system - so from a hardware
> > > description perspective, we will need to call that out as to which
> > > SRAM is available for the hardware block.
> > 
> > Just because more than one device wants some memory, does not mean this
> > is hardware property. Drivers can ask how much memory available there
> > is. OS knows how many users of memory there is, so knows how much to
> > allocate for each device.
> > 
> > > 
> > > Why would different boards need this differently? simply because
> > > different cameras have different resolution and framerates - and you
> > > dont want to pay the worst case sram penalty for all product
> > > configuration.
> > 
> > Choice of resolution and framerate is runtime choice or use-case
> > dependent, not board level configuration, therefore amount of SRAM size
> > to use is as well.
> 
> I am arguing this is similar to what we have for remote-procs. Yes,
> usecases usage come to a conclusion that sram size X is needed. Sure.
> Lets even argue that sram = <&sram> has X+100 bytes available, so as
> far as allocator is concerned, it can allocate. But how does the driver
> know that 1k of that sram is already used by a remote core or some other
> function?
> 
> This is no different from a remote proc usecase, following which, I
> wonder if "memory-region" is the right way to describe this usage? That
> would be a very specific bucket that is made available to the driver.
> And I'd say sram and memory-region are two mutually exclusive option?

Wouldn't this just be a static allocation of the SRAM then? I believe
the correct way to do this is highlighted in Rob's[0] response. This is
also something we have done in the past[1], but I thought dynamic
allocation was preferred method so that the VPU didn't hog a portion of
SRAM. Seems wasteful in cases where the VPU is not being used.

The device itself has the capability of doing runtime allocation before
any decoder/encoder stream instances are opened. All of these opened
streams will share this one allocated pool, meaning first open stream
allocates and the rest share. Because of this, the goal is to allocate
enough to meet maximum use case of VPU (4K60) or max case supported by
the SoC itself if the SoC is unable to handle 4K60.

Is there preferred method for dynamic SRAM allocation? I understand
point that framerate and resolution are runtime choice, but these
properties are not guaranteed to be known when streams are being opened.

If static SRAM allocation is the correct method to go, then this series
can be ignored and I will add section in device tree and remove check
for parameter in driver as that will now be a bug.

[0]: https://patchwork.kernel.org/project/linux-media/patch/20240201184238.2542695-1-b-brnich@ti.com/#25696671
[1]: https://patchwork.kernel.org/project/linux-media/patch/20231108-wave5-v14-rebased-v14-8-0b4af1258656@collabora.com/
 
> > 
> > > 
> > > Further, Linux is not the only thing that runs on these SoCs.. these are
> > > mixed systems with autonomous operations of uC cores who may or maynot
> > > (typically not) even need to communicate with MPU to state which part of
> > > resource they are hogging (hence the board level definition).
> > 
> > OK that could be the case but I could also say choice of RTOS or any
> > other is also board-independent.
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Thanks,
Brandon

