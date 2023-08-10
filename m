Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80177719C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHJHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHJHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:40:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1512680
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so9335191fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653231; x=1692258031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JofiBfwzy3kjUFhKUXLWtoVye53MuyuBLLBCjo+WoM4=;
        b=hVft4joyMLn4SOCV/gtcK0uGplfoX/ab/N0cUYfJMXp0BuUvhnB+C7Es+DxTERT8YM
         sTab+94QLh4XkVOPFt9+WZcH3GSTvaafD/UTR/XdqyXdp7ouQMxcdlMxafmNE7yC+veY
         eYZjZ495+Ebk7od3VMGnHXe0V99K1WAGHKBKYYxDGsoBx2QpHVyN5XoUQo07xv7CfN4F
         z1AA0a947XMRdz+iXTM2I2W6J4sop9DIEI0mhpAA8qRXWz7/qd7GceCKzn0o33K1f9pW
         qYFzHuvTXx9dChjEZyHpAJTcRidkPDl5tnY+TEWjo5vsSI8eZExn3/tjNjXYPUP7StVS
         TPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653231; x=1692258031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JofiBfwzy3kjUFhKUXLWtoVye53MuyuBLLBCjo+WoM4=;
        b=DFvItBHbyzsudtuTkBS+4f7avVuMtZhTZhEeT6pWDPgjoR9bK33AFQGRM8PtUS+TZY
         QZQayFnC5vfnqqkATUQgaREReThQI6FSuReqqERHaC/6GMSsAH6YThuYSM2+EnMZCwI5
         vMcKsnzGE+sxA1r8KZZlwac+2yCrnkISvpAmtIUiajbx6eOdegB+xjwimdIL/CW3ne+z
         keQ78K3PCUJKVO48KjmKN/glVCnIzOlAJ8XtaTcWM4Iuqmn9XEKBo+WbZAhHBrtSkTBK
         8g326wDRP0geNBLkUQgYpJ7fdY6jljwYd/o0WoJYWMajrom3sodvBJrq67ckqD4e/R/6
         n3mg==
X-Gm-Message-State: AOJu0YwWMZHMZ+RzQxqeDv1JHXFNJVun9cvrybI1WPR/hintso+z1Ute
        r8pludhq0NGyB0+9tJoKR6MKWw==
X-Google-Smtp-Source: AGHT+IHhuZtE2A2+8TNudV6c2QBTvCPnsZWQI9CBK0LmA4TtloLakTlHFgWjUJXu6Nbo4q2taImjKQ==
X-Received: by 2002:a2e:9b16:0:b0:2b6:9afe:191c with SMTP id u22-20020a2e9b16000000b002b69afe191cmr1386270lji.7.1691653231072;
        Thu, 10 Aug 2023 00:40:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9844000000b002b9ff8450aesm234500ljj.91.2023.08.10.00.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:40:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] csky: Convert memory accessors to static inlines
Date:   Thu, 10 Aug 2023 09:40:29 +0200
Message-Id: <20230810-csky-virt-to-phys-v3-0-f443cd2fc050@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2U1GQC/33NQQrDIBCF4asE152iI0TtqvcoXQSjydASg4o0h
 Ny9JqsWSpf/g/lmZclFcoldmpVFVyhRmGrIU8Ps2E2DA+prM+QoueYabHosUChmyAHmcUkge82
 tUCiEN6zezdF5eh3m7V57pJRDXI4XRezrP60I4NBZhcrr3nn01ydNXQznEAe2cwU/CfOLwEpga
 5Q10rfcfhPbtr0BEUIZXPYAAAA=
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the virt_to_pfn and pfn_to_virt macros
into static inlines so we get proper type checking on
the pointers passed in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Do not return const void * from pfn_to_virt(), return
  void * so we don't case a mess.
- Link to v2: https://lore.kernel.org/r/20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org

Changes in v2:
- Fix compilation error on pfn_to_virt() by more casting.
- Return const void * rather than just void * from pfn_to_virt()
- Link to v1: https://lore.kernel.org/r/20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org

---
Linus Walleij (2):
      csky: Cast argument to virt_to_pfn() to (void *)
      csky: Make pfn accessors static inlines

 arch/arc/include/asm/page.h  |  2 +-
 arch/csky/include/asm/page.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-csky-virt-to-phys-3d80c17211f9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

