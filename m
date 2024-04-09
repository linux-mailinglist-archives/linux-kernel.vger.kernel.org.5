Return-Path: <linux-kernel+bounces-137564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F289E3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8AE282320
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CB1581E0;
	Tue,  9 Apr 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HGwyxz36"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA29157E9A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692448; cv=none; b=Jvq50f1L7CzDWMiAban8ZyXSJFk25+kxVapn2S7a1JYrabwR7PMm4Xs5cRSEQIKxj7rsGCtSW0/AAJPF1uf98//WS/R5br6K2Lnzbmqksv+Agg1mLoWZbgT/cFEyLOdsuOD7960HkunUkI4tDmTeKi9wpG2g0j/DDIFEvLoqODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692448; c=relaxed/simple;
	bh=R4hWEalNgIc2RUbUIAhMo5HUmFCwGL3grERNsC+lPqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqS/EfEMGGjAskgZwOlFg4olw9qRYTmQq0LprXBQAUqwdVmX6fWo/LYylpGecKm9NcDw1UMjZSGgaUe3i+t3ZwZR9CTScQZnPJlba/lfQQHJvyyBkDOeBY4ST9UJbj9n56L++Ej2HFHRUumnL6fviEr7AOLJc2CE1kxA0kMJEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HGwyxz36; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439Js1OY018495;
	Tue, 9 Apr 2024 14:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712692441;
	bh=EJCDlAS4sE2k1Qyg8UddsBlBjtuABhLA0x+ZvQF/JLk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HGwyxz36voPlRWrx1vnKuajWRNo+fucOHOGcQE8szkZwb7IEo4J4+MKy2zE9tTrT1
	 dpBkF4KotCP1YA1d3nb12ehHXSOowHW28r8LjtXEcwpUKtoWU4//NNxRGxQVZB6bj5
	 yvMDu5VcdYJ8iiaLMfTBCYzDqLvRYnFvTZiD0Ifw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439Js160017623
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:54:01 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:54:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:54:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439Js1rf117998;
	Tue, 9 Apr 2024 14:54:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message
Date: Tue, 9 Apr 2024 14:53:59 -0500
Message-ID: <171269243168.647841.14793451313968418164.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325165507.30323-1-afd@ti.com>
References: <20240325165507.30323-1-afd@ti.com>
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

On Mon, 25 Mar 2024 11:55:07 -0500, Andrew Davis wrote:
> mbox_send_message() sends a u32 bit message, not a pointer to a message.
> We only convert to a pointer type as a generic type. If we want to send
> a dummy message of 0, then simply send 0 (NULL).
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message
      commit: ddbf3204f600a4d1f153498f618369fca352ae00

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


