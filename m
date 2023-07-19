Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89B759AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGSQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGSQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBD18D;
        Wed, 19 Jul 2023 09:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2DC61784;
        Wed, 19 Jul 2023 16:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FD3C433CB;
        Wed, 19 Jul 2023 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783772;
        bh=MhQlJrTsZHmha2KJIBaaG75cljAu9xtlF2pUFmjLQl0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ybo+jM3VJ9XHhauSCwdIsqdzWeqFQzs/qxba1+/HJ7MFo1coteRMEFtDOAJVonupb
         x5V9PtV/MBliY+teolKzToutb94UNyG0gFL+uw5WgWyv6xZ0rvKER6mZqbUaNQAKW6
         p3XcOg8yabNhSB+ci6Msr+j6Jjhnh10f5Z31/itKq3Xdhl+MnJvTn10G4OP/uoLmqW
         UmwS5f8GF3xEwCLE0e5qxLKHeCRGxP7uPke3mN4GBt+JsOozSU4k1SQ8SJlC5mUOCz
         OpHzfdrcrcOqD9Uf6F1e9iX43wj6y5XEnUylH3Ftmea7HdfzxnfhE5GR0ElQ/qrFrX
         ivJTQunK94Uww==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 16:22:31 +0000
Subject: [PATCH v4 2/4] fs/9p: fix typo in comparison logic for cache mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-2-a3cd1cd32af2@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=MhQlJrTsZHmha2KJIBaaG75cljAu9xtlF2pUFmjLQl0=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3YG2lCTw7UKGBhazSWgJkV4G2nM6ldEheUr
 xyRiO0BqDCJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2AAKCRCI/9X7Sl//
 mKzwEACfb3WBpP4t95Qby/jwVvjdngxQWel1ZL9JHoeb1r1FKF+FybflItJj4JCmqeAcOc9/Vh8
 xsP8vcee8Wjp2XQ5Z0NEUNX0Rp9taMXvUxKsVkjTrzmpjeRlM8+7dBnZzGWJ3PBGpMEpu0urFJv
 jIk7515+CoKprBoITqKEORaMcdOSitNRxUhGFZ82XC31fzbdH8ehG+KJ9lLqpNqUd9prTQX6YTr
 5lVAhp7ClbOkxH9aefpNBmpWeS0mfTp5FLE4ysrjUANkzqm9biqagH2i79dm/IyY0qEC29BUG9Q
 hXKuT0RUiNFCX4lB9RLie3dT4217w65D0FcQ18agAEm9pP4nmHoNAB5gtvvQzE6mBYM2rQuZ5WZ
 lC6z32z+OB5Cb+Qo93fG8lUMPv1egOGP5IqTgHkmqud/RHpLXWHqztbAxB0TnNsXfK81Jj3Hc/v
 4IRUtqhBgIoOEPxQQQC7AkJ5TrQUTRvmKJYC3J+RHjd91bd065inBCqd3b9rSaQN7KOcPzMgxcD
 uLasiATDItiixE4D0Q9Hrq8xCNWdEYbBATcji3CaKbwnT0eKDcOORD1FUOLOPlEdGs56nSC+nHM
 bVTwsjiIKX5tkQqXnPBchUlUcpLhOm3HKzoQ8s2flq2wWHkuMHedzeT6zH5qURqbQwqCOU0mbEP
 Pn82PdTDe8cLk3w==
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

There appears to be a typo in the comparison statement for the logic
which sets a file's cache mode based on mount flags.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0c51889a60b3..297c2c377e3d 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
 	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
+				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
 	}
 }

-- 
2.39.2

