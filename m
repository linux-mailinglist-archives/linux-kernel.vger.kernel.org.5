Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03C7BFFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjJJOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjJJOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:52:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959B99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696949554; x=1728485554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=prDOZaLhNry5FEtEme6DwAIMpa0s28Zjnwh4T+OU7pE=;
  b=QwHjc/KGi6BpXOr6IZAT14VyW9QKo8O6naYZ4h0hggoRrRL60oSAI3nY
   4tDIep2XkMC7wZoVqKcEdP8QYzM12O1TeaQXiHxmLlx7pjdiPJHa7cRVp
   xzA53lS4k/GVSu7IEgNzXSXWIPnWCwZBC3yfwmU19/BT/wS5XhcOvuE81
   xz2P+CkofMO9rcyzbwkbgbqj7LlllUepU9fDsRAhS8HwfPRt1YqKp9sNs
   4y5iHK6Q2l9H9QuwhXEG1wPhRAZynbE0N8AUGU0zvpsfpychhInZfIfoa
   dD64z+IZWHx5zJTwSSHuHII170YwUyy5bfBzBtSs3dVLgNkqWmi5e8xFm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374763954"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374763954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788609429"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="788609429"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 07:52:30 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 0/2] x86/sev: Generalize sev_setup_arch()
Date:   Tue, 10 Oct 2023 17:52:18 +0300
Message-Id: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v3:
 * rebased
 * moved mem_encrypt_setup_arch under a common #ifdef CONFIG_X86_MEM_ENCRYPT
   per Tom's comment

v2: [1]
 * added 2/2, which is a minor cleanup

v1: [0]

The main intention of this is to move sev_setup_arch() to mem_encrypt.c
to reflect the fact that it's not SEV-specific, but covers TDX as well,
although unintentionally.

While looking at it, I also noticed that mem_encrypt_amd.c still
includes virtio_config.h, which was needed for the code that since got
moved to a different place (and even there doesn't require the include
any more).

[0] https://lore.kernel.org/all/20230530121728.28854-1-alexander.shishkin@linux.intel.com/
[1] https://lore.kernel.org/all/20230609171214.31846-1-alexander.shishkin@linux.intel.com/

Alexander Shishkin (2):
  x86/sev: Move sev_setup_arch() to mem_encrypt.c
  x86/sev: Drop unneeded include

 arch/x86/include/asm/mem_encrypt.h |  4 ++--
 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/mm/mem_encrypt.c          | 34 ++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c      | 36 ------------------------------
 4 files changed, 37 insertions(+), 39 deletions(-)

-- 
2.40.1

