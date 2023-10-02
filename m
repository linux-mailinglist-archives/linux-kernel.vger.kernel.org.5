Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200247B587D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjJBQVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjJBQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:21:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B3B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:21:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77574c6cab0so498814285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696263694; x=1696868494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NaT0x53utpu1m0I+3T/XI1VUzVuytHLU7KtGrA3rvpc=;
        b=HYqgkaz/dCGP98gPSpHfc7f+eo6w/F6MLG4sKLtNM5pGNJOO7Uoe9igZ94lbfN/B5y
         cnBQ1mrI7RKV6rMHOdcXd3hksdP8NBAccmP45tddrc5KKyLD/xlX3Znisjzl2c0CjmpC
         q9M2vrPXMOmj5nFMITRaNOssq/j/Vo7yNA8cBXt2dTanhY9cm3vycMyFYJnvu0u70+wN
         NW4dCRY9xILzNLJo6ADJmBmEblKuU0MB2iTrPrq+eo+V3wOBVm+5oHkrbSjGTZaB3QJu
         Mrs3ISTocGCQYQHgf87zR+56XxgdI14SzAWft5lueox2GSxwlCbMdy6mocRZekE2tyuq
         r35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696263694; x=1696868494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaT0x53utpu1m0I+3T/XI1VUzVuytHLU7KtGrA3rvpc=;
        b=IBeBjh0fGonp7YaBDgwlqSkNleYE4xsHZ5pU6PjfSETL+GUuGVhJ+FaJpFF4RjSaA3
         1BLhKLN2UsB/Q7n+5TSOV/1pIDiU8n2gyuZA47+izrp7Y4zWf2GIYJTZqVuInK9SRkoI
         uTwaXTq4Duz08Xn8sQ2sWPsDa3hsVVmdJua+CY8gQipcCnaE/pEsFwWMYqHPDQLARHw5
         9rFEV1ars8laOlZwxg63CBMnQqdyMZgBfAOsvShaqMHSp+rfp0L7AnZkoPz6H2fvduET
         bKEz5sLQmxF3ue21DnxmNgcsXtFG4WnFJW7cQUqgpN4SJx4pKrMfAxMTzUU/BalADY1B
         3Qdg==
X-Gm-Message-State: AOJu0YzbwXr2hQyjyU1p7XVlOqWC2cmEJwL+6DeMOB2+JxDEsmuF2aKj
        JBDsINjLeOyi9OrcePu8/IwKaA==
X-Google-Smtp-Source: AGHT+IHBR9Tl9pOvqlxE75NeM5DT2AwWOubxDTt6FVTRUPGoLxdIiBlU9CkmYHCPoWwMOXvhe9w6cQ==
X-Received: by 2002:a05:620a:d85:b0:76d:2725:f36f with SMTP id q5-20020a05620a0d8500b0076d2725f36fmr13889629qkl.71.1696263694335;
        Mon, 02 Oct 2023 09:21:34 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a124e00b0076cc4610d0asm9119059qkl.85.2023.10.02.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:21:33 -0700 (PDT)
Date:   Mon, 2 Oct 2023 12:21:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231002162133.GC5054@cmpxchg.org>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> We should also consider the global control for this functionality. I am
> especially worried about setups where a mixed bag of workloads
> (containers) is executed. While some of them will be ready for the new
> accounting mode many will leave in their own world without ever being
> modified. How do we deal with that situation?

It's possible to add more localized control on top of the global flag
should this come up. But this seems like a new and honestly pretty
hypothetical usecase, given the host-level coordination already
involved in real-world hugetlb setups.

The same could be said about other mount options, such as nsdelegate,
memory_localevents, and memory_recursiveprot. Those you'd expect to
have a much broader audience, and nobody has asked for mixed use.

Let's cross this bridge not when but if we have to.
