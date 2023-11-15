Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323227ED544
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjKOVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjKOVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:02:49 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73971FFA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8EDE040E0171;
        Wed, 15 Nov 2023 21:02:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2mzkUDKnnQb9; Wed, 15 Nov 2023 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700082142; bh=8wemFoEe2jF1rnAawq1vGON18ICOHpwFkCE3gBgyjoQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OejNpMVbRiC0AxcCjDTaGDWCNwaVzIK6S4IhtFvfz3NYhTMm9Dir3lp5TJKmTSU6f
         nVc5LbhgozRx7LvzyVyEqtRz/l4yM4ir57sVNtrC/hg+4caTFk0dDqok5Anh61yxmo
         /0s523y4c9NLnz2Q0PJiEvB/rvV9Q8H/jkGHDJliqWH/bZnYMEGXx2W5O4abiHo8+M
         qWey8GzKbfLQ++sNj3E6SUEsV7T2mbwt3g3S2LW15Q07Q2N3z62WGOvwnO7slrgXLg
         O1KKbIJR3PsxkbKN6KM4R5NhfN6mfaZxelIyuS4NlTyunA1hb0nhTfgTUBwAEbcIvp
         gdMbCulbbUv2Y8mmBYA6aLvdhLq8ykJ6WyxIgKcW9EgvqD6A0ZKlRFRFfVvmPZsqQX
         +sfuQb7TVHnkzVGg7Gx1/4E3G3cJ9zhFlu35I+wDBodBiVtPZ9WI5dHR35mVncP9Xz
         4MZOf12aySXyTmAHio8OnqNVXy7xrPSUDgrCdvLXs44qEKQ347gx8PFyYUti4twT/x
         8c5d8S2fEevAKg+ECFiKMMYxj+5NaBhMp0Dq2KyhKFm8eiyyBcVVTh+toDFvtqjwPQ
         PN1aOYdNoyQ8J0Ud6MAXdySMqvD82SBU6IKFXG4OBFBypmhvzDgo14A70qTpSE95Yu
         vv8ND7NS/2XZTbR+AnxCV82s=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC5B140E0199;
        Wed, 15 Nov 2023 21:02:20 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] x86/microcode: Unify early reporting
Date:   Wed, 15 Nov 2023 22:02:10 +0100
Message-ID: <20231115210212.9981-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

this has been a pet peeve of mine for a while now and Linus prompted me
to finally do it.

So, this reworks the early microcode revision reporting on both sides of
the loader and unifies them into issuing only two lines max, for
example:

microcode: Current revision: 0x0a201025
microcode: Updated early from: 0x0a201016

The per-thread microcode revisions are in /proc/cpuinfo anyway so
grepping that is what people who are really interested, should do while
dmesg remains *not* flooded with the same revision number over and over
again.

Thx.

Borislav Petkov (AMD) (2):
  x86/microcode: Remove the driver announcement and version
  x86/microcode: Rework early revisions reporting

 arch/x86/kernel/cpu/microcode/amd.c      | 39 +++++++-----------------
 arch/x86/kernel/cpu/microcode/core.c     | 16 ++++++----
 arch/x86/kernel/cpu/microcode/intel.c    | 17 +++++------
 arch/x86/kernel/cpu/microcode/internal.h | 14 ++++++---
 4 files changed, 38 insertions(+), 48 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
--=20
2.42.0.rc0.25.ga82fb66fed25

