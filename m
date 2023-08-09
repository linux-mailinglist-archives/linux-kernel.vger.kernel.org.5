Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D3776ABC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjHIVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHIVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:07:44 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311281FD2;
        Wed,  9 Aug 2023 14:07:43 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd066b0fd4so214373a34.2;
        Wed, 09 Aug 2023 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691615262; x=1692220062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B35FL86sKskIjPM/ffA3EI5QZafQThibDMhYf5nJ0Xg=;
        b=SG9DwWmWWuvsH2fAgofeTRhLkIKvEiFkcI03U+DBYDfR7tm9vVRM9wrgeAtg9bSQFx
         tYkHacKyA+tM825TuRzLW+NaauH2VgXlha+oUBRfjw/295l0wrbqIiN8PCxGD/+86UHb
         EQEwtXoPrnoLY9G8onP9RiO1/ErCGA5qSESOJP3N3GnvMMxw2y9+GxORqLAZDzTDkq6y
         rhZ4uxEO7hBSXs+t7xvsU+AVmGODsB+2LJC/VKlabfd6E3tVyYQd8AKIutEdVrs1krpJ
         3ZkYvN4ihOwrO60f7291SIMxgjsYTJoWG4n9CBJ7yfip51G2eJqnS7au3pM8D1fScqb6
         yrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615262; x=1692220062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B35FL86sKskIjPM/ffA3EI5QZafQThibDMhYf5nJ0Xg=;
        b=LgYY+eJz7O9sKYey3OvkgzhhU6khTjXUOwFhtaVNCpNMGRzf6Pj01vk9xDMKlWIKke
         0ssXqHELRq0CNc4ZMQ3YcZFUlUXU0+HIxdUh6Bjcd1o7uvwciTLCXPm5ZAgVlBmiUkyk
         KFNySRAolSfYcWn47c3ky9upyEDdzgP3oWBl0PlKgoVhDq4Z5B2oU7d690ZWN4fuxmiJ
         f4T3ETxUqWUKG9lXlShKQUpClaT0xsJzv05tOh1jQ7pn73U3wMXjRWFDYjfz4GP2tL2X
         i0QYW0wQY4ZCTOkYwClQ8S7htpd3XE4XFeTRe1qHEH1C0xgiJfVNUSi8ZJGpH8TwrToB
         Fdmg==
X-Gm-Message-State: AOJu0YyGx5xwdVZrLwDNBvlxwXg8R4whiT1fCvZ1fn40QcMN0dE66SNU
        fWYpCU/0121wJ4xZlqMj9Pw=
X-Google-Smtp-Source: AGHT+IHgGhDsVVRSGZzJZPWmm7kPGrSiJpkvNI1mZzvqk1OOKLkpeQ4jc7feeMjqxDyWipotwvSQ/w==
X-Received: by 2002:a05:6870:d5a7:b0:1be:f7d9:c0df with SMTP id u39-20020a056870d5a700b001bef7d9c0dfmr461779oao.10.1691615262248;
        Wed, 09 Aug 2023 14:07:42 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:2825:7de2:269d:39bc])
        by smtp.gmail.com with ESMTPSA id x5-20020a056870740500b001bfd65998aesm39845oam.58.2023.08.09.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:07:41 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH] hp-bioscfg: Update steps how order list elements are evaluated
Date:   Wed,  9 Aug 2023 16:07:40 -0500
Message-Id: <20230809210740.18392-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update steps how order list elements data and elements size are
evaluated

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/order-list-attributes.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index b19644ed12e0..d2b61ab950d4 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -152,7 +152,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 
 		switch (order_obj[elem].type) {
 		case ACPI_TYPE_STRING:
-			if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
+			if (elem != PREREQUISITES) {
 				ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
 							       order_obj[elem].string.length,
 							       &str_value, &value_len);
@@ -266,6 +266,15 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			if (ret)
 				goto exit_list;
 
+			/*
+			 * It is expected for the element size value
+			 * to be 1 and not to represent the actual
+			 * number of elements stored in comma
+			 * separated format. element size value is
+			 * recalculated to report the correct number
+			 * of data elements found.
+			 */
+
 			part_tmp = tmpstr;
 			part = strsep(&part_tmp, COMMA_SEP);
 			if (!part)
@@ -273,11 +282,14 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 					tmpstr,
 					sizeof(ordered_list_data->elements[0]));
 
-			for (olist_elem = 1; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
+			for (olist_elem = 0; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
 				strscpy(ordered_list_data->elements[olist_elem],
 					part,
 					sizeof(ordered_list_data->elements[olist_elem]));
+
 				part = strsep(&part_tmp, COMMA_SEP);
+				if (part && ordered_list_data->elements_size < MAX_ELEMENTS_SIZE)
+					ordered_list_data->elements_size++;
 			}
 
 			kfree(str_value);
-- 
2.34.1

