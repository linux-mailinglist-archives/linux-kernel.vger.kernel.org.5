Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698F752EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjGNBxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjGNBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:53:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0E65E2D60
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:53:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 151E86062C7C7;
        Fri, 14 Jul 2023 09:53:09 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH v2] =?UTF-8?q?kernel:=20resource:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date:   Sun, 16 Jul 2023 02:24:28 +0800
Message-Id: <20230715182428.3348-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err is assigned first, so it does not need to initialize the assignment.
Modify __find_resource execution syntax to make it more in line with
commonly used styles.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 v2:
   Modify __find_resource Execution Syntax.

 kernel/resource.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..ee79e8f4f422 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -656,13 +656,14 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 			       resource_size_t newsize,
 			       struct resource_constraint *constraint)
 {
-	int err=0;
+	int err;
 	struct resource new = *old;
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
 
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	err = __find_resource(root, old, &new, newsize, constraint);
+	if (err)
 		goto out;
 
 	if (resource_contains(&new, old)) {
-- 
2.18.2

