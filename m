Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82107EC3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKON2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjKON2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:28:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192B18F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f6efd64so9013811e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054896; x=1700659696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwN4XVt8yK1X3+YfAI5MPsrSuan+JzWxqjLblP1tQKk=;
        b=U8G4Uevfz+kHk0zZH4Xj4k/HqAagC61Z5A7roLUdDSoeAGL83SRc6bJWyn5Tl+tQ8c
         Lmpf6x/qr6bp39utb+XPzTKWPtsZxcwMHKrr20ENEReQH4tDWpx56C8HRLUHCiw/PZOm
         PyYmYVYywVXySeZsW/POAoHjIGBpaUtZFg2CsbHc9UTq2m/te0/9DcnJ8J27iQELwO/x
         eBU31l7ADziA4V6WCPqtwTTd6UKL2M3+csZO7kj0m2RcPW8H3oD4IUjL/YFDbD1kuRCA
         Jbb6+OLtn7d0m6lYlAod08sVzg7tglDPlMVWNZjh13WntC8qXUyNnqprOoPRLznQ1ir0
         XjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054896; x=1700659696;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwN4XVt8yK1X3+YfAI5MPsrSuan+JzWxqjLblP1tQKk=;
        b=fQD8IRx0o4Tm9+wm7BkPkiGKI1Bdv37fGeYEICFcImrrlHsHQ8GzGxvoPYfE9lpF0h
         +Rpiu9on2/9H1FuQltlVvQpCEOMeaSAX2NiXJGBtmA0FFR21p14AUvn2KfA31s0+oEmr
         Knd7yTLTGCO1WUTQVigHWj1mjYTKPDSkQlCDVW7ot5vJhapVFjn0kd8auvIzkgPHpLQX
         5QsOasu5+y4og+CDaWagxf1pKDSfnAZLwGkTuBplrBW3DC7YLFnOPJ5Dn9iJK4c4isQ3
         g4UM3BexySy7bwHuEA5/o5NJwqDbVtZjVBiLIfTpkbkX7/xwTNZtljamD64z3ARkohOA
         XtfA==
X-Gm-Message-State: AOJu0Yx6XHD2aHRlaXf0hUcJm+xO8vOwINOoNoSLkEk61fAs97TY4vKK
        CJp09DI0292KsgrH1+0DCDmrrg==
X-Google-Smtp-Source: AGHT+IF6FsX84+Bpu5NsuR9YTgjgvPm5Ii4b6DzTvo5LXdZ+KTsK38zulfyHnqY8V8cYq+V7VMdbJg==
X-Received: by 2002:a05:6512:3e1e:b0:509:4b8a:b65f with SMTP id i30-20020a0565123e1e00b005094b8ab65fmr10675082lfv.60.1700054895757;
        Wed, 15 Nov 2023 05:28:15 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] arch: Virt to phys to static inlines
Date:   Wed, 15 Nov 2023 14:28:13 +0100
Message-Id: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3HVGUC/x3MPQqAMAxA4atIZgON/3gVcdAabRaVtBRFvLvF8
 Rvee8CzCnvosweUo3g59gTKM7Bu2jdGWZKhMEVJRDVG0YDhwNPdOKl1GJQZqWxn27Wmapggtaf
 yKtf/Hcb3/QD/9wbVZwAAAA==
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures have been given patches to switch their
virt_to_phys()/phys_to_virt() or underlying *pfn etc functions
over to static inlines.

Some patches have been ignored or have no maintained arch
tree.

This set includes patches that I suggest to simply be applied
to the arch tree so they get in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      ARC: mm: Make virt_to_pfn() a static inline
      Hexagon: Make pfn accessors statics inlines

 arch/arc/include/asm/page.h           | 21 ++++++++++++---------
 arch/arc/include/asm/pgtable-levels.h |  2 +-
 arch/hexagon/include/asm/page.h       | 15 +++++++++++++--
 3 files changed, 26 insertions(+), 12 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231115-virt-to-phy-arch-tree-137bc87046e1

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

