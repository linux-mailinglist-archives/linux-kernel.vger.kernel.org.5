Return-Path: <linux-kernel+bounces-115556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E5889C61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E541C29F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F224DBBE;
	Mon, 25 Mar 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEKXJkz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97314B09B;
	Sun, 24 Mar 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321066; cv=none; b=aWOSkUGoxU+o7qmPfiHEkmokY1Dr3vSG5d8n8pA/YL57Xyrzh84BeBU+kjcylSBXib4fiu7yPf76xeptDg8pCShJ6ft3WtyzU5u1YaDjurEtgBgR8HKtCsmc5TvQrEGnEFrTMZe4PYINSHPka/QJwy3TtCATp30sCxwm/I9F9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321066; c=relaxed/simple;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj85jMsoi8s0Uer94mYV6yvHeEZDHmLakcjZJn4gdic+7Vx/YkuWHRa8CNxC49TaWy3RLmXYRY560qD0wkvS6WwhiknveVc2uEJoO2sEkmf2OifLYo8aWRq8Hy5kiDclCuyRHif1HvwqH45dFQ8WpXsACHO7psanhUf0sXgHfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEKXJkz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60266C43390;
	Sun, 24 Mar 2024 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321066;
	bh=pRFSzQtLhCFk2XS/KpLm33y704/cqDGYsr0aJwn7PQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEKXJkz6pUmHiX3nrW5HBp3QXuEBvw6NOYu7AV5ea/K/HIOhGbOYekjmO3in0imTt
	 4+LeTRypHCASI43RH4oe3BtZCrWbvWCHbAgnFRW3iY2bFkzvfmpr+S8SCuGFhMhEJK
	 fLzNuYBM805lD+TUMti+IhV/GwQdGibW70oeoqemHvTVscWzQnNu/BFTr+c+EDyn8y
	 W2ABM9A1AI7sOLMMGHt0nhdMg4XMqy5bVagxZ9YIKPd1dMokHtBL1U6lz0jR8CoTVr
	 1nN3mRauKGH2TMcBVurwtf7s69HksBVQICgkU2o8Zy2JbOkm2V1qb37O1jeik2vJ2T
	 5t/47gLW9IkFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 630/713] iio: gts-helper: Fix division loop
Date: Sun, 24 Mar 2024 18:45:56 -0400
Message-ID: <20240324224720.1345309-631-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit bb76cc45dcdfcd962a5994b8fe19ab74fc6c3c3a ]

The loop based 64bit division may run for a long time when dividend is a
lot bigger than the divider. Replace the division loop by the
div64_u64() which implementation may be significantly faster.

Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Link: https://lore.kernel.org/r/Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-gts-helper.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 7653261d2dc2b..b51eb6cb766f3 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -34,24 +34,11 @@
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
 	u64 full = max;
-	int tmp = 1;
 
 	if (scale > full || !scale)
 		return -EINVAL;
 
-	if (U64_MAX - full < scale) {
-		/* Risk of overflow */
-		if (full - scale < scale)
-			return 1;
-
-		full -= scale;
-		tmp++;
-	}
-
-	while (full > scale * (u64)tmp)
-		tmp++;
-
-	return tmp;
+	return div64_u64(full, scale);
 }
 
 /**
-- 
2.43.0


