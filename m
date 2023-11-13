Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73DE7E9D16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjKMN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKMN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:26:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6791732
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:26:41 -0800 (PST)
Received: from letrec.thunk.org ([12.191.197.195])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3ADDQLDS005972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 08:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1699881985; bh=A3cLrLsAD7R33FPlXA97BU26N5BmXyNiPD9pSS1uKUQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=i7ZrQb3Qs3XpKtboy0+/4evxuo59TCF46dEv7qxwTbVc3/dOgUfj9E6hTOyDUrJfF
         VkWoMMPfGr6h+e+W2NWTwj4chpY65ICyA0nK9E7IG4KeoCacKGyF4eH/jbAzs87Pno
         oGZJJ95/6r2KnOv5KHnIII147SCq4F3byW4uFZzSNycAILnSDZLElH4y4/dj9gEI4V
         rWtXR7LEzzQ62Et2MnXWSgR/v+8kUr0HgDkYsTbsJpuH+3rdfE/PCvOxMCPjv3NJk9
         4hf8rzPjqpxt17n5zVTq87WIiuRJaFqPpNj7AACl7krHhGENUQIOZq9CeCwg7lUx4s
         yzouDv2jQIQkw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 096D18C034B; Mon, 13 Nov 2023 08:26:21 -0500 (EST)
Date:   Mon, 13 Nov 2023 08:26:21 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Wang <00107082@163.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [BUG?] mm/secretmem: memory address mapped to memfd_secret can
 be used in write syscall.
Message-ID: <ZVIj_cDIzat39lQ6@mit.edu>
References: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
 <60081af2-d580-4f82-9233-3d3d7dd883bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60081af2-d580-4f82-9233-3d3d7dd883bc@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:15:05AM +0100, David Hildenbrand wrote:
> 
> According to the man page:
> 
> "The  memory areas backing the file created with memfd_secret(2) are visible
> only to the processes that have access to the file descriptor. The memory
> region is removed from the kernel page tables and only the page tables  of
> the  processes  holding  the file descriptor map the corresponding physical
> memory.  (Thus, the pages in the region can't be accessed by the kernel
> itself, so that, for example, pointers  to  the region can't be passed to
> system calls.)
> 
> I'm not sure if the last part is actually true, if the syscalls end up
> walking user page tables to copy data in/out.

The idea behind removing it from the kernel page tables is so that
kernel code running in some other process context won't be able to
reference the memory via the kernel address space.  (So if there is
some kind of kernel zero-day which allows arbitrary code execution,
the injected attack code would have to play games with page tables
before being able to reference the memory --- this is not
*impossible*, just more annoying.)

But if you are doing a buffered write, the copy from the user-supplied
buffer to the page cache is happening in the process's context.  So
"foreground kernel code" can dereference the user-supplied pointer
just fine.

Cheers,

						- Ted
