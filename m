Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8852F81284F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443113AbjLNGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:37:19 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E959EA6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:37:24 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58dd3528497so4917206eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1702535844; x=1703140644; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ByMsI+TQi9NOnAmZv30hIBVObC1nPLx9Qj7duP4chNM=;
        b=ObavcbfyQbfE8jemvKgIfGrRI+91HnMmCxyE1adfJFdxRXzNxu7P2/BwV2rMc0Xhu5
         Gi/+zVbZgeL8D3lqpgl7runcUtjd8mg62JGh6cn+mmzBoFzbpBw5iHrMg81CsBF6OwHA
         15CsOq+YuX+x+N4EEfAywXzYBXYnISyO26WvD9MxGTlXloq5hlGQUrqO0yWn51adx+JC
         QutL2YTSdQh/p361TaSZViQec4W/z4s3T2fgQbqfpfn/FDd3aly02jmR6y47U7PMoI2y
         FTXaTjbDHAgsPbzW5eRtgpihngxYEII5T5OPLBHwBfa2+y2ormTQqhkoD8Vy940EPz4j
         3N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535844; x=1703140644;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByMsI+TQi9NOnAmZv30hIBVObC1nPLx9Qj7duP4chNM=;
        b=JWqvp2F42p5r7E8OGuLQVp8iAI0ATr7kpqSMSXgE5ZI4VWegNrdbVh9af4tHBI3GTg
         +BLUrZRtnhkxS8Pax1L6WCaPQg1vkHzIzK+0M0ZxKb+xrv2K8/aksGGHR/2mIr8A4e/g
         rgq57lsvU2nrv4XXM+y6KO6IKHu2IHQwrzX8JFlu58p6Fg93sbPeGyL74rJTo9bNsCHv
         o5xVnyglu/nUReIx270HUlhqmnv7YNWapf/DxNU37wFJjavWzxOtx3wo7jfP017Y5oVo
         G17DlfxgYDXWg9bfJrRXvjDBYu5kI1sUMqgzUX/E/QbHDVEXXTooQCHiQQXT0lQ2/P5M
         2lew==
X-Gm-Message-State: AOJu0YxGlqCRb6RgLNpYgxgi9WuIXhUwKosRWuBd6NJwJeSyGo361kJJ
        ftfUGSCQHi5cxtQs5ph9d703JQ==
X-Google-Smtp-Source: AGHT+IGDYgeMUV/OiBQYd+6hLIHIWc2eMQukN7gerceviPNB12bAQ2UKGqVe84ZOgh2+rdPXNyqT1A==
X-Received: by 2002:a4a:d28f:0:b0:590:e85:199c with SMTP id h15-20020a4ad28f000000b005900e85199cmr6792637oos.6.1702535844207;
        Wed, 13 Dec 2023 22:37:24 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3390878oof.22.2023.12.13.22.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:37:23 -0800 (PST)
From:   Matthew W Carlis <mattc@purestorage.com>
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports & RCECs
Date:   Wed, 13 Dec 2023 23:37:17 -0700
Message-Id: <20231214063717.992-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
References: <20221210002922.1749403-1-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Any Interested

Recently found that this patch had the affect of requiring us to set
pcie_ports_dpc_native in order to use the kernel DPC driver with PCIe switch
downstream ports. The kernel check for the DPC capability in portdrv.c has;
if pci_aer_available() and (dpc-native or using AER port service driver on
the device). I wonder if we couldn't do away with the requirement of the
AER service being used on the port if pci_aer_available() & host->native_aer
don't lie. I'm still trying to decide exactly what the condition ought to
look like, but it might draw from the AER service check above it. For example:

        if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-           pci_aer_available() &&
-           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+           dev->aer_cap && pci_aer_available() &&
+           (pcie_ports_dpc_native || host->native_aer))
                services |= PCIE_PORT_SERVICE_DPC;

Thanks,
-Matt


