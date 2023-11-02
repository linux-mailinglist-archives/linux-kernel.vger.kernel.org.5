Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E017DEAC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbjKBChX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbjKBChV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:37:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468F101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:37:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc53d0030fso4184235ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698892638; x=1699497438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKopUlcYKHiL2msqII7e4sEdoZVJ2JhDrM+KqYar1FE=;
        b=U8OxLhL+B4iZa85OamlTGXnzgLW11pNz/Yz/tzvZ3XIo3Or8RxkoFsEsw/HaeLp3x7
         J8SwHRfNd6M6PznFVmKzAvny8PRCbEWIohZB1dTJpu5mqBCVrycyxY4JX14tgjXKRph2
         BDu8+tG/98vRVPLhuTZhApqAMsO2q2slJY4CDFlrfe+mi/97xWWOAh543KsO6pOtVIYH
         LLcQc79nIq5CTAI0U/KvoKVtPEeMRg1Bs6hH0K2pIKsN0/BQYQJikvGqntxjEwMLCVZP
         fyXxZ4pdIJWZEtgLmqd5XIFrox9dutMqct+4HzCLPLV4xZ6G2G5jVSMNLyIeOZuyK6kx
         iArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698892638; x=1699497438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKopUlcYKHiL2msqII7e4sEdoZVJ2JhDrM+KqYar1FE=;
        b=kDTLb69c4NXbACQy66R7bIZF8yb8SiF+h6sJTMXFKCUO6tqhbX+ePjudRXY//O5HTz
         l573XEZDP6av3CtexIEv5c3MIVJVXoVUhdPEFXif7+NDOXlTWMvM7IXkb2r0nA4JPmYe
         G8e51N6Z+Uprs9CH6zSRDTOkq4f8Oc5ksP9LVPnXTcH4fPjDGrt2DV1E9Ufg6hCUjRNX
         P3wIUkaWvs2rvWVXbfrLO1f4Lgw+FihtL2Z0cX+1w1fdbHHxK1TPQmh7WCk3IbGmqDBm
         mPislbSjWTEepeEulXeyLzG7YMqtSSOMd7Di2fO3WToKhz36KZkrjkSn5sVUnpAKi8M1
         75Yw==
X-Gm-Message-State: AOJu0YyDtGsbbOQ/I24lsvy0t4NYzWU2+VZGJ559hOicAawu5Pcr8/pL
        Wrf173ZBRknGNjTIfQuQZCw=
X-Google-Smtp-Source: AGHT+IH+VAt/djpAXL6Q8OkiwoHBogmGJg+LU1nujx8Hxk5Mx5NdsGSkhcq28WP8pNdlnmjw9zEnLA==
X-Received: by 2002:a17:902:d488:b0:1cc:5f5a:5d3 with SMTP id c8-20020a170902d48800b001cc5f5a05d3mr10834928plg.22.1698892638198;
        Wed, 01 Nov 2023 19:37:18 -0700 (PDT)
Received: from localhost.localdomain (mail.lemote.com. [222.92.8.138])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c14200b001bb892a7a67sm1923156plj.1.2023.11.01.19.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 19:37:17 -0700 (PDT)
From:   huanglllzu@gmail.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, Liangliang Huang <huanglllzu@gmail.com>,
        Liangliang Huang <huangll@lemote.com>
Subject: [PATCH] mm/memblock.c: using judgment statement can reduce loop and enhance readability.
Date:   Thu,  2 Nov 2023 10:37:10 +0800
Message-Id: <20231102023710.13023-1-huanglllzu@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liangliang Huang <huangll@lemote.com>

Signed-off-by: Liangliang Huang <huangll@lemote.com>
---
 mm/memblock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 913b2520a9a0..e48dea7144bb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -655,7 +655,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 			}
 		}
 		/* area below @rend is dealt with, forget about it */
-		base = min(rend, end);
+		if (end < rend) {
+			base = end;
+			break;
+		} else
+			base = rend;
 	}
 
 	/* insert the remaining portion */
-- 
2.25.1

