Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA6754F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGPPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35171B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8251860D2B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76752C433C7;
        Sun, 16 Jul 2023 15:10:35 +0000 (UTC)
Date:   Sun, 16 Jul 2023 08:10:33 -0700
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC] arm64: properly define SOFT_DIRTY for arm64
Message-ID: <ZLQIaSMI74KpqsQQ@arm.com>
References: <20230703135526.930004-1-npache@redhat.com>
 <c8bbc891-cd52-e34a-8ca7-76314e97cbe3@arm.com>
 <CAA1CXcBWuMgMbBTLj9eYzW4wBxbJpa3FGZsbtiibrYODZQdg6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1CXcBWuMgMbBTLj9eYzW4wBxbJpa3FGZsbtiibrYODZQdg6A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I noticed Mark already replied in another thread along the same lines)

On Tue, Jul 04, 2023 at 06:08:59AM -0400, Nico Pache wrote:
> Is it possible to add the same DBM check I'm using
> (!arch_has_hw_pte_young) in these pte helper functions to only clear
> it when DBM is not present?

It's not possible since we don't have a way to encode a read-only +
dirty PTE (e.g. after ptep_set_wrprotect()). The PTE_WRITE/PTE_DBM bit
in the architecture only tells that the hardware is allowed to clear the
PTE_RDONLY bit on a write access and that's what we consider hw-dirty.
When a dirty/writeable PTE is made read-only, we clear PTE_WRITE, set
PTE_RDONLY _and_ the software PTE_DIRTY bit.

With the permission indirection extensions (PIE, see patches from Joey),
PTE_RDONLY can be treated as a true !PTE_DIRTY bit but there's no
hardware around yet.

So if you need software dirty, it can only be done with another software
PTE bit. The problem is that we are short of such bits (only one left if
we move PTE_PROT_NONE to a different location). The userfaultfd people
also want such bit.

Personally I'd reuse the four PBHA bits but I keep hearing that they may
be used with some out of tree patches.

-- 
Catalin
