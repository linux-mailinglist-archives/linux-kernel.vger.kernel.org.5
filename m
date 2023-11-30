Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F07FEB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbjK3Imo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjK3Iml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:42:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF9610C2;
        Thu, 30 Nov 2023 00:42:47 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:42:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701333765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcptB3mvhSIKokDXZRJrI1xRd2c85LJPwOEmETgObR0=;
        b=VB5YGGYXw58jLYn8NfK6UocG9lVuvAfHNxadzN1Frtx5DXdgPYQ+ufjtt9bitOi+lAixxH
        nYUwwc6UKzpOWawyaJRSvRC27ezYZB4LzAFqED/WcB1W/2edkLrT8KFaiSxZTxlY4Bu32U
        NW1KBZ3ub8iE44LyxUwbXdYAXJP+g8OFwn4+OwdYTy1jNote8BU7Y4KT8RF6V/IJCIV8Rn
        8ECzIu6evfLMacEV7qYgT7v0sqWph7UzIm9iTH3XVuXxht82J0YCvyQSnRJaC0o6FIf1Ty
        yPmwAo3rZClSwBitUwUCQEfwfXJ7f6RPC5FoHt63tXKTGoOIo8j+acGcy/2ggw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701333765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcptB3mvhSIKokDXZRJrI1xRd2c85LJPwOEmETgObR0=;
        b=tx5kc+z9FF1xI1oKAljhc3gOHKWijljGrLmAa7PQFG3vmSRJoIUU3txYEM8Td1Mz72/cSp
        hl81GXFqx/ZAlMBA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Reject branch stack for IBS events
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231130062246.290-1-ravi.bangoria@amd.com>
References: <20231130062246.290-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <170133376457.398.10426693252022090421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0f9e0d7928d8e88d57b1482effab70edb9741ce1
Gitweb:        https://git.kernel.org/tip/0f9e0d7928d8e88d57b1482effab70edb9741ce1
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 30 Nov 2023 11:52:46 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 09:34:40 +01:00

perf/x86/amd: Reject branch stack for IBS events

The AMD IBS PMU doesn't handle branch stacks, so it should not accept
events with brstack.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231130062246.290-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 6911c53..e91970b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -287,6 +287,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
