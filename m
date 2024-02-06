Return-Path: <linux-kernel+bounces-54406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AC84AECF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA3F1F22AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7612D76A;
	Tue,  6 Feb 2024 07:14:00 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76912D16F;
	Tue,  6 Feb 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203640; cv=none; b=cRqnUveeseL6eq72tYwj7Ngf0NoQs+RGs5j62RqJYHc1mtHIzX9UMsyt5zHFtSQ3MK3n0zlKYCIwT8reu9hbyyzLOfzXood0JjDKvOnMEdScwe+lvc66lymYTl6snHLjCIgSsltEfztzWQ9e/Lto1nlZ1j+6vdqn5yph0qpGU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203640; c=relaxed/simple;
	bh=L80wf6kF6QNyvYTWQXgwOGjrE91RObZVe2zi4GsCPQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj4R5OHf/zK9xJZVYZxN0aH40ol0b4WEgiuQeCpVQs+V/17HvDxdSTTScJ/DN00pcnv/NKhfE8SMLKMCSBFoxx6x9f3kd4jhcJO9HHz3P38GB5bRKE8P+ADJ+RBYzXUrJf/5gW+QaZzd2KHosoUJDmNJO/8wsslhmsA0XJZlNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00153;
        Tue, 06 Feb 2024 15:13:53 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:54 +0800
From: Bo Liu <liubo03@inspur.com>
To: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
	<support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
	<ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
	<mazziesaccount@gmail.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH 18/18] mfd: rc5t583: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:13:14 -0500
Message-ID: <20240206071314.8721-19-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20240206071314.8721-1-liubo03@inspur.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20242061513536484fa655b5a0fc9bdd3e7424c180b4e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/mfd/rc5t583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index 5e81f011363f..2c0e8e9630f7 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -230,7 +230,7 @@ static const struct regmap_config rc5t583_regmap_config = {
 	.volatile_reg = volatile_reg,
 	.max_register = RC5T583_MAX_REG,
 	.num_reg_defaults_raw = RC5T583_NUM_REGS,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int rc5t583_i2c_probe(struct i2c_client *i2c)
-- 
2.18.2


