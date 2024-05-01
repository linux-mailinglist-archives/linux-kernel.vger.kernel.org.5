Return-Path: <linux-kernel+bounces-165237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4F38B89F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14E7B236C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286328564F;
	Wed,  1 May 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jfMNF5A4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4254FA1;
	Wed,  1 May 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566319; cv=none; b=JhSBCdCy7HECgnxn9A0T5ogcsJZqmviYaivEpDgGx6galy0yNzgd3KDepZgdldNi/Ebjn4IGWDvevwM9RQWjyi9jKZoWLqqzXce6CeiMSmduBYsI+UrLId063FRuhp4r+KIczxAvCGY7cBUHH1v8B2y19JQvlC3vGTzN1yFVrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566319; c=relaxed/simple;
	bh=bNjNqglbSAvjM5n8SypXA+yVwX3zPRERPubtUX7xj0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbeZorQG5ZHQTnKhtFuztuX2D0BHbTXyrxDNX8wt4LAy1579GwCMZj7HGNeCJdHb3ZUTeF1vjwp9ceEnGia3Q9ZLOTALx2M2FbO+wg6GFZofIaXbuA4G2TBcsuxoyCyOcBrY8exQPB+SgakIGCQr25DAx6l6LgSzUJK3qL8g+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jfMNF5A4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441COvCE015239;
	Wed, 1 May 2024 07:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714566297;
	bh=IvGVvRHBEgjdv1v5ac4Fg9IPJ54RDT5gYOZ6Z/f6ODY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jfMNF5A4vOcGqlklQ10s/9zwL+D0uYEtMNktUtLXNSDJvjYpmI8eAB+5h1+NRSCD8
	 2TpfirOI/XD+qVTwNJH776NZ73i29A5Aymxmvw3LxXKxFl/KoX9moazNNIupDfDXMI
	 YkgAv/9xzy1YifF2mp38kXBtBsApcpF4QeW9OzRY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441COvOJ009675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 May 2024 07:24:57 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 07:24:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 07:24:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441COv2m116160;
	Wed, 1 May 2024 07:24:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Jai
 Luthra <j-luthra@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
Date: Wed, 1 May 2024 07:24:54 -0500
Message-ID: <171456628680.605009.13506755808765168770.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429-dtb_name_fix-v3-1-e13d58e744ef@ti.com>
References: <20240429-dtb_name_fix-v3-1-e13d58e744ef@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai Luthra,

On Mon, 29 Apr 2024 12:14:50 +0530, Jai Luthra wrote:
> Fix the output filenames of the combined device tree blobs generated by
> applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
> test.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
      commit: f329598c27332ff9e85e5551bed3cab280971678

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


