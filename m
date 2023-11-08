Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E17E534E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjKHK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjKHK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778D1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so11158098a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699439278; x=1700044078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+f7Qsv7fU9oe3DrF6r+pW1sCOQYzyprdQzjLRQbosbo=;
        b=SNj91xffe2RKtapnO5qopKkcTxabs6cK0MAeIyhHbkGBTIgdCbJCsRpUB1QFoBUjgA
         Qe+PoqZt3wCsxl3gqY+KkvSME14rltwchzbVzgyy71GFv5b5Ttb+61EmuRWmj4oD1RQR
         ZpLy1ofjvwN+Xl5gdytgv+6Zz8KJH5SdY7amxUYdRwn+KA1pEVm3niQMnf7h3cT4rP54
         Gc5VZZlaF0bYtd9rAM5ne9p/Z3dpAa0q5KPqM21DKEKzdt3XaMYYWkhihdbRPzas2DZI
         BrGocXtmceHHQUIYvghkxf+Q9xrRIvWmjicnARKcfoHqvPXZdNmA8RxNyQQUIekMsseE
         hokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439278; x=1700044078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f7Qsv7fU9oe3DrF6r+pW1sCOQYzyprdQzjLRQbosbo=;
        b=vobGSyoMs71fY1W9CsU3wfN9cfgjyrWKb7jGzfsjmXxUq50srSKvmfs+FP2vOXQjN9
         B3X0ansJwonsXFjCA02cFAuFagvp5yIi8vhSdHk0jeR0LeJwz8N5blPtd3iSOXy56lJw
         r0VtgVNk/3Wj4+DVWUUhzBoS84NSuSXpdclj8B3LMMEyI8XenUs7bAfiN3L17pJFJole
         PSfeRTf8y4UVYr57CVjyv8dsiRdwOmCZ0s4qqPF1AVAvdwEFXJmWiG04WlvUXzuJuq5d
         FoyrV5nbPIBXx/CAAM3mkumzz/jR3KnKR8QybvU8mCBfE556d2VPQtRE851JNBLPmCre
         l41w==
X-Gm-Message-State: AOJu0YxsGjVD1+ZI5QQCE06ojk2JBlxIKK4jR5DqYUsnrVGK6po0pnc7
        JQU1CcuQ8SKZo9arngfaeas+AnpX9MQz7uRyavI=
X-Google-Smtp-Source: AGHT+IEJDcJ5DMeJ6rqOFRUpLWIRMmKTodGNk0u7GQPsbTjlldvOkBaWs1tA9NcQYobH/aJCzR3gCg==
X-Received: by 2002:a17:907:7f0d:b0:9e0:2319:16f0 with SMTP id qf13-20020a1709077f0d00b009e0231916f0mr1226295ejc.65.1699439278292;
        Wed, 08 Nov 2023 02:27:58 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id bn22-20020a170906c0d600b009c3827134e5sm803257ejb.117.2023.11.08.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:27:57 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 0/2] OP-TEE kernel private shared memory optimizations
Date:   Wed,  8 Nov 2023 11:27:53 +0100
Message-Id: <20231108102755.93079-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set optimizes OP-TEE driver private shared memory allocated as
dynamic shared memory (not from the static shared memory pool). The first
patch handles kernel private RPC allocatations larger than one page and the
second changes from alloc_pages_exact() instead of alloc_pages() for more
efficient memory usage.

v1->v2:
* Split into two patches as requested

Jens Wiklander (2):
  optee: add page list to kernel private shared memory
  optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 59 +++++++++++++++++++++++++------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++---------------
 2 files changed, 61 insertions(+), 43 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.34.1

