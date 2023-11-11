Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D737E8ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjKKMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKKMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 07:25:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB073A84
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 04:25:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D87C433C7;
        Sat, 11 Nov 2023 12:25:17 +0000 (UTC)
Date:   Sat, 11 Nov 2023 12:25:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Omkar Wagle <ov.wagle@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: Remove security and coding style warning
Message-ID: <ZU9yqGF0l5rs0SWX@arm.com>
References: <20231110191102.2029-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110191102.2029-1-ov.wagle@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:11:02AM -0800, Omkar Wagle wrote:
> @@ -368,6 +367,7 @@ static void print_unreferenced(struct seq_file *seq,
>  
>  	for (i = 0; i < nr_entries; i++) {
>  		void *ptr = (void *)entries[i];
> +
>  		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
>  	}
>  }
> @@ -406,10 +406,11 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>  	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
>  
>  	while (rb) {
> -		struct kmemleak_object *object;
> +		struct kmemleak_object *object = NULL;

Seriously, what's this initialisation for?

>  		unsigned long untagged_objp;
>  
>  		object = rb_entry(rb, struct kmemleak_object, rb_node);

The variable gets assigned here.

> +
>  		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);

I'm also not a fan of random whitespace updates throughout this file. It
makes backporting fixes harder later on.

-- 
Catalin
