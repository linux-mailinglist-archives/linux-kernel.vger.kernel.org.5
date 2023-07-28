Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D7766B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjG1K4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjG1Kz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6091BC6;
        Fri, 28 Jul 2023 03:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6887962089;
        Fri, 28 Jul 2023 10:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD6C433C9;
        Fri, 28 Jul 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541757;
        bh=3R+8/wM2ulYNk2MtuXco2c6ZZXo31f3fGi0FFQXQTvY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dcYOzYyoMAAiKlRjm3cmcAL4eOHG1MX606CuHCNP5O4pyrhXyPTa+4FoqaPYE9tVH
         v/I7jSCxvTHUDABfYc45rN1O71o/GfO58kHddVZaBHi69OREa7yI2bCYWDeGBRykbF
         4Ook/UhMYwenYi6lGSD5Oul/d9e43wiPA5EAiIKYsp2SYVlqqAjZTcPgjaDUnytifk
         ieqrpYlYoEJg9O8J4OGI46iHpme2+L1tJ2YbFQk4DBxX2VWEyD2ht1QmlrBcJLTTsV
         n25Dks2wbKlp9eqh30crYW3ZxFtVMFmjUUHclWIW3SE7BUlYqpt0iqWIr1lXw3IWK6
         tjr++A2bEjzMw==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Cc:     sboyd@codeaurora.org, srinivas.kandagatla@linaro.org,
        quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230720071330.50382-1-dg573847474@gmail.com>
References: <20230720071330.50382-1-dg573847474@gmail.com>
Subject: Re: (subset) [PATCH v2] mfd: qcom-pm8xxx: Fix potential deadlock
 on &chip->pm_irq_lock
Message-Id: <169054175537.336560.5220328545584873141.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:55:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 07:13:30 +0000, Chengfeng Ye wrote:
> As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
> context, other process context code should disable irq before acquiring
> the lock.
> 
> Since .irq_set_type and .irq_get_irqchip_state callbacks are generally
> executed from process context without irq disabled by default, the same
> lock acquision should disable irq.
> 
> [...]

Applied, thanks!

[1/1] mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock
      commit: 213f9a4eb2f712866d471d18ab1bf664c71183e6

--
Lee Jones [李琼斯]

