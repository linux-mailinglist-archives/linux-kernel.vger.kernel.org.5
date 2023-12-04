Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB3804014
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346026AbjLDUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbjLDUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:21 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E502384F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:37 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423c28db22eso49750971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701722135; x=1702326935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyOt6WNJoyGPyyAGB/bMPPXRQGKI15oaDucC2U+fr/M=;
        b=KHFAu1tqEjUF818xvyy2DPCcHiLL60PxQAUJW6qaDAdQ2Q7R96QliiQrEajn5P0MOB
         8mhH03+0zJt0HNlN/FDzTGxHPM2wD4cBVLqyiicYpbM9vqEHpWUSMuGmwzcLdIi6E38p
         hTsh1rzrMSwXqNKLbZZaE6alC4yQPtNNE7GaXeC6ksZucFIZCzc/tvj+N1GhZff7cU2j
         fcSFU7VHFxVKCye85uQ9AkicYxi2APKZ/QB0Q3LdQ75qzJobrHo4HbNvapWYh5JHmnqp
         8zdY0HPOUDZwsYzzdMqele1oy9x5nDawgBlwhaxjEc6WtHP+hRyi5aO+rOU43YMdIOg3
         ZPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722135; x=1702326935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyOt6WNJoyGPyyAGB/bMPPXRQGKI15oaDucC2U+fr/M=;
        b=eOlhdJGDmzbDjmdUeyU8GSNM0z9sCtGesvGFr+r5lZqeQOUOPFzajVYsp1YqylyLG8
         ZsaFwKqdGIeKwJ+hLhYJT15kxLa0RwUJ3gUERA4U/4LKgemTMj+ArEWdCruTKTz68+u9
         iwJKQpGHMN3roOq61F6N/xBCWM3x4oYpwBFgs+E1w0gUhXnwTllAtlnsZdVOFfIikuGS
         d+fXX9yIOFzUTmwaLuubpTGFr/ACFyeHiMutlg/NEN2lQwX88dwP3XcT2mzp59mBaFh1
         TIuVOQiEDE5cfDRceQaWSsRJUdVMuMcfJiWSt0bWZxj8qc0OXk6MolDTggumvJrtZC6y
         VxDA==
X-Gm-Message-State: AOJu0YzX40GN5PkFfWuOYqBflE0o+YbjRNRwAOEyWo35s7KDgzhX+zlX
        T6Nar9T+67abHCp7gPBZESsG8pUFgOJjCamIOHM=
X-Google-Smtp-Source: AGHT+IHQVPJUpnF0jpAxRYOUbhikG4xN8M9TPSoPIYVN8gwSA7y9CB1MpGu7A2cRrqTvvdjC++88Hg==
X-Received: by 2002:a05:6214:519d:b0:67a:5815:9996 with SMTP id kl29-20020a056214519d00b0067a58159996mr217380qvb.6.1701722135213;
        Mon, 04 Dec 2023 12:35:35 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id jo23-20020a056214501700b0067ac930d17asm1123469qvb.141.2023.12.04.12.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:35:34 -0800 (PST)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/2] stm32: fix GPIO level interrupts
Date:   Mon,  4 Dec 2023 15:33:55 -0500
Message-ID: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO level interrupts on the STM32 were behaving like edge interrupts.
The STM32 lacks hardware support for GPIO level interrupts, therefore
the pinctrl driver contains code to emulate them using edge interrupts,
but this was not working.

First, the STM32 EXTI interrupt controller driver lacked support for
retriggering interrupts, and second, the wrong IRQ handler was being
used because the parent interrupt was an edge interrupt.

Ben Wolsieffer (2):
  irqchip/stm32-exti: support retriggering on STM32 MCUs
  pinctrl: stm32: fix GPIO level interrupts

 drivers/irqchip/irq-stm32-exti.c      | 13 +++++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.c |  3 +++
 2 files changed, 16 insertions(+)

-- 
2.42.1

