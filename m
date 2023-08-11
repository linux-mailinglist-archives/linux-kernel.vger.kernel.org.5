Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527DB779928
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHKVDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjHKVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:03:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18900E77;
        Fri, 11 Aug 2023 14:03:10 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691787787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQEbgcv3SXBzdgQ2vH6bH00o0e6nyx9jJoKAj9oSlmc=;
        b=ys2iEpJAXMMK0zl/MA4h+ZSsqF9if5VQw5MG1I0PvTxYMKe37Ohgzl3V5DWE8Puguw9DLS
        l7npYzjaN0IJQhrkVZQLJLRFvT28pLI2QMlhpxOyNvZFeOQWK1xSfPSufrNd2rI6LQZXSJ
        CAPCgLn2L5kChkMytyhAv5h9/GNjI7Qht3SFBywvA93J6+N3QDziyPfPJ3t9SALsh5PuJJ
        UyZdZxfEPKGya2c24LoLZ/PytP90xOfdyNL8P/1D/sd9uJw4/jj9yo/ZvhqroySxMNoCzP
        Y2tX3zJbWQmlJUVpHjc7cWeYFFq78lJb+xpEqZpN7iKeWamRRfhzSXjensCmmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691787787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQEbgcv3SXBzdgQ2vH6bH00o0e6nyx9jJoKAj9oSlmc=;
        b=Lo0AjL857grJ4eGOtWUXvVX4zQPHHG/11xzTdKx4hxBGAVDVT4+dND2khfXZeRmrhTWF9k
        IXNnytUv072/B8Aw==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230811203705.1699914-1-cristian.ciocaltea@collabora.com>
References: <20230811203705.1699914-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Message-ID: <169178778665.27769.10759890614564556189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271
Gitweb:        https://git.kernel.org/tip/6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271
Author:        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
AuthorDate:    Fri, 11 Aug 2023 23:37:05 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Aug 2023 22:52:29 +02:00

x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Commit

  522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")

provided a fix for the Zen2 VZEROUPPER data corruption bug affecting
a range of CPU models, but the AMD Custom APU 0405 found on SteamDeck
was not listed, although it is clearly affected by the vulnerability.

Add this CPU variant to the Zenbleed erratum list, in order to
unconditionally enable the fallback fix until a proper microcode update
is available.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230811203705.1699914-1-cristian.ciocaltea@collabora.com
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 26ad7ca..c15b4f0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -73,6 +73,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
