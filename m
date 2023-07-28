Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4597678D3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjG1XNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjG1XNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:13:08 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E32D7D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:13:07 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3476c902f2aso11086125ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690585986; x=1691190786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kzrIJ251du81UfGiykQe5BbFvGz2DnLNtmPFif5pQc=;
        b=F5JhxuOg0t6nSaWRZ0Qoxa1+19UT+pU1GVEWloFYpPLgkZCMFw4ZFWqg3RGKAtu0Uh
         cZSe6Xpa4gXqg91l3BwK0+IgJSbG4BmM2mXGafIeiZ8jJd64uow6RjqQGErsbTwWQIqz
         1F+PIyRqmrE3J8iEOrwo4f+vKXsYb5DjElYko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690585986; x=1691190786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kzrIJ251du81UfGiykQe5BbFvGz2DnLNtmPFif5pQc=;
        b=Pvo/SzX4c6d4lg15xFprqYRQBxn/mErXH9m0bJWGk2jkH/PLrZzSea3R/yz4O6rbRE
         AjBkdnRFWT0ONKWcclT6Tx3zJTAmvc7KcqdONkoRygUdoKwNuF+JF9p7VDJl41N8m7xj
         PE0pG9a4rp0nHve3x4jRLqN8ufNWSlByfqPfc3p0kWrny/J9LQc8T+bXufS1Tby7e0US
         57pXC2L8zCu//upV/RDklhgoUiJRil1QiDfaNjmYtnJ3UPTY7fZhtlWihJlD5O/BaL4j
         YhUYlxNBm/v/81nvoAkS5B3U559bpJHIhlqmHE6ckkzH8A9lr/gzkM492JSTiUPy4oSa
         VtAQ==
X-Gm-Message-State: ABy/qLZoz9XFoGEK2nvAlg3beCCVoiffHHdWj+qmzgeWAKkzigiIZWGr
        XnsKwI5bRqDBMoSd54gpEnnHXw==
X-Google-Smtp-Source: APBJJlGp+VAU42/jjtVrG/JebIxQW4FqEwxLhz2/RKZYxoJFCuMA+G4uVC0b6L5NeOC00BTpY7H0Rw==
X-Received: by 2002:a05:6e02:1aa4:b0:345:a319:ba83 with SMTP id l4-20020a056e021aa400b00345a319ba83mr1123261ilv.29.1690585986517;
        Fri, 28 Jul 2023 16:13:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001bba373919bsm4082542plh.261.2023.07.28.16.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 16:13:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: ray_cs: Replace 1-element array with flexible array
Date:   Fri, 28 Jul 2023 16:13:02 -0700
Message-Id: <20230728231245.never.309-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=keescook@chromium.org;
 h=from:subject:message-id; bh=D2CtAwl6CXqSqxRaLIFkwjFO+IpDh8k7U4uCnRppIQc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkxEt+LTcBY3bSQZBCTXAzRH9AadW88Qvphq0+C
 YXJpdqK4H2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMRLfgAKCRCJcvTf3G3A
 JnEYEACV0z75qof/EEz1U0UD95mEszMnH2IuR2rQZ74usHlFt6IzIwRFnZ2cM6UL4WJdNADtOKa
 3uhcp9GFb1pJ1QC0ZBpTanzH5aOAUD3Lj/kFBC+sVjJTKwug0ScKCYAdL7wb7mTLePi6FXR68rE
 RTx7NwZ0yc2pSYva8LAIQrtyKgKXNPPuf+egh0Yv121pj0icfN1lcDMYYBsFwwtz4pymN7aaGzH
 5d8JGzbBHfyBRoSdl3FRG9m6c4BrG2IpSZj2i5T4DgHKofDg1K60fyD1h/V8B2Sqhhx05qXpvVN
 krkuxUvUqLtdfznPDrO4Eq9oUsuTVYTlTxfxibcmrfdwsbTwfioD2yeQjRaLRIzPJwc1IXB4Va9
 4jH2wxpEayWDxJH0yunsKc8K6BWflAYl9qNVdse9qcsqk77Ph9d++zPXvbM+45OzuTePPzbLQvo
 gY3IcAh52lnpuuogdAJPXKo/NVZwN/Au21r1AsRHkTDeqMLWoqK01DY/nVFUTi0QnXTI/R3zRet
 qed7hsUR9BxF7ToL2Qv/G6pgAaJwEDpM5xGaBaCW/Qch25fj4niq+cr9r881bRP3siG3G74x2GV
 9YIkpt/vlqsKvs8NLuaeJmZC0AxntJ9bkwc9dwq1W6Tbh3iD/IWdT8/zv7qs2wcDulW3Ro/Cw1u
 demr381 Bj7egpAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trailing array member of struct tx_buf was defined as a 1-element
array, but used as a flexible array. This was resulting in build warnings:

    In function 'fortify_memset_chk',
        inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
        inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
    /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning:
detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
      493 |                         __write_overflow_field(p_size_field, size);
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Replace it with an actual flexible array. Binary difference comparison
shows a single change in output:

│  drivers/net/wireless/legacy/ray_cs.c:883
│       lea    0x1c(%rbp),%r13d
│ -     cmp    $0x7c3,%r13d
│ +     cmp    $0x7c4,%r13d

This is from:

        if (len + TX_HEADER_LENGTH > TX_BUF_SIZE) {

specifically:

 #define TX_BUF_SIZE (2048 - sizeof(struct tx_msg))

This appears to have been originally buggy, so the change is correct.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/legacy/rayctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/legacy/rayctl.h b/drivers/net/wireless/legacy/rayctl.h
index 2b0f332043d7..1f3bde8ac73d 100644
--- a/drivers/net/wireless/legacy/rayctl.h
+++ b/drivers/net/wireless/legacy/rayctl.h
@@ -577,7 +577,7 @@ struct tx_msg {
     struct tib_structure tib;
     struct phy_header phy;
     struct mac_header mac;
-    UCHAR  var[1];
+    UCHAR  var[];
 };
 
 /****** ECF Receive Control Structure (RCS) Area at Shared RAM offset 0x0800  */
-- 
2.34.1

