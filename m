Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8C7E34E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjKGFmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjKGFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:42:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C674119
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:42:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so4995754a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335726; x=1699940526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DgvxotwaTtWteL5tabHmVGGI55WW2NP7qS80NJ0jj8=;
        b=kLXf473pHIUnsqLonPpBOYzD/HkaJd8IBAgLDKb4HgvcFYMEA10Ws0fc6QIJNbUwKQ
         ALAGec/Pvc72Pqc+3PLHjLh7vFv+71MNDTiGmbXqGMvhKbuq3QrkbsdVIhX7SfrqM0qA
         zaBzKuosYatuQ+iBNNFYuRXoZdrLAbAiBmHBtHrpPI32jJaXprVnyb3OYFwpCC6Mgoaa
         iRK9owfgrPv0uE3oyjXT/s/sM6u7RBKBH0LuuIi7y4P28uOzLN160GDgREMdZqco/8dx
         m5FcAjFDKWgdDN3KVfShcHsC0CvJDOiipg1WXoVYb5kXy3/vQAxFkE8Qxxc/T8MCPVcn
         aMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335726; x=1699940526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DgvxotwaTtWteL5tabHmVGGI55WW2NP7qS80NJ0jj8=;
        b=SnQrnZ9PVDKv+KM7FK6gRo7sVE317rYjEDqELCGWJVpx7XdNv0v6A+ucfS1GW79eDk
         G3Uam/i0HOEi0xN5/6xlu04Z6Qer1rJG4joC3n2cDh60z1bWhK1+CYSQoXwVqiDnGNGG
         B1Anthba9zKwiG+7wgBLlXniCZevGn+kBhNvgblxeh8C0g9xzogtZEvyqZw4qoDLTuhY
         MIqhqJWbwvFPSoopNTbj+qH+myTkvnK8ZjXHEs+sd+0qiDRYRRoDtjGbF4rGCA7ijSeD
         vm1WEWBn6mtLJfOT3tjrGJzMRX0XZNAmhnXZPDeuJnMV0JRhjNok3k7brzHOiyb14J/P
         P/Og==
X-Gm-Message-State: AOJu0Yxutlxe/WifsUBZORBvGQh1sLVs9SeVzzvjQ9UGgCrjTwHRpf/I
        NHWh2frBeH2m/c9AteqgLANtkg==
X-Google-Smtp-Source: AGHT+IHZ3idJRm1aXs9l9xP/m9GfU8LEl5Lj5EkDsfn6ACMSyljS0zsakSZkEiN5ZV7gZIgIsSIedA==
X-Received: by 2002:a17:90a:194:b0:27d:5562:7e0b with SMTP id 20-20020a17090a019400b0027d55627e0bmr27688025pjc.7.1699335725847;
        Mon, 06 Nov 2023 21:42:05 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:42:05 -0800 (PST)
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
Subject: [PATCH v10 2/5] efi: Add EFI_ACCESS_DENIED status code
Date:   Tue,  7 Nov 2023 14:40:53 +0900
Message-Id: <20231107054057.1893-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index 08bc00dad66e..3db43957bf19 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -40,6 +40,7 @@ struct screen_info;
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.39.2

