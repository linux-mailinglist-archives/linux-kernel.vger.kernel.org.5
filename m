Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422CD7C9707
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNWZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJNWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:25:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D6DA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:25:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B5C433C7;
        Sat, 14 Oct 2023 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697322342;
        bh=DVFXu995Ek/eydKdbc/Uxs7E/ribT7x6PLE1LvWtWMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eg3LLDduGAPpZPmH+cwbNSSyYRkJV++4EQMhHvF2yYXau3PoRoqK881SxtlKd1zyF
         waCMDDEMx8joqUXDlJZcLXCmOyG3PY1S9ww0g5hYFh5BQ7RkHc6WqHt7oA1cQz5fS7
         iHZrAoYDVmAd0THWA9jzKLQ3A6zRH38Ph+JNYzjQ=
Date:   Sat, 14 Oct 2023 15:25:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <osalvador@suse.de>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing
 memory_section->usage
Message-Id: <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
In-Reply-To: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 18:34:27 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> The below race is observed on a PFN which falls into the device memory
> region with the system memory configuration where PFN's are such that
> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
> end pfn contains the device memory PFN's as well, the compaction
> triggered will try on the device memory PFN's too though they end up in
> NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
> sections). When from other core, the section mappings are being removed
> for the ZONE_DEVICE region, that the PFN in question belongs to,
> on which compaction is currently being operated is resulting into the
> kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.

Seems this bug is four years old, yes?  It must be quite hard to hit.

When people review this, please offer opinions on whether a fix should
be backported into -stable kernels, thanks.

> compact_zone()			memunmap_page
> -------------			---------------
> __pageblock_pfn_to_page
>    ......
>  (a)pfn_valid():
>      valid_section()//return true
> 			      (b)__remove_pages()->
> 				  sparse_remove_section()->
> 				    section_deactivate():
> 				    [Free the array ms->usage and set
> 				     ms->usage = NULL]
>      pfn_section_valid()
>      [Access ms->usage which
>      is NULL]
> 
> NOTE: From the above it can be said that the race is reduced to between
> the pfn_valid()/pfn_section_valid() and the section deactivate with
> SPASEMEM_VMEMAP enabled.
> 
> The commit b943f045a9af("mm/sparse: fix kernel crash with
> pfn_section_valid check") tried to address the same problem by clearing
> the SECTION_HAS_MEM_MAP with the expectation of valid_section() returns
> false thus ms->usage is not accessed.
> 
> Fix this issue by the below steps:
> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
> b) RCU protected read side critical section will either return NULL when
> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
> c) Synchronize the rcu on the write side and free the ->usage. No
> attempt will be made to access ->usage after this as the
> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
> 
> Since the section_deactivate() is a rare operation and will come in the
> hot remove path, impact of synchronize_rcu() should be negligble.
> 
> Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")

