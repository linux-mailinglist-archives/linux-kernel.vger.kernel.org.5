Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0017B5169
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjJBLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:33:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B4D3;
        Mon,  2 Oct 2023 04:33:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503065c4b25so25092547e87.1;
        Mon, 02 Oct 2023 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696246385; x=1696851185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veDUF5kAmIGjrBTZorjxEHNQVjHCsWyYzBTuHCrDAMk=;
        b=Z+rezgSQXl7Egy9yu76MSH66agpP56rt4FCR65yDa/AavimaRusYEouXI1seJ82/0N
         bZSsFADB0GDA63oToZbg0y9AfMHCfI8fyj9hSrcwWwNmJIFV3lGSPcPfDB/ITYtYmL5z
         HdcqpssfqctNCH0vwJKDQtQlG9OnnzgLX87myR0xcGuOVbXvbhSSyGr7V3pIRaF8rR4K
         oBn+ywqVR/kSzEJ5e2qzGiuk2dYRDprP9+8VsDmV0qpn3bB11xCTzUb/dMIlsrEiUH5S
         M36azy3QY9FENd/Yu80Zeop+9OaQqOBmS2t+GOemNU4J4REmcQQOPAn4ZlL4uWu+MJGd
         DpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696246385; x=1696851185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veDUF5kAmIGjrBTZorjxEHNQVjHCsWyYzBTuHCrDAMk=;
        b=AhTxFe5W5gzrFS3kA3SQ6bVgZ0I5rkq/+VSlnOkMXCHZU5YDZIddVXRKkhc2GWt+3A
         RDk8X77kefDe9woTYJJ2juT21w61UKqUeKiQgkFI6/v3K5XznnDfwbaA1eNJC6TdA0hc
         mBDMa8KVCuZtMlaZtYO+Kp4JStDCbsxSSoCj4Po/JR2Tb03v6JzLhBbxfFJqHC/64Lj6
         7fe5DyIyJA96p74vHKancIk4rTq44ZmRZZIvmZkO2QdLCBqHV1/rna+t6TyEukYJ+Ylh
         wVQC5NOLJ06Kie+njdCHcnA40s7XxcnhjIvAMoKqqp4V3KFlqFDoz16JIvdfnPRpF/dB
         kfpA==
X-Gm-Message-State: AOJu0YyXyoo1g3s/bE3cXNzaxOzzdXfV+RCYoa7Ds/5Iv6Dsa3sUPZrL
        5zFamCmMvxC/VlRllOT2bsDW3fIMAGUY6gOpy1k=
X-Google-Smtp-Source: AGHT+IG80++BNCcQ5m3rhyd7IgC5JKUl2jaNPc66dLXl4BQw6bds1+v6MEebOXnIS/x4emyVU0jT6g==
X-Received: by 2002:a05:6512:310f:b0:503:653:5713 with SMTP id n15-20020a056512310f00b0050306535713mr9027047lfb.47.1696246385197;
        Mon, 02 Oct 2023 04:33:05 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id i26-20020ac2523a000000b005041cc98273sm4715055lfl.300.2023.10.02.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:33:04 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v3 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date:   Mon,  2 Oct 2023 14:32:59 +0300
Message-Id: <20231002113301.1531717-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Also, while implementing CQE support for the driver, I faced with a problem 
which I will describe below.
According to the IP block documentation CQE works only with "AMDA-2 only"
mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata' platform data.

So my question is: is it correct to enable v4 mode for all platform data
if 'SDHCI_CAN_64BIT_V4' bit is set in hw?

Because I`m afraid that enabling v4 mode for some platforms could break
them down. On the other hand, if host controller says that it can do v4
(caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
quirk. Anyway - RFC.


v2:
 - Added dwcmshc specific cqe_disable hook to prevent losing
   in-flight cmd when an ioctl is issued and cqe_disable is called;

 - Added processing 128Mb boundary for the host memory data buffer size
   and the data buffer. For implementing this processing an extra
   callback is added to the struct 'sdhci_ops'.

 - Fixed typo.

v3:
 - Fix warning reported by kernel test robot:
	| Reported-by: kernel test robot <lkp@intel.com>
	| Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
	| Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/


Thanks in advance, Sergey.


Sergey Khimich (2):
  mmc: cqhci: Add cqhci_set_tran_desc() callback
  Implement SDHCI CQE support for DesignWare SDHCI.

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/cqhci-core.c       |   5 +
 drivers/mmc/host/cqhci.h            |   4 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 233 +++++++++++++++++++++++++++-
 4 files changed, 241 insertions(+), 2 deletions(-)

-- 
2.30.2

