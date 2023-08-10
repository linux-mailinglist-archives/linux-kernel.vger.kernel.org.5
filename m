Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18626777424
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjHJJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHJJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663A73A97;
        Thu, 10 Aug 2023 02:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1E18654E3;
        Thu, 10 Aug 2023 09:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28388C433C8;
        Thu, 10 Aug 2023 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658960;
        bh=bqk9imXFMSipriC6qFwCKZM/oCxujv3PCz30bPPeLV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9TrUe889m+8zZGNJJXXbox5ZqAlw10yTQERN++9tsUWflMJEiszPSIbU+pGtt9Av
         nS8XsWk8SQ0S2dlYFVVHKOiAxqs8p9CjZA+Ue7jroOgJSYLc8feyjfnnRYg0igk35K
         Id7ZxdXkfrWZ9QuFDzBSgDqOX3hqZ/3ryBRY7Jtbfd4XVru/uqKv3+bDkmMBGEGOSy
         o4cmnK7STBtIGtudm1mVFSCvfPD0ePWs1nzaZ8GbZQtO3atHBq/q4FpZ8MJcuGpyez
         lvq5c8uF9e0o5mkRDJEvoJHhaFrGqz93lR8C2bY0PAnEoRMbNPrFO8suiT/eog0PYO
         6iER+9XHRLAEw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 18/36] misc: ti-st: make st_recv() conforming to tty_ldisc_ops::receive_buf()
Date:   Thu, 10 Aug 2023 11:14:52 +0200
Message-ID: <20230810091510.13006-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is change data type to u8 and count to unsigned int. And propagate
to both hooks (st_kim_recv() and kim_int_recv()).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 7 +++----
 drivers/misc/ti-st/st_kim.c  | 6 +++---
 include/linux/ti_wilink_st.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 4467c5b94ae8..c1a134bd8ba7 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -21,7 +21,7 @@
  * st_kim_recv during registration to receive fw download responses
  * st_int_recv after registration to receive proto stack responses
  */
-static void (*st_recv) (void *, const unsigned char *, long);
+static void (*st_recv)(void *disc_data, const u8 *ptr, size_t count);
 
 /********************************************************************/
 static void add_channel_to_table(struct st_data_s *st_gdata,
@@ -223,8 +223,7 @@ static inline void st_wakeup_ack(struct st_data_s *st_gdata,
  *	HCI-Events, ACL, SCO, 4 types of HCI-LL PM packets
  *	CH-8 packets from FM, CH-9 packets from GPS cores.
  */
-static void st_int_recv(void *disc_data,
-	const unsigned char *ptr, long count)
+static void st_int_recv(void *disc_data, const u8 *ptr, size_t count)
 {
 	struct st_proto_s *proto;
 	unsigned short payload_len = 0;
@@ -239,7 +238,7 @@ static void st_int_recv(void *disc_data,
 		return;
 	}
 
-	pr_debug("count %ld rx_state %ld"
+	pr_debug("count %zu rx_state %ld"
 		   "rx_count %ld", count, st_gdata->rx_state,
 		   st_gdata->rx_count);
 
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 5431a89924aa..fe682e0553b2 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -127,8 +127,8 @@ static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
  *	have been observed to come in bursts of different
  *	tty_receive and hence the logic
  */
-static void kim_int_recv(struct kim_data_s *kim_gdata,
-	const unsigned char *ptr, long count)
+static void kim_int_recv(struct kim_data_s *kim_gdata, const u8 *ptr,
+			 size_t count)
 {
 	int len = 0;
 	unsigned char *plen;
@@ -417,7 +417,7 @@ static long download_firmware(struct kim_data_s *kim_gdata)
  * 1. response to read local version
  * 2. during send/recv's of firmware download
  */
-void st_kim_recv(void *disc_data, const unsigned char *data, long count)
+void st_kim_recv(void *disc_data, const u8 *data, size_t count)
 {
 	struct st_data_s	*st_gdata = (struct st_data_s *)disc_data;
 	struct kim_data_s	*kim_gdata = st_gdata->kim_data;
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 44a7f9169ac6..10642d4844f0 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -271,7 +271,7 @@ long st_kim_stop(void *);
 
 void st_kim_complete(void *);
 void kim_st_list_protocols(struct st_data_s *, void *);
-void st_kim_recv(void *, const unsigned char *, long);
+void st_kim_recv(void *disc_data, const u8 *data, size_t count);
 
 
 /*
-- 
2.41.0

