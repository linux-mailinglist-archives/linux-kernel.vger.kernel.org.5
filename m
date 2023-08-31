Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1778E437
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbjHaBOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbjHaBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:14:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B9CCDA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf078d5f33so2110385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693444447; x=1694049247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sUp2yimFnL41Syp4fRWiGYEjv3jeQXhshgUbuWCXiU=;
        b=hPACS1F46EEGmI5xV/eAzlwhcd0oqu4f2lRwcNaQFh+coaZwfqmW8GgiS1PZh7mStQ
         0+VN4FJiTSzPNrXVoqu+HJ6oXwxRcAoaZpJnfRFnq7I38x5gSrkosj4zxj5Kc9PYcUTt
         QBe5jbbp9Lco/lBkZqGm3UdplyoxN36YCPp/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693444447; x=1694049247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sUp2yimFnL41Syp4fRWiGYEjv3jeQXhshgUbuWCXiU=;
        b=j3IUA43nBU6rAympiCg1ldt1sGgir2/VNY3TrvBjcAtqw4w+xlgKwmVNHUtRmPDfOK
         MomDeQnFZOIM4Xl0SKIKM2oJpFavltQMUW0+PUBLICL5pdzF8+ZI4kyGR04fYQrFO1Va
         FDo4i595gdmoEb7gb07BSLxJMVg5ciYtnBuP2A8wv3AZzE+Q7yiF6V/ibhtSDGRdBwZH
         hJCS3kosu6yTFT5V8WkjyZwy2Fw/GSa4KbS7ldmaa3/qBS7nzFcIpMN0iyYK8kTr+gux
         Lgr08w+2T2RcecH/+82iR4l+mqmvNUQS1I20aJS63fl62sVxsVc5IlgS4w0YGkd5YzDo
         BiBQ==
X-Gm-Message-State: AOJu0YzKroezj8wDsJunJaCX0YhUoQoaevJSYT1BXDK1Z/bbzoJkXp43
        P8w0NyZV39IQ39oq7wr1pvuX1Q==
X-Google-Smtp-Source: AGHT+IEsaxAUmzOWP3YLPRyIonJDP5ynhSyj/X3KF7NV/5+fcbROj48eTEq1IrBDZ7PjIKflMZop6Q==
X-Received: by 2002:a17:902:ea94:b0:1bc:2188:ef88 with SMTP id x20-20020a170902ea9400b001bc2188ef88mr3832312plb.3.1693444447266;
        Wed, 30 Aug 2023 18:14:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:248f:d364:b451:2bc0])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001bbb7af4963sm132604plb.68.2023.08.30.18.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 18:14:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 0/3] platform/x86: intel_scu_ipc: Timeout fixes
Date:   Wed, 30 Aug 2023 18:14:00 -0700
Message-ID: <20230831011405.3246849-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently looked at some crash reports on ChromeOS devices that call
into this intel_scu_ipc driver. They were hitting timeouts, and it
certainly looks possible for those timeouts to be triggering because of
scheduling issues. Once things started going south, the timeouts kept
coming. Maybe that's because the other side got seriously confused? I
don't know. I'll poke at it some more by injecting timeouts on the
kernel side.

The first two patches are only lightly tested (normal functions keep
working), while the third one is purely speculation. I was going to make
the interrupt delay for a long time to see if I could hit the timeout.

Stephen Boyd (3):
  platform/x86: intel_scu_ipc: Check status after timeouts in
    busy_loop()
  platform/x86: intel_scu_ipc: Check status upon timeout in
    ipc_wait_for_interrupt()
  platform/x86: intel_scu_ipc: Fail IPC send if still busy

 drivers/platform/x86/intel_scu_ipc.c | 59 ++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 17 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
https://chromeos.dev

