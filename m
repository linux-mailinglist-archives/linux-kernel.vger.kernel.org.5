Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A497EC6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbjKOPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbjKOPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:14:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEF19D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:13:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D79AC433C7;
        Wed, 15 Nov 2023 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700061237;
        bh=UOpRDyfGB6Ea+Gq7xit84UByanxpLw9VApEKV8DKpcI=;
        h=From:To:Cc:Subject:Date:From;
        b=VqsLQgjEV3w5ae76flKoGmSiuEOcBZIPsOJx+P81m5AbEb9A/ANFBNEj6II1tTdEa
         wohdY4Dhqhy//XdqwM8lARz8nHsQ81jPqBteUzilgTV9lj+bcWhq9LI/aKOdX8ABuF
         kl8JngJMsXmi4oGcUheHKbHwZiU9lfxGM7vhBZCYUtcnHrFr/Vq1tEZfnLTjjSXZ4Y
         j42R+pOlehURj+3hOGLCGT1RkoFNKTl4q5VBy/7oCd+1yspuguEGtIRM96ZhbbL68P
         EH3g8YExYZ5PZ2X5TuntBizW0jYASbUZOnBW0P47fHDYz+Rbj7E5NEL1XpZdcDW5dN
         PSEjxLtMJMXhA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH 0/4] x86/cpuidle fixes and optimization
Date:   Wed, 15 Nov 2023 10:13:21 -0500
Message-ID: <20231115151325.6262-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the x86 part of a cpuidle series I posted a few time ago. There
is a fix by Peter (Not-yet-signed-off-by btw.), the rest is comment and
optimizations.

Frederic Weisbecker (3):
  x86: Add a comment about the "magic" behind shadow sti before mwait
  x86: Remove __current_clr_polling() from mwait_idle()
  x86: Remove the current_clr_polling() call upon mwait exit

Peter Zijlstra (1):
  x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram

 arch/x86/include/asm/mwait.h | 21 ++++++++++++++++++---
 arch/x86/kernel/process.c    |  1 -
 drivers/acpi/acpi_pad.c      |  1 +
 drivers/idle/intel_idle.c    | 19 +++++++------------
 4 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.42.1

