Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF87EFE91
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjKRIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E2D6D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bf0bee9f2fso76467966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297461; x=1700902261; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWS1RvxUn5tYPW8mqpxnbvJ8eJ8bpoU4JWTAG3BuVrI=;
        b=VS1K1NVwoDwCQHXnGsows5IZ8Qbemyovl5fiP0Fzpqe0kjHDwQrXhD+B0hwBhisA+g
         amPmPKz5R0/Ql2gYKO2+O2jCxU2X4mDLrcX7SBLKHHlSNbmT157XfsvFygWJTPgqqa66
         l9zuODJof9U5T64aNxgR/tprLdpUeAHl71o50XX0F7ZXX0J+twWVALhnxjU8Fx8la/nb
         CTVLkcNNySfOz9HKRDkU2j6FONMaMZVx+MdNMmMp8k3c/hVxoHaC8Y/ldHxlY84P5cKq
         0YXvwLalx+r4i8k8faFGADgfmFYbqXONoop3/4k/oMFyQtgu7oIe+lho2pmLk2q74zyt
         VdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297461; x=1700902261;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWS1RvxUn5tYPW8mqpxnbvJ8eJ8bpoU4JWTAG3BuVrI=;
        b=FhAmTaUNwXjXinmPg8QYS+xdq6MGeCyYjjHDB7Zdbg6GuNToqMRJpflWQYh4V7jmKY
         bP9CnFHSXcwSOysLs46N+db+jzzL2Tw+4t8U0KyKzg/Qm9GInaXDzPT15W+1dWmZ7Wqq
         SGh4jkgkZhVSpm+HpYvjJiJvrXG/wuD89aH+ZGEGJVXpqzYznxHEGyzhEgmNMN5fel1b
         Wnsi1VRDJc4Tqob8nQySqiSywo3jzckTYUxxL5M+MrTYrJZVisiGIk1A6FJp2u1ckjSR
         HlADJjg7qMPNQDYx08AbQ63HYzqC5xTJPpAj+8kI0McW/nXkJZBQegsvg+bN9nfDQOGM
         gIng==
X-Gm-Message-State: AOJu0Yxq8+yigvbD68qloa99kCpIZCw9bphGN2zs+wuTm84cy4ZWCWnx
        SDPgCg0zAgutOnL1DT2PS842Ygu2zs4=
X-Google-Smtp-Source: AGHT+IFD77xr148bXJVASVtA1veAHUwQiL16mjKcS5L3LcQS2YLCrMT+iH1DxkuzOk4GTEgXUJPX5g==
X-Received: by 2002:a17:906:1da:b0:9cf:7d6e:2c3e with SMTP id 26-20020a17090601da00b009cf7d6e2c3emr1132824ejj.7.1700297460900;
        Sat, 18 Nov 2023 00:51:00 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id qk7-20020a170906d9c700b009e6e82939f9sm1659979ejb.26.2023.11.18.00.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:00 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:50:58 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove constant variable
 channel_plan
Message-ID: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant variable channel_plan to increase readability of the code.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.
Tested on Channels: 1, 2, 10, 13

Philipp Hortmann (10):
  staging: rtl8192e: Remove unused return value of rtl92e_set_channel()
  staging: rtl8192e: Change parameter "ch" of set_chan() to u8
  staging: rtl8192e: Unwind pointer to pointer to rtl92e_set_channel()
  staging: rtl8192e: Remove equation that results in constant for
    chnl_plan
  staging: rtl8192e: Remove constant variable chnl_plan
  staging: rtl8192e: Remove unused variable eeprom_chnl_plan
  staging: rtl8192e: Remove equation to check limits of channel
  staging: rtl8192e: Remove check if channel_array[channel_plan].len !=
    0
  staging: rtl8192e: Remove switch for a constant in
    dot11d_channel_map()
  staging: rtl8192e: Remove constant index from channel_array[]

 drivers/staging/rtl8192e/dot11d.c             | 63 +++----------------
 drivers/staging/rtl8192e/dot11d.h             |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 12 ----
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 12 ++--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 20 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  4 --
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 8 files changed, 21 insertions(+), 96 deletions(-)

-- 
2.42.0

