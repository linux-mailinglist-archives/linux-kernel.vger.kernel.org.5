Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14A7D7364
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjJYShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjJYShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF01BC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ac87af634aso77654a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259036; x=1698863836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWDZyqBJhOVpYqYhwbudR4lRinTiZ1fIB/oQ8fHi3tg=;
        b=mRDDTlxDfVZ4q4JsFyDbCTEDG/QLsx/GfO41ZwHBPW87ceShqpqIoBk8el3SDT0c7b
         Z70hpl8okKOoMgyTscvmy8Q2WsMEW9ovIwGyJjUFn6ag3nIqnu/o6tFYmP6v8vJCWdj1
         nyXYOBcGgGXk5i4qXzrjEdYxAee8jRMTwG0Lvx1BYPeEIEgk9gD4iTHYCdvGQhHqQR9A
         KrLLnbQbbMQ0XV8fY0jUFh7qHRF+kW4DkwfoIB7zHlxUxlWuK51Y1eRpyo6M04CjLvLA
         Fr5VjXUd3tfBiwZOzMW1RS58SCfnCi75cmlZi21VvipOEDTppJLGTklc34sFsGZhg5ME
         wAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259036; x=1698863836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWDZyqBJhOVpYqYhwbudR4lRinTiZ1fIB/oQ8fHi3tg=;
        b=Hv5yCWVzj0Lby/4VWZC0h65WidaGEfkwu+291/beRoeVDsHrO5zFIbTKg4IDDUvKw5
         zqn1Hh6SNj4aAzVnwt7LpIjt+fmo7nTNyXlAsW049y5p8FjIcFx6m9ARfRx7KldQRxUA
         DNHWgLyWzSsu1+W9l7R4ghNBbsDT/AEbRiJ2If3YR/ORR3hK7Y4+IEEuNIQRIPHb55Zh
         nBGKEKBU3tmRxqGTmp+olvntBqcuuIgGeyTLTbGuE40a/8LiCHeYYy0FOC61nJ7SvUtX
         9qeE9BUlAdivQAv7IWnY81/Q401ns5Ty0mVe/5rW7PCPQQ5n33UtDQJ+DToPKqJgJli9
         Vdxw==
X-Gm-Message-State: AOJu0Yw2qocXHSUHa0gXTCIh8xIm3j64LAkzIBBa77HQR/zZS/29yiY9
        2hT4ySOG7D/3sySducbPWGj8FQ==
X-Google-Smtp-Source: AGHT+IFOJxOczYNy9csjaf/jWys3suT6WH12pXc8zs4hoIeoK9YHwvDMemywNi2gacyq+/6UAnDc7Q==
X-Received: by 2002:a17:90b:4a8f:b0:27d:b885:17f2 with SMTP id lp15-20020a17090b4a8f00b0027db88517f2mr12749747pjb.30.1698259035682;
        Wed, 25 Oct 2023 11:37:15 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:15 -0700 (PDT)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ebiggers@kernel.org, ardb@kernel.org,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 05/12] crypto: scatterwalk - Add scatterwalk_next() to get the next scatterlist in scatter_walk
Date:   Thu, 26 Oct 2023 02:36:37 +0800
Message-Id: <20231025183644.8735-6-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situations, we might split the `skcipher_request` into several
segments. When we try to move to next segment, we might use
`scatterwalk_ffwd()` to get the corresponding `scatterlist` iterating from
the head of `scatterlist`.

This helper function could just gather the information in `skcipher_walk`
and move to next `scatterlist` directly.

Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 include/crypto/scatterwalk.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 32fc4473175b..b1a90afe695d 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -98,7 +98,12 @@ void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
 			      unsigned int start, unsigned int nbytes, int out);
 
 struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
-				     struct scatterlist *src,
-				     unsigned int len);
+				     struct scatterlist *src, unsigned int len);
+
+static inline struct scatterlist *scatterwalk_next(struct scatterlist dst[2],
+						   struct scatter_walk *src)
+{
+	return scatterwalk_ffwd(dst, src->sg, src->offset - src->sg->offset);
+}
 
 #endif  /* _CRYPTO_SCATTERWALK_H */
-- 
2.28.0

