Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC2762551
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGYWBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjGYWBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:03 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F3BC;
        Tue, 25 Jul 2023 15:01:02 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bba1816960so680462fac.3;
        Tue, 25 Jul 2023 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322461; x=1690927261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUKWe23SezTiM/kRUdKBl5wmSf4mUZBR+Z+CLpUrp98=;
        b=H+d1jGajJSEzB3DvvT22YBnAf0zVpenbkl00bJpOlYhvKDQGRxnHB/z99wTBpVQGdu
         dwNmghwF+rGPqJ18uIg7Fiw4GokkurKyCkhtPejeI2YousXpG8bpEdFmNrsHXICE8+Gv
         YLLhieE7+OCxoq7vxVQ3BAFRrMs8FY4+cKkWBp+hRNUrOwevCFuxYSbs0J6CbxIPIWrO
         gUajJ2H6AoQmX3UfU+wO6d1FOesOWvTqcWPSi1x+QgOsl0DcuC8dGcWai98H7tmr5kzv
         /du5AfOLoP3cyxNKt0mtsJO+EXB2LOqf/ypmR7412uiWXxr/zlkYfdFJb6d+SMs7dx57
         uqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322461; x=1690927261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUKWe23SezTiM/kRUdKBl5wmSf4mUZBR+Z+CLpUrp98=;
        b=VYz8LGkG9YU5i2MkL0uVtB8Zw/kA8/OH68Sk/c1IWqZODOEPxzufBX45rasdEyq0l2
         Td9X+vbRypdghclNl15xR6lvrKCOxD1IoVxjAanjbFBCWSJPfclHREFlcjB/QUynGiZ2
         Sz6xAZUl+NTUx/TXG3CyTeabaHyzcdIHitTjTfXCqtUryHuOW/19mlkcCaMuqtDk3B/m
         9U9XfmNLBDV33vf2Mt0MxpynI1umEbvjhJnG1FrzKhjX3hCWmCH2uA8eT3K1aw98uoKW
         D73f9pggMODGclb4BwEMrZFdat3ZWsBp3XjEETXCIgkYm62zK9YdUxEmKnW7w5eB/ag9
         czgQ==
X-Gm-Message-State: ABy/qLZwWBEZGqapQ/B/Dr+YcSVlV5sLJ/64ENgU8Dc8PSIvm5h5nw7F
        yQo3nCjJNxM9HDDG6Yu6CVUSrv/WnJc=
X-Google-Smtp-Source: APBJJlGs8e+BcZoeIS7Ta8OdSTKkN/L7RoS80xB2EO9r2yWa13JhAScPI++JItWed+digROGv9kQqA==
X-Received: by 2002:a05:6870:40ca:b0:1b7:6158:621a with SMTP id l10-20020a05687040ca00b001b76158621amr370690oal.47.1690322461369;
        Tue, 25 Jul 2023 15:01:01 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:01:01 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 2/5] hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
Date:   Tue, 25 Jul 2023 17:00:53 -0500
Message-Id: <20230725220056.25560-3-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725220056.25560-1-jorge.lopez2@hp.com>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
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

Address memory leaks in hp_populate_ordered_list_elements_from_package() and
uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../platform/x86/hp/hp-bioscfg/order-list-attributes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 7e49a8427c06..89e67db733eb 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -131,10 +131,10 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 							  int instance_id)
 {
 	char *str_value = NULL;
-	int value_len;
+	int value_len = 0;
 	int ret;
 	u32 size;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
@@ -174,6 +174,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 		if (expected_order_types[eloc] != order_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_order_types[eloc], elem, order_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -231,6 +232,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 					sizeof(ordered_list_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -277,13 +279,17 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				part = strsep(&part_tmp, SEMICOLON_SEP);
 			}
 
+			kfree(str_value);
+			str_value = NULL;
 			break;
 		default:
 			pr_warn("Invalid element: %d found in Ordered_List attribute or data may be malformed\n", elem);
 			break;
 		}
 		kfree(tmpstr);
+		tmpstr = NULL;
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_list:
-- 
2.34.1

