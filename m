Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5377BA2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjJEPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjJEPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6153821A21
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD21DC433CD;
        Thu,  5 Oct 2023 05:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696482444;
        bh=q9gwVh9i7yhacKF0+Y1E5YalBV+GiHWLIMRRh+7yaJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPQxDQ2PwLXpWqinMgBQRN97ZkH0MQvovaLYeB4w1HxqXKfBITyukOtR5Xeh5LdEG
         YwhgvHjqCW3tRJlrBa+d6p9p/oIr6QBMEY0T32z1OQtcqRIVP2oVnf8jAKzaLI6x4p
         PEZbiQJO0vA8Xzad3bEqwkDQsjyVs7nj2fwqc53z32HUG6UIeV7UfaRZbde0jTR5LQ
         XwqKUqwZkzLSQCgA9+E7jQyTi1MVSEgZhvhsNPhKInezo6YkvmMnrUgVkkLorfp7b9
         6CO1kMKHWltCupII9JDmmCz/JMmriijlTQY2+euPnxiu0X5iDoWDR7wFXUKxerljuf
         KcvLNPfoOvCzQ==
Date:   Thu, 5 Oct 2023 08:06:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20231005050619.GB3303@kernel.org>
References: <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
 <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
 <20231002111051.GA3303@kernel.org>
 <3057dab3-19f2-99ca-f125-e91a094975ed@redhat.com>
 <8c9ee3bd-6d71-4111-8f4e-91bc52b42ed4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c9ee3bd-6d71-4111-8f4e-91bc52b42ed4@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:38:09PM +0800, Yajun Deng wrote:
> 
> On 2023/10/2 19:25, David Hildenbrand wrote:
> > On 02.10.23 13:10, Mike Rapoport wrote:
> > > > > 
> > > > > That 'if' breaks the invariant that __free_pages_core is
> > > > > always called for
> > > > > pages with initialized page count. Adding it may lead to
> > > > > subtle bugs and
> > > > > random memory corruption so we don't want to add it at the
> > > > > first place.
> > > > 
> > > > As long as we have to special-case memory hotplug, we know that we are
> > > > always coming via generic_online_page() in that case. We could
> > > > either move
> > > > some logic over there, or let __free_pages_core() know what it
> > > > should do.
> > > 
> > > Looks like the patch rather special cases MEMINIT_EARLY, although I
> > > didn't
> > > check throughfully other code paths.
> > > Anyway, relying on page_count() to be correct in different ways for
> > > different callers of __free_pages_core() does not sound right to me.
> > 
> > Absolutely agreed.
> > 
> I already sent v5  a few days ago. Comments, please...

Does it address all the feedback from this thread?

-- 
Sincerely yours,
Mike.
