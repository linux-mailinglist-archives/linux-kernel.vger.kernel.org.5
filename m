Return-Path: <linux-kernel+bounces-160742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D78B423B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DC31C223E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E238F86;
	Fri, 26 Apr 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BzYyJgdG"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9C3B28F;
	Fri, 26 Apr 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171196; cv=none; b=GHQ8FJAXtcGdDpQP5LcSUVQenTLC2w6fUnWdvbR+LW3X6p9XFnO+z87Yn2F7Tg3E1ZRVo+orLpWSsnokH+0U3ZrPKmAAoJPL63YEuGK7xQbimnoQIpglhxBPxmhE3L+N8GZjccRHVsFyFbgxAEqjQrycoInbFpHNYSQ6tQu/dP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171196; c=relaxed/simple;
	bh=TxSRq8lU+FO1wz9CAAqM9mQ4ZXRhWx18mECcQk6dkOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHcdQJwFsuR+S2tHbIUE1gHvz5/dujV9kptmB8j1DJam0+eLOv+ChDyKtisK+tMmzJa3DbBOJiiPsi+sIyagS37bKnCVqAKIblDwZ1rkWcXYrOeXRDx4eLInCB2eOnB7G1t9ZNLWoHJciDTM3cC6Hi4NUoh62JYpGFnE9Um8Obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BzYyJgdG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMdgvR028054;
	Fri, 26 Apr 2024 17:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171182;
	bh=XI72ltkgFJ9+EteFVM+RTl7kWv7x/mLa3ft3stZZMvY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BzYyJgdGm3desVo1prl9/W7OB70iBQxhTmkXDZlAsqhpV88TA6VDlIjWvucbEw8u9
	 A6TjgcM+8I95GOJS+UUbBVrW6DY1WnACz3PnfLRkImi/FSlAXxSev6eBw8CvKVTkS9
	 pP2TUV8WPFuzpVbkr/o1nnMtdfPz1k+KQH1Rv+EA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMdgGC073942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:39:42 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:39:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:39:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMdglU079634;
	Fri, 26 Apr 2024 17:39:42 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>,
        Udit Kumar
	<u-kumar1@ti.com>
CC: Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix UART pin type and macro type
Date: Fri, 26 Apr 2024 17:39:40 -0500
Message-ID: <171417117218.3482975.10699433624709237750.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415095605.3547933-1-u-kumar1@ti.com>
References: <20240415095605.3547933-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit Kumar,

On Mon, 15 Apr 2024 15:26:03 +0530, Udit Kumar wrote:
> This series fixes UART pin mux for J784s4-evm and am69.
> Along with replacing pin mux macro of J784S4 SOC instead of J721S2.
> 
> Test logs
> https://gist.github.com/uditkumarti/a28ec171732e32c16b2666c27093c115
> 
> For fixes, these errors should be caught during review but missed due to
> cross reference is taken from tool's output.
> Note to self, don't always rely on tool's output while reviewing the patch.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-evm: Fix UART pin type and macro type
      commit: d79fc91456338f42e9066cff91e3b4ea174986d4
[2/2] arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro type
      commit: e1818f04eff632bad803f85d24dbfbfa3ddb5218

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


