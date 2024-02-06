Return-Path: <linux-kernel+bounces-54329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC3184ADBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B358B2341A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6977F3F;
	Tue,  6 Feb 2024 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cptWNnjQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760E77F19;
	Tue,  6 Feb 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195391; cv=none; b=m5MZRnSWYoMHbqUPk3+8xb/ylDnuJd3cEadYx07RC2iKzqxDW3StH6hUVzdp1/meERr/DJ052mtsuFeN039xHpTKS/E4IhjkJqM5lmcqaXqo4aBUqyAAh8QgeYxH70L8DOQJkcKuqspcNzXyRK5q0n76nGsYrFvCBcRUbJfG25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195391; c=relaxed/simple;
	bh=2fPZ1PQnpBDy5/RYLdEFkEl55oXxFORxMX3LpNnG3bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7wbcbzhbsma+YR2emfE0+aHIgHT7Sd/kw+rlNdKtdBUHFBiQqhDIJdFGjuAB3EuFp+DT3Ll0XPSwnyAdSKu/2H1I9v3uKxzAFWWRfjGU7DtZOi2tY3HY3TX5qUR8KvqdwveM51cx+qtUoJQxbs3s8Cm8aKbwz/nPsHWxtNmtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cptWNnjQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164u7t6027724;
	Mon, 5 Feb 2024 22:56:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707195367;
	bh=qRh8SZaTY7OQla7ebetBPhE4myIl6NnT8HSn998EYkk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cptWNnjQe3y34snuEobIcKcijpueEQhV65OKgrO+OcC2OAip5Gf+FqLGnFDNMCXJm
	 uUuuWXx2ob3EBdWCxdyncgGy3xBB/OaeV+VUM35s1E18YkIiCqvtA8jPlyGoLekNpL
	 OsT3xZvQ39Trr99z5Y/HjZmZHcMAIjTzN/RRHP8E=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164u7Lg023793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:56:07 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:56:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:56:07 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164u2V2001979;
	Mon, 5 Feb 2024 22:56:03 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <tomi.valkeinen@ideasonboard.com>, <nm@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <rogerq@kernel.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <eballetbo@redhat.com>
Subject: Re: [RESEND PATCH v2] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
Date: Tue, 6 Feb 2024 10:25:56 +0530
Message-ID: <170719349985.2245010.17205587189304843387.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201142308.4954-1-j-choudhary@ti.com>
References: <20240201142308.4954-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jayesh Choudhary,

On Thu, 01 Feb 2024 19:53:08 +0530, Jayesh Choudhary wrote:
> VP2 and VP3 are unused video ports and VP3 share the same parent
> clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
> The current DM firmware does not support changing parent clock if it
> is shared by another component. It returns 0 for the determine_rate
> query before causing set_rate to set the clock at default maximum of
> 1.8GHz which is a lot more than the maximum frequency videoports can
> support (600MHz) causing SYNC LOST issues.
> So remove the parent clocks for unused VPs to avoid conflict.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
      commit: cfdb4f7ffdb855c1a3d274dc7757e780dcbf2d55

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


