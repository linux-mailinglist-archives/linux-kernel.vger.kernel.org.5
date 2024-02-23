Return-Path: <linux-kernel+bounces-78953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB4861B49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793C81C252DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934D142627;
	Fri, 23 Feb 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vnm2bnvp"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5F85921;
	Fri, 23 Feb 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712113; cv=pass; b=bh+p0ILDGXOF6BY7w9mCuccekZKGUEDNkYEC1ldbb6c0qQYYZ1Dtqe1YrAzrqFjQ3jkVMlyYoosFmimCNcews3NXE/8yUcwdVqSokPjIEIWE4eRAAC3iv4jOzHCUsMNpyyosIi2hz4H9nhGGWEg2ReAf4hWvcWRM7Of/JSXLmjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712113; c=relaxed/simple;
	bh=DXoAv6nWtSnax5gpgzYWV2FQ2CM2/oxmQvrmypdakgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VkPSq174VVUvRXTvgl5IJsfn+AlW3wQlLPRV/npqQMxvoH4bzcohCs9LZp2/xnNk424xNYJOL3RVlTcc8X3B7OPS9wY+XidJvaj+YeYDJm1aZ4596rVJbJCQ1xLWcV1ObNXlaOPomeViLCgiXi/GTHoPjWjEYosAFaD1BK79tfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vnm2bnvp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ852LxVzySZ;
	Fri, 23 Feb 2024 20:15:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuDIC2TYItyBBAHAljRCUREA1IAevspnj7ORVX0Cjko=;
	b=vnm2bnvpqIbRbxL+DtF5effj4SqLkriy+ALOdsOrbgsaAuwSoreJYLb81C/5GgsO/LSJxx
	doTZDXLHWY7eK2040EMB0wvf8xiiAnkRRTMecGoyLvzH9pLvNsyEho+bfh+BosCOq69yLa
	gK1pt1WKExuRapAfo+oki/On7FfiFqc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuDIC2TYItyBBAHAljRCUREA1IAevspnj7ORVX0Cjko=;
	b=tzOJgM0wFN1EETOfi7Yy1xgP1WepLWe6m5GM5mTtPa3b1mt2/FRh/L5JpUCGlOwkqBwljO
	JSmp/4CXTE9QQgeo64gqeFrSZ5BPgFJJNepwnE2lLKwTDnP//u+ZdmU56BvyYwu4pnNKWz
	CPhWG7ph+fhoWaXheJCpKyjW06RrcwM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712102; a=rsa-sha256; cv=none;
	b=eSaJDhlOT3nv110wlI6EBvUbbuX6qBH22AilK7u/op/qLZDaz46dc9CdjFm3n2xzWUaxjC
	ahniTQOGbqZk6HWFEXtiVo79wsJtW2wdoV7ZfUtggk1bDERepA0gtdito78d82tQM/H4eP
	Wq2oLmZTCI+KigjEReCVnsWErf29JLQ=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/5] Fix MMC/GPIO regression on Nokia N8x0
Date: Fri, 23 Feb 2024 20:14:34 +0200
Message-Id: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Nokia N8x0 MMC has been pretty much broken starting from v6.3. These
patches restore the functionality. Tested on N810 with eMMC and external
miniSD card, and on N800 with SD card in the inner slot.

A.

Aaro Koskinen (5):
  ARM: OMAP: fix bogus MMC GPIO labels on Nokia N8x0
  ARM: OMAP: fix N810 MMC gpiod table
  MMC: OMAP: fix broken slot switch lookup
  MMC: OMAP: fix deferred probe
  MMC: OMAP: restore original power up/down steps

 arch/arm/mach-omap2/board-n8x0.c | 17 ++++++-----
 drivers/mmc/host/omap.c          | 48 +++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 26 deletions(-)

-- 
2.39.2


