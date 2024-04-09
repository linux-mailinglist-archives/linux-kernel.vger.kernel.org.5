Return-Path: <linux-kernel+bounces-137563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C030389E3F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E6DB21E4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591171581E3;
	Tue,  9 Apr 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ocv+byEu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A68157A44;
	Tue,  9 Apr 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692429; cv=none; b=fzbIZ4PTnC9BGE2VaLK4TnHW4fm3EXeOcHmvp0VWL2e51RLuqDK3BEdKgSPOphH7RdiMdfiWhRoiwRGc1dncv60vPPadd6KkQu6zB5zSphQ99rxoihn3fqyKjrOzKfmcGRulmoE+cZg4Wkq1qiP9A5J+d67ng6siUm+18CqiXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692429; c=relaxed/simple;
	bh=TZ3aootWxltD3EKWy6U3UWGchEIxAQfp7i9I1yvoI4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgFvf+1DqWWuPAKKgrlskozuFLbwhhDizI1tOICwcHaqH5uNR3lfkkHSCHSjmzDERVoSEBLTksxYIl29CZKCt7OqOcHFtxBlbBQ74ik7hWnfwZ4gWtVFVFXP2RwPcsGhgQ8rOLgfOTjFjjg0ugwwAIEciwtzSX0T+vx8sqogS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ocv+byEu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439Jrefk067023;
	Tue, 9 Apr 2024 14:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712692420;
	bh=n9yKZ/FE80uwMs/umpNdmhBbpU3Q2Qd45yxqG/HmVo4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ocv+byEuQOD6a9XxUso5SL1ViwFt2yP3x0jGUm3/5X6pgl5Kl638W6wKt+eCJkIw1
	 bQ6bnQD9YoaYQJS6a1V1CU66I5gQPLKzJVCM4F76DvSMZf2c4zRZNHcBkC6x3r0bv9
	 uLb042yQ3sKjGbIm3uHKB6ZoXeAn0SYAMZwdS0gg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JreNE012933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:53:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:53:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:53:39 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JrdFC117545;
	Tue, 9 Apr 2024 14:53:39 -0500
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Unconditionally register TI-SCI reset handler
Date: Tue, 9 Apr 2024 14:53:37 -0500
Message-ID: <171269235826.647454.8602732844398119999.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326223730.54639-1-afd@ti.com>
References: <20240326223730.54639-1-afd@ti.com>
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

On Tue, 26 Mar 2024 17:37:26 -0500, Andrew Davis wrote:
> This series is the replacement for this series[0] and is based on a
> comment in that series by Rob here[1].
> 
> First patch is just a fixup, second patch is the core of the series.
> 
> Thanks,
> Andrew
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/4] firmware: ti_sci: Use devm_register_restart_handler()
      commit: c0e5a431442d7bbfbd3704212680e49faa8ee46c
[2/4] firmware: ti_sci: Unconditionally register reset handler
      commit: 8c8ff39838e02b6df91b80e086426dcb9ac86908

and the following to branch ti-keystone-dts-next on [1].

[3/4] ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller property
      commit: 345d22f4f45369a33b416a96c92bc273e41d695b
[4/4] dt-bindings: arm: keystone: Remove ti,system-reboot-controller property
      commit: 60242b20fe784ef9142050be8b68bd85e94be557

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


