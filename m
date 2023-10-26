Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3E7D7DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjJZH4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:56:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC2C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:56:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A71D860006;
        Thu, 26 Oct 2023 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1698306958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxdBcXYIBUZTorVYhg4RJds1Bjahgba7qpcJmqDPZ8A=;
        b=oDvA/UVmwTewFWFQ48H2EEQ63KtqCG30kyXD/k+4mepHQCZVcJVXw2Dj751L8dclIxHUng
        b1comh2Pm6UwoMStCosj6JfWVfIFnrLaWT7tF7A9uTRwKZGdd/RnIpj6TlXjW0NN7jHQCo
        TbJ7leKf6kvQ2yMi7DI4CEyns7v8jJBzCf/D/92iRJvqFqUKSSpFermZ/2Rewql/yIj20x
        JQKBNs8aQfgi1BUKV39Lm2SPxHlHLqOQqIsy+tWW7eJth/YtPMwsphW5b1VG3ojWpf3rmu
        zR1RKuwqH5DFexvmXbv5TaIlP3BpcuymmkCJDdrlX7aF74lbOBC8tyCtYMKh1w==
Message-ID: <2a91cc9a-98ac-4751-9bdb-56d8d91c1a86@arinc9.com>
Date:   Thu, 26 Oct 2023 10:55:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmem: brcm_nvram: store a copy of NVRAM content
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
References: <20231026073440.6724-1-zajec5@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231026073440.6724-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2023 10:34, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This driver uses MMIO access for reading NVRAM from a flash device.
> Underneath there is a flash controller that reads data and provides
> mapping window.
> 
> Using MMIO interface affects controller configuration and may break real
> controller driver. It was reported by multiple users of devices with
> NVRAM stored on NAND.
> 
> Modify driver to read & cache NVRAM content during init and use that
> copy to provide NVMEM data when requested. On NAND flashes due to their
> alignment NVRAM partitions can be quite big (1 MiB and more) while
> actual NVRAM content stays quite small (usually 16 to 32 KiB). To avoid
> allocating so much memory check for actual data length.
> 
> Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
> Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM")
> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
