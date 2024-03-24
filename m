Return-Path: <linux-kernel+bounces-115287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1143889388
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC4E294F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67015ECD3;
	Mon, 25 Mar 2024 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFK+ZB5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0C80031;
	Sun, 24 Mar 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320504; cv=none; b=kWM0+VFyee88gZtppVrBeDcCpx+n0ZvvisIrlb5LdNp2hn/2LsX92KmSkp7hUWFJzSNYkAW3NbetW7oocew3dbkxZBUtm+gN5C9/zo6V2h3sQDA+4ECE78w++nsW0102ReKBw0M1B1e/kC2V7iH0qclBM6rXPoUwJcVS9VxMnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320504; c=relaxed/simple;
	bh=hznCVND+HknEJDdeppqPpocutl/j4K2q3jGl5en2yYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTulxpvimDgXcJxPeDg+BvBCtdUc04JYE+kyqyLHhElEpUZBDk1ktbc2CqV2XmpwTsyG2LRUQSKxAOudyNV7/zAFl5U5B5t5hYaVZp7rITBLOR0cfQa9CXo/ok7doL5B6PUn9i4utT4EN9SAL5UawE+rP+r/VuVhN7Gcm8YYqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFK+ZB5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44B4C43394;
	Sun, 24 Mar 2024 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320504;
	bh=hznCVND+HknEJDdeppqPpocutl/j4K2q3jGl5en2yYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFK+ZB5cVYTcZ0bTYAdt3v7xzWpjl7ZJAlp/tCpJj/LVNzjeUQo2+sfhmaqh3vDhv
	 6SBC8xZneh/E5lP4VhnMkgkSrGf8wY14QA/WyuE+JONJDEERGWjatmJvIuGKhZYR4J
	 7YCCOwc+RvQBBrrmYcbcxC1TC9y8wvFOXW36L9gumI7GrARjO2ge2sReY0Da9sUoUW
	 CnD38OUL3yhuO75tU8eFq6GA8YFU4iukkEX8N3o2qsqqeDS/guQhhOFoDOeCK7jYyE
	 LtDZlrbxK2Oxh5kMmFTqly5J+Nl6YkVv5kfC3ZKf1TWAwDFOkJKUx3bCSHoPsXFijj
	 HpelPWZSujKAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 064/713] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Sun, 24 Mar 2024 18:36:30 -0400
Message-ID: <20240324224720.1345309-65-sashal@kernel.org>
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

From: Jiawei Wang <me@jwang.link>

[ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]

Like many other models, the Lenovo 21J2 (ThinkBook 16 G5+ APO)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 5587198751daa..abb9589b8477c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


