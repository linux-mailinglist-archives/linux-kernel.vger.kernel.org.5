Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612027DFF19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKCGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:46 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCAB19D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:38 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C19172012B;
        Fri,  3 Nov 2023 14:15:32 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992133;
        bh=9uBDHUEXTjz3mCrbNalyoZITY3Ldzz/4xXHCv3UN9mU=;
        h=From:To:Cc:Subject:Date;
        b=K3v0iWVmX+gSRJXB26gV0dszp3ioYxD5gBAE+cy0+zwC19GLqz5VDol6j+LnRWD/n
         YlbCEQrNWQN0SuaRaBwed6fHcStypW1bRb1J5pA4+cYL1rNc81JTR/TOdhXKCgV9cH
         JCcmbNitu6A2AfDnryd/i7/T8L+yvIV9cGbS+pZ4huMCvTKQs6bQyEh46wLbkHJfKJ
         LoPky8QxVqefzGZ6H1xvZDjkFphmhWY8lgBQB/EO2QrUj67tLxqv61zXVxebNbbd/+
         3IzR6MAn0UL7VzICnVUuBls2Ad46YaJMPOzd7jeC7kVzBuuyWZhoDPp0Hvdzo/njEH
         SjtXB2PUMmd9Q==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 00/10] ipmi: kcs_bmc: Miscellaneous cleanups
Date:   Fri,  3 Nov 2023 16:45:12 +1030
Message-Id: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A cleanup of the KCS subsystem was prompted after some concerns raised
by Jonathan on Konstantin's series implementing DSP0254[1] (the MCTP KCS
Transport Binding Specification):

https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com/

[1]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0254_1.0.0.pdf

The MCTP KCS patches are currently at v5:

https://lore.kernel.org/all/20231010122321.823-1-aladyshev22@gmail.com/

A v6 will be necessary to rework them in terms of the cleanup done here.
I've pushed a preview of that work here:

https://github.com/amboar/linux/compare/d2cc82b50335c8fcf83e1d8f396c8f8cf4333ac4...mctp-kcs

In addition to addressing some of the resource lifetime concerns I've
added kerneldoc for the subsystem in anticipation of Konstantin's series
moving the headers to include/linux/.

To get Konstantin's work merged I expect we'll have to either take these
KCS patches through netdev or the MCTP patches through the IPMI tree. We
should figure out which way we want to go, but netdev's not open right
now and so that's not a pressing concern.

Please review!

Thanks,

Andrew

Andrew Jeffery (10):
  ipmi: kcs_bmc: Update module description
  ipmi: kcs_bmc: Include spinlock.h
  ipmi: kcs_bmc: Make kcs_bmc_update_event_mask() static
  ipmi: kcs_bmc: Make remove_device() callback return void
  ipmi: kcs_bmc: Define client actions in terms of kcs_bmc_client
  ipmi: kcs_bmc: Integrate buffers into driver struct
  ipmi: kcs_bmc: Disassociate client from device lifetimes
  ipmi: kcs_bmc: Track clients in core
  ipmi: kcs_bmc: Add module_kcs_bmc_driver()
  ipmi: kcs_bmc: Add subsystem kerneldoc

 drivers/char/ipmi/kcs_bmc.c           | 160 +++++++++++---------
 drivers/char/ipmi/kcs_bmc.h           |  41 +++++
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 152 +++++++------------
 drivers/char/ipmi/kcs_bmc_client.h    | 206 +++++++++++++++++++++++---
 drivers/char/ipmi/kcs_bmc_device.h    |  44 +++++-
 drivers/char/ipmi/kcs_bmc_serio.c     |  84 ++++-------
 6 files changed, 448 insertions(+), 239 deletions(-)

-- 
2.39.2

