Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE976A1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGaUcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGaUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A781BC7;
        Mon, 31 Jul 2023 13:31:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bcae8c4072so279638a34.1;
        Mon, 31 Jul 2023 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835504; x=1691440304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GP+QHr3v6YWcRgxlfip67FR17AcusTOb3sQ59TeLes=;
        b=a6zaTRTtVtOJGm5dMouMX5i4dPC28dGaiT8x52Ml+aIdH92kRm+oD/GQTktUeTvTl0
         o0L3DL9Sj6iOvAXtZYy0p/YTvJxLFkBo+3mngG6g0VhSWTmQcUTDF6+rUVIYLyYBzE6h
         5URmUzwMlDnUS1jZBsX25HR9C+S/VxNuIxYlXBKZw63gFOb9ZUaqIlPdMVAKCTT58f/6
         Lh/HJegyEZIhvAZ2ZQekxXMvl3fmQnHhen9YMEJ91loXf6kzG7UHxg9WHFUAxe+Nhbtc
         JNhkaYNnupK1vqf0aCwlfGhJZ9945FnSMm5HHro5GYUycVGy+/5MCvnCMtvMIbu+pdCU
         dqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835504; x=1691440304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GP+QHr3v6YWcRgxlfip67FR17AcusTOb3sQ59TeLes=;
        b=g6irYjT8N7hYHQWMvj9quG6AQpj0P5Xfh0qSgvGfq0pxb1JLshbQPX/aEY+68h4kU1
         OjpWdPMcvPVrv75ikegiiW7mx/55w39vFS5slefmt9aUgftsIaGnafxkg+qUF+ftSJNy
         jHybwxBxLqfHGVV1C0aB3M9x7qzYId577rqUnvaWphnlfoU46FYBo5ZzPlbmWlYvlmZ6
         vGL61TrJAzh9YdVDrx6UlqRs0ai7jBkJdrBjTs9+M4qKqa5+3Exts+62322QKvbEJno0
         UK2qRPGfj+I6SrTDpuMhXwrS6WyXkc5GOaboL56SGydbTEXg6aOKDOt7tOzN07stY0j7
         olbQ==
X-Gm-Message-State: ABy/qLYswtA06NrXKTByc8UaMEt3BQPix6HowbodpOxziWjL7oijguy/
        FAtkBIe6oCh4ckwIkqa+udY=
X-Google-Smtp-Source: APBJJlHTbh+n8V87LrTHRfig+cHWlgJGEbBm3NayJSVS04LYqN74Hqsv+rg8uB07499qPPxheeFM3g==
X-Received: by 2002:a9d:7748:0:b0:6b9:1bfa:9e2d with SMTP id t8-20020a9d7748000000b006b91bfa9e2dmr10137742otl.0.1690835504093;
        Mon, 31 Jul 2023 13:31:44 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:43 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 1/8] hp-bioscfg: Fix memory leaks in attribute packages
Date:   Mon, 31 Jul 2023 15:31:34 -0500
Message-Id: <20230731203141.30044-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
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

Address memory leaks while handling elements in packages.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c      | 6 ++++++
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c       | 5 +++++
 .../platform/x86/hp/hp-bioscfg/order-list-attributes.c    | 6 ++++++
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 8 ++++++++
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c    | 3 +++
 5 files changed, 28 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index b1b241f0205a..8e615ccfc9b5 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -164,6 +164,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -224,6 +225,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					sizeof(enum_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -275,6 +277,9 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					strscpy(enum_data->possible_values[pos_values],
 						str_value,
 						sizeof(enum_data->possible_values[pos_values]));
+
+				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 		default:
@@ -283,6 +288,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		}
 
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_enumeration_package:
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 7364c5ef9ef8..6db2c8ba02a9 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -179,6 +179,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 		if (expected_integer_types[eloc] != integer_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_integer_types[eloc], elem, integer_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 		/* Assign appropriate element value to corresponding field*/
@@ -239,6 +240,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 					str_value,
 					sizeof(integer_data->common.prerequisites[reqs]));
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -258,6 +260,9 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 			pr_warn("Invalid element: %d found in Integer attribute or data may be malformed\n", elem);
 			break;
 		}
+
+		kfree(str_value);
+		str_value = NULL;
 	}
 exit_integer_package:
 	kfree(str_value);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 7e49a8427c06..739998682874 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
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
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 52e4d346b529..3f7b9fe857f1 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -264,6 +264,7 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 		if (expected_password_types[eloc] != password_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_password_types[eloc], elem, password_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -318,6 +319,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 					sizeof(password_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
+
 			}
 			break;
 		case SECURITY_LEVEL:
@@ -356,6 +359,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 					str_value,
 					sizeof(password_data->encodings[pos_values]));
 				kfree(str_value);
+				str_value = NULL;
+
 			}
 			break;
 		case PSWD_IS_SET:
@@ -365,6 +370,9 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			pr_warn("Invalid element: %d found in Password attribute or data may be malformed\n", elem);
 			break;
 		}
+
+		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_package:
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index 1b62e372fb9e..c9e124af170e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -171,6 +171,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 		if (expected_string_types[eloc] != string_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_string_types[eloc], elem, string_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -232,6 +233,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 					str_value,
 					sizeof(string_data->common.prerequisites[reqs]));
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -250,6 +252,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 		}
 
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_string_package:
-- 
2.34.1

