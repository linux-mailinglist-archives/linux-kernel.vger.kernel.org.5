Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019C805B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjLEQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjLEQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B77D48
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:52:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CC9C433C7;
        Tue,  5 Dec 2023 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795127;
        bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aHMiViY74sLM0JM7CzVJxKp1sKwUZX3Hz9kDzZI0BjfyDPqoitPV11YOa1xB0jo4z
         mfgW8ZzoWBeARI/GI7KvWK42ECqqPhaD1WPQal6NKo6F5rwnFFiwvaUBdO4yVdMu45
         9z8jCLaGf5UiD4jHqlbpq0xHMcsySwF6XLZoKSfPO8U9zwh7xZ3kntA9OAQVcsbftl
         +RngOADO5zHGkrpjQbH8wZjGI5qp6BJC9FcYz3iCfAxv4UaJVykCMPZpWRx6aj6SbQ
         5ei0iZxkE6eS7+vcegmr/0Z8Hi5lPh7A1utIf9oX/BoRw4EURS1C8gGoDvQClNN6BT
         IzEFsGvg5ezyQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:15 +0000
Subject: [PATCH v3 17/21] kselftest/arm64: Handle FPMR context in generic
 signal frame parser
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-17-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1T2B3U1hdoWdZAXs9jUGxuRLTGh/zZTJUyGObw3
 yFBl0nmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U9gAKCRAk1otyXVSH0JJRB/
 9G2ggrdGUsuptbMXcksc0nGAzBLQ1pTnUcoaTAl4TOuVbMe4yKlRHcjTlRdfxCwq85aVKyiqb1MX00
 P8OvQYkKGA/OYj0uiztlch1dGXh1CSWqKeeXvLdL8B/lOSKZspxRwdP6JEDS8qNsUrrXp3TtYCN6Hq
 tDJ581VLH/iki9SkugiOXebKqIzWG3RHb2ZX2oRtU1X+G8AVt6FkBptRx/PXsixdqBuccjSxGbYaWh
 FuuojFJsAdMyyEIkRJeVELNgl/itQTmxA+uSAjixwjpugc2aiY4Mzp9QG82DuYepM4OPiy2dPCSjUW
 xsae0hesxj91R0/xZnNco/vN/ri375
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach the generic signal frame parsing code about the newly added FPMR
frame, avoiding warnings every time one is generated.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 8 ++++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..674b88cc8c39 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -209,6 +209,14 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			zt = (struct zt_context *)head;
 			new_flags |= ZT_CTX;
 			break;
+		case FPMR_MAGIC:
+			if (flags & FPMR_CTX)
+				*err = "Multiple FPMR_MAGIC";
+			else if (head->size !=
+				 sizeof(struct fpmr_context))
+				*err = "Bad size for fpmr_context";
+			new_flags |= FPMR_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..7727126347e0 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -19,6 +19,7 @@
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
+#define FPMR_CTX	(1 << 5)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.30.2

