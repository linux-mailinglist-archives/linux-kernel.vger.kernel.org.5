Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0B772C46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjHGRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHGRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303FFE67;
        Mon,  7 Aug 2023 10:11:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6162910a12.0;
        Mon, 07 Aug 2023 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PO+ab1xjCHdDkh5lalW/5rufzTS+75sAkJKeFh3jcU=;
        b=MkS2i21E0eUYZCqU8XweZu22TzsncxX4VTS06KQvJSYwH9QRy8661yD5GMaT08UZ1i
         CYlsCjWYpVTk8L1W8elqZn8rKZ0ZlpRgRrpx1BTnKs8UUEepzIF5n5v3L2qC4ztZSNeo
         YD+vCy+k3Lqe1uqXuU1+DFQdsO4qP//RdGAdz69XQfGSvnbIMWH2cMbGJtfha/NaWhia
         ljj8QFK+04+d5JxmwekasLXudLSK0Gcer6pcLgorZd7yS6cy6cAd5oa8GrGuWM/rAoa5
         HkJ7qQ5b3ib156BJ4zf0RanM5hK7BPylzrTBBnfsnjsTXLcen6TzISYubJnBjgAadVyd
         J5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PO+ab1xjCHdDkh5lalW/5rufzTS+75sAkJKeFh3jcU=;
        b=dU/tVbMa4xvq3ZtatWRqJPSPz8aphXHlHwgy/YfOJxsPFDQay8v5xdJZYgJzqamjiy
         tU3hqsROnzGkzaA6jQpYwvKUoCME7rqfdv2zrbjqWxLivYccBVFwJE72zSYlxi86TLVP
         taLGONuKmpqiUXYV1hfIcSmj1gXUTbSCle6DDWHJXCF2Vy86Fe/PbrB39eqTNKjaU9KX
         2ii+98imCH0/PjeafLrk4bJ/77R3W2pchko0wWPgNrgP9cTedDOClNc2pBa1PjcVn6zm
         XMbMrpXLFYaO56W1yaRnaVDkD1ZxTR03LQnBeN+T/PbJZxvTTnk9reutsDKtG06YPyyv
         ej0w==
X-Gm-Message-State: AOJu0Yxq2sDJqDkB4ERE0duiKWC8zkr7Wp8WzSB88ma/+b3Tk6FSmgMY
        viplGpYGGsfcUDmPCAk37ITY7BSvgUl4Sg==
X-Google-Smtp-Source: AGHT+IEdliob4WAXSbPwtXsQkXwtbSZAd8ICwfGML7lwldtSlm8ceEI+EMrFqf9MUPeRb0AE2AaFyA==
X-Received: by 2002:aa7:d745:0:b0:523:100b:462b with SMTP id a5-20020aa7d745000000b00523100b462bmr9455129eds.5.1691428317675;
        Mon, 07 Aug 2023 10:11:57 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] selinux: use unsigned iterator in nlmsgtab code
Date:   Mon,  7 Aug 2023 19:11:41 +0200
Message-Id: <20230807171143.208481-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
References: <20230807171143.208481-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use an unsigned type as loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: use unsigned int instead of u32 since the loop bound is known at
    compile time and small (<100)
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/nlmsgtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2ee7b4ed43ef..8ff670cf1ee5 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -153,7 +153,8 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
 
 static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, size_t tabsize)
 {
-	int i, err = -EINVAL;
+	unsigned int i;
+	int err = -EINVAL;
 
 	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
 		if (nlmsg_type == tab[i].nlmsg_type) {
-- 
2.40.1

