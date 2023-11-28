Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39CE7FBB04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjK1NNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344343AbjK1NNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:13:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FEDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:13:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso1750209f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177203; x=1701782003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4lKo9bLDim6aDctAZZS9tg9Ds7n6sj9Q/UD4Yw1TdY=;
        b=KDspK1lQGnrqXT7YQDub+p8H/owMmhXYQEyfz79Xikk6rbcvJWhbeltXH+tKdkSnWn
         HP2igLRfNEZds7Zc+SI/I4o0nudIf5+5Dwgdg4Z01eGNCJ7IZF4dPw9XRfWgRdCJAPw5
         uK+uOSNgMyzZYit2Mg5rydT/cihk+lwj9Xble6UAtIv7AD3W934KIh29GJhb7sFb3FAB
         LqNnHYxwpdy9TLVDk4K6Ma2VbVfdn+kJsNOvXu6gHsHL4+wI7H4BfQprG1gZN3gToXx6
         um6eSzAkz0PHVhW8qGAq9pfhUz3WgpJq6lotMToCTNhnZzEoo/r0MVE3oTSqoMC92PYD
         t2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177203; x=1701782003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4lKo9bLDim6aDctAZZS9tg9Ds7n6sj9Q/UD4Yw1TdY=;
        b=DH55R4m+s0vpAJwVwmENuOKPPb6UdTc12IfhpV2erUi4DdI9FpQKRv73dEwFmjoGUb
         BmyKJF9UC96bAu3zQRy+xGsBuv+VzlXYQtxihb+4bbkZZkDOaIpG73dM/gOMn55nQUVB
         tfnG2acdUDaArtdb2Njn8E1mn1ZvK13B++bEbM1Um8rrOXQQYjCc8ZAsk/tJ9GDOODxn
         zWhG/mcsDQUMUKNx4F7FNoFe2v04AxNE5d1SoJlDnY7fdfrWyxuMB8ceJny96oNMCzsc
         kP35SS/t3PPfPMNgfZysjrY1e/RdI31WVUmu1O+qNyNwgzuef0qjYIhhxX627Q42hvkP
         teqQ==
X-Gm-Message-State: AOJu0Yx8NO5g2aaws1XjhbTqan7bbrtouTcRTyTEv+g97HURI67blfVG
        A1TFHsjZW62od8u9nMvvziYzKQ==
X-Google-Smtp-Source: AGHT+IG6ZnjMO1TgB7xr2eWRdAiProUe18u2mVdxwlRZXNoDvaF6Btqju7QeacT/L+RNroDhmltb2Q==
X-Received: by 2002:a5d:458b:0:b0:333:73c:7850 with SMTP id p11-20020a5d458b000000b00333073c7850mr3441608wrq.34.1701177202769;
        Tue, 28 Nov 2023 05:13:22 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h15-20020adff18f000000b00332ea526059sm12038283wro.82.2023.11.28.05.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:13:22 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:13:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] octeon_ep: Fix error code in probe()
Message-ID: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code
returns success.

Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 423eec5ff3ad..f2e5c7d80398 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1383,6 +1383,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (max_rx_pktlen < 0) {
 		dev_err(&octep_dev->pdev->dev,
 			"Failed to get max receive packet size; err = %d\n", max_rx_pktlen);
+		err = max_rx_pktlen;
 		goto register_dev_err;
 	}
 	netdev->min_mtu = OCTEP_MIN_MTU;
-- 
2.42.0

