Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EF76F442
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjHCUwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHCUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:52:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25544A2;
        Thu,  3 Aug 2023 13:52:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-316feb137a7so1234284f8f.1;
        Thu, 03 Aug 2023 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691095960; x=1691700760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUsStjJpVD7qt6r5K0hLWecq0MMWSxahYThfGKl6wi8=;
        b=qcUFyujXpeiN583AOnEqxZzKYkhUE7gwQyKGYlLhbux+5HUS66loXxVDZMtKUIWGts
         6SeF5BoEf8I9HLoWz516J4Ve/yKd6AoRhPfwv1YdppII5Uk5DMYPoGitYTdswmiH6mE6
         LgjTFrl63mjY7rFg6ECCnzz2eNePICw3jzuIhE+eAtLp6koU7t07Fps4l5K/q2g/aiqA
         bZTqUh+SOT3SVBsK67X495Qj/xIeVZULq9dPnu5UDC+47AB2JgsqZ8tdogayVsezGunR
         Ly3EBGc6/McMn19UOoz1b22QscRkDyMlN/0R6XN/Fxtx9CXZQ5RzYGeH9nn7+W5f881m
         M2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095960; x=1691700760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUsStjJpVD7qt6r5K0hLWecq0MMWSxahYThfGKl6wi8=;
        b=Bl8akAX0U1LEWLyiB/U/2Gx8fo9oorcKxsDLq3BvbhnykC0Zsj7F9u+/DLZGjb9uP1
         NAgPrH3qeVi3G1k6cNs3D2W/KaljFOL1r6Zmmg8eZDpgqaNrXzcNJH5O3vrrOScDKCnF
         JlvtBMxgvJlbCcvIc7O/yXB9ZGkLr4u46oQhQvsfeMbdsk9h2jHmbaAdcuGHypqhntCs
         3PMnPquCT8Slw348zyToK8oL8Xjk72vxK/Xv8cP13bRkq7nXp7avWMeEOnRqka9sTAiq
         ala8lMTdSa41UtFRLpH5LwLk3puGGdOvk/G/jXSd3eZPeQ1LC4LZdXlWqXiSLD3BKtpq
         NHrQ==
X-Gm-Message-State: ABy/qLaeLUVazaymZMCAYXQt0j92l5A3J1TcDjBkzXarIGiWNhxEkPzf
        PvW4yWBz9/d2YH1laPLJgaA=
X-Google-Smtp-Source: APBJJlHGofDiAMeTiumlODSgpgysa+cLtTW2A3pKTFFZv6cKAoH8d/TChY5XWLBuCxBR96QP9pJHfA==
X-Received: by 2002:adf:ec05:0:b0:313:ded8:f346 with SMTP id x5-20020adfec05000000b00313ded8f346mr8657716wrn.22.1691095960055;
        Thu, 03 Aug 2023 13:52:40 -0700 (PDT)
Received: from localhost.localdomain (host86-140-156-29.range86-140.btcentralplus.com. [86.140.156.29])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm749138wrs.30.2023.08.03.13.52.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Aug 2023 13:52:39 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] ftrace: Use within_module to check rec->ip within specified module.
Date:   Thu,  3 Aug 2023 21:52:36 +0100
Message-ID: <20230803205236.32201-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

within_module_core && within_module_init condition is same to
within module but it's more readable.

Use within_module instead of former condition to check rec->ip
within specified module area or not.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/trace/ftrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..c46dd6d97afe 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6779,8 +6779,7 @@ void ftrace_release_mod(struct module *mod)
 	last_pg = &ftrace_pages_start;
 	for (pg = ftrace_pages_start; pg; pg = *last_pg) {
 		rec = &pg->records[0];
-		if (within_module_core(rec->ip, mod) ||
-		    within_module_init(rec->ip, mod)) {
+		if (within_module(rec->ip, mod)) {
 			/*
 			 * As core pages are first, the first
 			 * page should never be a module page.
@@ -6852,8 +6851,7 @@ void ftrace_module_enable(struct module *mod)
 		 * not part of this module, then skip this pg,
 		 * which the "break" will do.
 		 */
-		if (!within_module_core(rec->ip, mod) &&
-		    !within_module_init(rec->ip, mod))
+		if (!within_module(rec->ip, mod))
 			break;
 
 		/* Weak functions should still be ignored */
-- 
2.37.2

