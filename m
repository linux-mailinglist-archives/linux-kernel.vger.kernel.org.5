Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799A76BF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjHAVzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHAVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4F103;
        Tue,  1 Aug 2023 14:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1326D6172A;
        Tue,  1 Aug 2023 21:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB77C433C8;
        Tue,  1 Aug 2023 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926916;
        bh=g77t/OfpnenRQkfxAJBR/wes+BJ5Qwsz7PG8xMvT9Ic=;
        h=From:Subject:Date:To:Cc:From;
        b=UK+uVCBdDzx05ihe4RoK9kitOsn+IoWzRFdi9mKEJe9US1FUgB+Q2Bs0/8lMGkUo8
         IlvNqGMTMrAmXDP+eh7W4a1aAGHGLUy+WuDDb1wJOS8SJ+tagtG+PxujDIYeU6WaCE
         06Tt5a1kCI2ewnWZK30HwdlwRUJiTRzT4Mo/I6SkHnzS3P4pErjtOg7Tfot40GkUCR
         pFAKXtQ7R7mzkPK6TetJDW+PpEczRUP6CslfED52SGdxQywMGgeF1U6GAxzA0/Zkeq
         0dbSEYdfGSxwBbvzTOhSkdZSynec7PFHSWYppSYE14vI2jgOoVzDQn5WPmsiptG99q
         mKSp/pQdHAHTA==
Received: (nullmailer pid 2469334 invoked by uid 1000);
        Tue, 01 Aug 2023 21:55:14 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/5] dt: changeset fixes and cleanups
Date:   Tue, 01 Aug 2023 15:54:43 -0600
Message-Id: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACN/yWQC/yXLWwqDMBBG4a3IPHcwamlDt1L6kMuvhkIsM0EEc
 e+N7ePh4+ykkASlR7OTYE2allyjuzQUZpcncIq1qTf9YKzpOBb+g6LwmDYo+/vNWzsihOtAdfR
 OwV5cDvO5vheZ2ljajK2c/BH8vmrP13F8AfuX0tGDAAAA
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert's locking fix[1] prompted my closer look at 
__of_changeset_entry_apply() and related functions. The result is a 
couple of fixes I found and some refactoring that unifies the "old API" 
and the changeset API.

[1] https://lore.kernel.org/all/c593d8389352c574b5be69d4ca4810da13326a50.1690533838.git.geert+renesas@glider.be/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (5):
      of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
      of: dynamic: Fix race in getting old property when updating property
      of: dynamic: Move dead property list check into property add/update functions
      of: Refactor node and property manipulation function locking

 drivers/of/base.c     |  86 ++++++++++++++++------------
 drivers/of/dynamic.c  | 153 +++++++++++---------------------------------------
 drivers/of/unittest.c |   4 +-
 3 files changed, 87 insertions(+), 156 deletions(-)
---
base-commit: e251a4e28a27884e8bfb7fccbf53b24736f3ef87
change-id: 20230801-dt-changeset-fixes-b76b88fecc43

Best regards,
-- 
Rob Herring <robh@kernel.org>

