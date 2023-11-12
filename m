Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851B7E925C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjKLTqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKLTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51870213A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A10C433C8;
        Sun, 12 Nov 2023 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818377;
        bh=tm53i8GhYDRGpRCnZgtLIn7P8jIf3OMjFqv6O/swkJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXNBzq2zCZgn2UYIGKvFcCBBjZM3OsXnwYAYjfdnuvAc7vizTJiNCl+uyVVJ6WyIm
         Cfgcc3kzBfeZ3Jb5Tckg+aiaCEnG/DcKQxoVCzBEwRPhaIgEZYt1XfmOrheu95cfLH
         OGw+GOLfmabiO+SZ/+OReGQK7XVM2GUG8Q0FZEyEtHLjcauH9QISo0m2+uBSHkttxd
         t7TGcn79ZD6lqANkN6R6bAfwexg2lNxX+DqYtmWqIygswnmKYtfczhmiNjZBWJyY/h
         99/hFUjkYThSkmQk2NsHbl+q8HGW8K0e1YEk7+QzlP5FY4ocV5B+Q/nD9Me0FxYIvI
         X9b4MAHnJ6GjA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/8] selftests/damon: test quota goals directory
Date:   Sun, 12 Nov 2023 19:46:05 +0000
Message-Id: <20231112194607.61399-7-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DAMON selftests for testing creation/existence of quota goals
directories and files, and simple valid input writes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 56f0230a8b92..e9a976d296e2 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -150,6 +150,32 @@ test_weights()
 	ensure_file "$weights_dir/age_permil" "exist" "600"
 }
 
+test_goal()
+{
+	goal_dir=$1
+	ensure_dir "$goal_dir" "exist"
+	ensure_file "$goal_dir/target_value" "exist" "600"
+	ensure_file "$goal_dir/current_value" "exist" "600"
+}
+
+test_goals()
+{
+	goals_dir=$1
+	ensure_dir "$goals_dir" "exist"
+	ensure_file "$goals_dir/nr_goals" "exist" "600"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "1" "valid input"
+	test_goal "$goals_dir/0"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "2" "valid input"
+	test_goal "$goals_dir/0"
+	test_goal "$goals_dir/1"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "0" "valid input"
+	ensure_dir "$goals_dir/0" "not_exist"
+	ensure_dir "$goals_dir/1" "not_exist"
+}
+
 test_quotas()
 {
 	quotas_dir=$1
@@ -158,6 +184,7 @@ test_quotas()
 	ensure_file "$quotas_dir/bytes" "exist" 600
 	ensure_file "$quotas_dir/reset_interval_ms" "exist" 600
 	test_weights "$quotas_dir/weights"
+	test_goals "$quotas_dir/goals"
 }
 
 test_access_pattern()
-- 
2.34.1

