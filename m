Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169977BFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjHNSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHNSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574B710F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNQlVHJQ4pIimjZoX+ixCZ4sXgWXT3PPMnETr4dtlP8=;
        b=e3m5+RW+L++sUxEgovgcRLte12Q/eZj8CW2T+dwHmGxN4WYAdExwPgEjmAQl5qhDjLMRvN
        glUkdfSYQsp4334jeGNlrR457mY/Ear1WDzjQkSi6XwZfnB3Ukk2hQjdD32SXAhPOEWCiD
        rVSXjmpUzIsS2bYAIP1EUkaepLucZj0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-moGkRko0MOef2uSPbji2gQ-1; Mon, 14 Aug 2023 14:44:17 -0400
X-MC-Unique: moGkRko0MOef2uSPbji2gQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63c9463c116so13418396d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038656; x=1692643456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNQlVHJQ4pIimjZoX+ixCZ4sXgWXT3PPMnETr4dtlP8=;
        b=dMJoQxNpKx1p2pDiOlGf/sb6e/CHlHKIswmAzJ4lvAyc1jTrESzSpisrNkA5xBpoVM
         alqc+MCSwYa7zWiyidpUafGaWLUDRkTu827Nsgr2vAJFIH1DS0nhzg5dgn5nTo1ymPaN
         UPBCy9BQI+mD48Th9laUYzz8fUQYWy0rYPgfksx1UsEzWlQMabaJo3IH0xWYBGjPwA2z
         U7yD4iwrMEZpDp8MiL6umcAr9Io99VDoQzMpVv1gVi6tHbVWtpJPzAWTJzoTDUMzc0CB
         zmEqpjYmZccHkkIqhDgAVvn8ajbW4MV0hSNN/l+doPwf25B6HKI7GECx77LxhEPvie35
         kfxQ==
X-Gm-Message-State: AOJu0YzaZc1jDLHYjcYsmwB227MtOeqScizvRcnreRb0b96UqKeIZBne
        Keoy2/9mqkGw4r/EnMuhkJLCZuNQG/DBkYDJ8gOPQ31VWbC5dtwnWQtJU3Ig8ndYbxnxhxMSqUZ
        X+dzPubcgaGEC04cZKezM0bBG
X-Received: by 2002:a05:6214:1d09:b0:635:d9d0:cccf with SMTP id e9-20020a0562141d0900b00635d9d0cccfmr14721970qvd.4.1692038656343;
        Mon, 14 Aug 2023 11:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg5lNOTyDZrEVxNjNHMJ72ccEGFwymh3Zpf7FNl3V4lRHNSY8M7kb1dQ3rnyfSzoGymgcKPg==
X-Received: by 2002:a05:6214:1d09:b0:635:d9d0:cccf with SMTP id e9-20020a0562141d0900b00635d9d0cccfmr14721945qvd.4.1692038656034;
        Mon, 14 Aug 2023 11:44:16 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cb347000000b00630c0ed6339sm3566561qvf.64.2023.08.14.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:15 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 2/3] mm: Reorg and declare free spaces in struct folio tails
Date:   Mon, 14 Aug 2023 14:44:10 -0400
Message-ID: <20230814184411.330496-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814184411.330496-1-peterx@redhat.com>
References: <20230814184411.330496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not 100% clear on what are the free spaces in the folio tail pages.
Currently we defined fields for only tail pages 1-2 but they're not really
fully occupied.  Add the fields to show what is free, and also reorg them a
bit to make 32/64 bits alignment easy.

Here _free_1_0 should be a constant hole (of 2 bytes) on any system, make
them explicit so people know they can be reused at any time.

_free_1_1 is special and need some attention: this will shift tail page 1's
fields starting from _entire_mapcount to be 4 bytes later.  I don't expect
this change much on real performance - if it will it might be good to have
_entire_mapcount and _nr_pages_mapped to be put on the same 8B alignment,
assuming that _pincount should be rarer to be used in real life.  But in
all cases the movement shouldn't change much on x86 or anything that has
64B cachelines.  This is the major reason why I had this change separate
from the upcoming documentation update patch - it may need some attention,
and when unwanted things happen (I don't expect) we quickly know what's
wrong.

_free_1_2 / _free_2_1 just calls out extra free spaces elsewhere and
shouldn't affect a thing just like _free_1_0.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3f2b0d46f5d6..829f5adfded1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -329,11 +329,21 @@ struct folio {
 	/* public: */
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
+	/* private: 2 bytes can be reused later */
+			unsigned char _free_1_0[2];
+#ifdef CONFIG_64BIT
+	/* 4 bytes can be reused later (64 bits only) */
+			unsigned char _free_1_1[4];
+#endif
+	/* public: */
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
+	/* private: 4 bytes can be reused later (64 bits only) */
+			unsigned char _free_1_2[4];
+	/* public: */
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -355,6 +365,8 @@ struct folio {
 			unsigned long _head_2a;
 	/* public: */
 			struct list_head _deferred_list;
+	/* private: 8 more free bytes for either 32/64 bits */
+			unsigned char _free_2_1[8];
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
-- 
2.41.0

