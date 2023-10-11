Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8B7C54D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjJKNIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJKNIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:08:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30378B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:08:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697029691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcBTZkFrKCC9+uriZsI68GWlw6IK9Tb1wdFpYBJJCYg=;
        b=HRCnUMdudkR0auWBbsD9vd5nJL5XsHWCK+TpeuH+ljrS+yAuh7yWwHQXVWHQtoSQ/Dg4hQ
        DWGlyJST7xM6ZlxJvio94UFxahqzw9eDXFuuGQq1XR0dnBTm+3zQOmKYF89WFsvw7OniM+
        kJp5ZeSLgo4PWDDYMgaAreJD+C8wEdJ1Sdi1UvN8LRwpbS8q03enfWDgv4KxdGWX1c1q9w
        OywHOoNEYPAT6HUmGSPqAF/N2SfS5SLoIAWjZ4iyMqCdLVLAbKC+XUXnpOuo+Ra6awNvx3
        lVy5ry0vgpgz08y4o/l0CpqmQGfVKto/KhbPKqAYnfxzhXtz+Nzvu1rstgmm7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697029691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcBTZkFrKCC9+uriZsI68GWlw6IK9Tb1wdFpYBJJCYg=;
        b=hIKtc13IGbcJcA+HEU8u0u/QMSxtdx3S9gGt4y4EK3K7p6Xxo3NxxcTFFuk5co9X8DfKDy
        Lvpx0r8mBCR9UbDA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
In-Reply-To: <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
Date:   Wed, 11 Oct 2023 15:08:11 +0200
Message-ID: <87il7dl32c.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2023 at 16:13, Kirill A. Shutemov wrote:
> The function cpu_hotplug_not_supported() can be called to indicate that
> CPU hotplug should be disabled. It does not prevent the initial bring up
> of the CPU, but it stops subsequent offlining.

This tells me what the patch is doing, but not the why.

> This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.

> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -132,6 +132,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_not_supported(void);

This function name sucks.

The point is as you explained to prevent offlining, but not onlining. So
can we please make this very clear? Something like:

    cpu_hotplug_disable_offlining()

> +/* Cleared if platform declares CPU hotplug not supported */
> +static bool cpu_hotplug_supported = true;

Again. This is not about disabling hotplug all together. Something like:

static bool cpu_hotplug_offline_disabled;

Which expresses clearly what this is about and does not require this
awkward negation.

Thanks,

        tglx
