Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820E79F3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjIMV1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjIMV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:27:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD511724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb898ab3bso188115b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694640446; x=1695245246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ8fqic/uomWgpsKqJ7x61RUWZmvyUYZyTh0hpMJdiM=;
        b=LsdFju0yd2M783C96YJe2N2eVqo72OAyMq9SeZFW+p65Vdqvg3x74ZiBDevIl+RoG6
         KuWIWY0dNq+tNcCsQIz7qWgMNNNDXQlako1livF9DJIWvVSgXB9uOSRxtQV4dfn9Pzud
         OKNOSvjO4RNxte2DCECG2DQgesAK5ahS3FNMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640446; x=1695245246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ8fqic/uomWgpsKqJ7x61RUWZmvyUYZyTh0hpMJdiM=;
        b=U3YrT9RbSdUoQJ94FBjgf/E8DKVcT+pA62qbw98n8kW2LRVTeN0n2lngQhU4i0cknZ
         1eDMk9UAagRU4++djH1kqWi9EDVQtmKaFiP/AQik9f2L1xHlbTIj1rGp7mfzZCqm3NB1
         yW1rOm0elGkUbAmQw0Hf4QhWHFAgjFEqKzMdDS8T5hXJShwe8i9Vypgzdn/akYD18kaK
         4szcwcJkGHU4DeOl5pe6sgmjEk4uV/YHjAgC8vfUfLSjP9jijBsBUDHeNf+U9hgEFe+Y
         XHivG1eEVDOuEaPcq12C4Big8Yd3bOf9Qy2cUJ3w053+838St9fFKkX4q3eapsgCXaYG
         J36Q==
X-Gm-Message-State: AOJu0YyEzgBrqjyp1DV7pIwCnezI4upr65tjL5Pybtnpf/1TXPt6rorI
        /5ObDYFC94kxHvat6DGi4A4P7A==
X-Google-Smtp-Source: AGHT+IGyI6LR0X+sTt85Dc5hyaU3kiSenLO/6Xn71Ljenu4d72Yi/579Xsvyp40g93KRVbpEbnHMVA==
X-Received: by 2002:a05:6a20:1445:b0:144:5d5b:8e24 with SMTP id a5-20020a056a20144500b001445d5b8e24mr4250764pzi.24.1694640445852;
        Wed, 13 Sep 2023 14:27:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:ae97:c6dc:1d98:494f])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090ad80a00b0025bdc3454c6sm1923976pjv.8.2023.09.13.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:27:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 0/4] platform/x86: intel_scu_ipc: Timeout fixes
Date:   Wed, 13 Sep 2023 14:27:18 -0700
Message-ID: <20230913212723.3055315-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently looked at some crash reports on ChromeOS devices that call
into this intel_scu_ipc driver. They were hitting timeouts, and it
certainly looks possible for those timeouts to be triggering because of
scheduling issues. Once things started going south, the timeouts kept
coming. Maybe that's because the other side got seriously confused? I
don't know.

I added some sleeps to these paths to trigger the timeout behavior to
make sure the code works. Simply sleeping for a long time in busy_loop()
hits the timeout, which could happen if the system is scheduling lots of
other things at the time.

I couldn't really test the last patch because forcing a timeout or
returning immediately wasn't fast enough to trigger the second
transaction to run into the first one being processed.

Changes from v3 (https://lore.kernel.org/r/20230911193937.302552-1-swboyd@chromium.org):
 * Use readx_poll_timeout() to shorten a line

Changes from v2 (https://lore.kernel.org/r/20230906180944.2197111-1-swboyd@chromium.org):
 * Use read_poll_timeout() helper in patch #1 (again)
 * New patch #3 to fix bug pointed out by Andy
 * Consolidate more code into busy check in patch #4

Changes from v1 (https://lore.kernel.org/r/20230831011405.3246849-1-swboyd@chromium.org):
 * Don't use read_poll_timeout() helper in patch 1, just add code
 * Rewrite patch 2 to be simpler
 * Make intel_scu_ipc_busy() return -EBUSY when busy
 * Downgrade dev_err() to dev_dbg() in intel_scu_ipc_busy()

Stephen Boyd (4):
  platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
  platform/x86: intel_scu_ipc: Check status upon timeout in
    ipc_wait_for_interrupt()
  platform/x86: intel_scu_ipc: Don't override scu in
    intel_scu_ipc_dev_simple_command()
  platform/x86: intel_scu_ipc: Fail IPC send if still busy

 drivers/platform/x86/intel_scu_ipc.c | 66 +++++++++++++++++-----------
 1 file changed, 40 insertions(+), 26 deletions(-)

Cc: Prashant Malani <pmalani@chromium.org>

base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
https://chromeos.dev

