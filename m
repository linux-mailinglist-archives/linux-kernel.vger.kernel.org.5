Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1267DA77C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJ1OH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1OH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 10:07:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA459C
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:07:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698502042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAZ8/ypQKsb51hCx92Cob0mTqPJOPxsmPa1MSwvVBmI=;
        b=YsJghcFYnSnqaFixz9uQHA7H4GDu4EHF504t285r81imS4UrUXnPT7YZN34If4C/dh+bOP
        K5ZdubvR6YTKatdEDUX1TC7aRCAyU5/iYVjBzvRMnmc2D45lUbRwQG+3B2wOs+kERUPnOu
        vUu92xav5dw2XbLRya3dl0Ntcxr/dpI9kSWW0r2h9hEPu0Vo2+4wG9FpVoVhvo2hNBd0gd
        8toq2qfb5G0Ca0iLOmPt/iklKwmQZoQAc04gz4EWI+/wM/mw8DgWNz6+X5jfaz0HrwnUcE
        oODwu7U1noneAif+trmRttQ7fMZOD9YS5PqnruGGQYzWNJDUpZTHtszTjNQtUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698502042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAZ8/ypQKsb51hCx92Cob0mTqPJOPxsmPa1MSwvVBmI=;
        b=1xqjRVFuL6iiObo0Dw71zi0nfUttrZD+bjTM8N6jPRzmNK6+9jzAnIn6ESFXTGWIc3WdYN
        G+CPAZn6ODbbhjAg==
To:     "Huang, Kai" <kai.huang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
In-Reply-To: <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
 <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
 <20231023153142.bes7zxcjc2soihsl@box>
 <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
Date:   Sat, 28 Oct 2023 16:07:21 +0200
Message-ID: <87cywy263q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 22:07, Kai Huang wrote:
> On Mon, 2023-10-23 at 18:31 +0300, kirill.shutemov@linux.intel.com wrote:
>> On Mon, Oct 23, 2023 at 09:30:59AM +0000, Huang, Kai wrote:
>> > IMHO it's a little bit odd to have two mechanisms in place, even in this middle
>> > state patch.  Is it better to completely replace CC_ATTR_HOTPLUG_DISABLED with
>> > the new cpu_hotplug_offline_disabled in this patch? You can explicitly call
>> > cpu_hotplug_disable_offlining() in tdx_early_init() so no functional change is
>> > done.
>> 
>> I can. But I don't see how it makes a difference.
>
> Personally I think this is better because it is odd to have two mechanisms in
> place even temporarily especially when we can avoid it.  But no hard opinion. 
> Up to you.

It's not at all better because having this clear split makes it simpler
to review and ponder the individual changes.

Thanks,

        tglx


