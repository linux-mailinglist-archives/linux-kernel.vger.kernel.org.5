Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B479299C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbjIEQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350948AbjIEFFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE9218C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE88FB810A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B840C433CB;
        Tue,  5 Sep 2023 05:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890310;
        bh=IuB7d7u3ZasrJgf6zWs7ZIAwIpl7dQyQe9v+nAwbKYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCF2PukUXjchG9OFTipxyx6+qp03BnPf9X5ZDX4bmI1wXdlUTZOjjXCCJ/FwKvyQZ
         nqaMKA11X53xmuTePeTQ5bhwxxpUoDlB9bGXvSgZJLuNpvFhiEIki9XhV7Cwo+DUIZ
         xludqMA/OCip5bf7WeT/6wnhJtExj05c2Wv8RTptvGzjgMSaAhYRic+bZkICdgGAM6
         Z56Gke4t5KCmiBXbs0i+atUSpDaU2u3wkQ5YOXffU8RLjPKxcbGydxCAdLNc06DuLq
         rYjk6n4g4Rgh28XM6glxgTvqSOEz3lFL2CEzgd/RW1+1kndMaD0qph/1gtuK/8yZTc
         TG46XsrUEeMqw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 06/20] x86/srso: Print actual mitigation if requested mitigation isn't possible
Date:   Mon,  4 Sep 2023 22:04:50 -0700
Message-ID: <7e7a12ea9d85a9f76ca16a3efb71f262dee46ab1.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel wasn't compiled to support the requested option, print the
actual option that ends up getting used.

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2859a54660a2..235c0e00ae51 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2461,7 +2461,6 @@ static void __init srso_select_mitigation(void)
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
 		}
 		break;
 
@@ -2473,7 +2472,6 @@ static void __init srso_select_mitigation(void)
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
-			goto pred_cmd;
 		}
 		break;
 
@@ -2485,7 +2483,6 @@ static void __init srso_select_mitigation(void)
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
                 }
 		break;
 
-- 
2.41.0

