Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3907C7618
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442021AbjJLSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441821AbjJLSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1283;
        Thu, 12 Oct 2023 11:43:50 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697136229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4IJk1jfPpuOdOgu2MQ79rc62trZiN8Vjveo+Rkj3n8=;
        b=AKlfPe08Yy4RsKr4WM2S3srzCwWroJ9Ia6/m7q+ozav+tOhuh0An18eiiAA3++NnikGsS7
        eDkPnmV6JbElCr0+/nTuiQvEqZjrUaEQ/X1ol7gg2g+TCHh54NPkrNX+zadgYNJOe50BxY
        kDrdQJQIfLiPqnsvR1XzD1dTOsPQK+hfVtT5KinupYLJjUwoOqU429EURKbvTn3Er5Lfph
        fdqgLFHttslPMO7rqJK2rjRIPu/Z1TjmyQ+MUtToqB6daT/veQA4Eu8cGHb4LA9Ynvk6K9
        senVMjyAGQi146PI3lVFrRbtfBJ0uUzXvuFYB/GXWtK8wirmOSsl562Cxj5yvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697136229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4IJk1jfPpuOdOgu2MQ79rc62trZiN8Vjveo+Rkj3n8=;
        b=uXdWhs3zJjoS98UVypG+XxK78H+hUwUtvjLaiD9BP4FqE3mdi97hDK2KO7/ia7Z7MMA4vt
        U9VJD2muECZ6goAA==
From:   "tip-bot2 for Lucy Mielke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Fix string sizing bug that
 triggers a format-truncation compiler-warning
Cc:     Lucy Mielke <lucymielke@icloud.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZSfOEHRkZAWaQr3U@fedora.fritz.box>
References: <ZSfOEHRkZAWaQr3U@fedora.fritz.box>
MIME-Version: 1.0
Message-ID: <169713622853.3135.11510940240910538539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ac8b60be078abebc3ab8836f3f0ecac6980e0b4f
Gitweb:        https://git.kernel.org/tip/ac8b60be078abebc3ab8836f3f0ecac6980e0b4f
Author:        Lucy Mielke <lucymielke@icloud.com>
AuthorDate:    Thu, 12 Oct 2023 12:44:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 20:37:59 +02:00

locking/lockdep: Fix string sizing bug that triggers a format-truncation compiler-warning

On an allyesconfig, with "treat warnings as errors" unset, GCC emits
these warnings:

	kernel/locking/lockdep_proc.c:438:32: Warning: Format specifier '%lld' may
		be truncated when writing 1 to 17 bytes into a region
		of size 15 [-Wformat-truncation=]

	kernel/locking/lockdep_proc.c:438:31: Note: Format directive argument is
		in the range [-9223372036854775, 9223372036854775]

	kernel/locking/lockdep_proc.c:438:9: Note: 'snprintf' has output
		between 5 and 22 bytes into a target of size 15

In seq_time(), the longest s64 is "-9223372036854775808"-ish, which
converted to the fixed-point float format is "-9223372036854775.80": 21 bytes,
plus termination is another byte: 22. Therefore, a larger buffer size
of 22 is needed here - not 15. The code was safe due to the snprintf().

Fix it.

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZSfOEHRkZAWaQr3U@fedora.fritz.box
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 15fdc7f..e2bfb1d 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -440,7 +440,7 @@ static void snprint_time(char *buf, size_t bufsiz, s64 nr)
 
 static void seq_time(struct seq_file *m, s64 time)
 {
-	char num[15];
+	char num[22];
 
 	snprint_time(num, sizeof(num), time);
 	seq_printf(m, " %14s", num);
