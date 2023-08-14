Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6477C08B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjHNTPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjHNTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0A172A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72CA462278
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D8C433C8;
        Mon, 14 Aug 2023 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692040522;
        bh=ft6PFp1kWRcEktVzmPZjCFhYR3/z/32uyG2rtkYFSXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NF5liyvpwstN6j+v/uzCgwbhgbJA7nJFovhqpTqVSWjr2qUF30e+h9IlB7gGA7UUy
         AOKOKy8VyiuwG6lIvWLLqSonSVUviraAL8tfMSKEK1vgCAFP9Xhrr36ELUgFNN4Wh9
         WnVHdKqxmLllcL+jvUZ73li1Bu7pcjoiPqrNT3JQ=
Date:   Mon, 14 Aug 2023 12:15:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        torvalds@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v4 5/6] mm: always lock new vma before inserting into
 vma tree
Message-Id: <20230814121521.83c2dda21765757d272538b2@linux-foundation.org>
In-Reply-To: <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com>
References: <20230804152724.3090321-1-surenb@google.com>
        <20230804152724.3090321-6-surenb@google.com>
        <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 16:54:01 +0200 Jann Horn <jannh@google.com> wrote:

> > @@ -403,6 +403,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
> >
> >   vma_iter_store(&vmi, vma);
> >
> > + vma_start_write(vma);
> > +
> >   if (vma->vm_file) {
> >  mapping = vma->vm_file->f_mapping;
> >  i_mmap_lock_write(mapping);
> 
> The "vma_start_write()" has to be ordered before the
> "vma_iter_store(&vmi, vma)".

Thanks.  This?


--- a/mm/mmap.c~mm-always-lock-new-vma-before-inserting-into-vma-tree-fix
+++ a/mm/mmap.c
@@ -401,10 +401,10 @@ static int vma_link(struct mm_struct *mm
 	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
-	vma_iter_store(&vmi, vma);
-
 	vma_start_write(vma);
 
+	vma_iter_store(&vmi, vma);
+
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
_

