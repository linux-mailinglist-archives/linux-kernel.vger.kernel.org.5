Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA88068D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376853AbjLFHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjLFHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:43:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CB1BC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:41:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFCFC433C7;
        Wed,  6 Dec 2023 07:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848517;
        bh=VWcLjdndihwJ1lairSLt4i225DLT92oa2lGQtFOVU/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCgFXbnAygRSN4e/Sboq3yK6XLi2YvAqhIvyC2sxgGurE+YAQYvh1RKaMqy1DI877
         iwH8OMjICOXqFdhXUv81ipxjjYsrWn88nukFlHrhxY1JaXEAyLTPKfupjLetubdyca
         8XEnRW06inNfANsX8b2ESSCGT9e6nLEdXLh9C3oqWDV3GeqSv6n+EIJ095FnD89dyo
         Xq0sJjuq+/xU+1Dg8Ks/jMwBwrrODQIfm1fJlQDPmUMEta5qd1kY+Gdeh6PORE5+zg
         LsdnedtLpUNW8A+XSMnD1ptTUlKLwr1NwJ+6bXKd8lBtBJeGwtRGzkSbKu1N9j2XOk
         qmuEV3h6QSYfg==
Date:   Tue, 5 Dec 2023 23:41:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        conor@kernel.org, heiko@sntech.de, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
Message-ID: <20231206074155.GA43833@sol.localdomain>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
 <20231206004656.GC1118@sol.localdomain>
 <434A2696-7C9E-4D13-9BEE-25104D37E423@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434A2696-7C9E-4D13-9BEE-25104D37E423@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Wed, Dec 06, 2023 at 03:02:40PM +0800, Jerry Shih wrote:
> On Dec 6, 2023, at 08:46, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
> >> This series depend on:
> >> 2. support kernel-mode vector
> >> Link: https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/
> >> 3. vector crypto extensions detection
> >> Link: https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@rivosinc.com/
> > 
> > What's the status of getting these prerequisites merged?
> > 
> > - Eric
> 
> The latest extension detection patch version is v5.
> Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/
> It's still under reviewing.
> But I think the checking codes used in this crypto patch series will not change.
> We could just wait and rebase when it's merged.
> 
> The latest kernel-mode vector patch version is v3.
> Link: https://lore.kernel.org/all/20231019154552.23351-1-andy.chiu@sifive.com/
> This patch doesn't work with qemu(hit kernel panic when using vector). It's not
> clear for the status. Could we still do the reviewing process for the gluing code and
> the crypto asm parts?

I'm almost ready to give my Reviewed-by for this whole series.  The problem is
that it can't be merged until its prerequisites are merged.

Andy Chiu's last patchset "riscv: support kernel-mode Vector" was 2 months ago,
but he also gave a talk at Plumbers about it more recently
(https://www.youtube.com/watch?v=eht3PccEn5o).  So I assume he's still working
on it.  It sounds like he's also going to include support for preemption, and
optimizations to memcpy, memset, memmove, and copy_{to,from}_user.

I think it would be a good idea to split out the basic support for
kernel_vector_{begin,end} so that the users of them, as well as the preemption
support, can be considered and merged separately.  Maybe patch 1 of the series
(https://lore.kernel.org/r/20231019154552.23351-2-andy.chiu@sifive.com) is all
that's needed initially?

Andy, what do you think?

- Eric
