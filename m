Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4377B288A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjI1WrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1WrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:47:00 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663019D;
        Thu, 28 Sep 2023 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695941218; x=1727477218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NN8BUbBe5IQWldFLhKZkzwvmTBEkE0S0/4uz0sb3TFk=;
  b=csTz4Njf9MIMGz/QPcbN55uwKARxFo8vfZZxd+ka6/Tg3/tGFFGMgTMU
   Yi4SXrqyYW8SYBYm2l/4yowE0F8ayx95oe54wZdaGQ7E+yGrxnn6LdaUe
   RYbOZMDuBDpMI0CYUGNR+qpw68FYUYPO+ROiJsFyimVbg8vsmsDRc87W/
   8=;
X-IronPort-AV: E=Sophos;i="6.03,185,1694736000"; 
   d="scan'208";a="32247585"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 22:46:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 920A640D8F;
        Thu, 28 Sep 2023 22:46:55 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 28 Sep 2023 22:46:49 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 28 Sep 2023 22:46:47 +0000
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
Subject: [PATCH 0/2] Add Nitro Secure Module support
Date:   Thu, 28 Sep 2023 22:46:43 +0000
Message-ID: <20230928224645.19768-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Alexander Graf (2):
  misc: Add Nitro Secure Module driver
  hwrng: Add support for Nitro Secure Module

 MAINTAINERS                      |  10 +
 drivers/char/hw_random/Kconfig   |  12 +
 drivers/char/hw_random/Makefile  |   1 +
 drivers/char/hw_random/nsm-rng.c | 284 +++++++++++++++++++
 drivers/misc/Kconfig             |  11 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/nsm.c               | 469 +++++++++++++++++++++++++++++++
 include/linux/nsm.h              |  42 +++
 8 files changed, 830 insertions(+)
 create mode 100644 drivers/char/hw_random/nsm-rng.c
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 include/linux/nsm.h

-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



