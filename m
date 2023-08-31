Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73F678ECD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbjHaMOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbjHaMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:14:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F51CFF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so13951471fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693484056; x=1694088856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVsS59qilvjuc8pISvBl0xkp2xoZ2lqHu9VV6p7+8P0=;
        b=Wbt3xwTHsd9vsWrVS0q2mpF7IzsZXOnLSP7a1nvJuML52qoWD94Nz6+cqWhqW7U4Hf
         N1HVG1EB+cKk1TIpxJl2qlvASiceJdK1T7Pe++qMumUCE1wNFkGek7Xds3kty/x3Ls8y
         i0QZ0AUsKpC+2W56hkpS429nWuYGomiaXQatWHxD75ZSWf79yTEZWUiNVGEFHblN2SXq
         KcBT7iVFBOY1pEbEYaSGWdRPomovo6pQyCcJYqF0bFy8S6LGtEs3ryVS6PmhMpAMwpxX
         ujOtm5csAyWEipUY/gU0aowjzlVBQct9IO1Kpcnw8gXe7khdw0lH3bK2mn/YPNgS4tkO
         NAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484056; x=1694088856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVsS59qilvjuc8pISvBl0xkp2xoZ2lqHu9VV6p7+8P0=;
        b=l7TGnQ5f+xO2Ocp9YYWuyvp+8fOz/UvzOnSFWtmz2oP1mk5274RMuMgswtzTWvYIki
         oQR5vo91JV8GrR5nC5E8UTfonYX0993S+wk5J/Kf65zCR7dcdVqWAKYeeQNKZBmuxY5g
         H2FGTck3DfUJJ7QND9BhSl30bOGy98JE9LB4MaBi/0T9YKK2qnZfDhO4iwoGQBiQ7eXI
         oissHYkM5EkivK0Jh74lC8waRZTFFtApoY5sIGLqw15fkjSlc5rUOh0T04pmRVzcHGcj
         MqytONEfBtR1ZZMw61MTpi4bUx9npekodUCdL/wzn2PAsKY7LBKLhBvpy1suDDmZXyhB
         YEQA==
X-Gm-Message-State: AOJu0Yy7G481vdWvMjmVeOuSxtcA5BupjXyg+a0h7nKlJfpWKTDdS1ss
        sQifEraoC6DJFWZH3TzB4kduvQ==
X-Google-Smtp-Source: AGHT+IEpk7ruzwTjBkc5zX2fDA7VOac/dCyuZtj/Agm3vXUwr1FsdEx961QszJ43TV9ej4jL3fKkvQ==
X-Received: by 2002:a2e:3109:0:b0:2bd:16e6:e34a with SMTP id x9-20020a2e3109000000b002bd16e6e34amr4165814ljx.19.1693484056105;
        Thu, 31 Aug 2023 05:14:16 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm1799448wmc.10.2023.08.31.05.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:14:15 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] regulator: userspace-consumer: Add regulator event support
Date:   Thu, 31 Aug 2023 14:14:09 +0200
Message-ID: <20230831121412.2359239-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attribute to track regulator events received from regulator
notifier block handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 54 +++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..a936661d99cd 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -29,6 +29,10 @@ struct userspace_consumer_data {
 
 	int num_supplies;
 	struct regulator_bulk_data *supplies;
+
+	struct kobject *kobj;
+	struct notifier_block nb;
+	unsigned long events;
 };
 
 static ssize_t name_show(struct device *dev,
@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static DEFINE_SPINLOCK(events_lock);
+
+static ssize_t events_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct userspace_consumer_data *data = dev_get_drvdata(dev);
+	unsigned long e;
+
+	spin_lock(&events_lock);
+	e = data->events;
+	data->events = 0;
+	spin_unlock(&events_lock);
+
+	return sprintf(buf, "0x%lx\n", e);
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RW(state);
+static DEVICE_ATTR_RO(events);
 
 static struct attribute *attributes[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_events.attr,
 	NULL,
 };
 
@@ -115,12 +137,30 @@ static const struct attribute_group attr_group = {
 	.is_visible =  attr_visible,
 };
 
+static int regulator_userspace_notify(struct notifier_block *nb,
+				      unsigned long event,
+				      void *ignored)
+{
+	struct userspace_consumer_data *data =
+		container_of(nb, struct userspace_consumer_data, nb);
+	static const char * const *envp[] = { "NAME=events", NULL };
+
+	spin_lock(&events_lock);
+	data->events |= event;
+	spin_unlock(&events_lock);
+
+	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
+	kobject_uevent_env(data->kobj, KOBJ_CHANGE, envp);
+
+	return NOTIFY_OK;
+}
+
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	int i, ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -153,6 +193,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	drvdata->num_supplies = pdata->num_supplies;
 	drvdata->supplies = pdata->supplies;
 	drvdata->no_autoswitch = pdata->no_autoswitch;
+	drvdata->kobj = &pdev->dev.kobj;
 
 	mutex_init(&drvdata->lock);
 
@@ -186,6 +227,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	}
 	drvdata->enabled = !!ret;
 
+	drvdata->nb.notifier_call = regulator_userspace_notify;
+	for (i = 0; i < drvdata->num_supplies; i++) {
+		ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
+		if (ret)
+			goto err_enable;
+	}
+
 	return 0;
 
 err_enable:
@@ -197,6 +245,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 {
 	struct userspace_consumer_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->num_supplies; i++)
+		devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
 
 	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
 
-- 
2.41.0

