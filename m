Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D061A7A00DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjINJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjINJwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:52:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F3E3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:52:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso853078a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1694685161; x=1695289961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj/SE6Rvk/e9XkZXnBOI/CaPNirJMgseWJYK31KjjgI=;
        b=ozWtVfe0XYvN1wI7astJBF7VJbiyXWKIbvNDhq2a4UOeOeBAnQrrDoj4dOGQmY8wUz
         3R/xHW4S5DuzoJK+U0Dio7OT4DUqmLWaJWM0KqIPtmopCOi9yb32//qTqQDEexEmrh/S
         9owzCaPFeJPi9XSF5UoXb9r/ErNXkP0Y1WLIITByNtbV1TMe/Se+on+c3BagGdbz0TOQ
         6NXlKyzsz/SUfQrsBbJ/S5FISIZHmunw43tGLSV+ZKurDNHWqfHthlQEweOD2JWvBFYV
         fKYK5zGYkIG+e4ZSJsVMiOpwIWRGbYc0hqVqk204q+LkP86evfjQ63E1cTbIdpKWtOiz
         Qmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685161; x=1695289961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj/SE6Rvk/e9XkZXnBOI/CaPNirJMgseWJYK31KjjgI=;
        b=oMlmRaS5KH+5y4a7fJLyP1QgvrmBIw+IZ6dM4LooSQ/y3vWw+hX98kbBbsLIMVIEwK
         cE91AjTKHDOBgT53PvocZhiFCUwbgsfbrQFZAF4VGdSZ+49m6s2j+wIex4Y3VVBuUr/s
         baItaVyPoNYfRxtmvlgqvIS5mkiSTyrE5If/kxQLCe6PD3C/DXSxv76r5XIJrBqJ3VCm
         kgHgMWymo43dSdvgMIvUO6oMV5IlAIfIbfocGQK75bmYGvKzRW7jmXmIdfABFGZ9iKpI
         u8uyVnvP/ZITF0efF1RDP+MmsTHRyt3AK5RuU2FiXUrsWjrdBxg9H3Bcs/JpzG3bOq7f
         hTow==
X-Gm-Message-State: AOJu0YywOeEdR/I58p33+oOZwqX/xNBEtNiot6K9+ti7ngdx3F/SVmbM
        +UrzxJSkKiZk2KJIl8ra3Ai3chq4jxlgDzxI0kA=
X-Google-Smtp-Source: AGHT+IEC1a+xoynrTyUQgipRBAyqN6fsm479LRqSrkw0S66XqgQeWHLIFCzhhNx7UhDg/cXs/ZrhdQ==
X-Received: by 2002:a17:906:24b:b0:99c:ae35:8cc with SMTP id 11-20020a170906024b00b0099cae3508ccmr4277277ejl.26.1694685160913;
        Thu, 14 Sep 2023 02:52:40 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
        by smtp.googlemail.com with ESMTPSA id i21-20020a170906851500b009894b476310sm760072ejx.163.2023.09.14.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:52:40 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] MAINTAINERS: uDPU: add remaining Methode boards
Date:   Thu, 14 Sep 2023 11:51:58 +0200
Message-ID: <20230914095236.1601639-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914095236.1601639-1-robert.marko@sartura.hr>
References: <20230914095236.1601639-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Methode also has eDPU which is based on uDPU, so add eDPU as well
as the common uDPU DTSI.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c4cf40cbb8..5bec4bcf8386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13875,7 +13875,8 @@ F:	drivers/staging/media/meson/vdec/
 METHODE UDPU SUPPORT
 M:	Robert Marko <robert.marko@sartura.hr>
 S:	Maintained
-F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+F:	arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
+F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.*
 
 MHI BUS
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-- 
2.41.0

