Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74F76F5F3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHCXEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHCXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:04:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419D198C;
        Thu,  3 Aug 2023 16:03:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so179375a12.2;
        Thu, 03 Aug 2023 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691103811; x=1691708611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gfB5p3kRpBivbHYK4HRVuajZlERtQJzXdWJ25BRbik=;
        b=cMH4kHq7Pva3x8dCkDZhimbqURQsYQN+ZCqI6vu+9FwzPXD7i3spF4pZLPhgtKgccr
         J1hzL28DjJObF8nvTfgQucdy225noVbtWXaUf197LP9E6HPD+Wd7he3GQu0nqxuHcfOG
         OUtBnYh9MHLyjNVvUaMGVjzBoMDvxGfSN27Xq+Hk5cJtOaRENYNh8d97yBbkQ8M8QqCx
         F2yFz7FdtY+PEsE0F+ZpLHXY/b01rSXbrmFEGLViwStUJbrZQKw3Un6NzDkiwTmDFwE+
         vCXaViadQq94qiX+dOAHbYPnsXj9M9k0fFhTkRdWDCDlmsWu71kYauTOhIF7YhqGPW7y
         pcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103811; x=1691708611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gfB5p3kRpBivbHYK4HRVuajZlERtQJzXdWJ25BRbik=;
        b=CUnWabb2Vk5so2GDX+fqXLWkihT8jYpNAv0YZIYp0m+f9znGW7hHvFTMp4i3UNuFbJ
         1AbpKW4WtaqcOT6UaEGoMLVBO92H24r1e7hoAPZtdZVh0TmlzyDbFeivWJijOZHu4v3w
         ZFOdCnaZxUnpBBwHELPSsO2uqMFO/AfyA2Cx3G3dkNi6gYwUtO7h9/9sv8N7kqbqka6A
         KdlDKBjhJPQmtIdIvGPqpl/XWYujQZhiyjRSAzN4DJbB2MkrcAfkDiZd9n40lRNMCQXb
         HY9Zs/h27zeovaHcfNtxd5tZlIPR7aug8gaByGQkUFJxyqCtXDmZVQBdPKCbnaoXl9AY
         DdzA==
X-Gm-Message-State: AOJu0YwVtwaSFDSe6vOnokBuXNMUw7Nntqxn1aq6rwJBhsb6Yru7qwta
        a6B+P+1BzipuDToRbqWgivc=
X-Google-Smtp-Source: AGHT+IGvjBU3bxLzbsm09R9c45orgIeqo6snaXMaan1h7W0xVECnryW6uvtgpU1ufvc8Uh7sx3dHig==
X-Received: by 2002:a17:90b:108c:b0:263:931b:bb5f with SMTP id gj12-20020a17090b108c00b00263931bbb5fmr98860pjb.14.1691103811297;
        Thu, 03 Aug 2023 16:03:31 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4.thefacebook.com ([2620:10d:c090:500::5:e60a])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001bbb598b8bbsm372349plg.41.2023.08.03.16.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:03:30 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
Date:   Thu,  3 Aug 2023 16:03:21 -0700
Message-Id: <20230803230324.731268-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
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

From: Tao Ren <rentao.bupt@gmail.com>

The patch series fixes a few entries in wedge400 device tree.

Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
by wedge400 dts) to make sure spi bus is consistent with flash labels in
flash layout.

Patch #2 enables more ADC channels in wedge400 dts.

Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.

Tao Ren (3):
  ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
  ARM: dts: aspeed: wedge400: Enable more ADC channels
  ARM: dts: aspeed: wedge400: Set eMMC max frequency

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 +++-
 arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.40.1

