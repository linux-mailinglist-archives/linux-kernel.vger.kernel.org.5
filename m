Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56467ABCDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjIWArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIWArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC8C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695430015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFq6zMaaGytyLVjCRlM3YGZB/pczKiOV+8u9ckMtHlE=;
        b=G3vrTVVC1of69IpxZZuPPqUi+P5WnXPwduI0eWjoclZyr0X+S5ZU9zgV7vvtFAop58koAq
        LfyPQ//gY1F+PcbHfwfZm6hHVP42zwuP25aDSm3ET9r5yv6/g/7I8euN2wnMxPw9XHThUG
        N3om5xZRRnKAN/q7UY9KsdLllkyPKpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-UHzJRoO2NxSdEjhQPdTCeg-1; Fri, 22 Sep 2023 20:46:52 -0400
X-MC-Unique: UHzJRoO2NxSdEjhQPdTCeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CC3185A5BA;
        Sat, 23 Sep 2023 00:46:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB10928FB;
        Sat, 23 Sep 2023 00:46:50 +0000 (UTC)
Date:   Sat, 23 Sep 2023 08:46:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Message-ID: <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
References: <20230922175224.work.712-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175224.work.712-kees@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 at 10:52am, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crash_mem.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/crash_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 3426f6eef60b..5126a4fecb44 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
>  struct crash_mem {
>  	unsigned int max_nr_ranges;
>  	unsigned int nr_ranges;
> -	struct range ranges[];
> +	struct range ranges[] __counted_by(max_nr_ranges);

This __counted_by() only makes sense when there's a obvious upper
boundary, max_nr_ranges in this case. This heavily depends and isn't
much in kernel? E.g struct swap_info_struct->avail_lists[]. Just
curious, not related to this patch though.

>  };
>  
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
> -- 
> 2.34.1
> 

