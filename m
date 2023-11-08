Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6651D7E5380
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjKHKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjKHKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:41:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559D9E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:41:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5833AC433C8;
        Wed,  8 Nov 2023 10:41:09 +0000 (UTC)
Date:   Wed, 8 Nov 2023 10:41:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Omkar Wagle <ov.wagle@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: kmemleak: Removed coding style warnings and added a
 NULL check
Message-ID: <ZUtlwgDB1L2WVzfy@arm.com>
References: <20231108062756.8129-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108062756.8129-1-ov.wagle@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:27:56PM -0800, Omkar Wagle wrote:
> @@ -406,10 +406,13 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>  	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
>  
>  	while (rb) {
> -		struct kmemleak_object *object;
> +		struct kmemleak_object *object = NULL;
>  		unsigned long untagged_objp;
>  
>  		object = rb_entry(rb, struct kmemleak_object, rb_node);
> +		if (!object)
> +			break;

No need for this. rb_entry() is a container_of() and we already check
that rb is not NULL.

> @@ -1027,7 +1030,7 @@ static void object_no_scan(unsigned long ptr)
>  void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
>  			  gfp_t gfp)
>  {
> -	pr_debug("%s(0x%px, %zu, %d)\n", __func__, ptr, size, min_count);
> +	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);

That's for debugging, I'd rather keep the %px option. The same comment
applies to all the other pr_debug() changes in this file.

-- 
Catalin
