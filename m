Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F190875864B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGRUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGRUu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD8BD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1769260C26
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48B2C433C8;
        Tue, 18 Jul 2023 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689713424;
        bh=jsjxHYDmiK3p+nOT5h02WYi1N3MzrRVdd2+TaPsAMcY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ov7F4c874drS+8VG1uVw0WB825cVnx7bjr0+UgPYnPVq0LZ+TAxjfn54bGtVweBYM
         u2YrIDq119CAI1Wx5fuuNT7DcN6DRo2wFYKJLgP0Qvuc6fsr2Sxq3z3ZhIgbtshbBe
         MIMnHC32Q+Bn48Fs5GAjCFKTMUo+Sj2akZKBnH3dtv+k4lvuh80vDd1PzqosEmCxn2
         TA3ScaWNq+Z9yLzicwUVqShZog2zbOWfAtqXvqURDHijmEieucXjc8bw54xRjE3vTU
         ZG47TGAi5JUTwSANwj1XH//mExHZD9dbguZ1Ex/6NoAm4aIk5RF+ax8T7V53iqP17C
         Ct8qkkGMZJhlQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Tue, 18 Jul 2023 20:50:17 +0000
Subject: [PATCH v2 3/4] fs/9p: fix type mismatch in file cache mode helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v2-3-147d6b93f699@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=jsjxHYDmiK3p+nOT5h02WYi1N3MzrRVdd2+TaPsAMcY=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktvsMuhuT2Ny13fKIEogkB4iNxaw3dU7ivO5zu
 pvtCeoh8q6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLb7DAAKCRCI/9X7Sl//
 mGwgD/oCnQ6KwfSKR/K/Jq68YlKph1hzVl4u1NQzSg9tvezTVWnVsYjTxyJU60aVg1GWJGzrl70
 tmG4LIN6ec9XRxP4dEDBP4FavHOiKnGnzZ2aXwOT2wtNMgkhuMfM8W2FGANt2jHg5b/JMYeYLkw
 Eh7Xyt3xK8VJxyICuPDCgpt9h6L5DTgJBkIFAiajmGKzbPHV0RhsFUuULMoc67qz0S3pjNL4EEu
 oSkg8VCadfi2FUJBGlOl3TUZ/4w5qqo3F+SqaOjWYsKu0wMeAkTNmRND0VQIirOQNWcCj3cDPET
 RltSMBJxX3Vw+IKE7YfMXJrY8CLG52YemdY//LKQ2x6KHAMXkuonOa9kRM8PFEshsXikCEqR0Y0
 yypSLlwINnEfrEiCkWUE4grAkovh4iwjoAvTdgijuQ5MrQP/JbIvX9bPzHIpbFTiKp4unhUcIzS
 Llbh2a1gOv21VKk5P9qNJKfgXn9mt9sPOjubgkYtnS4HEqf4INgyAKq9Oeu4hckapKrEIvnHWWh
 lxPYPqvzyegZycncMyIEGhsEJ0LOSX/1a2AtLo/47B2JNkR69UUMFbNr/9iJT10iK9Wt78Ami4C
 S32DO1ef3Xa0VN9cDT1jTosBoBHZIu2DULwUoz4r55S+7ylGHjAa21Qec3w72qetDf5AUf1896x
 FXwVyE4dpalAD1A==
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

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
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

