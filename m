Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0957F715A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjKXKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjKXKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:24:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A9D992;
        Fri, 24 Nov 2023 02:25:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70841063;
        Fri, 24 Nov 2023 02:25:48 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030A83F7A6;
        Fri, 24 Nov 2023 02:25:00 -0800 (PST)
Date:   Fri, 24 Nov 2023 10:24:58 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [BUG] Boot crash on v6.7-rc2
Message-ID: <20231124102458.GB1503258@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just hit a boot crash on v6.7-rc2 (arm64, FVP model):

[    1.418845] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000517
[    1.418855] Mem abort info:
[    1.418860]   ESR = 0x0000000096000004
[    1.418867]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.418876]   SET = 0, FnV = 0
[    1.418882]   EA = 0, S1PTW = 0
[    1.418889]   FSC = 0x04: level 0 translation fault
[    1.418897] Data abort info:
[    1.418902]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    1.418910]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.418919]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.418928] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000881835000
[    1.418938] [0000000000000517] pgd=0000000000000000, p4d=0000000000000000
[    1.418952] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.418961] Modules linked in:
[    1.418969] CPU: 0 PID: 8 Comm: kworker/0:0 Tainted: G                T  6.7.0-rc2-dirty #4191 40d10cdc812c74fd5dc5d91e2452ff6f1e5f4b4a
[    1.418984] Hardware name: FVP Base RevC (DT)
[    1.418992] Workqueue: mld mld_ifc_work
[    1.419003] pstate: 101402005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.419016] pc : ___neigh_create+0x790/0x9c8
[    1.419028] lr : ___neigh_create+0x270/0x9c8
[    1.419041] sp : ffff8000800c3a20
[    1.419048] x29: ffff8000800c3a20 x28: ffffd7c64c921078 x27: ffff00080188bd50
[    1.419066] x26: ffff00080183a30c x25: ffff00080188bda0 x24: ffff00080183a300
[    1.419084] x23: 0000000000000000 x22: 0000000000000010 x21: ffff00080188bcc0
[    1.419102] x20: 0000000000000000 x19: ffff0008003ef000 x18: 0000000000000014
[    1.419119] x17: 00000000cf0f2572 x16: 0000000080faa78d x15: 00000000b79921ac
[    1.419137] x14: ffff00087ff332c0 x13: 1600000000000000 x12: 00000000000002ff
[    1.419155] x11: 000000007c2c4dbd x10: 0000000000000003 x9 : 0000000000000000
[    1.419172] x8 : ffff00080188bd80 x7 : 00000000be3df655 x6 : 00000000f1691d6f
[    1.419190] x5 : 000000007c2c4dbd x4 : 0000000000000000 x3 : 000000008eb8ab5b
[    1.419207] x2 : 000000000000050f x1 : 000000000000001d x0 : 00000000000002ff
[    1.419225] Call trace:
[    1.419230]  ___neigh_create+0x790/0x9c8
[    1.419243]  __neigh_create+0x18/0x20
[    1.419255]  ip6_finish_output2+0x5f8/0x8c4
[    1.419267]  ip6_finish_output+0x1f0/0x258
[    1.419279]  ip6_output+0x70/0x1cc
[    1.419291]  NF_HOOK.constprop.0+0x4c/0xd8
[    1.419302]  mld_sendpack+0x1b4/0x394
[    1.419313]  mld_ifc_work+0x1d4/0x4b4

I tracked it down to the following line in net/core/neighbour.c ___neigh_create:
	memcpy(n->primary_key, pkey, key_len);

I did this by surrounding the memcpy with BUG():
	BUG_ON(n->tbl != tbl);
	memcpy(n->primary_key, pkey, key_len);
	BUG_ON(n->tbl != tbl);

And it was crashing on the second one.

Checking `struct neighbour`:

	struct neighbour {
		struct neighbour __rcu	*next;
		struct neigh_table	*tbl;
	.. fields ..
		u8			primary_key[0];
	} __randomize_layout;

Due to the `__randomize_layout`, `primary_key` field is being placed before `tbl` (actually it's the same address since it's a 0 length array). That means the memcpy() corrupts the tbl pointer.

I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide it if needed), it doesn't look as if it's a new issue.

I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary_key` didn't overlap).
However I tried changing the zero-length-array to a flexible one:

	+	DECLARE_FLEX_ARRAY(u8, primary_key);
	+	u8		primary_key[0];

Then the field offsets ended up overlapping, and I also got the same crash on v6.6.

Thanks,
Joey
