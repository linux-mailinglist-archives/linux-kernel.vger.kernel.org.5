Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C709076C48D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjHBFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjHBFFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4E273A;
        Tue,  1 Aug 2023 22:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21AA617C2;
        Wed,  2 Aug 2023 05:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A01C433C8;
        Wed,  2 Aug 2023 05:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690952695;
        bh=20F4xPeEvNj9IuAftI9KVAMz4n8aQOzO8rp3P7fmGNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9z225Vuo0O0cdGOCNgMKn+dvOU5eE4KM84og9IwU8gxi8fE1GdcLi226AenlSZDC
         vyN968CCLHAicKjG2npw9QyTqf5V/7QZu14QhJGEr4DkIVbWKR7qYIecWtVJzw1T7W
         EnZjm9vb2bb4d/bdiRASxZ05afIqPnbs8yXhC0nYM0Bqua4+iLDZ9cA8LvkqcX7Vsn
         nvgxRUpo8d1lo4C+hmsSlHKapcKTwO2CsB0UjWlgs+UD3Vz5T/i3qPzZGITD2F2V4M
         J9k1qrzUxWHpKqpbPVEyzMjyozTZzMyYntlUSlqJqOkJYXnhkJgBP5a4azkS2YzVeZ
         YeliueNUPZC5Q==
Date:   Tue, 1 Aug 2023 23:05:59 -0600
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
Subject: [PATCH 2/4][next] i40e: Replace one-element array with flex-array
 member in struct i40e_profile_segment
Message-ID: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690938732.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_profile_segment with flexible-array
member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index c3d5fe12059a..f7a984304b65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1487,7 +1487,7 @@ struct i40e_profile_segment {
 	struct i40e_ddp_version version;
 	char name[I40E_DDP_NAME_SIZE];
 	u32 device_table_count;
-	struct i40e_device_id_entry device_table[1];
+	struct i40e_device_id_entry device_table[];
 };
 
 struct i40e_section_table {
-- 
2.34.1

