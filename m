Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452207EE80F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbjKPUEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKPUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E231A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700165051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4XQ4i8Y5DNwJiAj9ly/ReOTlxs9KYLdEh1NBejN2C4=;
        b=GuEyVXrQuHVCQugwq+bPWiZUzUzD+RGg+iwWln9O5RNlrVAx9VI2tVPxxW2vILm25KYwh5
        auWurIE7Rit4j8MjTMztQYtA4vjAItvwH6Yhfbj7t+ARRQSStA/AgJIn6ZXahF5Xhu/9kM
        ViOfi6tY0zRD4x0RDg4L9t/EXSXGoBY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-4A8Bd_ElMxGxhxUFh0sH-A-1; Thu, 16 Nov 2023 15:04:08 -0500
X-MC-Unique: 4A8Bd_ElMxGxhxUFh0sH-A-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1f00b6ba9d6so294988fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165048; x=1700769848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4XQ4i8Y5DNwJiAj9ly/ReOTlxs9KYLdEh1NBejN2C4=;
        b=LiFmIyhCzKEBOQ6tSo7AYJiJLHPva4tFE0Kgs0tkAyzHqIclvpy6Wm645ZCQzsDups
         /wg7X+yVEkMwaK0lr9fPGefs+IC4bBepSxn4SkHUUNBp5ENa4vL8W3xd3tpRONNTjCIn
         W9USEI/4RpPIHG6IotXzxNQfEl3DMv5rusRbcFP+MuOcaCN1dO2ZSu1y+HFBLUXKM1ff
         klLDl6lGJYp9WSwxVYGTH4Sk+uUrvXHUEAN2bq+ccI1at6cadWKiP0fFgyqZ6yz3b1pn
         /+eUJLzF+BCJ+JcqW1ijvq15dJna1CcB1GqsExX6XYZIgI2g1XegkPICzC/f0AJPw+RS
         EZfw==
X-Gm-Message-State: AOJu0YwYD/RpjPgKHiquiCijmxxteAF0SrtfFA9vJKdvs8Q1GxR2HaUG
        7WFN6PJCVyfrG8RdbEYBwd7aoPXr3bMsB1bsBK6Cactee/9uz7YNE8TPaVf/R3sub+dVtOFhU1k
        S8qACyJFEkbUpI5K+03i/Rcza
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr10381849oao.0.1700165048057;
        Thu, 16 Nov 2023 12:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDPS7+wKj9qqDek4+rigv0rYOE1IH7oReMKMjyyoPNCSs/XVBtexRivZXLqhWKUZiqpeXWhA==
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr10381812oao.0.1700165047537;
        Thu, 16 Nov 2023 12:04:07 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j17-20020ac86651000000b0041b3deef647sm33619qtp.8.2023.11.16.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:04:06 -0800 (PST)
Date:   Thu, 16 Nov 2023 15:04:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        wangkefeng.wang@huawei.com
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Message-ID: <ZVZ1tLoOpRJu5n3g@x1n>
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
 <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
 <ZVZYvleasZddv-TD@x1n>
 <6308590a-d958-4ecc-a478-ba088cf7984d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6308590a-d958-4ecc-a478-ba088cf7984d@redhat.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 07:13:44PM +0100, David Hildenbrand wrote:
> > It should be fine, as:
> > 
> > static void make_uffd_wp_pte(struct vm_area_struct *vma,
> > 			     unsigned long addr, pte_t *pte)
> > {
> > 	pte_t ptent = ptep_get(pte);
> > 
> > #ifndef CONFIG_USERFAULTFD_
> > 
> > 	if (pte_present(ptent)) {
> > 		pte_t old_pte;
> > 
> > 		old_pte = ptep_modify_prot_start(vma, addr, pte);
> > 		ptent = pte_mkuffd_wp(ptent);
> > 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > 	} else if (is_swap_pte(ptent)) {
> > 		ptent = pte_swp_mkuffd_wp(ptent);
> > 		set_pte_at(vma->vm_mm, addr, pte, ptent);
> > 	} else {                                      <----------------- this must be pte_none() already
> > 		set_pte_at(vma->vm_mm, addr, pte,
> > 			   make_pte_marker(PTE_MARKER_UFFD_WP));
> > 	}
> > }
> 
> Indeed! Is pte_swp_mkuffd_wp() reasonable for pte markers? I rememebr that
> we don't support multiple markers yet, so it might be good enough.

Not really that reasonable, but nothing harmful either that I see so far;
the current code handles any pte marker without caring any of those hint
bits.

I can also reproduce this syzbot error easily with !UFFD config on x86.
Let me send the patchset to fix current known issues first.

Thanks,

-- 
Peter Xu

