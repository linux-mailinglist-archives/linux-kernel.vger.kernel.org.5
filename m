Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688A7B9E96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjJEOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjJEOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6C826A51;
        Thu,  5 Oct 2023 05:37:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adb9fa7200so215884166b.0;
        Thu, 05 Oct 2023 05:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509432; x=1697114232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6QrB9RE51dC06x5LjgJq6wybwojSHDaqDVY2rSdCIs=;
        b=iGxfy14qA05uTpqb9YJkv7Vxr0ty/W16zgd+iVXaK7toGF8Yv3a07AOpEe/cYV01Sq
         uBkElF1Q/FIYD6wd6vW1R8Nz7OevBPokb8R6cK644Vtba1JjFtAzRAtsEah9c6mrH93B
         iTcS1w+sbWFtygL6oJjeRA/FqOPalXGnUEJi1G8aRlQQhSD3di07z0+YcpYKO8VfByrD
         VDP3irpOaOybuhXQrfnm4/teKgzeb/RlQtbAwkJJng+P9s9BLduUtILQsxScD9fqAAS/
         ZszPhf6e0z5JRpdoPq6WchI0138caR+XWvib6MvIfF+PsG7jC/p0eF/jqpy+9W3ALIQw
         w3/Q==
X-Gm-Message-State: AOJu0Ywu1Ts0/9VnVu0q2fl8xqlm+lGwngddYAxSkjjTghnKiwk8AvAo
        Vb8EOyo3k8GhHVNjfL3SBiQ=
X-Google-Smtp-Source: AGHT+IFeBpi+mOpyWz8jhMoXfirHjtAIoCHN0b4tObYTv8RAt8ztsIhfOElTM+r6sPQD4GiuGgh6Dw==
X-Received: by 2002:a17:907:3f9a:b0:9ae:6648:9b53 with SMTP id hr26-20020a1709073f9a00b009ae66489b53mr1175352ejc.23.1696509431770;
        Thu, 05 Oct 2023 05:37:11 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b009a13fdc139fsm1129726ejb.183.2023.10.05.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:37:11 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v2 2/3] netconsole: Attach cmdline target to dynamic target
Date:   Thu,  5 Oct 2023 05:36:35 -0700
Message-Id: <20231005123637.2685334-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005123637.2685334-1-leitao@debian.org>
References: <20231005123637.2685334-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the attachment of a dynamic target to the target created during
boot time. The boot-time targets are named as "cmdline\d", where "\d" is
a number starting at 0.

If the user creates a dynamic target named "cmdline0", it will attach to
the first target created at boot time (as defined in the
`netconsole=...` command line argument). `cmdline1` will attach to the
second target and so forth.

If there is no netconsole target created at boot time, then, the target
name could be reused.

Relevant design discussion:
https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/

Suggested-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7c46cf1c923e..4aa40e2e4c86 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -685,6 +685,23 @@ static const struct config_item_type netconsole_target_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static struct netconsole_target *find_cmdline_target(const char *name)
+{
+	struct netconsole_target *nt, *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_for_each_entry(nt, &target_list, list) {
+		if (!strcmp(nt->item.ci_name, name)) {
+			ret = nt;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	return ret;
+}
+
 /*
  * Group operations and type for netconsole_subsys.
  */
@@ -695,6 +712,17 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 	struct netconsole_target *nt;
 	unsigned long flags;
 
+	/* Checking if a target by this name was created at boot time.  If so,
+	 * attach a configfs entry to that target.  This enables dynamic
+	 * control.
+	 */
+	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_NAME,
+		     strlen(NETCONSOLE_PARAM_TARGET_NAME))) {
+		nt = find_cmdline_target(name);
+		if (nt)
+			return &nt->item;
+	}
+
 	nt = alloc_and_init();
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1

