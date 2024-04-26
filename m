Return-Path: <linux-kernel+bounces-160743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DF8B423D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DD71C22573
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96833A1DB;
	Fri, 26 Apr 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KT+GEboy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D533086;
	Fri, 26 Apr 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171206; cv=none; b=MDh8+48I+9KY0bDnlE4R/TC9INGR7OeM/xK3mgTmbWxt/qoPBMIu7a6/GTt7NN15YXf+LyxiXC9j3tVGNGeJB1UQpmJ4+lw9MqwvmE8wcqR5f3VI4te3ALvEJ6uVldMom8qrwV8ZYk4mD4ajqgiuUCqc6q0EcyuM/xmCS1ZAj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171206; c=relaxed/simple;
	bh=SsJgqLSxsBJlivoh/TVLRf4c17iOeYVymrbBQkniyVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjh9ddeEBJ9iFXtdeqIwOwgzpDszYXWME24UdvTNQlogbZ+OAdt9fx76b11vQv3/egxbda+oDfptX4n4FpRjpo+tzuKsW7Uz1L2Huz4CdyJm6lYDeaFY8U0yPkpMMv2ifi9DhM3aM12g1UnlxBn9s0OrRaEYNnQN2Mvvm+PLs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KT+GEboy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMdxQx028082;
	Fri, 26 Apr 2024 17:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171199;
	bh=vgqhQ+Am3bXOCY7LjxBO6Pfqe1rOIoxtbTs5m9hBCV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KT+GEboyW99i8XBXirA2gefvKiTiw+962vZXEYE2KbOEO3qiCNszA8jmlAEECMTI1
	 f0bJd+NADh83OAiFWNu1Vsd2tFYWHHGCYV5rXPCzYSgK0H7QcehQC0b9um1PvD/6JJ
	 76Hl6ugLYyNH7+TpMDN8Mn4iRXM0iQExDLTtCz9s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMdx4J004665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:39:59 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:39:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:39:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMdwJc080715;
	Fri, 26 Apr 2024 17:39:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Brandon Brnich
	<b-brnich@ti.com>
CC: Nishanth Menon <nm@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Darren
 Etheridge <detheridge@ti.com>,
        Vijay Pothukuchi <vijayp@ti.com>, Praneeth
 Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-main: Add Wave5 Video Encoder/Decoder Node
Date: Fri, 26 Apr 2024 17:39:56 -0500
Message-ID: <171417118896.3483129.8626306085830034202.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415204659.798548-1-b-brnich@ti.com>
References: <20240415204659.798548-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Brandon Brnich,

On Mon, 15 Apr 2024 15:46:59 -0500, Brandon Brnich wrote:
> This patch adds support for the Wave521cl on the AM62A-SK.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a-main: Add Wave5 Video Encoder/Decoder Node
      commit: 252951f6fa6810604d1f727032a071da2c6ef2e2

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


