Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07A80E844
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbjLLJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:54:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8C9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:54:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a22ed5f0440so36609166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702374882; x=1702979682; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjR8BKwSgpek9GG0wHa5XZwZECW6M2QMMuJp4oAEKcE=;
        b=sdt5gMozXQO5bWKKyXiZsvPXtvPaatjOa0Rnfq7nkVQQeWkdEm72Ynjfoe2lLjkHBD
         5r+/c+X4L07c8gGnQeYb0jPNgjvRbzBzHazeht8fRXExbLwh062OwDs+rs2ND+6cWWra
         2W2QLdRqC8Qn2mG0ysJMESzDA4xcRL74ditLBuxwl3JEu3XMypN6qjr4bzNkqdphEMhL
         SEOFokJcbDz28j8uiZPdIFgFXXQUOaJDPag8P/xkMO9PTgXV8g2Xag8YH/q4J7elEKkO
         dc5vDN3lvKVT5Y5t3f5lslSXPjrvsFovTdXgR47bGV61d80nBlcioODBqwtImYPQLxF9
         kamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374882; x=1702979682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjR8BKwSgpek9GG0wHa5XZwZECW6M2QMMuJp4oAEKcE=;
        b=RWIiySyV8JZfGkxpGVEWXMtuldCkUWtJEPbzN5Jc9bK2P/sdogf0pK+IE7OS6pFebY
         JIM6nKS6VYANk42rN9Ay24iAj0GD9lHufX85rof7yr84PnvBbYzeoaD+L80dM9L5AQhV
         HSojIAxmfuudv+eNv34aPLiigdTZS2YFGi+1fLhp9mru0ZgzD5Kx12NgzrvHpdHJdkiM
         3/3jF2EBSVdNWTBomXnnfHNL/wKQXSan5WHDq6B4KmuTavd1EssDSNX/wZfz7ZhI9nJ/
         zKKIG1/5V5NcR+gEWLnJt8gAIks7BGFRNJtnc6v5vV9arRUUY39t1QFM9Bw2hSqY/Ypn
         f8NQ==
X-Gm-Message-State: AOJu0YxDS1N1f/tfEucLo16KCyZY8ZKf1+15i8fBDnjOTnGzLZ/iB5fU
        E5HAZKqJEKml5RLH61VF84/UJWTXHCmXnP4AQ4s1MA==
X-Google-Smtp-Source: AGHT+IGVrUPvYxOqLCfziqXrWtlmHZgVgkiHcyuyjLZ3ekgLNOCxP0p3aUMy133AXGHUctxY5NWBIg==
X-Received: by 2002:a17:906:f0cd:b0:a19:a19b:4210 with SMTP id dk13-20020a170906f0cd00b00a19a19b4210mr1825378ejb.123.1702374882002;
        Tue, 12 Dec 2023 01:54:42 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id hu18-20020a170907a09200b00a1e081369a9sm5953570ejc.23.2023.12.12.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:54:41 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:54:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Subject: drivers/pci/controller/pcie-xilinx-dma-pl.c:638
 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.
Message-ID: <efd94697-ef3c-4554-82f0-df6f7b74134a@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: 8d786149d78c7784144c7179e25134b6530b714b PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
config: riscv-randconfig-r071-20231211 (https://download.01.org/0day-ci/archive/20231212/202312120248.5DblxkBp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120248.5DblxkBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312120248.5DblxkBp-lkp@intel.com/

New smatch warnings:
drivers/pci/controller/pcie-xilinx-dma-pl.c:638 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.

vim +/irq +638 drivers/pci/controller/pcie-xilinx-dma-pl.c

8d786149d78c77 Thippeswamy Havalige 2023-10-03  596  static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
8d786149d78c77 Thippeswamy Havalige 2023-10-03  597  {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  598  	struct device *dev = port->dev;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  599  	struct platform_device *pdev = to_platform_device(dev);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  600  	int i, irq, err;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  601  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  602  	port->irq = platform_get_irq(pdev, 0);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  603  	if (port->irq < 0)
8d786149d78c77 Thippeswamy Havalige 2023-10-03  604  		return port->irq;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  605  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  606  	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  607  		int err;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  608  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  609  		if (!intr_cause[i].str)
8d786149d78c77 Thippeswamy Havalige 2023-10-03  610  			continue;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  611  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  612  		irq = irq_create_mapping(port->pldma_domain, i);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  613  		if (!irq) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  614  			dev_err(dev, "Failed to map interrupt\n");
8d786149d78c77 Thippeswamy Havalige 2023-10-03  615  			return -ENXIO;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  616  		}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  617  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  618  		err = devm_request_irq(dev, irq,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  619  				       xilinx_pl_dma_pcie_intr_handler,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  620  				       IRQF_SHARED | IRQF_NO_THREAD,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  621  				       intr_cause[i].sym, port);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  622  		if (err) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  623  			dev_err(dev, "Failed to request IRQ %d\n", irq);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  624  			return err;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  625  		}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  626  	}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  627  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  628  	port->intx_irq = irq_create_mapping(port->pldma_domain,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  629  					    XILINX_PCIE_INTR_INTX);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  630  	if (!port->intx_irq) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  631  		dev_err(dev, "Failed to map INTx interrupt\n");
8d786149d78c77 Thippeswamy Havalige 2023-10-03  632  		return -ENXIO;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  633  	}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  634  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  635  	err = devm_request_irq(dev, port->intx_irq, xilinx_pl_dma_pcie_intx_flow,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  636  			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  637  	if (err) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03 @638  		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
                                                                                                                ^^^
s/irq/port->intx_irq/

8d786149d78c77 Thippeswamy Havalige 2023-10-03  639  		return err;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  640  	}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  641  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  642  	err = devm_request_irq(dev, port->irq, xilinx_pl_dma_pcie_event_flow,
8d786149d78c77 Thippeswamy Havalige 2023-10-03  643  			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
8d786149d78c77 Thippeswamy Havalige 2023-10-03  644  	if (err) {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  645  		dev_err(dev, "Failed to request event IRQ %d\n", irq);
                                                                                                                 ^^^
s/irq/port->irq/

8d786149d78c77 Thippeswamy Havalige 2023-10-03  646  		return err;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  647  	}
8d786149d78c77 Thippeswamy Havalige 2023-10-03  648  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  649  	return 0;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  650  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

