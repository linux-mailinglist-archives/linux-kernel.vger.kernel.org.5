Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21C676D9D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHBVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjHBVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0972E7D;
        Wed,  2 Aug 2023 14:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A100A61B53;
        Wed,  2 Aug 2023 21:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92052C433C9;
        Wed,  2 Aug 2023 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012600;
        bh=0npm47qE7mM3V04g26fYupZB0KuQfvcIrbkch6jch58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmuvGpQGlAkUw9hAqOZXqKjRKwBsAsxuCPkSHgm3kIYifPfLVO8FNIUzDNc0uD73H
         T2bNTn8jozkgprT0X4+pUyK4KHv5/i/rCTnZ5ZNvSDKiGsTwE+/VopQNhY15M1vXzo
         HVlFk0wPQygfnrmkrsbp0AlO7ROtpMId1UtWLbaeuX48W2/Zo2wcsLHJwxkPNew9Ul
         NR/JuPLAV/rjcCR5zCCzk8ohmpZm4BA/mdMSi7G4f7r2JRvO2Ki+EG/KPdskeYJz9s
         oQJjc9Q5Uq6DZv+iMiYuBJkS0fS3AyLf+dplficscCvhTwev1ZKXzRzcTv5YcRmW/+
         vc8M30ajpgunw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] Docs/ABI/damon: update for address range DAMOS filter
Date:   Wed,  2 Aug 2023 21:43:05 +0000
Message-Id: <20230802214312.110532-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON ABI document for address ranges type DAMOS filter files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 3d9aaa1cafa9..0bc074d4618c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -271,8 +271,9 @@ What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
-		the memory of the interest.  'anon' for anonymous pages, or
-		'memcg' for specific memory cgroup can be written and read.
+		the memory of the interest.  'anon' for anonymous pages,
+		'memcg' for specific memory cgroup, or 'addr' for address range
+		(an open-ended interval) can be written and read.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
 Date:		Dec 2022
@@ -281,6 +282,21 @@ Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_start
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'addr' is written to the 'type' file, writing to or reading
+		from this file sets or gets the start address of the address
+		range for the filter.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_end
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'addr' is written to the 'type' file, writing to or reading
+		from this file sets or gets the end address of the address
+		range for the filter.
+
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

