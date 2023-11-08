Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B27E4E96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjKHB2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbjKHB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:28:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B110C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:28:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso5938342a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699406917; x=1700011717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDL22exLVhM/MeNU76axOAhFs9TgMQbWRMKU7ZDadZA=;
        b=I74SFPxu8fyojx53jYUYLpDHYU/+DeySqJifVcF4byI/Jn6zKFo9si5azF1NIqTgB1
         HZJx0ZzJmRClUeE8E5Hg9j7kTzci6wQFNetR9LXXZC47su5dcYOZvutFJCcvh4RMBOig
         Bl6XIqHqs5p+MRJXxsAIlsZx5MH1UBhAoz17A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406917; x=1700011717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDL22exLVhM/MeNU76axOAhFs9TgMQbWRMKU7ZDadZA=;
        b=ui7uiN7WGbA20VcJbzY6YgbULF7E/T6JtUIuZKz0sfdRF89h1el33dP2GQ497+s2RL
         SQTihjeuEpBi1LT7x9c56288oCTPSEJeXGjZNw6hEYhMswTyt/wPDmdgsBt4/VNGQrnE
         SPsetvbU3Blk3m0+m60lG31NnpmDqPEuFZgNHL6IEXuALvXaL5utMeYDfS3kF5Ha/nHw
         xn34/YIb9goPooj7aVFHV432Wbg8lz2ZrH4a05DIijQlkPgAfOiVYJkMklE5iCZncZV8
         5hfq13Hev/HRhYqtkUdGO9y78jyCRiJG7ePoftkPGpT2avWREkJCGAIVgJQmqTyYoZPN
         yq8Q==
X-Gm-Message-State: AOJu0YzkwzNWDHZJU7ty4Z/jzP6cbZmAx6g7SyJ9RjcY0ZbkHk/jQSIV
        BsoikpYBKILXqquwBA52slkoSw==
X-Google-Smtp-Source: AGHT+IFrylAbcHeAn6G1Ihl3Rsvk/QVzS4IgpsoYi4sVx3Ic027pn7a9uOoQUbRwP+MM9I9CGCOKhQ==
X-Received: by 2002:a17:90b:1d92:b0:27d:222c:f5eb with SMTP id pf18-20020a17090b1d9200b0027d222cf5ebmr486391pjb.11.1699406917333;
        Tue, 07 Nov 2023 17:28:37 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a01c200b002609cadc56esm475764pjd.11.2023.11.07.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 17:28:36 -0800 (PST)
Date:   Wed, 8 Nov 2023 10:28:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        SeongJae Park <sj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Hugh Dickins <hughd@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Subject: Re: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
Message-ID: <20231108012823.GD11577@google.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-12-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-12-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/07 15:08), Ankur Arora wrote:
[..]
> +++ b/mm/zsmalloc.c
> @@ -2029,7 +2029,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  			dst_zspage = NULL;
>  
>  			spin_unlock(&pool->lock);
> -			cond_resched();
>  			spin_lock(&pool->lock);
>  		}
>  	}

I'd personally prefer to have a comment explaining why we do that
spin_unlock/spin_lock sequence, which may look confusing to people.

Maybe would make sense to put a nice comment in all similar cases.
For instance:

  	rcu_read_unlock();
 -	cond_resched();
  	rcu_read_lock();
