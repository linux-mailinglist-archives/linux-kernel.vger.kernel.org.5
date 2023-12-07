Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1D808AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443233AbjLGObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjLGObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:31:40 -0500
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 06:31:45 PST
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE9126
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:31:45 -0800 (PST)
Received: from [192.168.178.76] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
        (Authenticated sender: g.gottleuber@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B51292FC01FB;
        Thu,  7 Dec 2023 15:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1701958916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYg2Ua18gfoK91NYq0zgMpgjLm5CM5Tzubo/eGrnCN0=;
        b=R/5e5cgtTOfpzfdej3UkNEmlkDTvc7oF3LwcIUnycinpxhqJjp/mOu/dzU/oDwU9/HqgYy
        LNF5K+EHHMP+9WgeTJpSN7+rvf0RbA+RC/3j3SUQME+/UME0zJs4kIsGh5q+8ey15daE81
        zB5RdrdVw593+cwUIQU3zhDSRCxKdbY=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
Date:   Thu, 7 Dec 2023 15:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
To:     Christoph Hellwig <hch@lst.de>,
        Werner Sembach <wse@tuxedocomputers.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Georg Gottleuber <ggo@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
 <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
 <20231206092420.GA27348@lst.de>
From:   Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <20231206092420.GA27348@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.12.23 um 10:24 schrieb Christoph Hellwig:
> What does save a lot of power mean, and why does it only apply to
> some platforms?  I suspect the more likely case is that APST is
> simply completely broken on this device?

Hello,

power consumption in s0ix varies depending on mainboard and NVMe SSD. 
Some examples:
Board,           nvme(id), mW w/o patch, mW with patch, kernel
NS5X_SN7XAU,     0x500f,   2691mW,       487mW,         6.2.0
NS5X_SN7XAU,     0x2263,   2262mW,       741mW,         6.2.0
PH4PRX1_PH6PRX1, 0x2263,   3042mW,       760mW,         6.2.0
NS5X_SN7XPU,     0x500f,   3135mW,       779mW,         6.5.0

All measurements were taken with the battery disconnected and a
modified adapter plug.

I don't have a deeper insight into APST to judge whether something is 
not working. But all other NVMe SSDs we have tested sleep with a power 
consumption below 2W (Samsung 970 Evo, Samsung 980, Corsair MP600 PRO 
NH, other Kingston NV1 with ID != 0x500f).

We originally noticed that newer Kingston NV1 (with id 500f) led to 
higher standby consumption. With some trial and error I came to the 
conclusion that the problem lies with 'Simple Suspend'.

Kind regards,

Georg Gottleuber
