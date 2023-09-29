Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC57B3C05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjI2Vhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Vhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:37:52 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EBE1AB;
        Fri, 29 Sep 2023 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696023470; x=1727559470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bJX4+NvWQ10hWHqKptnLbxIXX7JEo+TcPfEzhgBXIv4=;
  b=kiIcO146FQGSEckIpvoMzbxYZVyX/igvT5pO6GzGdtkVk9y/JuX6lQUF
   AaNO6ySPzwO4R+ZUoq+VcVgI6S3WBPpw65jdpHoJmH0ghDsSg9feSan/4
   8XBgW1/6TMw0/cQYYooAiN/lrN5sHUS6Y9voZi0UEaQdUgT8OO1j4v9Dl
   w=;
X-IronPort-AV: E=Sophos;i="6.03,188,1694736000"; 
   d="scan'208";a="242028653"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 21:37:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 6089140D91;
        Fri, 29 Sep 2023 21:37:47 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 21:37:42 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 21:37:40 +0000
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
Subject: [PATCH v3 0/2] Add Nitro Secure Module support
Date:   Fri, 29 Sep 2023 21:37:37 +0000
Message-ID: <20230929213739.68494-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
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

v2 -> v3:

   - Move globals to device struct
   - Add compat handling
   - Simplify some naming
   - Remove debug prints
   - Use module_virtio_driver
   - Ensure remove only happens on target device
   - Drop use of uio.h

Alexander Graf (2):
  misc: Add Nitro Secure Module driver
  hwrng: Add support for Nitro Secure Module

 MAINTAINERS                      |  11 +
 drivers/char/hw_random/Kconfig   |  12 +
 drivers/char/hw_random/Makefile  |   1 +
 drivers/char/hw_random/nsm-rng.c | 275 ++++++++++++++++++++
 drivers/misc/Kconfig             |  11 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/nsm.c               | 423 +++++++++++++++++++++++++++++++
 include/linux/nsm.h              |  35 +++
 include/uapi/linux/nsm.h         |  30 +++
 9 files changed, 799 insertions(+)
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



