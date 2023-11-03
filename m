Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEB7E0539
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjKCPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:04:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A91B2;
        Fri,  3 Nov 2023 08:04:20 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:04:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699023857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zw3qdAaPAqZS90DNMKf7YEZVCL6zjF1E8Lua1o2VnB4=;
        b=VEKbimh/tSJMSsyHMfmFvBox5+ECnWsOWM9p/r7dTTImfhTu11KUE0ET3Ij9oit6B8Zrpn
        ydBabE/+QwbRpN8CWM1AH19/nxq6/VzF8YU8DSIYZUN5KLq0N2aUJft6b3eyR/nhU8ElA/
        5aF784S9ddvQ7xf3Ja4UWtWpRvV3/yo0GW4dIjkA8bsTlWXMPLPzPYHPI1+H7MNu8L1/9s
        1DJLyJJGg7/FegppOIYVF2Go8cRptu1aN92xWLmM68X1QX9EhSkvYME2ztJ1jfZD9XkCf+
        SjNIrcQ3Svb6szFXKEKkzFaYxcYQYgNRXoWDuafqQG+M5dUQZLigY4Ssums9aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699023857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zw3qdAaPAqZS90DNMKf7YEZVCL6zjF1E8Lua1o2VnB4=;
        b=JoPZsWTAQAJGoMBzJJgw7YwAiYbMIdR/C93IIpb9+4rYlPm7mKr+iBQEX1bD3xkSrZZMkn
        zMj1CnK2fQZ0o4BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rt12
Message-ID: <20231103150416.n8dAWMix@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rt12 patch set. 

Changes since v6.6-rt11:

  - Add an export back which was accidentally removed with PREEMPT_AUTO
    resulting in a compile failure of kcsan_test if compiled as a
    module. 

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rt11-rt12.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rt12

The RT patch against v6.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rt12.tar.xz

Sebastian

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21b50e61d0014..0110026914efb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8930,6 +8930,7 @@ static void __init preempt_dynamic_init(void)
 		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
 		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
 	}									 \
+	EXPORT_SYMBOL_GPL(preempt_model_##mode)
 
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
