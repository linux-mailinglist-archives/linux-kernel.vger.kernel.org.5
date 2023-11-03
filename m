Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89A17E06FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjKCQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKCQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:48:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DAFB;
        Fri,  3 Nov 2023 09:48:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F4CC433C8;
        Fri,  3 Nov 2023 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699030123;
        bh=7Ih4odCRaefU12RaYZiOnOpNLIUANhMxlXFENUxtaxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imMWQOD9bogm99VgUKiYSIrLlDGzZLxEJt6a1qEXWkCt5vg2kO/FVn2qbUG3AoAhc
         BrnChn+vvhc0qJQDgmI1CO2ROMTR+Ucxc/93c/5hkG1dTC5GVooiqaSi1d+beazNr5
         LOvUCcZL5ImQbVefaIU5Qwsrj15KCrSI1x3Q77Q13VXiaM5cMWT6Pdl6ZmyS45sDM9
         TnvHg9mtX411C9eSphbojOXibjsHqHR4t0gWmeqyLp3X8cpHJ8K61+tRGYiEKkjsKO
         fOO9pgLm1gUV3zKcQGMCbnfxkNUAHdiuYxtiJ50CDHVjG3IAjYb5XnMt1tgq2PMPFx
         qN7vQNXb7pvsw==
Date:   Fri, 3 Nov 2023 16:48:39 +0000
From:   Simon Horman <horms@kernel.org>
To:     Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v8 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
Message-ID: <20231103164839.GA714036@kernel.org>
References: <20231025141635.1459606-1-stefan.maetje@esd.eu>
 <20231025141635.1459606-3-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025141635.1459606-3-stefan.maetje@esd.eu>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:16:35PM +0200, Stefan Mätje wrote:
> This patch adds support for the PCI based PCIe/402 CAN interface family
> from esd GmbH that is available with various form factors
> (https://esd.eu/en/products/402-series-can-interfaces).
> 
> All boards utilize a FPGA based CAN controller solution developed
> by esd (esdACC). For more information on the esdACC see
> https://esd.eu/en/products/esdacc.
> 
> This driver detects all available CAN interface board variants of
> the family but atm. operates the CAN-FD capable devices in
> Classic-CAN mode only! A later patch will introduce the CAN-FD
> functionality in this driver.
> 
> Co-developed-by: Thomas Körper <thomas.koerper@esd.eu>
> Signed-off-by: Thomas Körper <thomas.koerper@esd.eu>
> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>

...

> +static int pci402_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct pci402_card *card = NULL;
> +	int err;
> +
> +	err = pci_enable_device(pdev);
> +	if (err)
> +		return err;
> +
> +	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)

Hi Thomas and Stefan,

If this condition is met then the function will return err,
but err is set to 0. Perhaps it should be set to an error value here?

Flagged by Smatch.

> +		goto failure_disable_pci;
> +
> +	pci_set_drvdata(pdev, card);
> +
> +	err = pci_request_regions(pdev, pci_name(pdev));
> +	if (err)
> +		goto failure_disable_pci;
> +
> +	card->addr = pci_iomap(pdev, PCI402_BAR, PCI402_IO_LEN_TOTAL);
> +	if (!card->addr) {
> +		err = -ENOMEM;
> +		goto failure_release_regions;
> +	}
> +
> +	err = pci402_init_card(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err = pci402_init_dma(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err = pci402_init_interrupt(pdev);
> +	if (err)
> +		goto failure_finish_dma;
> +
> +	err = pci402_init_cores(pdev);
> +	if (err)
> +		goto failure_finish_interrupt;
> +
> +	return 0;
> +
> +failure_finish_interrupt:
> +	pci402_finish_interrupt(pdev);
> +
> +failure_finish_dma:
> +	pci402_finish_dma(pdev);
> +
> +failure_unmap:
> +	pci_iounmap(pdev, card->addr);
> +
> +failure_release_regions:
> +	pci_release_regions(pdev);
> +
> +failure_disable_pci:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}

...
