Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D27FAC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjK0VJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjK0VJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:09:56 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329D1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:10:02 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-285899772e4so4835558a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701119402; x=1701724202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+yJv8WNVxeThvq7VuGjifqnPyOkZQynfe++nihOK2k=;
        b=u+ICXVq2nfWmteOjrHZGwqAJvJCZNLmPvru78yjLnqkQkJne0WjziE0bkcC3n5Nmy/
         F5sUY6bSWBK28XGMN7KMdPG5B/XS5hI/qZLxovKQjKPqpPWl/Jf78BpzIyHS5N1KxBkB
         qmnZmeYrOEyf57IANNew6BVdBue+YxNGnAZnTykPHoJY3xa25F18ceWRawzKIAirpZGo
         HHi3qaYWe3p9EsjhkY5liU7W2DyN4oRnq8rE7xaF0elutQbVZpwnid3+WEBT5fboZwvB
         MXRurLUp7zCXmo69nN1jPY2jY8+FPgGDDHHmYqBr5ZNDKTaUUBtsOnyfOpScRtCozVx/
         Pphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119402; x=1701724202;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+yJv8WNVxeThvq7VuGjifqnPyOkZQynfe++nihOK2k=;
        b=BgT2+kh0Lxks1SwlJvPSLn9TACTlJxgmAcbwyxdSydYdHbkMasdF7V6gEad1MK4hjy
         09ZGi4xMEFWrLvE7+QSC9aSFTQIuFluyhb9x9FsOrOsQ4KAvARYF/Ogr6QBA9vfQJ5vP
         iVVN3XZp/JemDoA0Dttd7Y6o5dDbZGa64nyfv7ikToAhpxwMByaVOVPLMPrM5wiXsnJu
         EIH1M9nPms57d41VO5XNwG1PJzatRhqK/hJinLNVST1HxCA5yUt0288CIEUmaxEOtC4/
         hf4QW+yHaKbl4AwA3QmM6NvrgBHDl4s57tyZP8K68/1rO+f26x/uJ5ElAGE9BElP5HFO
         +g0g==
X-Gm-Message-State: AOJu0YwOd0NLihW0R9+EhjZHl1SupNPLWvWk+hyqjuVwVl3zBZUZN2Bt
        5TB2g4riGPnSzHGxkQQaXtItHPjXjpk1mmE=
X-Google-Smtp-Source: AGHT+IG4T87l6Jc1umPGTjJlvGyrlAAmvN/HToKfT0rHEPT+9djMhR2lev2oAFVL5FFYTChdXLfYbTFQvqmYZTk=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:90a:6f61:b0:27d:2233:d646 with SMTP
 id d88-20020a17090a6f6100b0027d2233d646mr2655299pjk.2.1701119402043; Mon, 27
 Nov 2023 13:10:02 -0800 (PST)
Date:   Mon, 27 Nov 2023 21:09:52 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=rdbabiera@google.com;
 h=from:subject; bh=HBsms+m+5r11Rra0u8wAjL7hztHH/IWB33DELSmjFkI=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmprPO3LohTqXTV2CvjsXlZi8FrRfW95hOaRBpThCbkP
 mK+onm8o5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgInoXGRk6JqYYL36ltnajTaC
 61UfLdVomP/KWCPk9afrHLsqD05vC2H4H8U45Wvr9jdKDT68RW5qDz0D5dKOHqv9EC+Q/Cf0/rU FDAA=
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127210951.730114-2-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: class: fix typec_altmode_put_partner to put plugs
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When typec_altmode_put_partner is called by a plug altmode upon release,
the port altmode the plug belongs to will not remove its reference to the
plug. The check to see if the altmode being released evaluates against the
released altmode's partner instead of the calling altmode itself, so change
adev in typec_altmode_put_partner to properly refer to the altmode being
released.

typec_altmode_set_partner is not run for port altmodes, so also add a check
in typec_altmode_release to prevent typec_altmode_put_partner() calls on
port altmode release.

---
Changes since v1:
* Changed commit message for clarity
* Added check to typec_altmode_release to only call put_partner if altmode
belongs to port partner or plug
---

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/class.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2e0451bd336e..16a670828dde 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -497,7 +497,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.rc1.413.gea7ed67945-goog

