Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144607E19F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjKFGIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:08:33 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 45D38B6;
        Sun,  5 Nov 2023 22:08:30 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A1A70602AB5FF;
        Mon,  6 Nov 2023 14:08:27 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     sergeantsagara@protonmail.com, ping.cheng@wacom.com,
        jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] HID: wacom_sys: add error code check in wacom_feature_mapping
Date:   Mon,  6 Nov 2023 14:08:16 +0800
Message-Id: <20231106060815.104971-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid_report_raw_event() can return error code like '-ENOMEM' if
failed, so check 'ret' to make sure all things work fine.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - report the returned error (Rahul Rameshbabu) and __func__.

 drivers/hid/wacom_sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3f704b8072e8..899579c6db9d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -320,6 +320,9 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 			if (ret == n && features->type == HID_GENERIC) {
 				ret = hid_report_raw_event(hdev,
 					HID_FEATURE_REPORT, data, n, 0);
+				if (ret)
+					hid_warn(hdev, "%s: failed to report feature: %pe\n",
+						 __func__, ERR_PTR(ret));
 			} else if (ret == 2 && features->type != HID_GENERIC) {
 				features->touch_max = data[1];
 			} else {
@@ -381,6 +384,9 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 		if (ret == n) {
 			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
 						   data, n, 0);
+			if (ret)
+				hid_warn(hdev, "%s: failed to report feature: %pe\n",
+					 __func__, ERR_PTR(ret));
 		} else {
 			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
 				 __func__);
-- 
2.30.2

