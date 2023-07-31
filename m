Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB0769C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjGaQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGaQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:22:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842831BC;
        Mon, 31 Jul 2023 09:22:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bca6c06e56so743362a34.1;
        Mon, 31 Jul 2023 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690820554; x=1691425354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzDgNvvV4+bZsRGmwAKaLXNz2B8luD/46V4R65j5gic=;
        b=C0Le20HcBnso+YRaacqK4yVMkuJZQ6t40Wk9lFOz04YTFH3+fzUmXD5q/D16jn3hGS
         1ILSPorameEjHnW0Inaym0UIANGGcbS2a9BDHyoZZB+xcLFyVd661FQZjU5pvHHK69Wr
         bz6paJSCY2SLV0gMfH3jvSdhtajeGO1S1gabOd04zc00WLoIOJRnw7AUHAdJbTj9sIK7
         1fQLOIfwVPR9HUFtJBLtiQL6Jqkw5Mq7aBh+5y/6tXi1Wg1Fmf8MCxJjcP9lnNCCpFcx
         WIMEEBNTa3WMjwnbvwUp+4zsSCaYOXqH9MecIe6q5bF1stHkyvW8jGyJaGegomvTCzYo
         mPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820554; x=1691425354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzDgNvvV4+bZsRGmwAKaLXNz2B8luD/46V4R65j5gic=;
        b=WeHVhCd5z78gf5fNo74LVZMJXJsf/G1etlTTCNIl4oyp6RiMuSEn1r99EO/3dj1BkU
         892VgnKNFVZexu0taKvXLWtja8AIKWb3F0wtoQJGcr1sp2/g5tBPpCa7S+4UZn6Xxksu
         Kyx89p47A7uPLwX2zS3QB1r2TjNQyo8cdICkstz45bBBkF8/2wFxQvPh5F2NWW+llxIU
         wY4E8WqsKSHZN1kOX+hmQJAjx4inSoDUBvYmkB2UED+5TAPZ9nwOMrNq8ImW/yETkleq
         n7wWjvhztkhGG9GU33eRTXJ1NF2cXAyEHHoLVVIsO6nM7o6NJfVVv32fCx5ABAAgTZe1
         cikw==
X-Gm-Message-State: ABy/qLZnMjf8je6mG/aFFipeaNKIBpKkFz7ZAzTCgcDzt6iGxff/zL5W
        AIDrIsaWkOVRQRFJbrZ4jyyEzc++0lc=
X-Google-Smtp-Source: APBJJlFIMMfplnYJagHynrP0HtUV5sTdOmIzJtKNZy+4Pk4oG5B350Akhyg4f9zCLZrBNKtcsGTtVw==
X-Received: by 2002:a05:6870:f690:b0:1b3:977b:8201 with SMTP id el16-20020a056870f69000b001b3977b8201mr12268949oab.7.1690820553235;
        Mon, 31 Jul 2023 09:22:33 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id dw18-20020a056870771200b001b04434d934sm4606268oab.34.2023.07.31.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:22:32 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH] Fixes for ordered_list_elements_from_package
Date:   Mon, 31 Jul 2023 11:22:31 -0500
Message-Id: <20230731162231.15814-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address latest comments and requested changes to
ordered_list_elements_from_package

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 44 +++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 89e67db733eb..98e51759134c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -134,8 +134,9 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 	int value_len = 0;
 	int ret;
 	u32 size;
-	u32 int_value = 0;
+	u32 type_int_value = 0;
 	int elem;
+	int ord_list_elem;
 	int reqs;
 	int eloc;
 	char *tmpstr = NULL;
@@ -147,10 +148,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 	if (!order_obj)
 		return -EINVAL;
 
-	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
-		/* ONLY look at the first ORDERED_ELEM_CNT elements */
-		if (eloc == ORD_ELEM_CNT)
-			goto exit_list;
+	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {
 
 		switch (order_obj[elem].type) {
 		case ACPI_TYPE_STRING:
@@ -163,7 +161,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			}
 			break;
 		case ACPI_TYPE_INTEGER:
-			int_value = (u32)order_obj[elem].integer.value;
+			type_int_value = (u32)order_obj[elem].integer.value;
 			break;
 		default:
 			pr_warn("Unsupported object type [%d]\n", order_obj[elem].type);
@@ -190,30 +188,30 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				sizeof(ordered_list_data->common.path));
 			break;
 		case IS_READONLY:
-			ordered_list_data->common.is_readonly = int_value;
+			ordered_list_data->common.is_readonly = type_int_value;
 			break;
 		case DISPLAY_IN_UI:
-			ordered_list_data->common.display_in_ui = int_value;
+			ordered_list_data->common.display_in_ui = type_int_value;
 			break;
 		case REQUIRES_PHYSICAL_PRESENCE:
-			ordered_list_data->common.requires_physical_presence = int_value;
+			ordered_list_data->common.requires_physical_presence = type_int_value;
 			break;
 		case SEQUENCE:
-			ordered_list_data->common.sequence = int_value;
+			ordered_list_data->common.sequence = type_int_value;
 			break;
 		case PREREQUISITES_SIZE:
-			ordered_list_data->common.prerequisites_size = int_value;
-			if (int_value > MAX_PREREQUISITES_SIZE)
+			ordered_list_data->common.prerequisites_size = type_int_value;
+			if (type_int_value > MAX_PREREQUISITES_SIZE)
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
 			 * zero.
 			 */
-			if (int_value == 0)
+			if (type_int_value == 0)
 				eloc++;
 			break;
 		case PREREQUISITES:
@@ -237,21 +235,21 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			break;
 
 		case SECURITY_LEVEL:
-			ordered_list_data->common.security_level = int_value;
+			ordered_list_data->common.security_level = type_int_value;
 			break;
 
 		case ORD_LIST_SIZE:
-			ordered_list_data->elements_size = int_value;
-			if (int_value > MAX_ELEMENTS_SIZE)
+			ordered_list_data->elements_size = type_int_value;
+			if (type_int_value > MAX_ELEMENTS_SIZE)
 				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. ORD_LIST_ELEMENTS
 			 * object is omitted by BIOS when the size is
 			 * zero.
 			 */
-			if (int_value == 0)
+			if (type_int_value == 0)
 				eloc++;
 			break;
 		case ORD_LIST_ELEMENTS:
@@ -261,7 +259,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			 * Ordered list data is stored in hex and comma separated format
 			 * Convert the data and split it to show each element
 			 */
-			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
+			ret = hp_convert_hexstr_to_str(str_value, size, &tmpstr, &tmp_len);
 			if (ret)
 				goto exit_list;
 
@@ -272,10 +270,10 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 					tmpstr,
 					sizeof(ordered_list_data->elements[0]));
 
-			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
-				strscpy(ordered_list_data->elements[elem],
+			for (ord_list_elem = 1; ord_list_elem < MAX_ELEMENTS_SIZE && part; ord_list_elem++) {
+				strscpy(ordered_list_data->elements[ord_list_elem],
 					part,
-					sizeof(ordered_list_data->elements[elem]));
+					sizeof(ordered_list_data->elements[ord_list_elem]));
 				part = strsep(&part_tmp, SEMICOLON_SEP);
 			}
 
-- 
2.34.1

