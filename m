Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B07FB7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbjK1KdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjK1Kcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:32:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361802722
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:28:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502D6C433C7;
        Tue, 28 Nov 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701167300;
        bh=nnqZ06ksK0pk3r0lDcdYcgWXjjX1wHxDRcwFEc8XS0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=rXUxKllRuBxV9GetXRXTafM9LWGk5dnCV9/zUrU6M673IhyjL0FNCdblspQNwCumW
         cpaW4+ofvJr1iFT4oBGnqq8XHTsxmagiB7s112d0l9bYGAHpiXgpliRdhiq7QuA1O/
         dSlazoAyeO0+9w+lyJYEzV5SZ3Rimcd/rvjJsOJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] driver core: make device_is_dependent() static
Date:   Tue, 28 Nov 2023 10:28:15 +0000
Message-ID: <2023112815-faculty-thud-add8@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Lines:  40
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=nnqZ06ksK0pk3r0lDcdYcgWXjjX1wHxDRcwFEc8XS0Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmpB/bLBQs3V5yIlQ+42nn61s0pxodteqLW35WU7toXH vGCZ1VsRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzEXphhwTGF33HxL68oJxtf U2Z+vLTvDut+GYZ5BoaTNhatcc76K/lZUbq5JDbGT+kAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

The function device_is_dependent() is only called by the driver core
internally and should not, at this time, be called by anyone else
outside of it, so mark it as static so as not to give driver authors the
wrong idea.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 2 +-
 include/linux/device.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dafdb9970901..6dcc26eec096 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -298,7 +298,7 @@ static inline bool device_link_flag_is_sync_state_only(u32 flags)
  * Check if @target depends on @dev or any device dependent on it (its child or
  * its consumer etc).  Return 1 if that is the case or 0 otherwise.
  */
-int device_is_dependent(struct device *dev, void *target)
+static int device_is_dependent(struct device *dev, void *target)
 {
 	struct device_link *link;
 	int ret;
diff --git a/include/linux/device.h b/include/linux/device.h
index c11d60cabaab..6a4ee40af3df 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1071,7 +1071,6 @@ int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
 int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
-int device_is_dependent(struct device *dev, void *target);
 
 static inline bool device_supports_offline(struct device *dev)
 {
-- 
2.43.0

