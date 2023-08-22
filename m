Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD5783B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjHVISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjHVISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:18:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194D1AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:18:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso164071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692692287; x=1693297087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y+P92gaIOtxmJ4GQuI1gvrZz/VMhfETxorK5TKfzBk=;
        b=XTbK95xrJra6oEzO1gFH4l3LUyPCQjhZVzPiUtK12pfKx1SfKU/ZmRcBAyKT6CYABK
         HKyrx3uFVJcTcBmsvdmN7zERpPi1u+63GNjEr8uaoOAd5l254TvXdetBum+neGos1/xj
         znnlKqJv0gPnoKlPNvUK/E8aiGqMv6ihs76Z0ezD6UaJYbqqVZ7arIE4fDWPKUecZze2
         4rnMhiYUUjnZ4KcHp5jHFfBIeqSep+q9So0PEC69rRHb0JgqBGm+N5Jo0OFmfnRA3eUp
         pjB4/txnakmdH/53EJfRWnVrmwTGIOydAWTGEdbbzdG3xSj4itwzPnN1N/CAVz6NXIMx
         zWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692287; x=1693297087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y+P92gaIOtxmJ4GQuI1gvrZz/VMhfETxorK5TKfzBk=;
        b=NWGmGtnTzTYgGB05rHVjSpxSVD13ZZ1B35GX5ccVh8WP60CeDpm26V6/qk7HyDBdmY
         XWF7VrrJ4MCzW79v6QN7K8bL4FAEFtyfngCMMdlOYMiL7LMuJEXNH0WDl6GKLgbrDEqP
         F1kErndIVcKjc5SqKmC9/dn6hnTyyW/MiPSHE64lCbWV+nfkX3yIMEXTnDG5BrdM68rq
         q955OQFFSjqTLI1q3vMOQqRP8LowJp59SEQY0i+Ep6MNFePdlgry9S1PdN8HLZA9Up1m
         buKO4wDuHW1uBXSVsqKX8mqPl6ptxbW9yQpx/fJiCGiVoMdgaiXbGaTwiGiXzGYUoMsi
         Dnfg==
X-Gm-Message-State: AOJu0YzWGig0d6pDvzt6RwdT0HN2EqfYrHwufgIve9SsxVyppg67TjyO
        5Sn7JRP+YY24oDa76oC+TIkDEtU00r7HH7uyAtfBl49+tRUH0eDdwn20cw==
X-Google-Smtp-Source: AGHT+IG6Imz+hb2H6ThrnJJSyj9TF/FlinkAsxgSUw9yPUDKDS984QzNxxtXbKl1fI2UbBLRqax8GK76LtgImM4gJkA=
X-Received: by 2002:ac8:5cc4:0:b0:410:9855:acd with SMTP id
 s4-20020ac85cc4000000b0041098550acdmr209444qta.14.1692692287343; Tue, 22 Aug
 2023 01:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com> <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
 <ZONRRubvUK7GXO4i@nvidia.com>
In-Reply-To: <ZONRRubvUK7GXO4i@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 22 Aug 2023 16:17:31 +0800
Message-ID: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 7:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> > Since there's now a loop over a series of SMMUs inside
> > arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> > that loop. This technically works because only SVA is calling
> > arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> > the future since it's not obvious from the function name.
>
> Well, I would remove the duplication and add an argument if you intend
> to share the function that loops

What do you think about this as a final stage:
Once the set_dev_pasid and sva refactor lands, SVA could call a common
arm_smmu_inv_range_domain implementation which would:
1. Skip the TLB invalidation on a per-smmu basis if it detects that
the domain type is SVA, or based on a passed-in parameter that is only
set True by SVA.
2. Issue ATC invalidations with SSIDs found in the arm_smmu_domain.
This common function would be used for all use-cases: invalidations of
domains attached on RIDs, on PASIDs (SVA and non SVA).

Then we have two options for the intermediate stage with this series:
1. Non-SVA code uses arm_smmu_inv_range_domain which calls
arm_smmu_tlb_inv_range_domain(_no_atc) and arm_smmu_atc_range_domain,
SVA code individually calls those two functions.
arm_smmu_tlb_inv_range_domain(_no_atc) accepts a parameter to skip the
invalidation if BTM feature is set.
2. Same as option 1, but SVA also calls arm_smmu_inv_range_domain.
arm_smmu_inv_range_domain accepts both a parameter to skip TLB inv
when BTM is set, as well as an SSID for the atc invalidation. SSID
would be 0 in non-sva callers, and mm->pasid for SVA.
