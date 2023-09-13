Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2728179EB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjIMOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIMOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC41B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:51:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB2C433C7;
        Wed, 13 Sep 2023 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616666;
        bh=Q9n9fiC6Q6HwDd/AL7ztrfunSyqcBsNnDmEcjMyEQ80=;
        h=From:Subject:Date:To:Cc:From;
        b=sMo9mBM94SKNpAKVwEY3N+WL+529FRRcmErvsjWyPCvTxiltzR51H4FJXoNpHXsr7
         uQvd8QnpiVKAFvvRLbZ9YSotFLvCLw2fyRDSvFh6Lke4gu8vAwag7df6+CuIJYFZCU
         qILKdc7VpIBdzRr/qPkPGWJluU9AOCOuxYqDoM9JANDEf3VSMVa4VII7FWy9Ld80fC
         PzZ2rWmxk27hQ2SwXW3t/t/citFQf73U0O9x1Vd3twW2SWT7ZX7pjEyf6cm28mHS6N
         BteT8UDBY7GtEFvwJoMA7Bl15LU1SkLYHWq7o2wga1aQfeYU7SLNxEUNSyq3qNuvje
         28jj3vmFv3iKg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/fp: Remove vector length pseudo registers
Date:   Wed, 13 Sep 2023 15:48:11 +0100
Message-Id: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvLAWUC/x3MQQqDMBBG4avIrDsQR6lNr1K6CPFXB2wqE5WCe
 HdDl9/ivYMyTJHpWR1k2DXrNxXUt4riFNII1r6YxEnjfC0c7HNveUfkGYnjsg0I62Zg8a7vHvC
 uFaGSL4ZBf//1632eF+94+MhqAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q9n9fiC6Q6HwDd/AL7ztrfunSyqcBsNnDmEcjMyEQ80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAcxWvbk0rTwu4c5V3rE6Vh3eT44cxERh5gDv9WVz
 oTE6qv6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQHMVgAKCRAk1otyXVSH0Km/B/
 9Cr2mB7rJlT39j903Qoesb4rZzZLrWKk014H6NcGAQpQNV8G4WQ+ykt66sfJqCMpCRebyLUgvY9WYK
 i7tZ8Exrekbumh0zI2b9O89o1KnbwYthV/8j3rvdwNzz00xFtqf+y145I4rNln5FOayymTU3qdMGDa
 GF0wiEnVFxk5XYL6A7ikt67wO0wUgZvWkJ7yUbE3P+M1mPcSXJAVIqobTsdtNGVikpMFSh/CLLyatB
 kJtZsUkhVq9+K+hmgcqA9zD3E0384OP/x0N5Cu4nZx92aPHhqBJ7nEN3U8VnqhwFovet4uydIRUynM
 IEnBK3pAmbTcVOAwCZI0SaAsIevFPa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the pseudo registers used by the cpufeature code for the maximum
SVE and SME vector length appear to be unneeded other than as a double
check of the full vector length enumeration.  As discussed when fixing
warnings from the pseudo register code let's simplify things by just
removing those registers and relying entirely on the full enumeration.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/sve: Remove ZCR pseudo register from cpufeature code
      arm64/sve: Remove SMCR pseudo register from cpufeature code

 arch/arm64/include/asm/cpu.h    |  6 ----
 arch/arm64/include/asm/fpsimd.h |  1 -
 arch/arm64/kernel/cpufeature.c  | 58 ++++++-------------------------
 arch/arm64/kernel/fpsimd.c      | 75 +++++------------------------------------
 4 files changed, 19 insertions(+), 121 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230912-arm64-vec-len-cpufeature-290d78e90422

Best regards,
-- 
Mark Brown <broonie@kernel.org>

