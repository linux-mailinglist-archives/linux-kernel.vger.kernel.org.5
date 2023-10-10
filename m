Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EBE7C41EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjJJUxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjJJUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:53:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7658F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:53:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a581346c4so1627025276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696971185; x=1697575985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzrS9yyU7Fxl+rEcRC2xGRsO34stFhcBXCNXeuzJc9Q=;
        b=1mksrxoazT1pzlHvN6L+lcXmg/Imy21GLAGQ04+Nx8DKk9suu1RKbM57IqXPm6bJqN
         LeJh1EHuF+9oNubAIcitTqnHQz4UVTNGVLkxkl3eXtEf2vVLShgooYeKnQ/BMeXKvX6a
         REW2ZGlAjncB+7tWENokHQu7IKN50q+8rPl31kj1KnH9HukCB3lYM6P5YysnroTYgNj8
         KbC/F6UmUiNn8VFUPyOTbIUpstD8u2aVOpELXPGODR0UpwLD+vbSGNuO5CXnqMHepTkA
         TUfC3v490losvT/9oeP99f0bZzRcoC0YuzGxeF64lTdwxfgobUVCWEQNUs7zpfxzbpNu
         bMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696971185; x=1697575985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzrS9yyU7Fxl+rEcRC2xGRsO34stFhcBXCNXeuzJc9Q=;
        b=Wqsr1G6TxTbd74G61iEpeo7anvwogBanTFxIP2gLJDrL8fr+h8Z4CR2aW6cQZKl6S2
         EwfL7OKD5CHxSWLpx9Z64LaWcESO0ZLyYuKV3aLTCcTSmsPDXoxOl+hUJUMB0ICOev9w
         AqjZBrIOAScMPmg8l2ifuUv9B5ysL/Gqy7BD77T8FaYO1uS5U9MO4UqXNk3PjZhgEf+v
         42pgmB3Jc2R7K30Va4uGTl0fS9VnZw7WlMuEKss7rEYbCybwT3iRjcltLt0U68giLIyQ
         nk8odeReWehGoOfM3s+N75B2iKm6TguabXpI4vnnFUqPKpdmHzMx0I1zTcVqspi01hRM
         tXxw==
X-Gm-Message-State: AOJu0Yxpp6kzpq0j1XGXC9hQD8sZQQyEP0gf8dFzNe/5txzXivcUyTs3
        zWNVUvtMyBAmyaSHOP3BK6hi2ivLCt9sYVzX+A==
X-Google-Smtp-Source: AGHT+IFEawv3/Q1aVdi1akfbJBKo97xvPPwQmp2OCE1jugDl7DSQ5964VSx1uuZU3vGzMYluwJTj8jYCJu4sipxh6g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP
 id h5-20020a056902008500b00d8656445d12mr360216ybs.4.1696971184847; Tue, 10
 Oct 2023 13:53:04 -0700 (PDT)
Date:   Tue, 10 Oct 2023 20:53:00 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKu5JWUC/x2N0QrCMBAEf6XcswdJqhT8FRGxua09kBguoVRK/
 93Yl2HnZWejAlMUunYbGRYt+klN/KmjOD/TC6zSnIILvXfecamWYv6ymC6wwgmVUWfYf2iqeLO eHQ48RDJHFhmm4MYBchFqx9kw6XpEb/d9/wFd1mpihAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696971183; l=2113;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2n+/99+B9opeglb9JUPmq/bkJEGJQqpMF0ubyjWVGZk=; b=QW1y3WrgWpVSmEbu1+0vOfFFpmr1+pxJv4LGFzx7Dc1VvHcE4fwNoHfwpAzs/aoR0cBHfUaXB
 QqdiMRspgFuCva36ud5TV5Qm1njxFennsGdx1/XqmdCR/al80n4nf9s
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
Subject: [PATCH] i40e: use scnprintf over strncpy+strncat
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Moreover, `strncat` shouldn't really be used either as per
fortify-string.h:
 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * read and write overflows, this is only possible when the sizes
 * of @p and @q are known to the compiler. Prefer building the
 * string with formatting, via scnprintf() or similar.

Instead, use `scnprintf` with "%s%s" format string. This code is now
more readable and robust.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 0e72abd178ae..ec25e4be250f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -438,10 +438,9 @@ int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash)
 		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
 				  + I40E_DDP_PROFILE_NAME_MAX];
 
-		profile_name[sizeof(profile_name) - 1] = 0;
-		strncpy(profile_name, I40E_DDP_PROFILE_PATH,
-			sizeof(profile_name) - 1);
-		strncat(profile_name, flash->data, I40E_DDP_PROFILE_NAME_MAX);
+		scnprintf(profile_name, sizeof(profile_name), "%s%s",
+			  I40E_DDP_PROFILE_PATH, flash->data);
+
 		/* Load DDP recipe. */
 		status = request_firmware(&ddp_config, profile_name,
 					  &netdev->dev);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-dd7f20b7ed5d

Best regards,
--
Justin Stitt <justinstitt@google.com>

