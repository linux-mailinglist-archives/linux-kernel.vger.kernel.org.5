Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC97D7E08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJZIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:04:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3CB18D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:04:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b95622c620so99961466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698307454; x=1698912254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbK71PpiWagt9UYz0JbsieBVbIawXnFxgcEDdqiAu9E=;
        b=N+JCDK3zjrIvVZwEs6CDIPcAuUKBYA3JIXP6OQ3mIGgZ1idBzqYBUs4IHcJLUw6x/Z
         aqnKDBAMGs5C1mhYaRrdKaezO6W1Ai7oicGOI4gU8qWCpLs5X5gpnjZGLFZN+OUND+57
         Fecb7jJHwDvjhP1hgMIwSTb3A+tDtacbewlUEn7x6yIAIzA0O11TpOq2DdQmbksq0v1Q
         CCK7Qg2nH0Jr/96VwrPQhMCHycLV3F6R86UqybS5aqS8XOuGFeZKUErXsgZSrdCohmE7
         zO9B81c0hPU7YaaI3ghN39mub59FKOUCdgTG6UMLa+t7+2DwUNmPIIYdSRkDgxn+Zjl8
         giEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307454; x=1698912254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbK71PpiWagt9UYz0JbsieBVbIawXnFxgcEDdqiAu9E=;
        b=kC53QHhjME3LSzS72dPmLM9cyVx3M9XbATvqiHCU+rNXSmdANZeRCwCZqEqcvXaB4v
         WVAyNafBV9WRsocJAbqpGHXLAbrYQ9OPq/WlOm8ZIBaUDLLSak5aVGnAd+dHbz2+yv9R
         6VUytTfanHClEON6Yghd6tUONC4KQCVim7cJRRZS/6nh6VXBZODV13+z+dHExt3Us7K7
         JOfNYlO/FKMjSzn4m79HlHYBQg7TEnPTv6/wk1++Jd4NpsPRVxt0Bp9XEB95jltVjHoo
         0uv9X4w6veBx3NeZ8GemBrKvF3FohaacrMqM0fPu4vdADc0XO0KksDnMjKMt+Q+lxNJo
         O27w==
X-Gm-Message-State: AOJu0YxyRLohM3CN5AujriaZeec9JinSp/OQmzO5yj5sHKAF703Z7Krk
        YCr7sdjndiLXt3tiifKxXUc+Nn+9wAH2c3RsNFA=
X-Google-Smtp-Source: AGHT+IGczQoc0VJUOpLp895odE4PrFBDTPh1GhOz4xYwJbIkxPSDMq7kjn98gv72AVIcNsPQUVgEKw==
X-Received: by 2002:a17:907:703:b0:9b6:50cd:a222 with SMTP id xb3-20020a170907070300b009b650cda222mr14579263ejb.54.1698307453983;
        Thu, 26 Oct 2023 01:04:13 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709065f9300b0099e12a49c8fsm11313448eju.173.2023.10.26.01.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:04:13 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/2] OP-TEE FF-A notifications
Date:   Thu, 26 Oct 2023 10:04:07 +0200
Message-Id: <20231026080409.4149616-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds support for using FF-A notifications as a delivery
mechanism of asynchronous notifications from OP-TEE running in the secure
world. Support for asynchronous notifications via the SMC ABI was added in
[1], here we add the counterpart needed when using the the FF-A ABI.

Support for FF-A notifications is added with [2] and this patch set is based
on Sudeeps tree at [3].

[1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
    commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")

Thanks,
Jens

Jens Wiklander (2):
  optee: provide optee_do_bottom_half() as a common function
  optee: ffa_abi: add asynchronous notifications

 drivers/tee/optee/call.c          | 31 ++++++++++-
 drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
 drivers/tee/optee/optee_private.h |  9 ++-
 drivers/tee/optee/smc_abi.c       | 36 ++----------
 5 files changed, 153 insertions(+), 42 deletions(-)


base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
-- 
2.34.1

