Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16246777AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjHJOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjHJOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166A2698
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B03E65E46
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81231C433C7;
        Thu, 10 Aug 2023 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678094;
        bh=qFb1AWXSv0ptnyqYb+YQ+216zdRiP+gYPb0xgmTKYqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEfmHSssrdc2+ny+nS195Z3pwQlAZ3ergx6I9Wva+RFjs3CazccFz9W9TnGpT25CT
         nOBeQopYo4AN/lyJIjnI9ycBidOYhH6S5RE7n1XO/3HHKGP+7o4VBNtBCgwS3FUuB7
         yl4m/zfCpGvyuK6fG0SnYcuVngtU42PjsyVJ42iX652WA4Ty+rusPH5f2bBvAyqgXC
         U10GuLWOYLKNv/s1WZjWkqklAVSCfc7Mg/+GbuIIUNVZ5Etbzzq3fOZ0vwv3UXmpWC
         avm2WSynsMThlIljQzcwfdKeevAhGe9cNofemwI3uSqt4s6cCTjxXlgu0OMoGNrl5e
         kPf87cCoCaLHw==
Date:   Thu, 10 Aug 2023 15:34:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <20230810143448.GB5795@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
 <CAKHBV27uY3TK3bWX8q1VHPo-ejeNmY53RAVNH_VqyYwZASKsNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27uY3TK3bWX8q1VHPo-ejeNmY53RAVNH_VqyYwZASKsNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:45:03PM +0800, Michael Shavit wrote:
> On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Aug 09, 2023 at 01:12:02AM +0800, Michael Shavit wrote:
> > > @@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> > >               ias = min_t(unsigned long, ias, VA_BITS);
> > >               oas = smmu->ias;
> > >               fmt = ARM_64_LPAE_S1;
> > > -             finalise_stage_fn = arm_smmu_domain_finalise_s1;
> > > +             finalise_stage_fn = arm_smmu_domain_finalise_cd;
> >
> > Why is this a better name? Now we have inconsistency with
> > arm_smmu_domain_finalise_s2().
> 
> There was a time where s1cfg represented the entire STE and carried
> the entire cd table. We've gotten rid of s1cfg, and now only store
> arm_smmu_ctx_desc in the arm_smmu_domain for stage 1 domains.
> arm_smmu_domain_finalise_cd is IMO more clear, especially given the
> historical baggage around `s1`.

Ok, but it's the inconsistency I object to. I don't think it's clear at
all to have arm_smmu_domain_finalise_cd() and arm_smmu_domain_finalise_s2().

The easiest thing is to leave it as-is.

Will
