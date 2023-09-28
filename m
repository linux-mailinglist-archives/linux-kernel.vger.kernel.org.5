Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368287B26BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjI1Uk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjI1Uk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:40:56 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 13:40:52 PDT
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364519D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:40:52 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.146.175])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 3DEFA2766C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:06 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-tq497 (unknown [10.110.208.152])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C499A1FDBA;
        Thu, 28 Sep 2023 20:24:04 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-tq497 with ESMTPSA
        id vKH/K+TgFWX2QwYA45+jXQ
        (envelope-from <rafal@milecki.pl>); Thu, 28 Sep 2023 20:24:04 +0000
MIME-Version: 1.0
Date:   Thu, 28 Sep 2023 22:24:04 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v10 1/3] nvmem: core: Rework layouts to become platform
 devices
In-Reply-To: <20230922174854.611975-2-miquel.raynal@bootlin.com>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
 <20230922174854.611975-2-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1982d29ccb4e8c82cddfe0d86edc6072@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16205640309849697181
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudejiedrfedurddvfeehrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 19:48, Miquel Raynal wrote:
> Current layout support was initially written without modules support in
> mind. When the requirement for module support rose, the existing base
> was improved to adopt modularization support, but kind of a design flaw
> was introduced. With the existing implementation, when a storage device
> registers into NVMEM, the core tries to hook a layout (if any) and
> populates its cells immediately. This means, if the hardware 
> description
> expects a layout to be hooked up, but no driver was provided for that,
> the storage medium will fail to probe and try later from
> scratch. Technically, the layouts are more like a "plus" and, even we
> consider that the hardware description shall be correct, we could still
> probe the storage device (especially if it contains the rootfs).
> 
> One way to overcome this situation is to consider the layouts as
> devices, and leverage the existing notifier mechanism. When a new NVMEM
> device is registered, we can:
> - populate its nvmem-layout child, if any
> - try to modprobe the relevant driver, if relevant
> - try to hook the NVMEM device with a layout in the notifier
> And when a new layout is registered:
> - try to hook all the existing NVMEM devices which are not yet hooked 
> to
>   a layout with the new layout
> This way, there is no strong order to enforce, any NVMEM device 
> creation
> or NVMEM layout driver insertion will be observed as a new event which
> may lead to the creation of additional cells, without disturbing the
> probes with costly (and sometimes endless) deferrals.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I rebased & tested my patch converting U-Boot NVMEM device to NVMEM
layout on top of this. It worked!

Tested-by: Rafał Miłecki <rafal@milecki.pl>

For reference what I used:

partitions {
	partition-loader {
		compatible = "brcm,u-boot";

		partition-u-boot-env {
			compatible = "nvmem-cells";

			nvmem-layout {
				compatible = "brcm,env";

				base_mac_addr: ethaddr {
					#nvmem-cell-cells = <1>;
				};
			};
		};
	};
};

-- 
Rafał Miłecki
