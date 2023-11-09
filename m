Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233077E6199
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjKIAyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjKIAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AAF26B3;
        Wed,  8 Nov 2023 16:43:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62139C43397;
        Thu,  9 Nov 2023 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490626;
        bh=8NHcfWQYiDrY3TdwV6wLuh/GROrzM7rVN7CxC7jZJZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDPeGyqPNnU7PAB45cqEq79LGLRkEdObLZzQGAG1qfceKrjCHpMV31YkpCXB8L4xd
         hI8sCYhCTeKSiJLUlMpQlxAqX1UQ2ircgRL9k/nvMBFVMXmZ242juUtWiLFRRfC57t
         nIKxHGRLWRTyTRRH5lFbgf1mu4zylFPvtvIyRpCXU3WzLnIRu7Xre6IGQxEEyXHfNC
         z/5lUvuvfyuUi9FHRb8w3B82gHViUaaTKIq0qsO8wzC/MjyHX0PRjyTJpgxXGPiDO0
         RbTm6Y/bDOGG0qDwpFLNTd39iVmQn1kqZJOqXg04VjAI5SzNQdlQfBOkdsQtJO6QZb
         GCl0JIyobKx2Q==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 10/10] unwind/x86/64: Add HAVE_USER_UNWIND_SFRAME
Date:   Wed,  8 Nov 2023 16:41:15 -0800
Message-ID: <ec004e900e02c9c85cf8c89d4c26d4168a6c5d18.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binutils 2.40 supports generating sframe for x86_64.  It works well in
testing so enable it.

NOTE: An out-of-tree glibc patch is still needed to enable setting
PR_ADD_SFRAME for shared libraries and dlopens.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95939cd54dfe..770d0528e4c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -279,6 +279,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_USER_UNWIND
+	select HAVE_USER_UNWIND_SFRAME		if X86_64
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
-- 
2.41.0

