Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3957CEA67
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjJRV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJRV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:58:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFE5B6;
        Wed, 18 Oct 2023 14:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRXKeHJctBEVEUU8aR0It3qfAc8aZ34VoY/xvun/MPNBjFIwG54hagxxJvGpHs5db6k4QSbU1da2rgjmEL36YxgC9TL0Dry9bHXyQRuq5Bzl7yOFt7a7UYL/mv+N+Lunqu1VBV6zTYfeSnbCRyqhQY4QApUbNM6fR7bkX5vfhjTxd6izbcG6/xIKfAaiWUqKPTNW9zkjBLfXN2a3I2Apbeyrgm1dqrcFAWXb2GF3K63WtIhDLlGWvmIqFkKTTIDowB7LvHaj3+rRSKIjUgEBaioMAAbTJhnRiwiFzC3K/0iLiJjIbswjVU7b3e3qZubLHrN6vPn/mm0pg8ujIO509w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al89GYN+eGXpUE5h903F768lF0xpfuhJAQu2vm0WI6w=;
 b=c0bDhBSz77CZbodEMwRtlJ+eoEDXgvLhK2b1raEPf+A5BpJtbzN1FodiqUMzgori5FtwnnjJeU9eAmyUl5Q0/GMtcz0JuSQAxgDyZqTmjlJsqm+bHHvZDFLSCRd92VgUklXb9HBtHggAe4k+WLoFDbHjq9GOUYFFg37KNiJ45L6Wnn5cM26sS0aL9NX/oXQBMc3TNQRYwc+uyka8mfm4IxZP5Z4ZWK64ye/D8XLha5Wm8e+QWw9M1GXPcuhPJrawPxyt8LDbFmVk+1iwDX8CK1KIbvX0Sjp/tzhI+9o1gP2WLxpGCosOa9GdmzKtiNxR099TOSjwFRVBP+tgLkzG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al89GYN+eGXpUE5h903F768lF0xpfuhJAQu2vm0WI6w=;
 b=SzNGTq7/iMIKcWChPBkX71gxeHDhn/rpjmY7B5fa+DiiqJoROUl4Mzx4/67Z6XIlwbiSKjEEqwSaAt1acJfCp3i8ATCo4+kr+aVfcl/xYEXgbVaqlGQigX1PDgj6e+L3wB+N7+KAhapd00XpSjnKx/4f9KINQtQ5fzoq8gIt3bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 21:58:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:58:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, Frank.Li@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 0/5] I3C slave mode support
