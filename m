Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59A17A6C88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjISUwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjISUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:52:21 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270CBF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:52:14 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 4CB08C361C1B; Tue, 19 Sep 2023 13:51:59 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 0/2] mm/ksm: add fork-exec support for prctl
Date:   Tue, 19 Sep 2023 13:51:56 -0700
Message-Id: <20230919205158.1897353-1-shr@devkernel.io>
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



Stefan Roesch (2):
  mm/ksm: support fork/exec for prctl
  mm/ksm: Test case for prctl fork/exec workflow

 include/linux/sched/coredump.h                |  7 ++-
 tools/testing/selftests/mm/Makefile           |  2 +
 .../selftests/mm/ksm_fork_exec_child.c        |  9 ++++
 .../selftests/mm/ksm_functional_tests.c       | 50 ++++++++++++++++++-
 4 files changed, 65 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/mm/ksm_fork_exec_child.c


base-commit: 15bcc9730fcd7526a3b92eff105d6701767a53bb
--=20
2.39.3

