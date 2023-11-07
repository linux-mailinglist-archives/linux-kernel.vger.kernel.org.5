Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234977E3E59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbjKGMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKGMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:36:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6B4491;
        Tue,  7 Nov 2023 04:25:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE1C433C7;
        Tue,  7 Nov 2023 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359934;
        bh=Ac4qz2ssxrPK0fi2tPq4579QhMScQX00ZzqG9yAO/Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHm8Fe4cv2Kmi+Jrkb+RQkiy9z79d3vfjV6Uu6Y24WtEOLRilLxsNBOC007hAyGo1
         RO1ap3AoLJstmBWO3l/XgYJQAfMYLQT5n+VpwkC4uCRngtIVHxrUBjK/RnhrC4y1Wr
         3WNIS+hBTrwvgYihKQpt+E0JcTY8JUcRsOX7ZAx/u3GTAf/iqGHBh/UB7ZDrDplef7
         TvsHkipBXJXLzfuRVQpNCNYcDwbpST3hhVqwEkQy1CkjJ6RHdzm3+HEhPW+XwnL+Ci
         g9icT9gw4LcaMAdkVDYM9y9U6eWZzZA+AtAa7TwTpw6mJCo3QSKmL8kzLfKMPw7CPH
         Tg2LEA5tlOWxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>, Baoquan He <bhe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        ebiederm@xmission.com, kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 14/37] kernel: kexec: copy user-array safely
Date:   Tue,  7 Nov 2023 07:21:25 -0500
Message-ID: <20231107122407.3760584-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 569c8d82f95eb5993c84fb61a649a9c4ddd208b3 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-4-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f987766..f6067c1bb0893 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.42.0

