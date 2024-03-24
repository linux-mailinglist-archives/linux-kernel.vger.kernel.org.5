Return-Path: <linux-kernel+bounces-113636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75956888E20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164D91F2F10F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0C82D88;
	Sun, 24 Mar 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBVxlHSt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12A13FD7C;
	Sun, 24 Mar 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320550; cv=none; b=pA9tRPGPgTgI/spKlb/8s8NEXz6tBYT0DwyOjrQZSnfkOslzjvDai128ANUFWU2x6kUeU0cwViyBw9V0mcnT9+A/gdaeyePXRV34/9ZRMsBEm7NESnfs6okXiNS/DggeiMnwhI3Wpbgkr7IGxQuGFaGDhie61Ds89tDMyEDmf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320550; c=relaxed/simple;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C71PGBDL0K/6X0tBt0nExf4Hqm/4HnYHLCB/qJt+s/FqwmpTAuJw1f7rBV3BI2yBAYuhLdKznmI+xwmAi3B17oeN/Wea1eJ0Ly+IBSOXLcT0Rl1H/nJK8E9VyalGZJ6AIgJFrQRxRsTpTkc9VdH73k2+Q6hvkpOdSp/FvTQ86Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBVxlHSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F18C433F1;
	Sun, 24 Mar 2024 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320549;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBVxlHStnSInKIzPJ0DeH4oIdQka17CGBiI3J57VQdweiI70eiUyF/0q/BmplM0QB
	 LXHfebXCauOHfSEZkix50fyJ8aHBkprq9qJcSQrL1kBifDsgjLd4MmCUvZ//Ex1FCc
	 3BCDTgtjBiEaSeHVkKOBzlR0/mJbDS+eGOKBlWkpGlQJx+BS3219D5aLJ8C+LfpIt+
	 q/g2DlvqBiaUaA6i5BvOt9RZ8ZfRNUZYxlSLeO+mrd/z4gGSTjIsb017hB3ePjAK87
	 P5jA1/gdp7Q3SeBFGtU+SeqHMr9c9z5DfUxeZzUjeioPVwHHZujM+Hxf7nZKHVPUA1
	 FOEIkf6EzpSDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 110/713] rtc: test: Fix invalid format specifier.
Date: Sun, 24 Mar 2024 18:37:16 -0400
Message-ID: <20240324224720.1345309-111-sashal@kernel.org>
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

From: David Gow <davidgow@google.com>

[ Upstream commit 8a904a3caa88118744062e872ae90f37748a8fd8 ]

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/lib_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index d5caf36c56cdc..225c859d6da55 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -54,7 +54,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%d/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
 			year, month, mday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-- 
2.43.0


