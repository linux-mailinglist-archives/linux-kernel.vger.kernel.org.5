Return-Path: <linux-kernel+bounces-137553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B589E3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556A61F2234E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748B157A4A;
	Tue,  9 Apr 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u0MKMgqe"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7215749F;
	Tue,  9 Apr 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691690; cv=none; b=XwkKmtkHD8pQwi807PUK9oMXeO+dLvLg1+uXhUjtHYQXhIyniZZ1SSjm5kbUNGwhjHiqSEYIETXbegwIUz3nSjhgq1wDPO6iuUEGmPx4PbqNyoyiR3iy1s88jaUQWV3O8SfSk62JdYrMvmj6SVbiFmN393u1Op1KP/fTKKmr42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691690; c=relaxed/simple;
	bh=nCbBdlZTzlp6j7tLLWZdgaOA5uqTwCPUR1eYhUb/khU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2q5umG/yutAEuSaI8KzdCzz8LPMnVVR4FoIL1Q2x35kV6i+D7GSkHXXltHSZ776MrGDApmLWonOVdmDdc7QMkw4A+ttmDUbkhBr90eQnuSk6KQqFmiivr2QexUsGP9SH9SFLOra61Hgj1qULJQpRHnOxO93yNjhDjoF2O/qrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u0MKMgqe; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JfLmP035516;
	Tue, 9 Apr 2024 14:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691681;
	bh=M1HkbRly7m2KOTKIjll7VorYJYk9cD0doVLyiQ0q4YQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u0MKMgqercA63YM29MWNfkj9sgm6opJe7S0HD/BIHP4lyrQDWPXJdvlKM5+R+6ip3
	 k4xO0bVRrOYkFbwNrT6RAs2fx2nEjXC/fEduDsW8j8KeHBgz26a7zPhNTR7ifjfBQE
	 cQlQVWuT9cs+/j1co5SkqER/zWQt/xPybOcxzGhk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JfLLs057123
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:41:21 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:41:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:41:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JfLc8108768;
	Tue, 9 Apr 2024 14:41:21 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
        Jared McArthur
	<j-mcarthur@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Tue, 9 Apr 2024 14:41:19 -0500
Message-ID: <171269159196.643843.14450504845025067994.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328191205.82295-1-robertcnelson@gmail.com>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Robert Nelson,

On Thu, 28 Mar 2024 14:12:04 -0500, Robert Nelson wrote:
> This board is based on ti,j722s
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> 

Robert,
	I did a couple of sync as part of rebase - but for the future, please
	be aware of [2]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: arm: ti: Add BeagleY-AI
      commit: d2b3e3b544d7e657406db3bdcdc296f02f4f07c9
[2/2] arm64: dts: ti: Add k3-j722s-beagley-ai
      commit: f6a61274cc851e1dbae82b5fa2d3e7087dccf85b

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
[2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


