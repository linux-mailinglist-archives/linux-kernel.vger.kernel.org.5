Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD67E0B43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbjKCWo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjKCWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:44:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25019D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:44:51 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7afd45199so31391267b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699051491; x=1699656291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pXAnVldJ3nanWX3o4K4wMNI9RumqfofpvcrvhRbJBE=;
        b=fqNFeKIPqyosj7ToLadcFM9ouLlO98EpCPZyqqUO2rks+giE3X41D+3Mq0gVFo9ZzA
         dKZjh6j0AC0rpJtfs7/pCjEf7JzbahKJOcAue+p8ZS8jH6zd4c6mL8kjhClKxo9QmIX+
         UCUIxuFX4wfkej0IWLNpgUHfR8mQBaleVIRR1DS5JIvhu6gCA2A068x3ttDOMSeis3hw
         FCKUbIBC57WeMKeNLuxFNGnTgUv3v7xLIE7ADbacxkPuCkNPK4Hf7pPxrYZaEzgX1lPh
         fJJaGnNkwMlIHFh88sUbRMXTiZglXZsmBWFo7heUvjYKKNUh0jTja6payAsR6cRvo2tJ
         kFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699051491; x=1699656291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pXAnVldJ3nanWX3o4K4wMNI9RumqfofpvcrvhRbJBE=;
        b=uMSTjameZVJqzAN9gzTmY4vZCG9cAzXfsVGHJ5v+pp6iDqnbMGkCdIIIXxw4o1ijwp
         psiqbSg6jYzoFhy0uEBBnb28O9riEOniQ/6ubS0Tt8zjsMQKDIzG4b/DkQH3HIDZy+jx
         yXWmlZMUeAoAnrBMgxBubmFcXHBAsHK1FjENE163tt5Ug+jm2/qnp+pZFfhKgU/VHKSi
         YChT3L2HZgsUombqTm5zmXoqnM2yoq4k681TqPKu0qkrcREmsDzkneYsoG+i3rAXf83G
         NcdAzB3+IAdWMp75px16LktnUxLhOMTf+7fH74f9bFXlu6Y//FYrvLJ6aISFhwj8rG2W
         EjYw==
X-Gm-Message-State: AOJu0Yz9OcxbxBlRcvhRaT0jZt4JQb9GhI6s3qO8DhB29PVG0ReoUbHH
        Ymm59pi/ePr83IjeoM8ZEZ6oS7qn51mA9wgqDZV9u3retjwOnJRa
X-Google-Smtp-Source: AGHT+IEm9VwzgigzWfkuoz9kqjEtpavw7kmTAvP+ZZNOjFYy+eTQNahaWC/UkcJxqxAHwTChWi2eyod6Er9zTty6Shw=
X-Received: by 2002:a05:690c:f04:b0:5a7:bc38:fff2 with SMTP id
 dc4-20020a05690c0f0400b005a7bc38fff2mr5168299ywb.15.1699051491000; Fri, 03
 Nov 2023 15:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:44:39 +0200
Message-ID: <CAA8EJpqtZXNSz2-VEdQL2XTxi6GnZBkLABLe1qSUcwCbfoEHVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: introduction of ACTLR implementation
 for Qualcomm SoCs
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_saipraka@quicinc.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consists of three parts and covers the following:
>
> 1. Introducing intital set of driver changes to implement ACTLR register
> for custom prefetcher settings in Qualcomm SoCs.
>
> 2. Adding ACTLR data and implementation operations for SM8550.
>
> 3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
> settings during reset and runtime suspend.
>
> Link to discussion on RFC posted on ACTLR implementation:
> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/

First two patches in that thread were not archived for some reason.

However, as there was a previous iteration, it is suggested to include
the changelog between RFC and v1.

>
> Bibek Kumar Patro (3):
>   iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>   iommu/arm-smmu: add ACTLR data and support for sm8550
>   iommu/arm-smmu: re-enable context caching in smmu reset operation
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 143 ++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +

Although it is not mentioned in the MAINTAINERS file, could you please
CC linux-arm-msm when sending v2?

>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
>  4 files changed, 146 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
