Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608A780ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378053AbjHRPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378087AbjHRPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37794684;
        Fri, 18 Aug 2023 08:12:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52557cc5e7bso1290023a12.0;
        Fri, 18 Aug 2023 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371551; x=1692976351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1jVeMiv4f74U6MfEWdlEgNquQEP8X/dgMx+4n42j1I=;
        b=HTT6/COwSLC02B0rT+envRitn3bOH6mq3vpB6sl/GELyCq5Gh3Z45L7+3Qj3fAUGY7
         CyFUJFP4LGfMsxEtQYiQIsbr40G2Ow7wOR/Uu5tyvVkLrT8WP1UT0Bouz14zC+htz/tj
         z9Wv39YPmeDTLTfTkK09IbPYbZJczy7H2POPGT18iIvzz3Ch64d5v+fYCTyg3tippHtP
         xx9vbGk14NeUZiPkZZ6wICoR7n1eOgsZu8XRfn3HkICUg+esfQdgx2mTy2nDSQ8OmIpR
         0Q85V6xRvARZzJAo7/0YwOnqCF1fpGVpDG7rnyzayT/8dnzZDvwIoO3go4gYCo1Gve4U
         k6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371551; x=1692976351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1jVeMiv4f74U6MfEWdlEgNquQEP8X/dgMx+4n42j1I=;
        b=J2GAEFuwGhbkFRijX5jeGdefVGOcSnr/ZqW7nZKnNUpgRClzZ2G32V5CYkwmR+3Wul
         9HW7+kT97c4UOj0V7UUmdjo/W7M3mQVySrqD3itICFtcKTgRJk/27YQfthJvwj7uWIWk
         gsAXc1jeqnmCYhiiB2Tw6QE+7xwq7mOs1nKkb0KyquTdwxyDUrdBXx2CL+mgjx65cX57
         kd7VVTqZGIuxqSljqhscqbfHyATq0YN0MNTKbKLyTfyEXNF1oEjwy/ZbbWwSUzfV3SHL
         PzzCAhuxLfRjnPizUATG9qvPBmwIgcWzYDRImKGNAUVVKtSNS1YgLebU/M923KQLecar
         3nhA==
X-Gm-Message-State: AOJu0YzWZNaqkouJFjucZU0aZ5947hBvpTmo+gmR5tlyZJHFgL9w2SOv
        0HmzS2wl/jI+nrINcg7FycI7Pmgccckcaw==
X-Google-Smtp-Source: AGHT+IGOgqKFUZ8bOuSHphStUiU1cg9eo/KR2DD/wMgeT/uF+UPvWhaQ/dR3qqBzYA31rQ0gOjtvqg==
X-Received: by 2002:a17:906:5392:b0:992:42d4:a7dc with SMTP id g18-20020a170906539200b0099242d4a7dcmr2388918ejo.21.1692371551279;
        Fri, 18 Aug 2023 08:12:31 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selinux: improve role transition hashing
Date:   Fri, 18 Aug 2023 17:12:16 +0200
Message-Id: <20230818151220.166215-4-cgzones@googlemail.com>
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

The number of buckets is calculated by performing a binary AND against
the mask of the hash table, which is one less than its size (which is a
power of two).  This leads to all top bits being discarded, e.g. with
the Reference Policy on Debian there exists 376 entries, leading to a
size of 512, discarding the top 23 bits.

Use jhash to improve the hash table utilization:

    # current
    roletr:  376 entries and 124/512 buckets used, longest chain length 8, sum of chain length^2 1496

    # patch
    roletr:  376 entries and 266/512 buckets used, longest chain length 4, sum of chain length^2 646

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 932e383bcad6..dd4a9eff61be 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -491,7 +491,7 @@ static u32 role_trans_hash(const void *k)
 {
 	const struct role_trans_key *key = k;
 
-	return key->role + (key->type << 3) + (key->tclass << 5);
+	return jhash_3words(key->role, key->type, (u32)key->tclass << 16 | key->tclass, 0);
 }
 
 static int role_trans_cmp(const void *k1, const void *k2)
-- 
2.40.1

