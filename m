Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916307E75AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjKJAIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKJAIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:08:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA38D9ECE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:03:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0424C433C8;
        Fri, 10 Nov 2023 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699574634;
        bh=h8AjMlgeweBber584pcT8cef3G9RzsF/azvY3XBYmWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crAAHkbywAX0uho+8nKwbw5mdekCYhR921Wmj8yzSvKYkEm1phZ6U4it4mnSS3bKD
         apZPL146J6/id+qoH6ak/vTHZmbcSTkB8sLUg9d0WkGDyKuhn3fl3UMuy3uQGWAnz5
         QsguxjwcX6vMXhVCZ5wlF4NbHFkCD+nJEM3Vf9sigs1zwmwBJIic7auG3zYuOzYCZy
         X0ZbzCSYnKvnM+yvhJJjGgwXZuWBsi5RPFavgam6u90Ne+b5hp8RynfLs24I/vMKR1
         sXfbgPpBkbTX6gsDSM7JFqdRhfHgnpbCRsbsSpkZAwUsX+gbj9P1dcB+hO1/wj8Mj6
         O2XEVe1jyfRgg==
Date:   Thu, 9 Nov 2023 16:03:52 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH RFC 1/7] x86/head/64: Mark startup_gdt and
 startup_gdt_descr as __initdata
Message-ID: <20231110000352.zr6z6yofumdbk4wd@treble>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
 <c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com>
 <ZS0lEmEpQOz4iQ4Q@gmail.com>
 <20231017072311.GA46993@k08j02272.eu95sqa>
 <ZS6F46vJfca5f6f8@gmail.com>
 <77B66FD0-ED28-4D3F-8D28-467AC4FCD00D@zytor.com>
 <ZS/FZAq6lbxXtBtB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS/FZAq6lbxXtBtB@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:45:40PM +0200, Ingo Molnar wrote:
> 
> * H. Peter Anvin <hpa@zytor.com> wrote:
> 
> > If the goal is better KASLR, then what we really should spend time on was 
> > Kristen Accardi's fgKASLR patches, which not only exponentially(!) 
> > increases the randomization entrophy but also *actually* avoids the "one 
> > leak and it's over" problem.
> 
> Agreed. Going by this version of function-granularity KASLR from 3 years 
> ago:
> 
>   https://lwn.net/Articles/824307/
>   https://lwn.net/ml/linux-kernel/20200623172327.5701-1-kristen@linux.intel.com/
> 
> The fgKASLR feature looks entirely viable to me. Back then I presumed it 
> would get iterated beyond v3, and then it fell off my radar. :-/
> 
> If Kristen or someone else would like to dust this off & submit a fresh 
> version it would be much appreciated!

That actually got up to v10:

  https://lkml.kernel.org/lkml/20220209185752.1226407-1-alexandr.lobakin@intel.com

Anyway, I'm also very interested in this.  If nobody else is working on
it then I could give it a try.

BTW I've wondered if translation-unit granularity would be more
preferable than function granularity due to improved i-cache locality
and (possibly) easier livepatch compatibility.

-- 
Josh
