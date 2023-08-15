Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98D577CB17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjHOKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjHOKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19108115
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6096312B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D65C433C8;
        Tue, 15 Aug 2023 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692094758;
        bh=e3RTHya1UOALxBcGLFqnI0iuhaDpwjhJ2Bpe8CJ5PAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvYDYh2ixAEgo17/j0lP3XWYLHUgCFnKLFClqWVDLhgWScDu1cSfeVdSuO01gXKo3
         Q2zz2OAlKv+63jwj/hohwq08LB2DTTlsYFXWaYOsEZUK7w+rN/nDHLe/L8yP/kJQ8I
         tRM8dR/Jw6cbl6TzObd6UKYVRPc+rCGywKHDf8w/yr20zbcbB0ztLFB2LiIIu36wRz
         p+xR1ibaJMTIjq4QueT8YoZeVb9b4iEA0gfqO9CGi3+aFZiW9BaGhDtUn75zkI6WLx
         BhBE4/O9fOuieZ1ZS0+TymH6zTCS8TQTm/ec5Pmo5DcAURuBR34wwcM1cuoOi15jOW
         //4ROxwX365Pw==
Date:   Tue, 15 Aug 2023 11:19:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20230815101911.GA11399@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
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

On Tue, Aug 15, 2023 at 01:04:43PM +0800, Michael Shavit wrote:
> On Thu, Aug 10, 2023 at 5:15 PM Michael Shavit <mshavit@google.com> wrote:
> > On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Since you're dropping this and relying on the lock being taken higher up
> > > callstack, can we add a lockdep assertion that we do actually hold the
> > > devices_lock, please?
> >
> > Will do!
> 
> I spoke too soon; the point of this change was to remove the
> dependency on the arm_smmu_domain, piping the devices_lock would
> defeat this. In fact, this section is really depending on the iommu
> group lock not the devices_lock.

Sorry, but I'm not following you here. What is the devices_lock protecting
if we're depending on the group lock?

Will
