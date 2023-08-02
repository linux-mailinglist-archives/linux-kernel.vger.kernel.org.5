Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288CA76D9DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjHBVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjHBVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C4211F;
        Wed,  2 Aug 2023 14:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C5961B30;
        Wed,  2 Aug 2023 21:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76513C433AB;
        Wed,  2 Aug 2023 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012603;
        bh=vyjBGWyxBLS7yKk1ryFlF7UDmbUqwEQwLNgOkCH6QUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InKTFXglKyqDxzYPMq7NxuLc1kuCMy7s7lSSgw9zcaoztarPdVrWFnCGfQbaD8diT
         XYkrtAgwTrLYuesB6SPbEwxHNv7DbcZ+Zy2RmEoVzRNJJV0ad47F/S3+7M4Df8R0lb
         v/FVFU7wdrXt4u4P9/4cy8TUxl1WNvh/Auirz4Xmdfn4kx1gaXYFlALCP0law6E6we
         9ySCKnGfQv0yhHkaC1GvNYxVSigA+7WxkHolZNxxjsevvCJ1zdTF+QPVFZ9IwHU+y3
         9J43bQ+duZE008f243VXYMyqt1QkpgLLQOpPfgULP8cHLSS/fHir5X/eCgj7vhrBnH
         QR5XuDszSHpTA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] Docs/ABI/damon: update for DAMON monitoring target type DAMOS filter
Date:   Wed,  2 Aug 2023 21:43:11 +0000
Message-Id: <20230802214312.110532-13-sj@kernel.org>
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

Update DAMON ABI document for the newly added DAMON monitoring target
type DAMOS filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 0bc074d4618c..334352d198f8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -272,8 +272,9 @@ Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
 		the memory of the interest.  'anon' for anonymous pages,
-		'memcg' for specific memory cgroup, or 'addr' for address range
-		(an open-ended interval) can be written and read.
+		'memcg' for specific memory cgroup, 'addr' for address range
+		(an open-ended interval), or 'target' for DAMON monitoring
+		target can be written and read.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
 Date:		Dec 2022
@@ -296,6 +297,12 @@ Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the end address of the address
 		range for the filter.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'target' is written to the 'type' file, writing to or
+		reading from this file sets or gets the index of the DAMON
+		monitoring target of the interest.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
-- 
2.25.1

