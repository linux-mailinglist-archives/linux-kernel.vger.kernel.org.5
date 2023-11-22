Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA77F54D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjKVXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjKVXcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:32:52 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE21BFE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c115026985so363361b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700695935; x=1701300735; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLUpOssAYTVzeEiOhoYcENie1wzsLU/orNHzIAqK+E4=;
        b=cihpBYripcQ61aN1odvEREFmajjISofm+DaiaSgXGjW4sQM2crnq1puLttRExcOyj7
         yEW9NsWH98urLSF5yjQ5+2ksza1rOB4QBXu+PHyX/BjpBxaEYh9EuvQUfVvbN107+YeJ
         FBgNiM2YzIYrdE8p4NZOSYmBiYsggat85YDYoSRjKilEWZX3eiIEAJ/1iVN8x4/rNYKa
         Uo9CkpN58AGGhacKiYYDUSyrSlsYKmG+XIwFPE66jlE08i10LtT0/CcPhUC48lj507PM
         WEtWpJhRPkvVMX3J1q1IFJwdm32Va+TsNg+E7I1RnF7SelVhLHlO18ZQFG9NIeuUVQCh
         gHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695935; x=1701300735;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLUpOssAYTVzeEiOhoYcENie1wzsLU/orNHzIAqK+E4=;
        b=uiqNjwtJk6eyKLG7gCGl/fPoZeCSSE8Ex/rBMGdjOnmdyc69O/w6ZqWriD/iEnJtd8
         ijvOcaoN4vTOChj3c/4FZgjdf9ncl+q6iq/Ndv59oXcnunnHKJRSd4A5kZjs8fdsQNFz
         UfebvnwrM8CgVs12Np2aQ8Ms+Y9zwDjcTLmJcymqKYCyYOaUvya1i3E1xz5J6hY3FYw1
         w+tYeBVRqVtjcteOFjxXtX2VozEUjr2Mkht1gcuw94rVWJJRUeKa+AVn6EzAIUy256kx
         y4UuDhy3QCCToQlgV+PgLuKg76+L0ye0tKN/9VsA8KvGlmNhRWSFmYgFY97lCPbiUKoJ
         Py+w==
X-Gm-Message-State: AOJu0Yy2TrYLy3MVrQCaHGl3n3SyC2B0tzCbTmH9nMq1iGtxkhjeWA+C
        MsgVWgKbfDXpPeqX8A/2Qc6mqA==
X-Google-Smtp-Source: AGHT+IFcwCrbHmI2/Si3lJWdyA1kfWGBgQhRHqzzJtYh+UpNZfyRxdWJNB15WIFzV/kSsdIDFDfSZA==
X-Received: by 2002:a05:6a20:9e4d:b0:187:9521:92a7 with SMTP id mt13-20020a056a209e4d00b00187952192a7mr4359181pzb.18.1700695934863;
        Wed, 22 Nov 2023 15:32:14 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm22603pfd.121.2023.11.22.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:32:14 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: Fix issues with module loading
Date:   Wed, 22 Nov 2023 15:31:40 -0800
Message-Id: <20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyPXmUC/4XNSwrCMBCA4atI1kaapE9X3kOkNMmkHWwTSTQop
 Xc37UoEcTX8A/PNTAJ4hECOu5l4iBjQ2RRivyNq6GwPFHVqwjMuGOMZnZx+jNCOaK9o+9Z4gDQ
 pl0UnJC8KWQBJxzcPBp8bfL6kHjDcnX9tfyJbt3/JyCijxpia6YrXjVEnj9EFtOqg3ERWNfJPi
 f2UeJKaKpdGaVGWOXxJy7K8AWB7seQJAQAA
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695933; l=1054;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vrpXxvCGGH1YSMvQ5Jqe6xeNNZN1b1oOFmQ9hFvEp70=;
 b=H+vCsGlFIDAhGLcJCyOavGWzQy2EFY2oZAna2dyq5R2q7g2O6wwED3KreBmoVYvsgWxcxXjlp
 dRS+VBwsxmcB3uzdrkkC12s/Ph3jvsZ6CLb+KWMBb6gQEVxE0y2rRgT
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module loading did not account for multiple threads concurrently loading
modules. This patch fixes that issue. There is also a small patch to fix
the type of a __le16 variable.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Cleanup pointer passing (Samuel)
- Correct indentation (Samuel)
- Check for kmalloc failures (Samuel)
- Link to v2: https://lore.kernel.org/r/20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com

Changes in v2:
- Support linking modules concurrently across threads.
- Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Safely remove entries from relocation list
      riscv: Correct type casting in module loading

 arch/riscv/kernel/module.c | 97 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 26 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231120-module_linking_freeing-2b5a3b255b5e
-- 
- Charlie

