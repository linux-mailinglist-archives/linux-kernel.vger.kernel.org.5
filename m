Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A7753D34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjGNOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjGNOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA7819B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689344655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYk7jz6ntAwEI6PiLsydtI+XJXWTqtYTXOH7ZzwkMlE=;
        b=CGRx4pPzRYDcQCzHRAR2rY0+b20Ker3y5O2nZYLrT9tjVzRCgHhkUGtzydZQ2LT0u3SsK3
        NGcFeH50kFufvV2z7FHg/4ghdQY6Ic7e8p1qY8uUl85tTMvYHdaBmbYHTkcj6XUx5G9vtU
        FqfyE4ynuAkZTBYp8JBaE0LS+pTllDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-KSJy30IvPO-lj94K7tmh0Q-1; Fri, 14 Jul 2023 10:24:14 -0400
X-MC-Unique: KSJy30IvPO-lj94K7tmh0Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso13060485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344653; x=1691936653;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYk7jz6ntAwEI6PiLsydtI+XJXWTqtYTXOH7ZzwkMlE=;
        b=cxsTRgHN4VeSiHdDuWJbKXWShWh5F65U01aQzR40fXchDghHtDnaNlr4+76mzpalkV
         mUZayu/u3xU/1r69MzxrVO2BFiz5y3PsbTdI+gdT++mddAAZvtDfgLvBKdsDCpEEwa60
         g/RzpflUgTzGOJW+XdSM8V+OLnpFyl4Li3zgxja43HTsKr0Qf6EM2/g+DjcnXxfxBM/H
         xddzRJg1Xzlts4i4VW+qOmwQFLbZBuFgM8FhizJHVIBXH86Mvw75fKD2jaq+b54WBT9H
         TmCK6qhBdcC0Epae1szSXV5Xl411Xw5/aVn9X1UGeQh0kWGFKPjEXAKh50WGo50YGcmV
         nPnA==
X-Gm-Message-State: ABy/qLbbK36NnGxbCQqQFQ7YG9tN4ovP0FzsA1STOqFacX8TfzNrVibx
        SQDBi8wytmZsPje6pW5BMEUH2dCJh2fWDFNSd0piKt2wn2JCHdqTV6yOAeqJwU4KXkbvOiJhGr5
        B5lbxhPf22nOjE929C51O1p/63cDNJJBW
X-Received: by 2002:a05:600c:c0a:b0:3f7:e78e:8a41 with SMTP id fm10-20020a05600c0c0a00b003f7e78e8a41mr2336885wmb.18.1689344653160;
        Fri, 14 Jul 2023 07:24:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnkg8aA3OrK+INJg7RhquoSyjRL9/hr1Er0A3tqfhzrfsoLaE8gpCAuhI8MVbOWXXmbH0KRw==
X-Received: by 2002:a05:600c:c0a:b0:3f7:e78e:8a41 with SMTP id fm10-20020a05600c0c0a00b003f7e78e8a41mr2336876wmb.18.1689344652791;
        Fri, 14 Jul 2023 07:24:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c224e00b003fbaade0735sm1571461wmm.19.2023.07.14.07.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:24:12 -0700 (PDT)
Message-ID: <ad8b9857-9aa8-8f33-d378-fdd5ce8f28f5@redhat.com>
Date:   Fri, 14 Jul 2023 16:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/huge_memory: use RMAP_NONE when calling
 page_add_anon_rmap()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230713120557.218592-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713120557.218592-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 14:05, Miaohe Lin wrote:
> It's more convenient and readable to use RMAP_NONE instead of false when
> calling page_add_anon_rmap(). No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/huge_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9f3109ed7351..762be2f4244c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2255,7 +2255,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   				entry = pte_mksoft_dirty(entry);
>   			if (uffd_wp)
>   				entry = pte_mkuffd_wp(entry);
> -			page_add_anon_rmap(page + i, vma, addr, false);
> +			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
>   		}
>   		VM_BUG_ON(!pte_none(ptep_get(pte)));
>   		set_pte_at(mm, addr, pte, entry);

Indeed

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

