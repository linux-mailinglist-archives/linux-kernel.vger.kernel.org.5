Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38587C8D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:42:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24595
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:42:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso4903512a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697222524; x=1697827324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlcetPZENt/KWUqTdKuElmZntlZWvFUuRk0MWi//bA8=;
        b=Z75SW8rJLM6vMUcAeZKpUczPTN/YEMJwR6PDl9Vd/m2Gnq/zhUFFKl5V6yoxPRYXWu
         c0Izk0LlqBNlz7n/SLietSdjUf9vWSTysf5bzKGhdbc67enRaeD+DHU8XzHDbBVod8gk
         p2Qp9JK0Q1bjcWRryaUTXeAvjyO6iip/lcUjv0XBsJMGiiaVPEcu1VxYfqQMR8unYKLX
         q7hHJnAVbYnqzu8SlAlqRnttKr/+msC+btuAcqKwV8VV4/Pu8qRL//UlmvGKPakIZFJj
         gRkJdgavPZJ0WqXcS8CGVe+02lAVjlWxfejwx7BdXB0X87HiLB71Xb4KDaHBwMv4HgB4
         S4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222524; x=1697827324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlcetPZENt/KWUqTdKuElmZntlZWvFUuRk0MWi//bA8=;
        b=hk5CplwXVnCtvkJXfMs+q7cwam+0iM66lyQyuo62eLDMZH7bYeXkzb0PhVE/xaxeFg
         eDfcG7Tis5iOGJ/9ztsrDaLhlyvTvndOES1Ko8gbi0rtXzJZ8bNOau69OD7nlikFl5i6
         LvPjjjf2qguJnLYcAiNUg1KSNRbmiLpW080dwr14iY4x1GndAKuM5MhImAmlsNJeqtiE
         D45sB6M3JXPji08w9QekVbfYMx6MxLPQoNQDQtCd7g2B7XGES05ulWeaYYc1ABMjQ8Jg
         9znSBEJtMsqJcjQuQ9I0zbT0fFyCpn+F6EdFr5RFKwCXCAgf/223xvkw4ShHq6u78AIo
         aq6w==
X-Gm-Message-State: AOJu0YzbWdQqwFP4okzYQtda2CmOIaBydtZeqHKSdHo4OGxVTY1BRqNq
        mDvt9DMQaeH9ugvtxbS2ua8sng==
X-Google-Smtp-Source: AGHT+IENdas/HNvJqTs1sK4tay28wAJbuqwId0DuBDkOut5TKAkUJeoLG3Vf6EFnfe2mQpBp5j/wbA==
X-Received: by 2002:a50:d658:0:b0:533:dcb1:5ab4 with SMTP id c24-20020a50d658000000b00533dcb15ab4mr821984edj.18.1697222523963;
        Fri, 13 Oct 2023 11:42:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id dm9-20020a05640222c900b0053db1ca293asm4173171edb.19.2023.10.13.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:42:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=E9=BB=84=E6=80=9D=E8=81=AA?= <huangsicong@iie.ac.cn>,
        stable@vger.kernel.org
Subject: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
Date:   Fri, 13 Oct 2023 20:41:29 +0200
Message-Id: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle memory allocation failure from nci_skb_alloc() (calling
alloc_skb()) to avoid possible NULL pointer dereference.

Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/nci/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index 0935527d1d12..b68150c971d0 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -151,6 +151,8 @@ static int send_acknowledge(struct nci_spi *nspi, u8 acknowledge)
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);
-- 
2.34.1

