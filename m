Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0105D7618F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjGYMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjGYMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:54:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9D19AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so8296552e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690289672; x=1690894472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Puz3ztq+s5PMQIYSFqmtMplo+slwUgkmSW9O9rbzaQ=;
        b=eOX71mI8ivbPxd47f1eV4r7XwztgvsB/VUt6UiU2TRTzqzn/nnNc5dYBCQ7YDwpwcw
         4HBgy5/tA3pr37dG8a8OX60bkNrHIpBqrsLUJw4zccm3bqKV2Lw5vm4RGbwODH7N6Her
         yiQtddh86DliiC3qSQhIR9Y1vNaY5Gt5CLb1vHwHV9UgJ9kjuPH05HuPeM57qIhIGKAq
         zs6T3wIBWTz3h8E8FwJ6FFDuoTE9KEJ0yZQQZFzZBrKjF656WagqNBNREbD7l8OcgZj0
         jibS2zS5edmrdiyj3AmKMHjH7JmAAn9J894UFTXdqgXFhPnzh3Fk9sKgZqOyodCVziQL
         W9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289672; x=1690894472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Puz3ztq+s5PMQIYSFqmtMplo+slwUgkmSW9O9rbzaQ=;
        b=fNNvHWtKrGCoVCJnf3/B5im8KVoT+j5aEKMj6xDVd4oLFgc5s//ZQv76+31AVMQsrf
         KmNkEPPmkrqRgEcHKBo7yq8oVexpGck65gaYRPxNxTHsMJFuWoo2ZC/h8q0C8YimeztE
         wQ9dkLM+eXunlNg1NNlrhOv2YlEQ6vpYXQ6u3kiZARipaiiWweX72SPuJ+Ctbkbn0WNJ
         yhHyhoC9MF1IkdkWXqXk0l+T5/DB8z+QU7kOp3FcXA0MC3TaraZlaJiN4EJm9ENm+5DD
         NujfKH8+WQXyZNX28ZCXIXU/mheZRLumVKIHd4tGztYMuorgL2kGDNhh4Vs+EoDXwsDH
         khNA==
X-Gm-Message-State: ABy/qLYPaiofDN2lVJCxGp9mZDAbeAdiQegfZlSqK+c7zJK0YJE/WhGd
        dQ88nGwismJ02wS24AbaX36hnA==
X-Google-Smtp-Source: APBJJlHZSFk1xstmzkc7CIM9TH+3PcYrQLyXquXF3/qVEGqAj4CIMfMvldYlGO/C3XlsJKxIowWyAQ==
X-Received: by 2002:ac2:4d96:0:b0:4fb:7532:35aa with SMTP id g22-20020ac24d96000000b004fb753235aamr7085307lfe.28.1690289671914;
        Tue, 25 Jul 2023 05:54:31 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402064b00b0051dfa2e30b2sm7516682edx.9.2023.07.25.05.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:54:31 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] pmbus_core: Refactor pmbus_is_enabled function
Date:   Tue, 25 Jul 2023 14:54:25 +0200
Message-ID: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Refactor the pmbus_is_enabled() function to return the raw status
without any additional processing as its already done in
_pmbus_is_enabled function.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index fa06325f5a7c..42fb7286805b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2768,7 +2768,7 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
 	ret = _pmbus_is_enabled(dev, page);
 	mutex_unlock(&data->update_lock);
 
-	return !!(ret & PB_OPERATION_CONTROL_ON);
+	return ret;
 }
 
 #define to_dev_attr(_dev_attr) \

base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
-- 
2.41.0

