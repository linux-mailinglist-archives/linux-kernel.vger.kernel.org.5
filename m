Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73003754F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGPPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGPPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341281BF;
        Sun, 16 Jul 2023 08:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A364960D2C;
        Sun, 16 Jul 2023 15:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95374C433C8;
        Sun, 16 Jul 2023 15:10:50 +0000 (UTC)
Date:   Sun, 16 Jul 2023 08:10:49 -0700
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
Message-ID: <ZLQIeVQ6ITF8RMB/@arm.com>
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
 <ZKvqjrpyLZVB3R2z@FVFF77S0Q05N>
 <8a7416df-1656-8380-9a42-1af3cd940f97@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7416df-1656-8380-9a42-1af3cd940f97@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:31:39AM +0530, Anshuman Khandual wrote:
> On 7/10/23 16:55, Mark Rutland wrote:
> > On Fri, Jul 07, 2023 at 11:03:27AM +0530, Anshuman Khandual wrote:
> >> These pte_dirty() changes make things explicitly clear, while improving the
> >> code readability. This optimizes HW dirty state transfer into SW dirty bit.
> >> This also adds a new arm64 documentation explaining overall pte dirty state
> >> management in detail. This series applies on the latest mainline kernel.
> > 
> > TBH, I think this is all swings and roundabouts, and I'm not sure this is
> > worthwhile. I appreciate that as-is some people find this confusing, but I

I'm pretty much on the same lines, though maybe I looked too much at
this code that I don't like any further changes to it ;).

> Current situation for pte_dirty() management is confusing when there are two
> distinct mechanisms to track PTE dirty states, but both are forced to work
> together because
> 
> - HW DBM cannot track non-writable dirty state (PTE_DBM == PTE_WRITE)
> - Runtime check for HW DBM is avoided

Depending on how you look at it, we can say that any writeable PTE (as
in page table permission, PTE_RDONLY cleared) is dirty and we only have
a software mechanism for tracking the dirty state. The DBM feature is
not actually giving us a dirty bit but an automated way to make a PTE
writeable on access (for some historical reasons like the SMMU not
having such mechanism in place).

Maybe we can clean the code a bit based on the above perspective. E.g.
instead of pte_hw_dirty() just have a !pte_hw_rdonly() macro. It may
help with the confusion of having two mechanisms.

OTOH, with PIE, we can have a true dirty bit but at that point we can
eliminate the pte_sw_dirty() use entirely and allow soft-dirty using the
current PTE_DIRTY (with some static labels based on the feature).

> > don't think the end result of this series is actually better, and it adds more
> > code/documentation to maintain.
> 
> Agreed, it does add more code and documentation but still trying to understand
> why it is not worthwhile. Regardless, following patch does optimize a situation
> where we dont need to call pte_mkdirty() knowing it will be cleared afterwards.
> 
> [RFC 2/4] arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state

I wonder whether the compiler eliminates much of this duplication since
there are some checks for pte_write() before. We may be able to remove
some checks. For example, does pte_hw_dirty() actually need to check
pte_write()? A !PTE_RDONLY entry is dirty automatically since we can't
trap any write access to it (prior to PIE; I need to check Joey's
patches on how it treats writeable+clean PTEs; still on holiday).

As for the fourth patch, I'd rather add documentation in the header
file, it's more likely to be looked at and updated.

-- 
Catalin
