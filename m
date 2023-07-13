Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C47529E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGMReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjGMReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D256226A0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706DB61ADB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390ECC433C7;
        Thu, 13 Jul 2023 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689269649;
        bh=E5ywfrtI0Wco8qvyzBJpgMPdT7W3NwtbJglM7sjmO7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHpIyvXaC7NiiFrbSOrnSr6QNzIs34S29H5zYDRfLdgbxGk1H7VW8z7EbpMdSkFp0
         N5Kor/L7l2mylFn31eRxzBdTCS+PrMrcIpB1Tm5Jw6CUiUxr7CE7a8QCBsfMQ4dSdG
         ytOxhDNS4uQPuGaUJ9wMfy6iCgeH5OAVeCyY7nxE=
Date:   Thu, 13 Jul 2023 10:34:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Fix hugetlb free path race with memory errors
Message-Id: <20230713103407.902e24dc90e85a9779ba885c@linux-foundation.org>
In-Reply-To: <20230711220942.43706-1-mike.kravetz@oracle.com>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 15:09:40 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
> HWPOISON hugepages" the race window was discovered.
> https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/
> 
> Freeing a hugetlb page back to low level memory allocators is performed
> in two steps.
> 1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
> 2) Outside lock, allocate vmemmap if necessary and call low level free
> Between these two steps, the hugetlb page will appear as a normal
> compound page.  However, vmemmap for tail pages could be missing.
> If a memory error occurs at this time, we could try to update page
> flags non-existant page structs.
> 
> A much more detailed description is in the first patch.
> 
> The first patch addresses the race window.  However, it adds a
> hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb
> page free operation.  This could lead to slowdowns if one is freeing
> a large number of hugetlb pages.
> 
> The second path optimizes the update_and_free_pages_bulk routine
> to only take the lock once in bulk operations.
> 
> The second patch is technically not a bug fix, but includes a Fixes
> tag and Cc stable to avoid a performance regression.  It can be
> combined with the first, but was done separately make reviewing easier.
> 

I feel that backporting performance improvements into -stable is not a
usual thing to do.  Perhaps the fact that it's a regression fix changes
this, but why?

Much hinges on the magnitude of the performance change.  Are you able
to quantify this at all?

