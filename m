Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F697F9C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjK0Irm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjK0Iri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:47:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C2111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb4d366248so3140791b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701074840; x=1701679640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sa2C6hevcNV6Dl9tqszGj9RDMXGfLvCPyO01ufsuBI=;
        b=JND3ABHDgBkwTUWF5DQtbJVmSbNTnn55JCPvGhAzRLQFzBkgMZ32hewuUkgo02Eg/D
         r5+WurFnSQTYhS0/hoGe9SMkBjMU8YWdT1H4GLfXIXhlwkeEub9etLROw3qr9cowRiQM
         us7hy/XpRYdQSFH3WlFIYmK+Cj4Im8v8ZyynbspivgwSgLmjEJPex0yMZcTGQ9fbru37
         MfeZwI3tREcOW4Wds+PkT3TUNlrynYt2MnyeDorhdHE1b3kvu9IDS5SzEmoy25MxWMoX
         f4Ii6fJeUqtu4RvZrUFrJXjL72EzA+5SNxiWQvr3v4A4ZCyfBDTqUa9x6sg7sbMLnqUB
         SLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074840; x=1701679640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Sa2C6hevcNV6Dl9tqszGj9RDMXGfLvCPyO01ufsuBI=;
        b=jT4wdx6KAofiguLxfXKXVDL2VAJ2hQnuPCQ33lcVO2uQVxXado1/F3tGf8YOwImubU
         RCba3vDdsDx0ixS5Mvr384WCT0xdTjXsOzU7wdopu034K1O+RCsJex/Srx8SgYKM9Mmy
         39g3jOzMnQelAnNjypzuUFQ3WPk0caEmiFSOtaeKm8zEHu+kbRuskL0xs9Z1XAQSRF1q
         z2vdErt3whWrJhLFyh0YUc5An0Yx/PhfHl4Dax+jPU95duNzFGmHVpOlip48hZ+juUGX
         Ty7ysk9y0lzysd0mHPk9eRha0MJyI94EH1hHZAYMqALPbq1FGPnAlF4kg487zsVGrJZ0
         8xfQ==
X-Gm-Message-State: AOJu0Yw8MSQiyBN7Pau7D5RqQusLeQYI/iMpLJmNHOnqCcXKcEWoJEgR
        xjnBkYGAx+gB6rOmEsUzdSRmxQ==
X-Google-Smtp-Source: AGHT+IER+3HNPer8f2/FkqltCg3CtQYI9QGod+kfV5wUzf12yUTb24cfgQOsNCWRWoRfTCI5RE1deA==
X-Received: by 2002:a05:6a00:1f0a:b0:6cb:63cb:83c0 with SMTP id be10-20020a056a001f0a00b006cb63cb83c0mr11865332pfb.29.1701074839860;
        Mon, 27 Nov 2023 00:47:19 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm6686932pfd.121.2023.11.27.00.47.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Nov 2023 00:47:19 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] Code simplification and clean-up for hugetlb vmemmap
Date:   Mon, 27 Nov 2023 16:46:41 +0800
Message-Id: <20231127084645.27017-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to simplify and clean the code of hugetlb vmemmap, please
look at the commit message of each individual patch for more details.

Thanks.

Muchun Song (4):
  mm: pagewalk: assert write mmap lock only for walking the user page
    tables
  mm: hugetlb_vmemmap: use walk_page_range_novma() to simplify the code
  mm: hugetlb_vmemmap: move PageVmemmapSelfHosted() check to
    split_vmemmap_huge_pmd()
  mm: hugetlb_vmemmap: convert page to folio

 mm/hugetlb_vmemmap.c | 259 ++++++++++++++-----------------------------
 mm/pagewalk.c        |  29 ++++-
 2 files changed, 111 insertions(+), 177 deletions(-)

-- 
2.20.1

