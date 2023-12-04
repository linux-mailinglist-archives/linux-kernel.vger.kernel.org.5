Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB33802C65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjLDHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjLDHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73167F3;
        Sun,  3 Dec 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676351;
        bh=IyP3fTXp1SAs7UkxiJUA9xlgTpZMUTTPQdr1Z8WPbb0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SQ4c4OJgJJCnisETb9hXUF5YYUf7C0UKd6c5Mww/aO3s77s0vnJ0BYmhq9jI56SXo
         ZOeCfh0d6Oci9O5gxeD87hctfl1w06lqiP3cEdVC5pjMtWexivDvWbYfte4WFes+8e
         nV0fUg21Ob0hYeGT65jveRMunFejdMDZjaDXK1Ak=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:16 +0100
Subject: [PATCH v2 03/18] sysctl: drop sysctl_is_perm_empty_ctl_table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-3-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1435;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IyP3fTXp1SAs7UkxiJUA9xlgTpZMUTTPQdr1Z8WPbb0=;
 b=+ngBpUV2SiwicZA4ds9XMOzk5Pbxi+vGaZjien+LXgMroK7KKieP5OaWIcOCF+WqNuE4vgwZP
 xT40W0mgomqCFiuD3TvBSNW81r50LHid1h8Ji7pYWOHqATHnrdOYQdq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used only once and that caller would be simpler with
sysctl_is_perm_empty_ctl_header().
So use this sibling function.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8064ea76f80b..689a30196d0c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -48,10 +48,8 @@ struct ctl_table_header *register_sysctl_mount_point(const char *path)
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
-#define sysctl_is_perm_empty_ctl_table(tptr)		\
-	(tptr[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_is_perm_empty_ctl_header(hptr)		\
-	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
+	(hptr->ctl_table[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_set_perm_empty_ctl_header(hptr)		\
 	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
 #define sysctl_clear_perm_empty_ctl_header(hptr)	\
@@ -233,7 +231,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
+	if (sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);

-- 
2.43.0

