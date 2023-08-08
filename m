Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819067741E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjHHRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjHHR3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63D8C0B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5690662526
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9789FC433C8;
        Tue,  8 Aug 2023 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691511134;
        bh=3dtzfUCD+LNNd3R69riKgojTMmB3iwvo7xJjgLrGkV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q34GiRU8y8r2pRb0qHmcFZnOhscY+xDmlIhH4L0ZUdaIi96k4MWtFeaF6KVLQsIf5
         m0QmQWwAZrGpPjOcunyJx/WxYukvd54B282f21cpE2jLkclk0ekzlUvBUBcJZmsLvq
         qdQO9uVszwltdLW8tltgXFkKVPceYj1CZze8+KlaywbUxg9fYeEbEXuAP+p0swyE8+
         1ejWJW9Y2WKOG8euvAgq4ji6Vu4W6ylOYb694tlUBBBD1240Wtqgmuvjy7Bb7fgaGc
         lKRcSMIF+6pIZ+GuYZ6P4rKeBks4z/XTR0AsBK/2Qo13ldQcq3kDbvV8EmbG9VGrSj
         RbTA3xdakPSaQ==
Date:   Tue, 8 Aug 2023 17:12:09 +0100
From:   Will Deacon <will@kernel.org>
To:     zhurui <zhurui3@huawei.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <20230808161208.GA2890@willie-the-truck>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck>
 <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
 <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 01:28:04PM +0800, zhurui wrote:
> On 2023/8/5 2:30, Nicolin Chen wrote:
> > On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
> >> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
> >>> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
> >>> is reserved and will cause the CERROR_ILL error. This case means
> >>> that the size to be invalidated is only one page size, and the
> >>> range invalidation is meaningless here. So we set tg to 0 in this
> >>> case to do an non-range invalidation instead.
> > 
> >>> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> >>>                         num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> >>>                         cmd->tlbi.num = num - 1;
> >>>
> >>> +                       /* Prevent error caused by one page tlbi with leaf 0 */
> >>> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
> >>> +                               cmd->tlbi.tg = 0;
> >>
> >> This should only be true for the last iteration, right (i.e. when num_pages
> >> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
> >>
> >>         /* Single-page leaf invalidation requires a TG field of 0 */
> >>         if (num_pages == 1 && !cmd->tlbi.leaf)
> >>                 cmd->tlbi.tg = 0;To Will and Nicolin,
> 
> Not only the last iteration, it's the result of __ffs function. For example, if
> numpages is 33, then the value of __ffs(num_pages) is 0, so the value of scale
> is also 0. The value of num depends on CMDQ_TLBI_RANGE_NUM_MAX. That is, the
> maximum value of num is 31. Therefore, the final value of num is 1.
> So, if consider CMDQ_TLBI_RANGE_NUM_MAX, there will be some case not the last
> one page but the beginning pages. That's why I use scale and num as conditions,
> not num_pages. Then I should reassign tg based on the result.

Yes, thanks, you're quite right. I'm not sure what I was thinking!

Will
