Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDF7CEB89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:01:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E56114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:01:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso4977436b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697670083; x=1698274883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeBSz/e8uYkWV3uKMPbuMCCs2Qe4sufjGN1Hon5hT9Y=;
        b=cnvaAjJCAjQs2RACKo10A/i7/Yjg5xKurPNk+eoE4wlazHrKRDSPFdT/34vUMvyFrS
         SwG4kooNBz7vz+wrrF1HqFbEa0BSbFiaoHjq/Q6egcRIXk/iTanSBatsxUVyDCT/gpxc
         WbP2XP8g6A11X8VpHEtZHPqf66b2IXvNIa9HBZQcwuYQMoJ8JW+I6DEog0tk8MbSKpxy
         05Xcrss4BO9EoR7RR5pEX8uPxXXzrQJvVsuUi11QJJJvMSfxdvpaivIzBF3RSk+HUrx8
         DUUn8DoSeJNwa61MKOkFhPL4sNC/+qVzJUCRHWza5nwFn8LDORuPXBnYxIG+qC3meQ4m
         P3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670083; x=1698274883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeBSz/e8uYkWV3uKMPbuMCCs2Qe4sufjGN1Hon5hT9Y=;
        b=PZwXmlW2m4RXJ0jQxKOF5FgBWTNVUQmP9nE3F1XgDZ8fOicuE+JgnOq0uVW6xndl2l
         46Fa7xB7nxuZBB6MmvQfEdkLJvtwnCc8Ig4IE/cW5A+e0lJquJYr9f4AxvbbgMabnV9S
         QLyb+49vvApg0eC8cJH9WwqHwfW/xjgcN/MDzDSr3E7vCp+30UEb7w4w0la/oW0PFzxb
         E49mxzj3JQhNILHFprbM9m39Bvl51gN7xj7IG8HjFG9aiWZJuHXcm7ddGhrZU63bZVPl
         9wFwOrU8WwKjMJMD5cXkIjbn2iVel6suIrzN1viP2YRifJLIk2TSdOHnsKxqcg2/CV1Q
         3cjQ==
X-Gm-Message-State: AOJu0Yw0MSwFECSPyjbf+/kA7WmNQDWXDNSX3kS2z3TUQyC0cngAnkMd
        WSquBHATq8K+39Mn99KTY9M=
X-Google-Smtp-Source: AGHT+IHjKoxN0D8+FMnbEY+Wlmj7R4d03KYlxj2pcGC3jDKRtDimoGB73Rodd3bR5eaVLdUQVKixSw==
X-Received: by 2002:a05:6a20:1604:b0:15e:986:d92b with SMTP id l4-20020a056a20160400b0015e0986d92bmr627175pzj.16.1697670082760;
        Wed, 18 Oct 2023 16:01:22 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001c3e732b8dbsm461189pld.168.2023.10.18.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:01:22 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:01:19 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com
Subject: Re: [PATCH v2 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp()
 to use folios
Message-ID: <ZTBjv4jyQ5/zu5cw@fedora>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
 <20231018203213.50224-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k9WjaocPDLBP3aBR"
Content-Disposition: inline
In-Reply-To: <20231018203213.50224-6-vishal.moola@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k9WjaocPDLBP3aBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 01:32:13PM -0700, Vishal Moola (Oracle) wrote:
> This removes 2 calls to compound_head() and helps convert khugepaged to
> use folios throughout.
> 
> Previously, if the address passed to collapse_pte_mapped_thp()
> corresponded to a tail page, the scan would fail immediately. Using
> filemap_lock_folio() we can get the corresponding folio back and try to
> operate on the folio instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Hi Andrew, I've attached a fix patch addressing the syzbot issue.
It can be squashed into this patch, syzbot tested it on v2 already as
well.

--k9WjaocPDLBP3aBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-syz-fix.patch"

From 34d60af8cb66d6f582c1aeade01689e94e8a0092 Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Wed, 18 Oct 2023 14:24:47 -0700
Subject: [PATCH] collapse_pte_mapped_thp() folio conversion fix

filemap_lock_folio() can return an ERR_PTR on failure.
find_lock_page()/pagecache_get_page() handles this internally, while
filemap_lock_folio() does not. Ensure this is checked for in the caller
after converting find_lock_page() to filemap_lock_folio().

Reported-and-tested-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 94c1dd09a8a6..b944ed231792 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1510,7 +1510,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 	folio = filemap_lock_folio(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
-	if (!folio)
+	if (!folio || IS_ERR(folio))
 		return SCAN_PAGE_NULL;
 
 	if (folio_order(folio) != HPAGE_PMD_ORDER) {
-- 
2.40.1


--k9WjaocPDLBP3aBR--
