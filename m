Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8D76BABC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjHARFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjHAREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:43 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423AB3C14
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:04:08 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bba254a7d4so4505930fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909426; x=1691514226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iCNWvd7mdJx34DAX7Wae2aC5uwBwu5nJTt0y8KbTx8=;
        b=aJzaQpO+iKoeSkqk0qUhUXPdCplJv4ISfU4yAwr+5tyWNnq2DaWE+l97DNaAgrIaD4
         7U/oj7kzdf7rjc1jiOrsvsQkkts93G/2xXMk++5fgR5utNmEXIyItX7b3gsnh3HX2TWM
         lXwwP0jT0m8bAqoeHQ/SP6y56Vks45+PrJRT63gecbcpHUBnYl7i8zBsoc3qaYSmAYam
         LULtsUCkhPDSIbvL/bhUQ8nkN8eomoHRDHe9546qlyFP8g2IdNespF3GDg1ZjTIbUl8x
         OqCk6MSjN5DhoftTzGTAizO7c9UqTOTMvZ6Mn4xF7KFX3icVHkUXIHwOcAI0J4fSuVT0
         /9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909426; x=1691514226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iCNWvd7mdJx34DAX7Wae2aC5uwBwu5nJTt0y8KbTx8=;
        b=D07SyHvdRekcaB4TwozRbeVc6QIFIn+npcjRayc1gtBeGjQbFusQNB1X8NNmce8thE
         5woDxgHiiL/n/7NAZyJLBPqfQZgUBw3mplu4tIb0yCT+vGOWarCZgwt61m2whFttf67z
         VWAGMI0Xvco7ppVkzfBYgpA8jDfBTu7ShxojVrEep8rcx3V60HL3qpk+Sypr5g9tP6QQ
         pch2jjz6GD2xPDXlCJ5aqjpMcKHCzIk5nFY+ct4dmttGoqb86D5e/T0my22GtRuXJcE2
         fouIJpGWKCDv3xUR/jKxWgKBoR/tNveYMegDvsIiz/uDVN/rzH8Kl3CALmwFWa7J9OO0
         03Iw==
X-Gm-Message-State: ABy/qLaStlFANCo4K6OCQf/go7m2VYUosNwikgf7qmcfODg1aUJQgPwK
        3Iy0smD7SWmQ3VH+evzqApeLPzkaoqOJ2uJT
X-Google-Smtp-Source: APBJJlHSNTZ2BaqMZvdSTgWjUX4MA/sAFkg+pUvFWHolW24p/6jpaAEuX5JOwNOA86Kh6n02As3N3w==
X-Received: by 2002:a05:6870:64a4:b0:1bb:fd78:4f22 with SMTP id cz36-20020a05687064a400b001bbfd784f22mr13866571oab.34.1690909426252;
        Tue, 01 Aug 2023 10:03:46 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com
Subject: [PATCH v5 22/22] checkpatch: reword long-line warn about commit-msg
Date:   Tue,  1 Aug 2023 11:02:55 -0600
Message-ID: <20230801170255.163237-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword the warning to complain about line length 1st, since thats
whats actually tested.

Cc: apw@canonical.com
Cc: joe@perches.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f6b6b2a50dfe..31c55e3ece09 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3272,7 +3272,7 @@ sub process {
 					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
-- 
2.41.0

