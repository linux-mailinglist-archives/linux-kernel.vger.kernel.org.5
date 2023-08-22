Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCF783ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHVHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHVHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:19:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8302DCD1;
        Tue, 22 Aug 2023 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692688380;
        bh=SJsxQb+2HzJMV+XlszngI2wKeDLW6PxOCQm17ZNiClI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fjwnGJPioT0weeWOqyAkgiI1a71lig5O/DDdgp8N8FfiXBZ4/xA5NSEPXKYR/aQaS
         bMu5yZinGGG0hTRG+wiJPeM1c8cLc0IxXGmae2uiRShM6m4VR7tpM0YcYJRrYTslBH
         hOFJJs3aCld4D6dEU8ZW5oCjsyntUZ1A1mFIeY62HL1QDCGnGXGDnNTJeWjKZZiJo0
         uCmJLvG4Mr4WS2MwGzBs+sPQX+JNZl7IOcXaSAPZ9hXBtXqWiB1s2KzCwbU6Rb0KGa
         nMLzr/3NhO8sXRhDaJM6C3FdXI9fKvkUZhnsyCiOEs1U54tt21eKaO89fIB/OkI2Q3
         +PPiMUncW/abg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVLCb2MQ1z4x2n;
        Tue, 22 Aug 2023 17:12:59 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: build failure after merge of the mm tree
In-Reply-To: <ZOQLUMBB7amLUJLY@casper.infradead.org>
References: <20230822095537.500047f7@canb.auug.org.au>
 <ZOQLUMBB7amLUJLY@casper.infradead.org>
Date:   Tue, 22 Aug 2023 17:12:55 +1000
Message-ID: <87wmxnv9c8.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:
> On Tue, Aug 22, 2023 at 09:55:37AM +1000, Stephen Rothwell wrote:
>> In file included from include/trace/trace_events.h:27,
>>                  from include/trace/define_trace.h:102,
>>                  from fs/xfs/xfs_trace.h:4428,
>>                  from fs/xfs/xfs_trace.c:45:
>> include/linux/pgtable.h:8:25: error: initializer element is not constant
>>     8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
>
> Ummm.  PowerPC doesn't have a compile-time constant PMD size?

Yeah. The joys of supporting two MMUs with different supported page
sizes in a single kernel binary.

> arch/powerpc/include/asm/book3s/64/pgtable.h:#define PMD_SHIFT  (PAGE_SHIFT + PTE_INDEX_SIZE)
> arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTE_INDEX_SIZE  __pte_index_size
>
> That's really annoying.  I'll try to work around it.

Sorry, thanks.

cheers
