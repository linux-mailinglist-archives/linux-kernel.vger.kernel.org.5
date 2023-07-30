Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72B7685FE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjG3O0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3O0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A7199
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4055D60B66
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66557C433C8;
        Sun, 30 Jul 2023 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690727158;
        bh=d8GF2nj75dcAK/W9xm27IQOlnskgBpm9dOo8ZbtueO0=;
        h=From:To:Cc:Subject:Date:From;
        b=r9uankZ7WV2NH7kxQVR4E7GJxfRrmfeRRSEqY/T7MMQISryAIPzyvqDkEa2xmTo4J
         ikfUr1rRYoSiu5NxCTcB/TRvOPB9i+m4A0hlZ226R4O7WWkzseocgfREbAGn+sj8UL
         yMW3+YJv2BfVCROnAZZ9HYJ8GS1v4Db3VKEN7xunZBJ0ekWRgqX+/YW4VdhyZzl+PM
         A0jx57OnYvlrBMHubevOAIUOfKRDBu8OqKyLr056BOsw5ECuHdU1kfRp0a+UbUfyUs
         TGrE07RgEul+Bc3Y8IldPVdY/imRuPEtyKmu7DbnQfjXEGltpByd+Fid+67Se+X1m5
         S4o6UGtMR43Wg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: doc: fix description of max_small_discards
Date:   Sun, 30 Jul 2023 22:25:51 +0800
Message-Id: <20230730142552.3918623-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

The description of max_small_discards is out-of-update in below two
aspects, fix it.
- it is disabled by default
- small discards will be issued during checkpoint

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ad3d76d37c8b..36c3cb547901 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -102,9 +102,9 @@ What:		/sys/fs/f2fs/<disk>/max_small_discards
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:	Controls the issue rate of discard commands that consist of small
-		blocks less than 2MB. The candidates to be discarded are cached until
-		checkpoint is triggered, and issued during the checkpoint.
-		By default, it is disabled with 0.
+		blocks less than 2MB. The candidates to be discarded are cached during
+		checkpoint, and issued by issue_discard thread after checkpoint.
+		It is enabled by default.
 
 What:		/sys/fs/f2fs/<disk>/max_ordered_discard
 Date:		October 2022
-- 
2.40.1

