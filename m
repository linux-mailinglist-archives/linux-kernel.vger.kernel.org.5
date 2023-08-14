Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B677C24C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjHNVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjHNVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:17:42 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F6106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:17:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 93CED40E0197;
        Mon, 14 Aug 2023 21:17:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B8Av_rQgfmBJ; Mon, 14 Aug 2023 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692047857; bh=j6VfVzWruDKTogfbhfTNC0oxeVa4TEs220Igf0QpDk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVD1TC++RebC9P+BpLN9mponko9emz9R0caa9lUwKSlBw3mss/yoItiIn4J5k+Jrc
         LXu+uORAXTj9y784uNwtRVYMICnbEmMIFd1ZGZZrOCeQ/pvKYBhM7ILTZCD2Nw6E1a
         cP1JZASfvBXx9tLQmSUi2CLOwKysdLtQjSY9O+rdoo5jfxKS3UWyrmf0gwd6zp2cLv
         Itf/dMYO5maWVOPbv/DEiiUxhE1xPGyZ66utN2FfHsPAXSE6eCqoQY8UVW/DzHhq+D
         pfoA6frGkQfjm/pLtlbnxtNDvD/E9WrfgMhu/nOc+X4A76l66U9EP28TWS8pJJyyb3
         X7LhZAdG53LeSxZ8ktzjjqACqaYk/ZF2q1Nc1PDQAhykzc5JYMCL6uUKqwcC3m90e+
         gGgJJ0QCGKADMs9ayTIi8E4TEcEydsIB6UhjIkTaPCJjS7fpjOtNldnTYYECCfEdqP
         DU21uzasTvlsa/ZbSDKfc6qzEWAV4pNN/2Sqslt43f/xoZjN2GEP5W1NtQbobxXTyV
         77N/yWnzVwmeQX4mkWsM9wO6KxZoGVS+cAq2NyYx6OU5ofu3wnACorIza/QBKm86uV
         LhMEwDoe6m7Am82izNWMnwDI9MLV4H7yujXaVn+NWWU/3jH7hR/twsX6BCIS8LB9yT
         s5dl7UmRzdd7oUcme3CqYp6M=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3251340E0195;
        Mon, 14 Aug 2023 21:17:32 +0000 (UTC)
Date:   Mon, 14 Aug 2023 23:17:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Disable the mitigation on unaffected
 configurations
Message-ID: <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814205300.krikym7jeckehqik@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:53:00PM -0700, Josh Poimboeuf wrote:
> cpu_smt_possible() already does that.

Ok.

> 2. ENUMERATION OF NEW CAPABILITIES

Yes, exactly. On the next page: "Hypervisor software should
synthesize... " I got confused initially too.

> Since technically the CPU is affected, I'm thinking it should say
> "Mitigation: SMT disabled" or such, instead of "Not affected".

Lemme see how ugly it becomes tomorrow.

> Hm?  You mean the *_NO ones that determine whether the BUG bits get set
> in the first place?  How do they print "Not affected"?

If SMT is disabled on those configurations, it is not affected. But ok,
"SMT disabled".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
