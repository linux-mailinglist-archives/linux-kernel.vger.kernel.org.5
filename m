Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BDB7CB3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjJPUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjJPUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FAE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so3147447a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486815; x=1698091615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F7OC++xn+kkTY71IkQWnoFxTqqatmRbWWQxi/FzcJo=;
        b=Uej+szlynz4EmjMPypHm0od5E7oEZJ1phjbsdC4ZgCgrzvlR62wZbeQsKrJF3JN9rq
         M58JHNeNFWKvR2MAO2jCZbgGaCqBJdMpLTDnbnzQxaSMPUhDpuH4lmZalPxtrDNpj7eY
         HVqbz08snJ95GNuolKxEV7XWHVXwnsHc8IMMYfzbkiQM88IoU4xSfkbwtXLHVcHSfajD
         36wa3HxId4WdRWehWZLChWp5YvPzuepRZl9OpG+FSJIIiXVBPShtlvpdhTaFKv+EsDlk
         JJ3IoT0wRetXTDLN4OGXXkcKLl36t+9uU2GihDznZyu5BX0eJXCH2nJ+uDNT1RCysa/p
         QjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486815; x=1698091615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F7OC++xn+kkTY71IkQWnoFxTqqatmRbWWQxi/FzcJo=;
        b=oIkLjjR5MYiIF1zCnmFWF+u8w0GFMb964BJUrWiBY79nnUnF7CwgRnYGJiA4EwsQtK
         uWXEMS7REstFFlqbNLfnv3UxbqK/B0oH+yXT1bRTRonWVzinWgQ5QK7F5/XP4c25vx8a
         +gMW5pIlt9ILU4+4sp/invGZbdkw3o9QGosc3EwRE5Sk/FhfvosSAwxg/X2Jaumxn6PJ
         D8PKd6aCRvdw9RWtGd0lyRRXQRZTbyKBaq3UMo8WKdeQmVniBSFVjy48DkM7NAuoOZgR
         Sh5Z6dWv0vbG1KwDa0I9ke98jabyW66FSkdrQLLuu2h6dK0uYo2fbhy7fLnQsyPnDB+E
         8I0A==
X-Gm-Message-State: AOJu0YyITucbRSMmDKPEApt1nwycbI6YGhhqRTeMwtZOb/qDMHwFnMI0
        bOPujbdkRLkilLKEP3cSS40=
X-Google-Smtp-Source: AGHT+IHRe/04l7y/WWAAnARrrDNmRIvsMR57xoWNqeU+M4PHMsebtC+kDe7i3+rbZZ1zLcbUFsuD8Q==
X-Received: by 2002:a17:90b:528d:b0:268:1355:b03e with SMTP id si13-20020a17090b528d00b002681355b03emr176566pjb.38.1697486815380;
        Mon, 16 Oct 2023 13:06:55 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:54 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/5] Some khugepaged folio conversions
Date:   Mon, 16 Oct 2023 13:05:05 -0700
Message-Id: <20231016200510.7387-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts a number of functions to use folios. This cleans
up some khugepaged code and removes a large number of hidden
compound_head() calls.

---

The first 2 patches break khugepaged max_ptes_shared selftests as the
functions now use folio_estimated_sharers() instead of page_mapcount().
This is expected, although I'm uncertain as to whether that's actually a
bad thing or not. Some performance testing/feedback would be appreciated
on that front.

Vishal Moola (Oracle) (5):
  mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
  mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
  mm/khugepaged: Convert is_refcount_suitable() to use folios
  mm/khugepaged: Convert alloc_charge_hpage() to use folios
  mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios

 mm/khugepaged.c | 145 +++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 76 deletions(-)

-- 
2.40.1

