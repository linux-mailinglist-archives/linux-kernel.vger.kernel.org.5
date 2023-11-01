Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C77DDF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjKAKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjKAKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:17:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8DF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:17:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b0c27d504fso5817407b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698833829; x=1699438629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GCfjHREs5pEMf72upJaooTRYe6HV9ikyCsileBJWqEU=;
        b=aVNK09IdJxvTQCHQ+fsccUmEoyhcOpYU/N4CSeLUFEfOTfeZ2lcz7taXsvymPHQ5IF
         QB7aDFdgKu6c1HiJ1CaCUhKBggV+HrS31IkuJEOMtkbr0Pwnn1GAGNd3t9ZYTNNLBbxG
         1Qccdxx0McvW8iRZ/iEft18WIG8Cw1Kdj2TyT65GhsM3rxHpivQ6VKljM+TnrSkKAi9P
         c32UR3gnSA7+/lDEf26VbLLpRvS8VKqnBZh9Y15qGTFE2Fa67/mgIYE9tHgiCA8Pmha/
         zFzf6vyJ+ez2r23MadZD/lJJzwpy4HbIirVAjxe/7Q4PVayH1weyWwaO5Ff8ochGuYzx
         0Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833829; x=1699438629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCfjHREs5pEMf72upJaooTRYe6HV9ikyCsileBJWqEU=;
        b=CNAtXXVtoxtj/QJJWKg+MXYECuns3JPxLN6ZKdmL8YFxjCkztgb786IPNAc3BR+njz
         gNcS5R3p+iI34gBF6/cS9rVA2RwZSQ2f89BK57JkV7jG0zwcWyNe0BEHgP8eRRRE+kb0
         gB2+aOHpYg9soHc8lR6DMYxMvmZdVpa2Tyc4tr5rphi9D0dCGak1s+76zoBiC+EkLpEq
         fUY9kcnU30jdulJw3UKJlLWH/7qiDCN1bgLfCdQvklMZxOtg6Fal8LfJYsFT0chcG5Of
         b0PJhV+gdB8rKEBm5lNwp76LwsqfKPXVC2X9xwSzTp6BaRdTUxpXeLAOXpOjZfxqZ12q
         iT+g==
X-Gm-Message-State: AOJu0YzylD47oA8Y5KdxYsIKw0c98DHLOGc5GWBdEusn1Mp8udpiArjS
        CgosGdznLOchKiz+jgK/FQOxFOE4OPu7
X-Google-Smtp-Source: AGHT+IEjYMUpKpvpCvh+KfUDpQbFLjsINNUjpLZWsNpFXOjr+w4UtkwMZ6r3nPZ3BkLJJ1Y2MtAXmZNgKuvq
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a05:690c:ecb:b0:5a7:b95c:a58f with SMTP id
 cs11-20020a05690c0ecb00b005a7b95ca58fmr63716ywb.1.1698833829577; Wed, 01 Nov
 2023 03:17:09 -0700 (PDT)
Date:   Wed,  1 Nov 2023 10:16:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101101625.4151442-1-mnkumar@google.com>
Subject: [PATCH RESEND 0/2] Add a quirk in xhci-plat for parent nodes to
 specify no 64 bit support
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org,
        Naveen Kumar M <mnkumar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar M <mnkumar@google.com>

This patch aims to expose the XHCI_NO_64BIT_SUPPORT flag to the parent
nodes of xhci for clients to specify if they can not support 64 bit DMA
memory pointers. This issue was observed with a Google SoC that uses
a DWC3 controller where the virtual address's higher order bits are
truncated.

Resending due to missing out some reviewers/maintainers in the original
patch.

Naveen Kumar M (2):
  usb: host: xhci-plat: Add quirk-no-64-bit-support
  dt-bindings: usb: add no-64-bit-support property

 Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
 drivers/usb/host/xhci-plat.c                        | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.42.0.820.g83a721a137-goog

