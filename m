Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC577A4680
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbjIRKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbjIRJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A81A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695031147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNidpQnXZFzSVwcXt0DkppO/+qmDF4IgQY6avnb9Gps=;
        b=bmGqx7KqgoUygBGJwR/iorlqyNRcbM/eVS2MPGLqHAnUNA+BGOA9MIVZdvj12H9eLenj8a
        7VoWAUfYiWrhPOEGawvzUW/YMGjVAEiK7JaOY1Uk09QqQ5edGFWmqkhnen2M+RxVW+68fL
        O7VgfFjUFX1PJqiWFJ9kbXxoOl/VZU0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Ia9IwwblMQqS_qfy9pLBlg-1; Mon, 18 Sep 2023 05:59:06 -0400
X-MC-Unique: Ia9IwwblMQqS_qfy9pLBlg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32153a4533eso392883f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031145; x=1695635945;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNidpQnXZFzSVwcXt0DkppO/+qmDF4IgQY6avnb9Gps=;
        b=eeDVfarwlPIL9vCVipDFKmm6jehCpR0BMb/h+c2GloiryNw5bCqltP5R9BTz9TYzj4
         foP/gKlW0LCJK+D2sDrnXLeh/LJLdaEEGiHljHvucp/ruGgOnt7xVGeP/GSvrplGXO3s
         bXPzZXiYDJ2n1AgWIaqYtW0cuVhggNWV3Zu6Fx9VBZz3q1qvaD32vqbQlzKcrY+AGChO
         M5sG8OsuRvO+hD7sO9rF4GFtEx/sGr4L6UvzBJe5XHbS3cUaOT7i6DQjMBg27ir70WQz
         ixF33a+44s1EhawLEY4/erqSa1557osFRA/QqNfxlTnvHYjQQnV+sArWsSvCs1S9SkFc
         Q06w==
X-Gm-Message-State: AOJu0YyeI/qFKbCvvtUT9k6wdsz08y5tYgP7Fw/DST0TpbbOX4Glp8GU
        EbL+mtvg+IZjG04JMZ3JW0RPiXFxYWAdah/k7agpCg6Z/yKCvXqNMXTx9ijquebFmD955uzsuWR
        HARteNFPYP07z8WnHfFyzT8K/upeucKMRjkTFuESipKSzA4n41fcyGCpxIgbaaOqlVvcg2QEzAm
        LYS0RP
X-Received: by 2002:a5d:4b0a:0:b0:31a:e6bf:9032 with SMTP id v10-20020a5d4b0a000000b0031ae6bf9032mr7625299wrq.4.1695031145083;
        Mon, 18 Sep 2023 02:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv7/pK0NBwQhVjn7Ictpql8f3D6lQqvfmKDXBC5ve2ggMcpdHjOSCvXQv01uR1wir+Ug9/nA==
X-Received: by 2002:a5d:4b0a:0:b0:31a:e6bf:9032 with SMTP id v10-20020a5d4b0a000000b0031ae6bf9032mr7625276wrq.4.1695031144707;
        Mon, 18 Sep 2023 02:59:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c044400b003fee567235bsm14752750wmb.1.2023.09.18.02.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 02:59:04 -0700 (PDT)
Message-ID: <d8e5a093-2e22-c14b-7e64-6da280398d9f@redhat.com>
Date:   Mon, 18 Sep 2023 11:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 5/6] mm/rmap: simplify PageAnonExclusive sanity checks
 when adding anon rmap
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20230913125113.313322-1-david@redhat.com>
 <20230913125113.313322-6-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230913125113.313322-6-david@redhat.com>
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

On 13.09.23 14:51, David Hildenbrand wrote:
> Let's sanity-check PageAnonExclusive vs. mapcount in page_add_anon_rmap()
> and hugepage_add_anon_rmap() after setting PageAnonExclusive simply by
> re-reading the mapcounts.
> 
> We can stop initializing the "first" variable in page_add_anon_rmap()
> and no longer need an atomic_inc_and_test() in hugepage_add_anon_rmap().
> 
> While at it, switch to VM_WARN_ON_FOLIO().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Hi Andrew, the following fixup on top:

 From 4b945ca15817b491123cc922f022b253134075b7 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2023 11:16:57 +0200
Subject: [PATCH] fixup: mm/rmap: simplify PageAnonExclusive sanity checks when
  adding anon rmap

While PTE-mapping a THP, we temporarily have an exclusive page of a THP
mapped by both, a PMD and a PTE at the same time. Update our check to
allow for that combination.

Reported-by: syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/rmap.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

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

