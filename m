Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C757BA990
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjJES45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjJES4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:56:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E210B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:56:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a4f656f751so19932917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696532211; x=1697137011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eydlxrPJ/pmozsTSySXLkFu7a53QgB4P2BhmOOld44E=;
        b=1MOG0FzWY+B28VfmpmiZ4Kh/e0fbmWDVf/kdCM2HUX5E5+HfYjFV37LBLnaWy/5+No
         UA+YEv2vZhyj1fndNxbx0jp+/nPJJUHfG06a4ok6EPNLTfl1Or8f2gl4maWvZQnAtwxh
         zp0efHFSC1s8doqXfnjyYnDurpqaSql3am9TWsIth22bpnigc5K1qkZVv875Yc1RnLgQ
         pD3ZGob00JamvjDbDR70My+/ShqIN5hjon6qXRqHLK15s2Qk7z9xWo6rw7J90jmHRt2C
         1+NojdXvk4apZ3/8QDd1UBg9Q2uoRsd80kHzHgxplBiPw6NiHomabLDnYV9FG55Wl46w
         SWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696532211; x=1697137011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eydlxrPJ/pmozsTSySXLkFu7a53QgB4P2BhmOOld44E=;
        b=QY4sJW5MP+3E5fXJnCKv1pEaencEV4P/DhbTI8PbU7qCrVc/l04bGAZ9VLqf/VjO0/
         hM30hNyGs2skR6+0CRABa1kstHL7Ml0EGRiLXlWuIRYG4CbiA600dpLZlzFpWHW5IPuH
         d15BfYBktIgiKZEokykzf9dapz3g3g/wgY7HvklqEaeCjPCmFWJTLXdSPHepOUUP5+JB
         zDm4DO9N8Hbjvm8fEKZf1uKYoWPm8Jb+MbJ3BBQe9MyO5P83A4ls5uBNxnSoZ68Sy/Qx
         LvXSPYGWx7gs26jhrm1SrEE06lfHNfujrQvAxR3Votb4pFFsOPqGNDojpyV36BmtV4Ny
         rfWw==
X-Gm-Message-State: AOJu0Yw5HpZqcIJfbU8eI/5Q6hk6lWhsLolhPGfCN2zIfO489hSWJ0/E
        7JV2+I5kqSQpSlo9JZXjSBVzE5bWoZPqqVdxeg==
X-Google-Smtp-Source: AGHT+IGw9j1c4ZqKT+jP44Q5jYqURZViGdjQP9Qdf764azGuPvp2A8S9d3pmyXW8g/SwbG3OQxUJq0useT5bEpN0/A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:770f:0:b0:d35:bf85:5aa0 with SMTP
 id s15-20020a25770f000000b00d35bf855aa0mr99342ybc.4.1696532211122; Thu, 05
 Oct 2023 11:56:51 -0700 (PDT)
Date:   Thu, 05 Oct 2023 18:56:50 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPEGH2UC/5XNSw7CIBSF4a00jL2GhyA6ch+mA0KvLUmF5kKIT
 dO9i92Bw/8MzrexjBQws3u3McIackixhTx1zE8ujghhaM0kl0pwriEXin5ZYaBQkTJELDBkB7O
 LN8UV+EQIHoyyxmqL2kvJ2tlC+AqfA3r2raeQS6L1cKv4rX8TVYAA7YzxWllxueJjTGmc8ezTm /X7vn8B+2ULJ90AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696532210; l=1964;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WEPAms72jIcON0R+TEoyIAOUx88hgLlG4C/IGyOKoeU=; b=Q5u/lRzz9GPrsxR/C/lmVH9+BUcqxH7ZIwWb/XRDHgvWh3MZgzMpWnZf5WZVVLkGT9Swq4rEM
 N4zrwEiBjCXA5MFNEV/hVlnf6tFI0qkjSjJQ8QUtujKRqnDY/z7+iwE
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Subject: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pattern of strncpy with some pointer arithmetic setting fixed-sized
intervals with string literal data is a bit weird so let's use
ethtool_sprintf() as this has more obvious behavior and is less-error
prone.

Nicely, we also get to drop a usage of the now deprecated strncpy() [1].

One might consider this pattern:
|       ethtool_sprintf(&buf, lan9303_mib[u].name);
... but this triggers a -Wformat-security warning.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Changes in v2:
- use ethtool_sprintf (thanks Alexander)
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
---
Note: build-tested only.
---
 drivers/net/dsa/lan9303-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ee67adeb2cdb..95a8e5168c2a 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1007,14 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
 static void lan9303_get_strings(struct dsa_switch *ds, int port,
 				u32 stringset, uint8_t *data)
 {
+	u8 *buf = data;
 	unsigned int u;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&buf, "%s", lan9303_mib[u].name);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>

