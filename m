Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC37784B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHKA6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjHKA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:58:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF262706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so12933416d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715522; x=1692320322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUOs2rZgGkBFFSdaCrQAmAwIIFAJLWjtOt57qeU+xpk=;
        b=bWO5Ub9RI9saPBfTCrM4APPk2LtmNtuAV6RiDOnMARB61Hxkw/Un9TVs2diTw111yH
         cBn1I0riUBRZp+SFQSxGss1HLm223XhTPPpjhwZabbAqelNpo2c+lX0N3vOzyOzL5k4L
         +9E6U7aFGubdsEUn7iPB4PvlMMQy+cW+R9oNjgjQ/fmQxu/gRu9/LsMJLIemqrZN7Vpu
         vwlN7j8TPj5rw730n0oeP9uMve/D1SsalCy7o/ro79A8gNEB0KeIEAsLu2JKKunpbMvz
         Jy3an6fSEHEO02ndLoudxLJ998yR0/pQARxjog0UmtdjqvJgnmp/VRtpBZIKUrqdU6Y0
         qScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715522; x=1692320322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUOs2rZgGkBFFSdaCrQAmAwIIFAJLWjtOt57qeU+xpk=;
        b=RMpZRFmJxVxjMOfVecNY52O2qv41qpSo+fyHnOwIItWY7TPT0J4AlQO17EV/lVPbDr
         2+xTEUb/4eMm2FHu140ubQ8gGE+MaU1BvcKhgZsgftJekdAV8pC8CkSiifIel2VEzSyj
         jHBs+I9qcheWD7sa+BwiHwCnUVg0NJkH+ToEH0orQlKD0YfZ4Q6uAALLhO8rbwb8wv2c
         6LzgObkEX1iwuWZnSX9AlRln3h9dvdSljcr0UuK9KxzzY1znoTvRXddOTgpQiBTLBRCC
         CHuHafB1XSlsjJiEf0++95Qq06n6sBEPqv8v76TDoaSUSK7XPqo15V1AKKg1xRXebGo0
         PoHA==
X-Gm-Message-State: AOJu0Yzgn1eGCcb/MA1cKlJnt5gmblhbQkL2j46qsFvbNqW5LmgvNlsS
        AErDPkmVHOgwkHqp1teYjUXpcjwixYw=
X-Google-Smtp-Source: AGHT+IFwzePF9Hugza7YLya59EIfvbmLwmBeBw36pmXWWz+kHpGJ1cWfBl7a6dB6gpCs+wBeTvqdrQ==
X-Received: by 2002:a05:6214:492:b0:635:f546:83d0 with SMTP id pt18-20020a056214049200b00635f54683d0mr4384813qvb.11.1691715522210;
        Thu, 10 Aug 2023 17:58:42 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id h14-20020a0cf44e000000b0063d38e52c8fsm871376qvm.18.2023.08.10.17.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:58:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 4/6] bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
Date:   Thu, 10 Aug 2023 17:57:30 -0700
Message-Id: <20230811005732.107718-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811005732.107718-1-yury.norov@gmail.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
Doing that opens room for potential small_const_nbits()
optimization.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0ffafc41cd56..d4560acbe077 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1354,7 +1354,7 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int nbits = pos + BIT(order);
 
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (find_next_bit(bitmap, pos, nbits) < nbits)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, nbits);
 	return 0;
-- 
2.39.2

