Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D87CE903
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjJRUdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF5A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso4878987b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661186; x=1698265986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8jWDR/ZgJmIkKKp66piz2uVDLnH/M22Jlwkva7IsYg=;
        b=nb4+Hx7koEYA4We5DJIE9p96KnZtXRl9+8ZmJWpvbdTB71CKVlbNIbB+rOGRIHVGCm
         RDanut/ho0AxUrC8SIIREqpwH9wtKpEuyU5craPRuU2GQM0KsB7Kesohw78qTK+8F/KQ
         CEQxU/2mGgJiljRFuRs0LkYHZz/5rjzyCYPvjDNH1HJN8JougT8bdDpnaxvhyMdS9I+v
         v67pKdd08ZcpzOyUAmqMs9BoULO+rANNcKHLe6r09Kgv1VxLYs+Tc4bjJH2Nw/x0ijJN
         ulQx1WsVx0ewhjMVVcuVzsMZfm9JUlRT+R3gk5e/q1fW0PqNT+Cs1cj8gRWx7F5cmJcr
         K9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661186; x=1698265986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8jWDR/ZgJmIkKKp66piz2uVDLnH/M22Jlwkva7IsYg=;
        b=nD5MWOrHtnkjCLiHKFLDTWHuNRFZX40HGwn7J/fInBw+u7tnaCM/uaWsCkp+SZ9TQY
         zYYQ8lqNEeHEbKosigNxOEQH4ur21xPjnr8s9+ftrlsLBnTKrFeSS/JA+Qds3DXdGpLe
         i1VMm+ADBaY6vA28MHUAgYLJbCXobCETrjhk3eQiWt5OSiFUPliBQQ+eUMj7eD5HSntv
         RFaQtkZRdvj6VcFdnqUfE2+WFeI4DioGuNVbHblph/VW0LLM7a74dMIzL1sUdQexGWoR
         ANRU2EPq15jslLQKLnXqHDdnF+JEx2mgCqAQH+LxCw37QTJ5NEpHfeWT4ZTLYlpczhmf
         wc1Q==
X-Gm-Message-State: AOJu0YzE7tQuBovrUSVeSCvhVa3PfkTa+/5k6PXjhXLWFqv9UuSjmlt3
        yxuMhM18bf5xbxXOlg+Y0KQ=
X-Google-Smtp-Source: AGHT+IH0hnK1spD0NMASNofGlsws/sPM/TTyB7tCLaOY/hN83Q3KmURqvBqsuwZWLr8g9CSjzJw7Cw==
X-Received: by 2002:a05:6a20:da83:b0:163:2dc7:d077 with SMTP id iy3-20020a056a20da8300b001632dc7d077mr293178pzb.55.1697661186019;
        Wed, 18 Oct 2023 13:33:06 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:05 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/5] Some khugepaged folio conversions
Date:   Wed, 18 Oct 2023 13:32:08 -0700
Message-Id: <20231018203213.50224-1-vishal.moola@gmail.com>
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
v2:
  Remove last caller of count_memcg_page_event()
  Stop using the folio_estimated_sharers() heuristic for tail page
  sharer estimation

Vishal Moola (Oracle) (5):
  mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
  mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
  mm/khugepaged: Convert is_refcount_suitable() to use folios
  mm/khugepaged: Convert alloc_charge_hpage() to use folios
  mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios

 include/linux/memcontrol.h |  14 ----
 mm/khugepaged.c            | 135 ++++++++++++++++++-------------------
 2 files changed, 66 insertions(+), 83 deletions(-)

-- 
2.40.1

