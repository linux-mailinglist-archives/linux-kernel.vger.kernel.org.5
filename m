Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D8B7EBB96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjKODLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:11:38 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7ED5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:11:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so5104983b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700017894; x=1700622694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZDkwNsNq+X79quW0/EG+q9SX4HEapk0fZkP3MS7px0=;
        b=GWRuPLARyqdnQ+Y1MJRJhTy9CumtYC0kJLlo60WMYQd4WKJlA4ViLgj9xTFjDfjUTx
         MuIu0dL7Va2OZHvT4sAjUzLc5m2H2MRj+xQdyLYJUa5QgaCBLgjMVmhA8K8TPPTNCjA+
         o1UMwGZTviIBr2tThqHNe+8yE84se1qRVocH0jkDibXybPngocAl+lXj3EdotUpXmOXg
         KNQVIS3qOkFPeiZx3oTXRgNvmHOzycyHTa9xJr6UcDFwPyJtdeIVoDo9yMEzFQ8vk0X2
         kVbwhrHIxnOH+x+rTyhI2QP2Uq1ROA285mLLPPmt8hZhYzA+3+quMg8wxhjPiHAxUj5C
         kOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700017894; x=1700622694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZDkwNsNq+X79quW0/EG+q9SX4HEapk0fZkP3MS7px0=;
        b=tkmtxG1gvAvjzsI/GWnTc8uCF1GChWPbDWTmZn0pqXu4AbwzuLlsd8+8SRMVlznAO7
         NNr7PNNEOXrWlpmaPpmsPCbIWaGUraKLjS4+egT67xN0RGsZ2MFEVDUVJ6SsrWc5pdG1
         2w7tlUUi/I3VlhdwKBXH3Pg7TDMQwBDYm2rtx6BpKBByKDRIYPanuMGQ4dYaeX+A2SAA
         D4ebY1+HkwnHKGtPdphBbhXWwC1VU2OlCBue6AB8mRk9j5KLD8VSj3JprByJxQJYWJw7
         ck+6elIrYY20bBV5T/rfTr37vP6XeBWe+6PwWaEQUlubk/Y+Dapx6n8eRYgVY1hixNF2
         kFQA==
X-Gm-Message-State: AOJu0YzoYAakWZtOU1hn4/GFPrPJ2PFEMZ6k4YyCIw9aKA4qKr7cbaLc
        dObCg5iATpZtnb1F0+BvggE=
X-Google-Smtp-Source: AGHT+IG1o/fG8d7Eq8VE+C7PkIjGpCGxhDqAFugd3BfFy7cE501Vpo0YeGb45YzYPWTU914xFMAjhg==
X-Received: by 2002:a05:6a00:4c8d:b0:68e:2478:d6c9 with SMTP id eb13-20020a056a004c8d00b0068e2478d6c9mr10523019pfb.2.1700017893652;
        Tue, 14 Nov 2023 19:11:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r1-20020aa78441000000b006933f85bc29sm1893797pfn.111.2023.11.14.19.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:11:33 -0800 (PST)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin.sc@gmail.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Date:   Wed, 15 Nov 2023 03:11:29 +0000
Message-Id: <20231115031129.1970581-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b4a11840-0118-44af-9397-30b5bcdd6552@redhat.com>
References: <b4a11840-0118-44af-9397-30b5bcdd6552@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 7efcc68ccc6e..c952fe5d9e43 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>   	tree_rmap_item =
>>   		unstable_tree_search_insert(rmap_item, page, &tree_page);
>>   	if (tree_rmap_item) {
>> -		bool split;
>> -
>>   		kpage = try_to_merge_two_pages(rmap_item, page,
>>   						tree_rmap_item, tree_page);
>> -		/*
>> -		 * If both pages we tried to merge belong to the same compound
>> -		 * page, then we actually ended up increasing the reference
>> -		 * count of the same compound page twice, and split_huge_page
>> -		 * failed.
>> -		 * Here we set a flag if that happened, and we use it later to
>> -		 * try split_huge_page again. Since we call put_page right
>> -		 * afterwards, the reference count will be correct and
>> -		 * split_huge_page should succeed.
>> -		 */
>
>I'm curious, why can't we detect that ahead of time and keep only a 
>single reference? Why do we need the backup code? Anything I am missing?

I don't know the original reason, better ask Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>. 
Maybe because doing detection that ahead of time will break several funtions' semantic,
such as try_to_merge_two_pages(), try_to_merge_with_ksm_page() and try_to_merge_one_page()

Adding the backup code don't change the old code and fixing the old problem, it's good.

>
>> -		split = PageTransCompound(page)
>> -			&& compound_head(page) == compound_head(tree_page);
>> -		put_page(tree_page);
>>   		if (kpage) {
>> +			put_page(tree_page);
>>   			/*
>>   			 * The pages were successfully merged: insert new
>>   			 * node in the stable tree and add both rmap_items.
>> @@ -2271,7 +2257,25 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>   				break_cow(tree_rmap_item);
>>   				break_cow(rmap_item);
>>   			}
>> -		} else if (split) {
>> +		} else {
>> +			bool split;
>> +			/*
>> +			 * If both pages we tried to merge belong to the same compound
>> +			 * page, then we actually ended up increasing the reference
>> +			 * count of the same compound page twice, and split_huge_page
>> +			 * failed.
>> +			 * Here we set a flag if that happened, and we use it later to
>> +			 * try split_huge_page again. Since we call put_page right
>> +			 * afterwards, the reference count will be correct and
>> +			 * split_huge_page should succeed.
>> +			 */
>> +
>> +			split = PageTransCompound(page)
>> +				&& compound_head(page) == compound_head(tree_page);
>
>Would
>
>split = page_folio(page) == page_folio(tree_page);
>
>do the trick? No need to mess with compound pages.

In terms of function correctness, it should work correctly because here 'page' and 'tree_page' are never
the same page, which is guaranteed by unstable_tree_search_insert(). But it's not very intuitive, maybe
ww need to add some comment.

