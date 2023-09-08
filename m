Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B7798E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbjIHSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbjIHSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:31:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D82125;
        Fri,  8 Sep 2023 11:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1288BC433BF;
        Fri,  8 Sep 2023 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197257;
        bh=0+YyDjwx3h8JedkPqH2eJ8aZFt0cO7/GGWjCLDYPi8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0m0CGZwYlBchrAUBxeNh60fw6f03iq+z/O+VtmRnsqDzdJYfNPir4vxpzV6802aG
         0QC2r8tARvt90ZOvev0UurwvrGogsdxltkrJs9T6fW2rZhKlwcIZ+8WhK1I6wrmu5A
         gjiCHK6cmVJ+1NQ4F7m7xilIznZuL1hBhM8Yn+b9uU3wStQGH3n/PfxvgvrpvLMiqX
         +XOqaT5D7dkJY306lOYMePxX1Wc2MJWTHVnW9Np0GUrDwa2wDwhndx2hQJPKc0IYQY
         rCmN7MEhejNT4q9sfFsma/ez4bytejHqS4uBb4aLSSNEMEI9OxWRWZ3iAHKA+6GCam
         RUVrFeXAGGmRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, zohar@linux.ibm.com
Subject: [PATCH AUTOSEL 5.4 04/10] crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()
Date:   Fri,  8 Sep 2023 14:20:38 -0400
Message-Id: <20230908182046.3460968-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182046.3460968-1-sashal@kernel.org>
References: <20230908182046.3460968-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 9e47a758b70167c9301d2b44d2569f86c7796f2d ]

During NVMeTCP Authentication a controller can trigger a kernel
oops by specifying the 8192 bit Diffie Hellman group and passing
a correctly sized, but zeroed Diffie Hellamn value.
mpi_cmp_ui() was detecting this if the second parameter was 0,
but 1 is passed from dh_is_pubkey_valid(). This causes the null
pointer u->d to be dereferenced towards the end of mpi_cmp_ui()

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/mpi/mpi-cmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index d25e9e96c310f..ceaebe181cd70 100644
--- a/lib/mpi/mpi-cmp.c
+++ b/lib/mpi/mpi-cmp.c
@@ -25,8 +25,12 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 	mpi_limb_t limb = v;
 
 	mpi_normalize(u);
-	if (!u->nlimbs && !limb)
-		return 0;
+	if (u->nlimbs == 0) {
+		if (v == 0)
+			return 0;
+		else
+			return -1;
+	}
 	if (u->sign)
 		return -1;
 	if (u->nlimbs > 1)
-- 
2.40.1

