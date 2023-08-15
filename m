Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589AD77C621
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjHOCyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjHOCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:53:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE710E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:53:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-589f784a972so14074807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692068007; x=1692672807;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63ap8sbQYwzl9ADZmQRahUt+SmCNa6I6b+pZyfApvsk=;
        b=Qxav+m2hV7n79NtWX4hLjb4m6eEJ4b4KRe4/NNr10GuMwjyvT57KrpniOeTwNXicCQ
         7qJcaEX+vaJxJkCpQrbQW3tmoDtnJ//vRv3z8qN7EANQR64DJYe+3Snu834fuiTklPr6
         Nbv5wamhtKVDP6ux9lxt/UzD3wsgoGvmhlkRmmgH1KOkvqYckq/DphjCS2A6fV9JYk7I
         ZrUD7FZ2Qu+uXe19HD5VmHR0ZALWOaao8yJZZw1W4SxtVed5yUiWRd9U5nkJdWJr/QyC
         5VkhjfqqU5N6QK+TyUS4y4t2N3+FetZVyAF0X6N5tOZJcLmC8lDgquJrNpwiz+C8iHmb
         c2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692068007; x=1692672807;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63ap8sbQYwzl9ADZmQRahUt+SmCNa6I6b+pZyfApvsk=;
        b=lKXGNNXJEOSMvgZwrF/Ucd5L5MZI4460z0RHM3S7co+52/eR294BvnfPQGhiZ2uu7G
         tn4ZnRLCfSnkI3dg4XzT2d4SMapR2v97oTouXTV/WVIvxihpYFRoMKEQValkLUoj0mNd
         I2E1rxP/4tBWvhJU5yvA8aABO2ij8xP/ysGvoY064tYnFp5HHM1LGbmQWt5VG2nSBQgW
         Q/VPRKwqDLW1IssjuTp51ehAQTDLHFET8iSUj4i6VqD0pWqH+MkHtijL/DKXdj4/fxjd
         KZF0T2iGUX0AtnFhy8lL5fYbDRKGMF+fW63aADUocmsjH7Ww8ubgyVDOGXH7G70OJSQd
         rkXg==
X-Gm-Message-State: AOJu0YyyPbygrs9w5DXvsp9bFX6RHrHyuPq93OAVKzMyCrhfjzYOcFr2
        XZ8/LShY44mOntYwwSASyRTAAg==
X-Google-Smtp-Source: AGHT+IFrcBt/5zlpQ9ulRLG2oLPv85TSbVhwBVZG+yWdWI8jXstI6EEBPfJmSOaVjLVDalJNFmU7Lg==
X-Received: by 2002:a81:bb42:0:b0:561:a123:1041 with SMTP id a2-20020a81bb42000000b00561a1231041mr10779719ywl.29.1692068007378;
        Mon, 14 Aug 2023 19:53:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k189-20020a816fc6000000b00586a9abcbe9sm3172116ywc.53.2023.08.14.19.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 19:53:27 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:53:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Borislav Petkov <bp@alien8.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86_64: Show CR4.PSE on auxiliaries like on BSP
Message-ID: <103ad03a-8c93-c3e2-4226-f79af4d9a074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set CR4.PSE in secondary_startup_64: the Intel SDM is clear that it does
not matter whether it's 0 or 1 when 4-level-pts are enabled, but it's
distracting to find CR4 different on BSP and auxiliaries - on x86_64,
BSP alone got to add the PSE bit, in probe_page_size_mask().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289837dc..72e36739c407 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -181,8 +181,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl	$0, %ecx
 #endif
 
-	/* Enable PAE mode, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	/* Enable PAE mode, PSE, PGE and LA57 */
+	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
-- 
2.35.3

