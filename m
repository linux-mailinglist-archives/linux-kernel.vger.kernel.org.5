Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35331759AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGSQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2318D;
        Wed, 19 Jul 2023 09:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF7161784;
        Wed, 19 Jul 2023 16:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440ABC433C8;
        Wed, 19 Jul 2023 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783770;
        bh=dp2zlWprh3aQ0p8wXOlySBFvIkjzoKk6uAidRdDwNXI=;
        h=From:Subject:Date:To:Cc:From;
        b=AUzM88a3kKAsyHKScqsmBk/UMAx6Ok1+sNAlGfHXUCy6C4pTVJi/LxmhNFIvpX2ys
         1Wrp7W1eVZWnmtJGQ6zruNMGNpIEblw6kwsAG5l7aF6Lb8DG3Meb2fP0pw9sKmrJvc
         8JuZR7T9tgw+rEJvmpmGm5TiJGW2PgIEGxgV7FnF6zM9yxUmDBoPKQMrKYx1IvKDnd
         k278pRPKQYAbkA2EXLsUBID+2DYvRc+9+BKHfBH8nZ5AOjYD58jTCp2S0B+oYLxl8C
         K9cqTggXA89ZhZmfyYeY7Ff1woblBrEVkukBOf0Lg8Cjn5kbi8tiGA/sjtMgRM00iu
         aOLWgOtvVDOvQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 0/4] fs/9p: fix mmap regression
Date:   Wed, 19 Jul 2023 16:22:29 +0000
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUNuGQC/5XOzW7CMAwH8FdBOWOWjy4hnPYe0w5p69AISJBTR
 SDUd5/LDe0yDj78betnP0RFSljFYfMQhC3VVDKHbrsRwxTyESGNnIWW2kinLMR0wwqlIZ3vQFh
 nSsOcGsLlEq5gZNDmUyp0eyfY6ENF6CnkYVoVvjW06SMWgoy3ed24Ej5JHn//cJ5SnQvdnw81t
 Xb/e7spkCDt3vSayxv9dULKeN4VOoqVbvotTjOnOjdatqL1/g9n3uIMc85651XsXBfHF25Zll9
 z0jvbiwEAAA==
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=dp2zlWprh3aQ0p8wXOlySBFvIkjzoKk6uAidRdDwNXI=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3Y7VGJe3Yy1lpSSN/S6sDVpTeL+Bt6aFbc3
 G5BJ6HgECSJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2AAKCRCI/9X7Sl//
 mHqIEACDYSv/QQ1TqXoHfQZK/4fDGKu1yLW9c3tAWBwQxBNRFDmIlYYGwWkZTlJK/MaPvTblsr/
 DMXO5i96RGRV7EmxWBkM+G5E8/H35UavAN1Xwl12DdPW4GS4SdbPZ4ZYZf26B1QRXev2tAGGdKj
 /oLi4zA6gapFDeHC08e8WCSGi8AcMzX+g1W7WU5ayu0G+iCksGF2Qn6dTOs0MIYj1msSCHZ149k
 xvZOShPlRSH/xnELD8Ba2HWKhryhr/oTswuGh+vN8KCXfpkpa8po6J+87pQ2dumFaUkYj6QZe1p
 xEL6v+5g5gH5nmUhdcVLJN6t7Jl7Uu5Ql6qPd1B07B9oBIJLETW2fU7PzqvBKnt2+T2nzsf2WQR
 jRka4rUV9h18TqM74YWVpVZtwwO1YmThzd7C34C5WEbF3X3J4Q7yM2ClekFBEor81evYix9P+2K
 cJOtq6VYpMPQaGA2wgiRC3wiLzJhyAzkXfnM9903N+biQLnhKfhpPTN8iBpig++6Uk3ShheYkPO
 ioa66pXWaVOlhq/dXQX8/x7pL6P7SVYjG+tx1hyt14OHJRhBp+kYKlHFQYWwz20pu6HkiY/MWtL
 G7BUtCeQ3FdffImILWZGd8zLJMC/RB5s1B1TE/a4gdOIVlKzjwLQ/bVkNGHxYLbmnKQFVG4Enr+
 lRCqAbzzwT5ugiA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix a reported exception with mmap
on newer kernels. 

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Closes: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v4:
- Another attempt to fix tags for regression and stable, sorry for the
  noise.
- Link to v3: https://lore.kernel.org/r/20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org

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

