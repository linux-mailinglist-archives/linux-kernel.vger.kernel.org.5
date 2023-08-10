Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788B777AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjHJOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FCE53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE7164B25
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F10C433C7;
        Thu, 10 Aug 2023 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678457;
        bh=qIjgpMCMchGb8GSzUQvWxpoDDxQOmNK9dlfrexgl7S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9HdELJhhcOK5bhsUbkMOury6WbB2zebnKCKQG2KAbUtvi76HksnWxm3/V5V2KMQl
         H6pU16EteNOTPbC49IeCG0peGkze+i7d2z6+jbNqsKmABWlMJtPtmOZAS1aruzXxDE
         OB05/iZ4ELrUNserg3658J4p1s7a/M/VmrtdnY6b5edxzLZ1P1fSPoGIh5lFrGhvZ5
         +p5VoG2bWJnCEgtaaJWqlHrViq5kohkkTnRr73+eHDoIuv9CA0KdWNGZ1jkF5A0U2K
         kgmkeRoCk3Qu/nrQulymx74DBiw1QaOJpWTlx14XRFEJTu4Q/J+DzApCQZHrYOM/MH
         0A0yvKeOSl1QA==
Date:   Thu, 10 Aug 2023 15:40:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20230810144051.GD5795@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:15:50PM +0800, Michael Shavit wrote:
> On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> >
> > > -     ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> > > -     if (ret)
> > > +     ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
> > > +     if (ret) {
> > > +             arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
> >
> > Why is it safe to drop the lock between these two calls?
> 
> Hmmm this is a tricky question.
> Tracing through the SVA flow, it seems like there's a scenario where
> multiple masters (with the same upstream SMMU device) can be attached
> to the same primary/non-sva domain, in which case calling
> iommu_attach_device_pasid on one device will write the CD entry for
> both masters. This is still the case even with this patch series, and
> changing this behavior will be the subject of a separate follow-up.
> This is weird, especially since the second master need not even have
> the sva_enabled bit set. This also means that the list of attached
> masters can indeed change between these two calls if that second
> master (not the one used on the iommu_attach_device_pasid call leading
> to this code) is detached/attached at the same time. It's hard for me
> to reason about whether this is safe or not, since this is already
> weird behavior...

I really think the writing of the context descriptors should look atomic;
dropping the lock half way through a failed update and then coming back
to NULL them out definitely isn't correct. So I think you've probably pushed
the locking too far down the stack.

Will
