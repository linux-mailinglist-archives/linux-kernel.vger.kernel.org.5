Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210927A4A38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbjIRMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbjIRMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46473C7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695041608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCf8FMEWiy9a0XpvHieMO1Zjq0SrTxWmPqBgxKH5lAk=;
        b=OuszJ0JFlZiPNs8lvV19oPT5tGRCKcYdyI+nvmpIesFBIjrFFEZ4X4ArtsIUJOy55+76HQ
        BS8OC5k0UcOSr//UVTJs+oixgsTGinkN4nchGtSkaaxU4pvjmfP/OR4DY4BcxETY0wJZ9G
        TvAC8IUfMdS0h/dsSP9670rXV/NBSxo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-vOJ6dNfJPvunrMUizPlvjQ-1; Mon, 18 Sep 2023 08:53:26 -0400
X-MC-Unique: vOJ6dNfJPvunrMUizPlvjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402ff13f749so33054565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041605; x=1695646405;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCf8FMEWiy9a0XpvHieMO1Zjq0SrTxWmPqBgxKH5lAk=;
        b=RSkCogQqcWMeGgkOWGfd8xOS9rnYf5OBTizLUfvsEqe+8ob9ZwEkWm12GDItIV6lBv
         0wda3jzbxqoADvnshBmkvpm+AgPAtL0/a8fdBHRS6aZd0huP26rA1GIVhzJtAsQvYMsE
         QZrZ+c9PvPt3cTqH9NVgaFecvY1MAcDzCdl26BEAmnEOZIz5IqZ2pAyniEuzm/PyKL3G
         HHDbAHp/tfiy4i+fBqR17CX4Azy+ubxzEnCUYR9KcRFDbOkQlHVOTuGNj+ARD4bpH2V8
         soNj8ARXM6EgCKgvU54oXUqxjSafo1IjCOGhzwnzynLFOjHF4fCMj58JdUN/lc9c7Bhh
         l5Sg==
X-Gm-Message-State: AOJu0YxDn7Tj0Fq6sCCTg8l8i00HSq2CWC38/ePcK9zBELr/Vqkrv+vg
        2iQ/5W/nWJP+/knv45aNgqM/q5jly9SdBvmb4CpkPRh2+WH6gVvKoYfoPgaf2tM7VGMk6lJxuHR
        TdnF/UpsSJsXI53GQLKywaMmb
X-Received: by 2002:a05:600c:8508:b0:405:a30:151e with SMTP id gw8-20020a05600c850800b004050a30151emr2355373wmb.12.1695041605212;
        Mon, 18 Sep 2023 05:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiQWe+uwQOYVM4McAUlbjVx8K08AH6m92XIdHqAW+ElXXJZAluGs5FS8UBxA6Y9OqdJzu5nw==
X-Received: by 2002:a05:600c:8508:b0:405:a30:151e with SMTP id gw8-20020a05600c850800b004050a30151emr2355355wmb.12.1695041604825;
        Mon, 18 Sep 2023 05:53:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id g13-20020a7bc4cd000000b003fc02e8ea68sm15249285wmk.13.2023.09.18.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:53:23 -0700 (PDT)
Message-ID: <1fe06726-85bf-7231-f33d-d73e8cfbaa4f@redhat.com>
Date:   Mon, 18 Sep 2023 14:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000008bf71d06059a2276@google.com>
 <a841592f-942d-b1b7-db93-7bd31c96e4eb@redhat.com>
 <ZQhDRtWYSJWfHvEM@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQhDRtWYSJWfHvEM@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.23 14:32, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 12:00:24PM +0200, David Hildenbrand wrote:
>>> If you want syzbot to run the reproducer, reply with:
>>> #syz test: git://repo/address.git branch-or-commit-hash
>>> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If I understand correctly, you have to do it like this:
> 
> #syz test
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 789a2beb8b3a..f13a2927163d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1249,8 +1249,10 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   	}
>   	if (flags & RMAP_EXCLUSIVE)
>   		SetPageAnonExclusive(page);
> -	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
> -			 folio);
> +	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
> +	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
> +			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
> +			 PageAnonExclusive(page), folio);
>   	mlock_vma_folio(folio, vma, compound);
>   }

Looks like an empty line went missing in your attempt.

Let's try again for fun (I reproduced and tested myself already ;) ).


#syz test

diff --git a/mm/rmap.c b/mm/rmap.c
index 789a2beb8b3a..f13a2927163d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1249,8 +1249,10 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
  	}
  	if (flags & RMAP_EXCLUSIVE)
  		SetPageAnonExclusive(page);
-	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
-			 folio);
+	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
+	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
+			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
+			 PageAnonExclusive(page), folio);
  
  	mlock_vma_folio(folio, vma, compound);
  }
-- 
2.41.0

-- 
Cheers,

David / dhildenb

