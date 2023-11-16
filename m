Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F847EE82C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjKPUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjKPUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8395E1A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700165751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BXyMUvPFi7/b7BrzgsNqnZhAP3xYr4UsmeMU4TKgC9Y=;
        b=OYuqUDgAQ6QrerB9URuJkJp4vkZqjDNI8FjjAxS4gP53PkVdOCJHfDOA9+xyNdFYcEqKPS
        0b1SZB6rKYODn03izIM3qhfUiJuZ3drFpQgSwGS68BWHOMVE2J/8unXTlenRb4PgjcGv/x
        99zzQKEV6mR9qwZShCQwj81nKch7LQA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-D9lzHgoON8iiNCuWAx8qzw-1; Thu, 16 Nov 2023 15:15:50 -0500
X-MC-Unique: D9lzHgoON8iiNCuWAx8qzw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3eaecbc4dso286346b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165749; x=1700770549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXyMUvPFi7/b7BrzgsNqnZhAP3xYr4UsmeMU4TKgC9Y=;
        b=ocH9Ef26/bvmNBwZniNp2pYHwMgpFfIvTXHwwEo6mTPj37cHWs34zGT1y0pLGVfsRp
         qrjBh7CR32VLN3aGIly4yvBVkQEUXORUdmgB2CwTYhVo3INCUUPhEMYl+sKFRUHNjVmD
         h5ptqowIeTRVjhwJBzyWvSy9rrSDj41pqM/C+PIw3uSoOSW7eprgb2DoW8tLAyEoLLvQ
         i68YMQ0VFDyo2AK1ThoNTDTz6UTxvAgydUUIpX++dbm9sgZH+K9f2XKyXVMHSf1xTJXv
         ut2pisP5ORXHE90Yg6W8RxTNN5byhK0Kef2YVieSx89xgJvf+1Z08Ts7HlaZtTLEei2v
         KEog==
X-Gm-Message-State: AOJu0YwC9W3ocpbC/3rUvhuG3kwqIWyqQ3tfOkL+uBK2YUXcELE6fs/n
        PlEfxKi04Gq+jeRLY9jQrbhJTrhymzsVKnae/OZs6Pxg8Yl34fUu1KZi/H1a36aIpqqRDxIpGsT
        ASpvuqvU0j8SYz8u6osLz5zFrizZfVSAA
X-Received: by 2002:a05:6808:2209:b0:3b2:ec6d:edcd with SMTP id bd9-20020a056808220900b003b2ec6dedcdmr13465933oib.3.1700165749560;
        Thu, 16 Nov 2023 12:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX6yQo/D+VJmocu3Rk9YyrtuL+oxTWoQmnTKoNRR4B9T8rzd/CHnRXNN8eDXbWpHwACtresw==
X-Received: by 2002:a05:6808:2209:b0:3b2:ec6d:edcd with SMTP id bd9-20020a056808220900b003b2ec6dedcdmr13465914oib.3.1700165749340;
        Thu, 16 Nov 2023 12:15:49 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b007659935ce64sm65524qkp.71.2023.11.16.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:15:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 0/3] mm/pagemap: A few fixes to the recent PAGEMAP_SCAN
Date:   Thu, 16 Nov 2023 15:15:44 -0500
Message-ID: <20231116201547.536857-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muhammad: I'd rather leave these to you, but since I already started
looking into it, and you didn't yet start replying, let me try to do it.
Please still review if you can catch the train.

This series should fix two known reports from syzbot on the new
PAGEMAP_SCAN ioctl():

https://lore.kernel.org/all/000000000000b0e576060a30ee3b@google.com/
https://lore.kernel.org/all/000000000000773fa7060a31e2cc@google.com/

The 3rd patch is something I found when testing these patches.

Thanks,

Peter Xu (3):
  mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check
  mm/pagemap: Fix wr-protect even if PM_SCAN_WP_MATCHING not set
  mm/selftests: Fix pagemap_ioctl memory map test

 fs/proc/task_mmu.c                         | 26 +++++++++++++++++-----
 tools/testing/selftests/mm/pagemap_ioctl.c |  9 +++++---
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.41.0

