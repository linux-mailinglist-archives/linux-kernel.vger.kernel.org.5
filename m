Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80E7DC3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjJaAi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbjJaAiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:38:25 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF9A9;
        Mon, 30 Oct 2023 17:38:23 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-da077db5145so4147540276.0;
        Mon, 30 Oct 2023 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712703; x=1699317503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNWxUz2NxLkXz6WG/bZ7peSXHyS5FiPJ8oc8+TIvteE=;
        b=DwBwjwaz1Io0JzxxBYmbHvN54LjM2QmnmfUvoLpxhEtFwB6xPAEiS16N3StLDYr9yc
         ZA9KkT4pTnSjq3pyeB4E7qP4hNGTqo0hNd+WX/1gLOckcA5sw5FRd3BYzmOUlPwo2dLW
         K8jr5OfX/Tst64GI4xFYBbcVuKon4JjdkyP18OvnZRq5zAyfF0wPvvl1L1Mw/nJnloRt
         N1VucwsWes4Y3ZtkT+4iTvtAx+ZoukHONEwJi5DS7t8grZ5Ykf6abyZJh6zNtI80PUEl
         yqNmpGJ2BDIw/b4VugQJBMIyDYFtz3i21uzwQR9VELYBhoWk+f7eIGNVg1GTSGX0A26l
         V6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712703; x=1699317503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNWxUz2NxLkXz6WG/bZ7peSXHyS5FiPJ8oc8+TIvteE=;
        b=HsPYMejgRfOb1UNA/DgLHxYTPBNtWmEXk2wyePP3tPAFBdbZlL6YPF3YpBuu8qtOrl
         skeL3Pe4KPV/d1AYyPNl57LVC6u+X+cFbSNn+z6N4ah3iG5rbzI6EpqAQ4nLWGM3W2Ej
         P5W/dWy9QSXw21x9gyIg55j/XykGCRBqNO2lsrdywtkZfkh7uJLQsABIaUHy9osS0YvY
         q/K896AXxJ8iozDkSLbnkioW+s4FVvZ2VQ4zvSixyXVoNIC+d5iXoTN3PAs6NR4UVW0z
         xPjOtK5EyoCSWuM1m0QC4N93YbyQTBG6cOpYfZ2JcRpOU0OAttjVXssapKYweCjUlFRH
         iA9w==
X-Gm-Message-State: AOJu0Yz1FwDeibI958caZMQov7mPOi9H3S/RwVgXmfUPnUlJQRhYTErk
        ihaldX2TRNmu2B9X+vyfn9ZdnbNmflIi
X-Google-Smtp-Source: AGHT+IGgWc7KHIcrjpKOpD6pgY9qEv+bwm9+PsDaXLv1DX1ayloOlH4Mxk+5+Uw0Z8nEH8CkF/8q5g==
X-Received: by 2002:a25:ad03:0:b0:d9c:a583:9db0 with SMTP id y3-20020a25ad03000000b00d9ca5839db0mr10439299ybi.39.1698712702923;
        Mon, 30 Oct 2023 17:38:22 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm182750ybj.50.2023.10.30.17.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:38:22 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        hannes@cmpxchg.org, tim.c.chen@intel.com, dave.hansen@intel.com,
        mhocko@kernel.org, shy828301@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v3 2/4] node: add accessors to sysfs when nodes are created
Date:   Mon, 30 Oct 2023 20:38:08 -0400
Message-Id: <20231031003810.4532-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031003810.4532-1-gregory.price@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessor information is presently only exposed when hmat information
is registered. Add accessor information at node creation to allow
new attributes to be added even in the absense of hmat information.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 drivers/base/node.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4d588f4658c8..b09c9c8e6830 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -868,7 +868,9 @@ int __register_one_node(int nid)
 {
 	int error;
 	int cpu;
+	int onid;
 	struct node *node;
+	struct node_access_nodes *acc;
 
 	node = kzalloc(sizeof(struct node), GFP_KERNEL);
 	if (!node)
@@ -887,6 +889,20 @@ int __register_one_node(int nid)
 
 	node_init_caches(nid);
 
+	/*
+	 * for each cpu node - add accessor to this node
+	 * if this is a cpu node, add accessor to each other node
+	 */
+	for_each_online_node(onid) {
+		/* During system bringup nodes may not be fully initialized */
+		if (!node_devices[onid])
+			continue;
+		if (node_state(onid, N_CPU))
+			acc = node_init_node_access(node, onid);
+		if (node_state(nid, N_CPU))
+			acc = node_init_node_access(node_devices[onid], nid);
+	}
+
 	return error;
 }
 
-- 
2.39.1

