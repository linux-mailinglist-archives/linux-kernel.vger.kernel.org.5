Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C593768F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGaIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGaIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409E1A6;
        Mon, 31 Jul 2023 01:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6170B60F33;
        Mon, 31 Jul 2023 08:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C2C433C9;
        Mon, 31 Jul 2023 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790586;
        bh=+2+5Tnk3+q3dIP9/bYUXB3vDyW94Doym0JZK1jfkQpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkoKyimKveikThTww6CG4ac9bXEwuyUSo1neOBMVcQrK84SM2A80Qhb7TEr9ptBhX
         CWHxlZWvIp7ntSAIW1ifiJBHuY94tsuBJ/erROBMHJd1f8le+MAAh/raO9wBH1zmai
         RM2BDg0tDqzaFQtKpW4YrlCBtgCH3cmtygr8nb0uuISuKevTLvGELTzZSKh+VHXGJb
         cNHnXHIKHwJock1jDKepc5AbC+TIqW6gACjRUBwyTWs7IZMZdzkUN9wQee0a9dIdzs
         gHZVixrhMnnt3YoJX8wXFrMYG/cEAillAeHkFMjbIibhOTNJbrx9BIYGWJTmMO9qfP
         nEAYEA8ZmalTg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/10] misc: ti-st: don't check for tty data == NULL
Date:   Mon, 31 Jul 2023 10:02:44 +0200
Message-ID: <20230731080244.2698-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty data passed to tty_ldisc_ops::receive_buf() are never NULL. Remove
this check.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 3 +--
 drivers/misc/ti-st/st_kim.c  | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index e2add50b191c..3b2145722bd7 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -234,8 +234,7 @@ static void st_int_recv(void *disc_data,
 	struct st_data_s *st_gdata = (struct st_data_s *)disc_data;
 	unsigned long flags;
 
-	/* tty_receive sent null ? */
-	if (unlikely(ptr == NULL) || (st_gdata == NULL)) {
+	if (st_gdata == NULL) {
 		pr_err(" received null from TTY ");
 		return;
 	}
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 8c801897ffa2..5431a89924aa 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -135,11 +135,6 @@ static void kim_int_recv(struct kim_data_s *kim_gdata,
 
 	pr_debug("%s", __func__);
 	/* Decode received bytes here */
-	if (unlikely(ptr == NULL)) {
-		pr_err(" received null from TTY ");
-		return;
-	}
-
 	while (count) {
 		if (kim_gdata->rx_count) {
 			len = min_t(unsigned int, kim_gdata->rx_count, count);
-- 
2.41.0

