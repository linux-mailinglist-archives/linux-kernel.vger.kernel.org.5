Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58C7F00B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjKRPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjKRPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:06 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76A1FD9;
        Sat, 18 Nov 2023 07:51:48 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5c516f92759so32038617b3.2;
        Sat, 18 Nov 2023 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322708; x=1700927508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm1bHPEyELp3MiPjOSu0bHDojYqM84986duNSStQHBY=;
        b=S4GwRONQN6Sg7Bq0l5QNXv2PN7PtyWj4PbeIQm1D0PgHld0Aue9+G9wJIa3+VR6r4N
         69fckYz3ZFtTSrTmp3wBm9HgI4AFnN9oP8kq2NFoUF7zI5qMGuq0QfN8uWOwRlPcugwb
         SgsXAzhcRoKLyTeBcAykIkmKaVsdwZTdnJ5oMwlTmUIrFNm6hE7uIZwbfaRavFTiFbSN
         vgLIi9Doss0CR/kd4xoJudiEEg0LxDUQSmpsoAPa9Rmil3o3cEkzZkK+0SN5LNZQnmG0
         AT8q/gLHLLhO5bFeMeduSD7QNmlMQ2PI9YysiarzIbxyaKqkuWP1uhYJj7ntZbz/adua
         lqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322708; x=1700927508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm1bHPEyELp3MiPjOSu0bHDojYqM84986duNSStQHBY=;
        b=GvT1qHTA1uEw494ni2VTjuK/ejdoxx2W4wC6b86eetyhkRQcvwqLVuPHZqngQNHWE9
         dH4nYSxgs41Au6dTRF9+wxsmX1DMAdGL7VCzEidM3cTZGwg1rs/eU/bEz0zTRhR/U9Cv
         4+s+twvmyjJy2dfHPNz27sxaCqP7cz7hoyB0d8Z8tZ+36nFIJD2LMr98ongzkb7HAhpm
         mQUe43NT0Q9kPYAErdfb28epsXkRnD2REq0gxnuFzu5G+q9qlahmAT24manx57LN1lPJ
         OrJhi7ujbDrip45E/9MuE9on4tDNZSIDVWJ11mMeaERVCsriDnS1kjXNYTS+PA6WFcoX
         Phkw==
X-Gm-Message-State: AOJu0YxMJB6d2rNmyaG7G7trBdICttbdfXUClSnpYrs9S3nhXHKBdK0e
        ZNaImNiBiHR4RDMbCI7KngBlwAnUSXF289po
X-Google-Smtp-Source: AGHT+IEr9EXnIrnz3KfJlWeIhC3M3/FUV0iAGcHYIcYOW9tXgSnWoyx3lY1GC4qxv/GhgpzHagmIGw==
X-Received: by 2002:a81:ef0d:0:b0:59b:5696:c33 with SMTP id o13-20020a81ef0d000000b0059b56960c33mr2780375ywm.46.1700322707666;
        Sat, 18 Nov 2023 07:51:47 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id b65-20020a0dd944000000b005a8c392f498sm1167821ywe.82.2023.11.18.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:46 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 26/34] ethernet: rocker: optimize ofdpa_port_internal_vlan_id_get()
Date:   Sat, 18 Nov 2023 07:50:57 -0800
Message-Id: <20231118155105.25678-27-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize ofdpa_port_internal_vlan_id_get() by using find_and_set_bit(),
instead of polling every bit from bitmap in a for-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 826990459fa4..449be8af7ffc 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2249,14 +2249,11 @@ static __be16 ofdpa_port_internal_vlan_id_get(struct ofdpa_port *ofdpa_port,
 	found = entry;
 	hash_add(ofdpa->internal_vlan_tbl, &found->entry, found->ifindex);
 
-	for (i = 0; i < OFDPA_N_INTERNAL_VLANS; i++) {
-		if (test_and_set_bit(i, ofdpa->internal_vlan_bitmap))
-			continue;
+	i = find_and_set_bit(ofdpa->internal_vlan_bitmap, OFDPA_N_INTERNAL_VLANS);
+	if (i < OFDPA_N_INTERNAL_VLANS)
 		found->vlan_id = htons(OFDPA_INTERNAL_VLAN_ID_BASE + i);
-		goto found;
-	}
-
-	netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
+	else
+		netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
 
 found:
 	found->ref_count++;
-- 
2.39.2

