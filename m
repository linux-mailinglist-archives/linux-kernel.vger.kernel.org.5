Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36487A2799
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjIOUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjIOUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:03:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE852120
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c4194f7635so14194225ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808227; x=1695413027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=585ELGKH6mcU0nuyAJeZCpFUeKhNPgDgSqqVI53K3fs=;
        b=H/toPEu6GpGPDI/SfYB5S5T6q6DbHy789mftoN2S2PbUP3xd6W8InOwXbirIVwkF6G
         yCfw8xBQ7fnSb7cof0cLEL+N0EbIjlzlUsN9qAugrhwufHTp8kcdiWKqrM37Jx+ZoXPE
         Vhd4W6fOZd8Hkv3Wr477UVv7501cKTX9XwkjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808227; x=1695413027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=585ELGKH6mcU0nuyAJeZCpFUeKhNPgDgSqqVI53K3fs=;
        b=xC3rvinmzual5FRZntuFuHCZVjyUldOvhRfGKz1W0qJR1F22kMOtCJKM+NoXC7Gd4s
         uOwhPth6Khd8E0xvPAWuH6YcQXFwNWGauohSKNggw+Qg+QfVG00Oq4bOB5pghglh72mX
         EQtQfu51jfO981T6i5iDWI+b9cANPEL3nEuSoFZWXyE4B0dN9YpHVJ9Wwj1fKTDlvpNC
         D3MuOGsMjOc2s7xoucMR6M2B51zk8qxm6lg5BHWUEu3cfFgjvF5r8hozl9IqE0mUMa7s
         sbEU1lSQao5Qwy2DXwJbUz5jt2U5tRgwwq4iLrwK4a99XDcfJlZwz+KJ8mjLVRUR6MYw
         +xqQ==
X-Gm-Message-State: AOJu0YyiwxkmMCu5tf8xKyb/oXFXLVc4NTf5gSLW+qmBuBI7nczIZR6+
        hIyKsDGI+zjoRYaJwpSLSeyLdQ==
X-Google-Smtp-Source: AGHT+IGxirG4c1+wNpjD+C0ivacitJE7me+i97dg7mLg1+2Am2AXQTOZsLaZMKFyejKoHm2lSiLWUg==
X-Received: by 2002:a17:903:2311:b0:1c3:81b7:2385 with SMTP id d17-20020a170903231100b001c381b72385mr4018353plh.11.1694808227690;
        Fri, 15 Sep 2023 13:03:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001bf044dc1a6sm3488624plb.39.2023.09.15.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:03:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm crypt: Annotate struct crypt_config with __counted_by
Date:   Fri, 15 Sep 2023 13:03:45 -0700
Message-Id: <20230915200344.never.272-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2J6fBiPdZIR8mGnEk0bNvAHhXLvKbIZhyM289hn91M0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLihfwsK6T3HOV1j4wnd25zaVLF5WQpYGwyS+
 5kE88zkP0eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4oQAKCRCJcvTf3G3A
 JtSpD/9zzSwBgu0DciTVR5Kuff9eIrmBXAQb1lB9CqCovFopZkSEQY5tNgaZ78xwjchx+SUL0+w
 U596UPQfpyHBDuBCDdrWmn59UUrEv7daZ8bnNYszDjqEEloDL9evqkm1heUI+1NZHp3hBGJMY1I
 EPN/1/SnJZemS9I2Ehsn50giqtGvagxkRx4RTYc43lLCi8lyzkQpyy4aWuunQZ9b/jooQ29YCRu
 0qTTTLUZM2YFI0C6XmnedeWXMaxGCHs/UC/+f2Pa/lnMg3D8cahgzy1Meee+78H4cJCjFKRM8e8
 WfB0QQeYwFx3HGHCcMgtArJ8KYAFzMHtm7MqCvqz8smhDz+Tt6gYqVOgFvC1LUHK9dwlsPEVjg1
 mGDPElivAoJ2+o2BHgDTbzDcWqqQLoENNm2VzQWQfKmprPY/mlLkzPP8x1RWz72qpmm0qWLp/ep
 1Gf+h0kU5Mxb/1lfNNO7kryPvP1ucJ42ibtEOAszDV/9sy4qkmCInNjCBni+HPeRYChSAwjwQV5
 Giq8/cHs+mSSMRPvoBCFcwfHVqQY+zPw8VuhEnjXYnAGtAHiW6nz91S5ysEHuXjmdIZbWNmHbLT
 h55IMoKtjCzJ3T/HKqcJCJ61XbHGSK92I6vRuEyJip7zWe6rUlExh+M8SUVR6nsQ5lM9wIdus/R
 Dbhko43 8ezYT+5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct crypt_config.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..f276e9460feb 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -224,7 +224,7 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
-	u8 key[];
+	u8 key[] __counted_by(key_size);
 };
 
 #define MIN_IOS		64
-- 
2.34.1

