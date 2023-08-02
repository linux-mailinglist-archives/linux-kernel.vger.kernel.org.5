Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4176C490
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjHBFFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHBFF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134A1FCF;
        Tue,  1 Aug 2023 22:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24F3617E2;
        Wed,  2 Aug 2023 05:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14365C433CA;
        Wed,  2 Aug 2023 05:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690952726;
        bh=mqqkGVbU/w5XVGL8wNFiKBrpnoFsZ0U7xfNm17f7El4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVODpFlGBTgJf/7xxXR6C30T6BZmJoEN3+kRYa79kTII0nnf6ub3clATPGufXTnTE
         P1eFFL1msnaqiFvcfvjhfbIWovhU1tqPpSdnflkPghhkn2lh+hZ5ZVoaHo2VaQypDj
         xV+96UEjZDU4q2/giYSW3dfh9wWNayYZcKuYJ63+9jB0uKPZfoy3MyJkKN7gxkmCO0
         55jVCANF0xJbgIXgoULvPYhOrsgUFYs10dSKWJ46Pm6V3nVYy/aB/0YZ8yNl8Isl/v
         AEa+nwN887eWcZeTNlqhP7f9DUeSP+L1HcCFO/w3mQm7W43LY4naJJaRTzU9eZdGCu
         sWK96H0/eRzpQ==
Date:   Tue, 1 Aug 2023 23:06:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/4][next] i40e: Replace one-element array with flex-array
 member in struct i40e_section_table
Message-ID: <ddc1cde5fe6cb6a0865ae96d0d064298e343720d.1690938732.git.gustavoars@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690938732.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_section_table with flexible-array
member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index f7a984304b65..010261a10f56 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1492,7 +1492,7 @@ struct i40e_profile_segment {
 
 struct i40e_section_table {
 	u32 section_count;
-	u32 section_offset[1];
+	u32 section_offset[];
 };
 
 struct i40e_profile_section_header {
-- 
2.34.1

