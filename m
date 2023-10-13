Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE27C7ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJMHqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJMHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:46:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B88DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9d407bb15so15775595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183188; x=1697787988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBtuwn9njyU4DYsPjYCQyVji9eWIAOyM+cwBNlNvv8w=;
        b=QLtwGKDAkWOclm0IURy53XQ2TQAxZPHlkhtBUN+TSgXbxA9CSXtvP1VGpWpWzeQy0Y
         AddFqjnx3YbXzY4hs0MbQ1FG/D734JMFLdw+3h5sCtf+etyUMH5HbM3FeBgKD/s9FqfQ
         0v7ArgVb+wKrvTgZewDn79SBZiuCQu91j+/wJG29n0rR+dTomT3L2bXPtQl6fb01ZLvT
         e+pBqRSR+DCpVLvBtyKt9rJTVXuJ/cYCikzUlUZJ73uVXOisD392pmYZANABlIC7MLpZ
         i0Wca7k3uR40kJAs4zPWl8W7BiXIlq7qE4gjcY0BNRDvwtWQ16XIBajxRLjIrb7tRy7O
         I1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183188; x=1697787988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBtuwn9njyU4DYsPjYCQyVji9eWIAOyM+cwBNlNvv8w=;
        b=w+id4KbK3I2dIXehkVHB3cUt5Z9BE5uStN3tu49YjS7wRs8/xSyPIxifXY1gtmqUvw
         ySe/O18y5uUugYsQUy6zxjvQvaWGe8UcusdZx0zi4BNtDUZWQztSDmm3nWoJRcV1slNS
         cRbjeP3Rx/QhG7hL83ZYDzOj636S+rKBlNA178jzW2qopX4st+SFqcE9QP8+PF6x2ZGk
         cNm3OztMJ75gXAhe1fv3QxADqMxb3T/z890PZLU5m/gMj9eZf2LIqKr5OpUx5g7oI618
         JY4MdvdBB5eTJApLHAC8UStV+JjiunljmG7nUkIc48XZ4tSvTSdyFSN6ofIS2fVUHKA8
         nz/g==
X-Gm-Message-State: AOJu0Yw53erk4KUxrYDfE4lzf4bCquuYRWGtzhvAvnL29a38gzs5Clkn
        oD2874Y8j3WHePuE9/MvFgw0Hg==
X-Google-Smtp-Source: AGHT+IE1Avla0fhVNFzAxH24XOjPkwxea/S/BSmRGzboh9L1ADBuD7NinRNSPlzdTwyF1m4ZgPgGuw==
X-Received: by 2002:a17:902:a504:b0:1c4:56a7:b632 with SMTP id s4-20020a170902a50400b001c456a7b632mr22763499plq.52.1697183188108;
        Fri, 13 Oct 2023 00:46:28 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001c9ccbb8fdasm3200548plg.260.2023.10.13.00.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:46:27 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org
Subject: [PATCH v9 2/6] efi: Add EFI_ACCESS_DENIED status code
Date:   Fri, 13 Oct 2023 16:45:35 +0900
Message-Id: <20231013074540.8980-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 3ade74795ea9..4776a3dd9a72 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2

