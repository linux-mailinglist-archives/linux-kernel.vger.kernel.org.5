Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D8803B81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjLDR1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjLDR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:27:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA43C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:27:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d0c4ba7081so78366597b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710832; x=1702315632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIP1VBSrHfriGjh5Ogk9INZtbtmoj9c5sEQfKrkJBSE=;
        b=m4uH/7hzVu5zigT1huoKtvcvFkWnSAug3GAlEda3+9FUh0K+crF/J5hHQzUHGAt4rl
         ej3lyThtJQiZunyJaNC8od6dZxLx6rwkT40wY/fwMY+B7TLGEa/fVu4xO6M/KNGnm+sD
         rBNbNpbOGcoFRpglZ4viyH0DMU1/KrJnD7N2wzTTr5YcHzI+FPQG3SXhraLaBbNdyQNQ
         6c2Wxx+98ueDomh7lThK9UM52Ewh0/BMzWkxtC0A/6QZGdUF82kkmgvxSpknTvVf8aUW
         T1trWAXZclpo1OP63LF7Yaacq9pxr//sppS719lkVKiTquvM2eTH2zy1ZqXzdQBXjlsO
         I7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710832; x=1702315632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIP1VBSrHfriGjh5Ogk9INZtbtmoj9c5sEQfKrkJBSE=;
        b=pQCpQ7NQLtJm+nr9S9imziSyZKEqLU0xcPaptpFgPVdOixN7kcOlg5y4/x+jhSp3aB
         pcsz//4yXFwmteaeucEqeC/RHmTz6Cq3Bwojf4RH+7Q1wqrrmSLvbblWsgKwL8xRhGCG
         hfJCJQbLiM/EwHD+iD6dIb8gth87eyzIXznvvpqjMVARLOwtCNp3mj4ARez5uPtk7l46
         6YqtpE58zFSHRVEVTUuiATkI86Pl9G958zsl+UYeBzAz4O3uvaDj13CLrQOntfP5Dl7U
         R9jcBWCl6a2M7ndfWSJaBkKrsM9uLWD6RxK3aWY10N7zJzuvmxM7N1bzxUyCgB9uqPGm
         V7aQ==
X-Gm-Message-State: AOJu0YxJt9qkbLmh7nZCFzH+UrJBwpAB+OnaWWIRw+33mNk1b/BWvFzv
        iJuEXdCBI8AKSK+Zapt6wzZiylhGLoXUEAY9
X-Google-Smtp-Source: AGHT+IFq88uu4hPlgv5GbGd/ux88m4iUlZ64ATBmq3rePqIk98p8cvyl0w6nJZb3uZTHk5FQwmgEwV0mbM4oM1P0
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:2710:b0:5d5:5183:ebd7 with
 SMTP id dy16-20020a05690c271000b005d55183ebd7mr222984ywb.7.1701710831851;
 Mon, 04 Dec 2023 09:27:11 -0800 (PST)
Date:   Mon,  4 Dec 2023 17:26:46 +0000
In-Reply-To: <20231204172646.2541916-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172646.2541916-3-jthoughton@google.com>
Subject: [PATCH 2/2] arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify
From:   James Houghton <jthoughton@google.com>
To:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it impossible to create a sw-dirty, hw-clean PTE with pte_modify.
Such a PTE should be impossible to create, and there may be places that
assume that pte_dirty() implies pte_hw_dirty().

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b19a8aee684c..79ce70fbb751 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -834,6 +834,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
 
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+	/*
+	 * If we end up clearing hw dirtiness for a sw-dirty PTE, set hardware
+	 * dirtiness again.
+	 */
+	if (pte_sw_dirty(pte))
+		pte = pte_mkdirty(pte);
 	return pte;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