Date:   Wed, 18 Oct 2023 17:58:04 -0400
Message-Id: <20231018215809.3477437-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1e612d-0454-45c1-4ed0-08dbd0255c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbXJw5c3fmmjr8mj/YXHbR6ui7blod5m9vOdYhGhWNSdyJq7/vLQbEDu52IyppinPGYhiuoh8gFgF0oQ2py4VSccyrsZMCKjwWC7HUuSCueBR2trQQNr5oqn5mfbEowvzqDMg9BzT9IeIO23Hy/QOjGeYYb/pDnys3zyEYfq7tM7A40SZZNCgBL/FZl2ryqI8OMV9mh+swRYv1fAaXrIqyKDhfosZV3fjMQ83SDNZ382GC6JAaYUntrgxTil5GaPoCt7woG1mzIz0KadQW/HYWKP9+5PJgpH0xmIZ507nAp0P7Wc1wsv+O57Xb/EBCF8LWNaG4E9yX443zH9A6mH4IDolwHcRU8fPngY4/vv3/+e1cNbtzEikzTJ2JWUWAPaz37wKeh1yN6lfy0sME1x3VberxtyMYFe+ET4lWnFzpp20nDMav9qMV65bO6+6G40345Ck1ozy6fwkN/+2hIabfmSvcWCfzSOUrYQmZfq25SnkXZkBRQE4qaXlJurZZ7DWC+gMSr7589DR5D4OsAFKXmPCR+PwL9ObPGBxUXeUcenaEjD7C2M6eJbMUqw88gMZ2yz3tNdyA9fpnqwN8YKWyeBR+YvK15nQFRF3w+hSxzPSGroYGDzQ3WvD0PASnSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(966005)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4326008)(2906002)(86362001)(7416002)(38100700002)(2616005)(52116002)(6512007)(1076003)(83380400001)(6506007)(26005)(921005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZaZ8HbKVDUrWzMGK6J/yWFbbO/UETRj9Ux7NtKDpv2sGd2ukxIbhvZLde4g?=
 =?us-ascii?Q?H8rvQh3NKJxI67mIWmFnRCoAizUiF1eZmgQnEN7rws1Jb04B6fEy2QKzFiSF?=
 =?us-ascii?Q?/c14hXaVfs0d0dL4c496tUs1t7ERZ5VTZ8kGK/DQANG5Ey6fbBvdvFgzMuHg?=
 =?us-ascii?Q?hAdCnn7Obg4v+ry08yD/3AzTlDYLOsevcpcsgeznI2KN5ZgLHrv2JHpCIlZG?=
 =?us-ascii?Q?OS5iaKdGhr09EgtpwrdOd4qgHGnGhFsLDShSYNFbybgWyWMJ69PasE2sfYnB?=
 =?us-ascii?Q?obsRRysEaU1xPibUG647nzkprySzKqPDZJdMPqpckNtLA+1lJrGkdzlSSjT4?=
 =?us-ascii?Q?5WyzceWFvso5Mli2Y+xp6VYpZEmoFGIp80zUk7dpLkzOjniDq/LW3fw7H90p?=
 =?us-ascii?Q?vPGQK4epkXuoCLzXp21AaaUjsgTX042kg+WUfkvkK3+19vHqy+6hvhP+4JUt?=
 =?us-ascii?Q?Kc3o50czOI/qVqboG5rt+NA5XMKRkvaqqWpf/vVEAgiK7CvUCYAyTRTZ8gak?=
 =?us-ascii?Q?kvTgNP13TdYRgzznwRLq+GhizOa36od6spVaA1glm1m0DdhiTW+l9hca+ONh?=
 =?us-ascii?Q?RweE0igF4cm7UmdjsGtaKFrhV3XRazibG1oIGKfZHkY3EzdFS+gPKWx/MhHh?=
 =?us-ascii?Q?SkvWMItHzrSXguwj6kpxqgld8kZdCnqh2jx1Cw8U9K7tBsObvahzx0KQLf1F?=
 =?us-ascii?Q?XfyDN51xObE2VS+izAxOQE9cJjDWkSi+uxTdE0ZTtnzKXgeiDjoCeQhx+ARc?=
 =?us-ascii?Q?ira90NPlsGE5u6oxvXGmJaiKYQ6uR+FjnYFrjyTGcxLRm1nkQ8K9NSxgD50i?=
 =?us-ascii?Q?B7aFj1iPH8RYFF7TsD5TkNCtYw8g0moAMmDBtiD4IcnJmgcNIlTbQCHn2t39?=
 =?us-ascii?Q?xO1MGTmfqsAHKJjQTL/VCSgKHTzG2rVzAC2siQBkViIFncFxIf+Bgn4SsR+6?=
 =?us-ascii?Q?nUbRciVezQGtwdcaisxMdmSoURYuqLZZ+thKd6a347rm92/NEmUiWOqPFeMw?=
 =?us-ascii?Q?VV2xJnGx5Cn0TRdS8zQhtCp3WlLn1N+1HqODLmPl29QmPJ8xj6TP5n/wXw4o?=
 =?us-ascii?Q?x04XYcFFShg/VbYv1Nw1HGi6b9xy8hlsjqTED8q9P8p/cbTE8qg8QTy3Z2/H?=
 =?us-ascii?Q?ovtTY7kWH2i6pkxb5DWsIlifO+YNAnDYCw1ACxe8jr3uQtzKB48c/QvWQMzZ?=
 =?us-ascii?Q?nFhOIZaJi9q20sslovLhJPTJkwH5wXJ0emk/ps4KID8FkUJKN29GozFDjkDj?=
 =?us-ascii?Q?O+Q/BPKCPYIppCSaTWCpT+iJbT4kFv30JNwaLmYYLtvgwPMQPnN1ReNHFgE8?=
 =?us-ascii?Q?dtF8Vi2twC4ULTe4MKa+31BAn/Q6xTwg2jQ1ydOupKRgJrOhKBTrx9jbM/o5?=
 =?us-ascii?Q?69zWLccO5/YwDw0lXBtIzvAFJyTyeEjqeYQYKJUarwuU7J/zoJRvfyLEe8zj?=
 =?us-ascii?Q?x1aNfks18aHaY09F9Tf7EvFGmptGux5YjaL80tTkHvZOrRtgHe88MN1K/Qmb?=
 =?us-ascii?Q?OuiHYhBIKF67sM3TQfIXDQ13Xe7KX0exCZYdHHsemE+/V4EYZAdv3iiS0X2u?=
 =?us-ascii?Q?tmWeeJrscH9sgWCwiGZ/FMDz1SRBTuzI7yzxySNG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1e612d-0454-45c1-4ed0-08dbd0255c7c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:58:28.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xupsPAD27W2tAML6BLhf3v27Sp6HkYGvuhmgD8+Y/V7vdXu3PFTmtq6TVpKI9TEzWpJlboz0rR4x6TxrJK9SVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This  patch introduces support for I3C slave mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C slave controller driver and the I3C slave function
driver

Typic usage as

The user can configure the i3c-slave-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-slave-tty Device to slave Controller
------------------------------------------------

In order for the slave function device to be useful, it has to be bound to
a I3C slave controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-slave/

Host side:
        cat /dev/ttyI3C0
Slave side:
        echo abc >/dev/ttyI3C0

Master side patch:
https://lore.kernel.org/imx/20231018211111.3437929-1-Frank.Li@nxp.com/T/#u

Frank Li (5):
  i3c: add slave mode support
  dt-bindings: i3c: svc: add compatible string i3c: silvaco,i3c-slave
  i3c: slave: add svc slave controller support
  i3c: slave: func: add tty driver
  Documentation: i3c: Add I3C slave mode controller and function

 .../bindings/i3c/silvaco,i3c-master.yaml      |   8 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/slave/i3c-slave-cfs.rst    | 109 +++
 .../driver-api/i3c/slave/i3c-slave.rst        | 189 +++++
 .../driver-api/i3c/slave/i3c-tty-function.rst | 103 +++
 .../driver-api/i3c/slave/i3c-tty-howto.rst    | 109 +++
 Documentation/driver-api/i3c/slave/index.rst  |  13 +
 drivers/i3c/Kconfig                           |  30 +
 drivers/i3c/Makefile                          |   4 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 548 ++++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/slave.c                           | 453 ++++++++++
 drivers/i3c/slave/Kconfig                     |   9 +
 drivers/i3c/slave/Makefile                    |   4 +
 drivers/i3c/slave/svc-i3c-slave.c             | 795 ++++++++++++++++++
 include/linux/i3c/slave.h                     | 503 +++++++++++
 18 files changed, 3276 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-function.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/slave/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/slave.c
 create mode 100644 drivers/i3c/slave/Kconfig
 create mode 100644 drivers/i3c/slave/Makefile
 create mode 100644 drivers/i3c/slave/svc-i3c-slave.c
 create mode 100644 include/linux/i3c/slave.h

-- 
2.34.1

