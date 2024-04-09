Return-Path: <linux-kernel+bounces-137546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C889E3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA392871D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6D3157A49;
	Tue,  9 Apr 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PRYAca2e"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9815699E;
	Tue,  9 Apr 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691460; cv=none; b=heOztq0xiYRqqUiaHIBMb9A1rwyw+ywN+yLD+yj+FJcX0Ji3ko2Zvzor9zvVfJS5QKWsvzWmqMQCZk9R9Xfb62xcwI4IPXtNjo0qU9bDLaPUR4aLiFXTqtf9fQGKVNz1WNO24pCS1OYii2IlCkdfdcVktQrcWkdICjeUfvMZQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691460; c=relaxed/simple;
	bh=RpsZ/E5woailLraq+rLciStxEis1JoVdknqghnMqJKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjW2JVtx+HORjZ45yu0WHNySa2RvqMdIAtzkbipifhKucO8vvxiiL/GoD9j74dnA6smzP7cOENSddYJmZ1U/U/hfzMvVLQu2mYflyFYRhN1fykl5AqmS3ufYwLDX1afpx/Xa57EFXYk6imHFAg2LDNjtAXM7g34PzL169LjsdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PRYAca2e; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JbKUr034799;
	Tue, 9 Apr 2024 14:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691440;
	bh=jtWSn0QUC1RtGshhNU5i07HfuZDjb28710CEBnY+WlA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PRYAca2efendeUx7t/5SnqNwdjdwOpHYWdUa0qH/jrynSpb7uMcMkgZTC++rm8G4Y
	 EXSVqwl1r/ZHaBykhoZUfPsaUcw+X1ZrdG3DAvacMgaS99DGknOaYQM6wt+5wZ+rgI
	 cxcBXVdesNu2PVtCeTe8CT8Z8+lEPj2qhpE3Hv2w=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JbKBP012948
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:37:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:37:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:37:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JbKQ2090612;
	Tue, 9 Apr 2024 14:37:20 -0500
From: Nishanth Menon <nm@ti.com>
To: <max.krummenacher@toradex.com>, <max.oss.09@gmail.com>
CC: Nishanth Menon <nm@ti.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <francesco.dolcini@toradex.com>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: verdin-am62: Set memory size to 2gb
Date: Tue, 9 Apr 2024 14:37:18 -0500
Message-ID: <171269142225.642948.2709707830763732879.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320142937.2028707-1-max.oss.09@gmail.com>
References: <20240320142937.2028707-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi max.oss.09@gmail.com,

On Wed, 20 Mar 2024 15:29:37 +0100, max.oss.09@gmail.com wrote:
> The maximum DDR RAM size stuffed on the Verdin AM62 is 2GB,
> correct the memory node accordingly.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: Set memory size to 2gb
      commit: 7e8eddc5291f5c94dd28227a73b7573b671f4a05

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


