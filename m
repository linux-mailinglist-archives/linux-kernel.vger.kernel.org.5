Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557EB7F6341
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbjKWPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbjKWPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:47:57 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EAC1;
        Thu, 23 Nov 2023 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754483; x=1732290483;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=CTX5KvvgdrTsg7p8OnAZgf7FxwGXh2z+Mhi27UJgJ4Q=;
  b=UDCLdEd+Bb6nwhBto1XjllUAqrvU1edxO9a+fExEnSLQW4lnN8EROI9l
   w6EQcyjtIwumKy8n+40IQ0djA7cxnw/V0I6zq5DUxr3GyikMKeZW+KxP6
   eUezrO6fKtZcrg31SIf7tK1owY/P/FGA20SWN0wIdXOyjJLQ6+Tda0Pmn
   1LdLG28qRMsP+eDq3ZwQ1YS77rmydFS1USI4PsBjsXkJ+P3iXep/N4Bxk
   S4HF2KC4trPGUFpr2czUAh2zAhNvRLdEcZDU8ZQunIUwkwsgJ9BfcQfRB
   sIG3tI2D9yh6V6xdNSf+qr86Drw/p4Fi5nCqdziJyFEEbzXohdo534tTR
   A==;
X-CSE-ConnectionGUID: IbuvLynlSvKRjrA8ik4ZfQ==
X-CSE-MsgGUID: J6IRFKNHRK2x6R8J40l5pw==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3129197"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:25 +0800
IronPort-SDR: yvlYE0fFMMVn3+OAAEFRErHaPTmuEQ5myLsYHxfF3iol+8AHdcUbmeGS89U5f4xQNA5TVkSzeu
 imaALadapih9KbA3Azcqzyj5SMOZDo4I6tcjV8RNCLAcVTmM/9PfkE0hALStEtqSd8kUpTQMbu
 JV5IOXhESeEnopnqo7pWqV3u1sDOiuuQNywsP7mtOkcbSyz6j+KPHQHSOGh3hzUefO6MVVsana
 nMQYv7ocbzXqtTrOxrD31ahou2zQ9YAG0LXZFJVpgeltfKza9r+HeHqi+yoeor7n+2uGzEB3nm
 J+0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:58:41 -0800
IronPort-SDR: VlVTdledMOtlAk9w60uDMeGBo9FxlsO6K5T5qVN8bPQl8PugdQqlRiY00niArHMbtaAR7mxxJG
 3z+iVAlMl4ffZzEG8fEcEvzivoLBSNPTcafCoIPFZztExKwHDQ8ojNjbN5bpSM363YvkfP41Wv
 cxHdd7/hZ/urSxenMq5r/CskSg52cr9h/Pvee1HYEwBUJhtDJRLzbpDT4eV702tJ6Ti8u1oA7T
 jP0Q5PF/zkOw0pu0lCTRzBCbBiRfDG9tNcbr2SIrSZyot2uFfeUz7GEVZt6m81CfJ+fvql98FX
 WUc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:24 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] btrfs: zoned: remove extent_buffer redirtying
Date:   Thu, 23 Nov 2023 07:47:14 -0800
Message-Id: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAN0X2UC/22NQQrCMBBFr1Jm7UgmiZq68h7SRU0n7Qg2kkhVS
 u9uLLhz+T6892fInIQzHKsZEk+SJY4F9KYCP7RjzyhdYdBKGyKt8BozB+x5LJ5H2hsMtguW24v
 2tYPi3RMHea3Nc1N4kPyI6b1eTPRdfzX6U5sIFSpbszmQ2zlLp2fntz7eoFmW5QNoHvc5sAAAA
 A==
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=1956;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CTX5KvvgdrTsg7p8OnAZgf7FxwGXh2z+Mhi27UJgJ4Q=;
 b=+GlT1k7R+eeutsowVFxL6yS5MvlOHpSZVEv3B/yWnSKMMRTx6jtgIymMc/IrkRzr2O/rbECvR
 esX9BpccjubCXAj8GMFlhvzMXbti+8yFaVAWChYlXo38ExV9ZVMJhSV
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_ZONED_ZEROOUT,
because this fits the new model somewhat better.

Number two sets the cancel bit instead of clearing the dirty bit from a zoned
extent_buffer.

Number three removes the last remaining bits of btrfs_redirty_list_add().

The last two patches in this series are just trivial cleanups I came across
while looking at the code.

---
Changes in v2:
- Rename EXTENT_BUFFER_CANCELLED to EXTENT_BUFFER_ZONED_ZEROOUT
- Add comments why we're marking the buffer as zeroout and zero it.
- Add Reviews from Josef and Christoph
- Link to v1: https://lore.kernel.org/r/20231121-josef-generic-163-v1-0-049e37185841@wdc.com

---
Johannes Thumshirn (5):
      btrfs: rename EXTENT_BUFFER_NO_CHECK to EXTENT_BUFFER_ZONED_ZEROOUT
      btrfs: zoned: don't clear dirty flag of extent buffer
      btrfs: remove now unneeded btrfs_redirty_list_add
      btrfs: use memset_page instead of opencoding it
      btrfs: reflow btrfs_free_tree_block

 fs/btrfs/disk-io.c     |   9 ++++-
 fs/btrfs/extent-tree.c | 102 ++++++++++++++++++++++++-------------------------
 fs/btrfs/extent_io.c   |  18 +++++++--
 fs/btrfs/extent_io.h   |   3 +-
 fs/btrfs/tree-log.c    |   1 -
 fs/btrfs/zoned.c       |  16 --------
 fs/btrfs/zoned.h       |   5 ---
 7 files changed, 74 insertions(+), 80 deletions(-)
---
base-commit: 592afe8e8b7ceee58107757fd29ff3290e6539e3
change-id: 20231120-josef-generic-163-f4df4eab2c98

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

