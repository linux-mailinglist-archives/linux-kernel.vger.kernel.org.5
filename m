Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9214C805F71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjLEU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjLEU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:29:51 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEC181;
        Tue,  5 Dec 2023 12:29:58 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 18AFD40E014B;
        Tue,  5 Dec 2023 20:29:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4YEoh4W8wn-3; Tue,  5 Dec 2023 20:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701808194; bh=yB72VxK/0IQl3pur+X+/eX4EI1aY2v5x0vLEBbpCd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIthWYpTbMK0CmeXE3hZeqs8Zowj8EzqAaqEzRtGvMWJEY9OicO1L4rgb5NGO/cFh
         KbUzib78+xQk/ODh5jPhwPi6M+uPK4HyG9iAF6fK8XAkQvqPxUXX1vLmGAgBNaDc8P
         QJ8R+AH4zVMD/OT9aZcKE+cNdWx8LdSCevu1iVheOIwg4ln9MqWaO+NP4zjFh2dDuB
         3W5XSvi3I0K/M/ZUuoiE5oHvtiyhRcqP/jB40a5CFcTw68JQ1HN+SoCpAUPjgXILzC
         0OrG+FfxawWJNaRBhhFGij21/IsthdN9DBzO6+0lWxAt1XQTbIDeGn5IptAVUKP8iR
         ood6UQKjaYPsDFwTt6Im0LXGKY9dQtdzRFnJDOmm5o0XazvH/Aj8ZNEas6QvJREuEm
         U7/lo8Y5QsKowYoGL8Xd9f+uKDOimkfD57IFugVuESJk2gr6QE7I9xQ2BzEvK0sagP
         +eXDgyaGU6httlGOTnyiKRCJWxecWIzXy2Qj5wGkpF4NTfWtzarVAmfHOYwLDyTivX
         Fuh9rGE74pkyFvt3hNZrrrWjD9CUg/6pXNnQ9eZPJ9/WlrzCkgGwJLbbR6zCWvtlFW
         sJ0l2GZlX85PBitwagY0/XBNviHTudAzZIKfsdslgFpW0P3/e7HdPr0FJsWACGi4gB
         MNTCED08c+B70gZyElT2OcOY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE2D240E0195;
        Tue,  5 Dec 2023 20:29:27 +0000 (UTC)
Date:   Tue, 5 Dec 2023 21:29:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "sagis@google.com" <sagis@google.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v15 22/23] x86/mce: Improve error log of kernel space TDX
 #MC due to erratum
Message-ID: <20231205202927.GJZW+IJ0NelvVmEum/@fat_crate.local>
References: <cover.1699527082.git.kai.huang@intel.com>
 <9e80873fac878aa5d697cbcd4d456d01e1009d1f.1699527082.git.kai.huang@intel.com>
 <20231205142517.GBZW8yzVDEKIVTthSx@fat_crate.local>
 <0db3de96d324710cef469040d88002db429c47e6.camel@intel.com>
 <20231205195637.GHZW+Add3H/gSefAVM@fat_crate.local>
 <2394202d237b4a74440fba1a267652335b53b71d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2394202d237b4a74440fba1a267652335b53b71d.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:08:34PM +0000, Huang, Kai wrote:
> The difference is for TDX host the kernel needs to initialize the TDX module
> first before TDX can be used.  The module initialization is done at runtime, and
> the platform_tdx_enabled() here only returns whether the BIOS has enabled TDX.
> 
> IIUC the X86_FEATURE_ flag doesn't suit this purpose because based on my
> understanding the flag being present means the kernel has done some enabling
> work and the feature is ready to use.

Which flag do you mean? X86_FEATURE_TDX_GUEST?

I mean, you would set a separate X86_FEATURE_TDX or so flag to denote
that the BIOS has enabled it, at the end of that tdx_init() in the first
patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
