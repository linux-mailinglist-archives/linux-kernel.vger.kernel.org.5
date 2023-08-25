Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FB788438
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbjHYKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbjHYKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:00:42 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6B1FD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:00:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5921a962adfso8890127b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692957638; x=1693562438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6If5EjcjNWDZstp6qFU/ATLLg3ICZt1fdKDrO8/tZ0=;
        b=nbI/JwabJN9ZeZcmPE1O5VxauB1CWuioWf0xlXmfRufq0VO3/lR9taNtbLp71Mo1Eq
         LCPu2Q6/tKcUD5LOSfWA761HbbLtlft/M0+ealNEIfYz1k0BK4hAZyTyi/kSGcfN8oqL
         jLuBCJgu1lUGE3pkoPoIT/djjNreJza1CLIk/Qcd+B0m7Crc4WLTwgLM5PURPuJ3MOWr
         gXgnlU4rap4rN4SW+Nt14jYykzpQwLv3ny7wFIk2oUNRxm5eJXAW1uRYCdOBseanqCxI
         Q1eqzg86L0Cr0/Osd242hgru665hz0xFd7yd+VhXEir/DYIKdMaGKyeZhqo8UG9ljpfy
         PH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692957638; x=1693562438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6If5EjcjNWDZstp6qFU/ATLLg3ICZt1fdKDrO8/tZ0=;
        b=ieiGNOoDqxQ0NNYqSFlFEe6IVkBLq7D/QFE/feHH0Z7nhy3eLG6ag9teLxLQimMC3J
         8hP+DSD/+wnS4sKgSNMj9Ue6uH+DaH4BZKWn/x/+onrTGN+aFw4LdRQt/4IsPrG+zJY5
         WTyQnkimuv/Ot9zgwMws14ih2XsNDZcMG7J8ER9we1BixUAkRoBZZXAE/bS5vigtWRQK
         0YnH9c1mRUXUKXv9hTOH5n57/8G5/aZlPVTfHo/S0tgBHu/M5MSIUbuQHaeQWdVCTfwa
         lhU2ctw6Nj+NmVL50AmTigrT6PntKE1wbZg+5UQs4XoUAw2NkupzD+/SnwLg83YViprs
         KMSg==
X-Gm-Message-State: AOJu0YzD/EgOPK7jxzpjRRXK1YCuT4b6DIMPb/+xOU0oUbTAnu+V+Q1M
        XtOMT/ElTTYfvldaNjlPHQo2HAcGtXx4k4qretqkfQ==
X-Google-Smtp-Source: AGHT+IEOsbOy+RYASkcI/UnK7YnLgMYNKZ1ts7Vx3xLDADc2hk/6VG4xLAk6rgwHyCF+46GXcaoPiyniIDPGrmQbRdk=
X-Received: by 2002:a25:f81b:0:b0:d15:7402:f7cd with SMTP id
 u27-20020a25f81b000000b00d157402f7cdmr18874314ybd.27.1692957638523; Fri, 25
 Aug 2023 03:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091743.15613-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230825091743.15613-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 12:00:02 +0200
Message-ID: <CAPDyKFoBnZCF7MMfou=mY0xqVtCcCOMMtZGv=KpxhKxFFjkqiw@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 11:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v3:
> - Move changes in include/linux/mmc/host.h and drivers/mmc/core/sd_ops.c into patch1
> - The callback is executed when timing is equal to MMC_TIMING_SD_HS
> - Rename prepare_hs_tuning to prepare_sd_hs_tuning
> - Rename execute_hs_tuning to execute_sd_hs_tuning
>
> Change in v2:
> - add mmc_sd_switch() and mmc_send_status() to the header file
> - split up core changes from host driver changes
> - Use pr_debug instead of dev_info and dev_dbg
> - Optimize the best sampled value algorithm
>
> Wenchao Chen (2):
>   mmc: core: Add host specific tuning support for SD HS mode
>   mmc: sdhci-sprd: Add SD HS mode online tuning
>
>  drivers/mmc/core/sd.c         |  14 ++++
>  drivers/mmc/core/sd_ops.c     |   1 +
>  drivers/mmc/host/sdhci-sprd.c | 149 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   8 ++
>  4 files changed, 172 insertions(+)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
