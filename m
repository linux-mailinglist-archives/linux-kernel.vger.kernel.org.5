Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2678927B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjHYXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjHYXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:40:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB082D72
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d780a0d3cefso1834368276.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693006774; x=1693611574;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7aV7w0V21TeD8O9lx9J/kLPCQZ4fZ7EMNLpfS0Aue3E=;
        b=GVYu7ijOZ7ZT+xY+UPkvyjNQcuDD1KSsf0Qu+Id3NgMOO8BFowHFeZq/mWl44Sa8wg
         oRfsE086eMwryEq/fupeabtL3m8xfLrrB2oamvS/O5lvdr/ZEehM9K0SW+0iq6WgEjlM
         38rtnLYRUSmhj4BKde8TvEHmbi3VnrhIc76AmWosAbFs12XsxLHmPIZbjAd3KOSEY942
         U9ajPvEZ/SEJf0+59TMi4sfpQ9YP9vbWH8cEUIaiIR6EWRG3sIHD72TqhawvaGCvzEu8
         NJmUhom8BLp6WoozJyr/s06CsxlsUlq9sxP4EhUe+IN5cpdOrVau/PD9RSAc3g55VfOw
         mdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006774; x=1693611574;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aV7w0V21TeD8O9lx9J/kLPCQZ4fZ7EMNLpfS0Aue3E=;
        b=ZZAjHCjwIkVxNIHJIIoa3ASOKN2Rm6CX/AAVupJErrrfnqnKJJc3jnOJhJUKywB0JE
         itLngcg2GcsEAZjyOUxYYIfFE+kLyNc9/HkSWex5t/Ta4b0Mk5HBfcvyTRXUuhhrmftb
         Wn3sjDWyw8Ad2rPLts+kia82ahKzvx9513FJc98PMHy/5OXd0X/Gff8c89SWdE2EbfWS
         LGjY8v1JyJQh4iL88yUEHq9y9vHhdgUCciKr/JyrHxcbrzuH1g79HteGtPR6q+FeYGAY
         itqjzULNB+8ouDHQVAWM4Y+8YpKkCxv28YNYjndlSvJyJqz5SvkandTmYHbHgsF/26Om
         rO8Q==
X-Gm-Message-State: AOJu0Yzd3eoNnOo+Nj1D+3cyr5QzGFCWYL801rDiQGTp1rtMTi/zDiK+
        hWCYADg0ve9rfVbzTkd5ewJqHDo7TA==
X-Google-Smtp-Source: AGHT+IETlHmSjwJaM0AbmFP5PNi9j2E8KNwZHzi0fdSgcb/bfCO+qDMRXGD68g/LBc4tikN9NPbAK+0u8lE=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:4739:860d:b144:6102])
 (user=yabinc job=sendgmr) by 2002:a25:e757:0:b0:d0b:c67:de3b with SMTP id
 e84-20020a25e757000000b00d0b0c67de3bmr508497ybh.13.1693006774139; Fri, 25 Aug
 2023 16:39:34 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:39:30 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230825233930.1875819-1-yabinc@google.com>
Subject: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure access
 is disabled
From:   Yabin Cui <yabinc@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the non-secure access can be enabled later on some devices.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..5ebfd12b627b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
 
 	if (!tmc_etr_has_non_secure_access(drvdata))
-		return -EACCES;
+		dev_warn(parent, "TMC ETR doesn't have non-secure access\n");
 
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
-- 
2.42.0.rc1.204.g551eb34607-goog

