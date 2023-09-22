Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5E7ABA24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjIVTg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjIVTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:36:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D9B9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2461746b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695411409; x=1696016209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=da37cK7f0DLWm75F0VD76b8MmO4wjEBlXspBzXAT+eA=;
        b=hSLmnZkIS82o96fDvUHDbnt9NZWo2JjNhU/M54R8WxbG33pMWOo8rKpa2aKJ31VNFT
         NCb0RgCQr84fz1jOYdW+lJcyKdfIF5zFpLiruc5zOD9nxVghnOCaGogsycyIjQvkmiDo
         ZE/KKdUJoDLYh9n0/Qp/n2NjgabJi8iLOqeKX4zzcYGh/ICRjRCCqI3SN2lQnFX427pd
         Jz8GiZc5H+D+XX7V9XCgmjNQjVK+ETdqE/tL4bOyRokHrsfr6o/GDJ5jVeEVGkUE/8nf
         mFuBqoElWD9RgnQvd59VomiVCdTAGWS5OAtQ43c2+uDJi0a6H6eldZlOFV+AyoWm4eFa
         ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695411409; x=1696016209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da37cK7f0DLWm75F0VD76b8MmO4wjEBlXspBzXAT+eA=;
        b=NbKHUKMAQQTNbmcKvSFbFdhzX1wpFNUxCaZoKbodSaqauVFwqeLJPOwYG8F5tIzJ5R
         NU7/jAHO75H+NmpP+4NDW1h3CyL4UCMCUKZzP7b4RN8Eg5rMOZH9VzB2fsmX9Hq9VQ5x
         WFbsT04u5r9vSljRTNxB0akiMsUAh8nszA2YWcdHXjMBE/Ur1QpZQAoPI03XfAQmCpT0
         1rkNY22gW40lQnGzWUts1y0zb5T732wXPMaz9N3m+FUOUcWr5Ka5QNZ1RmZ9YUfBsz/Q
         Wm9FBFoIio2TUpVzKYcdYIz81z/h4CHf5DpWUMrxLW06J/z+guTY6uDxTZy8lK54TE/6
         T1PA==
X-Gm-Message-State: AOJu0YwSW1Gk+ddJ89XdmXOKPYHE+cqygqQ6HN8gIsPgzAABWAv3rU8G
        7+eg1DYqi25v+ZGBn5pVgFyRpIBlzC8=
X-Google-Smtp-Source: AGHT+IGk/RM8lFrrGh1H3NphlAexv0hlMQ8zEl2wSgRTT/hugTmYBbr7IoROasfPjVl/I8Nf2/Bn2g==
X-Received: by 2002:a05:6a21:9805:b0:157:877a:5f5e with SMTP id ue5-20020a056a21980500b00157877a5f5emr338411pzb.61.1695411409240;
        Fri, 22 Sep 2023 12:36:49 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170902dad000b001c0cb2aa2easm3841833plx.121.2023.09.22.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:36:48 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 0/2] Remove compound_pagelist from khugepaged 
Date:   Fri, 22 Sep 2023 12:36:37 -0700
Message-Id: <20230922193639.10158-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, khugepaged builds and uses a list to properly account for
compound pages. Now we can use folios to account for these compound pages
as singular large folio units instead.

Removing compound_pagelist streamlines the scanning/freeing code in
khugepaged, as well as reduces the overall size of the kernel.

Vishal Moola (Oracle) (2):
  mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
  mm/khugepaged: Remove compound_pagelist

 mm/khugepaged.c | 116 ++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 78 deletions(-)

-- 
2.40.1

