Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E9759956
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGSPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjGSPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2566CC;
        Wed, 19 Jul 2023 08:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4269061753;
        Wed, 19 Jul 2023 15:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62AEC433CB;
        Wed, 19 Jul 2023 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779843;
        bh=37fxouyOhTLlN51p11xeLF2Xq6fH1PuX7PAunRa1+I4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fylAeVKuZFgjAnD1Rbim39U56NZuBKOVKurcYlSzFSYgdYzCcVRgdWKtmDP8BIb8X
         irT9O6qEfUYfN7IkSyHpADgOlsW3uzZV8eJW/FPIeYTInOw3WZX04YljcvBdoQMtwX
         LU9p+6lHxJpr+LRjd+o2jXa7BE2xZqgXOe/GQQ6EgswaUtdAY5/v3Sf1sawn1qT5Z7
         TIafQfzfn11/SDxcpGw72B9Y8GcCUkmOsyrlqZPCiZ5nx9TVytCWLDMgtsl+KqfIW+
         H0ZxOhNhsjhOwPJEbJRDp57+X4VCvE97Z8kEgfZqtf0QR+PUzfkjPfzhkARjREd6G2
         JQMm85MEBwRkA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 15:17:07 +0000
Subject: [PATCH v3 3/4] fs/9p: fix type mismatch in file cache mode helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=37fxouyOhTLlN51p11xeLF2Xq6fH1PuX7PAunRa1+I4=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5/NwNmg5qgKtbbcoMgW80FHdRrrxHqqWmhz
 2n1QoBKK2qJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fwAKCRCI/9X7Sl//
 mBamD/9iUHjCZ0miq5COrTtaDVZNcwtUvz0doOrSLg6zYoajcTbAiy4PdqPp8O4ZenpN7R/T29J
 sUGXZ8alc7Zr0M1ILxSqgok1y9mCY4Oa9Cm/SUv+rYxW29+id4od2wcEeDvui8Zmt9gsdr1DOcj
 j0dfZCuMqjQZX2sJSC8Ej66JcelxE7n19RES54JZIq66bOWL8e9goFce9R1kHP7XONEKipNL9Ia
 mrDsoXSC9fTK7Rr/FfLKDDuJaozbdM3mubfXOVDMvGY4LOElfs/B1Gq7VwFckXKIdjhAQkALify
 +UpIwqbK6jNppC21fXJLP97G4WIQzodpq/QTzBF+n590RKPvpiIMxrAIU5ReUhtrksDgVkw8ETp
 72YAhRXHJU+9m6B+Ld3TVI70Swj8uVp+0BSrjX0HRghg8JIedOD/lhMfnj3D/Vp7m4jUsTcTjxu
 GNknf78iSbzfOa0ZTpwpRm0Wg6XqbVT7FfoKddOp3KPARi2CYa6yoxWDinOtWJAO9wcF+MSsk6t
 DV6wcJrOqNUGe78rcSPyrqrqW18jazl/sloFJXmmGgz4iFnG8hob/a0AgYgJ/CnAenIG1k35W6v
 mNFDNcJbIVWHti3YwC+289Bfd0X7ayQ/AYSv/7lSRs9S26K8ZO8ARRcB1PvVAe4nw6ZAJV/+fly
 nIWB0prL0tfJ0Zw==
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

There were two flags (s_flags and s_cache) which had incorrect signed
type in the parameters of the file cache mode helper function.

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 297c2c377e3d..29281b7c3887 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
  * NOTE: these are set after open so only reflect 9p client not
  * underlying file system on server.
  */
-static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
-	int s_cache, unsigned int f_flags)
+static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
+	unsigned int s_cache, unsigned int f_flags)
 {
 	if (fid->qid.type != P9_QTFILE)
 		return;

-- 
2.39.2

