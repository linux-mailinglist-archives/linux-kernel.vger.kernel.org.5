Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89B17F4537
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjKVL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjKVL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:56:23 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCACD67
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yhCcK0wRZ/D1OEdibIwHIFgo6z7azJAhavEvkkBIAX8=; b=Ub25VtVYY2/ZmqxVJ3EemcELNr
        yWZmXZIMc0mkevEphpYIHS1bV6IOAPbAPw40MSNI5WaovJ9lcA5y9rX3LOo/YVbisecrrUANRvfuA
        HOU4x2caPyL4hbrGuOxSqxZs9R9u6fxTTLYZHCYeNFQxiAm6ChFeQDrom4Kp5k4CtmtuK8JURbkne
        zQuRy+sZptW8RhECUv5Gdml0hF+ko7prQjlt690IZOnhsjZz+XhU19f+xvj7zfht6hsJ0rNjWsMDD
        iT+J52SW0/trn1EoaeZSbpJu6X67UmDxoFcmYlBIWg28+SIo+863gatbV3eUIOVLF9SnGj1vGy+L4
        g4YkPKuA==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r5lq0-003nX6-8U; Wed, 22 Nov 2023 11:56:13 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r5lq0-00000001CJ4-36MO;
        Wed, 22 Nov 2023 11:56:12 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     apparmor@lists.ubuntu.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] apparmor: make stack_msg static
Date:   Wed, 22 Nov 2023 11:56:11 +0000
Message-Id: <20231122115611.285625-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack_msg is not exported out of security/apparmor/domain.c so
make it static to avoid the following sparse warning:

security/apparmor/domain.c:1314:12: warning: symbol 'stack_msg' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 89fbeab4b33b..571158ec6188 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1311,7 +1311,7 @@ static int change_profile_perms_wrapper(const char *op, const char *name,
 	return error;
 }
 
-const char *stack_msg = "change_profile unprivileged unconfined converted to stacking";
+static const char *stack_msg = "change_profile unprivileged unconfined converted to stacking";
 
 /**
  * aa_change_profile - perform a one-way profile transition
-- 
2.37.2.352.g3c44437643

