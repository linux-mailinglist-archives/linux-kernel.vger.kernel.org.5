Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA96A7E3D94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjKGM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjKGM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617528FC4;
        Tue,  7 Nov 2023 04:20:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC07C433C8;
        Tue,  7 Nov 2023 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359606;
        bh=p0mex8bBv1TTORPMIHzWnMsEXyAsprynyz1dfSu86+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9n2ZLGTQF1UGoU8ZS7QCcqQITJvlXwtPIyPBNnY7y7WG2KrDA7sQAcIniwHRyYVJ
         FHMU9crYMFcjlhjzqivQ3NVPgPl1H68gCMGYG51x95l8ss+I0l+s1m8ELI1IMCBUgP
         DNEtKrZ11E4jYJDR9ujEcP5e9A2ItQ4xyd1vG+NSXjfk+IAoeOuv+vEZgbPXLZWWmc
         9lYmfu9Ie4h+ntG4QXPr5kJKJUd/QF2brfoCyo0AlbpzJe8KQZ7A9P5ggo3ikTRCMN
         jt01X5ffxBt8Z+CrTONCPvOVn4VC0OqsPZPavO0lnr2tZeLZDkhthmNJvMxf/Yrk9k
         7osrZMaF6Kkzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>, Baoquan He <bhe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        ebiederm@xmission.com, kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/40] kernel: kexec: copy user-array safely
Date:   Tue,  7 Nov 2023 07:16:17 -0500
Message-ID: <20231107121837.3759358-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 107f355eac101..8f35a5a42af85 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.42.0

