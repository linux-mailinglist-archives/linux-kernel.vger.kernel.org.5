Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B207BED3D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378696AbjJIVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjJIVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:22:08 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2E170C;
        Mon,  9 Oct 2023 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696886474; x=1728422474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z8585nc3M3phCESzSv++FBQLoJuagdeKBNwW1jecD54=;
  b=OXzwWONqJyOXPl7NZ2jnV/w6hL7ViSzmSfuZtQzWLedxApeLI9+CfWCV
   X0lFpk/WBpMOS9W+T4xBmfzp3F1B4qjYapk7kOuzrPLgADHHJrp9AAk+u
   Tm2fc4T7styhoHDAIH8PeW7iRgFL82GeqbgjjubOSv00VJvKVE/mK8G8R
   M=;
X-IronPort-AV: E=Sophos;i="6.03,211,1694736000"; 
   d="scan'208";a="368774903"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 21:21:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 0458184B9F;
        Mon,  9 Oct 2023 21:21:02 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 21:20:57 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 21:20:55 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: [PATCH v4 0/2] Add Nitro Secure Module support
Date:   Mon, 9 Oct 2023 21:20:51 +0000
Message-ID: <20231009212053.2007-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
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

Nitro Enclaves run Linux inside as well as outside the Enclave. Outside
the Enclave, we already have the nitro_enclaves driver in upstream Linux
which controls a Nitro Enclave's lifecycle.

Inside the Enclave, the environment looks like a typical Firecracker
microvm. In addition to standard virtio devices, an Enclave also has an
additional "Nitro Secure Module" (NSM) virtio device which so far was
missing an upstream Linux driver. The NSM provides access to PCRs, an
attestation document as well as entropy.

To support the NSM communication protocol, Linux needs to learn to
generate and parse the Concise Binary Object Representation (CBOR)
format. The first patch adds support for a CBOR library. The second adds
the actual NSM driver.

With these patches in place, upstream Linux has everything that's needed
to run inside a Nitro Enclave.


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

v3 -> v4:

  - Add CBOR library
  - Merge hwrng into the misc driver
  - Add dependency on CBOR library
  - Add internal and ioctl logic for all current NSM actions
  - Use in-struct arrays instead of kvecs
  - Add sysfs entries for NSM metadata
  - Use dev_ print and devm_ allocation helpers

Alexander Graf (2):
  Import CBOR library
  misc: Add Nitro Secure Module driver

 MAINTAINERS                  |   17 +
 drivers/misc/Kconfig         |   13 +
 drivers/misc/Makefile        |    1 +
 drivers/misc/nsm.c           | 1466 ++++++++++++++++++++++++++++++++++
 include/linux/cbor/base.h    |   94 +++
 include/linux/cbor/cbor.h    |   22 +
 include/linux/cbor/decoder.h |   42 +
 include/linux/cbor/encoder.h |   48 ++
 include/linux/cbor/helper.h  |   41 +
 include/linux/cbor/ieee754.h |   52 ++
 include/linux/cbor/parser.h  |   32 +
 include/uapi/linux/nsm.h     |  188 +++++
 lib/Kconfig                  |    3 +
 lib/Makefile                 |    2 +
 lib/cbor/Makefile            |   12 +
 lib/cbor/common.c            |  105 +++
 lib/cbor/decoder.c           |  170 ++++
 lib/cbor/encoder.c           |  218 +++++
 lib/cbor/helper.c            |  175 ++++
 lib/cbor/ieee754.c           |  205 +++++
 lib/cbor/parser.c            |  243 ++++++
 21 files changed, 3149 insertions(+)
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 include/linux/cbor/base.h
 create mode 100644 include/linux/cbor/cbor.h
 create mode 100644 include/linux/cbor/decoder.h
 create mode 100644 include/linux/cbor/encoder.h
 create mode 100644 include/linux/cbor/helper.h
 create mode 100644 include/linux/cbor/ieee754.h
 create mode 100644 include/linux/cbor/parser.h
 create mode 100644 include/uapi/linux/nsm.h
 create mode 100644 lib/cbor/Makefile
 create mode 100644 lib/cbor/common.c
 create mode 100644 lib/cbor/decoder.c
 create mode 100644 lib/cbor/encoder.c
 create mode 100644 lib/cbor/helper.c
 create mode 100644 lib/cbor/ieee754.c
 create mode 100644 lib/cbor/parser.c

-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



