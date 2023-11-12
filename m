Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418E7E9176
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjKLPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:44:55 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B3270C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:44:51 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-113-74.bstnma.fios.verizon.net [173.48.113.74])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3ACFiOI9009744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 10:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1699803867; bh=Ikwnvi8v+x4raoC2mWubQl6+3PFm9Hj28qG7SUc77ew=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=GMFvLmPAS6OOIns1ZDPU8KTtXZyEsv5MS10k7s3A2qcSYMxz8e4ArvuuILYzYv4rh
         wb6zg9+RG+xVYBm6qZ6S1rm2E0IdMrVxEFhSgJzKu7SSc15r+/0Sr8UHCm3dNJxLAN
         Pyb+D+EW9GsywE4Gg4Eog+cS17Sp0dOMBmiXoVBGBkrTxHDUUrw9e5mDIAwP64DqbI
         WJcRJcsbGLJwh6Zq3eT8Spyq9WY654ZCdTujNpW0js6LLVlAHoRSlFHRryYDHVkt76
         U/z7FvMBhDuuDFnEn7V2M4ePn/LdepeM7w1FNLfrVfRmIsxb+Lr1bTFRZNmbhcMz5c
         1wLOQBRldC+Tw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 15A0E15C02AA; Sun, 12 Nov 2023 10:44:24 -0500 (EST)
Date:   Sun, 12 Nov 2023 10:44:24 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jasper Niebuhr <yjnworkstation@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] exitz syscall
Message-ID: <20231112154424.GE35991@mit.edu>
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu>
 <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
 <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 11:03:43AM +0100, Jasper Niebuhr wrote:
> 
> Do you think it could make sense to enable zeroing on exit only for
> ranges of memory (base + len) with a config dictating the max amount
> of bytes (or pages or whatever) that a single process is allowed to
> flag for zeroing? This way the DoS issue is effectively solved and the
> config could always be set to 0 (by default I guess), which would
> effectively leave any common system unchanged. The users that actually
> want to use this feature could then decide on their own how much it is
> worth to them and how big of a task they want the kernel to perform at
> max on exit.

How about adding a flag MLOCK_ZERO_ON_FREE used by the mlock2() system
call?  The number of pages which an unprivileged process can lock is
already capped via RLIMIT_MEMLOCK (or else mlock would be it own
denial of service attack).  That way if process dies from crash, the
keys would be zero'ed.

The argument against this is that this functionality could be an
attractive nuisance, since best practice is to zero any keying
information the moment you no longer need it, instead of depending on
magic OS behavior to take care of something that you darned well
should be doing yourself.  I understand that in your case, you're
trying to protect a key manager, whose *job* it is to hold onto keys
for long periods of time.  So this advice might not be as applicable
in your case.

I do suspect that the chances that trying to grab a memory page after
it has been released is one of the least likely way keys would be
exfiltrated.  I'd be much more worried about stack/buffer overflow
attacks in any of the libraries used by the key manager, for example.
Or zero-day attacks on the kernel which then grab the keys from the
key manager process while it is still running....

Cheers,

					- Ted

