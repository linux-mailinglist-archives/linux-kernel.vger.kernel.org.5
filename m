Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE257C75FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbjJLSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347421AbjJLSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:35:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2813E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:35:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso1781701276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697135742; x=1697740542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZ5vZeZ1rQtj/pLLfjwP55zNf2pNIW6kvAeBQT1x4bU=;
        b=DSZHXL9gw45hmfv+Snb7H4L6njWd/lhK8QsZGUxgaJzK/+K1VwiW30ehjEpi6SnpBQ
         9y8ORbiypnX1Fn+DDilQf3mM35qgPXSo1htW9agMVupQ+92UDvisv5XSIQlI6xzDQxTa
         ZtaSe9MHYfARRmh1WjATl/L+HYNO7GWdoUey4JDXB+aQpW5fjeLNZPo0mfeRAfKmzZs7
         DsJ1iWc/+GwKoJr5VAS6sutmqYGQBpm+fSQ1WTCkbWGxFaCmUdKM/w8OEaduRF8mVfZX
         4c1jMKvuqh9NNHxU52MdZ1MeI6y7XK3m65lp+Yt5cd5iJGHrm4/ILb6k23hLxl5pylmz
         H6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697135742; x=1697740542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZ5vZeZ1rQtj/pLLfjwP55zNf2pNIW6kvAeBQT1x4bU=;
        b=eFfjFhCnoLqDwUuXICLi8vWfgh3T41VLd67PgWDEJ1X3g+R+GaLs3on0rtGavIWRYx
         TJxjFHy9x4FdaCsBLaaC+5V2S3bz2FerdsY1IWo8YLeVHmZmvJsEo4kC9J6yDhlgF4Km
         Tiwp8OvKKwuV9TxCHGoJN4l+yuR4hq/XaBEGW2FmKCHm+TnbmTGkdV8FIgIwPXNsgkb8
         pxLZRIeNpXkg95jpXCoaQ5H8aCz6xWkHw9tNrl9uUQB3eVAIQQO0NfM0W138zGgQQieU
         qrXLipokglk217hegIXwN1A/Gt888VMj02IDtL3bmmhIXrFeXd2orY57cUkN4z7ufFxG
         85XA==
X-Gm-Message-State: AOJu0Yy+aKvg7PLaIuH9fxOnIDfAhhgU3bQLDa5t90NQU10of0wsRVm2
        xlw0ic8E6aEZN8AZ+fvPB13OhSbG0ynWBhqSBQ==
X-Google-Smtp-Source: AGHT+IGAvRFiDoAAgv8+76QvrcJUTBz0asmElUscHpthtBCbO3PwIS4e92bgGQ5whYpEiOcgN0o4K9DW6LvVSd/RiQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abab:0:b0:d9a:bd7c:189 with SMTP
 id v40-20020a25abab000000b00d9abd7c0189mr67389ybi.4.1697135742183; Thu, 12
 Oct 2023 11:35:42 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:35:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHw8KGUC/6WOQQrCMBREryJZ+yU/tkJdeQ8pUpNv+qEmbRKDp
 fTupr2Ci4F5s5iZRUQKTFFcD4sIlDmydwXU8SB03zlLwKawUFKdUSJCTMHpcQYTOFOI4CgBpZ7
 CZqbBW9Ywkdn0MPT8WNCgEE3dVEoiVaI0j4Fe/N1X723hnmPyYd5PZNzS//YyAsJF6kZ3ytRVp 27WezvQSfu3aNd1/QFDxYYM9wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697135741; l=2878;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=aHFOyb2iG6fjzUFXJXI6La24xrPjq56KO9Plhvehm8c=; b=xCNDPvyU646zkhkhjsYRp1o2dlZlirYKKLW2wM2NGn7p1AsuRwNCYh05miZknve/xyJY39trx
 zLMNz9yaUKrAXx+fMPPolFn7b4FFi31Smw2iDKzM8nzzSdf16DUBlA2
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
Subject: [PATCH v2] qed: replace uses of strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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

This patch eliminates three uses of strncpy():

Firstly, `dest` is expected to be NUL-terminated which is evident by the
manual setting of a NUL-byte at size - 1. For this use specifically,
strscpy() is a viable replacement due to the fact that it guarantees
NUL-termination on the destination buffer.

The next two cases should simply be memcpy() as the size of the src
string is always 3 and the destination string just wants the first 3
bytes changed.

To be clear, there are no buffer overread bugs in the current code as
the sizes and offsets are carefully managed such that buffers are
NUL-terminated. However, with these changes, the code is now more robust
and less ambiguous (and hopefully easier to read).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- prefer memcpy to snprintf (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v1-1-60c9ca2d54a2@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index cdcead614e9f..f67be4b8ad43 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -3204,8 +3204,8 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
 		     BIT(big_ram->is_256b_bit_offset[dev_data->chip_id]) ? 256
 									 : 128;
 
-	strncpy(type_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
-	strncpy(mem_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
+	memcpy(type_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
+	memcpy(mem_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
 
 	/* Dump memory header */
 	offset += qed_grc_dump_mem_hdr(p_hwfn,
@@ -6359,8 +6359,7 @@ static void qed_read_str_from_buf(void *buf, u32 *offset, u32 size, char *dest)
 {
 	const char *source_str = &((const char *)buf)[*offset];
 
-	strncpy(dest, source_str, size);
-	dest[size - 1] = '\0';
+	strscpy(dest, source_str, size);
 	*offset += size;
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-211d594201e4

Best regards,
--
Justin Stitt <justinstitt@google.com>

