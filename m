Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58A774B97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHHUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjHHUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A06110E9FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:45:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so49645635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513147; x=1692117947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKaXpSlwUGOFKYnA0/ujGgP0b2CVx1lfhbc608RRtk4=;
        b=AJCi6xZxL9ZGGAzt8y1R8enCqQgZuK6TMlP9v7+QISt/nuuJ2fgOtYwKDqKPV9b+5I
         Slu5etz8yrr+TlmDb7fS13ShjIThB1lkgiFWUjiZV95BAwLhY6+/6ghvLXZJHMkdlrLM
         vbe7Wshb8wpstKDUbjY9om0Yi3eVUXeG3UPVTZhW7Y9yNakLWHOuIfz1oVor5JF/h/4M
         uTSGh8L/bvMnFP41I90Z/Hb+ZkFmmyeK+M57SgoM5xWgh4E2j6Z5FnQGcjH02lbj5Ugl
         ZNsL2ZtfR0zjvKyfcD7U5cRGZtzaVXe8l1lUBKNtcKytkqmxiJv3iIgQ3vqJ9+AgH+eF
         Vj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513147; x=1692117947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKaXpSlwUGOFKYnA0/ujGgP0b2CVx1lfhbc608RRtk4=;
        b=Ir9C0B3iFnLkwka6iojwa1PxAm0+zbS5CGhIRq/DZVEbu8LAaSQMfne9BrIjdNnjeC
         vlS25d3VQbv2+c4kCRlFPE9qk2TDAdh2VXFF2D8NsVGp10iCaALqQNGcMc1/mJN/S8Qw
         jtmNl2ayXg7US4fLQOwbxbqvoebLjuP9xhZtVHkBoODing4YT+Qt/7YRGc/gSSOYaEXK
         /n0YnpGzDKSkUIVDI02wSPE1aPK7cxax0Y89gjRUPXvynP1sgvfqSSNVFRB0m/LMKEMc
         si7bQ5kJFYKwejRzVfcteejj2L2syepQZH0+bcvl/2Mo+/FKgjkHFQaY3AvkSb6Je6QN
         svHw==
X-Gm-Message-State: AOJu0Yx2I6Twfa7FAlGpTAjet8n39MR+2C4n2kYqayuxtZPQJeSZ9SFc
        wVf7vhb/H75LjdTWueG6jMKRkOsNvf91dNAXekg=
X-Google-Smtp-Source: AGHT+IGwuIaXMoIESGfMjXZqvgjAKYGfq+7lPk9/u4u6+4RfcqSnKW8XNmPB5gwM67RaOJssLaTogw==
X-Received: by 2002:ac2:5b89:0:b0:4fb:7888:7e6d with SMTP id o9-20020ac25b89000000b004fb78887e6dmr7043859lfn.46.1691483162463;
        Tue, 08 Aug 2023 01:26:02 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] csky: Convert memory accessors to static inlines
Date:   Tue, 08 Aug 2023 10:25:54 +0200
Message-Id: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABL80WQC/x3MPQqAMAxA4atIZgP9GaxeRRykphoElaYUpXh3i
 +M3vFdAKDIJDE2BSJmFz6NCtw34bT5WQl6qwShjlVMOvewPZo4J04nX9gjaxSmvO6N16KF2V6T
 A9/8cp/f9ALLAmCNjAAAA
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

