Return-Path: <linux-kernel+bounces-140750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24B8A18D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399ACB2B0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5EB1400B;
	Thu, 11 Apr 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="jRzWdfru"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B44749F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849377; cv=none; b=gLO8tf4OBgNLlF7g8exOjIwOXbgn3jpZE8BCpfiRLrAyKBnoTNdlQjI+6VxkKOor5idrO9fH7TQOa36w9qBlqaKNW3+szdQkG79BWq/UKQgEMbCspyAcKqobO90aThvmm73/pWRqTLlzqJt6bJSzJM38BG1sqWil8qO8fRpoqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849377; c=relaxed/simple;
	bh=abzdobl6kFhj/cxNTOy15fncC/KDGWetUBzv0ypOZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5aZvy14hBubVrcXnf2mInl/eOdwfZVWsl/UbD5ZeLeCRwa/7B5QoS9W32GBT+GFEnsapDX/7497vwdzYMj2SHHU1AlLZt2HKUOnc6GrxBD/EtImEaSe34grBkGRG2AjGM8Asbx+r1TFORSF+ui7Wjc7rcU64CGFRsAK2bGn0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=jRzWdfru; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uwMhr0X3qiznzuwMirpLmf; Thu, 11 Apr 2024 17:29:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712849368; bh=abzdobl6kFhj/cxNTOy15fncC/KDGWetUBzv0ypOZo8=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=jRzWdfrup0jJXs2SDRrY070NJDoze6PlPrPAxb7Bx8vG6HoTgRKWbRhpFz3dKW6+x
	 oRL3T+QgL1yzMet7dDqqwyBsqmd/nrVD4jzGMMPqcwDSw0/UWWy0Kk7qNdTYXAMnhr
	 vzoNeYyz0XkqVxUmykYmZ4EJffoqldpZnvy6cqcC4sBBzWGyFlOHzxVdE0zQkL1Xiv
	 +4dhm4jx6/a2uoByEdSmGMgdHzoUoOkJ4mef2vNB33B/iQcc3TouR6jmHbUj7bdzHL
	 jTB/QksWmABvaqOujvk2hQfNxCEjvIMOqy50NIw5XJuEh27NzQKm5WBnu9WaT9Oivz
	 0FU7Gyz+J064g==
Date: Thu, 11 Apr 2024 17:29:26 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v2 1/1] regulator: pca9450: make warm reset on PMIC_RST_B
 assertion
Message-ID: <ZhgB1ifgrg0zeZtv@engicam>
References: <20240411100138.366292-1-fabio.aiuto@engicam.com>
 <20240411100138.366292-2-fabio.aiuto@engicam.com>
 <b805ed86-ce3c-4ecb-8a46-59bfa4678c4b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b805ed86-ce3c-4ecb-8a46-59bfa4678c4b@kernel.org>
X-CMAE-Envelope: MS4xfGIjvZ3taEFr1w1uLq7uYueOLsi7SIVx2p/w6mM8uoMQrXGSlTb9JMvarRY52+akmUi2mcQ/CYAttTYRc3+3jhRfomEzinAspw2dkOiNfHjZDRGpitSC
 2fFJDvPNkVbbarFxJVrVloIEwhLcxtYjvrZ6K4atWWnweAzdJnCCXhQxvikt0oz58mxZ48/58q1Y9rqRZE0MePHHRrobfWPoM30Bw67LMJ1pGtolkzfoGYzR
 +YuhpeL3DMlo8SB+b8uhPxoLqTxZRUCS4GW/eyxtY/i+tcDsc8MSXGsi3vG6EB+WfyhrjrSxPcXTOf5RxeUCfuwmAOYa3RJWaIC/9217fq3OnHytISvTMGlB
 MhbpNBTL

Dear Krzysztof,

Il Thu, Apr 11, 2024 at 04:46:06PM +0200, Krzysztof Kozlowski ha scritto:
> On 11/04/2024 12:01, Fabio Aiuto wrote:
> > The default configuration of the PMIC behavior makes the PMIC
> > power cycle most regulators on PMIC_RST_B assertion. This power
> > cycling causes the memory contents of OCRAM to be lost.
> > Some systems needs some memory that survives reset and
> > reboot, therefore this patch is created.
> > 
> > This patch extends commit 2364a64d0673 ("regulator: pca9450:
> > Make warm reset on WDOG_B assertion") to the other reset
> > input source PMIC_RST_B as per pmic specs.
> > 
> > CC: Matteo Lisi <matteo.lisi@engicam.com>
> > CC: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> > Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
> > ---
> >  .../bindings/regulator/nxp,pca9450-regulator.yaml     |  6 ++++++
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
> 
> >  drivers/regulator/pca9450-regulator.c                 | 11 ++++++++---
> >  include/linux/regulator/pca9450.h                     |  6 ++++++
> >  3 files changed, 20 insertions(+), 3 deletions(-)
> > 
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> 
> 
> Also: underscores are not allowed in property names.

thanks a lot for all suggestions, will send a patchset soon.

kind regards,

fabio

> 
> Best regards,
> Krzysztof
> 

