Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648F87E3B53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjKGLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjKGLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:49:59 -0500
Received: from esa2.ltts.com (unknown [14.140.155.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12EC10A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:49:55 -0800 (PST)
IronPort-SDR: vNiul8AbzKX3TcBOCBYHC1n47OMjlBNXsDrwZNdDHGgMPnpD1Et6p743gkBItwPBsnqxc4vVDa
 288PAJfWiEew==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa2.ltts.com with ESMTP; 07 Nov 2023 17:19:52 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     krzk@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, sirisha.gairuboina@Ltts.com,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Subject: Re: [PATCH v1 3/3] drivers: misc: Add support for TPS65224 pfsm driver
Date:   Tue,  7 Nov 2023 17:18:24 +0530
Message-Id: <20231107114824.1067475-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dc0852dc-8207-4195-a6ad-41792357aeda@kernel.org>
References: <dc0852dc-8207-4195-a6ad-41792357aeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On 26/10/2023 15:32, Gairuboina Sirisha wrote:
> > From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> >
> > Added support for pmic nvm set FSM_I2C_TRIGGER functions driver,
> > state control driver, Makefile and Kconfig
> >
>
> ...
>
> > +
> > +static int tps65224_pfsm_probe(struct platform_device *pdev)
> > +{
> > +	struct tps65224_pfsm *pfsm;
> > +	struct tps65224 *tps = dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev = &pdev->dev;
> > +	int irq;
> > +	int ret;
> > +	int i;
> > +
> > +	pfsm = devm_kzalloc(dev, sizeof(struct tps65224_pfsm), GFP_KERNEL);
>
> sizeof(*)
>
> > +	if (!pfsm)
> > +		return -ENOMEM;
> > +
> > +	pfsm->regmap = tps->regmap;
> > +
> > +	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
> > +	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
> > +						tps->chip_id, tps->reg);
> > +	pfsm->miscdev.fops = &tps65224_pfsm_fops;
> > +	pfsm->miscdev.parent = dev->parent;
> > +
> > +	for (i = 0 ; i < pdev->num_resources ; i++) {
> > +		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
> > +		if (irq < 0)
> > +			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
> > +						 pdev->resource[i].name);
> > +
> > +		ret = devm_request_threaded_irq(dev, irq, NULL,
> > +						tps65224_pfsm_isr, IRQF_ONESHOT,
> > +						pdev->resource[i].name, pdev);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to request irq\n");
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pfsm);
> > +
> > +	return misc_register(&pfsm->miscdev);
> > +}
> > +
> > +static void tps65224_pfsm_remove(struct platform_device *pdev)
> > +{
> > +	struct tps65224_pfsm *pfsm = platform_get_drvdata(pdev);
> > +
> > +	misc_deregister(&pfsm->miscdev);
> > +}
> > +
> > +static struct platform_driver tps65224_pfsm_driver = {
> > +	.driver	= {
> > +		.name = "tps65224-pfsm",
> > +	},
> > +	.probe = tps65224_pfsm_probe,
> > +	.remove_new = tps65224_pfsm_remove,
> > +};
> > +
> > +module_platform_driver(tps65224_pfsm_driver);
> > +
> > +MODULE_ALIAS("platform:tps65224-pfsm");
>
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong.

Thanks for your feedback. We will remove the same in the next patch version
as we don't have PMIC subset for now.

Thanks & Regards,
Sirisha G.
