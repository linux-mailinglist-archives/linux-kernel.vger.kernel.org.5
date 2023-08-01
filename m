Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED976BD7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHATQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHATQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:16:32 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55218B;
        Tue,  1 Aug 2023 12:16:31 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56ca4d7079aso2152632eaf.0;
        Tue, 01 Aug 2023 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690917391; x=1691522191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/DiicnH3axzr7iqL00fOt/VCKsU/0ZbCcF8W8UmQHQ=;
        b=m26xAZ8i6jKtz/Yl/N5ClIAyAQgUcpy7TFLFCe8Ub5OEYhRIri93peDqRzKZcp7CEJ
         7Nu+k1nszqz8kyp6IV95lJKs7kDqq9wkSPccrR8OUraCw5RfelGnD6ttAYu92hhS1cb6
         I3tzvphXvZkV/IuqU/TD9FD3wY75ATeC9EzpO7Q1o8VDySTmfwQqqp7+Vb56fdQWFRNe
         AozoTFe4OoOwEgJZtod8nMD6qUOWLc3SVuQ+M+u/CLaNxGP34scGKsCEwiJUzJ/rP41p
         d6AzxVBggpb1Svog5c/c2ZSnvZ9lPdbVzLwtN5/YOJEzJGCXpDc8cclAlY/eflicC7Jj
         BmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917391; x=1691522191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/DiicnH3axzr7iqL00fOt/VCKsU/0ZbCcF8W8UmQHQ=;
        b=Xd02G1ln0aQ1HoIT/Gz9CYqC5egm3h+hsgTClp8ylK9yAwmVUas1sIBpxVFnM86kpp
         qw3sQMrIVWvx8hKJBlu6+mKnddgeVaerwpzYlWxKz5MSEqp+h75WdBML3RLNAm2HZQld
         aMUwG3t95OAv3BL2PUGtNm9YvReVJO3/+fgxg1s9bjgCuhkWSwJwjJ9qHTifYsihwj1f
         rmlgdvnTx4dh3qb7tsNkI+CCxGaytlyZKvWrQQqm51lBEXWnWjMkKd5+A9qnh50E4Aj+
         NZEXTJci4d8Dqk/uiiOvDKmUBSp+O182hSA5fU1XXOz1aKR6JzKZhd7khTcd377hd3YQ
         PeIA==
X-Gm-Message-State: ABy/qLaeY1XNn4nOw0bQ3Cgj6WWiZUTD3bZ3cX/e+DgN/mDb6rMqcqXA
        RpRAggU6ZID0EmJFrkEruA8=
X-Google-Smtp-Source: APBJJlF/MU5mflY7MkJoxsd9baK9GklT2V12HX3LXuGOyGs/LnT5GrfnNMxf7W5HLeKmVqRKkKpVmw==
X-Received: by 2002:a05:6808:93:b0:3a7:5075:b0b8 with SMTP id s19-20020a056808009300b003a75075b0b8mr1985197oic.4.1690917390865;
        Tue, 01 Aug 2023 12:16:30 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:2bee:a481:ab2e:3ea2])
        by smtp.gmail.com with ESMTPSA id p64-20020acaf143000000b003a414415693sm5860738oih.44.2023.08.01.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:16:30 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH] hp-bioscfg: Update string length calculation
Date:   Tue,  1 Aug 2023 14:16:29 -0500
Message-Id: <20230801191629.45942-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
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

Replace method how the string length is calculated.
Removed unused variable 'size'

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index cffc1c9ba3e7..b19644ed12e0 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -258,13 +258,11 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				eloc++;
 			break;
 		case ORD_LIST_ELEMENTS:
-			size = ordered_list_data->elements_size;
-
 			/*
 			 * Ordered list data is stored in hex and comma separated format
 			 * Convert the data and split it to show each element
 			 */
-			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
+			ret = hp_convert_hexstr_to_str(str_value, strlen(str_value), &tmpstr, &tmp_len);
 			if (ret)
 				goto exit_list;
 
@@ -279,7 +277,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				strscpy(ordered_list_data->elements[olist_elem],
 					part,
 					sizeof(ordered_list_data->elements[olist_elem]));
-				part = strsep(&part_tmp, SEMICOLON_SEP);
+				part = strsep(&part_tmp, COMMA_SEP);
 			}
 
 			kfree(str_value);
-- 
2.34.1

