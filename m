Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D97FF4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjK3QTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbjK3QTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F531BF8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:19:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB9DC433CC;
        Thu, 30 Nov 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701361141;
        bh=ev/3cQ8WkO4ZH4x0KC/Ak2z7sd7hRQCPFQGQ6Q/urBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfCmaJXBScFzJTswaF+Ez0GyO6+FrNirwBnvtipOEyATe/Oj7aCtY4gb2IbLvIw3v
         UT2OisJ5UHOnYXLTF2YapcC795BuXiQBsvxfvlRuOmQxZquDtKxyYzfD+NVeAOOjsM
         Fp0hFHIoBvU0J4PDqQNXpCRvtJrSXeTPGFsEA4Nc=
Date:   Thu, 30 Nov 2023 16:18:58 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>,
        Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <2023113008-prenatal-pushchair-956f@gregkh>
References: <20231130152418.680966-1-herve.codina@bootlin.com>
 <20231130152418.680966-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130152418.680966-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:24:04PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created.
> For each PCI devices a struct device is already present (created and
> handled by the PCI core).
> Having a second struct device to represent the exact same PCI device is
> not correct.
> 
> On the of_node creation, tell the of_platform that there is no need to
> create a device for this node (OF_POPULATED flag), link this newly
> created of_node to the already present device and tell fwnode that the
> device attached to this of_node is ready (fwnode_dev_initialized()).
> 
> With this fix, the of_node are available in the sysfs device tree:
> /sys/devices/platform/soc/d0070000.pcie/
> + of_node -> .../devicetree/base/soc/pcie@d0070000
> + pci0000:00
>   + 0000:00:00.0
>     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
>     + 0000:01:00.0
>       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> 
> On the of_node removal, revert the operations.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org

How can this be cc: stable when the api it relies on is not?

confused,

greg k-h
