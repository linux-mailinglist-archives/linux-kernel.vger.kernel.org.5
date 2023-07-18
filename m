Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0237577AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjGRJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGRJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD391985;
        Tue, 18 Jul 2023 02:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3026E614DC;
        Tue, 18 Jul 2023 09:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2729AC433C7;
        Tue, 18 Jul 2023 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689671815;
        bh=X1PB0DZ98HNXgcbNBNhLnxz+WT2Ttfz91vdZj8MqJdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEXVjd8A1wrHo2OdsLRY2qh7dp8JAFitJbD/0++C4IYmLBpgshjtfaQ+EanQBdDPS
         q6IWubOJ6X+Q+uXBW/hswlYp8i6EbnNRCjxx9MeSVi1X2+Xf2grZAfBcz3DaLuA7o+
         tMXZ7c8l6PkTjQ9+MJIp4tLQIquKIKSURyu6eBsniqUnnMeepF3engRvmX9T+Gau6c
         pgxHDRnRcLSzoBDAaez5KndjZiFfDlirlhRGepgJyu/uWIqyez8VjNNO8UOTJ3rfUg
         aQiB8myN+2AUmHJ6dZMAFBd1EtvXIW65Ye+Auu4D9gDzqmsTOIlU2hVZt/oC/cI19N
         d6LKpVyXVm+Ug==
Date:   Tue, 18 Jul 2023 11:16:49 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        catalin.marinas@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZLZYgZMnNB0pdycr@lpieralisi>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZLZEq0QBBW4rcxJM@lpieralisi>
 <8e2cfde3-15fa-4e5a-02bf-0763abf10821@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e2cfde3-15fa-4e5a-02bf-0763abf10821@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:54:36PM +0800, guanghui.fgh wrote:
> 
> 
> 在 2023/7/18 15:52, Lorenzo Pieralisi 写道:
> > [+Catalin, Will, Shameer]
> > 
> > On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > > According to the ARM IORT specifications DEN 0049 issue E,
> > > the "Number of IDs" field in the ID mapping format reports
> > > the number of IDs in the mapping range minus one.
> > > 
> > > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > > whose "Number of IDs" equal to 0, resulting in valid mapping
> > > nodes with a single ID to map being skipped, which is wrong.
> > > 
> > > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > > check.
> > > 
> > > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > ---
> > >   drivers/acpi/arm64/iort.c | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index 3631230..56d8873 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
> > >   	for (i = 0; i < node->mapping_count; i++, map++) {
> > >   		struct acpi_iort_node *parent;
> > > -		if (!map->id_count)
> > > -			continue;
> > > -
> > >   		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> > >   				      map->output_reference);
> > >   		if (parent != iommu)
> > 
> > Shameer, I know this may look like overkill since the hunk we are
> > removing is buggy but can you please test this patch on platforms
> > with RMR to make sure we are not triggering regressions by removing
> > it (by the specs that's what should be done but current firmware
> > is always something to reckon with) ?
> > 
> > Thanks,
> > Lorenzo
> Thanks for your response.
> 
> Firstly, I have tested iort rmr with one ID mapping and works well.
> 
> Secondly, When there is more than two id mappings, the buggly id_count check
> has no effect(for the id_count is larger than zero).

Thank you, I wasn't asking you, it is comforting to know you tested the
patch before sending it though.

I asked Shameer to make sure the id_count check did not mask a bug
in the platforms on which the RMR IORT implementation was initially
tested - that's it, I don't want to merge a fix and revert it the
next day.

Thanks,
Lorenzo
