Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891257FE703
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjK3CiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjK3CiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DC171F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95400C433CB;
        Thu, 30 Nov 2023 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311824;
        bh=aVQYYR7Wa2j5FcEbEqZY4GpoX0ij3ZW/t2YkLOpkPDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ab3KL1CA/Q1LdHqbROyoGrBYbAzm+vS90RXg2E8BXqXKEg5WEjZojHnxDn9nYqvD3
         F1f4Im4M6vU9+o7l3V1SvkvjkldXXrKbk03T1no8M0JuRDCfSx/Iy8YOPKdDINT6FS
         ISWn3NNg2kx3/5L0ud8yO5DiDbbsFVb4sZYKvK+PPVjRqXcqDYrl9PDurGehZAeban
         sPc/85by17P4PosFwLVgg3428nwiR3rQRMv29Ggy/BIrzH3ZwJinZk99qOHsE3XUAg
         eXbFr3YYNbMNjrS+iX50I9+vg6aZId9yd3e0qppFUtYx8tISAFwq9gnrCu7zl70r82
         fbwlXVVYwoYjg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] Docs/mm/damon/design: document DAMOS quota auto tuning
Date:   Thu, 30 Nov 2023 02:36:50 +0000
Message-Id: <20231130023652.50284-8-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DAMOS quota auto tuning feature on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1f7e0586b5fa..947c9df6cd33 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -346,6 +346,17 @@ the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
 
+Aim-oriented Feedback-driven Auto-tuning
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Automatic feedback-driven quota tuning.  Instead of setting the absolute quota
+value, users can repeatedly provide numbers representing how much of their goal
+for the scheme is achieved as feedback.  DAMOS then automatically tunes the
+aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
+is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
+is over achieving the goal, it decreases the quota.
+
+
 .. _damon_design_damos_watermarks:
 
 Watermarks
-- 
2.34.1

