Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A67EBBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjKODQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:16:02 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FACC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:15:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6c34e87b571so5392062b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700018159; x=1700622959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4Ea1f5N/gqKkZF2UAjZC/hFg+PjK9kJPhmAlWJLxS8=;
        b=ewoCInhtwdLqEtV9sAc0f8LvYHlQHni0AVabHJqw/mOOIi6eMghjAklJNxrdtBrvoY
         5JZSy9qcnqK7zjstA4bzbbHE85bmxHU32cgPGSwCPqGU+LT0q29ynmHLYZm0vyLe/hPM
         meOQWvuhPgHmo+h48QU72GWvBjchzcd0O6ccJftc/GPyzm5voCgJjZsSno8ekFPhMxJE
         vOmPtxNce+Vi8/QrJa94xjtdi1t7AlR0pGJuA+wfCeoh+GbpOgEJ/hdhXTWUZJ7+C8rp
         yMX8JPOefd0XgrerBjGRKcMl7faTjDrpr/e179Ahq7VyqFRjfdv01fsdKxPNStdXMaky
         Pnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700018159; x=1700622959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4Ea1f5N/gqKkZF2UAjZC/hFg+PjK9kJPhmAlWJLxS8=;
        b=PvwhBKXbHMbg3B3XwYcSVZ+kv6MRoUeY150v3NM/4ZDkn2sOXJeJ0KwmejtFlHSaTX
         h9ISAyEj2u1CTEtd8yNd0/79sYonwzGNrVoWXwplc1NW1q79dJ5JZe8d+IWvNEYwGtNu
         G84uz/mkuNxJpIrox4ySnHifcaGBs0cvgjjVYpDHeMuETbVYGLM7BL9CGiP0n0MupYA3
         mHCdbkTtfo123t0l19ncZh8Ig39IKipZwx38WpF7Ma9iCdNCtp9DHsN+7hC1kXpZiqfw
         F0snj5CLb0+LLQluiDpmPxdIe1SZPK9zxdJEMnotFqyzJIlnRdRWusisu6v+v/4jbgjc
         65fw==
X-Gm-Message-State: AOJu0YyyBrtArvyNEwHM0qiH6poMN7ZEwS2ZFbqiZsc/ikYJTv0tGfSt
        LimSqyHDUid9OQJshpznv9c=
X-Google-Smtp-Source: AGHT+IFH/UcrBIf8ZaeLGZ1shmqLDybbtB31S97IR5xQhWxMAMw9vAwbHI7XYj0j4MhdA0BFD8dbrQ==
X-Received: by 2002:a05:6a20:5487:b0:186:de1b:628 with SMTP id i7-20020a056a20548700b00186de1b0628mr6538717pzk.21.1700018158786;
        Tue, 14 Nov 2023 19:15:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b001bb0eebd90asm6396271plg.245.2023.11.14.19.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:15:57 -0800 (PST)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin.sc@gmail.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Date:   Wed, 15 Nov 2023 03:15:53 +0000
Message-Id: <20231115031553.1970634-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <938be193-8a73-432e-b424-53afa9f8c38e@redhat.com>
References: <938be193-8a73-432e-b424-53afa9f8c38e@redhat.com>
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

>> From: xu xin <xu.xin16@zte.com.cn>
>> 
>> Background
>> ==========
>> When trying to merge two pages, it may fail because the two pages
>> belongs to the same compound page and split_huge_page fails due to
>> the incorrect reference to the page. To solve the problem, the commit
>> 77da2ba0648a4 ("mm/ksm: fix interaction with THP") tries to split the
>> compound page after try_to_merge_two_pages() fails and put_page in
>> that case. However it is too early to calculate of the variable 'split' which
>> indicates whether the two pages belongs to the same compound page.
>> 
>> What to do
>> ==========
>> If try_to_merge_two_pages() succeeds, there is no need to check whether
>> to splitting compound pages. So we delay the check of splitting compound
>> pages until try_to_merge_two_pages() fails, which can improve the
>> processing efficiency of cmp_and_merge_page() a little.
>> 
>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
>
>Can we please add a unit test to ksm_functional_tests.c so we actually 
>get it right this time?

Sure. Maybe we can simply refer to the reproducing way Claudio proposes in
77da2ba0648a4 ("mm/ksm: fix interaction with THP").

>-- 
>Cheers,
>
>David / dhildenb
