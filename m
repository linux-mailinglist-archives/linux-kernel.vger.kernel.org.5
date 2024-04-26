Return-Path: <linux-kernel+bounces-160737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9E8B4230
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF9DB21923
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D4381A4;
	Fri, 26 Apr 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v/0qTFl7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7425569;
	Fri, 26 Apr 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171055; cv=none; b=ZUTQJJ7eeZU6rurKZS3G0LV2aFjRmxZnb44TfffXJsHIBTvN1t9bS0mMYkVZ+BFuvC/TWcvztohGKv0eKL+sW+L1Wo8JQ3ihJeRqHr3lhTD2BqbffvRksyqdg0JcXlppEqDBnj5ie2b2lMcvq0W+OndnuMxGvv6Y+KR93IwRm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171055; c=relaxed/simple;
	bh=VJzg7/h/ntIWDkImbv1wTuAUtG3sd15UK9WYzlWmpC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o143I955PkiacrbskObdqWEzTFG4/c0WcMWvCvCmtQuse5LjUCZaPoxGAQm4g0uPsPp209IqFZhOO0JSCOyyGp+7++WKEpeh6Qr9w71I14bdRSyZAv0MJV0TEVdIzkNiSg1A2cBSXC3IoDuJ2TWyDdQqGu8gHcw80K72s/jmwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v/0qTFl7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMbNGk027708;
	Fri, 26 Apr 2024 17:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171043;
	bh=jbZZHwVA4fpz6fvWH6qyS6P9uF7QISLrln3DtabcjCY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=v/0qTFl7es7ffKVZU0YTIPpHQ7+fYzwoApk+VikZHQfm9YmET23n/f19N+BF/Yh5x
	 imfGbhBUH4/zLI+SqaDjwptR0q24WbzfcTvlh1gv203vOOP3b3Yy8btZZWtj2kZ2PT
	 ioUG3amlOVtSaB1bebtl75TGKiW9bEjn7Gm/I83I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMbNpC058594
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:37:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:37:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:37:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMbNUJ076651;
	Fri, 26 Apr 2024 17:37:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am65: Use exact ranges for FSS node
Date: Fri, 26 Apr 2024 17:37:21 -0500
Message-ID: <171417102550.3482062.1616101241058926180.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326205920.40147-1-afd@ti.com>
References: <20240326205920.40147-1-afd@ti.com>
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

On Tue, 26 Mar 2024 15:59:17 -0500, Andrew Davis wrote:
> The FSS bus contains several register ranges. Using an empty
> ranges property works but causes a DT warning when we give
> this node an address. Fix this by explicitly defining the
> memory ranges in use.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am65: Use exact ranges for FSS node
      commit: 8ec19dbe9217edbb564b16a5f68465b8cd42a167
[2/4] arm64: dts: ti: k3-j7200: Use exact ranges for FSS node
      commit: 98b939a9b3204120bd3a96015d74cbe818a3a2e9
[3/4] arm64: dts: ti: k3-j721e: Use exact ranges for FSS node
      commit: 74904fc1f1f1c802eaed10edc3744f0997c154ff
[4/4] arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node
      commit: b3f629482cade3a6ada44d2e83dd65f0f1ed1293

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


