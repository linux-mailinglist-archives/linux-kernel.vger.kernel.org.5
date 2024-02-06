Return-Path: <linux-kernel+bounces-54307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603384AD89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF424B21210
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F657C6E9;
	Tue,  6 Feb 2024 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SRJZQ4qN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C57C0A4;
	Tue,  6 Feb 2024 04:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194008; cv=none; b=r0YyI86iZdkH05LEqJRXQNkduZ8CryMjYCyAfIWRvL/NtFt+2R4Ly6XDEsFOeBNE4pK0+l2viO+rb2Qikds2ZRln6QgxSufliJh/vd2mweNtp7RTMpNJ/+cpN/oVCa9oWQZ18GIAbx3RW4Gpxx9tJw0yPhDDw8G9eIH7jEtq/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194008; c=relaxed/simple;
	bh=OaaGjGJS0/9pYL9p814XKZkw2IYymdVPU/1l12f4t1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjyV2pcGEguAB6akQNZbisilwt75xEvHxPf/ZI+ydcivIgBJ4W0Z1RVy1fvC+rl6u4lMc0uhwXJJYFZX4nkIDMAiN87IzXjMLPQXex3sBWTnNe52p2pKrp4xZt66zHHMVsA6P36SgCu/LD2XyhY98IFBTyV5xpuLrynqBiz9Ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SRJZQ4qN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164XGR9017087;
	Mon, 5 Feb 2024 22:33:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707193996;
	bh=FZxDQN02GC4AHMWFMEf4txLmiJ+2Oz3f6hT8apWs9+A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SRJZQ4qNyyT31yQsjI/PN2aCFzDE5bkuvD6QVtM9uGHxVi8v/4tyRHG3vT4RXCrPh
	 ml2cTjdoBmsdaffyytxsBaPoefvXNOWKrNtAMzucIXIAACKMzqZAYYOzQpeCdmXP2r
	 899JezqHpPqPUAycdq319dOxc2upWI0l7g3B/UGc=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164XGS9104553
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:33:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:33:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:33:16 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164WFp9088075;
	Mon, 5 Feb 2024 22:33:13 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: phycore-am64: Add ADC
Date: Tue, 6 Feb 2024 10:02:03 +0530
Message-ID: <170719349984.2245010.9672098246589016677.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201001439.3259450-1-nmorrisson@phytec.com>
References: <20240201001439.3259450-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Wed, 31 Jan 2024 16:14:39 -0800, Nathan Morrisson wrote:
> Add the ADC node to the phyCORE AM64x and enable the ADC.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: phycore-am64: Add ADC
      commit: 61fc6b43f0e321e265164701d3bf65a2e5157720

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
Vignesh


