Return-Path: <linux-kernel+bounces-94076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60290873981
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4312B21DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12670134413;
	Wed,  6 Mar 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgyhOkVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58F28EC;
	Wed,  6 Mar 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736218; cv=none; b=ljq9JFPK5iQe0+spxDC+uSqObUcrl/FrhV9ZhB+Keo3kqyLZgLgnU4c6FCcE6TYP4YzlAbL1N/UUfhGB/oaB2s91+jrqwwIhqyfNaOBl5G3P1SQ4k8b450nCz27YLH+m8txnak4RwJvRT123/T35GDgXCtbs8ho6cjr8VpW6QxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736218; c=relaxed/simple;
	bh=mWbp73eMNAokt9fYznOu9SNauqvLUqMJhCKZDXxOfNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki1EjzCQ0Rirq0h6r1v8NIM5k9VllpaTW9BAHIqTRRycayM/spLBqFupFjBv3MPv24vtZa6D2ai46ztiRHGvgCvSsX4o5DWAuAYzqAApH+Dg6/DewWXO7PatSd+YW5iurY+kLiYIrxo6WsShLgWEt9f7iPuwU4DEHYhRA/nsLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgyhOkVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DF3C433C7;
	Wed,  6 Mar 2024 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709736217;
	bh=mWbp73eMNAokt9fYznOu9SNauqvLUqMJhCKZDXxOfNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgyhOkVd6u4W1iU9MwffZEuZVCC29CBMHvD/EVRTHl54EfAiveOAdI/WlsPpa0XiP
	 xUZLAOGxJ8gQvg8/MyH4WZgZlkFYKEqK/jKLJqs2GFYc7w3sbzeZ/knXIzLbS6H1xR
	 NpY0knjWotss727Q7C8fAcbLX5qwiqFIFcO4+Rlei/wFNtRE6jPYA/3g6Wlg6f9MU+
	 zMblSRZ2hHVwZ8J3QBglYvaVrNodciQnBv2g0jYCvg+XbGA9G/6QjaYu+UFCK/LGw3
	 EwXOT/Zhqo0dAKB2XN6l3lVyW/0otjgXnpVndljWcw7os9DkTj+UlElp6i1f8LrprU
	 68AChOpdZ114g==
Date: Wed, 6 Mar 2024 15:43:32 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v5 0/1] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZeiBFBDhwlJnCUZ2@lpieralisi>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123110332.112797-1-lpieralisi@kernel.org>

On Tue, Jan 23, 2024 at 12:03:31PM +0100, Lorenzo Pieralisi wrote:
> This series is v5 of previous series:
> 
> v4: https://lore.kernel.org/all/20231227110038.55453-1-lpieralisi@kernel.org
> v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
> v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
> v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> 
> v4 -> v5
> 	- ACPICA patches merged for v6.8
> 	- Refactored ACPI parsing code according to review
> 	- Rebased against v6.8-rc1

Hi Marc, all,

this is not an urgent fix (I don't think there is any ACPI platform
affected in the field so it is not even a fix), I am just asking please
what should I do with it, I appreciate it is late in the cycle (and I
know some fixes got merged in -rcX leading up to -rc7 that are
pre-requisite for this patch to work).

Thanks,
Lorenzo

> v3 -> v4:
> 	- Dropped patches [1-3], already merged
> 	- Added Linuxized ACPICA changes accepted upstream
> 	- Rebased against v6.7-rc3
> 
> v2 -> v3:
> 	- Added ACPICA temporary changes and ACPI changes to implement
> 	  ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> 	- ACPI changes are for testing purposes - subject to ECR code
> 	  first approval
> 
> v1 -> v2:
> 	- Updated DT bindings as per feedback
> 	- Updated patch[2] to use GIC quirks infrastructure
> 
> Original cover letter
> ---
> The GICv3 architecture specifications provide a means for the
> system programmer to set the shareability and cacheability
> attributes the GIC components (redistributors and ITSes) use
> to drive memory transactions.
> 
> Albeit the architecture give control over shareability/cacheability
> memory transactions attributes (and barriers), it is allowed to
> connect the GIC interconnect ports to non-coherent memory ports
> on the interconnect, basically tying off shareability/cacheability
> "wires" and de-facto making the redistributors and ITSes non-coherent
> memory observers.
> 
> This series aims at starting a discussion over a possible solution
> to this problem, by adding to the GIC device tree bindings the
> standard dma-noncoherent property. The GIC driver uses the property
> to force the redistributors and ITSes shareability attributes to
> non-shareable, which consequently forces the driver to use CMOs
> on GIC memory tables.
> 
> On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> on the generic DT dma-coherent/non-coherent property management layer
> (of_dma_is_coherent()) which would default all GIC designs in the field
> as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.
> 
> When a consistent approach is agreed upon for DT an equivalent binding will
> be put forward for ACPI based systems.
> 
> Lorenzo Pieralisi (1):
>   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
> 
>  drivers/acpi/processor_core.c    | 15 +++++++++++++++
>  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>  include/linux/acpi.h             |  3 +++
>  4 files changed, 31 insertions(+)
> 
> -- 
> 2.34.1
> 

