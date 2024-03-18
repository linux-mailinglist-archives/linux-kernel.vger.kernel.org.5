Return-Path: <linux-kernel+bounces-105720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B887E367
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7722816AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EA22337;
	Mon, 18 Mar 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V3j2kBdr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EC4C84;
	Mon, 18 Mar 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741356; cv=none; b=DZanEnvAVcod9Ud/PF47v0bpJuTxcdVvvo5HitYo+D4hDXcKIKPUS5KUpyEahSxXX875DZMfNJqw8iTRCetWhi6OwgCqO1ii8/FjhZAHPkEbkuM7DfGYURBRLdYOZjA50YyLPDLyzLKWhqRaPjo5Z2VFNa+rxHP54yCyPfumhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741356; c=relaxed/simple;
	bh=j/Ss5DMv9UPR2GoQ38F+FOQNt0A1Eza7EAmHZss64VQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WaVfbmambnEz8VKm6meB2yH1KywimOZZq02IIGdWiIFIoyG3x95+oAABf8SQG4TPCOuVkLfhKe2b7vRRH7qSXp/ExujPTkhrWgTkeSW4NmsbdvHnGbcHzh9qOfYiwnNUoCtAfdQnPBmUBs/nNKA4DFrSEQ+/ty9caG/eVajxb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V3j2kBdr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tPWG115591;
	Mon, 18 Mar 2024 00:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741325;
	bh=pFxI+pQ5jjRgIwAq7NRn7tOdBICtoztZwb8r14D2wZ0=;
	h=From:To:CC:Subject:Date;
	b=V3j2kBdr8BgVKrqmzwbtv1v/8++YfBtfVPr+eRDOq1Heg8SSvHQ3s83Fa7MCoe2kj
	 TZnNhoSZ/MhmZKqm9knaurZRxeVYuo79VteZljYk4AtUttzNN15VnvEIyWmHTXKdnj
	 8BuBjEvRc0kC4ReyhiXOuwvfoRthE0YLizl6If/o=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I5tPmP016264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 00:55:25 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 00:55:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 00:55:24 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tKiE082113;
	Mon, 18 Mar 2024 00:55:21 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 0/3] PM: wakeup: make device_wakeup_disable return void
Date: Mon, 18 Mar 2024 11:20:51 +0530
Message-ID: <20240318055054.1564696-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This is a follow up patch based on discussions with Rafael[0] on a previous
patch I sent to propagate return value from device_wakeup_disable
further upward inside device_init_wakeup

However, it doesn't seem like today any return values from
device_wakeup_disable are very useful to the caller.

I could only spot one caller of this function that was actually
propagating the return value upward other than the PM core calls. I have
tried to update sdhci-pci-core to work with the new changes

I think that the patch 3/3 should go via Adrian or Ulf's tree, rest are
all PM core changes.

[0] https://lore.kernel.org/all/CAJZ5v0jbHwiZemtNAoM-jmgB_58VqmKUkqv4P7qrPkxWzBzMyQ@mail.gmail.com/

Dhruva Gole (3):
  PM: wakeup: make device_wakeup_disable return void
  PM: wakeup: Remove unnecessary else from device_init_wakeup
  mmc: sdhci-pci: Use device_set_wakeup_enable for en/disable wakeups

 drivers/base/power/wakeup.c       | 11 +++++++----
 drivers/mmc/host/sdhci-pci-core.c |  4 ++--
 include/linux/pm_wakeup.h         | 12 +++++-------
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.34.1


