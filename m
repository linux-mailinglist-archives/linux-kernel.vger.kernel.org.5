Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A007FAADC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjK0UEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0UEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:04:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43520C2;
        Mon, 27 Nov 2023 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HKdTKht77swWp6IqbMhOYILRR0g0Evek+a+XDBEGFI4=; b=VlhbNNJtOQjRl9xNXhif3pyBI3
        Yp697PDT+1EY5w8uqPMVRgSViNRDlwsEBioaXw3hqY3eTB8lhCbqt0zd3cnGZiqHwqP840guPwjV2
        oriE6LXZ82ilVLw6slHwTwphcRMD/0Nd1NsiEuOe9r4lBzOcT6SSF2nX3osd+EUhPcnLH6Ranfo9H
        Bv1hzhp/gFFn6ry0jRZXH/H0Gc8LitSNJ60ue7C967EBwiz7XA/OdUI9oaNSFUlcKQNcT7WMTubkf
        R85oEhWPha2wXYJ4yiCw7hSoq1yPIGJKgfABhWmW6p9IKG8obBpzJRziZFbyBKuL64aiz/cSiRsQN
        YX0jqE5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7hp0-00BhJQ-Ds; Mon, 27 Nov 2023 20:03:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B60BD3002F1; Mon, 27 Nov 2023 21:03:08 +0100 (CET)
Date:   Mon, 27 Nov 2023 21:03:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Graf <graf@amazon.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Forrest Yuan Yu <yuanyu@google.com>,
        James Gowans <jgowans@amazon.com>,
        James Morris <jamorris@linux.microsoft.com>,
        John Andersen <john.s.andersen@intel.com>,
        Marian Rotariu <marian.c.rotariu@gmail.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
        Thara Gopinath <tgopinath@microsoft.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v2 18/19] heki: x86: Protect guest kernel memory
 using the KVM hypervisor
Message-ID: <20231127200308.GY3818@noisy.programming.kicks-ass.net>
References: <20231113022326.24388-1-mic@digikod.net>
 <20231113022326.24388-19-mic@digikod.net>
 <20231113085403.GC16138@noisy.programming.kicks-ass.net>
 <b1dc0963-ab99-4a79-af19-ef5ed981fa60@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1dc0963-ab99-4a79-af19-ef5ed981fa60@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:05:23AM -0600, Madhavan T. Venkataraman wrote:
> Apologies for the late reply. I was on vacation. Please see my response below:
> 
> On 11/13/23 02:54, Peter Zijlstra wrote:
> > On Sun, Nov 12, 2023 at 09:23:25PM -0500, Mickaël Salaün wrote:
> >> From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> >>
> >> Implement a hypervisor function, kvm_protect_memory() that calls the
> >> KVM_HC_PROTECT_MEMORY hypercall to request the KVM hypervisor to
> >> set specified permissions on a list of guest pages.
> >>
> >> Using the protect_memory() function, set proper EPT permissions for all
> >> guest pages.
> >>
> >> Use the MEM_ATTR_IMMUTABLE property to protect the kernel static
> >> sections and the boot-time read-only sections. This enables to make sure
> >> a compromised guest will not be able to change its main physical memory
> >> page permissions. However, this also disable any feature that may change
> >> the kernel's text section (e.g., ftrace, Kprobes), but they can still be
> >> used on kernel modules.
> >>
> >> Module loading/unloading, and eBPF JIT is allowed without restrictions
> >> for now, but we'll need a way to authenticate these code changes to
> >> really improve the guests' security. We plan to use module signatures,
> >> but there is no solution yet to authenticate eBPF programs.
> >>
> >> Being able to use ftrace and Kprobes in a secure way is a challenge not
> >> solved yet. We're looking for ideas to make this work.
> >>
> >> Likewise, the JUMP_LABEL feature cannot work because the kernel's text
> >> section is read-only.
> > 
> > What is the actual problem? As is the kernel text map is already RO and
> > never changed.
> 
> For the JUMP_LABEL optimization, the text needs to be patched at some point.
> That patching requires a writable mapping of the text page at the time of
> patching.
> 
> In this Heki feature, we currently lock down the kernel text at the end of
> kernel boot just before kicking off the init process. The lockdown is
> implemented by setting the permissions of a text page to R_X in the extended
> page table and not allowing write permissions in the EPT after that. So, jump label
> patching during kernel boot is not a problem. But doing it after kernel
> boot is a problem.

But you see, that's exactly what the kernel already does with the normal
permissions. They get set to RX after init and are never changed.

See the previous patch, we establish a read-write alias and write there.

You seem to lack basic understanding of how the kernel works in this
regard, which makes me very nervous about you touching any of this.

I must also say I really dislike your extra/random permssion calls all
over the place. They don't really get us anything afaict. Why can't you
plumb into the existing set_memory_*() family?
