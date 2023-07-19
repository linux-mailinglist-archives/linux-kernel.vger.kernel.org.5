Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28963759AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGSQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGSQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148ABB6;
        Wed, 19 Jul 2023 09:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBDE6178D;
        Wed, 19 Jul 2023 16:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB223C433C8;
        Wed, 19 Jul 2023 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783773;
        bh=exSvQfCJy5HOJ0e35lnsgXGxg66VQJVaJEEUsXz/SvI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tEvY4snmwkL34r4FGAGuqjLcHEgVdTgJL7BkqvldfJSzOA0wVDMT+5i0gW3De3Na5
         K2oUFM4Oqb8xENigBbUHzYaO+U1h3Qu9WNmeBlB6zxs9fR50bYv2ZUnx3nX8iFyBfl
         7snwPG7CxmUdQGJ+xE1TB/G8khUX1sBcmapwjAeHRDcsb+GcPVUDmtXW1HXmEgeTjI
         JxkPjE3ewejr0p2GkZi9UY30xBfbfN+p0GH5UD6A8uTa36diZgBgXg6A4ALqYa4+GR
         GoJU4hXCW0kebZVKQsPFzFzVTeGClmyYf2aengwtHfGfdBREXM6xPq0yjK6uWRttVy
         MgEQ30L9oV3Mg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 16:22:32 +0000
Subject: [PATCH v4 3/4] fs/9p: fix type mismatch in file cache mode helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-3-a3cd1cd32af2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=exSvQfCJy5HOJ0e35lnsgXGxg66VQJVaJEEUsXz/SvI=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3Y9X0qfbFlJ6sfM0lCKgu7/mb+WN7TKAZPg
 xXIlSHSqv6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2AAKCRCI/9X7Sl//
 mEXNEACjLvXN3fAnnDDhgVTEQKwe5zl9FzLhrDKt0Rs8wPEJppkcw5W8lTGL8Z8pnnuW6iOsvb6
 BsqipDh/ubGHfcTV/7vD4Pp4eOkgfKy8nRtaGo+RZoLbI+RayB+szhSwNap0Bh1DYjhn3OVChtz
 8gK0ffqrN//hFCI6hwdJ5Og2FIfpfWTytO+HG0gPtqqz8hdsiG1ath8JO9hfR3E9DScd4F/LziW
 UabyqZdlx+VQDwrYTEc7uSuTD2VoOW82mPIHLeDrL/aLuGnAns/kp2R7gPLv6+DMu2qeEcvsjxQ
 FgdX43EPhZ/K6mVHuQH8YkpANJIiyDs3mK4l24nvFMc63XUe3vBL/RN4Trhyzw0Zqqjs9Oml07H
 1Rt5eJcHiVLJWDTw2B9luZTcxGWQefU6bSr63GQcztF5YyH2IFaKont0zGQmor2OIQi694uDJTm
 Gq+jIfKhbqFL7WxlkJPycDt/z31pql1OkyUXnHfrhmNFP5IiMb2FY4f5y6ShO4xRRzl98ms1/vC
 udsil8mTAQcSoObpUg5PJfqIfskn/W7WehlqlPc0LD24bPG6grQkxr3jMIaP+mYnmKXGtzT0xSF
 nvvvBp8KIYprh2ZtuUiKFRaas6/TqFXNymBkEw3gv+sMBI/Bw6uyDgeuBR+sCFuXkGT0HjrgcKQ
 ez+Is1DC8PVMQow==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were two flags (s_flags and s_cache) which had incorrect signed
type in the parameters of the file cache mode helper function.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
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

