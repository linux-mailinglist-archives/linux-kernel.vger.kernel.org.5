Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C003B7EE736
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjKPTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:13:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84918D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:13:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1128919b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162025; x=1700766825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYlw/v9GVrPaC0s5UN9J8tYY4w/hsJ/PA3URh3Q8lJ8=;
        b=VooWjFQEZrJhPPuYBpbhtwGwIQgYGz6kH0inZ+g8mS1ynD+fdwb6NjYBvWs9iWLgRA
         9ik1hqeGW392s0wHuBgzAVv4Xio9IUo+99d0h2n98vq8bpiwCBIJ/zqooC//Mm0N22HC
         L067ds04wmKvRFf/0yGr9nxObGiDNf+s7KhrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162025; x=1700766825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYlw/v9GVrPaC0s5UN9J8tYY4w/hsJ/PA3URh3Q8lJ8=;
        b=VJIWo0ecG6mGgc8cBb6WqzRKOeVbaBkEZ8pwMIgFrL6IrNf6GkkLQ6lbWVECxOAqjT
         vun5wzW5PzomSWHR566e0mwMu0buFvBIA3crFf+VTrHa+nP4/27ZnkWoaurfC/L4zbzx
         OvjXcKR6PqtH1H8QVF2vj2NFyDMIo28A2l16oavRgJuY5T3b6UpgoYoa6LYTbznTQQ5I
         T7HQ5zes0Sj2QV+5bvYFZeoZ2GFKfvgLkBVnf195TFy0iNw1xCk42UTbZ41GLKL/IRU6
         VOxqboBnl4z3zpvSOhAn7g+vjXettd2Z/74OB2Knh3evr/Cbszy0UHcAErvouCz5HbV6
         u6GA==
X-Gm-Message-State: AOJu0YxfjKidu2AsWypE4P3kG5Lxt2rCRsxeTD/J/nHRbZdAELaMFrlv
        WuTzUm4EBDCNgMqjohLp/xsUyNNqzLHiiv0qfNddvA==
X-Google-Smtp-Source: AGHT+IFgcVG7tXCPsOyhSSlGhDJFcKq7oCg9wEnCj3YoT8Jr/uvJFGRO8OknbrQ7So0WvGIkyFeWIQ==
X-Received: by 2002:a05:6a00:4099:b0:6b4:231b:a45c with SMTP id bw25-20020a056a00409900b006b4231ba45cmr21865074pfb.26.1700162024994;
        Thu, 16 Nov 2023 11:13:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000a0b00b0068fb8e18971sm77330pfh.130.2023.11.16.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:13:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] parisc: Replace strlcpy() with strscpy()
Date:   Thu, 16 Nov 2023 11:13:40 -0800
Message-Id: <20231116191336.work.986-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=keescook@chromium.org;
 h=from:subject:message-id; bh=BzD7pn1JfYRhaoY80hkyIKEr+mEu4xES2K8u21WGIyk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmnklqIN5lZaW0f7xYsyH3WQSBx8zE4Qk3JQ/
 qbccTS4bEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZp5AAKCRCJcvTf3G3A
 Jnc2EACuCUkbrGx9lSJGiaQGUafTwnelfTeuI404evq3xhBAjJHJhJCJ+uvTDfi1Pckk2n1LUMD
 QXo8pj48wa+jy9NQ0Q5+RSxyunjEvpbMaTRjmoVF1rlSMM42iCMihT/xBpWAm7LC8Gxr1551HxM
 eJ9I0uEQz+/MdFjBtxRO7YC2HAcwGsvuIrD5hHXD2mm4PbdQ8KdnoGY7iSWBpXd59Dwc+2V3DsC
 GrZTQ7LpjjsfziVRhVi7NmwSKE3FfcSd8fv3prm/DJl3SUAABh7IZFP3JvaSOG6oh3cP5lM2VzV
 2JKNorakX5VGe0Lq9GYpFGY4+XEkLljxIvYXYkgxjnbhM0KtRzB3mySyTAVMiRWOGzh0cJX2+KA
 8648KnwAHCIQKaOiY4wmF9YraK4DvjN8PTn38IXBQHipgJRXnXzbnDV9FybPxIeGdGYWPddV0/t
 SW8RXJ1Hv45wcANMdcpQ0g/6ZefeupFqVhrooMYOtnDIJUPAI0zSTLY44X1g/p5+LDIcT3VRyKz
 tqDDQx4/rU0UKiq1Y7V1vV2XtRJUHOIzJFdrSFaZCR655E2EaMqtHJdA612nQpspQl00NFCnmuH
 lBR2AZwCTYXLXJM2ia3p+h88JWMY+EGFjyBzF9P0yPp/IlqVr1v/sTnCrjdHTArUtOo51sDYTUm
 GjKamcX 6VghP7eg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 29e2750f86a4..e95a977ba5f3 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -383,7 +383,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 	char cpu_name[60], *p;
 
 	/* strip PA path from CPU name to not confuse lscpu */
-	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
+	strscpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
 	p = strrchr(cpu_name, '[');
 	if (p)
 		*(--p) = 0;
-- 
2.34.1

