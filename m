Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743EB753E19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjGNOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjGNOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:52:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF426A5;
        Fri, 14 Jul 2023 07:52:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so261540466b.2;
        Fri, 14 Jul 2023 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689346352; x=1691938352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+Y7J/CfROpAWdo0NFVfodvbCSxyNFMpV5vaNCFKuEA=;
        b=HOCxu6W8gCA+Z01yLdgRwWPbWKx21vPpdKDTsF8DWYDTpqcmP+I+Fb41hjdLrvJzpH
         O+EkcijxxzmjHTjFRv6/vVusSnJ6Ftu6akOZYMon4nM7zLkbEe6Mq3io/s5QywRnUPAE
         EC/vlnTighBJXrdlTmrcfZr9wRQCvv/NsASzAvII/dnkMkMYYUpZWnV9VfRkD/7O3jU6
         jKFQwztB5HTmpbcSW1zveO8+7gsir1+ti5n91HhzxeIxviEocBWBf6Xe3/8AwjuK3AjO
         cQ48CvSOOnIOn+++QhjPSr3uOhQt2x/aBJzQs062IPauFtc04VQycNxXuKGBABt10GTe
         ASwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346352; x=1691938352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+Y7J/CfROpAWdo0NFVfodvbCSxyNFMpV5vaNCFKuEA=;
        b=QuiSRQrScEe+boGE0H/Y0sHdDek+gPjg1VFzsif5pttlKd6M7Ur2CAGzUGGr4Q6dO2
         3WASQPGGGTE1TpLHfPFl4qn/9QDAygufBNUUwftvqKXVFvEbSMuB/OqPt0xtPH4sl3z9
         m0WsK890t5ImUB8fSVVJaI3R624tbCsmyA3fsjRLa9Ke26o9nE8NZ2Nlxy7svK3zpBc5
         u8edcHKk51bfzV98iofbGw2ifIAZlb1XFtCrXjfLTfFIqjO/1gB6YzawzUv3AArSLEU3
         GDsVnlCP+o/eB95VhjyBK+jbzYPKFmDBj+G5C2dgf/7zZIu77HNMnd94Ko1QEVR4R0r1
         N36g==
X-Gm-Message-State: ABy/qLZZ4RarD0IPqa8ijDHg2DxEBvoCu4Vruhc5EcwlSMFY9raCCp8D
        pz1HhrmFRs3huV8BYFWCrh4=
X-Google-Smtp-Source: APBJJlG7OWa/0j2mFZ3Jz/CdSQr9e0vGXSmQRb7+u9Nnx2FGDHPrlREDkcmjngmV4/ockafeBw+Kbg==
X-Received: by 2002:a17:906:b7d5:b0:992:c774:9415 with SMTP id fy21-20020a170906b7d500b00992c7749415mr4430305ejb.63.1689346352457;
        Fri, 14 Jul 2023 07:52:32 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090680cf00b0099251a40184sm5536348ejx.99.2023.07.14.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:52:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Gupta <sumitg@nvidia.com>
Cc:     bbasu@nvidia.com, shaochunk@nvidia.com
Subject: Re: [Patch] arm64: tegra: update CPU OPP tables
Date:   Fri, 14 Jul 2023 16:52:26 +0200
Message-ID: <168934632798.2822346.11688804206324171987.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713133850.823-1-sumitg@nvidia.com>
References: <20230713133850.823-1-sumitg@nvidia.com>
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


On Thu, 13 Jul 2023 19:08:50 +0530, Sumit Gupta wrote:
> Update the CPU OPP table to include all frequencies supported by
> Tegra234. Different platforms can choose to keep all or few entries
> based on their power and performance tunings.
> 
> 

Applied, thanks!

[1/1] arm64: tegra: update CPU OPP tables
      commit: d5b9d25d3fb6f63614ee00104f16e099e3497c65

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
