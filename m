Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4B7A8CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjITTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjITTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:32:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8141B4;
        Wed, 20 Sep 2023 12:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05091C433AD;
        Wed, 20 Sep 2023 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695238325;
        bh=bcP72m9EhmjsOzjFU5Em8mvcDsCEuWWFRjHnralHl2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC1ZMnQiXtxcKFL3Cj3sqwJdmfq4v5O2Asja5tvU1SeCJUZPzH/pK4gaJYnHyPTgY
         abWhQpwerZ44NlDpaEIK1x+H9IOTbNAPLXiMkLMCSO7ri85yks004apzex0V2HHbx6
         UeC5RwBV+YwrfT/hd7PMuAgP4gn7OpjnXEHQUw9xqAvqc3Z4dj+AUK31hETnaS34gE
         TCqskU9N+1fiySWy822kzYIh/PLHAGRkWPpoWGiihAzbT512i3sMV1Gjuy7LLoSkSM
         zvoqP9J58veqwNNchMhyNEj6opXTbCCKkGijfYhJcpXeJuaH6a9n1GXs0926935X0+
         rNENwAmVDy/4g==
Date:   Wed, 20 Sep 2023 12:32:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
Message-ID: <20230920193203.GA914@sol.localdomain>
References: <20230920060615.GA2739@sol.localdomain>
 <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Sep 20, 2023 at 11:48:26AM -0700, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 23:06, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This would be the potential change, BTW:
> 
> Entirely regardless of your fundamental question, no, that's not the
> potential change.
> 
> That causes a crng_reseed() even if the write fails completely and
> returns -EFAULT.
> 
> So at a *minimum*, I'd expect the patch to be be something like
> 
>         memzero_explicit(block, sizeof(block));
> -       return ret ? ret : -EFAULT;
> +       if (!ret)
> +               return -EFAULT;
> +       crng_reseed(NULL);
> +       return ret;
> 
> but even then I'd ask
> 
>  - wouldn't we want some kind of minimum check?
> 
>  - do we really trust writes to add any actual entropy at all and at what point?
> 
> which are admittedly likely the same question just in different guises.

Whether to credit entropy for writes to /dev/{u,}random is an unrelated topic,
and the answer is clearly "no, we must not, and we never have" (as I mentioned
in the second paragraph of my email).  I understand the last discussion
https://lore.kernel.org/lkml/20220322191436.110963-1-Jason@zx2c4.com/T/#u
diverged into both topics, but they're not directly related.  Reseeding the CRNG
just makes it up to date with the entropy pool; nothing more than that.

Yes, obviously there's no point in reseeding if nothing actually got added, so
we could skip the reseed in that case if we want to.

> 
> Also, are there any relevant architectures where
> "try_to_generate_entropy()" doesn't work? IOW, why do you even care?
> 

There are, as shown by the fact that the full unification of /dev/urandom and
/dev/random failed yet again.  But similarly, that's unrelated.  The actual
question, which I'm attempting to start a discussion about without getting
sidetracked into questions that may seem related but actually aren't, is simply
whether writes to /dev/{u,}random should immediately affect reads.

- Eric
