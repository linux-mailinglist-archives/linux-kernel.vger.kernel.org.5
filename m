Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E47708BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHDTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHDTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D566CB9;
        Fri,  4 Aug 2023 12:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735E562101;
        Fri,  4 Aug 2023 19:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C65C433C8;
        Fri,  4 Aug 2023 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691176457;
        bh=KjLfStABFwUIAtuSAKNcnmOi2LteNNPlPp20ShgMzp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z0eePU9NC4Pz6n6vXCNvjXjwlqXDzzzr5i3qU2pMQKHmkgb5AhlUyg9FUUtR84vnj
         Zhk+jFYTAa/8XPVFoOiFEMxePF2hfUOKoJRQWf4aPeUTeLUzOv9oQhLUykgZa02sUW
         i8K5cksG4rlxLiAtQeTF7k4fI/GPmi0vCP1n8tWY=
Date:   Fri, 4 Aug 2023 12:14:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v4 1/6] mm: enable page walking API to lock vmas during
 the walk
Message-Id: <20230804121416.533bb81336ded8f170da097e@linux-foundation.org>
In-Reply-To: <20230804152724.3090321-2-surenb@google.com>
References: <20230804152724.3090321-1-surenb@google.com>
        <20230804152724.3090321-2-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 08:27:19 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> walk_page_range() and friends often operate under write-locked mmap_lock.
> With introduction of vma locks, the vmas have to be locked as well
> during such walks to prevent concurrent page faults in these areas.
> Add an additional member to mm_walk_ops to indicate locking requirements
> for the walk.
> 
> ...
>
>  18 files changed, 100 insertions(+), 20 deletions(-)
> 

That's a big patch for a -stable backport.

Presumably the various -stable maintainers will be wondering why we're
doing this.  But, as is so often the case, the changelog fails to
describe any user-visible effects of the change.  Please send this info
and I'll add it to the changelog.


