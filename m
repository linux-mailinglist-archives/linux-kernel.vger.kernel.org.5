Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7780D01E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjLKPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:55:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0FB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:55:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cdea2f5918so2420440b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702310106; x=1702914906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvzZ6GPm6FBKY13t74SyXbkcqS52Q/SYf3epLnEDjq0=;
        b=Qs2Cyvbhd8pBWtIpsB66s0oQ4ecSQblZaYTVn/2XfAq9bil6VZRaNhx5i3EqsgCJ4r
         uordSDSB/P+RFtm0KOgKbfQPkJtcMmXWVANjOQNeNlBUvSKGkWyzGzsrBgu5lUMkhK2r
         Xh8mZjCX+B4MzfqlZ+G6ZQeQUOlHWoplubY4ktiOiYaCACO4VlInon+272omJoy/nQUL
         w57QjiMa+QOCIgPF9muvw80j99Q291UJCLkqoeePt4H3zoEydEjQJnisS1NV7YZyBK46
         O8TBj8jd9NOYOp67YGRGNHmJIeG2keP7gNPXe0bElKU6NJ7PPCSbIW95jhWgRx4qNt53
         StdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310106; x=1702914906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvzZ6GPm6FBKY13t74SyXbkcqS52Q/SYf3epLnEDjq0=;
        b=u7zP8SGoZ1C1kh+dFKCfgsxPrkHYgS1SE6x10xbg/e+lpbJjhDawe2wV40xIQ2Li3W
         vHNcd8qRo9agRGrCZqlMacAGeRisAwxGMLjpRN1dEm1wF3x5YXzVK/QcVpPiJV3GqS54
         DJnv49nvxTSvdErGt4Z95PFrm/1CX9S8sHZdXHe7KoP683YbrjSPsdHca9HTNAQjmbu1
         KCkNZzKb6kGI2kitGXqxEWQPRPLXqSycpoPTNfIsKMCR4zKCeRrh8xr0QScfYALll4iU
         wsGgStQPKQ/D1yvEGDxzIWfN2aJU6O7guI88DX6dii6/OoMcaXEceBBz2Dr7/VcxpxAe
         KiGA==
X-Gm-Message-State: AOJu0YxVNFZwj164135qSx/M3IKGn7DAh4NXMm1pyUpU6x2xuU0jJgfG
        GRpsS3RTtlS8pJfIETgwbQooM0u7mU4ob1cb
X-Google-Smtp-Source: AGHT+IEv5Jn3dltTrGp5+G1vApnJxPRoM3hLU6VPEwFnlcyynK+8IbpQ1xP6Yefp+y7/AartPzpX+g==
X-Received: by 2002:a05:6a00:98e:b0:6ce:6185:44e1 with SMTP id u14-20020a056a00098e00b006ce618544e1mr1849376pfg.66.1702310105961;
        Mon, 11 Dec 2023 07:55:05 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b006cdd00f91fdsm193168pfn.185.2023.12.11.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:55:05 -0800 (PST)
From:   Piro Yang <piroyangg@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Piro Yang <piroyangg@gmail.com>, linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging:vme_user:fix the issue of using the wrong error code
Date:   Mon, 11 Dec 2023 23:54:53 +0800
Message-Id: <20231211155453.105409-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. the error code of ENOSYS indicates Invalid system call number,
   but there is not system call

2. unified the logging error message, when slave_set func is NULL

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 drivers/staging/vme_user/vme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..e9461a7a7ab8 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -340,8 +340,8 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_set) {
-		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		dev_err(bridge->parent, "%s not supported\n", __func__);
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.25.1

