Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EAA780EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378032AbjHRPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378079AbjHRPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307F44BB;
        Fri, 18 Aug 2023 08:12:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so1302209a12.3;
        Fri, 18 Aug 2023 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371549; x=1692976349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/WNaebago/aJqZZVlC3lFxaEfE7d2mg3xgPUu5EqLQ=;
        b=Hcnq/di8BsbBcYaSke+l7b6FwHMPwVJFgYRLEAKgYIcEyDkBRT1VNXOhv0XFcX7mRZ
         RppUIGV9CXMCM6lk36f2jbfxdh5Vclnw+ON+qxvKUNu9ZihNI86AyHN5njcY3wgkjhA9
         8RwvNNf4wqh5YOh5G6FejL6ml4dYgKSirRdBS8imftBECryhECYyoqUWK519IScauSNb
         KgYHAwieGkVPCPxQpJM/ycyJ2+EAKdPu/K4NR0mCPR05b2FRkA4mqH7fLeeuLhoN4S0L
         Zz9bxPT+1IZk2QRZtYb0Su0Ijipk7ZFDSSKrzq5nea4g0VRF8BY7we8WeymTEgNLYF0w
         mP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371549; x=1692976349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/WNaebago/aJqZZVlC3lFxaEfE7d2mg3xgPUu5EqLQ=;
        b=kH1s5YHtVagSaSgPRE6UI47vEQKSv1lzhQ4iQz3YlO9On6kPPnEbMZ0VJ4FhogyLgC
         04R+s+jsCzOaV/3Yqu/nr04hqloXQxpuhp3PY7/905CByKrRKOy727Eg6QECJrilyoyn
         USQbrKgWXKV6doZ8raOBMqql6LB5FivbWN+oz72mjHP+Jj/ZWZ532wdSmuqngOoSK0Ri
         uMFh1Wjv67xBetP47RVS9/kkz5QgErjS3bHRxSM+m54636HvNOu+pbTZHxCm/iJxm8er
         ts8ptS1WaVVsFPDhKxtHWCIPbUFOSUh/+6TB6FEeAjZTcTwyhkOX+s/U2wBHwuV3UF+S
         f8+Q==
X-Gm-Message-State: AOJu0YxE3xJo5TuLXNEtGkBwdg5jCBoY0/8/Lq/dQ/IOdmZiVrb0x+3/
        TXT0SCvO8yvBoZItgTah00NZH2Zdo/FQTQ==
X-Google-Smtp-Source: AGHT+IGFWZElf1DbrvlGXU7UqtZRx9/EpHWXV8o2fqe4FEIPObb7LMccx5zwrREke6ZJS/lmKgcGqg==
X-Received: by 2002:a17:906:d0:b0:965:6075:d100 with SMTP id 16-20020a17090600d000b009656075d100mr2203978eji.39.1692371549310;
        Fri, 18 Aug 2023 08:12:29 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] selinux: simplify avtab slot calculation
Date:   Fri, 18 Aug 2023 17:12:15 +0200
Message-Id: <20230818151220.166215-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
References: <20230818151220.166215-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of dividing by 8 and then performing log2 by hand, use a more
readable calculation.

The behavior of rounddown_pow_of_two() for an input of 0 is undefined,
so handle that case and small values manually to achieve the same
results.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 955cfe495606..1d1ffe085b35 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -298,13 +298,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	u32 nslot = 0;
 
 	if (nrules != 0) {
-		u32 shift = 1;
-		u32 work = nrules >> 3;
-		while (work) {
-			work >>= 1;
-			shift++;
-		}
-		nslot = 1 << shift;
+		nslot = nrules > 3 ? rounddown_pow_of_two(nrules / 2) : 2;
 		if (nslot > MAX_AVTAB_HASH_BUCKETS)
 			nslot = MAX_AVTAB_HASH_BUCKETS;
 
-- 
2.40.1

