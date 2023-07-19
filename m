Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB28759018
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGSITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGSITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AC171D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3PRF01yQKk/5cZ5BWUeGIVek1A+ZScaFRNRxy8v7WU=;
        b=HbL+PnSYQMWXQyxZK69h8iU3a4RSI0ZacPI8dKea9r8/CtqTK1yd4cMEsrKzOe1oVeI6us
        jQ6w7Rwidq7zR9Pws2bP+O0NHf5QjJy+8/pIfCnBZM1pyBgyYXEOCvxDGh7tQ3Fj1aWTFC
        8FtON6xNDn4uyM/nn+iNNHBXKU+67OY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-3732ChrnORmo232po8Jwaw-1; Wed, 19 Jul 2023 04:19:00 -0400
X-MC-Unique: 3732ChrnORmo232po8Jwaw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb736a7746so5516538e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754738; x=1692346738;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3PRF01yQKk/5cZ5BWUeGIVek1A+ZScaFRNRxy8v7WU=;
        b=XyIoOpO7o5cRezFra+QLJH9Ayv0Q1thilcd6lzZaTNkqRTpynf59nGDAZZephcwMd4
         pnUmtksHpoQhueT0ra/1KPfYhHK2jUFQUJ06/yUFj8MEiazuMvewdbLdYglNlkEUljMS
         z1IQBiwG041F6MCr49NB/O88/QlLEIDa+OyyGrg831j2AdT/qbtX5279dATvSqjdoWiN
         93lvj69Z3wHD+r0ONgB/51FNRODMNYCVLywB544H4rosm7EILYIwmEwUbwD9nafWVlOS
         fhEWSxEfZYE8XEVSDU2BTok/qfSVvPpvuxPAF95C0oQSY1QtxN/wqp2tpJ1PHVUETi9w
         3iwg==
X-Gm-Message-State: ABy/qLbklRuoJuW1P/d0CcYnBN8MxehRiwP4TctQ4bPOp54pan+8GT6J
        45csE8UUUeXyD5Q38qoyzsHs3dVbrS0rUJQq01UjjzYcCqsZvSxZmrEBVnTeHBpNiIhIwcyPF5x
        89GJ26i++5/p0EpS+MQXBW5GN
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id o1-20020a05651205c100b004f8083fbabemr11169520lfo.62.1689754737883;
        Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlElWbEEQS6wB/sXWEw3o9coLgNkRyP67VSBFnN2SP6jtQCcIg6AEec+Q116/3HBCGy4e/xB8A==
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id o1-20020a05651205c100b004f8083fbabemr11169502lfo.62.1689754737550;
        Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63? (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de. [2003:cb:c74b:4f00:b030:1632:49f2:63])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbb5142c4bsm1075458wmm.18.2023.07.19.01.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
Message-ID: <251edad7-e169-2118-e8e0-e8d4781d5a9c@redhat.com>
Date:   Wed, 19 Jul 2023 10:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-4-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   security/selinux/hooks.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..ee8575540a8e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>   	if (default_noexec &&
>   	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>   		int rc = 0;
> -		if (vma->vm_start >= vma->vm_mm->start_brk &&
> -		    vma->vm_end <= vma->vm_mm->brk) {
> +		if (vma_is_initial_heap(vma)) {
>   			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>   					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file &&
> -			   ((vma->vm_start <= vma->vm_mm->start_stack &&
> -			     vma->vm_end >= vma->vm_mm->start_stack) ||
> +		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
>   			    vma_is_stack_for_current(vma))) {
>   			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>   					  PROCESS__EXECSTACK, NULL);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

