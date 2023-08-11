Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B047778E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHKL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:56:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCE110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf9252eddso270729966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691755009; x=1692359809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SewJHhbNJUJRqc8Gih8YghAXfMGYs1HlqBRDq5rbG0k=;
        b=ldRov8LNEePOEL0UfQUj6A4Nc5GRzvKh4jNbExhqb/rRKDSmJPIhy4lssxB9SBBl9f
         0+Q5n9yQZHYAT8IYGnK7MYpxlEF5QNbret+DLZB5suEUo1kTEan/3viW2h7pJZtwNHHf
         p0+ilp8Rg9yyD6Nuryjm/e5Cj0h8n5zFmCtpPnqSHyljSvJnyHwyk/vmgFo+wpn4z1f/
         AkrUcebMB13D45ebQjjjjuJnPSqKssuszDf5P1k5juSuWKYaq0s15G6YKb8PS5A31YoH
         fqFWmdHwxikppBsdDdPERQGstuKQ54Y7Rh2sBx1iDAR0jp9FGbVLy4RsuKfCtDw4I6lf
         NqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755009; x=1692359809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SewJHhbNJUJRqc8Gih8YghAXfMGYs1HlqBRDq5rbG0k=;
        b=TSqRwbEIOtFBhtY0bUY/jYQPfP84PBdS/O8EW7Kwb8E9LdeOuoGQLYsp2WVBuru/UH
         BZ7xywak1DjEH/tEDtwYezppySq69v1RZo7e8rkVhLLdxSqB2kYkzJrgHZUcjN4CRFm9
         HzcM1xHX1Ry0vDeCN7+OM1uik6mzR1BlH1bxCFCDU9uX/ERWFvSqOSML+v8tr3ZFi18h
         s3jh8PQl1ALS7WlGnQjQYOPsoIHeKpwheopHLefmLyyICnDiVwQ213kSMZ0PmAZZqR+V
         cnJfTO3Ht1MRorSPNDcYprhIkQMG+j8il0hI9RRygy6tJ/IkssCTfe3C/6vYxkhL+Db0
         L1+A==
X-Gm-Message-State: AOJu0YzOHkPtT2+1qSOfv/WnzXhgsDRz8YelthnZaC+jo2bY1l9u4m53
        2Tc5xZmRiIm1SisgXTIJ7AMFkt28VeKf9uWhhHk=
X-Google-Smtp-Source: AGHT+IELcB8B26RntsIpn8EtO6JRJ9cowahkaFC96we82PSZTSQ8zERjhiyWhFYkeFewNh17oo8yAA==
X-Received: by 2002:a17:906:cc0d:b0:997:caf0:9945 with SMTP id ml13-20020a170906cc0d00b00997caf09945mr1373562ejb.12.1691755009045;
        Fri, 11 Aug 2023 04:56:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm2165395ejq.190.2023.08.11.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:56:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] misc: fastrpc: fixes for v6.5
Date:   Fri, 11 Aug 2023 12:56:40 +0100
Message-Id: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some fixes in fastrpc driver mostly around audio process domain
and secure memory allocation.

Can you please apply them for v6.5

thanks,
Srini

Ekansh Gupta (3):
  misc: fastrpc: Fix remote heap allocation request
  misc: fastrpc: Fix incorrect DMA mapping unmap request
  misc: fastrpc: Pass proper scm arguments for static process init

 drivers/misc/fastrpc.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

-- 
2.25.1

