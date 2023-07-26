Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D55763E42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGZSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGZSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:17:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724BFE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:17:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1ef7a6abacso44601276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690395466; x=1691000266;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hpPFf3+4VDGkjUYreTZKwGSOm+oraygLQyLjZ9weYQ=;
        b=hjn8mdrtNt9Ay3MT8vju6yt1vWWaegDo8jLTy5DfycKo2rzUVA/XHPkvSjJFTg6z/9
         ZO/2sJVzjGD4YwuFUuL3uUYLNuY9h3lzSYcAcemBYK9pmFUsMo3feU1lhphgzA6buHTf
         /s/30xXM6avFdrT4XdzovhgQUc7UahQHgtETcqIIdTBNvAeHHjh2pXsPBmfO68uSqoDq
         HYyh9ejstmtWTcxPccAyM2NyC/kNm8WrPf5pel+MpbgYQjv71M0+YuzlmwT/hJv1bvpS
         YdsAbPhUysp7Bs1c2M29rTcvR22VVWQtSiw/rvDRU53Zj980a1n0qBGDtvc8z3UBr+kV
         Xokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690395466; x=1691000266;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hpPFf3+4VDGkjUYreTZKwGSOm+oraygLQyLjZ9weYQ=;
        b=bQgrHFetbWAaUcW00x25Acd+KSSgSAZpvtAggqFu+DBmSUW+dC7ipcYcp0tbH5SedQ
         zivcnP2mInV9Zpfu5EfnLNiykKVnrXKYk9Zb+xzqxuxCfvWS5aqnxBzqcGyQObC/96kn
         vViv0jmK5J9OUklJB1qzP9ml4o81yaa/9HsUDcTtVChkdg0B35JUE//CEc5e3JfyZQve
         qRRRMyGuydvEEFja8UCghUqef0vVa6+0y8Ilvv0cQ1fJXeeYSRD6+/A0z6+7zmxyYm8Q
         ngW3kLJkeE64xRHvcpXL7L9INSBEbmhWbiD3eMslF+YLyxyuO+U8koBjNErbEyOl+uGU
         vjEg==
X-Gm-Message-State: ABy/qLahuj6by//3IabRSn7C7jc+3OUpZ22aRUlc7mxB3tyI9NtXBEIN
        +GOdqOJpVwoQepWJAP1+/L23QHR5fuMsfY8=
X-Google-Smtp-Source: APBJJlHbz0sUA7ksJ0wtqMgCDZ3UsGIdiM6y/iN9eyg5I8CgKaXTzEA5PrDCe21WfEENMYVlo27ltf1yGRlemxo=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a25:3212:0:b0:cef:5453:b6da with SMTP id
 y18-20020a253212000000b00cef5453b6damr16367yby.7.1690395465748; Wed, 26 Jul
 2023 11:17:45 -0700 (PDT)
Date:   Wed, 26 Jul 2023 18:17:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726181738.1.Ic6b8e25120b2aec95e3d0f4ac92c2a35fc7a40e8@changeid>
Subject: [PATCH] platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
From:   Rob Barnes <robbarnes@google.com>
To:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org
Cc:     Rob Barnes <robbarnes@google.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform a filesystem sync when an EC panic is reported. The
sync is performed twice in case some inodes or pages are
temporarily locked. Testing showed syncing twice significantly
improved reliability.

hw_protection_shutdown is replaced for a couple reasons. It is
unnecessary because the EC will force reset either way.
hw_protection_shutdown does not reliably sync filesystem
before shutting down.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

 drivers/platform/chrome/cros_ec_lpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e47..44b7637e745c2 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,8 +327,10 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
-		/* Begin orderly shutdown. Force shutdown after 1 second. */
-		hw_protection_shutdown("CrOS EC Panic", 1000);
+		/* Sync filesystem before EC resets */
+		ksys_sync_helper();
+		/* Sync again just in case some inodes were temporarily locked */
+		ksys_sync_helper();
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
-- 
2.41.0.487.g6d72f3e995-goog

