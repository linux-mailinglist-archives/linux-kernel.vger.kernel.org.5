Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541517B291D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjI1X5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1X5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9D195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695945407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmH6ulJd+9yyiGz4CzogSJiZ2VjE+uu1xK5/kan0/PQ=;
        b=Po0Uo66sg7JMps6ecBrt3CDRIrgofV1dgM8zLb5RER6nryEmegrm68VNgouk2V+pDae8pi
        faKy1Znn+KZHlQ9NhBUBpEEkN7Ivj9/Uq3AsGY9p++2A6H7xtEuwN2yDEGCZrNPwux5Kex
        HYzEn3c/pwpPrl2U7oFFo8JyIheHK4s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440--9d5HYC4NbCzZbJc3VfQuQ-1; Thu, 28 Sep 2023 19:56:42 -0400
X-MC-Unique: -9d5HYC4NbCzZbJc3VfQuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9C693811F22;
        Thu, 28 Sep 2023 23:56:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1A440C6E76;
        Thu, 28 Sep 2023 23:56:39 +0000 (UTC)
Date:   Fri, 29 Sep 2023 07:56:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, stanislav.kinsburskii@gmail.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-mm@kvack.org, kys@microsoft.com,
        jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <ZRYStfGZ0/FrRh8Z@MiWiFi-R3L-srv>
References: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
 <64208.123092816192300612@us-mta-483.us.mimecast.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64208.123092816192300612@us-mta-483.us.mimecast.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/23 at 07:46pm, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 12:16:31PM -0700, Dave Hansen wrote:
> > On 9/27/23 17:38, Stanislav Kinsburskii wrote:
> > > On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
> > >> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> > >>> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
> > >> ...
> > >>> Well, not exactly. That's something I'd like to have indeed, but from my
> > >>> POV this goal is out of scope of discussion at the moment.
> > >>> Let me try to express it the same way you did above:
> > >>>
> > >>> 1. Boot some kernel
> > >>> 2. Grow the deposited memory a bunch
> > >>> 5. Kexec
> > >>> 4. Kernel panic due to GPF upon accessing the memory deposited to
> > >>> hypervisor.
> > >>
> > >> I basically consider this a bug in the first kernel.  It *can't* kexec
> > >> when it's left RAM in shambles.  It doesn't know what features the new
> > >> kernel has and whether this is even safe.
> > >>
> > > 
> > > Could you elaborate more on why this is a bug in the first kernel?
> > > Say, kernel memory can be allocated in big physically consequitive
> > > chunks by the first kernel for depositing. The information about these
> > > chunks is then passed the the second kernel via FDT or even command
> > > line, so the seconds kernel can reserve this region during booting.
> > > What's wrong with this approach?
> > 
> > How do you know the second kernel can parse the FDT entry or the
> > command-line you pass to it?
> > 
> > >> Can the new kernel even read the new device tree data?
> > > 
> > > I'm not sure I understand the question, to be honest.
> > > Why can't it? This series contains code parts for both first and seconds
> > > kernels.
> > 
> > How do you know the second kernel isn't the version *before* this series
> > gets merged?
> > 
> 
> The answer to both questions above is the following: the feature is deployed
> fleed-wide first, and enabled only upon the next deployment.
> It worth mentioning, that fleet-wide deployments usually don't need to support
> updates to a version older that the previous one.
> Also, since kexec is initialited by user space, it always can be
> enlightened about kernel capabilities and simply don't kexec to an
> incompatible kernel version.
> One more bit to mention, that it real life this problme exists only
> during initial transition, as once the upgrade to a kernel with a
> feature has happened, there won't be a revert to a versoin without it.
> 
> > ...
> > >> I still think the only way this will possibly work when kexec'ing both
> > >> old and new kernels is to do it with the memory maps that *all* kernels
> > >> can read.
> > > 
> > > Could you elaborate more on this?
> > > The avaiable memory map actually stays the same for both kernels. The
> > > difference here can be in a different list of memory regions to reserve,
> > > when the first kernel allocated and deposited another chunk, and thus
> > > the second kernel needs to reserve this memory as a new region upon
> > > booting.
> > 
> > Please take a step back from your implementation for a moment.  There
> > are two basic design points that need to be considered.
> > 
> > First, *must* "System RAM" (according to the memory map) be persisted
> > across kexec?  If no, then there's no problem to solve and we can stop
> > this thread.  If yes, then some mechanism must be used to tell the new
> > kernel that the "System RAM" in the memory map is not normal RAM.
> > 
> > Second, *if* we agree that some data must communicate across kexec, then
> > what mechanism should be used?  You're arguing for a new mechanism that
> > only new kernels can use.  I'm arguing that you should likely reuse an
> > existing mechanism (probably the UEFI/e820 maps) so that *ALL* kernels
> > can consume the information, old and new.
> > 
> 
> I'd answer yes, "System MAP" must be persisted across kexec.
> Could you elaborate on why there should be a mechanism to tell the
> kernel anything special about the existent "System map" in this context?
> Say, one can reserve a CMA region (or a crash kernel region, etc), store
> there some data, and then pass it across kexec. Reserved CMA region will
> still be a part of the "System MAP", won't it?

Well, I haven't gone through all the discusison thread and clearly got
your intention and motivation. But here I have to say there's
misunderstanding. At least I am astonished when I heard the above
description. Who said a CMA region or a crahs kernel region need be
passed across kexec. Think kexec as a bootloader, in essence it's no
different than any other bootloader. When it jumps to 2nd kernel, the
whole system will be booted up and reconstructed on the system resources.
All the difference kexec has is it won't go through firmware to do those
detecting/testing/init. If the intentionn is to preserve any state or
region in 1st kernel, you absolutely got it wrong.

This is not the first time people want to put burden on kexec because
of a specifica scenario, and this is not the 2nd time, and not 3rd time
in the recent 2 years. But I would say please think about what is kexec
reboot, what we expect it to do, whether the problem be fixed in its own
side.

