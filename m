Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C283756E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGQUxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGQUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:53:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD29BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:53:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LVDvqk82e2ts4LVDvqgmhS; Mon, 17 Jul 2023 22:53:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689627221;
        bh=gH/CT643ZS5ZguiPFDy4NfnRiWDoPJy5TfU7apbBTY4=;
        h=From:To:Cc:Subject:Date;
        b=EUxW+eBqx0/fwJQ4mgi6TBoMfh2JIImC5lXvo4ECT562e2t/Pe25+tCgrwogyu7TW
         34f6skb/GVFv9oRX95oCPkM0o2XzJilSzDsFzjB1pxM5q5vqzomhi3fAB8d11h4DZZ
         pCrsK4Yfm2hSz5L8D6b8Jr7olrJgiBMFaG7u3OwMHbV6O6PJB8A20qLxtd1W3gb54U
         HZ2WLgmx7vG9PuCOHL8HjbZA+ROG2YNwNWJ3W3vHS9FSaWu12UXGVvMhRKND0vNznj
         swWYgfwcqIjMRk9ADNPg6mER/KqK0vCheGn94fEkkwiHqm/Bfi53yE+gW5QQarZhCa
         TvcXmXOrFSYaw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 22:53:41 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: hp-bioscfg: Fix some memory leaks in hp_populate_enumeration_elements_from_package()
Date:   Mon, 17 Jul 2023 22:53:37 +0200
Message-Id: <9770122e4e079dfa87d860ed86ba1a1237bcf944.1689627201.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the loop in the ENUM_POSSIBLE_VALUES case, we allocate some memory that
is never freed.

While at it, add some "str_value = NULL" to avoid some potential double
free.

Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ Speculative /!\

   This patch is based on analysis of the surrounding code and should be
   reviewed with care !

/!\ Speculative /!\
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index b1b241f0205a..dd173020c747 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -224,6 +224,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					sizeof(enum_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -275,6 +276,9 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					strscpy(enum_data->possible_values[pos_values],
 						str_value,
 						sizeof(enum_data->possible_values[pos_values]));
+
+				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 		default:
@@ -283,6 +287,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		}
 
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_enumeration_package:
-- 
2.34.1

