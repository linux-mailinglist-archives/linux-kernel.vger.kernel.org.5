Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D9768F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGaIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGaIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB61724;
        Mon, 31 Jul 2023 01:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E4160F77;
        Mon, 31 Jul 2023 08:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3261DC433C9;
        Mon, 31 Jul 2023 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790583;
        bh=6sCzu84ZbNFeuecmBcFu3cCZGqCgnMZYTlY4wKquDdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqIK16KsZ0ZT6eMsToQp0hx9VJoCyerLkUrrq/zljD3OZLcpyVXHWxxKBfkVHHuz1
         gv/u+bm+Krjnb+eCyXAHaTpu0ukPWjDM+jissvtq3y4bgIzRbcLBadshpgfNaZDCxc
         UB3CLZVCMeQ4A/cxnkgxaEgOizu/uyUGwN5pCtcwxczcyYbwhrl3UsAr3tEsMI0Kyf
         3aGdzyLzyPbMy3eJpW3F7vsJjMefg62ukSiF2I5/a2/zCxV1Vy4vLqCw1EwogcO2Rc
         GgyZtf0ZCutLbe4Lhnh669GJ54MOasDH2gpdyDNXeztYxOQq5ejehL5CRmUz68WNsV
         CrvDFIDjW+Hxg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/10] misc: ti-st: remove forward declarations and make st_int_recv() static
Date:   Mon, 31 Jul 2023 10:02:42 +0200
Message-ID: <20230731080244.2698-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_kim_recv() is already declared in linux/ti_wilink_st.h. Given that is
already included in st_core.c, drop the re-declaration from there.

st_int_recv() is used only in st_core.c and the forward declaration is
not needed. So drop the declaration and make the function static.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 01d2257deea4..389901276ce3 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -16,8 +16,6 @@
 
 #include <linux/ti_wilink_st.h>
 
-extern void st_kim_recv(void *, const unsigned char *, long);
-void st_int_recv(void *, const unsigned char *, long);
 /*
  * function pointer pointing to either,
  * st_kim_recv during registration to receive fw download responses
@@ -225,7 +223,7 @@ static inline void st_wakeup_ack(struct st_data_s *st_gdata,
  *	HCI-Events, ACL, SCO, 4 types of HCI-LL PM packets
  *	CH-8 packets from FM, CH-9 packets from GPS cores.
  */
-void st_int_recv(void *disc_data,
+static void st_int_recv(void *disc_data,
 	const unsigned char *data, long count)
 {
 	char *ptr;
-- 
2.41.0

