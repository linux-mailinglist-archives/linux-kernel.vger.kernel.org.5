Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47727F8F70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:22:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811F7DB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:22:31 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 180801FD26;
        Sat, 25 Nov 2023 21:22:30 +0000 (UTC)
Received: from localhost (dwarf.suse.cz [10.100.12.32])
        by relay2.suse.de (Postfix) with ESMTP id 3868B2C142;
        Sat, 25 Nov 2023 21:22:29 +0000 (UTC)
Date:   Sat, 25 Nov 2023 22:22:29 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Tao Liu <ltao@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 180801FD26
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao, 

On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> However I have a question:
> 
> What if there is on-going DMA/RDMA access on the CMA range when 1st
> kernel crash? There might be data corruption when 2nd kernel and
> DMA/RDMA write to the same place, how to address such an issue?

The crash kernel CMA area(s) registered via
cma_declare_contiguous() are distinct from the
dma_contiguous_default_area or device-specific CMA areas that
dma_alloc_contiguous() would use to reserve memory for DMA.

Kernel pages will not be allocated from the crash kernel CMA
area(s), because they are not GFP_MOVABLE. The CMA area will only
be used for user pages. 

User pages for RDMA, should be pinned with FOLL_LONGTERM and that
would migrate them away from the CMA area.

But you're right that DMA to user pages pinned without
FOLL_LONGTERM would still be possible. Would this be a problem in
practice? Do you see any way around it?

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

