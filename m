Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD462771D54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjHGJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHGJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:44:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54195
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:44:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so3849595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691401498; x=1692006298;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkUdmOsdanYJRPaOBW+Sf9SKg08UmbFYSf2hDRsm7Ew=;
        b=J9pgGgRPpqHlck1+0KnoJkG88FkDuJlHW5sLQ9r8MVmOhil5QYz/fhfhzEOSPMI28R
         i3clEExQpgGOf/DVuEkNsFeViQfeNSSiDAllWffOjOFiD0fKk/ClwukylBnoZWKJqt1c
         u+fPX9F0YS+1cchDFZwpBysy8iILSJqaf+Ny8ER/J4XfqYwDb4kyNAfG1UEkY2JubGlD
         KaEtpKiTaavV1zx4Kz2ghyFotC6weGlY1sk6dW3M6dt14JjsnvrMfQlBTN3uxIlDQAIp
         nKru/lUhoHZs6qjO/DR1xJc8AhPyQjioBdo5TDLJv5nka35WsXlFqJsSmkc7TCl7Asm6
         ZyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401498; x=1692006298;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkUdmOsdanYJRPaOBW+Sf9SKg08UmbFYSf2hDRsm7Ew=;
        b=gLqknskazrWYa06jlssfnOlyYw4GTBBAOUB9T18oTbu9r46297Z2MeGXJ+5zujIMZQ
         7FPyMNVA2npKxOSlU8hvScYnPpDRgJoC9Krb6UoiEsOVBa6ixbNwjdo4cZUPlK9gUsqq
         pnqUCSXRCRIv5c5pRpxRA+KHTvaS6y/Ug6TyuZA+7ijFvT0tmui2NDUWfVtJbV0BKgBc
         Cl13FAYVUzmPRIKDR96bdrrUV4MQC4kwJAvV2/pONCiBKOWmCMfyKJ0Y7qMgbLs/Me0A
         PXddjIBoiCSOAVuqnDakx3WDy+TAyHAuR40FeiiYsgfPTBKMVN+pbTz3v956cJeIo3bt
         N9zA==
X-Gm-Message-State: AOJu0YwgTl28Ao8vVtCsBX5dcaZF1Q/hS08i1jnUNY6WtfpS3M2NOsrs
        jAHGihaGPe/LQ2abrO/4Gqqj7kgacAb123mh
X-Google-Smtp-Source: AGHT+IEd7cs63rRKy5qAJS39wV13USrhwp2ni+AteUU85QcEbpUv2VW2KfMRQ3pMCfSHmJu3iWkvgg==
X-Received: by 2002:a17:902:e5c2:b0:1bc:5e50:9345 with SMTP id u2-20020a170902e5c200b001bc5e509345mr3893259plf.50.1691401498021;
        Mon, 07 Aug 2023 02:44:58 -0700 (PDT)
Received: from localhost.localdomain ([1.237.29.215])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001bc445e249asm6424809plb.124.2023.08.07.02.44.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:44:57 -0700 (PDT)
From:   Hyeongtak Ji <hyeongtak.ji@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@gmail.com>,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH] mm/damon: Prevent unnecessary age reset for regions
Date:   Mon,  7 Aug 2023 18:44:35 +0900
Message-Id: <1691401475-3796-1-git-send-email-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON resets the age of each region after applying each scheme,
regardless of whether the scheme has been successfully applied.

This patch adds a simple condition to prevent the age of regions from
being reset when schemes have not been actually applied.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91cff7f2997e..4044fcf18ac1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -908,7 +908,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			quota->charge_addr_from = r->ar.end + 1;
 		}
 	}
-	if (s->action != DAMOS_STAT)
+	if (s->action != DAMOS_STAT && sz_applied > 0)
 		r->age = 0;
 
 update_stat:
-- 
2.7.4

