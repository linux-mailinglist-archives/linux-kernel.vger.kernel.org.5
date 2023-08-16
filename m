Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ECC77E01B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbjHPLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbjHPLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:13:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3104E40;
        Wed, 16 Aug 2023 04:13:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f94328a4so4330210b3a.0;
        Wed, 16 Aug 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184437; x=1692789237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9kK5DIzApBxuWnbw06RTl4SjwuCEuicEM0Xs3i511o=;
        b=mF5rzaYtzgFfRw4XRRB0D9/JrvS5xToIOKOCT/YArIZvXZ0wx/XKain9gmorBwamVa
         ANsCSqGu6eF13WtiisitonvMt7zMxH/IOQpU6lyuBq/PWIdq+wCwiSTeprAc83nC8q1x
         R9FJ2LgMHySDcThrGFMmcsd+1+61WxWTY7UOX7jl7Hgi9ekuaam8Eu7qIHrUT4VBxs7w
         nchI8nkfig6AcEFkCgiSVDmAQUIoXaCQncjje0kVcfmC/CHlqU3hvOLC+OFBGq3x8CAa
         y0MkFqm3iadklxEwew/IvHwqH9mJqOBhDq37IBF3B4DU/UcPMMUYb/BebW1rrDE7e5/M
         5uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184437; x=1692789237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9kK5DIzApBxuWnbw06RTl4SjwuCEuicEM0Xs3i511o=;
        b=P5pY/L9LtKGGjUXq1n+TuFBi91jPdz0LMaYiIUxQW4HHabpYl6xDVLIBbgkKMr4uNo
         TCCoGJ9LgBADSJWkNnGjmzLERjZcmUZ4CWGt1gUt95Ap7qC+cYzt51KPKZQvWoaESqH0
         8p+Eyw6UttocASVmf1dnVoh37KiFLspfmni6BSicFWuLWoznrDQc/SDqwKR71DcKmZKy
         MpLOWYqWuk8VtDuzXjybUyUki8hpIhJsuBHyAQBezns8Ub34fsRlsQuyriT/QQm/OneD
         rxKiEYNDyYoTffOInEmcjnZUiuwb/2t9ozjERmOUCrFmMjYuYyz3qyHXJGZlGuyMtOlQ
         tWWA==
X-Gm-Message-State: AOJu0YwY72j3F+Lavhve3KRqGQN4mdbvbZX+4dePTyL0MwDioYEzJG3u
        OjWGOCtXyP3Kdm3zvqKvCXU5DG89RudYha3L
X-Google-Smtp-Source: AGHT+IH/bC5k0/+M6D3V5ZG8pBcxMj4UoZOvrsgj/Th3yyxER0TsvysF6O71BWUZFxJ1mlTD/ZeWPA==
X-Received: by 2002:a05:6a20:7f84:b0:137:c971:6a0c with SMTP id d4-20020a056a207f8400b00137c9716a0cmr1705965pzj.31.1692184436961;
        Wed, 16 Aug 2023 04:13:56 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00563e1ef0491sm11750627pgn.8.2023.08.16.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:13:56 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Date:   Wed, 16 Aug 2023 19:13:10 +0800
Message-Id: <20230816111310.1656224-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816111310.1656224-1-keguang.zhang@gmail.com>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new F: entry for Loongson1 DWMAC driver.
Add a new F: entry for all Loongson-1 dt-bindings.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Improve the commit message

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8700b009e22..4621facb2cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14313,9 +14313,11 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
-- 
2.39.2

