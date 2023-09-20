Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513347A74C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjITHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjITHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:47:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BA5CCC;
        Wed, 20 Sep 2023 00:47:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-530e721f077so4467283a12.2;
        Wed, 20 Sep 2023 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695196039; x=1695800839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Khfw26nVwR5SSm/oHTsHGdekypaZLMTQP1+Wqxj59M=;
        b=MZqmRFY9+1cc1zpVsxKovDpKbOIElez6M7HL12hk0HagnwPDHyjFMeLLu8OtCBDB2K
         cedOtaoVE2EO36xqWTler5uQ21c5fdpBrWDGAmbyXU++7qEffA7jj2LIqKkWn9/UOCvQ
         AUkcfkbG8hYUJ5o8xfTbHOSjFyCjmGTBubTnEvgCmhbWwcztDg9599CnXM6ZMffpeVAg
         A/uUpW++cFi5JNKiFAJmXZQuG+qi0eJ+rwZHbeASJ2rVMboFT1WiMNSJe/BfYLyvmp74
         xp7v+oRj2o31jlKD9rhOB20RIgb0/xF5myZnSvf3lcvYtj67U8HojMTLpBYw331o34kk
         g/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196039; x=1695800839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Khfw26nVwR5SSm/oHTsHGdekypaZLMTQP1+Wqxj59M=;
        b=McaKRf5IjyoetQEnCD9jMSeSn/rZVNaLgAZV6Y5NMOWBskiSdiGFO2uSUGQW0ed4tp
         A/T4CNnmV/TBr49zadN/VYeZG8PDjGgZbwTlPmSBe0DvkwOZnXmMgP7HwiMRf4f2QaM1
         UuWT9PdlekuIZ/JAbDLWFlq72h9nWdnYvgfsCU0X9EukVRz5vc44iuovjtPpwQR0RaBf
         jSX6qi7pLVGfOIDmHVoCY0iqW2mb0oQcBJ+bHaaHwuP5+Vi5g68Y/VJ9UN7tWViwBKYe
         OM1leKm3QoZ5So0Cz7HfHqb0FTtTHsGD6E3YtsumwIPVlssHaVOR0xxOvX29UtdZeS8S
         pLfA==
X-Gm-Message-State: AOJu0YxbjUhGQRP+rLP/FsMf6tevlsthZxsUMqQCVl9iKMMNN7/+N9O8
        VVVe0d+CKsxPR+CHzbxtHrpAo+Ql7iyr+giw
X-Google-Smtp-Source: AGHT+IEPJxUtV2nUN0msBQ02+l+gW1F3kkVtyEcpM3CrOHECZQROH/bEt+wczTzlBKHfoeBEpzqwPA==
X-Received: by 2002:aa7:c658:0:b0:51e:1643:5ad0 with SMTP id z24-20020aa7c658000000b0051e16435ad0mr1444419edr.8.1695196039173;
        Wed, 20 Sep 2023 00:47:19 -0700 (PDT)
Received: from emanuele-nb.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id p13-20020a056402074d00b005224d960e66sm8438186edy.96.2023.09.20.00.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:47:18 -0700 (PDT)
From:   Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: [PATCH v2 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Date:   Wed, 20 Sep 2023 09:46:48 +0200
Message-Id: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

A couple of fixes to prevent spurious events when the data buffer is not the expected one.

Emanuele Ghidoli (2):
  Input: ilitek_ts_i2c - avoid wrong input subsystem sync
  Input: ilitek_ts_i2c - add report id message validation

 drivers/input/touchscreen/ilitek_ts_i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.34.1

