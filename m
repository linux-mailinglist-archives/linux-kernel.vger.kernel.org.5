Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B0F7CE1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbjJRPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjJRPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:52:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A9123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:52:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CE7C433C8;
        Wed, 18 Oct 2023 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697644370;
        bh=b8LsAR2QdX3IC2gaSa678S7SamLDd+g6f++6ZqtXOmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDurZJ/tH9/Dcq2NUUAnR7bwtgDl5thIrctfw+s4q4F7B9z+LCEL9V4leztRfz6Oy
         QN+ti9o7Lk4il2Xp2hnzjsN60DUZJkyYwxwhGWgCcp/J6tv9XrZpdoii3QHMM6q8IS
         FBIF1WP+glbZTrUhUIkqwPEPvI4kpzhkxsSOShA4=
Date:   Wed, 18 Oct 2023 08:52:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Philip Li <philip.li@intel.com>, oe-kbuild@lists.linux.dev,
        Lorenzo Stoakes <lstoakes@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed
 'vm' could be null (see line 3667)
Message-Id: <20231018085248.6f3f36101cbdfe0990c8b467@linux-foundation.org>
In-Reply-To: <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
        <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
        <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
        <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
        <ZS/TVMT9ed7OdyNy@rli9-mobl>
        <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 23:15:31 +0800 Baoquan He <bhe@redhat.com> wrote:

> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 18 Oct 2023 22:50:14 +0800
> Subject: [PATCH] mm/vmalloc: fix the unchecked dereference warning in vread_iter()
> Content-type: text/plain
> 
> LKP reported smatch warning as below:
> 
> ===================
> smatch warnings:
> mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> ......
> 06c8994626d1b7  @3667 size = vm ? get_vm_area_size(vm) : va_size(va);
> ......
> 06c8994626d1b7  @3689 else if (!(vm->flags & VM_IOREMAP))
>                                  ^^^^^^^^^
> Unchecked dereference
> =====================
> 
> So add checking on whether 'vm' is not null when dereferencing it in
> vread_iter(). This mutes smatch complaint.
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3813,7 +3813,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  
>  		if (flags & VMAP_RAM)
>  			copied = vmap_ram_vread_iter(iter, addr, n, flags);
> -		else if (!(vm->flags & VM_IOREMAP))
> +		else if (!(vm && (vm->flags & VM_IOREMAP)))
>  			copied = aligned_vread_iter(iter, addr, n);
>  		else /* IOREMAP area is treated as memory hole */
>  			copied = zero_iter(iter, n);

So is this not a real runtime bug?  We're only doing this to suppress a
smatch warning?

If so, can we please include a description of *why* this wasn't a bug? 
What conditions ensure that vm!=NULL at this point?
