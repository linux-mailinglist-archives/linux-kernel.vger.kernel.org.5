Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0511762752
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjGYX3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGYX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:31 -0400
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84221BE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
Message-ID: <d5bce711-cef0-2929-2126-50105b6d807e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690327768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOEjSRPghqZUXU6a9KIFU0/2bAuZPx1SXHj+MlsTBQk=;
        b=GJ9xevCEq1sj4q4o69h/sQv1iIDXDIAysRTshJHIo4iErGxicFq8ZauC/jMaNJ6wA6Q8Uo
        wpa1DKrj/9QkQiuc1N67YRt7AyxByTMojBAGQQj8QPMHvkiZV6fXq6xfxY7Z4Cd3LjuyVl
        +8TNH+5uypaT3rame/2Q5+oBXwZuwiM=
Date:   Tue, 25 Jul 2023 16:29:21 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] btf: Remove unnecessary header file inclusions
Content-Language: en-US
To:     George Guo <guodongtai@kylinos.cn>
References: <20230721075007.4100863-1-guodongtai@kylinos.cn>
Cc:     masahiroy@kernel.org, nathan@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230721075007.4100863-1-guodongtai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 12:50 AM, George Guo wrote:
> Remove unnecessary header file inclusions in btf.c
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   kernel/bpf/btf.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..e5ea729ba6b8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1,20 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2018 Facebook */
>   
> -#include <uapi/linux/btf.h>
> -#include <uapi/linux/bpf.h>
> -#include <uapi/linux/bpf_perf_event.h>
> -#include <uapi/linux/types.h>
> -#include <linux/seq_file.h>
> -#include <linux/compiler.h>
> -#include <linux/ctype.h>
> -#include <linux/errno.h>
> -#include <linux/slab.h>
>   #include <linux/anon_inodes.h>
> -#include <linux/file.h>
> -#include <linux/uaccess.h>
> -#include <linux/kernel.h>
> -#include <linux/idr.h>
>   #include <linux/sort.h>
>   #include <linux/bpf_verifier.h>
>   #include <linux/btf.h>
> @@ -22,9 +9,6 @@
>   #include <linux/bpf_lsm.h>
>   #include <linux/skmsg.h>
>   #include <linux/perf_event.h>
> -#include <linux/bsearch.h>
> -#include <linux/kobject.h>
> -#include <linux/sysfs.h>

What is the reason that needs this change and only to this file? There are other 
files that can do this kind of removal. Are you planning to make all the changes 
also?

afaict, they are here because this file is using something defined in them. Now 
it is depending on other header files implicitly including the removed headers.

>   
>   #include <net/netfilter/nf_bpf_link.h>
>   

