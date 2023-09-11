Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66B79B34D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbjIKWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244447AbjIKUgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:36:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2E1A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so4331803276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694464605; x=1695069405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FnzDM/qQAqed9imlJULqe1YljfAs+NqW+4eAtGoZVY=;
        b=1U5Wpr8Z1ntC5r0NmUbmnav0wxs52+MVc5TiUu57x4su+ZP1jvlrhuTqvBciYvd6it
         CnuOV8RyauMJK03yxAkPrZm9IAn3JfZteLJXyW/fbdgbwCwdiqO2M0dBhdrjmDmVvL9v
         jXMHBZUduNF/b5JC2Oj6Syh12c8FQ9VjvgHk45v+0hyGwSe9i2omChAvIdr2JUQYKu7q
         Kt5s5ytc/4bOrtVIVNlY6j9Ifd+G4jpsRkp8M17opg7P/70hEFvgQK2+xdrqJtLShuEl
         oRXXZ9a9udvlkElMSMqmPtZMBPcMnOj2u+znhj4Oe7GOAU+XPhogk3uCuDtqJ73G3F73
         ou0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694464605; x=1695069405;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FnzDM/qQAqed9imlJULqe1YljfAs+NqW+4eAtGoZVY=;
        b=tlDKwyqAjCYq2Y26+GTXzv2MMiRDFdnPOjMmnuGtIk3xAluC1kqWmdGogcga5NvKhW
         wvsPWrytoOXxnc0SWuxxkxxgHtuKy1WXU40Cch1/cimkHoeAI1Nup44WgNBdtmtHkTPq
         FAFc4e/WRf633pYV0R8BV+tmmX4SAjxQQl3oyVRPFt2dfJTUmY9y968vjX1Kb+EbP3qn
         TqMzW2lt7OdBkOuM3la3rFddyDaVWqcQ8ejfoQjUe4haizG5+FsUlzOl/ekFMjIs8Nlp
         wRDKDj5VzHOlP8S67ZaUBvQeWZYjju2dUg9Ck0v0zwT+nqaEvYmDtz6+USOjWkHykGun
         gTQA==
X-Gm-Message-State: AOJu0Yyp5gN5IoKjD1hlQGxm/w8ht4/E6IIgR25UyEwXe3t0rPvZ1GT8
        JiNQx0/KtejTT2S3wMthJ0AOy6Wp4rmF14TgPA==
X-Google-Smtp-Source: AGHT+IFavwzswLW8yPM+m4Foezkzk+uicGyjzH3OefTfV/uWSx1gYNKGFR6NefIDbvFvpW7kzYGAGZiPqAq40xkDnA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:a28d:0:b0:d78:2690:5a47 with SMTP
 id c13-20020a25a28d000000b00d7826905a47mr230661ybi.7.1694464605062; Mon, 11
 Sep 2023 13:36:45 -0700 (PDT)
Date:   Mon, 11 Sep 2023 20:36:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFt6/2QC/x3MQQqEMAwAwK9Izhtoq1D1K8seNEbNpZZkEUX8u
 8XjXOYCYxU26KsLlHcx2VKB/1RA65AWRpmKIbhQu857tL8myidOKjur4UBZcDNBQmqdH2MTYtd GKEFWnuV48+/vvh8Kurk9bAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694464604; l=1891;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=HNx9V4mK74WpkVhxiiuXehucuUIfIncQWa1keuFMymQ=; b=AO4I7CYDSx3ySiPi/FSRJ83HNqGFyhMdWiNYmP5m9j56lpVc9OLlQ9PlTc/x1Y2aKb0JecpaD
 JdLryhyC6dtArDawSx61qfJu6+mUxUflGPGixf6WDbGpq2P/1WDKP6m
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-acpi-osi-c-v1-1-ca2ec0667b18@google.com>
Subject: [PATCH] ACPI: OSI: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We know `osi->string` is a NUL-terminated string due to its eventual use
in `acpi_install_interface()` and `acpi_remove_interface()` which expect
a `acpi_string` which has been specifically typedef'd as:
|  typedef char *acpi_string;	/* Null terminated ASCII string */

... and which also has other string functions used on it like `strlen`.
Furthermore, padding is not needed in this instance either.

Due to the reasoning above a suitable replacement is `strscpy` [2] since
it guarantees NUL-termination on the destination buffer and doesn't
unnecessarily NUL-pad.

While there is unlikely to be a buffer overread (or other related bug)
in this case, we should still favor a more robust and less ambiguous
interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/acpi/osi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index d4405e1ca9b9..df9328c850bd 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -110,7 +110,7 @@ void __init acpi_osi_setup(char *str)
 			break;
 		} else if (osi->string[0] == '\0') {
 			osi->enable = enable;
-			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
+			strscpy(osi->string, str, OSI_STRING_LENGTH_MAX);
 			break;
 		}
 	}

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-acpi-osi-c-c801b7427987

Best regards,
--
Justin Stitt <justinstitt@google.com>

