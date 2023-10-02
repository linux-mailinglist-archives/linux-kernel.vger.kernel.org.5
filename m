Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EDD7B57B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjJBPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjJBPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:54 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70ECE;
        Mon,  2 Oct 2023 08:55:42 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so2279293066b.3;
        Mon, 02 Oct 2023 08:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262140; x=1696866940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVA8+4Ag1gceWiVP2I9j+CrDamJhnQG/Ib4pWtjPquA=;
        b=NC3X17Hm6TbXzEoKpGMKlllx3HIwjaxuQKC+K+dogwBAaai9lXPlwKBnmWsmhdraiV
         h8NYlt6mVUSur7fGhnrhr/JFVwnhZaWR7P9TArLlHJv0TZvCgGBAgsasvtAsOJTzZWES
         uCImysrwRnQTgQofMKrZ+y2lIYhGNEoO44EJPbL9wM+Nt0tDbemfKbxUIGYbxCQ2jnv7
         1LeMlbk9B+GxyRJiEOPdUstOAYTmAHWOyizpT0TAIFZ0NJV6x6ufXGzW1B4shLGeUiN7
         KsF40LUXGiPg09bnTQL0Q5U/idE13OSPf0mKGvwNNutrnvgbDNDFNTnprJq2vDli5Run
         wZXg==
X-Gm-Message-State: AOJu0Yw8sbpLrzRhN9oZfvYx8izhR9WNxvEhK+H/9ne2dVTQ6XTbT2po
        KAo1riAex6O0x4zYIGfVhZU=
X-Google-Smtp-Source: AGHT+IE+Zi8Fb98oyNB30KZKRnjdjfsN0mmOs28H0s1tQhD48OcMlFkU/4MM58tfTOCHacC5c6t+Bw==
X-Received: by 2002:a17:906:3019:b0:9b2:73b3:29a1 with SMTP id 25-20020a170906301900b009b273b329a1mr11631013ejz.23.1696262140597;
        Mon, 02 Oct 2023 08:55:40 -0700 (PDT)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id t20-20020a170906949400b0099bd5d28dc4sm17289237ejx.195.2023.10.02.08.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:55:40 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH 2/3] netconsole: Attach cmdline target to dynamic target
Date:   Mon,  2 Oct 2023 08:53:48 -0700
Message-Id: <20231002155349.2032826-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002155349.2032826-1-leitao@debian.org>
References: <20231002155349.2032826-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/netconsole.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b68456054a0c..6235f56dc652 100644
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
@@ -695,6 +712,13 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 	struct netconsole_target *nt;
 	unsigned long flags;
 
+	/* Checking if there is a target created populated at boot time */
+	if (!strncmp(name, DEFAULT_TARGET_NAME, strlen(DEFAULT_TARGET_NAME))) {
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

