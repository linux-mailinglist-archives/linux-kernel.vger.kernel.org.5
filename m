Return-Path: <linux-kernel+bounces-102271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBA87B00D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0DB1F22DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8912B14C;
	Wed, 13 Mar 2024 17:33:49 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF812AACA;
	Wed, 13 Mar 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351229; cv=none; b=V0oK+khyf3Y/PkMppEavlp8EIFnHQXLbrqtBXvreV2WeI8fGKmWXf6/hZhMYtfiDhsyWfCqY/jbepUjWyPIds4VjTNma5JX8E53Gy2PrR3xYXdHQoBbRLDIJvgavhs9cIqcR0ZMfPgTuTAi99nF51KDTSLw3EFO1Cbeo5y1fXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351229; c=relaxed/simple;
	bh=CfE1Qa7B1pDeJJVcPNq/eHR71qDGkenzEfw4ps12Zd4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=k4M2Klp7FhlbvgpHCNthAbe/QKjQxAsy1EWPbD/3kV7hnxQ2aWVMxWblM2EHVxNMeUEimhtsXnaDCjqukqw8tvpWk3Pa9VrZCX/9p0DIZgUQK5n02NP1dv65OEt1V0Cn+yA0wUg3bzzYSEMRF6zj4NfFEX/XyqmIMT1xayqMBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 3D3685E6;
	Wed, 13 Mar 2024 18:33:44 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 18:33:43 +0100
Message-Id: <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
Cc: "Mark Brown" <broonie@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Mika Westerberg"
 <mika.westerberg@linux.intel.com>, "Chia-Lin Kao (AceLan)"
 <acelan.kao@canonical.com>, "open list" <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Florian Fainelli" <florian.fainelli@broadcom.com>,
 <linux-spi@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240313171050.3505620-1-florian.fainelli@broadcom.com>

On Wed Mar 13, 2024 at 6:10 PM CET, Florian Fainelli wrote:
> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP=
 with
> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
> visible in the kernel log:
>
> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
>
> It turns out that the check in spi_mem_exec_op() was changed to check
> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
> means that for drivers that were converted, the second condition is now
> true, and we stop falling through like we used to. Fix the error to
> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
>
> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with =
-EOPNOTSUPP")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I4159811f6c582c4de2143382473d2000b8755872

Ha, thank you!

Reviewed-by: Michael Walle <mwalle@kernel.org>

FWIW in next, there is commit
e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op() calls")
that probably will conflict with this one.

Also, - not for this patch - but with that logic, spi_mem_exec_op()
might return EOPNOTSUPP *or* ENOTSUPP, even for drivers which might
still return ENOTSUPP, because there is one condition in
spi_mem_exec_op() which will always return EOPNOTSUPP. That is
somewhat confusing, no?

-michael

