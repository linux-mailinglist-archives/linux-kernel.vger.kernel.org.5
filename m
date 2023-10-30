Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476C7DB8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjJ3L13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3L12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:27:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26004C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:27:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso12433205ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665245; x=1699270045; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpLwYpgaiOlSuMBWmrfdzpIlcQiSL6xgiZ+mhaXVxIA=;
        b=EGFiUzWHa8GnGxAco3r158vXKk2xlxZJH40rEjphXedJFeYf/Dnx4XIbFAQwu6DwX2
         bOlz7OgLv3EVt8HPSf2twJYfz6IQkS95g/ywMX3iwNFYg00PDBKSPd+lExppzJzCAWgm
         oM8Tp4yszW00vvKrJbKHAHyTiESRfdZ3VI8zND0Wlob3qVU+Ck91yJnn0cicgejIqOqD
         zZQBJlq/kUq0zOudd4gNST2cbidqZDZj5FpE6p9o+cjc7JFx6169xQ8euXqFj5PwdCpd
         PRjwwvtZ8t/Drr1a0InftDQmbJ3wxAe4u91SEjzNeh2VlR6L5KvQllXKmxORaEwLfvct
         TzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665245; x=1699270045;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpLwYpgaiOlSuMBWmrfdzpIlcQiSL6xgiZ+mhaXVxIA=;
        b=QYQGZqECMzQOVYdJsjCGfrfDN1Y8IPLEorZ80dLMO70KZtABLLKlaSRQDxHEOCVtKq
         Y7+dJeTJAcH5zWQkfeuSQRnBYfcatWmpDDZ36JCEqJP6eaflYHopuK4nmohcRkMSmRba
         EZO4jL1qQ7cbxZdeKLHRg/1QiWRkI1mjUHuvI2kY1HflqfVJV8pnCrToiTuEqUNe3HSK
         OuE2Xsow8wdgpBnDHKvlZjwVAagQjPW2Z29O9Q0dXVRiIUvxcH0NwtjibaVB0CuMD63a
         qh/jVON78pmhc4Ei8jMN8WDnMIp7pHhpSUFZegk9bOyv/Ok46Z8eJFYMDNB9qkykJcMd
         chCQ==
X-Gm-Message-State: AOJu0YyTexLUwEblIVV6fMSd6PRr89ZM8WNccQ8r6AL+4rcesq7Ysclr
        sRoB4UWNRW/s4cX0x0WFAKq7NRKj5CsLPA==
X-Google-Smtp-Source: AGHT+IGt5t2lTGb8duU7SM/kR6NDs7Fmr5BhaxDy4ENMnnRKHtV3KKadhJF6hAc+dnuYWX2xyKGfWg==
X-Received: by 2002:a17:902:f394:b0:1c9:b2c1:139c with SMTP id f20-20020a170902f39400b001c9b2c1139cmr7778034ple.62.1698665245507;
        Mon, 30 Oct 2023 04:27:25 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902aa4400b001c9cb2fb8d8sm6072099plr.49.2023.10.30.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:27:25 -0700 (PDT)
Date:   Mon, 30 Oct 2023 20:26:41 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     brauner@kernel.org, mcgrof@kernel.org, dhowells@redhat.com,
        nick.alcock@oracle.com, code@siddh.me, ddiss@suse.de,
        linux-kernel@vger.kernel.org
Cc:     ywchoi@casys.kaist.ac.kr
Subject: BUG: unable to handle kernel NULL pointer dereference in
 _find_first_bit
Message-ID: <ZT-S8Q7tyutcvu_q@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems watch_queue_set_size() and post_one_notification() miss
memory barriers, potentially causing a kernel crash in the following
scenario:

CPU0                           CPU1
watch_queue_set_size()         post_one_notification()
-----                          -----
wqueue->notes_bitmap;
wqueue->nr_notes = nr_notes;
                               // In find_first_bit()
                               // In _find_first_bit()
                               for (idx = 0;
                                    idx * BITS_PER_LONG < wqueue->nr_notes;
                                    idx++) {
                                   wqueue->notes_bitmap[idx];
                               }

In the above scenario, it seems that nothing prevents reordering of
accesses to wqueue->notes_bitmap and wqueue->nr_notes in both
functions.

Our research prototype found the following issue, which seems to be
due to the above scenario.

BUG: kernel NULL pointer dereference, address: 0000000000000000
<...>
 _find_first_bit+0x18d/0x1a0 lib/find_bit.c:101
 find_first_bit include/linux/find.h:208 [inline]
 post_one_notification+0x197/0xbd0 kernel/watch_queue.c:115
 __post_watch_notification+0x5ac/0x1080 kernel/watch_queue.c:225
 post_watch_notification include/linux/watch_queue.h:108 [inline]
 notify_key security/keys/internal.h:197 [inline]
 __key_update security/keys/key.c:775 [inline]
 __key_create_or_update+0xec0/0xfb0 security/keys/key.c:968
 key_create_or_update+0x3e/0x50 security/keys/key.c:1011
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x2f3/0x3f0 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x50/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd


Please note that this issue is found by a research prototype which
significantly transforms a kernel binary. So, I can't guarantee that
the issue is not a false positive, although I tried my best to
analyze and understand the issue.


Best regards,
Dae R. Jeong
