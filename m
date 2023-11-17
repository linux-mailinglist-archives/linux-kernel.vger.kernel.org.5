Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9147EF207
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbjKQLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKQLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:44:48 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8698;
        Fri, 17 Nov 2023 03:44:45 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A97140E0030;
        Fri, 17 Nov 2023 11:44:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GO9dGrUiVnGR; Fri, 17 Nov 2023 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700221479; bh=j36hMrH3K4SVbtqb212vDUmrokFUM95lH3N8+utHpM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z091vdAPt+a3wH6+ryDgjKAqa3uZtWqO+x7+XYF/ovEqONfJI9nPrYrFISNnFuNnc
         uom8wJOhpTp09/ysBobaPRIDiOWUFJ/pNBL6WEa/OuUaS5WOnLc0BflwBek54BpyQg
         e3HX7lVcOktfVXEN1oyKZrdzM/m0yDw9KnmKhNA1BABBNrOjZ1KN9e2vHAlzQgV21N
         xy4SD544LKq+ZpZNx6HCDzQ/QAGAxTdSu/SRhT/1fVtzyTAzVene9BU/m1HFp0Tx1N
         REV5VoqzAbYvyiAdEHcqQM2WCvpA3OP87AepABevqg0Am55yUWw1V2jJuAQRMiM38k
         cqzbY7FUZm3DZ4AqlG3DGrMEMLKERnECX4gMErSa3+UTUERJlPIBalEQ2qgpE6MRax
         icXoqPNQalIrRS8iwP8aDEeod6OiIr0u6vbfEdH8ZibBMKA1Xz2mqZ5H02OlI6SMrB
         mYbnfq/y9+pa09xWOLAuaow6KC/tLeKdBjB2dRolcTvd9qKLjx5XbEJeRScSpS0nxn
         1qh/67XdbikL4CxlPGkHR1w3zImdiLxF3LJaQ3PuGDTOAduk2wawRJYV4Bfe8Kr/Wq
         cNTpryL94Ub87sFixzK21XjMoWrC2oJvFnGWrBDJiT0nvEvEz98mEs+XnX19A2OZIv
         V8Wo8hyZMj7BFcAVivMP/x6o=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2ADD540E0031;
        Fri, 17 Nov 2023 11:44:22 +0000 (UTC)
Date:   Fri, 17 Nov 2023 12:44:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might as well Cc toolchains...

On Thu, Nov 16, 2023 at 11:48:18AM -0500, Linus Torvalds wrote:
> Hmm. I know about the '-mstringop-strategy' flag because of the fairly
> recently discussed bug where gcc would create a byte-by-byte copy in
> some crazy circumstances with the address space attributes:
> 
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111657

I hear those stringop strategy heuristics are interesting. :)

> But I incorrectly thought that "-mstringop-strategy=libcall" would
> then *always* do library calls.

That's how I understood it too. BUT, reportedly, small and known sizes
are still optimized, which is exactly what we want.

> So I decided to test, and that shows that gcc still ends up doing the
> "expand small constant size copies inline" even with that option, and
> doesn't force library calls for those cases.

And you've confirmed it.

> IOW, my assumption was just broken, and using
> "-mstringop-strategy=libcall" may well be the right thing to do.

And here's where I'm wondering whether we should enable it for x86 only
or globally. I think globally because those stringop heuristics happen,
AFAIU, in the general optimization stage and thus target agnostic.

> Of course, it's also possible that with all the function call overhead
> introduced by the CPU mitigations on older CPU's, we should just say
> "rep movsb" is always correct - if you have a new CPU with FSRM it's
> good, and if you have an old CPU it's no worse than the horrendous CPU
> mitigation overhead for function call/returns.

Yeah, I think we should measure the libcall thing and then try to get
the inlined "rep movsb" working and see which one is better. You do have
a point about that RET overhead after each CALL.

> I really hate the mitigations. Oh well.

Tell me about it.

> Ayway, maybe your patch is the RightThing(tm). Or maybe we should use
> 'rep_byte' instead of 'libcall'. Who knows..

Yeah, lemme keep playing with this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
