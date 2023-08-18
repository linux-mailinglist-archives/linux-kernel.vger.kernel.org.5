Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60354781289
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379332AbjHRSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379339AbjHRSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838342D70
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D0D63B49
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388F1C433C8;
        Fri, 18 Aug 2023 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692381790;
        bh=GcHOZuE+yu2rWZVOxdHvFqURHbfpZ1mp7n9HpH+zdzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VznVWNicvACp1njnOOXedvuJgDQqYM+Q9dBLYk37vX0JeFjqG6ZVjdI8nItAMS9UY
         nhZdm9XF5qcAUERZcp5KcupokYXEDxkWf1RsS947vdeWju2XqX0ukQykAthnVJppKe
         8TgKWHdI1jbiHSy7EtytTr+TA3eRqkxxhEZIr7ZM=
Date:   Fri, 18 Aug 2023 11:03:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-Id: <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
In-Reply-To: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 11:18:36 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Perf was used to check the performance differences after the patch. Overall
> the performance is similar to mainline with a very small larger overhead that
> occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
> of the larger overhead that occurs in xa_load() and xa_store() as the
> xarray is now using more entries to store hugetlb folios in the page cache.

So... why merge the patch?  To save 40 lines of code?

I mean, if a patch which added 40 lines yielded a "very small"
reduction in overhead, we'd probably merge it!

Or is there some wider reason for this which the changelog omitted?
