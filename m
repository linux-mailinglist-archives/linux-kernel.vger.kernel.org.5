Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA07EE092
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbjKPMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:17:23 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E86187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:17:20 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cc68c1fac2so6905355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700137040; x=1700741840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aq51udqPabDrhMIIqZFnTBT5LeHwsY7uMRmk0JI2FA=;
        b=YwnHPyaVDJeqZJLEEKd5TeHCDA3W45rthHuq3CGwyPrKpEyQnwcOMVfVuGbJ0ImEwl
         1QC6/vKPseLMKfdWbAdmkZ53wfhCj9lS7dzrZZRzzUQZpoQH4ZIacS3Scuhg88850xA9
         2oDZMRRldJenqe300xJBW/bwAJfZGQqcDvk+Ede0Mq0b5ybIhMTy9/0nk0aOFzrdjCet
         AI7ey0yLjWhE2Zob8UuTY5zyvhJQTohxC/job3MDDDmYej8qs0i2Yfw9cAdhBCOPz2e7
         K3lgxlkH6ZlnZMsBDnFXA5K2RAV3fp0ynebbpaukPW5c9M9r50N/aZ4RB0jpvHCur9tH
         1l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700137040; x=1700741840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aq51udqPabDrhMIIqZFnTBT5LeHwsY7uMRmk0JI2FA=;
        b=wYElfyrHOZ5s6H6xtOZid+tEq4Kk52b+ZJ8f3a8O7g/ek2zguXnVOg0tE4DGHbDetM
         8jF2CFaydtwGx2du7GwOO2qlN3/mK5BI+XFCVyWyOu7jcyP5WhLowHtG6zgPBIDlnXi8
         bTcKCwaYd+8D3J0X7P63ua51878XvOJdMsncPF0KDhrt9cBMCdaXD+3nLyYvqwiW/bCC
         kNjMcxwngLgF/+cnJJZV37WrtcnHmkOABuD/VSEbasg6lks7hOYcXSixm/UCBl5WgU/N
         t5qnSi6YG2VdXSUNZ+uvzpB4mFulf87sVAPAYPsZ4fT7sfzdu2lYc+0phVsVfL29x5jh
         g50Q==
X-Gm-Message-State: AOJu0YxG1eJKe4arhl2IEVnVo5paxcW+NMfPz/Gsa8jnK2dvjngtaCoI
        TVYvR261nnOctyLALvTG9o/FQO9HJ9Ihig==
X-Google-Smtp-Source: AGHT+IGccebkPsrncb2428ZzEoT212XQZ/yDquuab+aT+2dHdHsC7S/sg7r7nKcnYlGPujAmIRCKpw==
X-Received: by 2002:a17:902:e803:b0:1cc:4985:fc15 with SMTP id u3-20020a170902e80300b001cc4985fc15mr9318166plg.27.1700137040000;
        Thu, 16 Nov 2023 04:17:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b001b8b45b177esm9085780plf.274.2023.11.16.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:17:19 -0800 (PST)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin.sc@gmail.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Date:   Thu, 16 Nov 2023 12:17:15 +0000
Message-Id: <20231116121715.1974713-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d87bfcdd-cbaa-4485-a63b-6a524681fa08@redhat.com>
References: <d87bfcdd-cbaa-4485-a63b-6a524681fa08@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> @@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>>>    	tree_rmap_item =
>>>>    		unstable_tree_search_insert(rmap_item, page, &tree_page);
>>>>    	if (tree_rmap_item) {
>>>> -		bool split;
>>>> -
>>>>    		kpage = try_to_merge_two_pages(rmap_item, page,
>>>>    						tree_rmap_item, tree_page);
>>>> -		/*
>>>> -		 * If both pages we tried to merge belong to the same compound
>>>> -		 * page, then we actually ended up increasing the reference
>>>> -		 * count of the same compound page twice, and split_huge_page
>>>> -		 * failed.
>>>> -		 * Here we set a flag if that happened, and we use it later to
>>>> -		 * try split_huge_page again. Since we call put_page right
>>>> -		 * afterwards, the reference count will be correct and
>>>> -		 * split_huge_page should succeed.
>>>> -		 */
>>>
>>> I'm curious, why can't we detect that ahead of time and keep only a
>>> single reference? Why do we need the backup code? Anything I am missing?

Do you mean like this?

--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2229,23 +2229,21 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
        tree_rmap_item =
                unstable_tree_search_insert(rmap_item, page, &tree_page);
        if (tree_rmap_item) {
-               bool split;
+               bool SameCompound;
+               /*
+                * If they belongs to the same compound page, its' reference
+                * get twice, so need to put_page once to avoid that
+                * split_huge_page fails in try_to_merge_two_pages().
+                */
+               if (SameCompound = Is_SameCompound(page, tree_page))
+                       put_page(tree_page);
 
                kpage = try_to_merge_two_pages(rmap_item, page,
                                                tree_rmap_item, tree_page);
-               /*
-                * If both pages we tried to merge belong to the same compound
-                * page, then we actually ended up increasing the reference
-                * count of the same compound page twice, and split_huge_page
-                * failed.
-                * Here we set a flag if that happened, and we use it later to
-                * try split_huge_page again. Since we call put_page right
-                * afterwards, the reference count will be correct and
-                * split_huge_page should succeed.
-                */
-               split = PageTransCompound(page)
-                       && compound_head(page) == compound_head(tree_page);
-               put_page(tree_page);
+
+               if (!SameCompound)
+                       put_page(tree_page);
+
                if (kpage) {
                        /*
                         * The pages were successfully merged: insert new
@@ -2271,20 +2269,6 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
                                break_cow(tree_rmap_item);
                                break_cow(rmap_item);
                        }
-               } else if (split) {
-                       /*
-                        * We are here if we tried to merge two pages and
-                        * failed because they both belonged to the same
-                        * compound page. We will split the page now, but no
-                        * merging will take place.
-                        * We do not want to add the cost of a full lock; if
-                        * the page is locked, it is better to skip it and
-                        * perhaps try again later.
-                        */
-                       if (!trylock_page(page))
-                               return;
-                       split_huge_page(page);
-                       unlock_page(page);
                }
        }
 }


>> 
>> I don't know the original reason, better ask Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>.
>> Maybe because doing detection that ahead of time will break several funtions' semantic,
>> such as try_to_merge_two_pages(), try_to_merge_with_ksm_page() and try_to_merge_one_page()
>> 
>> Adding the backup code don't change the old code and fixing the old problem, it's good.
>
>It's absolutely counter-intuitive to check for something that cannot 
>possibly work after the effects. This better has a good reason to make 
>that code more complicated.
>-- 


