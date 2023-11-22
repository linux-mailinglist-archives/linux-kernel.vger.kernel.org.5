Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A67F420E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjKVJoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjKVJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:43:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A81D53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:43:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130AEC4339A;
        Wed, 22 Nov 2023 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646218;
        bh=sAPCPg94+tnQw67CJNTbw1zQ3juZmRAe+Eh6kRT4gRc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IkXRbg5bBWSUR+v3gfhiN3UWClgOifXCfJYdSSioSWvlRRW0PeQTS3840LnJeHTZ4
         VoP/bZznXx/D8Zmd8/wg3SHiiXpdq9G7qXu0SHuGSzY3E9t8R3OaZw8DlZc41Hl497
         kdEEsWXJpHK1VK2rDYLui9+R7Uo9Mlb9NwLVVUh7IldVFd9eFzYERwTx68oGWAaxwD
         4cHNbjRbM4lBZ8/5G5l4KIIIyrrEi3vmyEqksXhSzmqSPbiTjemvRhc3jDYyfjIY4f
         tzU5DbkQd+AXeKkMRQ8qtIW90WHtI6KFwV0/j7Om0fl0b/6+HV2Eid1Lr4gKKzkPUb
         iKqusnHn1iNIg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:16 +0000
Subject: [PATCH v7 06/39] arm64/sysreg: Add new system registers for GCS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-6-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sAPCPg94+tnQw67CJNTbw1zQ3juZmRAe+Eh6kRT4gRc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz7ZHl1qts3vCkTyLrvdIYGWOcI1zxCo5W7w
 MWcYuLMMqmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M+wAKCRAk1otyXVSH
 0Ni7B/4s8EgRGzCroRrqSGQDamkc26auatPOVjhjcDAF4UzqAGfqte6xSPGtlM654rV6oxw4S74
 ScqJVKLmOfCAkvCwX5BxxAlOSdeMqOK/FgKj9J+cM2W5+0AVlvUZv8vAGZIelYeutlHEFoMLD9P
 r+ONekQALp7T/WiFNBAEbhIqQK7O3EUizX/yHODMJPOzkRMgvLifseFZkrbV5bTKSKVr0pCB18m
 MCcrHY/O0TwRVMvKL5AYsOCdHTbLkn+Bj+t4hMu50SoZTrAN/9sJa+XlLNgT2Sm5DtgJNxunb1g
 ownRsis25uUJ0pSZSxZzqvPmmuSJZVa/rIVWAMDmhxRNHGC4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_GCS introduces a number of new system registers. Add the registers
available up to EL2 to sysreg as per DDI0601 2022-12.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 96cbeeab4eec..d2ee46b63482 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1790,6 +1790,41 @@ Sysreg	SMCR_EL1	3	0	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+SysregFields	GCSCR_ELx
+Res0	63:10
+Field	9	STREn
+Field	8	PUSHMEn
+Res0	7
+Field	6	EXLOCKEN
+Field	5	RVCHKEN
+Res0	4:1
+Field	0	PCRSEL
+EndSysregFields
+
+Sysreg	GCSCR_EL1	3	0	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+SysregFields	GCSPR_ELx
+Field	63:3	PTR
+Res0	2:0
+EndSysregFields
+
+Sysreg	GCSPR_EL1	3	0	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
+Sysreg	GCSCRE0_EL1	3	0	2	5	2
+Res0	63:11
+Field	10	nTR
+Field	9	STREn
+Field	8	PUSHMEn
+Res0	7:6
+Field	5	RVCHKEN
+Res0	4:1
+Field	0	PCRSEL
+EndSysreg
+
 Sysreg	ALLINT	3	0	4	3	0
 Res0	63:14
 Field	13	ALLINT
@@ -2020,6 +2055,10 @@ Field	4	DZP
 Field	3:0	BS
 EndSysreg
 
+Sysreg	GCSPR_EL0	3	3	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	SVCR	3	3	4	2	2
 Res0	63:2
 Field	1	ZA
@@ -2348,6 +2387,14 @@ Sysreg	SMCR_EL2	3	4	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+Sysreg	GCSCR_EL2	3	4	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+Sysreg	GCSPR_EL2	3	4	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	DACR32_EL2	3	4	3	0	0
 Res0	63:32
 Field	31:30	D15
@@ -2407,6 +2454,14 @@ Sysreg	SMCR_EL12	3	5	1	2	6
 Fields	SMCR_ELx
 EndSysreg
 
+Sysreg	GCSCR_EL12	3	5	2	5	0
+Fields	GCSCR_ELx
+EndSysreg
+
+Sysreg	GCSPR_EL12	3	5	2	5	1
+Fields	GCSPR_ELx
+EndSysreg
+
 Sysreg	FAR_EL12	3	5	6	0	0
 Field	63:0	ADDR
 EndSysreg

-- 
2.39.2

