Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DA7B0994
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjI0QFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjI0QFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:05:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E87DE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D2C433C7;
        Wed, 27 Sep 2023 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695830705;
        bh=PrFvZ4k1hwv64LB7gobXsxrGNWxskL6dT4erfDoxXjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=utL1b4AZyAMIiaqgHvwkLxcHvw83gspie08WKEoSRxKq9G2MBJ+3B7HXEp0k3MqP5
         39uMjtQnjoDLT201VUBcr4txuEJNNw3+dX1CePiAjFEfPJ2rI20XP234Jg8UgYisHU
         HIuhldDX9xFWb+jqeYdGZ4fyt7VPUNbi60DCCe9Y=
Date:   Wed, 27 Sep 2023 09:05:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] bootmem: use kmemleak_free_part_phys in
 free_bootmem_page/put_page_bootmem
Message-Id: <20230927090504.f3ef3b9123bcdb7d131b3daf@linux-foundation.org>
In-Reply-To: <20230927035923.1425340-2-liushixin2@huawei.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
        <20230927035923.1425340-2-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 11:59:21 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Since kmemleak_alloc_phys() rather than kmemleak_alloc() was called from
> memblock_alloc_range_nid(), kmemleak_free_part_phys() should be used to
> delete kmemleak object in free_bootmem_page() and put_page_bootmem().
> 
> Fixes: 028725e73375 ("bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page")
> Fixes: dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem")

Having two Fixes: is awkward.  If someone is considering backporting
this patch into earlier kernels then which Fixes: target should they
use to decide whether the fix is applicable?

So I think it would be best if this patch was split into two patches,
please.

And let's decide whther these fixes should be backported into -stable
kernels.  For that, please alter the changelogs so they tell us what are
the userspace-visible effect of the bugs.

