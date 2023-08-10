Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8031B7774D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjHJJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjHJJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF002127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 851DA6564C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D207C433C7;
        Thu, 10 Aug 2023 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691660618;
        bh=tdZvvunqI2kWKxGbLVgNcUUq5A+ZAKwbvFYIFUY+NYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A10A9URAFmjsDxwciW/ZOY590dKY4C3OAB2pDu0GmmbEFWmD8m5rbBGgHI2EQnPEs
         VXFVk4MKY9hgaiqUcRi13WLXWoqhmGYyNeW2qAIzhxUBJoCPY4/cMyeZhaYxEHD6Ow
         /ArdVEdttCJTQ/Ls+YTtHTewM6ZiZoTtKJxQRtsFFKxENRXLXQy9M0dKTOK2U3ykCp
         4pJShizefWUz6/aFRqImpflfZzQXFe/e7iA8+f1IhIL4bitf5zEg5C0psL20VLXU8S
         4hK+hrfBvB+a6Caega2jSeCQJmD5Zsixy2ZCtNTUmfkFGokpqo+3lbR84cqwdhsbpS
         zjNCm/X3bjiEw==
Date:   Thu, 10 Aug 2023 10:43:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230810094323.GC5365@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
 <ZNO+QVkXcHG78KG3@nvidia.com>
 <20230809162749.GA4663@willie-the-truck>
 <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
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

On Thu, Aug 10, 2023 at 05:33:53PM +0800, Michael Shavit wrote:
> > > > Sounds a lot like the existing s1fmt field. Can we keep it?
> > >
> > > If you are OK with the dead code, I don't object. But let's put it in
> > > the struct arm_smmu_ctx_desc_cfg.
> >
> > Ok, we have a deal!
> 
> What dead code? Is the deal here that we keep the field, but still
> infer the value to write from (cd_table->l1_desc == null) in
> arm_smmu_write_strtab_ent??

Keep the field and write it directly when populating the ste (i.e. don't
infer anything), but the field moves into 'struct arm_smmu_ctx_desc_cfg'.

Will
