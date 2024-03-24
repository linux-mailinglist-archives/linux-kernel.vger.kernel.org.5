Return-Path: <linux-kernel+bounces-113881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DB888723
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12E61F249B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB6139588;
	Sun, 24 Mar 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2iKSEyp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0251EBD59;
	Sun, 24 Mar 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320938; cv=none; b=qSCw4jhA1+P+9FMxMkf9hkWpVvqqHJC6PzJWiO0MNy5kSbxHttDD4196bwD/liG00jWM0vnYGGTMKpe1p4/ZFn5PSExu+BItLnRSZv6/zY7BSlmpwrSEclH1jGQhhNDK7KQ42NL+lqq7C+2MOeXilNaaFAUW5aDDCodCWTROHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320938; c=relaxed/simple;
	bh=6NKZ+nns2FDi5/2LhPWcehmggKBZIPf/gzGtIL9UKCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhk6+dshx11VMIFP9y0To44M11PcI9mupMc8jVaLcnWW27gTfuFy/BrDf0GiPfGwWeI6tBL2kAquz0VXBQ4CNJWlkq0cw06O7JnZzVTFcu338bFA+5xm6nEVb+ZRUCscPo2zCtYNsxlMQmtQGQ5G+o1OqqtrnXdP64Cq72Db4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2iKSEyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7AC43390;
	Sun, 24 Mar 2024 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320937;
	bh=6NKZ+nns2FDi5/2LhPWcehmggKBZIPf/gzGtIL9UKCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2iKSEypyV4lE9wITaGCoKtewfcAIZt1PLVbg0i3pj5ZMhBvScpEuD9M7I6PCtozI
	 f0WlicexwB7FgKP8Nmp3yH83kUN+8o51N1zz1TayjJRuoLIYFnDNo91GT2UoUn5JRj
	 EQZ3ClX0flsGrmXga0ca2almXGDrkrpeRuZWugurWiUwXxbRoyxHl1QkOdXdZsvpUd
	 AxPGPuYXLEXaOjoi3oN9C7HlMrjo393cxLBnFriPTjRqnWPnobI8RLUh9aPlVSOC2X
	 dC5bQ63LWsftnsEZ9RarDmsM0NEqM0NERoQS1mGc7trO7DCVT4BHHAhuSf2Vba153L
	 05Lh6+rVxpwpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 500/713] crypto: qat - avoid division by zero
Date: Sun, 24 Mar 2024 18:43:46 -0400
Message-ID: <20240324224720.1345309-501-sashal@kernel.org>
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

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit f99fb7d660f7c818105803f1f1915396a14d18ad ]

Check if delta_us is not zero and return -EINVAL if it is.
delta_us is unlikely to be zero as there is a sleep between the reads of
the two timestamps.

This is to fix the following warning when compiling the QAT driver
using clang scan-build:
    drivers/crypto/intel/qat/qat_common/adf_clock.c:87:9: warning: Division by zero [core.DivideZero]
       87 |         temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: e2980ba57e79 ("crypto: qat - add measure clock frequency")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_clock.c b/drivers/crypto/intel/qat/qat_common/adf_clock.c
index 01e0a389e462b..cf89f57de2a70 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_clock.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_clock.c
@@ -83,6 +83,9 @@ static int measure_clock(struct adf_accel_dev *accel_dev, u32 *frequency)
 	}
 
 	delta_us = timespec_to_us(&ts3) - timespec_to_us(&ts1);
+	if (!delta_us)
+		return -EINVAL;
+
 	temp = (timestamp2 - timestamp1) * ME_CLK_DIVIDER * 10;
 	temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
 	/*
-- 
2.43.0


