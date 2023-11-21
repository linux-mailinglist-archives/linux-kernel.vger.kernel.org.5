Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C187F34A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjKURNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjKURM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:56 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3310CE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:49 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso3067410a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586768; x=1701191568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvoV//U7FVv1pKsj0pHVwZMcyaDGT7gkmJVz+LeD9vo=;
        b=qaaz9VRO3ZRu8ruuf8RVehwlSkhB/yXMXD3wKqe8fNzwsUZ002qI71lbK+Mr49kT97
         niXIz9etLnzFsj2E5QeXABMK5qCFmDEe68gsktNcpb6wuFQeib+xmFOqxYfTKdGKKyzS
         aAaVnjVf4h8u9PDao2mEJfeoXlQRt6j0xtVwhTYRGrZFoDqQmheT4BQ1E7Xjui1o9j+j
         J1mX93HVxcGl9z7wIEbOTfUu30AYYaK1BQpctr6aAdKDe1M1Ry0cSwHgEm9Yo/eXsG6T
         0AMGghkb4Ikv2pbfBKvlB8MMAB2tSVJpiehNDgWzjz2NjNPp+3nfQ88JTTht/aqv9/rt
         gp4w==
X-Gm-Message-State: AOJu0Yy7BpF3GUJbMsj5qd0aiawDZxR8SKrsXMWM9gHusT8z5xc8CWfu
        3VpDGjs1xdSLv3Ub4V1QsfM=
X-Google-Smtp-Source: AGHT+IFU2qKlYtQ9jK4egnBT7EgrzH9XTvsfmEPiBoFIwKEkCQNSMs99EOKXzEqbMtDGH53+BMO5Ow==
X-Received: by 2002:a17:906:159:b0:9f7:b6c2:cd3f with SMTP id 25-20020a170906015900b009f7b6c2cd3fmr8135322ejh.5.1700586767935;
        Tue, 21 Nov 2023 09:12:47 -0800 (PST)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b009f5b7b6f3c8sm5451328eji.56.2023.11.21.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:47 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/13] x86/bugs: spectre_v2_user default mode depends on Kconfig
Date:   Tue, 21 Nov 2023 08:07:39 -0800
Message-Id: <20231121160740.1249350-13-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default value of spectre v2 in user mode to respect the
CONFIG_MITIGATION_SPECTRE_V2 config option.

Currently, user mode spectre v2 is set to auto
(SPECTRE_V2_USER_CMD_AUTO) by default, even if
CONFIG_MITIGATION_SPECTRE_V2 is disabled.

Set the Spectre_v2 value to auto (SPECTRE_V2_USER_CMD_AUTO) if the
Spectre v2 config (CONFIG_MITIGATION_SPECTRE_V2) is enabled, otherwise
set the value to none (SPECTRE_V2_USER_CMD_NONE).

Important to say the command line argument "spectre_v2_user" overwrites
the default value in both cases.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0172bb0f61fe..a99f8c064682 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1216,8 +1216,11 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	int ret, i, mode;
 	char arg[20];
-	int ret, i;
+
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
 
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
@@ -1231,7 +1234,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1241,8 +1244,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
-- 
2.34.1

