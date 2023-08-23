Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B1786244
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbjHWVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbjHWVY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:24:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01A10DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:24:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d746edab033so511705276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692825864; x=1693430664;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TbPL2PbuPCNxQGI1y3a6rEWIPbbe+cfcATZZcxOCUGI=;
        b=fUWTLxYKAB6Bnwv5w/j0QG2oEXybU5q5Ucbtd0Pc0FR4pXaoEq7DAfWzn2dIdrYAXE
         oHUiKql/YYEtbgV92PbTYLuISHGgk+wo3F1X/3lGiCbJwWz5liBndZ8Ap1LGyIBKly36
         o14dBwlVyjH3E9AMfXXO0mnHDrkR42VWOcrTVzknk5L5mu9KqHOcWZ5I3Byzacl1iqo0
         aMrJucttH5HBOkDxBU91joNpFesqv1Xwb10gcpsKTPkXpQZQQFjQJ9658g5cfPKfPbbp
         tIQZr/48VbtDyLWbj6HQmtLiE9GuE3VA837nPdyNAT2I+k2R8dxGjUbglCDuSbz23t8w
         h0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825864; x=1693430664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbPL2PbuPCNxQGI1y3a6rEWIPbbe+cfcATZZcxOCUGI=;
        b=SV2XP5WiT+pHqPxli3bjcLlqJeCBUoVOkDk9oKVfoZkkfOslxb0+xFlNxWt8Bawzdx
         KUzoxn8yVLOJ7VzbvXD+Q2jsO4QwlQPIJ/Oam6IE3SzVPWX0e1qD2tdP+6T7i0YOorjz
         OgTQ4IfQu7voaf1MFsvluMmCk7Ka151BzPr57l4oaHUqvSqjx9mxLpQnRX+I9iKVUDBC
         /Y5EdH75scrFAt2jHNiioCyl4TJyxqn7nJP/IXU7k22ymjkD4MM8jF52gytk4B4gtoI5
         lhdig+5cfzdAifyYbeLD5y3bTdQ3C3sMeFFp6rioFkpboo65L5T4a2fTf4ryTyUyUOWo
         ZlDA==
X-Gm-Message-State: AOJu0Yw08lyxBnvs6G2HXODdGypldUbt0rT+hD+vn35Su3FF7d+fB3I8
        1QDezTsBkMktD5qMjXdXlp2WT0K9DG/nBRdKDQ==
X-Google-Smtp-Source: AGHT+IFC5CLGTBE5gLIYORB0WZv4opNFZjYQFqmQYtYhaR0QqqB+q4SWHuhGDXAN76pPJ7CO6CwR446PHw58/B29TQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1786:b0:d77:f943:ed59 with
 SMTP id ca6-20020a056902178600b00d77f943ed59mr8006ybb.4.1692825864222; Wed,
 23 Aug 2023 14:24:24 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:24:22 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAV55mQC/5WNQQqDMBBFryKzboqmDUpXvUdxEcdRh2oSkiAV8
 e6deoMyqzf8/98OiSJTgkexQ6SVE3snoC8F4GTdSIp7YdClvpWN1irl6DBsqps9vlWwMXOWTlK
 49DM7yXeLqgfTIVpT1mRBpkKkgT+n5tUKT5yyj9tpXavf90/BWik5c+/JNkNtDD5H78eZrugXa I/j+AK8rWNO2QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692825863; l=2053;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=F91J7AD4u94TOVQIMBsKGDBwUQP3G+Sm5rhyoHv613I=; b=FVINnwLMtY574yUaHJXvkPLlkHraXeO6bU6OblYeuUDqDh8uov0e/zo0PaXmc+xM6/82pla1A
 v5jU752UOutBfLowpNP1MUrO5HCECSP9Cyx3+7jmXNKlx3erJyHAvK0
X-Mailer: b4 0.12.3
Message-ID: <20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com>
Subject: [PATCH v2] partitions/ibm: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated [1] and we should favor different interfaces.

A suitable replacement is `strtomem_pad` as it is a more robust and less
ambiguous interface. In this case, the destination buffer is not
necessarily NUL-terminated as Heiko points out [2]. Using `strtomem_pad`
over strncpy means it is now more obvious what is expected of the
destination buffer: 1) Not necessarily NUL-terminated and 2) padded with
NUL-bytes

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://lore.kernel.org/all/20230823134936.14378-E-hca@linux.ibm.com/ [2]
Link: https://github.com/KSPP/linux/issues/90
Suggested-by: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- prefer `strtomem_pad` over `strscpy` (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com
---
 block/partitions/ibm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 403756dbd50d..56c076c5523d 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
 		    !strcmp(temp, "LNX1") ||
 		    !strcmp(temp, "CMS1")) {
 			if (!strcmp(temp, "VOL1")) {
-				strncpy(type, label->vol.vollbl, 4);
-				strncpy(name, label->vol.volid, 6);
+				strtomem_pad(type, label->vol.vollbl, 4);
+				strtomem_pad(name, label->vol.volid, 6);
 			} else {
-				strncpy(type, label->lnx.vollbl, 4);
-				strncpy(name, label->lnx.volid, 6);
+				strtomem_pad(type, label->lnx.vollbl, 4);
+				strtomem_pad(name, label->lnx.volid, 6);
 			}
 			EBCASC(type, 4);
 			EBCASC(name, 6);

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-block-partitions-cmdline-ibm-7f5bcca507ea

Best regards,
--
Justin Stitt <justinstitt@google.com>

