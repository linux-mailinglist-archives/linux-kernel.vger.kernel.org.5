Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1515E80F720
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377243AbjLLTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:48:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE39A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:48:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFA9C433C8;
        Tue, 12 Dec 2023 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702410499;
        bh=igd2RnhMFXzUjNiscTu9eDHYyW+3+ewG3ZKhV0p4XGo=;
        h=From:To:Cc:Subject:Date:From;
        b=X95NT4afRyAWsTbccHx94B2W6zzknjz9JqcA0ko1z5FUEoNTBl7Ci88oljGXp5l9U
         +MDcVdzohghe0yxN+qav+YX16YRFRiO+7n0a8yfPKE5Uv67CS+rgZwxKw5LG992pcM
         lbTYfra/SJ7b4EozxyjCKF1bAGwmlHxKPhxXy1v2Nvs2LbNJMePXF0xOTsZQYoCqfe
         42knU6Y/QcMzxziq4TBYGFQRm/HBIjSLfGUfqDg779PmkHUf0g4D2seuunMQv8Iko6
         TbOwyb4nfQfs8hqd+lo5mt5Lt7Zr899nMncYM4jKYErwoVCVsm49Znn3CKIpO7n9k1
         FjYLmCmvp/u8w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] selftests/damon: add Python-written DAMON functionality tests
Date:   Tue, 12 Dec 2023 19:48:05 +0000
Message-Id: <20231212194810.54457-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Changes from v1
(https://lore.kernel.org/damon/20231212191206.52917-1-sj@kernel.org/)
- Fix conflicts on latest mm-unstable tree

Changes from RFC
(https://lore.kernel.org/damon/20231202000806.46210-1-sj@kernel.org/)
- Make the working set size estimation test more reliable
- Wordsmith coverletter and commit messages
- Rename _damon.py to _damon_sysfs.py

DAMON exports most of its functionality via its sysfs interface.  Hence
most DAMON functionality tests could be implemented using the interface.
However, because the interfaces require simple but multiple operations
for many controls, writing all such tests from the scratch could be
repetitive and time consuming.

Implement a minimum DAMON sysfs control module, and a couple of DAMON
functionality tests using the control module.  The first test is for
ensuring minimum accuracy of data access monitoring, and the second test
is for finding if a previously found and fixed bug is introduced again.

Note that the DAMON sysfs control module is only for avoiding
duplicating code in tests.  For convenient and general control of DAMON,
users should use DAMON user-space tools that developed for the purpose,
such as damo[1].

[1] https://github.com/damonitor/damo

Patches Sequence
----------------

This patchset is constructed with five patches.  The first three patches
implement a Python-written test implementation-purpose DAMON sysfs
control module.  The implementation is incrementally done in the
sequence of the basic data structure (first patch) first, kdamonds start
command (second patch) next, and finally DAMOS tried bytes update
command (third patch).

Then two patches for implementing selftests using the module follows.
The fourth patch implements a basic functionality test of DAMON for
working set estimation accuracy.  Finally, the fifth patch implements a
corner case test for a previously found bug.

SeongJae Park (5):
  selftests/damon: implement a python module for test-purpose DAMON
    sysfs controls
  selftests/damon/_damon_sysfs: implement kdamonds start function
  selftests/damon/_damon_sysfs: implement updat_schemes_tried_bytes
    command
  selftests/damon: add a test for update_schemes_tried_regions sysfs
    command
  selftests/damon: add a test for update_schemes_tried_regions hang bug

 tools/testing/selftests/damon/Makefile        |   3 +
 tools/testing/selftests/damon/_damon_sysfs.py | 322 ++++++++++++++++++
 tools/testing/selftests/damon/access_memory.c |  41 +++
 ...sysfs_update_schemes_tried_regions_hang.py |  33 ++
 ...te_schemes_tried_regions_wss_estimation.py |  55 +++
 5 files changed, 454 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon_sysfs.py
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py


base-commit: 091b8c820de390a6235595bdb281edab63b9befe
-- 
2.34.1

