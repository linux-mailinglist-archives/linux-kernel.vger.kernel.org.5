Return-Path: <linux-kernel+bounces-101039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A111E87A130
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DBD1C21D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB388DDA2;
	Wed, 13 Mar 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jwang.link header.i=@jwang.link header.b="SqGtKKwB"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91266BA5E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295212; cv=none; b=tw4BimBLBGSJolH74rCUqhKpv5b/85ZtgIYckT9q/96PAOraEKwOalkt9lXMUNR+i5Cb3dIXDJ3iYBQ0BZVso6ZI2lgo1fB0P54vKCuZ8Pby9/9mceOidUpgGK3Hxf/MerGiRKGXkFUaveF9VR5YY5n4XY6oBP314hCmmUGP5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295212; c=relaxed/simple;
	bh=3S+ml9Q6wYDAd17jCHPrCumLNoYX/YCTLP2FSb8YSPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drwasu5DZCTDd3DOJnD4z0U+i64+s3oYR/8n+H+W2poaYy6bSCsslHoeH8TigtYp2A9spW4uPKrCNvuIWhJzjoigInUxwfaIsXXZGjrh9YA8iSCumlBySdaqszbJQiLRWL+nwGXOpmidBhQA7Ax8MX/cYwq2i8tCMH5NT5B+GF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jwang.link; spf=pass smtp.mailfrom=jwang.link; dkim=pass (2048-bit key) header.d=jwang.link header.i=@jwang.link header.b=SqGtKKwB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jwang.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwang.link
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jwang.link; s=key1;
	t=1710295206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujRJgU6f66VX27X6ZaO6EbWjKporwX3PrXShnhBOR40=;
	b=SqGtKKwBA+9PAhnDNa8xlMraSaT8Xd4BXgV6BbwBzvzvsFJlizH9Gu0sPusdbx0F0YNf1i
	UHBRtsVe5am0GEz1KSD/bbrBLBf7MldZlXK2JSJfpWXGu0/KRXuCnCu1cTketO/dwqhj5R
	lKOrN4wAEoGiLNf5mZRY7fRYs2ErhsGeqQAhUe2S36SZQurSzXdKqqlZTYgGvcDZvPRZnd
	OTgJLcIhGrucBmrNiZLMNqjk9ffHatO37igluSFxs4xJSCerQnwt0EuHZtrJt9Lel8n1YP
	qL7hwLoEth74OxLKDbIiDYjZKJkA3WJ7GQykkzQblA0+iyvcjuHKAC1k+Xl1jg==
From: Jiawei Wang <me@jwang.link>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	me@jwang.link,
	sashal@kernel.org,
	vijendar.mukunda@amd.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"
Date: Wed, 13 Mar 2024 09:58:53 +0800
Message-Id: <20240313015853.3573242-3-me@jwang.link>
In-Reply-To: <20240313015853.3573242-1-me@jwang.link>
References: <a127404b-a071-4917-8ddb-d7371c721827@sirena.org.uk>
 <20240313015853.3573242-1-me@jwang.link>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This reverts commit 316a784839b21b122e1761cdca54677bb19a47fa,
that enabled Yellow Carp (YC) driver for PCI revision id 0x63.

Mukunda Vijendar [1] points out that revision 0x63 is Pink
Sardine platform, not Yellow Carp. The YC driver should not
be enabled for this platform. This patch prevents the YC
driver from being incorrectly enabled.

Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]

Signed-off-by: Jiawei Wang <me@jwang.link>
---
 sound/soc/amd/yc/pci-acp6x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 694b8e313902..7af6a349b1d4 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -162,7 +162,6 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
-	case 0x63:
 	case 0x6f:
 		break;
 	default:
-- 
2.39.2


