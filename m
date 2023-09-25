Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0457ADC63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjIYPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjIYPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:54:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92092
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:54:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D79BC433C7;
        Mon, 25 Sep 2023 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695657259;
        bh=B4lato5sKbIJfj/DcTxCJi6Fpi7KSgnK6AAG1dAv0WI=;
        h=From:To:Cc:Subject:Date:From;
        b=Xz+FlTT0VGq3tgbriqS2EDaNs11wwdg05SylJzWh/+MjuJrj6gv1A33uV0K9z5PZC
         uOISJiUJKkEfwop5py2fR6lDz+1iQQ6PHYEaklwFtAntZ98Sjo2CZkjVZQB6/mZ4W1
         7E+xM/4XJFyE5im3h2UkBLth88NECJC+iYzwrzAW1r5CdowA+gkpxrOIGwIrt8sjW2
         g7J6SLzreVvMH81sYwZlSKjZpAFTQR6r/s+P4suoajmsgKqxGuadxO7oXDBUklo+s+
         cPSE8QCwH/QgHLGt4KMavTHbP2MAqnGwY8I+Cq8haydsunntR0FqvgV3tQkU46n1TB
         WY+A+7V+baI3w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tree Davies <tdavies@darkphysics.net>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: fix structure alignment
Date:   Mon, 25 Sep 2023 17:54:03 +0200
Message-Id: <20230925155413.471287-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent cleanup changed the rtl8192e from using the custom misaligned
rtllib_hdr_3addr structure to the generic ieee80211_hdr_3addr definition
that enforces 16-bit structure alignment in memory.

This causes a gcc warning about conflicting alignment requirements:

drivers/staging/rtl8192e/rtllib.h:645:1: error: alignment 1 of 'struct rtllib_authentication' is less than 2 [-Werror=packed-not-aligned]
  645 | } __packed;
      | ^
rtllib.h:650:1: error: alignment 1 of 'struct rtllib_disauth' is less than 2 [-Werror=packed-not-aligned]
rtllib.h:655:1: error: alignment 1 of 'struct rtllib_disassoc' is less than 2 [-Werror=packed-not-aligned]
rtllib.h:661:1: error: alignment 1 of 'struct rtllib_probe_request' is less than 2 [-Werror=packed-not-aligned]
rtllib.h:672:1: error: alignment 1 of 'struct rtllib_probe_response' is less than 2 [-Werror=packed-not-aligned]
rtllib.h:683:1: error: alignment 1 of 'struct rtllib_assoc_request_frame' is less than 2 [-Werror=packed-not-aligned]
rtllib.h:691:1: error: alignment 1 of 'struct rtllib_assoc_response_frame' is less than 2 [-Werror=packed-not-aligned]

Change all of the structure definitions that include this one to also
use 16-bit alignment. This assumes that the objects are actually aligned
in memory, but that is normally guaranteed by the slab allocator already.

All members of the structure definitions are already 16-bit aligned,
so the layouts do not change. As an added benefit, 16-bit accesses are
generally faster than 8-bit accesses, so architectures without unaligned
load/store instructions can produce better code now by avoiding byte-wise
accesses.

Fixes: 71ddc43ed7c71 ("staging: rtl8192e: Replace struct rtllib_hdr_3addr in structs of rtllib.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8192e/rtllib.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5517b9df65bee..7d26910a0b162 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -642,23 +642,23 @@ struct rtllib_authentication {
 	__le16 status;
 	/*challenge*/
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_disauth {
 	struct ieee80211_hdr_3addr header;
 	__le16 reason;
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_disassoc {
 	struct ieee80211_hdr_3addr header;
 	__le16 reason;
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_probe_request {
 	struct ieee80211_hdr_3addr header;
 	/* SSID, supported rates */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_probe_response {
 	struct ieee80211_hdr_3addr header;
@@ -669,7 +669,7 @@ struct rtllib_probe_response {
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 /* Alias beacon for probe_response */
 #define rtllib_beacon rtllib_probe_response
@@ -680,7 +680,7 @@ struct rtllib_assoc_request_frame {
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
 	struct rtllib_info_element info_element[];
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_assoc_response_frame {
 	struct ieee80211_hdr_3addr header;
@@ -688,7 +688,7 @@ struct rtllib_assoc_response_frame {
 	__le16 status;
 	__le16 aid;
 	struct rtllib_info_element info_element[]; /* supported rates */
-} __packed;
+} __packed __aligned(2);
 
 struct rtllib_txb {
 	u8 nr_frags;
-- 
2.39.2

