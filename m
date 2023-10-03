Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFE7B648B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjJCIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjJCIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:44:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE9A7;
        Tue,  3 Oct 2023 01:44:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61acd1285so4676975ad.2;
        Tue, 03 Oct 2023 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696322646; x=1696927446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hquSg/aXE1/u0q+geoga44KI7IqOR8LfjmqgUyTNI18=;
        b=jorcgsJsHndmaBwaDIp3k3yTSYDqoe1fQhaSXblOGBuK4bxXqTvrFLqK1CRQB6Occ/
         PLuGiApFSpP2Zgofo9eO7q5H2k2oprrWaGKJuisCQKY4D3VXtXxy4iqXSWbmoA210b1a
         OSO3QifmObtABRGPK+gYtwk2JoEQgBPnRTRJxsxSxgEkeQ5m8CGgjXzplyBdHI8ZYEPB
         mS17nsGlaPKPSyoXXi3CAOX9PYSOHpEKhC2++T1emqgv0kkBo6FVPmXvYPCeSY4JSBb+
         AJy2TIPra3ZCWEorT376zGQEXdIXpanwFjYWTPmWpGDUApxYL5FPlPUVRfzF847AwhSh
         0gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322646; x=1696927446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hquSg/aXE1/u0q+geoga44KI7IqOR8LfjmqgUyTNI18=;
        b=JTrpBFV6Gx5KGSk0vZ6MyRjoGPrzqXfB5nytxNv3f6eiGNWsH9+cfPa0b1kLDFeoI2
         q0DRsb6pZ8U/1GT/xmze5/P9wHVYRvVklxzovXyfJ+yogJKYd0xfpiR5Z2iNRyhgJXxW
         MofKqkuIStx04C/c+jO/8osUObJ6hd0ke6EC55xMmcHqKr1YDQURB289aliWoo3ZHdUU
         nK85miuWbibNrHZt3ObtUhdoaOuf9lxTUlWb3kJWXZyJYHyiDtgFNrKhs6Tx+hczE/rH
         UefSMNIJj8KD+yphTxXkJcBCyRvhUrDFDozDiB1cGGueiY0vTml7FiEy2XwMr6Z2O9X0
         YD4g==
X-Gm-Message-State: AOJu0YyrLB0w09oatI8HUR3eb/Ixt+lKwJ2vR0VdKdUGoonteN/Liny+
        Gqnbdo6Vik7J8U+bIHSdH0jXkxVB1/LJzsbr
X-Google-Smtp-Source: AGHT+IFahaYX8CalAWykz4EmSxSLX/A1YkzBiU22esy/Jzm208wCFO9H+cs8MAxy97khUrV3LOhsmg==
X-Received: by 2002:a17:902:d490:b0:1c0:c640:3f3e with SMTP id c16-20020a170902d49000b001c0c6403f3emr14443148plg.42.1696322645982;
        Tue, 03 Oct 2023 01:44:05 -0700 (PDT)
Received: from ubuntu.. ([113.64.184.44])
        by smtp.googlemail.com with ESMTPSA id y16-20020a17090322d000b001bc445e249asm902876plg.124.2023.10.03.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:44:05 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [RFC PATCH 0/2] seccomp: Split set filter into two steps
Date:   Tue,  3 Oct 2023 08:38:34 +0000
Message-Id: <20231003083836.100706-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patchset introduces two new operations which essentially
splits the SECCOMP_SET_MODE_FILTER process into two steps:
SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.

The SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be pinned to bpffs. This extends the lifetime of the
filter and thus can be reused by different processes.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
The filter is represented by a fd which is either returned
from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Hengqi Chen (2):
  seccomp: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce SECCOMP_ATTACH_FILTER operation

 include/uapi/linux/seccomp.h |   2 +
 kernel/seccomp.c             | 138 ++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 4 deletions(-)

-- 
2.34.1

