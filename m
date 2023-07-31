Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF08768C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjGaGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGaGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:51:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1EE68
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:51:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso2502487a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786260; x=1691391060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=mC5QRm/OQcspRx17nE1QVQ7eQzoVRIIMo0ZjMXBYh64PATE720Mf8XJ8rXqIvfFLkR
         2LI4syFbwNbN3jcI7NiaKf/40LV9wNCg+932ARh2SjF78xXML/cV1/1AFE8rIJZStfLN
         pI45lN2JLif3adnxuMGRbh27pwnUQ17tCgWPEQOH2iMSedLWIXVQgfL76l0Sc6rTk+wF
         1YzoH7+Py5B5A9sXa6bn0hAPXLJh03eF8ZNUpbpoUNvGRILXXKXG2//h2o9Orpp0iOK6
         pnqlh2syhbMbwh/JniZpec3yRVwTInfFfaEAWkyYIO0kZCzRtvYGn9c/QehNX3g8AuRw
         ak0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786260; x=1691391060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=efHAmgqw0/3pMuRcsVo6Y7tp3IuW2bKO+LkoWGiOCaM6l54d/3AWFdnSlZUXHX1gcc
         4MxOioUBTibGM0sHUAFkvJVehB07Nsr2s/QwN0oWr2GaDFrXZ2+pBdvHQN2iLhuadI9N
         yDWPezxd7e6gPZsLnp9UttKjK7YW3bIEdR5hn5+NJo2QTCysT+nUOiK8J9NZ1nWeKIc0
         ALiCyxb6iYce/2wvepTI1ghuadUGcHxp0pILky9nHdVowSgOtAbuaonG0ulmwqy0eESo
         SW8RVTvDSt6e07DGWjjA/bRBDW293Ek4glu/2t76dcLk+dbfOgBQ+YXn7VTllYVJvaga
         eZBw==
X-Gm-Message-State: ABy/qLYjSY/vgDeUSk2mO1ZZTKelBdmG2Mm+fQqjXKBTJmv0YD3GGN5J
        8rnj5n7N4ZlfNff0cVcKMUHcjg==
X-Google-Smtp-Source: APBJJlFdrpNCKYfzENtKiyRWo5aIDz03Mz/wVycOs1V22aagEehO3a/cvCocsez4K9b60wjW3nUvrQ==
X-Received: by 2002:a05:6a20:2451:b0:12e:92c1:b1c8 with SMTP id t17-20020a056a20245100b0012e92c1b1c8mr9719669pzc.47.1690786260594;
        Sun, 30 Jul 2023 23:51:00 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001b8ad8382a4sm7706245plb.216.2023.07.30.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 23:51:00 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v7 2/5] efi: Add EFI_ACCESS_DENIED status code
Date:   Mon, 31 Jul 2023 15:50:37 +0900
Message-Id: <20230731065041.1447-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731065041.1447-1-masahisa.kojima@linaro.org>
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index b8ba9c5adc7a..657f7e203374 100644
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

