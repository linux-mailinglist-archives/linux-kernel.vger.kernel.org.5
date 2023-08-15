Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF9B77C4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjHOAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjHOAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0462A1739
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D775164C2B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B40AC433CD;
        Tue, 15 Aug 2023 00:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060505;
        bh=UNDMqVBFCNk6b1A03SE3areXfHWhTB+t/pNxpu/gslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1jppoqe4US9n9CGmBpjEdhEDn/TAzPypdmyx2qsmvGkC4Fsrvz1YK8nGKZPZIPtL
         KaP1p3emDMTLGqHKVl6INVBT4/rGCeH5Zmjt9w9mZnqk9FUuHIDk2zYUGhHporY5nB
         vBfmVQVHSkPQRKtiA/fLKb3DcQUBnPttO7yR75Td8mKu/SG1Dc/eC9R5C0G5Zb3BCo
         u8NweEctbBX9ulBOo/exaaNWIB/RgaMrXjp8jIPq4AZPBmcGhYfvX0Mrsou7LcO9AS
         3W4xyDlz2wvr3Y2oQ2brfWCjaEGyWfueA+q1tY/zNdLDWIo2W050oXOEV0rF+57Hy3
         Txbdvr4ocgh0A==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 17/20] ARC: entry: replace 8 byte OR with 4 byte BSET
Date:   Mon, 14 Aug 2023 17:48:10 -0700
Message-Id: <20230815004813.555115-18-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FAKE_RET_FROM_EXCEPTION drops down to pure kernel mode. It currently has
an 8 byte instruction which can be replaced with 4 byte BSET

This is applicable to both ARCv2 and ARCv3 entr code.

ARCv2 current
------------
00000804 <EV_Trap>:
...
 874:   216a 1280               lr      r9,[status32]
 878:   2146 1809               bic     r9,r9,0x20
 87c:   2105 1f89 8000 0000     or      r9,r9,0x80000000
                  ^^^^^^^^^
 884:   2029 8240               kflag   r9

ARCv2 after
----------
000007e0 <EV_Trap>:
...
 850:   216a 1280               lr      r9,[status32]
 854:   2150 1149               bclr    r9,r9,0x5
 858:   214f 17c9               bset    r9,r9,0x1f
 85c:   2029 8240               kflag   r9

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 11b48ab39154..f7c9b3915d10 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -274,8 +274,8 @@
 
 .macro FAKE_RET_FROM_EXCPN
 	lr      r9, [status32]
-	bic     r9, r9, STATUS_AE_MASK
-	or      r9, r9, STATUS_IE_MASK
+	bclr    r9, r9, STATUS_AE_BIT
+	bset    r9, r9, STATUS_IE_BIT
 	kflag   r9
 .endm
 
-- 
2.34.1

