Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986A9803BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjLDRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjLDRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:48:27 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2121AE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:48:33 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a9a51663fso6300116d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701712112; x=1702316912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNBeey8ABhZnSuK97F6c8ME4rtRyAoISrux9SFRA0Dw=;
        b=nbVVNQshSnR8CJZDufoX+mL5eaPGGoNxt9f2zr4TD9Yg9Bd4qbw9CqO0iCsd/qDW0P
         6DE/XAK/q0L22S/P4ChjPVsUkFWK1BL1n2RecqB3EDrHEtss4gkk936Oazt/RV1awhb2
         SrSbK8V8FEKJz3BtpN/J5VN7yyAB9XdcE+WvYI6+7AVHvXM3asD8+ooB6Pfuaj5I8i8p
         JdhmZnyvAIzHvstNgg/NYDaOv23/ETQ3iUq00DHWDOGUCZ685BSfCF3+viWRgJ5PvJyX
         WgezQ5SGAbVXkO+WXj/S9Bky3NIGXkNRo+AeDa9w70yGVszIpIGqSd2MgF9vKwAzLsid
         l25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712112; x=1702316912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNBeey8ABhZnSuK97F6c8ME4rtRyAoISrux9SFRA0Dw=;
        b=wEOP3khIWSQDanLpcTsfDmt0Z+vBvQh3NsImOuz8S7v2rAJ4OvRDdc+aN98frXxlhv
         O/pw7dqxg/qca7k8o6EyWZZwHWGufdEy54Sg4GDTqUaca+QQhE7lQLxUWBUR121AzqwN
         gRrPLV1SgIwfd7iQQjnborP9BOrAW9hLky0Uo85uCR4am5i63YzzGu+7Cg2r0DNXjiBY
         DTHp9B8EbtUfZNnpmpCfqu5Pv6EhpCACyvS/QkXqBDrAg2sC/FbcgsD+XdZbMB84XRPN
         uTbGuKWX1pYtG3TPNMxGXIWOfCdiUpEiKss3mF7JnWSOhvJrPw6YOZk6EAag3LTjjjdD
         Nf+w==
X-Gm-Message-State: AOJu0YzEiIVRphD+NsJJ5KiLwDglY/u9Glp0fcRq0fv9En+PeY7WRgg4
        M2s/8o/8mEn8V8MmmvIxrQsSTnvSoGe5Xk9JHPCm0w==
X-Google-Smtp-Source: AGHT+IGN5RzKQwy4qLpJGVHeE/8kcLv5fHJJCvhuNty5xTZSpSC85BbVZTEshnXKJEMT6JM4Ahk9dA==
X-Received: by 2002:a05:622a:1a1e:b0:423:dbbc:aab7 with SMTP id f30-20020a05622a1a1e00b00423dbbcaab7mr23312621qtb.1.1701712111828;
        Mon, 04 Dec 2023 09:48:31 -0800 (PST)
Received: from m2max.tfbnw.net ([2620:10d:c091:400::5:2355])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05622a610f00b00424059fe96esm3670981qtb.89.2023.12.04.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:48:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: [PATCHSET 0/2] Get rid of import_single_range()
Date:   Mon,  4 Dec 2023 10:47:48 -0700
Message-ID: <20231204174827.1258875-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking at this today, I noticed that the 'iov' argument to this
function is totally dead code. Patch 1 gets rid of it, and with this
function and import_ubuf() now being identical, converts the callers
to just use import_ubuf().

No functional changes here, just a cleanup removing some dead code.

 drivers/block/ublk_drv.c         |  9 ++-------
 drivers/char/random.c            |  6 ++----
 fs/aio.c                         |  2 +-
 include/linux/uio.h              |  2 --
 kernel/trace/trace_events_user.c |  4 +---
 lib/iov_iter.c                   | 13 -------------
 net/ipv4/tcp.c                   | 10 ++++------
 net/socket.c                     |  6 ++----
 security/keys/keyctl.c           |  5 ++---
 9 files changed, 14 insertions(+), 43 deletions(-)

-- 
Jens Axboe


