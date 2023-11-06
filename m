Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4927E3179
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjKFXeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKFXeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:34:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E5D83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 15:34:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54337C433C7;
        Mon,  6 Nov 2023 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699313649;
        bh=PbpR9uAMS4z983F6X6mqfiz2aQZYHIrus56jewv3Dm0=;
        h=From:To:Cc:Subject:Date:From;
        b=Zf599/1WIA2jNOUN4kR6gOh3lwFhhyDXC4RuryzQnC5JBIIHZIzvtul8AWm0Cj3AP
         DRTXjtzUf05LqPIg2tLtbNDn5BzCTLwS7WGB8flQ2zX2OBsp6ZNSAIqULowMqed27J
         CAoHT1Pzg6ONtcJLuS2YPea+Eq/vqqIeh6VIyxxja8Feu0ezVbgdOzCMrXQND5LZAi
         0wIqTG5GMQP7N68wqCP3uZlmKxSYyxbWw6k2Ly4LDD7L7AwhLXWDSvSefmSw23Efa7
         E8YRMS7WI+nFrqyD4iqio5wDm049e6aoKFO99iOvGpYK1QCT45QIqL0W0i026aHu9C
         qQ/b2gV0R/fhA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon/sysfs: fix unhandled return values
Date:   Mon,  6 Nov 2023 23:34:05 +0000
Message-Id: <20231106233408.51159-1-sj@kernel.org>
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

Some of DAMON sysfs interface code is not handling return values from
some functions.  As a result, confusing user input handling or
NULL-dereference is possible.  Check those properly.

Please note that these patches are not cleanly applicable on mm-unstable
since mm-unstable has dropped the mainline-merged patches and rebased on
v6.6, while some DAMON patches that these patches are depend on are
merged in the mainline after v6.6.  I confirmed these patches can
cleanly applied on latest mainline, or mm-stable-2023-11-01-14-33.

SeongJae Park (3):
  mm/damon/sysfs: check error from damon_sysfs_update_target()
  mm/damon/sysfs-schemes: handle tried regions sysfs directory
    allocation failure
  mm/damon/sysfs-schemes: handle tried region directory allocation
    failure

 mm/damon/sysfs-schemes.c | 5 +++++
 mm/damon/sysfs.c         | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)


base-commit: 3496e8e0a1eeabb738105c09e575495fa78914bb
-- 
2.34.1

