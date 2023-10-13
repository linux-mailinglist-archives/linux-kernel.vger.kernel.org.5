Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6507C858B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjJMMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjJMMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:20:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A7D6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so23621795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199620; x=1697804420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaxTvrExcsJYfT+rRhpPKDHnyWyB5m+MM5ymcNTcTkc=;
        b=K8VlhwJ5OrBGtFlhwwvctgXD6o9hLGL5s+Z5S9U3PFuyklCK80gaGIr+urxsVJWYbH
         WUfLzSxjJePYfGshrnNYWHnWxLMsYVC/UOH8cwuvCYLtIIXSl7h3O9He8lZBkqyF3k56
         S93d8tqTt6HG9Jqy/GL4Exnscvan9PZNcPgjInegsFlhpl0l0jocZxCHE6xGO+5sqzWL
         nSuT1ZtjSaGfrkMTBQduaoI8yhQE21Av/0EIq0uENu59m1zbSHXhPeJIQOhpCkBOFayF
         lyG/ZtcVCU5lxhSKjU+5ksi0EUbRY1XnBdUzwqd0k8Ag+D6ka7AImenrYnMHY6rQd+u5
         bgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199620; x=1697804420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaxTvrExcsJYfT+rRhpPKDHnyWyB5m+MM5ymcNTcTkc=;
        b=uiAa79++a3g0g36KyvGHa7ggfxS1xl8gNUo+esHu0exNh/Xknc5BFoJ/wsPTnieNZR
         qOc7OusjxDV+skKPnAz52jHQeNbysHzQfE8+rKwaS7JQ/vM75Zh7PvEi8ujCpBNr49Yb
         wpxT12qHYHBz8Dz2k8FUUMjpehw0LhTb0Wb3EckKJqbY/FsbOWFlV3ckFhW2v+32SO7E
         bIcYAGjkRpv30TtUBzXcpi1DGiDBlrem3+jFURxRe++E1gFyRRq6lX1BI+5l93yFjOqM
         GMWl2kBj0/h7EFpDf5/WGbEEEZHLuLr9uwoXGFWRBEEhVGXDWQ3d4ZgIRxNNGdP2gSzG
         fP9w==
X-Gm-Message-State: AOJu0YwRM9sDhTdyXhFxsaHcsORSuAqFddBwIiGlX3nZ1Nw54p85X8iX
        dbnapWM4IwjU0xP9I5WwdRUKHg==
X-Google-Smtp-Source: AGHT+IG8Ma27UizRE7lPhtIw1KXwnZXD3W9qhYX9/vV6AFzUf2064VtOq9WW94oBhJT5obNe1kCj7w==
X-Received: by 2002:a05:600c:c10:b0:407:536d:2e93 with SMTP id fm16-20020a05600c0c1000b00407536d2e93mr9746754wmb.8.1697199619820;
        Fri, 13 Oct 2023 05:20:19 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b0040772934b12sm1806751wms.7.2023.10.13.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:20:19 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4]  misc: fastrpc: fixes for v6.6
Date:   Fri, 13 Oct 2023 13:20:03 +0100
Message-Id: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=564; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=joj5ZcY29jdrBWbjLChNWIZTXbdZ+p/OJQ6RKbc/PE4=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTXviI441xkeZ2cgc/HBeI0wfBpqXcb/4Tkk4 LY9B3hvZzqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk17wAKCRB6of1ZxzRV N/H2CAC28Y/vr0Mu1w5/VOlrqtu4h/Tbiydq7evt+ENoe9CqNzlnzTtdfWdv0iJ+DSrm1+z3mnu EXLDe7yJhs2UfnDC9oE1lMkCGNgXE0ZMMiZ918b/fHCFT2yOiErAeyc5OzK2CnpuAcjwOGMNVr5 gD33PdToYOstAMXr1bV6/sb5TvgB73E+Vdt4v8FULtvno395OyH7IZtLJ3WWY89gVk6kY2wE6+o B0ONbzuKxAhvwWmBsjVv2RgF/vvx2HD8nefA4uKiUi8q525O4uLP5OaeYB2i5IxJ1AIYC27Vyu8 /dY/RKRUXkthIudQ+cWnUW7uon3yzLD54LlJN1YKEtdDbM11
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some fixes in fastrpc driver mostly around cleanup path after
remote invoke.

Can you please apply them for v6.6

thanks,
Srini

Ekansh Gupta (4):
  misc: fastrpc: Reset metadata buffer to avoid incorrect free
  misc: fastrpc: Free DMA handles for RPC calls with no arguments
  misc: fastrpc: Clean buffers on remote invocation failures
  misc: fastrpc: Unmap only if buffer is unmapped from DSP

 drivers/misc/fastrpc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

-- 
2.25.1

