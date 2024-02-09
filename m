Return-Path: <linux-kernel+bounces-59548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E584F8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CE31C239F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD074E36;
	Fri,  9 Feb 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AaE9aeqK"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5671B3A;
	Fri,  9 Feb 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493446; cv=none; b=J3mmZf7WgDtIwCJjIPxdXjhukJuBLAWQ1RitvmQN3l7SQSAzwM41/+3uqu3PePo4zeKLu030prbBkNaTJ5x1HdvtmWaqc40JTODPoYZ8r0Ob+wb+p9pocjpDwQ1R/xEsyLtklYSBaA6ib05DxEWnfRDsnIq8tarNQAL3gqivq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493446; c=relaxed/simple;
	bh=O4/YM668cDKSHelku3SxggCbwo1G68KwNgmDfW7ur/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvW1Pp6bj0/ZTYU1N8ZbmuiAN/BKCLkFhSQ7WHEg3vHMthz/S9XVJtvGo3tMotaFmnRhVrHmUb/1kCLyFYk/LbQ1rpk/2CVA7GHL2e5TdbQWqXRVL4aY105NlfTrzmxZmr2ATYVO07jYp1XoCv1YPyoqxZKEsy09DtSaE637nBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AaE9aeqK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TWdSH5lyhz9t4t;
	Fri,  9 Feb 2024 16:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1707493439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8PypmVbsnCrC9vOiFkAsVoG/5dR314vcsbeC6i7o88=;
	b=AaE9aeqK97OIAPqXITM/NCWrmdwiH365Skq0RD5OcfcCktcP1M/IOXjHDTIqFQvBdVnrOO
	S0wK0iC1MOogj/Kr6nIPoQKmwpBftXxMjooU4nTMYAk5ZfIT1OSocG9ScUBbbFwj0hJgYo
	+TJnJFaKu9YgrrE7zgiY5LHaF/mWOgdY39PGseDwJzP96caKY6OgaFNB1W8SRjew0N/7/z
	t6kkzgwP4YSu+hS9X6YkcyPuaFGPq/AA2jZJHXB3z2/Jz0klkA54QNDC8jnokYSE6rxYOD
	S7QZA8l6XWicO0+qnR265H8Dle6IVq+3VBwVN06OzQ9ZqlCMSPkJJr4QmaFlug==
From: Tor Vic <torvic9@mailbox.org>
To: Perry.Yuan@amd.com,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v3] cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()
Date: Fri,  9 Feb 2024 16:42:26 +0100
Message-ID: <20240209154336.7788-1-torvic9@mailbox.org>
In-Reply-To: <8eefeeb7-f8e8-49f4-b83c-e67a9e728f41@mailbox.org>
References: <8eefeeb7-f8e8-49f4-b83c-e67a9e728f41@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gz74hbj39br16tma89hs5oeudf64gmsk
X-MBO-RS-ID: 5d468f1bf389e51a998

In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set
to 'highest_perf' instead of 'lowest_perf'.

Cc: <stable@vger.kernel.org> # 6.1+
Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
v2->v3: Resend with git, misconfigured mail client borked v2
v1->v2: Add Perry's 'Reviewed-by' and 'Cc: stable' tag
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..aa5e57e27d2b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
-- 
2.43.0


