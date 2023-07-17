Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BEC75691C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGQQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGQQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCA1B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7482E61172
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E34DC433CA;
        Mon, 17 Jul 2023 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689611347;
        bh=oLQSaca6C3+dC9X6PrVs62lkR/VnjdA0ABRf6CYLTn4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mF9WgaFHfh7/nkSXFaUSle/aJPwsbgCYu5sjEaKiau1FgvJi441GhLi7St8cF2Zv5
         aaKKLmSTuVLFyFwz7u43uPYV96r6oDxm/f1i/1MkrrgqJ0BZIVKtnhHk9JLdVCMUUd
         g9jjf+sv846mlCkevsR0xcpDPxGsgWfSZ1438VRAYaAcx1SYVbXd/9e3sGuw344kXi
         AQkOhEcZ2S90xAuftc4/FlcheOY56GVg5ViJ1i4ZmpTAKOB/hmRVRDI77/GfcXa1G4
         gORF6f9h+Qy4sMNrzcsAE/gzk9SONY5Gd+/os0hx+O1KJvX75JrBaO1P7Hb9AfhT/p
         Tk5UANY+Y9XVA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Mon, 17 Jul 2023 16:29:02 +0000
Subject: [PATCH 3/3] fs/9p: fix type mismatch in file cache mode helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=oLQSaca6C3+dC9X6PrVs62lkR/VnjdA0ABRf6CYLTn4=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktWxPIC0EaLAznACdWpUQZhpLof/8y5QRbyo1C
 QtxwvZGd9qJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLVsTwAKCRCI/9X7Sl//
 mJsQD/oC9v+6jOyzJWP6TF7YZ4ZbDp44VBwwjLdS+s5gxEipUVbBCq4gn76JX1RR1GLCFwsTOpX
 HLxAFpWM+XPKORHARacmgzm3S1n74LX6ORqYOX1lyYEkc5kCAUhKOIwi0WVmxdq4NQcEqC9mW/r
 SGpgBb9vK4ZB9Xh7WFwlXQf64AuVRqTSoRUP2wnv//5bTx3BDnX8k8iY5ouw6Q1HhmUImxmOjO5
 /shsp0gb385wt1CzlIz7FLS4OInE5cw4rTJsX/imwQCho4B/R48qrW4bWg57niVAjnH7hBIGoLg
 kvDjO1MPspB57+T/E+jT6OKLN7uBgPv1ruIaaco36A6cVCMOfwoOJwazOBO1h5d5n4FC4kR0Qiq
 tp29N6A8l58InIH7pN53rd2N3XR9Kxr2kaGtfHOKNltjqA17f5KlKlhK1AKeQYyGPlBq1VUjrIa
 71gv44P90Gnee5qmmUSlBS3Dicw4KQCWE53rBn0ed89ATnzma20+cXjlR9WRnA1UuyAesVgueL9
 VrcuQgOdLzYqGxImS/mEjGTn8Puxap6mbUIPCzpPP922XiLdMGbXNZ/0258Xvk+gc4Nv3GDsDmP
 sSS7k0l9gayH2basmCQMid1yTv7Fe3/S6P2retom9fo4bEK5FS5BA4flJn2O8iEB1VuwyLld3jt
 8We55fT5hyekujQ==
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

There were two flags which had incorrect type in the
paramaters of the file cache mode helper function.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 297c2c377e3dd..29281b7c38870 100644
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

