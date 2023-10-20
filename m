Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF907D198C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjJTXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:19:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B52D46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:19:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9bc6447193so1689181276.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697843939; x=1698448739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LidG2fExW0rwMYjQ9PdGz9R964tJxbhZmIPXqTMSy5E=;
        b=u6fzuD3rsjn3z3aHoTB50cXFsZlu5skZpJMntd8lw9hv8gL45x3eQgBgP/F7SESm7t
         l80guAEAEXVrdMor2zJpyzSpPzJvtV934Rb/hYMVE0iTBGvI/oZEBrvdMXrZiNvVdg8X
         h/RRshIw1SPsEVUdy1FZ55TC3yL28hMilns9oaPumWwaAKnT7Q91Btg9FB/8MZS6gUIs
         9lsZvrczqbp01lU9PRNXiXrR8LaJXG93NeFRcFGqQfxdeczXjD1TzP1dymspTHzGjW/1
         1pwDHF8OOTA6+Yiml2hLWHkABGCHgJdRqhy/AIdQrIu7X2ZYwJbq/9ZYVuiZY9V3KFcO
         tpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697843939; x=1698448739;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LidG2fExW0rwMYjQ9PdGz9R964tJxbhZmIPXqTMSy5E=;
        b=Dj8B8C3Vfw945WRp9ZeZptTo5cCrG3hDUdDIZzzqN3F+NobZpIgdv/bXOc1IG54aqq
         NP3c8KIJJH/ZGS5MHiwXsiMlxKflEFrpRPQEGYX20Cb69M9or3dRwM+4XEHiAnPXTOV7
         6p/C6iF673LPCifv/TT0r/wOV9sguRXYjqRhYahA4QpBc6X9hcn33y75SWayx+BNmPsH
         pFEHYn2WA/2XRpLKSsR6Z1IV2NHMl7H0ygV7kBF5eQljaiIY9APVm7ParlgIRpYsdmmL
         xnpmcMsipYPJAjfLuqhNspJOFbCt2BH/aDwjBQ7IR0E8d0YqEisuabjcHLYE/ZtSUIMs
         L1hQ==
X-Gm-Message-State: AOJu0YzQ8d28M7/lP9zBb7/cF/ALX+XK3DonIYEAvMRCfuJaxIWn2iVr
        QDlIORguxJ7h6fOA/LTRpf3qfnpNRn5+Ptq1zg==
X-Google-Smtp-Source: AGHT+IGDcYkCzjAktivUcypqglvB0XdzOnw9qjmzTctlQYnD6q8k9McqKaubWwbxDSHcdHHkTO0P+szvTV+TyfJbNw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:868d:0:b0:d9a:3f67:672c with SMTP
 id z13-20020a25868d000000b00d9a3f67672cmr73076ybk.3.1697843939429; Fri, 20
 Oct 2023 16:18:59 -0700 (PDT)
Date:   Fri, 20 Oct 2023 23:18:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOIKM2UC/yWNQQqEMAwAvyI5G6j1pF8RWbQmmoO1JIso4t8te
 hmYy8wFRipk0BYXKO1issUsVVlAWIY4E8qUHbzzdeW8Q/trDOnESWUnNdS02vzxFw0DMlPNgx/ HhhlyJimxHO+i6+/7AZWwx81yAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697843938; l=1846;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=llDPq5cpan48qP/R2KAFEviR6LsPU5tD/kVlkY7ZT6w=; b=gSmFNZVEghVuGZ1QS+hwXLkUsPakqZ2ey8hP3gdAEqKztchsCYGZ3kvhhioAzBjOCIjiQ5ZDr
 dmN+6PRIoUyCYc+q36XkXT3ghMHtL5a7jLdyBrtHBLjb+Xfd7TxspxV
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-rpmsg-rpmsg_ns-c-v1-1-99b16b00c36c@google.com>
Subject: [PATCH] rpmsg: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect chinfo.name to be NUL-terminated based on its use with format
strings:
|       dev_err(&ctrldev->dev, "failed to create %s channel\n", chinfo.name);

Since chinfo is not default initialized, we should NUL-pad the `name`
field so that the behavior is consistent with what strncpy() provides:
|       struct rpmsg_channel_info chinfo;

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/rpmsg/rpmsg_ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index c70ad03ff2e9..bde8c8d433e0 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -50,7 +50,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	/* don't trust the remote processor for null terminating the name */
 	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
 
-	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
+	strscpy_pad(chinfo.name, msg->name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = rpmsg32_to_cpu(rpdev, msg->addr);
 

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231020-strncpy-drivers-rpmsg-rpmsg_ns-c-ffe3fa2bb9ff

Best regards,
--
Justin Stitt <justinstitt@google.com>

