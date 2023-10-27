Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCD7D9CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbjJ0P3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ0P3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:29:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25AAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:29:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084095722aso17294925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698420539; x=1699025339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzqx8XYbA4QiCfYm/TIcDbjCVUGr9u+/h0s0o1TtnVY=;
        b=KDgbDmT4uiBw//y5CHKM+PSx4m2gncCUMZ66RmoBfzfF2kmGOdOEyctPT+KHfRmxNa
         QozaTAf/cAGKye3lIcCpYM3RU94aCkoRAESvOLTCXFTajebAbPczLYp6fHjqIOOl57OD
         Uistv14jyTZjzQWVFjaSKzJkW+ezxvM8reUQZRpTq4otxrl0Pp2s1hkEj20uQpqSWqxw
         HAqr3FQE+MvkZ38SdCKdc11XbtUEFA0K3/LSBsd7XGgX7zW2P8WXDotGNwk1yzlvL4+k
         6RzF0jrQQOMm/DugN5p9VqGPulQygRG0D/5KOXQsEt8oLM1q/vCggyucgUeP0HsXKUQ8
         FxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420539; x=1699025339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzqx8XYbA4QiCfYm/TIcDbjCVUGr9u+/h0s0o1TtnVY=;
        b=pxl1xk3K7YOn6ZlvDQRPiqBZmk60sHCnpveiOmDaE5hVGhpju9fx6hJu7S6fhXXEHD
         Fr+41ZTc+ZlNkAAjvM2LeIIe2Sw9cZHEJ5sO86uWB3DPCSIBFQa8IOSrM9PlkSHjEpUB
         fpyMNktxHydYeMsXiRbztsWmtO9FZELGnNaPOccnmHdwS6zutoAAn6NUFXSXz/fKH+2u
         CRLIV3dMYf/VgLzuyG5nPtrgHcZY1PHPwp2SoKerE8zaN1PNQtigrd/3LOY2JPkAdpNK
         h9w/aBO1VoU3ltqkvr9yr5bIAPbteiEmc9NeEMg2nNNsBvKbUoQs2gWuDdCW3+MrxtKM
         joOg==
X-Gm-Message-State: AOJu0YzFhb7Sz95wpr5rVEcgy7wM5bTXYFgvlsIGpNwe4A01sqNMIuNr
        1ooiyTs0Cg8yGImhVSKF1jvWZ5bnSJwsEJ4Z4J85Lw==
X-Google-Smtp-Source: AGHT+IEYouaMAJvx5EfhLjs+tGxoRNrvzkB6VYRzCHNV+7D0TvsukVBo82R8vCHoEnoj/HOzboSw1g==
X-Received: by 2002:a05:600c:450f:b0:408:3918:1bc1 with SMTP id t15-20020a05600c450f00b0040839181bc1mr2744992wmo.8.1698420539479;
        Fri, 27 Oct 2023 08:28:59 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0040836519dd9sm1902688wmo.25.2023.10.27.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:28:59 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] regulator (max5970): Remove duplicate line
Date:   Fri, 27 Oct 2023 15:28:29 +0000
Message-ID: <20231027152830.1269895-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027152830.1269895-1-naresh.solanki@9elements.com>
References: <20231027152830.1269895-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant/duplicate line.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/max5970-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index 56cc56ae63b7..bc88a40a88d4 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -584,7 +584,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	i2c_set_clientdata(i2c, max597x);
 	num_switches = max597x->num_switches;
 
 	for (i = 0; i < num_switches; i++) {
-- 
2.41.0

