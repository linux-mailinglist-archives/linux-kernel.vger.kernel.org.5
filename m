Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527B7B33AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjI2Ndb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjI2Nd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:33:29 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A31AA;
        Fri, 29 Sep 2023 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695994408; x=1727530408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xambfgWWZgU+LtWtj7EW8T9Yc1SrUYVGEqTnYU67a1A=;
  b=MMw1sRYPvBNuZAALLYnzAz3nqhgNOIwM1qrSXU8POTgB9/m39urMoZqA
   x0Bhcz9WAzfIDdq7NtuE4qknoiq22czQcdx0JW1MH58Xh2iTHHFlkQkV9
   neyJxniAs8XF6UD0aLjzO75qqdrdaV/XVUSIoz2z6xn/gDmgMB+QB41eP
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,187,1694736000"; 
   d="scan'208";a="32401400"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:33:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id ACE9040D6A;
        Fri, 29 Sep 2023 13:33:25 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 13:33:24 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 13:33:22 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 0/2] Add Nitro Secure Module support
Date:   Fri, 29 Sep 2023 13:33:18 +0000
Message-ID: <20230929133320.74848-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have support for the Nitro Enclave kernel module in upstream
Linux, which is needed to control a Nitro Enclave's lifecycle.

However, users typically want to run Linux inside the Enclave as well. To
do that well, they need the ability to communicate to the Nitro Secure
Module: A virtio based PV device that provides access to PCRs, an attestation
document as well as access to entropy.

These patches add driver support for NSM. With them in place, upstream Linux
has everything that's needed to run as a Nitro Enclave kernel.


Alex

v1 -> v2:

   - Remove boilerplate
   - Add uapi header

Alexander Graf (2):
  misc: Add Nitro Secure Module driver
  hwrng: Add support for Nitro Secure Module

 MAINTAINERS                      |  11 +
 drivers/char/hw_random/Kconfig   |  12 +
 drivers/char/hw_random/Makefile  |   1 +
 drivers/char/hw_random/nsm-rng.c | 272 +++++++++++++++++++
 drivers/misc/Kconfig             |  11 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/nsm.c               | 448 +++++++++++++++++++++++++++++++
 include/linux/nsm.h              |  35 +++
 include/uapi/linux/nsm.h         |  24 ++
 9 files changed, 815 insertions(+)
 create mode 100644 drivers/char/hw_random/nsm-rng.c
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 include/linux/nsm.h
 create mode 100644 include/uapi/linux/nsm.h

-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



