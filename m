Return-Path: <linux-kernel+bounces-52854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D2849D74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33453B26605
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8642C68C;
	Mon,  5 Feb 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NoptUjVs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C52C1A9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144998; cv=none; b=ai8ION+CdNos5WPUMpdVIKDA8RfXBPTCN/Zkc0XoDs3POtxfcpTYNjliGAd7o8aVatQw6SE9uHHv+kTB7+Kfg7La7D5ce7OP3v6c3XYKG+ERTc5ocozKiZm3jecNI5ItCVyWsYKNVDcurbp7AsUNScRFPCWTm7Hu8wGbJh64GlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144998; c=relaxed/simple;
	bh=KZQAVKk17hNGCoiNed1olR8PLExPHWy3Xw9IMnmA5bY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELhKc6QiuLHhnEPJaAGLh5+SXncOBI2tk/1bZEtkJ1AvsWVsw9E+f6YzkYEICTlmLFtEvQfHodr92PHvKt1ghf4pbe8qMw4wNFMZEKH9WZqGs07I6J1m8SjMOFIyZx+LyzC/VZvvFp9wErAL+QAQ31u4MB/agYeuUQ4gCFFu4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NoptUjVs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415EuKM7066929;
	Mon, 5 Feb 2024 08:56:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707144980;
	bh=MHcT7cAFsxqyYHFScxuXokkyTjjYaCWV3c5QCurtdVA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NoptUjVsXsiLzDNz6exsYq71eHnqjGgY03nv0YqQj0AwiojLX87z/U67MyJhDnX2f
	 Z5Y8uCdj7ODtwrfHJHG/0eg6eQKTIAleAmogxB345EnvRSya6sFmyQH3sdHTr7r4Wr
	 ygK3G8GrlWkwTwwviw1Yzq1+DgWDHukllHiTKH7w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415EuKem015402
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:56:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:56:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:56:20 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415EuK46000384;
	Mon, 5 Feb 2024 08:56:20 -0600
From: Nishanth Menon <nm@ti.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Add more TI Keystone support
Date: Mon, 5 Feb 2024 08:56:18 -0600
Message-ID: <170714487232.2498590.16765370636323778041.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125163145.87055-1-afd@ti.com>
References: <20240125163145.87055-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Thu, 25 Jan 2024 10:31:45 -0600, Andrew Davis wrote:
> The Keystone platforms used their own keystone_defconfig mostly to
> enable CONFIG_ARM_LPAE which could not be added to the multi_v7 config.
> Now that we have multi_v7_lpae_defconfig/lpae.config target we can and
> should use that defconfig for Keystone. Add the remaining must-have
> options for Keystone support to multi_v7_defconfig.
> 
> TI_SCI_*:
> TI_MESSAGE_MANAGER:
>  Allows TI-SCI communication with system control firmware (PMMC) on K2G.
> 
> [...]

I have applied the following to branch ti-k3-config-next (branch name
is a bit confusing, but since changes are very infrequent, I didn't
want to spin off another branch) on [1].

Thank you!

[1/1] ARM: multi_v7_defconfig: Add more TI Keystone support
      commit: 69cd52b92782a466b18ea66a1f8b5f9f956e1648

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


