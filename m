Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198F767710
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjG1UfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjG1UfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18244492;
        Fri, 28 Jul 2023 13:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D70362206;
        Fri, 28 Jul 2023 20:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC43C433CB;
        Fri, 28 Jul 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576492;
        bh=0npm47qE7mM3V04g26fYupZB0KuQfvcIrbkch6jch58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrxOU/dNh7jCfSKEdcp2NaJS0/E9e7SwsZdBuNxy5RQsHjiWpl6nQFNDHC1cgMXoN
         YZMJtZg+OwctxSsEr9MpVt052ifmf3dVP/0yjPdxdwc5CjViezW6aLvDbyZTnruc4t
         pZCSvfk5WEVpX2pvYQY4gf5yFA62IQ1ppZpYH2hQENmnJNk6w4B2rvQwCY96KJ3FLN
         1FhQFQBA8qhXEIJgCbaRbZtd5GJW54biKuy3jEc0aTf32BaIPXauFRF1vvYxwPrOeh
         qcTZTdaCusboMSVeL/RRJ8U2FRA3+UCrNT4Ad55sFhFPYEIwEbToVXf+cQeQI6bqLe
         C2sMA5joPS5qg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/13] Docs/ABI/damon: update for address range DAMOS filter
Date:   Fri, 28 Jul 2023 20:34:37 +0000
Message-Id: <20230728203444.70703-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

