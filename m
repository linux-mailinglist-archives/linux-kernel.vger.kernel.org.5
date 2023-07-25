Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FB762552
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGYWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGYWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:04 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0022E0;
        Tue, 25 Jul 2023 15:01:03 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5634d8d1db0so3836682eaf.0;
        Tue, 25 Jul 2023 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322463; x=1690927263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QX7T2RPgbuYmgoQOJwoEsgAUtn61DiADmPjBuL7fWDc=;
        b=hFVnEW+UvIkZfF9U6GFwGnUmRFoV5LNdQd7RH61zvA4z8nURZU4gp3EszcF63CMdI0
         FygbNn7LHdbZ5MBZFW+YcdR8ndLv98WAgRJPj673nOrK1e3iTpgW/2Jn/507ZlaOw32w
         JfRENeqIqwMfPFTa8U7Goo/9WIYxrHYSrxAVHJfl5lbHD6ewUthSxKNXst56HxOA9abw
         6day8S0+bW6+KdGQWYYxRAHIouf8XH4zqWBvJeza0DYEvIjEi0+D18UXxWSSooW26wOe
         cuPpHWDHnKhrJD5Ce/OayN1cuxnAnoCYArLZtPB36035XIKy/9RD4eg5F2Sj3H4Nt0rE
         0r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322463; x=1690927263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX7T2RPgbuYmgoQOJwoEsgAUtn61DiADmPjBuL7fWDc=;
        b=J0cXrQGfn0wrsIofuIb3mo85XbFRTOTsZqwAMJYoLEzJR4/VLrxxgnEvAar+6CiaER
         iFpTDSm20XBt0nSOSavJL1G/1qMG/EvsU+zrqjTQVrCtLBVAmoXA7LD/ZUUb+x2JDHVL
         hpZ+XsCIgCRl2XO05rpcKWq1vb36F7UlIbN3CnW4H5/raCdTGHkNmc5sAOYJ32ALAKMb
         le6VmQsNNguZ6UjcXxqH3KjE+eHzqUBew8eSjapTHIyxxEde7mmEkTrxnfYyOwdhkVxP
         QpT3a3/s7unehDHJ/U6o7ezaUaVhaW74LGFQ1DApJmHb+jxvWoxVuNTDATr9q2BOyHh5
         jtMQ==
X-Gm-Message-State: ABy/qLYW0HapcZrSYZ2pT9dybN0Kp0fig8bx0T3stUq18As55sie4gF2
        RY3u/Mx55htzDCpp/eYdHys=
X-Google-Smtp-Source: APBJJlHYOTWAkHaNlbdB4sQSR8mFdK35EDIebnNZ3A0a3Pih3TclyM3kSYF439JcIVzJh2yxtFrfww==
X-Received: by 2002:a4a:3107:0:b0:566:fcc8:5b6e with SMTP id k7-20020a4a3107000000b00566fcc85b6emr79987ooa.6.1690322463049;
        Tue, 25 Jul 2023 15:01:03 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:01:02 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 3/5] hp-bioscfg: Fix memory leaks in integer_elements_from_package
Date:   Tue, 25 Jul 2023 17:00:54 -0500
Message-Id: <20230725220056.25560-4-jorge.lopez2@hp.com>
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

Address memory leaks in hp_populate_integer_elements_from_package()
and uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 7364c5ef9ef8..97f88e0ef0cc 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -143,7 +143,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 	char *str_value = NULL;
 	int value_len;
 	int ret;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
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
-- 
2.34.1

