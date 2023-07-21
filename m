Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE675CBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjGUP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjGUP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:26:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270C12F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:26:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b962c226ceso30402551fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953190; x=1690557990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMIayNAPm5Eq4SXAKjBrCInKrs0jRqX2GjfiDnlxWN4=;
        b=hQtE/A7M+hTh+uZ0Y9RabnX8vSZeLjk89MctwS6+uGSQkI9dy9Wsa+zFf2KPP5z7q+
         AEMd41uxsDekcnl5Mw7owOWURG61Uk5IlaUJ2l+aGRErJLdz2SAccAkJfzt95Pe4YlK7
         eXW2lui6RBvZxGKNgLMScqdRLcr44nWCOwVSRE/CJSvS/ptueYoC5EjyuNt6FeX1DwHS
         05irp/zk8Bf0RhSRQq+/7WBFlHmwlEplZnF2p8cCTJbWN2tKLYJ+Vr6Y2uYNT1A6TLFQ
         PPxAXhGB/03QhzT7Ln186eYeRGGkDkmMGLgmWWzJ4ePfzCJNyOHYcogBvRvz6xXtj0lZ
         /g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953190; x=1690557990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMIayNAPm5Eq4SXAKjBrCInKrs0jRqX2GjfiDnlxWN4=;
        b=RpwmcK8tgbGpUfDdvYO4o0dfdvNvd3GV4I66PCMC39/8LgeFV5Ru0geqWpC+I3P0Mg
         WBPdMcYrGxDoFH8E9FcY9s3i/P6k3Iw7WMbDqATxCfM2egIa76dAJxeDYpXhxlCXNGUu
         fUSkxUIVSi7XNA5mk1cQ2MYHJLadPYcs+cknlM388Ctxyq/X+9kKaLqcseICKuZLMGZw
         7Q2BM7ucAdy+lorTaU8foIfNzYJM0Ukp4w+iUGUnI2qKyrSdNchybBxeDN8lMh0BALY0
         pddEp/n/ivb3MpBXXhHtXz8CHNx7h/FLXr0CelrK1jIwOpGFz36Ewy0f9rFrHF/GoILh
         w7IQ==
X-Gm-Message-State: ABy/qLY7YROFTmObmu9mobwmqr/XX4ba4cPnAFi+vL6J9BVV+RwpUz6m
        KZdz95O1ZbxAF4YgFRYteVMPjCHE7g8=
X-Google-Smtp-Source: APBJJlFY8cE+d5Zmbt+CfairHYcAgwXnk8vlZJKnuEQC65G1Rp1R/9ud5veEhcEu1VBZ5mjcrp5OFA==
X-Received: by 2002:a2e:83cd:0:b0:2b6:efa0:7c36 with SMTP id s13-20020a2e83cd000000b002b6efa07c36mr1666103ljh.21.1689953189379;
        Fri, 21 Jul 2023 08:26:29 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b00982d0563b11sm2287461ejg.197.2023.07.21.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:26:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/6] soc: ti: omap-prm: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 21 Jul 2023 17:26:27 +0200
Message-ID: <168995317239.3656133.18010329002771216313.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Thierry Reding <treding@nvidia.com>


On Wed, 05 Jul 2023 20:26:39 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[2/6] soc/tegra: fuse: Use devm_platform_get_and_ioremap_resource()
      commit: 6674c9808048f28f979fc4c57994d936d477d3ed

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
