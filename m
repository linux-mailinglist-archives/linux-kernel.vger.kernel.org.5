Return-Path: <linux-kernel+bounces-53213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67184A240
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD372866B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779F48796;
	Mon,  5 Feb 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PgQLVmXF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8D482F4;
	Mon,  5 Feb 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157680; cv=none; b=laOETMqzwPrS0SnVVtp85WX6C7JacdW16JusSifqDpZSvXb+yLJN1asx0DAyiAwr7or0IY1KkMNIjJWsbExRiv43OK6TF8tK6mk3sN264eINjzGJz8uIjvgq/CC0alEfCjJgBL+Gb7cW3KJHXSKXdJhhzDci+wttD4RUSZEJN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157680; c=relaxed/simple;
	bh=bMMY96zKQOaV7c0QaYEhXG+N+Y2d3Sum11vxyvPZOXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YS+RgVEcW+kAzDDu4qsU7qvuQiqmTadBb6uYcXqqN+PC2FBwQM1TW08MYyAm0ZMfGfkVJQ1Df4ewV8lfr58h4P+n4YaI6k8gnpfLqCaHgtAtxd7wIOU4UZD17HQF8g2Q8BGkc1RnxiQGZ5AN0TrWhBqljgD/mBt9h/85DppFMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PgQLVmXF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IRswT120256;
	Mon, 5 Feb 2024 12:27:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707157675;
	bh=fojgM4V6c/EvbnCvW9bg946O2LaY18YdMAN1MROclH8=;
	h=From:To:CC:Subject:Date;
	b=PgQLVmXFmIC/3Wy/PXSExKb6CiO3aabCHVWBIMxWlt4gBauS9JHEIc0jITO34jU7p
	 BPRvLTHKtaUp0dEP6vcBmLAhX3cP1WhsU+g9Ma7V2WXwWzb+fPZMJ9YH8wIlnkoASG
	 2/NEqkn6ADXpvSxqO0DyWNcOTwhMnMMiN6c/mo1Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IRsLB017710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:27:54 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:27:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:27:54 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IRsX4058567;
	Mon, 5 Feb 2024 12:27:54 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 0/5] K3 DSP Remoteproc remove cleanup
Date: Mon, 5 Feb 2024 12:27:48 -0600
Message-ID: <20240205182753.36978-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

This series uses various devm_ helpers to simplify the device
removal path.

Removing an unused var "ret1" got squashed into the wrong patch in
the v1 series causing a bisectability error. v2 is based on -next
with the first 3 already taken. These are the last 5 patches of the
v1 series[0].

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20240123184913.725435-4-afd@ti.com/T/

Andrew Davis (5):
  remoteproc: k3-dsp: Use devm_ti_sci_get_by_phandle() helper
  remoteproc: k3-dsp: Use devm_kzalloc() helper
  remoteproc: k3-dsp: Add devm action to release tsp
  remoteproc: k3-dsp: Use devm_ioremap_wc() helper
  remoteproc: k3-dsp: Use devm_rproc_add() helper

 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 116 ++++++----------------
 1 file changed, 32 insertions(+), 84 deletions(-)

-- 
2.39.2


