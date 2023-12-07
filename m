Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB08091E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443799AbjLGTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLGTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:49:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2EA5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:49:25 -0800 (PST)
Message-ID: <20231207193859.961361261@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701978563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:references:references;
        bh=2A5tOfBTQ9+8b7wKUOCXmPk6lKlNDwfopIYX+SrqFvY=;
        b=cjxnIKza2OROijSk2HRt5zAtBnx1RFrbj4lFIq4vCnIjg0akKvRXYrihMqc8Qr+UBEPq8X
        zgGPPSTNF1dA2iIWqKvHsik6sSyx1K80FYfdTc6AIlQCntpvqnOdvMm3Aha58SHbIDs6Z6
        3xzwj/OYdwvkbtI+lmk0bEuASmA6vhIGYsjusXYEwU8GulGvOWkL2FG1M5TSpLw17HpdDM
        NEEvprhkyg97FXHFR419WBK1X4iAH6iexZcOUAJ1x2bq4vYocb/Ds0rA0LAzElKz8d6fVA
        PT1qGTWzbjLRZ++PKgX+yOXYO7w4b4jJsSAn3leVxp4KivywVEB+ef0SEY5x8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701978563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:references:references;
        bh=2A5tOfBTQ9+8b7wKUOCXmPk6lKlNDwfopIYX+SrqFvY=;
        b=hdLzHWl4dDtnn9kSJymTmjiFU/yETMGR0PDwaRxrgjdhBQLlhlqRWIOH9mnOoj7c4iOYdg
        nZ3T88HM5jmh7MCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     paul.gortmaker@windriver.com, x86@kernel.org,
        regressions@leemhuis.info, richard.purdie@linuxfoundation.org,
        regressions@lists.linux.dev
References: <ZXCXc+BtnLzqMbFv@windriver.com> <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info> <87r0k9ym0y.ffs@tglx>
Subject: [patch 0/2] x86/alternatives: Prevent crash in NOP optimizer
Date:   Thu,  7 Dec 2023 20:49:22 +0100 (CET)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series addresses the regression report from Paul on behalf of
the yocto project. It turns out that the recent changes to alternatives
opened a race window where interrupts are enabled and NOPs are optimized in
place. An interrupt hitting into the modification will observe inconsistent
text and crash and burn.

A 32bit QEMU crashes w/o these fixes reliably within about 50 boot
attempts. With the fix applied it survived close to 600 attempts by
now.

Thanks to Paul for providing all the information!

Thanks,

	tglx


