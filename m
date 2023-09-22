Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510C7ABAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIVVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjIVVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:12:09 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD64C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:12:03 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id CA938C60DC47; Fri, 22 Sep 2023 14:11:49 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 0/2] mm/ksm: add fork-exec support for prctl
Date:   Fri, 22 Sep 2023 14:11:39 -0700
Message-Id: <20230922211141.320789-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A process can enable KSM with the prctl system call. When the process is
forked the KSM flag is inherited by the child process. However if the
process is executing an exec system call directly after the fork, the
KSM setting is cleared. This patch series addresses this problem.

1) Change the mask in coredump.h for execing a new process
2) Add a new test case in ksm_functional_tests


Changes:
- V4:
  - Added motivation for the fix to the commit message of the
    first patch
- V3:
  - Combined two lines in function ksm_fork_exec_child()
- V2:
  - Removed the child program from the patch series
  - Child program is implemented by the program itself
  - Added a new command line parameter for the child program
  - Removed new section from Makefile
  - Removed duplicate ; charaters
  - Added return in if clause
  - Used PR_GET_MEMORY_MERGE instead of magic numbers
  - Resetting PR_SET_MEMROY_MERGE at the end.



Stefan Roesch (2):
  mm/ksm: support fork/exec for prctl
  mm/ksm: Test case for prctl fork/exec workflow

 include/linux/sched/coredump.h                |  7 +-
 .../selftests/mm/ksm_functional_tests.c       | 66 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 3 deletions(-)


base-commit: 15bcc9730fcd7526a3b92eff105d6701767a53bb
--=20
2.39.3

