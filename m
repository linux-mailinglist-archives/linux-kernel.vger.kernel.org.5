Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1177C4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHOAsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjHOAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B31710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366E764A88
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D2AC433CA;
        Tue, 15 Aug 2023 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060500;
        bh=zkG7tKNl0pma2wQFLKTamwokqNgfsNplt2WvHHW0PGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kO8RZEOgp4rtCJQvp9wDXzhuhF7W3vI/goCzoA04uvMkG+BW64KEvcpWXKMlnfY72
         jkhHSjgPy9uYEOCcFrDtkCbCn2Z6aSS0ghRRTfSrPAGN4GF0ilZ5K+kUmmJR5+etfZ
         Ius1ROSzMsZwSVd3AZVpmi+7vQl3Ejjtb7z3B/vgP3/t+UVWcMd7E1y1sB1Cd/UlNZ
         UQaeO7GTK9aqkt32A5/Xei8MX0D5AK0LJkypV+gUXCwv74P+opA8zGqmt3fID7t/xf
         yWVUgdv2UjxM03uEtOaS3JcAfIj40GKCirBj6lIOv7AYRYJeXz2dAhC1LeKXQ/ZmH3
         YI4mQFHuPInIQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 04/20] ARCv2: memset: don't prefetch for len == 0 which happens a alot
Date:   Mon, 14 Aug 2023 17:47:57 -0700
Message-Id: <20230815004813.555115-5-vgupta@kernel.org>
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

This avoids potential "bleeding" when size == 0 as cache line would be
dirtied (and possibly fetched from other cores) and due to the same
reaons more optimal too.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/lib/memset-archs.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S
index d2e09fece5bc..d0a5cec4cdca 100644
--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -36,12 +36,13 @@
 #endif
 
 ENTRY_CFI(memset)
-	PREFETCHW_INSTR	r0, 0	; Prefetch the first write location
 	mov.f	0, r2
 ;;; if size is zero
 	jz.d	[blink]
 	mov	r3, r0		; don't clobber ret val
 
+	PREFETCHW_INSTR	r0, 0	; Prefetch the first write location
+
 ;;; if length < 8
 	brls.d.nt	r2, 8, .Lsmallchunk
 	mov.f	lp_count,r2
-- 
2.34.1

