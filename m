Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D27989A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjIHPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjIHPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:14:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E411BFA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+bkjLG5gMjn96Meh3UOx/AhFT/Dk/aCNk1nc/BHvvo=; b=J74rWk3HckJyMmu2A42t1dSfWO
        LmR54eLsr04O8lRB8a2/Som1A6+/SuYU2TEdMjQ61ABeUn8YcCMi8ZLGLttzS3FM2XnAvG8J34E83
        Mks1ZNhvcv/yLEPdOG86ZoT/bHKsaOpF+djLOljt6VS8ovxA58WKl2fStiLoxgWk+otNBk4ry7Fc1
        6iVsGzqdoJWZMyOE0YzC6W7t0p0oyom+h0DuYwGCU6Qf1VwJFgRmEHbF4OLVPb5UT2bTUcKFdLcLG
        HmFfX6H4YFNJOvJtDyUheybRRprqkAdwXy66ZqLpGTrIzULxnOQkdzAwSFqobEJOd3MtzZosbiHSe
        cmaT6fBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qedAq-002aRz-2n;
        Fri, 08 Sep 2023 15:13:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE5F2300472; Fri,  8 Sep 2023 17:13:33 +0200 (CEST)
Date:   Fri, 8 Sep 2023 17:13:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Adam Dunlap <acdunlap@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Message-ID: <20230908151333.GL19320@noisy.programming.kicks-ass.net>
References: <20230906224541.2778523-1-acdunlap@google.com>
 <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
 <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
 <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
 <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
 <0d8a35c9-82ca-188a-529d-65fd01c40149@amd.com>
 <cc90c896-7581-62b5-4836-971e9ca8fac0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc90c896-7581-62b5-4836-971e9ca8fac0@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 07:48:58AM -0700, Dave Hansen wrote:
> On 9/8/23 06:13, Tom Lendacky wrote:
> > On 9/7/23 14:12, Dave Hansen wrote:
> >> But seriously, is it even *possible* to spin up a SEV-SNP VM what
> >> doesn't have NX?
> > 
> > It is a common path, so while an SEV guest would have NX support, you
> > would first have to determine that it is an SEV guest. That would take
> > issuing a CPUID instruction in order to determine if a particular MSR
> > can be read...
> 
> I was thinking more along the lines of telling folks that if they want
> to turn SEV-SNP support on, they also have to give up on running on a
> !NX system.  That would be a _bit_ nicer than just refusing to boot on
> all !NX systems.

I think there were a very limited amount of !NX P4 class x86_64 systems.
I vote in favour of dropping them into the museum bucket, they get to
run an old kernel.

Andrew and me looked at this a few months ago, but I forgot all details
again :/
