Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BE77E087
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbjHPLge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 07:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbjHPLga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:36:30 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF31B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:36:29 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58d31f142eeso2498577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185788; x=1692790588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9gJbFseA01i0krgU46+q3/Jf0P3rLnLM6Eq8Alo05E=;
        b=hKe/MmX4o2OHSuBzacBVMMJrnn0eLEwNlSGIMu9iofBj5yq06WPOdjgf71Wk4T1LCR
         pUQTnldrTFQQ1HTZlvxkHoNTmnDD3k0jCujdok8zPySsep1WC9iimgiUkPVsUhVxtmgz
         +yOR/ZO1qBaXk3IQ4LzR0/Pad/hn9WZVWC0rEn0iQHyDBW8zp2KVuS31kMjUd2gWnmEt
         l5P2xUXnrXtEY/XEfyLx2/2Aq62gZjUkd3y+Fjrbqtq3MBkt+XMHbai2lykrzjzUTner
         rrEwjOuEvxJK4KqO0cRRwEU++HV1Wj5PwOq6JF8xiBSmPWcnAA6Pken3SmAdZuPiR/qV
         HgIw==
X-Gm-Message-State: AOJu0YzzcnyEhHG8l6lbk1QPba5KxZ/qArbvE3xR7Lu9WBUMjExDbPmC
        zIzuGsGGxK9aIcswWfonMZHqFLBdIEUPeQ==
X-Google-Smtp-Source: AGHT+IGerOkHbEQTV63zrTG0ZH1Pz3NNZkFjUQ2sL59rgwPK6NMhDOB0srQ2NORNypZ342CXsC123g==
X-Received: by 2002:a81:8901:0:b0:589:f57b:e16e with SMTP id z1-20020a818901000000b00589f57be16emr2117345ywf.25.1692185788326;
        Wed, 16 Aug 2023 04:36:28 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id i64-20020a0df843000000b005704c4d3579sm3954179ywf.40.2023.08.16.04.36.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:36:27 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58c4f61ca12so25047427b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:36:27 -0700 (PDT)
X-Received: by 2002:a25:da02:0:b0:d07:3fb6:c00d with SMTP id
 n2-20020a25da02000000b00d073fb6c00dmr2398620ybf.12.1692185787100; Wed, 16 Aug
 2023 04:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <0f8ac07472f4161c71247742acb2303f9cf91396.1692113438.git.geert+renesas@glider.be>
 <2e076cb5-1e31-10b2-9f33-79a825ac9c11@arm.com>
In-Reply-To: <2e076cb5-1e31-10b2-9f33-79a825ac9c11@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 13:36:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTNP8YyUCvA_LxH1uHWPrF6oLK6gmo4f998nSCXha59g@mail.gmail.com>
Message-ID: <CAMuHMdVTNP8YyUCvA_LxH1uHWPrF6oLK6gmo4f998nSCXha59g@mail.gmail.com>
Subject: Re: [PATCH] perf: ARM_SMMU_V3_PMU should depend on ARM_SMMU_V3
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Aug 16, 2023 at 1:23 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2023-08-15 16:36, Geert Uytterhoeven wrote:
> > There is no point in monitoring transactions passing through the SMMU
> > when ARM Ltd. System MMU Version 3 (SMMUv3) Support is disabled.
> > Hence replace the dependency on ARM64 by a dependency on ARM_SMMU_V3
> > (which implies the former).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This caught my eye after commit 7c3f204e544dfa37 ("perf/smmuv3: Remove
> > build dependency on ACPI") in arm64/for-next/core.
> >
> > Perhaps my understanding is wrong? Is there anything to monitor when
> > ARM_SMMU_V3=n?
>
> Yes, at least TBU event 1 still counts bypass transactions even when the
> SMMU is disabled, so PMCGs can be useful as basic traffic monitors in
> their own right. Plus the original design intent was that PMCGs may also
> be implemented by other things that interact with the SMMU, like
> ATS-capable PCIe root complexes, or devices with their own internal
> TLBs, thus they could potentially count any manner of
> implementation-defined events that aren't necessarily related to SMMU
> translation.

Thanks for the explanation!
Hereby I withdraw my patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
