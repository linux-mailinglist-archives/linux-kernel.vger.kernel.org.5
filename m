Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7F7C00EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjJJP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjJJP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:59:32 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D15C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:59:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c63588b554so3957977a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696953569; x=1697558369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Av9vrNBattNw+30gbnF49RgNFJElqwcfnE+Y8ALKtNU=;
        b=tyTnUjzUXkoTDabypL6Vmrvdt3APEQTv589f/K8UN4okPW+iiznTzzYHewMNKF+b+C
         vNrS20uqumXnWz4rNix1ZAIP2x2msJGeZK3v8Qh/FJ5/inqjQ36tuEYGlOIRCL7lpUYf
         n4B0U9QvvckGC4FpAR3yKQin7gL0SwQUzdW/JB3StH5QW4oLQvwxObqKWkKtAXuNKYsP
         VriflfLbUwel7rIJvI82NsGRiShBkEpH2dGGIAglGfJSfgb922F1KUOL/JtGfAXq+bmX
         BYStxTkb3QnuH8DpkHsfoYxr9bz10ypYTugPB3v7m1AIE75evAjYWQ4xBVXM70CVV6XO
         rm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953569; x=1697558369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Av9vrNBattNw+30gbnF49RgNFJElqwcfnE+Y8ALKtNU=;
        b=HsHfh6Xeja5Nbi2o9fagVMTqz8C8b6nln9V9Di9CsX+br5VvR05H20eViJ/kaaRJ5j
         uYLvY0uGWQgJtFqk52BSdHgoP0vSb3PDNq+oEyzMQJXtr1dsPgHk0fZUL7yQxgRUbV+/
         5Ro+nqQWFLnN3SF5eibf3OSMtr6vdSsaV6bh+5AK7fxH2hJ1k8EFDiMWeI/mWybksW8r
         jHi3ZRsKv9u6fVsmyxgw9jdEXcYYk/oyDjX6/YfjsrXO88X6SZLKA5un4yg03ljLa+A6
         NysDxsmQ1S/lnGrnempUdGfqeGe9iPICdnCID7+OzTDzIxHsUteeDtKm7cll1KlVw0IG
         w/HA==
X-Gm-Message-State: AOJu0YwztMP3hodzb/A8Vny5ufl191+kROZn1AgaUotaWhATKfObXNm0
        3iPn4/buGYtlNQSAaxBw8/MYGOSiqQCVaF3h7A==
X-Google-Smtp-Source: AGHT+IFkjPrgqxC2sO9tb7GFo/gxS/EJyf+37LvD+BQzNwDAPFoIFw9a1dGFeQ+f1j5dO4/j4mkyBw==
X-Received: by 2002:a05:6830:606:b0:6b9:68fb:5a28 with SMTP id w6-20020a056830060600b006b968fb5a28mr20995634oti.27.1696953569609;
        Tue, 10 Oct 2023 08:59:29 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id c24-20020a637258000000b0055c178a8df1sm6537023pgn.94.2023.10.10.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:59:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] PCI: qcom: Enable ASPM on host bridge and devices
Date:   Tue, 10 Oct 2023 21:29:12 +0530
Message-Id: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables ASPM by default on the host bridge and devices of selected
Qcom platforms.

The motivation behind enabling ASPM in the controller driver is provided in the
commit message of patch 2/2.

This series has been tested on SC8280-CRD and Lenovo Thinkpad X13s laptop
and it helped save ~0.6W of power during runtime.

- Mani

Changes in v2:

* Rebased on top of v6.6-rc1

Manivannan Sadhasivam (2):
  PCI: dwc: Add host_post_init() callback
  PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops

 .../pci/controller/dwc/pcie-designware-host.c |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        | 28 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.25.1

