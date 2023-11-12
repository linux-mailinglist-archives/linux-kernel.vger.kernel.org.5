Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A87E922C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjKLTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:03:51 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3D212E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:03:48 -0800 (PST)
Received: from letrec.thunk.org ([65.217.157.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3ACJ3K0s000305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 14:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1699815802; bh=mwpvDhP8rr4vCE2dpGWSyhy+tEU0tBPEvXrUqeqBQe4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=gl21uuvQut9jucRhv2jhOkv6N9F9tRswiM0auY4aN1aXrPi8o/n17uKOeqXKpgT8y
         3BlFYcfqtvYlwmIu6Cu54pCgwoijYatC40AlfRkTR9jG5YpCVBrBkspUF9BH/1x5tP
         iSrLN9k+Pk+UqHbn9RXgFLwF5YiqkE+JIgMZJ6V6i9uFicDlIsdhP0m8twwwaVXtr2
         qqI1a1v3VDgdhGI0T9DxcRWHNXlXbbY5w/ndoBO2fu9IFQdA986lJAwxQyOKuOrskt
         NWvIBrLNmVMiI56e2SehK0pf5PNYS9Lr7reKK3iRU8DiuUhDSOY3gWtgLgTLxOscZj
         p/zp9YJo6jbwQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A70068C0345; Sun, 12 Nov 2023 14:03:19 -0500 (EST)
Date:   Sun, 12 Nov 2023 14:03:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jasper Niebuhr <yjnworkstation@gmail.com>,
        Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] exitz syscall
Message-ID: <ZVEhd1ZbzBlawHz8@mit.edu>
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu>
 <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
 <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com>
 <20231112154424.GE35991@mit.edu>
 <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 10:50:10AM -0800, Linus Torvalds wrote:
> 
> However, it still needs to also make sure that the memory in question
> is not file-backed etc. Which the patch I saw didn't seem to do
> either.

Well, yes.  If the program isn't using a small amount of anonymous
memory, which is also mlock'ed so it doesn't get written to swap, the
rest of it is a total waste of time.

And from what I've seen from the O_PONIES debate (e.g., users
truncating files and rewriting them, and then complaining when the
top-ten score file disappears after the system crashes when they close
the OpenGL connection to the proprietary kernel driver), my basic
assumption is that anything application writers will get wrong, they
probably will....

     	      		  	       - Ted
