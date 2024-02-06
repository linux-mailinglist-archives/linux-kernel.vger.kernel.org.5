Return-Path: <linux-kernel+bounces-54303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31684AD7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101EA1F24980
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFE77F1E;
	Tue,  6 Feb 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k9iWCoXe"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316C77F00;
	Tue,  6 Feb 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193947; cv=none; b=VSD3QzTZFVdJYPw+to6JJ4E4cncONjdy0rqjvUCvfFhH99Vf5iKsUkqgzbnTsx54g1wQOcyKJ/d3uKCqzisjOBZleLJHJDg46SUI+/GKb/u0ZvXHQCU9bVBsfIUfVCWgf0/jWIbh+uc4NPW+DaEu/IO16BF10P92sHimuLN5mDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193947; c=relaxed/simple;
	bh=13DEo3P59aqqpZXJ88ROMXh/erX2LipT1Fmn8/kIssc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnjOz/BCLrpXIZmlsmDZ2HsN5rtvxJs30vvk6IziWVTPAeRO1V7cnYu3b+S9p8vAv99XKvz9RRWTJHEj7R/kPF7C2o2ImPA2O5g0vr/BM22+kQPm9YRbmjX4lH5axrgKcXrtMkKZm+QhXfQfiOiUJAJ1QEUEdN81eH4WOfMqIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k9iWCoXe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164WJ72088513;
	Mon, 5 Feb 2024 22:32:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707193939;
	bh=39YzDSWRuG6QU1XDbYsq0RciMuPlttN+beiEGqHIerY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k9iWCoXeTKS9GIM3oJT4xC9la/0ow/jZrg/AOw8xshmeiUWBiAKrTDF7oegQPqnBT
	 XTnQktgn/uY9II71SU04r7CAFtIVasNr/bxjCcYqeouwWdR1+DRSheqRDPG1iSR0p1
	 iwEhsUsnYqHVYcjrMg/evScFgcQyZ8PQq7VAmVgg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164WJD3103592
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:32:19 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:32:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:32:19 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164WFp8088075;
	Mon, 5 Feb 2024 22:32:15 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: Disable clock output of the ethernet PHY
Date: Tue, 6 Feb 2024 10:02:02 +0530
Message-ID: <170719349981.2245010.3205058653973869263.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119225257.403222-1-nmorrisson@phytec.com>
References: <20240119225257.403222-1-nmorrisson@phytec.com>
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

On Fri, 19 Jan 2024 14:52:57 -0800, Nathan Morrisson wrote:
> The clock on the ethernet1 PHY is turned on by default. This turns
> the clock off as we do not use it.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Disable clock output of the ethernet PHY
      commit: f4ee6882ef25959f14c61aa76515fe301fa45a99

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


