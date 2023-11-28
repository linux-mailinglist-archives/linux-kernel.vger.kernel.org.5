Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CD87FB4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbjK1IpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344225AbjK1IpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:45:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51411AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:45:06 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf80a7be0aso44338115ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701161106; x=1701765906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHxxwveZDRAPnfOWumxXktb5k7NbUjKgtDpJO55ZaA8=;
        b=PVg+vAbG5Eli/fKzjnqSzq3QEwBSoaN9bOYtemv4oCkYgNDbXV7U2P5Sz7GwuxRSwY
         cAWt8nh6n4Jqufzl4cYLtzzmNGOkzTHSGqJkWIWElJlOwJPUV59MYPgi9Qy0+oqrYyZb
         EBV/JQsIk7XOGsrA7Mavoiqn8zqa1sW9x2hnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161106; x=1701765906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHxxwveZDRAPnfOWumxXktb5k7NbUjKgtDpJO55ZaA8=;
        b=ukaq3rAONqQmiJWBELbdIpktbYzc+pTj8D/aiJvd267uzFiZz2ZsSHyvTISLtxt3Ob
         U1ztTP/xXEtcyD+e5Gt35ic5QmSyp1MZkxPSUVo01YwXa0t5iDz6Tegs0jy2d6qu/0Gz
         Bb6DwS15+U8uxVQH7K1cZ7y7tSxswgmE30bgKFREYCeZh1xavYjqYXKEG1r/oeb5ndTX
         xmuTcL/7qVZA1TR5ogPOtn/8aRxVEkw+STa1YCc8aKV5duUxqY5I2obE2vXA0PeIdPgX
         ldhwQ6LHi5DLR1UVSo6766AxXuwElO2AcfkjiV2xTZuAagVXFpX6WhM8huBaWz8Kmn5P
         Jn0A==
X-Gm-Message-State: AOJu0YzN1hixZu1SzZh+HxUR6P/FmhMQdU3t19Th8nptLtAoqSaltaMq
        ZCU62IIOvp1OujGDGe9zXaJfxw==
X-Google-Smtp-Source: AGHT+IFwNRanqg6iNjPiAn8C7xAInJUbYOtL1AJjn6XOh76hm70XQlF/qqZTYAqMlV2R/DvAZERpiQ==
X-Received: by 2002:a17:902:d2c1:b0:1cf:ccc3:c9d7 with SMTP id n1-20020a170902d2c100b001cfccc3c9d7mr7924520plc.3.1701161106024;
        Tue, 28 Nov 2023 00:45:06 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:a990:1e95:a915:9c70])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c08100b001ab39cd875csm8358074pld.133.2023.11.28.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:45:05 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, chrome-platform@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [RFC PATCH v3 1/5] of: dynamic: Add of_changeset_update_prop_string
Date:   Tue, 28 Nov 2023 16:42:30 +0800
Message-ID: <20231128084236.157152-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128084236.157152-1-wenst@chromium.org>
References: <20231128084236.157152-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to add string property updates to an OF changeset.
This is similar to of_changeset_add_prop_string(), but instead of adding
the property (and failing if it exists), it will update the property.

This shall be used later in the DT hardware prober.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
New patch added in v3.
---
 drivers/of/dynamic.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f63250c650ca..d22aad938667 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1039,3 +1039,50 @@ int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
+
+static int of_changeset_update_prop_helper(struct of_changeset *ocs,
+					   struct device_node *np,
+					   const struct property *pp)
+{
+	struct property *new_pp;
+	int ret;
+
+	new_pp = __of_prop_dup(pp, GFP_KERNEL);
+	if (!new_pp)
+		return -ENOMEM;
+
+	ret = of_changeset_update_property(ocs, np, new_pp);
+	if (ret) {
+		kfree(new_pp->name);
+		kfree(new_pp->value);
+		kfree(new_pp);
+	}
+
+	return ret;
+}
+
+/**
+ * of_changeset_update_prop_string - Add a string property update to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be updated
+ * @str:	pointer to null terminated string
+ *
+ * Create a string property to be updated and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_update_prop_string(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name, const char *str)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = strlen(str) + 1;
+	prop.value = (void *)str;
+
+	return of_changeset_update_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_update_prop_string);
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..c69bc7da380e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1601,6 +1601,9 @@ static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
 {
 	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
 }
+int of_changeset_update_prop_string(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name, const char *str);
 
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
-- 
2.43.0.rc1.413.gea7ed67945-goog

