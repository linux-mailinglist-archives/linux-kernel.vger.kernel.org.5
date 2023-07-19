Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199977597A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGSOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGSOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:00:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5F1731;
        Wed, 19 Jul 2023 07:00:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso9790476a12.3;
        Wed, 19 Jul 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689775220; x=1692367220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WG1/1PGr6K8OyLB4Qk19/O0vzUanSieaRPj5jWDmRzU=;
        b=aZ1XbjyGp3iMdlByDdtJzyG5jQRsZA/RCemLZnQ/TN9SRhiWl4HfqViQtyexKdizCP
         9bm+3LVUzeoR4r262DZYJsWoOA1MUD4H7DCgtgRzk2i+wae+FMpj4KhzoaRTLZ26S2bv
         AVMZ1IpSBrJQciLChqQUq2nw9IGBSzcQv0sRXC2ufjI2S5VOzSH/cTrf/XbY23181SvL
         998TPqD79mOMS8Qkii2a1DTF152YgFxzRtNDw3AsDQj+v25H+vRd2Q+IB06VAi41NAly
         Mca9DF1uhQwbsMFNJ1VS0+i+8hX+OoqyPIDya29NDvmjJZZR+0gFZEahe5JJgqmg9H1F
         nYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775220; x=1692367220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WG1/1PGr6K8OyLB4Qk19/O0vzUanSieaRPj5jWDmRzU=;
        b=XAHmZipe0YvdbAYwhOpemO26eT9A8c4t17yzjD3pvGXIhAp29oK7buxsMC0w4R6v03
         nmc4Muuphm9ZlBDEInJciW291cMFmNUjRChinHS9rVmDJpxnJ/u6hV6B72Moo0tyD0MT
         B5SUJWi9Ll3nQ+JsAoxQSWfzTAvydqdQcxWII4n16kNlxI+0m9lRlYimxaboHqbnWVRy
         dtZkMI1/CoWdI3SBP8gsDq2kH5u2tpJepz/IdhZMR8CKVunE2HMgGo7nZl+7wIOvlhkv
         1hhQNbrhfImv4DKPD0CFnQ4KyLQMmF7cht/BVGGsuUiP0s209Bibm/a5SyVPbhDwJqxu
         6Pmg==
X-Gm-Message-State: ABy/qLa3oOhLYd7FlajECK1/mz1gpCHN54QYHZBKrsKlNuJFVPLVOa/2
        Otz2lp+BtlRomvyN1uN2xSgUfkWgzadyAx5r9es=
X-Google-Smtp-Source: APBJJlGTP/KjgS0L66VBgw3uA1Z/vrOSeOwRyd9kuIyK5+jShFWEfdBfCdq/sGQDhvmRHJCflTjHWA==
X-Received: by 2002:aa7:c3d4:0:b0:521:775b:ec8b with SMTP id l20-20020aa7c3d4000000b00521775bec8bmr2401071edr.25.1689775219949;
        Wed, 19 Jul 2023 07:00:19 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-150-003.77.10.pool.telefonica.de. [77.10.150.3])
        by smtp.gmail.com with ESMTPSA id g21-20020aa7c855000000b00521cc4d5a5bsm714521edt.58.2023.07.19.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:00:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tomoyo: add format attributes to functions
Date:   Wed, 19 Jul 2023 16:00:07 +0200
Message-Id: <20230719140007.34570-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format attributes on functions taking format string can help compilers
detect argument type or count mismatches.

Please the compiler when building with W=1:

    security/tomoyo/audit.c: In function ‘tomoyo_init_log’:
    security/tomoyo/audit.c:290:9: error: function ‘tomoyo_init_log’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
      290 |         vsnprintf(buf + pos, len - pos, fmt, args);
          |         ^~~~~~~~~
    security/tomoyo/audit.c: In function ‘tomoyo_write_log2’:
    security/tomoyo/audit.c:376:9: error: function ‘tomoyo_write_log2’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
      376 |         buf = tomoyo_init_log(r, len, fmt, args);
          |         ^~~
    security/tomoyo/common.c: In function ‘tomoyo_addprintf’:
    security/tomoyo/common.c:193:9: error: function ‘tomoyo_addprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
      193 |         vsnprintf(buffer + pos, len - pos - 1, fmt, args);
          |         ^~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/tomoyo/common.c | 1 +
 security/tomoyo/common.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 969d4aa6fd55..57ee70ae50f2 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -184,6 +184,7 @@ static bool tomoyo_manage_by_non_root;
  *
  * Returns nothing.
  */
+__printf(3, 4)
 static void tomoyo_addprintf(char *buffer, int len, const char *fmt, ...)
 {
 	va_list args;
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index a539b2cbb5c4..e669837ed0e3 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -954,7 +954,7 @@ bool tomoyo_str_starts(char **src, const char *find);
 char *tomoyo_encode(const char *str);
 char *tomoyo_encode2(const char *str, int str_len);
 char *tomoyo_init_log(struct tomoyo_request_info *r, int len, const char *fmt,
-		      va_list args);
+		      va_list args) __printf(3, 0);
 char *tomoyo_read_token(struct tomoyo_acl_param *param);
 char *tomoyo_realpath_from_path(const struct path *path);
 char *tomoyo_realpath_nofollow(const char *pathname);
@@ -1067,7 +1067,7 @@ void tomoyo_warn_oom(const char *function);
 void tomoyo_write_log(struct tomoyo_request_info *r, const char *fmt, ...)
 	__printf(2, 3);
 void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
-		       va_list args);
+		       va_list args) __printf(3, 0);
 
 /********** External variable definitions. **********/
 
-- 
2.40.1

