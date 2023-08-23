Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A978578A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHWMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjHWMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:08:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B649171A;
        Wed, 23 Aug 2023 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ysaf8/wElHvFH5MgVZnFnGtYChLdMb1DwC+nYrsJpbg=; b=gaIJgvP/yCQGTdYQZzy6fhCJK2
        MeBwI4GHNIHtWrK2t4mZcMxICZHFs+dwhMye+S0PrUeB6fmVAN7lV+YmK6f3zoKBVi/shqwFXbpY0
        FONGKBVfQrdtG8JGpqBhBW1/9z6av0A5S73ch2VkqXt6IiQpDXc3W9mo5IG8FMusYRSdzwcp6pK9f
        /xxc3EE3PPX2zS0/Li0tGnH9+hgOfXNqMFYikBSf4jL+Bs/ugXladR29PyFb6ExFL8p/hmzH8iinG
        3izepVNtBs7NTYdh8ajJOfAuBBf1rBnqrAPZyTebI4KQgSbFPc3e4fULbmV25cFDYD7sYNdKwZQgD
        5b2EBAJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYmdQ-004iOg-J5; Wed, 23 Aug 2023 12:06:52 +0000
Date:   Wed, 23 Aug 2023 13:06:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify the 'mm' parameter in
 security_vm_enough_memory_mm()
Message-ID: <ZOX2XDdrfk8rO9+t@casper.infradead.org>
References: <ZOWtBTKkfcc8sKkY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOWtBTKkfcc8sKkY@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:53:57AM +0500, Khadija Kamran wrote:
> +++ b/include/linux/mm.h
> @@ -3064,7 +3064,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
>  
>  /* mmap.c */
> -extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> +extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);

Could you remove the 'extern' when you touch a function prototype?

