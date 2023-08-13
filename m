Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864577A8CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHMQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjHMQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586EC1735;
        Sun, 13 Aug 2023 09:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34FFD6363C;
        Sun, 13 Aug 2023 16:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1D9C433C8;
        Sun, 13 Aug 2023 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942595;
        bh=S6PLgcqVYG/09XUkFR2LEZR1UJ53rgcX1thU90AKZno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnnkOeRUZTWu2V/JIg6I7uBlVRpG8CuRVSCCtw1nQKW5j2bF+9ETLG2KaJKnlSBNE
         6dP1vRs18tUg1n+BlCiyJ+AEBfDapQq954hkxHo6hLRX2HgYOKldqn57tVqSWi7mEx
         CdrKnVwXq1qx7QbO+BWCAghlWwd/RwxzA8RyW9rtulORHDkNBVqW2AgDCnBHK0dLd9
         R2R0CUXXpu2idX/4GWXkudrp7qFRTMsdM1yMjoggYkD0AWh4bDlv10a8MGPkRJM/ly
         qx1WvIwwp+JTk/h5VHZL6H+hUylUo63z2+g9SEFrNIxxijfA8sBKuiNhUtOKtS+Li4
         IR+ZbxOKnskGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Ming <machel@vivo.com>, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, markpearson@lenovo.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 34/47] platform/x86: think-lmi: Use kfree_sensitive instead of kfree
Date:   Sun, 13 Aug 2023 11:59:29 -0400
Message-Id: <20230813160006.1073695-34-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Ming <machel@vivo.com>

[ Upstream commit 1da0893aed2e48e2bdf37c29b029f2e060d25927 ]

key might contain private part of the key, so better use
kfree_sensitive to free it.

Signed-off-by: Wang Ming <machel@vivo.com>
Link: https://lore.kernel.org/r/20230717101114.18966-1-machel@vivo.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3cbb92b6c5215..f6290221d139d 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -719,12 +719,12 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	/* Format: 'Password,Signature' */
 	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
 	if (!auth_str) {
-		kfree(passwd);
+		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
 	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
 	kfree(auth_str);
-	kfree(passwd);
+	kfree_sensitive(passwd);
 
 	return ret ?: count;
 }
-- 
2.40.1

