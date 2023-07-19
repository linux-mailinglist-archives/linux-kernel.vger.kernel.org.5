Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016075994C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGSPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGSPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0CC1;
        Wed, 19 Jul 2023 08:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1900B6173E;
        Wed, 19 Jul 2023 15:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD20C433C7;
        Wed, 19 Jul 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779840;
        bh=ysLR5wobitKPf8JrxKamS+gYhvSQgQK2wwYl0cnu1PE=;
        h=From:Subject:Date:To:Cc:From;
        b=PlfNTQDW0Gmv1RaV4rPthVL3t4AOzNBSe2PJ0jVSvxy0kjIwITjPjKKJouIh1KU/e
         9PfAGONXixqLgNcte3cw1giWGhzXYiuaK00okYWrYxum7nPVSHltp4Dgu+y71HT0Wl
         480g1FRkkdVzHe2enOVkrtl9XXqfoDpMHZwLE7GYWAPtymS+hZ4Mc4vTUmNBXYeIhx
         TAwGqSwPljSqps0B3sl1hkiQWxS0/oAs99M30vQxitiXf3qK/FoIagDIQUofb6DMuL
         n+z7jOIDfKV2Bz3Z0Bs6EtXC2/1XRMXDeKIQpfj9fSKI6NcphUpPlEQZTsn13RoK42
         H64ate9P+8CRw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 0/4] fs/9p: fix mmap regression
Date:   Wed, 19 Jul 2023 15:17:04 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHD+t2QC/5XOzQ6CMAwH8FcxO1vdh4J48j2MhwFFFmUjHVkgh
 He3cPOmhx7+bfNrZxGRHEZx3c2CMLnogudg9jtRtdY/EVzNWWipjcxVBo0bMUJISO8JCONArhp
 cQug624ORVpuzVJhfcsFGaSNCSdZX7arwrSq1xyYQeByHdaMn3Ege3x+cWxeHQNP2UFJr99fbS
 YEEmV1MqbkKo28vJI/vQ6CnWOmk/+I0c+qU1xlbTVYUX9yyLB8YSRoFPAEAAA==
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=ysLR5wobitKPf8JrxKamS+gYhvSQgQK2wwYl0cnu1PE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5+El6+7oA1ENNSlafzPFG0wmMLyaf10zHKO
 KWsRc4dp4eJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fgAKCRCI/9X7Sl//
 mO6xEACdcMUN6ZONVl6MaUH4zg1r7hs4oqp5fDM3fn8ui/ETaXv0yxqXw+83ZrrnnXSrBps8ZgR
 1IfxSsVTKB9A99KTDMxmH05ONKLIQ15qKzBlU7EZV5H2dbr56ddxluJB8SyQbCFPbHHQWR1vAel
 rcj3wNMDwlc1+fp5KQ4q1w+guaAy9XttjbL1gmS57n+GHWKwHXrxJZO5HiKd/oZHNxq+AlkA21J
 xuQGN95iYlsCTSA0mD2e1kpdRapz5sQyjvV0E4SGSlcGoxWTon5fecCze0N7addPooP3k+B+xJL
 eYPXKXecjvUfMcTtJhyyBiCypXzIBKLvECpn6ZpINTY+iaQv6Ug56m7qtpJlTy0vvIyh4+MAPLo
 lsrpsOSvE3M/VDeYu47prGkPzao1l2ntCWtFByH36KVtfP1cBgd11HphNccsa7qhyxz7H8Dcv+V
 GaXMwlTDp5KUGCuL7NZ0LOa2xW0p4KmPF2qhIG94K+9+g7RbfMzkNgHqN+BsQRMH2e6tXNrWcPN
 yt71qf/Sfu4jcURrM+R+NdqzF/9q7j0HkHSgJLn/2gB2A+qg7cC/hXZe8iv90g8EvWC10zCchKh
 A1laxFV0o0iO2e3Dfn9v6CGCJyv82Jvvmo6GQfgNLS15jk7jJ8tUj5hvZuPCvhUE2yAgC3e8F77
 HMR7H6s7Bpwim3w==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix a reported exception with mmap
on newer kernels. 

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v3:
- Clarify debug print to read-only mmap mode versus no mmap mode in
  v9fs_file_mmap
- Fix suggested regression tags and propagate across series
- Link to v2: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org

Changes in v2:
- fix requested changes in commit messages
- add patch to remove unnecessary invalidate_inode_pages in mmap readonly path
- Link to v1: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org

---
Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

 fs/9p/fid.h      | 6 +++---
 fs/9p/vfs_file.c | 5 +----
 2 files changed, 4 insertions(+), 7 deletions(-)
---
base-commit: 95f41d87810083d8b3dedcce46a4e356cf4a9673
change-id: 20230716-fixes-overly-restrictive-mmap-30a23501e787

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

