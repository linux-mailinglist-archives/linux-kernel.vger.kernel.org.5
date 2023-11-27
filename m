Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE527F9AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjK0HHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjK0HH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:07:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8B181
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfafe3d46bso16442325ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068851; x=1701673651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWDZyqBJhOVpYqYhwbudR4lRinTiZ1fIB/oQ8fHi3tg=;
        b=kjzYockN9LFJ6sx2k0sGTTv2ytJuV4elNRp7fBYMsUAQ9WMnE/5gs3P+8QSQ9lYcUu
         y0q54OvISdijCRal+GXbTQQM9k8P4lbgU7+Qi6cXrbec2Vy0BhNWcgObBZGenfaBM0pa
         WWfUkV5tBE3ALfJosouIAt6/wP/1T092eOP9/CmWzyHQUYfUK4BkAioZkNr2/Sly8FSm
         umWvG6sqhe0fLBciczQW2wL/PushexwwSJTU843BMvxw4DkiMzx+1G5AQJ7Ugi7Omh7L
         waH/IKc9Ewewq1bLR7U2nQWiX6+COnNYXo+fV/MpRKzFBgi9xpjCIy6jkqqN4dKvlNhK
         KIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068851; x=1701673651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWDZyqBJhOVpYqYhwbudR4lRinTiZ1fIB/oQ8fHi3tg=;
        b=UgwRmO9MlVcS4Vv1SXXAhulinlnsmUk3n+VWxtw4f7GT54oE2wK/96dedB4KyY4AZC
         fqUoAl77RX2zMyno/3IqFvg3iw8dvYSUjKJ01NVzjlytV6WSJnQuS9m9VTubxyfSvF0K
         i3a/RsyHE6ju3GHPQ5y/42hMtADUTk1jdqj7rWrC9ImCw+KbqBVzRCgfRg85vOG4Bl+D
         RVVn2MRfMWge/YJIgIjVvxI4uhW4jBgwykHDOi4J0xv10Bhv6Mg8alV6ugRjqkTbDn2V
         hLW9Ec1yJw4ZMdpim4POqCEvQ+9Vuqx+vxiL/YJfab4iRgrRviVrSHTLJLNWgTa6tJbx
         AuOA==
X-Gm-Message-State: AOJu0Yxqwjw4fyqmORe757pqaw6v5aNdr9/RL/FtKA5eoogCbs/HjtTy
        itDkLQebff+oojDlEubIyM9vsA==
X-Google-Smtp-Source: AGHT+IH+pvi642lKHelJCCdm6Sbw3UusLCtlqBwe0TaqWn+6ozeTKQf9INKnJ4k0xOSABXksoQFmKA==
X-Received: by 2002:a17:902:820b:b0:1cf:cd4e:ca02 with SMTP id x11-20020a170902820b00b001cfcd4eca02mr2699019pln.24.1701068851234;
        Sun, 26 Nov 2023 23:07:31 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:31 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 06/13] crypto: scatterwalk - Add scatterwalk_next() to get the next scatterlist in scatter_walk
Date:   Mon, 27 Nov 2023 15:06:56 +0800
Message-Id: <20231127070703.1697-7-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
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

