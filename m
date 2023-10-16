Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5847CA021
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJPHLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjJPHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:11:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBDDC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bd73395bceso732560b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697440308; x=1698045108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/E6/GLx6ZozVsglJmVw75Y9W/GS8DVZN69OPx54uAk=;
        b=L+g2IeWtoN3jhZVNhuUIdbOznyrDE5yOrsbAhy2yRl9wwAgOn09n8z81MQ5VIATs5v
         TyHh8/EbOcyGaeT74LX4jzwu+MjE4MD7c2shGzhTjrfE5sh9xIXLcBfVpJQd2Xlh6b/f
         Rz4dFUKy3PESCZ0mPZcNsG5xRmN2t4tE+oXP5zIJ/e+HT5vUha4l9wVy7viLyr4QLAhV
         pHkGBb7ShcwQGySSEWsXiX45XhF/SExTZjeeeJ0AAhINAUaSjMvnug7RS5L2n7zxLqxb
         0QXTUfelXHHjiVyb0AGdzWas/t8weeF69sVGoc+3UjdLDoEn9OVZdndOzAU0n9XOkWxl
         rWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440308; x=1698045108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/E6/GLx6ZozVsglJmVw75Y9W/GS8DVZN69OPx54uAk=;
        b=kZL70KhRCSAFDmNAKkGn+hLF6UL+0Zaxlei8NJxRIbyzaqTMfMHm4I3BTl9SigFNXq
         zSLVqkAVXb/sIEX2E5mwUS/Ys5de5xugupZk/OwIVFRmTyMxSBZvzBrkk1RkSjFKMd4y
         Gv257JlpTiBi7gfPpBYcCEuGeV28G02tfFulBBiLrigKDjcnsvSHbmIm7AFosrrCaS0O
         wXNhTLXELIBdlu7ZIrM3PjnYrdxqSl+Y0HdenZx0jxAYeUZgiGt7PlZ9U1k5xIneZ+sq
         5kDuZLTlMedLl//1s7YNEzAkAR861t4dA4tCCsHpErUlhljQHDdoClfjMPLbW2i5eC1u
         5T8Q==
X-Gm-Message-State: AOJu0Yxh5gSnYdlklCV5WK4dc5USr3Ic1m4qMAKCI/Mmflb7aJTPQ6DG
        1RZnyDgGARtuFXbBLltJN1cJPw==
X-Google-Smtp-Source: AGHT+IE4MLkjnBefAElzY+bdBEEt2z+P5us27ZF3QfmSrVEbRNd3DDmAZ96JnRzreQ+qrlXMVJ0vpw==
X-Received: by 2002:a05:6a00:1819:b0:68f:d44c:22f8 with SMTP id y25-20020a056a00181900b0068fd44c22f8mr10614696pfa.1.1697440307784;
        Mon, 16 Oct 2023 00:11:47 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b0069305627491sm17212825pfh.159.2023.10.16.00.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:11:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] xen: irqfd: Use _IOW instead of the internal _IOC() macro
Date:   Mon, 16 Oct 2023 12:41:25 +0530
Message-Id: <599ca6f1b9dd2f0e6247ea37bee3ea6827404b6d.1697439990.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697439990.git.viresh.kumar@linaro.org>
References: <cover.1697439990.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_IOC() an internal helper that we should not use in driver code.  In
particular, we got the data direction wrong here, which breaks a number
of tools, as having "_IOC_NONE" should never be paired with a nonzero
size.

Use _IOW() instead.

Fixes: f8941e6c4c71 ("xen: privcmd: Add support for irqfd")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/268a2031-63b8-4c7d-b1e5-8ab83ca80b4a@app.fastmail.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/xen/privcmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index b143fafce84d..e145bca5105c 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -138,6 +138,6 @@ struct privcmd_irqfd {
 #define IOCTL_PRIVCMD_MMAP_RESOURCE				\
 	_IOC(_IOC_NONE, 'P', 7, sizeof(struct privcmd_mmap_resource))
 #define IOCTL_PRIVCMD_IRQFD					\
-	_IOC(_IOC_NONE, 'P', 8, sizeof(struct privcmd_irqfd))
+	_IOW('P', 8, struct privcmd_irqfd)
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
-- 
2.31.1.272.g89b43f80a514

