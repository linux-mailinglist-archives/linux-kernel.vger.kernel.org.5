Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0F7E3849
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjKGJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjKGJys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E37F10C1;
        Tue,  7 Nov 2023 01:54:44 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577fff1cae6so4026139a12.1;
        Tue, 07 Nov 2023 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699350884; x=1699955684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEmyl1Kghqf1NFmsUhneaNM1whAWfSEyfRV9qa+1zHQ=;
        b=CFdWkzpf3wZ27aN341Tbi+0+ZHSj/dYvjws1rWvzLTbfrVfHKP0YrjooTW4xH53MpZ
         +OaRSpOBjdTuL6qrEAwgruv6BSU5lLm0yADAfBjkj8irclTgtq1Mv26OoCa4L/RabyRy
         aR26IfeRG1skHHdN31tt2AC8yYp7E3Z10Omp/g25qBil5YpLGMXwneQ2/daMFPYlbL2W
         Ltv6/UZ22h4C7Ca7ivi1UIoePrCbrkATRe0gwNkML2I07N4GjGurVrsXmYhjGlBfLj4i
         vTRdx4SElkvF16FM/+Miu+m/O3+LinqPCGy5GWXgK3+pjYmTJFfehaKUBxVj6xBgJYO5
         Z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350884; x=1699955684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEmyl1Kghqf1NFmsUhneaNM1whAWfSEyfRV9qa+1zHQ=;
        b=BNU8JwC3beRox6dRAVaBzApQ6e4EJc6ynt9pcWyoxGqpqS1NiotK60o8Gp97r8uL2u
         b0gLsW4tmFSon4vYacru6jPt5c7F7FEWF9CgNAOwqyYU/fln151RvcPZQaxPcryTSPJa
         ygbPE+5rGHukY6M+bcaesVMmsov9bl+HgzurCoTBuIo+AV7q1ULo8HS6rOyzntFz/9v6
         24lvbfM5vZnBCSCX59vlDfI8/Hnp0crGSpTNNImiwmRBfJV4nCzfR7s3VFG7gvcosgN6
         8Pqlo3xHrF7hoqZU26oOcaEhWsNvuN3iAGmorPufonOU9PUkhLp/cgKvm4bPR0Fv4uJ0
         1mfQ==
X-Gm-Message-State: AOJu0YyHk45EG7sEsxQzw54KqZ6rWvmtFMq9BfaFTbWczJZkZo4HLAIN
        e/JoSDEV0HEoyqEGXjkDHsm0EiqnQBeNIg==
X-Google-Smtp-Source: AGHT+IHW9l7NcYEnjIx4poqeC4I1J+q0SioVe4wPUZ4oRzT2558y17sK1SJCI4ofgXUfHpKzdHHiTw==
X-Received: by 2002:a05:6a21:6d92:b0:17a:e981:817e with SMTP id wl18-20020a056a216d9200b0017ae981817emr3175153pzb.3.1699350883922;
        Tue, 07 Nov 2023 01:54:43 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm7106705pfm.142.2023.11.07.01.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:43 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 0/2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay
Date:   Tue,  7 Nov 2023 17:54:35 +0800
Message-Id: <20231107095437.8724-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Summary
=======
Due to a flaw in the hardware design, the GL975x replay timer frequently
times out when ASPM is enabled. As a result, the warning messages that will
often appear in the system log when the system accesses the GL975x
PCI config. Therefore, the replay timer timeout must be masked.

Patch structure
===============
patch#1: for GL9750
patch#2: for GL9755

Changes in v3 (November. 7, 2023)
* Split patch in two patches. One patch for GL9750 and another for GL9755.
* Add fixes tag to corresponding patches.

Victor Shih (2):
  mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
  mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER

 drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.25.1

