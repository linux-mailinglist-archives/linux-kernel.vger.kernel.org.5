Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD54375305D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjGNEKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjGNEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:10:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFE2719
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:10:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992ca792065so193587266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689307807; x=1691899807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQeLL7yucbWziupvS5Xb8lpNweQHJYTP0AzdJBC+cOA=;
        b=JJbN3WNatS/+7/otmtG1ut5N43O0WU2oCSGIbfu0MUL9+HAYUFhHYtD6qLcvvQpRjJ
         7krgBcG4KOYrQPYiCqjgOv+oEduSBAcEhiqyPlAnq0+6v47zZbVX1/cHoDjgvlz4bjog
         9naz+BbioEiN1MkvMss7grPLAVGgpPwxFaHYqYh0me/W4rTe8iNUpQ0OgDJBPp7lQFPW
         2YZfUpFnycPEnd8NersiU4HY7MB6+h+eBRT3RVnvuHlMscf5zKBe47YwQOo33nAP8F21
         VqG6PJOkZGw0Pozl6Z0Zbf9Z8jLWiXyQaRNgui5xUynRluhQ/LrhbAFx18UroHOSgBvK
         ZRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307807; x=1691899807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQeLL7yucbWziupvS5Xb8lpNweQHJYTP0AzdJBC+cOA=;
        b=g2bDXYcqeKLGMmERMEbBU2FA6pMVS9CCwYxx2eHQRHtZS4tnHDCgzcCBUY8Xx3kFKS
         6LF3hGZvKR89AjD9w6QFfPgiVu8r/9Tv7+e1PW9EYJgc3EOCW50s29lZdHjrzWghbTx4
         wWu3LVLl+E0puQPstw8+RNDoOpuBz3/xKp3u4Y8sAAjCmfu/Uaq3vvqMkhdPDjBon45Q
         SoGDPoxqdjPeUccbtEXIP9Lap7mKqb3SG58k7Iiho5K9nn5IjZkDFuYylP9jVZHDdc67
         tL5Uec9+Qs3fiVLEQa051JeE7krOV5Mn8a2pOjgJ2BWLO2gLLYaMXpvCEbivBarpzHvK
         dJig==
X-Gm-Message-State: ABy/qLZE9BjwV7tix012KbQmSXHfyaWr/YnsQMbEc6fe8YddMZXVixw7
        +7NC226/HU60Kr/fPbFYMQVzuA==
X-Google-Smtp-Source: APBJJlEvSuFIaTgobSWO26XSkfmzThp3Re5ekkZqgTD13PdPbzSAZZZZUjDhEkH06V7JpD7uKAvieQ==
X-Received: by 2002:a17:906:7a0b:b0:994:4ebe:7a6d with SMTP id d11-20020a1709067a0b00b009944ebe7a6dmr357321ejo.19.1689307807456;
        Thu, 13 Jul 2023 21:10:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ss14-20020a170907038e00b009926928d486sm4818308ejb.35.2023.07.13.21.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 21:10:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     treding@nvidia.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bbasu@nvidia.com, talho@nvidia.com
Subject: Re: [Patch RESEND 0/4] Tegra234 Memory Interconnect followup changes
Date:   Fri, 14 Jul 2023 06:10:04 +0200
Message-Id: <168930776405.4539.5215502650424893821.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621134400.23070-1-sumitg@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2023 19:13:56 +0530, Sumit Gupta wrote:
> This patch set adds VIC, NVDEC, NVENC, NVJPG, NVDISPLAY clients
> of Memory Controller to the Tegra234 MC clients table. It also
> improves error handling when some MRQ's are not supported by a
> platform. For Example:
> - Avoid "tegra186_emc_probe" failure if the "MRQ_EMC_DVFS_LATENCY"
>   is not supported.
> - Avoid Error returned by icc_set_bw() in the MC client drivers if
>   the "MRQ_BWMGR_INT" is not supported.
> 
> [...]

Applied, thanks!

[1/4] memory: tegra: sort tegra234_mc_clients table as per register offsets
      https://git.kernel.org/krzk/linux-mem-ctrl/c/01c70c8e52c5579de0c3fff81f81778a570a8643
[2/4] memory: tegra: Add clients used by DRM in Tegra234
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9d0bd0e535953886cd1a1335941c5afbe4d7df32
[3/4] memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
      https://git.kernel.org/krzk/linux-mem-ctrl/c/8fda1018ca68e7b8fa860087e3069c3be476148f

Checkpatch errors (I guess expected due to code move):
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
#86: FILE: drivers/memory/tegra/tegra186-emc.c:215:
+	debugfs_create_file("available_rates", S_IRUGO, emc->debugfs.root,

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
#88: FILE: drivers/memory/tegra/tegra186-emc.c:217:
+	debugfs_create_file("min_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
#90: FILE: drivers/memory/tegra/tegra186-emc.c:219:
+	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,


[4/4] memory: tegra: make icc_set_bw return zero if BWMGR not supported
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3d7cfb8d6142c1d681eb70eae7fb1950b59fc0dc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
