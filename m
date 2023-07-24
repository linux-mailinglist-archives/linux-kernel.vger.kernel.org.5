Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC275F3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGXKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjGXKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:54:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BEE6;
        Mon, 24 Jul 2023 03:54:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31751d7d96eso978073f8f.1;
        Mon, 24 Jul 2023 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196069; x=1690800869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuukWSSIlqBsc+jjkqa9IHelgU4HEBkAlLZYUDelO8M=;
        b=qKBwUn9uzu/b+NKMwT8JHRsWh7mw0jMgRMxpcirBzwnwd180sqhjHJ8Kw4W84xy7MK
         1JbJGud4GyC49w7bT7EZ1DOf2BbdEqAyuAP+XjaYwo0obaQQpScUq5eWKnf+QH5lkWdS
         Pjf/l+l6N8uYqik3JqmZ2lzf9ZTZQIMPXQPmKLI1T3D01NIC4mbHEjFlIYQK6Bi6bouy
         1rQJHm62iBoSLuPIAgLRa5Q9ItREg5lBZhNXF2znv6kSYYCTditN9Lfz45K7BgrSf5EG
         Muco895fHevbWPg7Nb9jM9JvTbM75QjbKosW6lkQAhS65Hmj1YDoQzKtUOgN7gqJk/nD
         12gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196069; x=1690800869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuukWSSIlqBsc+jjkqa9IHelgU4HEBkAlLZYUDelO8M=;
        b=FhVPQMlH3tqfKKLJVgeBoBqEjY9T1HRnagHEKUz8Q4Mojcc/iGWifAWUhMQHAE3MtR
         GuAAebxWH276ZJCF5Q/qzXV+MGK9hLZQ/eFgDG0QyzaM58MWE5/ycyTKU/lXwGHNIFGQ
         si/dyGyL8nwNPbWM1e/HsZXkB4rNwA7nV6u23x9n+OPFwZ3i4g56ByxY9oOEmJGX/wpl
         CGgQn322QasrzNdyf7VKf0fDkeZbKfVStbl7GLaa0rI3bmJS4CxLqPh2YTUGYKbQkVP+
         Pj+bB3Sln71QgLLnIUdy9wZn+LC0BJ1AFZBpfQbaKXHOAygvhOIKDkFOhta462YYWrLM
         Hy3g==
X-Gm-Message-State: ABy/qLZwbLJG61FhVxmqeExJVnUlSDWinbazNQctJlntL0auAv1RwfB/
        9PzgQ9mqDG3tlNsDnpHkFgM=
X-Google-Smtp-Source: APBJJlFpKYZ0rfl6BcoKmne1Hm7Zln371bZfCqmtU+360RsDDJSJgeO+gcrcAQcXSBlI6XVqOIx9/w==
X-Received: by 2002:a5d:638c:0:b0:314:10d8:b483 with SMTP id p12-20020a5d638c000000b0031410d8b483mr7199581wru.64.1690196069066;
        Mon, 24 Jul 2023 03:54:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm12529631wrr.109.2023.07.24.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:54:28 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [net PATCH 2/4] net: dsa: qca8k: fix search_and_insert wrong handling of new rule
Date:   Mon, 24 Jul 2023 05:25:29 +0200
Message-Id: <20230724032531.15998-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724032531.15998-1-ansuelsmth@gmail.com>
References: <20230724032531.15998-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On inserting a mdb entry, fdb_search_and_insert is used to add a port to
the qca8k target entry in the FDB db.

A FDB entry can't be modified so it needs to be removed and insert again
with the new values.

To detect if an entry already exist, the SEARCH operation is used and we
check the aging of the entry. If the entry is not 0, the entry exist and
we proceed to delete it.

Current code have 2 main problem:
- The condition to check if the FDB entry exist is wrong and should be
  the opposite.
- When a FDB entry doesn't exist, aging was never actually set to the
  STATIC value resulting in allocating an invalid entry.

Fix both problem by adding aging support to the function, calling the
function with STATIC as aging by default and finally by correct the
condition to check if the entry actually exist.

Fixes: ba8f870dfa63 ("net: dsa: qca8k: add support for mdb_add/del")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/dsa/qca/qca8k-common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 8c2dc0e48ff4..4909603d07c8 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -244,7 +244,7 @@ void qca8k_fdb_flush(struct qca8k_priv *priv)
 }
 
 static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
-				       const u8 *mac, u16 vid)
+				       const u8 *mac, u16 vid, u8 aging)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -261,10 +261,12 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 		goto exit;
 
 	/* Rule exist. Delete first */
-	if (!fdb.aging) {
+	if (fdb.aging) {
 		ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
 		if (ret)
 			goto exit;
+	} else {
+		fdb.aging = aging;
 	}
 
 	/* Add port to fdb portmask */
@@ -810,7 +812,8 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
-	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid);
+	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
 }
 
 int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
-- 
2.40.1

