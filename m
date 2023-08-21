Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5433782744
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHUKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjHUKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E78D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FC563069
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A863C433C8;
        Mon, 21 Aug 2023 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692614572;
        bh=XnwUB514PPCDbHd6aAR29S9FdVfiRdORES8i2CcbAFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5QpjJIWaWBVQFquS5BaAK1jjl/dAdClZj/ZErMCv8PiBda1NJF2FCHOz4u1Tz7qm
         lBteEy+WFVjjQHs2OsVdWPMhJB2XhqyJyVJqCXiTpMQV4cO4MJYKwGkrnd053nlkfH
         0TNzt9SWggDfAlMt2sW7/1Cat4SRWzGW1MC3jReg/gDKqgnp274GDjanq5LEQuYwKK
         o8blznHtlaLByL3ZzrLNBNpqTZUlN/pPryWWywztYgVF98KrkLbkaqnr2XzL3z2oCi
         5cceIc8VhkyhGIhtkF7KK0JX8dBZL5+GsL8hb44pxzMwIDnmz+xlKOwwuqSuLAtm4W
         /WgoCS8wD9CFQ==
Date:   Mon, 21 Aug 2023 11:42:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        jean-philippe@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com
Subject: Re: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table
 isn't active
Message-ID: <20230821104247.GA19469@willie-the-truck>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 06:16:08PM +0800, Michael Shavit wrote:
> On Wed, Aug 16, 2023 at 9:20 PM Michael Shavit <mshavit@google.com> wrote:
> >
> > This commit explicitly keeps track of whether a CD table is installed in
> > an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> > was previously achieved through the domain->devices list, but we are
> > moving to a model where arm_smmu_sync_cd directly operates on a master
> > and the master's CD table instead of a domain.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> > Happy to drop this commit if we don't think it's useful.
> 
> Hi Will,
> Do you have any recommendations for keeping or dropping this commit in
> the end? It's only purpose is to minimize any potential performance
> impact from the refactor but can certainly be dropped if you don't
> think it's worth the complication.

I'd prefer to drop it unless somebody can measure the benefits that it
brings.

Will
