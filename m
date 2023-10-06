Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64327BBF60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJFS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjJFSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0391AB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW50MvzyQoFy0Y9n7htqlvGtReQShELOcf6kg4n+7v4=;
        b=gXDT58Hc3fMlYZqxCwWmVXjh8ZKuSQkS0gPogfBAWBBj80i0a4vKqrl8OpXLTP0bNQ26E2
        z177Dx5ZPUsqItVgE/k0cIPP7q81+LUVjWa5atJZiD1SI2uIklq1ZAu73TYoJim6HlJZ2z
        dGUFnqlnAkc4edVv/gxPm7ZnUwJqg54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-wvQdhD0ON6asu949UZXTRA-1; Fri, 06 Oct 2023 14:53:37 -0400
X-MC-Unique: wvQdhD0ON6asu949UZXTRA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32686c75f8fso1786249f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 11:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618415; x=1697223215;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW50MvzyQoFy0Y9n7htqlvGtReQShELOcf6kg4n+7v4=;
        b=aKIrwf1G0FimxvJicouMMDYTF3/lIdj/rp1DZSz+fCqqHtFV2wGIA+DbSpCyR31BoG
         qJZCQK+bo6OMzMrPpZXEgml+snyuQyD3gRYXPUVszPYan3ef0E9yUvZ5t/ojPKe5sVtt
         1P/1SL8gDSi2kSUbE5w9ER1hI9pgZhm0+VFrcR8vKHlyM4GE1EntUZE2TVcxG7RiEtGK
         oxlzMBmFJ3ts23+7BpANvukkNLphdVa/9i291F3C1d+jaDaNoSvfEF3ZG5RK+VYb6Nj8
         HrTlP1lqc8H/toVKntRVOQVei86YHh06gvWm/UhnHFjNM53l+Qbi4C/iYCVHgOeMCfbX
         nw/g==
X-Gm-Message-State: AOJu0Ywav/HyhQMnOuc4aGhKzKTeS6FTy6WtfmgKwq07/UZ3DADFChWR
        PbGLffFyLM21ZrulY2u+8fJriowpV7UmyCl/9srImJwT+yHCfjFokQdgMzaRtvdMlqTAEtD/rBw
        Or3c9qQrY+iVtR5UHA3EzEsNA
X-Received: by 2002:adf:f692:0:b0:31f:e883:2ffc with SMTP id v18-20020adff692000000b0031fe8832ffcmr7401132wrp.43.1696618415038;
        Fri, 06 Oct 2023 11:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpqMwEsERFbTQP4/MhAPILilQxV0SuCQcsD/MwMnwwdswb1JRO89mDTE4up485ECSgZoYcFg==
X-Received: by 2002:adf:f692:0:b0:31f:e883:2ffc with SMTP id v18-20020adff692000000b0031fe8832ffcmr7401116wrp.43.1696618414601;
        Fri, 06 Oct 2023 11:53:34 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23b7e.dip0.t-ipconnect.de. [79.242.59.126])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b00327df8fcbd9sm2250805wrv.9.2023.10.06.11.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:53:34 -0700 (PDT)
Message-ID: <225e8018-ef79-5514-a6ce-f5994206efe9@redhat.com>
Date:   Fri, 6 Oct 2023 20:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230925200110.1979606-1-zokeefe@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230925200110.1979606-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 22:01, Zach O'Keefe wrote:
> The 6.0 commits:
> 
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> 
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> 
> During the process, the semantics of the fault path check changed in two
> ways:
> 
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>     handler that could satisfy the fault.  Previously, this check had been
>     done in create_huge_pud() and create_huge_pmd() routines, but after
>     the changes, we never reach those routines.
> 
> During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only relevant
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic. However, this was a bad
> assumption to make as it assumes the only reason to support ->huge_fault
> was for DAX (which is not true in general).
> 
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we
> don't validate the file mode or mapping alignment, which is consistent
> with the behavior before the aforementioned commits.
> 
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
> I've updated the changelog to reflect discussions in [1] -- leaving
> ack to David / Matthew on whether to take the patch.

Works for me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

