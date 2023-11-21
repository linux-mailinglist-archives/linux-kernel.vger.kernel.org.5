Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92AC7F33CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjKUQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjKUQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:32:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B2197;
        Tue, 21 Nov 2023 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584358; x=1732120358;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=a0hiW0ugZ3WPuFUH975iQYWx7zRQJgHR8z77ikQEbyE=;
  b=ojamMJT2u6v3rA0/92PTjhqD/kp12S+z9gu2sSVs/lDf/k7h86njj5hr
   Dw+wTMGfHZ0Z6jDal7D9sHxcb4tmPAIllPwHRE9qjZiZiA2m7+aQMrmgw
   RlOv8ukkJSyB3bdTxNmoN0hF70wFpwl+YmwqQbPcW2T/EbJiApw8KReZe
   nA/tPkg1DHVkmzJCPvpCcdvLDh/86L5FR3N0Mz6zZHDQ7Rh31FJnYXWDr
   i/42+KZoW7myFoQlCkSDHWBAy0QraETRpgcrgSEc6x+yU9vtiZJvmHTjy
   nR7aEM3tT66A71qDImWxXtWa3LePEvoTBSSHnCaXBDtE7ngP3IyquDxYT
   Q==;
X-CSE-ConnectionGUID: vo7YZa9KRpuG7MJM9qH6Gw==
X-CSE-MsgGUID: 0bZVuSChRxSruo+u2KkS3g==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076032"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:35 +0800
IronPort-SDR: ihIXLt1ZSRxOPc4fPfNU/Ps569USj2QLcwiEve60FLuWXmA+ENIeaIiu9q4sXwf14bVPO9P5Ur
 IwuhJI+CYHjiGx1BKEa+JmNYGTWPsTvzq5qOKfG0zfkAPeaA+OKp98dkMGeWx82RJRQ40bX0QH
 jIWfH82/IjzSLQitiqxbxrEeuXb9fHZBCzgQs+Q+Ms96oTe50TqpxBZSnr1euthdFMUvUis1B/
 Or7W6UHzIP1AVPefSU/xiia5bqDK7UgcCVyQC0bDqejMa2mGhpKY0nMm5sXWDouZYre4FDMtep
 fm4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:14 -0800
IronPort-SDR: /h2oYavbxuBGrvAIhs5CjIcL2bCLulOjB9A3zzOQzQFnbvMLQFKpsRPU1UDw4zToEalirEELWh
 6+E7niVyQt4YKV5MOjAa5w0XwKaB24gg8d3Th+dPksOpXka1LU/SgI1WBDGdCDffjVtUOZl5jA
 mD+BmavJQKsrosva49MRbkUQzIyLaQH4H1r5gNsYC3oyBN7ZoTA3A7QBayt3w9FFSVShQgTg8d
 dJI7l6sygkPvamjmkZjN65H39qGW2bVRmvFSmKD8/PKqRvHgD9S5J4EL3Ee8g4fmYlq3+AWTZy
 EkE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:35 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] btrfs: zoned: remove extent_buffer redirtying
Date:   Tue, 21 Nov 2023 08:32:29 -0800
Message-Id: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3bXGUC/x3MTQqAIBBA4avErBvwj6iuEi1MR5sWFgoRSHdPW
 r7F9yoUykwF5q5CppsLn6mF7Dtwu02RkH1rUEJpKZXA4ywUMFJqzqEcNAbjgyG7KTeN0NyVKfD
 zP5f1fT/H+dmoYwAAAA==
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=1650;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=a0hiW0ugZ3WPuFUH975iQYWx7zRQJgHR8z77ikQEbyE=;
 b=nOE9SVbTJpXa0DAaj/6VwVfin9C7x/pPFeEgobBSeM7kam8Odx70p7GS+T8XAL7gGxHumZCAy
 6BRRL//62EnAXIjhiUY/ekt0++TEM6q4aaYC6czH/N240Z6Pa8YH9tF
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the beginning of zoned mode, I've promised Josef to get rid of the
extent_buffer redirtying, but never actually got around to doing so.

Then 2 weeks ago our CI has hit an ASSERT() in this area and I started to look
into it again. After some discussion with Christoph we came to the conclusion
to finally take the time and get rid of the extent_buffer redirtying once and
for all.

Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_CANCELLED, because
this fits the new model somewhat better.

Number two sets the cancel bit instead of clearing the dirty bit from a zoned
extent_buffer.

Number three removes the last remaining bits of btrfs_redirty_list_add().

The last two patches in this series are just trivial cleanups I came across
while looking at the code.

---
Johannes Thumshirn (5):
      btrfs: rename EXTENT_BUFFER_NO_CHECK to EXTENT_BUFFER_CANCELLED
      btrfs: zoned: don't clear dirty flag of extent buffer
      btrfs: remove now unneeded btrfs_redirty_list_add
      btrfs: use memset_page instead of opencoding it
      btrfs: reflow btrfs_free_tree_block

 fs/btrfs/disk-io.c     |   4 +-
 fs/btrfs/extent-tree.c | 102 ++++++++++++++++++++++++-------------------------
 fs/btrfs/extent_io.c   |   9 +++--
 fs/btrfs/extent_io.h   |   3 +-
 fs/btrfs/tree-log.c    |   1 -
 fs/btrfs/zoned.c       |  16 --------
 fs/btrfs/zoned.h       |   5 ---
 7 files changed, 60 insertions(+), 80 deletions(-)
---
base-commit: 592afe8e8b7ceee58107757fd29ff3290e6539e3
change-id: 20231120-josef-generic-163-f4df4eab2c98

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

