Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B437CEAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJRWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJRWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:07:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95B111;
        Wed, 18 Oct 2023 15:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsoSnBhf4L241ZmAnRsssrtYC/z8QIvRptGxWTlSpO7TyarqTtTjsc3wCwUMtC/N5hX9sIJ17X6ILrOgGoLSGUqRjtpgBIo5cTmaVwiqk8ZiGwkB9ksFntDdNAA0PWAwN4d1Jb8CufiUYyrtO20Sv9HDlmOkA5hauhbi8Jc2keCFcKQcswgGNtnV29AQNyQJ9v1wrbNv/qzstdTWLEIzEatmKT2+amEWY3dYLsJqgnT0gsURNPxkgIRdhOZiAzmaGYnm4+JY1IV+4sEu1MCqT/H52Kzs1JYHZZ1KOhPzZya4uhvTVxMrUYmHvwVPt314MsPGg4PZ/ULoPUXghL0eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsPwt67BaTg8sv/50n2tPR++KP6lvXVwazl2upcBULI=;
 b=Kt6TYb9iOjBPvureMuJHfNv7zoLHgvu+WBChg7rt0D8H/kMJ+B5FtZ0dBCk8vX1J3sJUARTb7YFFdgL6tp5e17WP5l5brQp74vIpq/dHBQFiBDjBtV78QiVib5ctUBORtDp09UOrEcpnhTTC2gbaAEVCXDCHb1D1Yi8Nl1cfGVMh0sXbvBrVC55E60m/IF6KZlAYDCVi9stUpo0f29GxzGZQlxmeRs4fCUFT5FE+LHnN72ETbL8pEMlSiNnsyED41+EJ5bRLu4izBdkEX0owVwAjFoYIbD14X6lqholnAyCgBSu6NJGyh1M9A5Yms2JOLKOB1CEAvfIofd0TPChrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsPwt67BaTg8sv/50n2tPR++KP6lvXVwazl2upcBULI=;
 b=pYZRCdIbij6SbU28DmeTXBlXjDGMcxeKAOxEOByis7DkER+XEVxlJWcSerkVwFDNwLIUwcQAJOnmmL13U+JIr80gskJAOUpFUaFbaVaD5ZdsEQWMjH9rvj7Ywy1/dWNzJyBbCLXLKNaUQTiSs7n/4yzXThcNu8JQuqTcUX+COeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 22:07:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 22:07:26 +0000
Date:   Wed, 18 Oct 2023 18:07:17 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/5] Documentation: i3c: Add I3C slave mode controller
 and function
Message-ID: <ZTBXFd1lOjWTiAI9@lizhi-Precision-Tower-5810>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-6-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018215809.3477437-6-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a12d39b-362d-40f8-1e45-08dbd0269ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tk9SjclsGT5DldAtF5MvBJeWovDaAfqR1FiziTpFCHBAnc1zf2hi7rz+dVj2erGS7u79NmxUqw7UMxOyFkuqSzoc3yNklMW6gLXSA3H+vxc8nJB3CHSilDz+kuFLTUIEKQBWkJWEqlKN95CddhQIm3oatDkt/2+W/blQ6sBLVGtSiAU2srDJvslrp27HXo4Gx1pQ1qMEkUD8KQUQJ5t+0wEUlsZE6rzU0srxybp5OC1jdInQQ3pW67gJ/vfjMoIc5v4yeQ+oGM1Wmk+/LFZlXkxOE4t5aH/dxgmWo9OlMOvA/tUbhNKt0DkSARDHL93FFt3mLXRDQLqEVvcBInsdcsniRRc7pT3Um9cGjQjbGb69chuxAp8CpmGQZe5lyclJ20ki9ZscV0VFuEF3GSn1TDWkr7QYBN/xPftvfsS+QeTC7jjtXwAbAVhOkR+SAvvUk4gGfAXYDxP0xQAoBkE1PpMPff+v//NZfnIo4D5ADou8DRhWuMSktkE2xo0PObKsCsW69bLHc80jYvMwa7XOIf+A6Ul7rUf8OB9IPwurxaTQKGS3WeXk/f0E78mCeYR1vitcxGkumGx9FKuMF8agP7TKbxt2LbVJNDVaKF7D7PrOiQuJBVvT3wv9oypd5DuXza6dq9LRa294G725n5cMZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(8936002)(8676002)(5660300002)(41300700001)(4326008)(30864003)(2906002)(86362001)(7416002)(38100700002)(52116002)(9686003)(6512007)(83380400001)(6506007)(26005)(921005)(33716001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yl+OQEM+sGzgoACMvRorpHiq8bMj3Kpo8ltTPn+bv6WbBiesQ2AGQEP/H7Y1?=
 =?us-ascii?Q?gnBFI5Uncyfg0GzCyECcS/CXlWbdQLBYwDRkXmV6dT9MeiUVqFHJAZ4Pht6i?=
 =?us-ascii?Q?glgXHAH4p/PdReC6z2vgBl9psDGm6GKbB3ifMtEVKI3/cFiVufCDsuHuJSOV?=
 =?us-ascii?Q?ftA4Cka/+EXn3TZx13CU1X2Xe/I4zzoeefijSQI+mPKzluleID23K5gmlzt+?=
 =?us-ascii?Q?KsJayokEXD/nrPYL6EO0vvV9NubFwf2hQRVbc8dzL7T5lWndE0ArrG1SG+bg?=
 =?us-ascii?Q?sYwG0ccoG1Gsk4mpfOo6YXFLjbzxhmN0zEBKGUwmvGMBdIZsm9rsNSJhbRSo?=
 =?us-ascii?Q?zE9rRyBY+BwTeaYB0f71UzPNCVhS1Z61RLcYBJm9k0T0vZ2xXVfWmu9H4PT/?=
 =?us-ascii?Q?bnRHYGs7AOiAe2dnw7teAZM/61EBEwPyfV3+U32RtaBNOgP6LGWjLCjD8Hro?=
 =?us-ascii?Q?3UP372RsGoiE1fk/058fxCP4Hnof7pemqEDfBLb2lNqDTo6QYzJVHBmZeSz9?=
 =?us-ascii?Q?CUapjnBKKCBjCEbAggpe5uFAmSAGf2xHCwyrsqZtGhlbJcIpcWSQPOtnVo87?=
 =?us-ascii?Q?Og0Ovbv8162zIdCwYmHF3Ee2iYqvMAvd59c69+czU3QE6zPPeumXpCX6B9Gy?=
 =?us-ascii?Q?2MlwD6zea4TimLwfCFPH5mS/owIPvc2kKjJYEAsj5EwwLEjxhUk2g2Tw2hIX?=
 =?us-ascii?Q?Zsu/JXaRBxWX6ZT1QmCPIKtZBFu1mYHvd7ct9tyieQZYS+7P0Hv+S54C7h9R?=
 =?us-ascii?Q?p5ti5mLSh95TmX52wP/A97USIPQRggye6Gz6+ZJLggVpEFUhRyX1tLO7O9C+?=
 =?us-ascii?Q?fUhsCKCh7Xx8OfaRCvZMhQenAi219mSDB7wxGtUumZDYbDaqqFDGDL/ZiJf1?=
 =?us-ascii?Q?C+2q8Wi3DtkoFGNaK/+Ov/q+Ua23VYjg9KSHEUUZT8Tj5lo0gjDw965BUFy3?=
 =?us-ascii?Q?3+1I0H7kSqMFjGwfTFr2LZiDfeGLHU1Dtv07IzxWAPoNslxfXYPehlLhnI31?=
 =?us-ascii?Q?MdlbdHr8+bCyiuYd27f8DSJ3RRPq18Krl06Os0lIthrYKLOH+3eu7EU8XNPH?=
 =?us-ascii?Q?L70SuAOTHLTaRld2VPv20lrbZHX+1CVLVGcN14TP2Kfs+JCPS5oiC4RHrxvj?=
 =?us-ascii?Q?RvY2jkkfB+YtP2dacAmKQPukWoVbP7Dc8G1xYc0HbShOFzQqekW5VEGx4bkx?=
 =?us-ascii?Q?5qn56pI7VVhpuepWT0kqPKx96jjs//Aasqz6KwHVd6ikg5p5oiRlaiZzoM2N?=
 =?us-ascii?Q?IqyJwucrqXf/cngCCUyvBLHIKOhFfMt/XWTyqWcOmCXn4FyfNV2TSscPLkc/?=
 =?us-ascii?Q?skWUIJHN286z9wu9XmiqCtwgSgLAvSzYb6QEjdKJY9r9+qoa2VSJELnxSOm2?=
 =?us-ascii?Q?WbmFaGFT0TlkD9BrttoivyfmEan4+fF9SA6UKJmV4lUMWNwODCe1aOlSsEwm?=
 =?us-ascii?Q?oIdJkUjdMs2Aa7EdqzaFNQA9QNhCFgGhDB+Bt1Caqsa1K+x8YEopxyO8NwHa?=
 =?us-ascii?Q?OvUrMgTZ6CkMIMyxIR8xOpqK30B54VRyDg6FFZhP4oA3N+s40tFVmZKnrUlY?=
 =?us-ascii?Q?KuligmxbHfmSB2CERzc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a12d39b-362d-40f8-1e45-08dbd0269ca5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:07:26.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P40bk32Zhzgg67WoPIBnA0bk5Ly96DFAORVEVa1GSrmXG3GHm/7tJ0jVNQenYCAAYazJH673hO1wJ5LfVpbHVQ==
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

On Wed, Oct 18, 2023 at 05:58:09PM -0400, Frank Li wrote:
> Add I3C slave mode and tty over i3c func driver document.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/driver-api/i3c/index.rst        |   1 +
>  .../driver-api/i3c/slave/i3c-slave-cfs.rst    | 109 ++++++++++
>  .../driver-api/i3c/slave/i3c-slave.rst        | 189 ++++++++++++++++++
>  .../driver-api/i3c/slave/i3c-tty-function.rst | 103 ++++++++++
>  .../driver-api/i3c/slave/i3c-tty-howto.rst    | 109 ++++++++++
>  Documentation/driver-api/i3c/slave/index.rst  |  13 ++
>  6 files changed, 524 insertions(+)
>  create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst
>  create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave.rst
>  create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-function.rst

Please omit i3c-tty-function.rst. This one accidently add to here.
I will remove it at next version.

>  create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-howto.rst
>  create mode 100644 Documentation/driver-api/i3c/slave/index.rst
> 
> diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
> index 783d6dad054b6..63fc51fc8bd58 100644
> --- a/Documentation/driver-api/i3c/index.rst
> +++ b/Documentation/driver-api/i3c/index.rst
> @@ -9,3 +9,4 @@ I3C subsystem
>     protocol
>     device-driver-api
>     master-driver-api
> +   slave/index
> diff --git a/Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst b/Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst
> new file mode 100644
> index 0000000000000..d78fcbc4e5587
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Configuring I3C Slave Using CONFIGFS
> +=======================================
> +
> +:Author: Frank Li <Frank.Li@nxp.com>
> +
> +The I3C Slave Core exposes configfs entry (i3c_slave) to configure the I3C
> +slave function and to bind the slave function
> +with the slave controller. (For introducing other mechanisms to
> +configure the I3C Slave Function refer to [1]).
> +
> +Mounting configfs
> +=================
> +
> +The I3C Slave Core layer creates i3c_slave directory in the mounted configfs
> +directory. configfs can be mounted using the following command::
> +
> +	mount -t configfs none /sys/kernel/config
> +
> +Directory Structure
> +===================
> +
> +The i3c_slave configfs has two directories at its root: controllers and
> +functions. Every Controller device present in the system will have an entry in
> +the *controllers* directory and every Function driver present in the system
> +will have an entry in the *functions* directory.
> +::
> +
> +	/sys/kernel/config/i3c_slave/
> +		.. controllers/
> +		.. functions/
> +
> +Creating Function Device
> +===================
> +
> +Every registered Function driver will be listed in controllers directory. The
> +entries corresponding to Function driver will be created by the Function core.
> +::
> +
> +	/sys/kernel/config/i3c_slave/functions/
> +		.. <Function Driver1>/
> +			... <Function Device 11>/
> +			... <Function Device 21>/
> +			... <Function Device 31>/
> +		.. <Function Driver2>/
> +			... <Function Device 12>/
> +			... <Function Device 22>/
> +
> +In order to create a <Function device> of the type probed by <Function Driver>,
> +the user has to create a directory inside <Function DriverN>.
> +
> +Every <Function device> directory consists of the following entries that can be
> +used to configure the standard configuration header of the slave function.
> +(These entries are created by the framework when any new <Function Device> is
> +created)
> +::
> +
> +		.. <Function Driver1>/
> +			... <Function Device 11>/
> +				... vendor_id
> +				... part_id
> +				... bcr
> +				... dcr
> +				... ext_id
> +				... instance_id
> +				... max_read_len
> +				... max_write_len
> +				... vendor_info
> +
> +Controller Device
> +==========
> +
> +Every registered Controller device will be listed in controllers directory. The
> +entries corresponding to Controller device will be created by the Controller
> +core.
> +::
> +
> +	/sys/kernel/config/i3c_slave/controllers/
> +		.. <Controller Device1>/
> +			... <Symlink Function Device11>/
> +		.. <Controller Device2>/
> +			... <Symlink Function Device21>/
> +
> +The <Controller Device> directory will have a list of symbolic links to
> +<Function Device>. These symbolic links should be created by the user to
> +represent the functions present in the slave device. Only <Function Device>
> +that represents a physical function can be linked to a Controller device.
> +
> +::
> +
> +			 | controllers/
> +				| <Directory: Controller name>/
> +					| <Symbolic Link: Function>
> +			 | functions/
> +				| <Directory: Function driver>/
> +					| <Directory: Function device>/
> +						| vendor_id
> +						| part_id
> +						| bcr
> +						| dcr
> +						| ext_id
> +						| instance_id
> +						| max_read_len
> +						| max_write_len
> +						| vendor_info
> +
> +[1] Documentation/I3C/slave/pci-slave.rst
> diff --git a/Documentation/driver-api/i3c/slave/i3c-slave.rst b/Documentation/driver-api/i3c/slave/i3c-slave.rst
> new file mode 100644
> index 0000000000000..363421241b594
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/slave/i3c-slave.rst
> @@ -0,0 +1,189 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Frank Li <Frank.Li@nxp.com>
> +
> +This document is a guide to use the I3C Slave Framework in order to create
> +slave controller driver, slave function driver, and using configfs
> +interface to bind the function driver to the controller driver.
> +
> +Introduction
> +============
> +
> +Linux has a comprehensive I3C subsystem to support I3C controllers that
> +operates in master mode. The subsystem has capability to scan I3C bus,assign
> +i3c device address, load I3C driver (based on Manufacturer ID, part ID),
> +support other services like hot-join, In-Band Interrupt(IBI).
> +
> +However the I3C controller IP integrated in some SoCs is capable of operating
> +either in Master mode or Slave mode. I3C Slave Framework will add slave mode
> +support in Linux. This will help to run Linux in an slave system which can
> +have a wide variety of use cases from testing or validation, co-processor
> +accelerator, etc.
> +
> +I3C Slave Core
> +=================
> +
> +The I3C Slave Core layer comprises 3 components: the Slave Controller
> +library, the Slave Function library, and the configfs layer to bind the
> +slave function with the slave controller.
> +
> +I3C Slave Controller Library
> +------------------------------------
> +
> +The Controller library provides APIs to be used by the controller that can
> +operate in slave mode. It also provides APIs to be used by function
> +driver/library in order to implement a particular slave function.
> +
> +APIs for the I3C Slave controller Driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This section lists the APIs that the I3C Slave core provides to be used
> +by the I3C controller driver.
> +
> +* devm_i3c_slave_ctrl_create()/i3c_slave_ctrl_create()
> +
> +   The I3C controller driver should implement the following ops:
> +
> +	* set_config: ops to set i3c configuration
> +	* enable: ops to enable controller
> +	* disable: ops to disable controller
> +	* raise_ibi: ops to raise IBI to master controller
> +	* alloc_request: ops to alloc a transfer request
> +	* free_request: ops to free a transfer request
> +	* queue: ops to queue a request to transfer queue
> +	* dequeue: ops to dequeue a request from transfer queue
> +	* cancel_all_reqs: ops to cancel all request from transfer queue
> +        * fifo_status: ops to get fifo status
> +        * fifo_flush: ops to flush hardware fifo
> +	* get_features: ops to get controller supported features
> +
> +   The I3C controller driver can then create a new Controller device by
> +   invoking devm_i3c_slave_ctrl_create()/i3c_slave_ctrl_create().
> +
> +* devm_i3c_slave_ctrl_destroy()/i3c_slave_ctrl_destroy()
> +
> +   The I3C controller driver can destroy the Controller device created by
> +   either devm_i3c_slave_ctrl_create() or i3c_slave_ctrl_create() using
> +   devm_i3c_slave_ctrl_destroy() or i3c_slave_ctrl_destroy().
> +
> +I3C Slave Controller APIs for the I3C Slave Function Driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This section lists the APIs that the I3C Slave core provides to be used
> +by the I3C slave function driver.
> +
> +* i3c_slave_ctrl_set_config()
> +
> +   The I3C slave function driver should use i3c_slave_ctrl_set_config() to
> +   write i3c configuration to the slave controller.
> +
> +* i3c_slave_ctrl_enable()/i3c_slave_ctrl_disable()
> +
> +   The I3C slave function driver should use i3c_slave_ctrl_enable()/
> +   i3c_slave_ctrl_disable() to enable/disable i3c slave controller.
> +
> +* i3c_slave_ctrl_alloc_request()/i3c_slave_ctrl_free_request()
> +
> +   The I3C slave function driver should usei3c_slave_ctrl_alloc_request() /
> +   i3c_slave_ctrl_free_request() to alloc/free a i3c request.
> +
> +* i3c_slave_ctrl_raise_ibi()
> +
> +   The I3C slave function driver should use i3c_slave_ctrl_raise_ibi() to
> +   raise IBI.
> +
> +* i3c_slave_ctrl_queue()/i3c_slave_ctrl_dequeue()
> +
> +   The I3C slave function driver should use i3c_slave_ctrl_queue()/
> +   i3c_slave_ctrl_dequeue(), to queue/dequeue I3C transfer to/from transfer
> +   queue.
> +
> +* i3c_slave_ctrl_get_features()
> +
> +   The I3C slave function driver should use i3c_slave_ctrl_get_features()
> +   to get I3C slave controller supported features.
> +
> +Other I3C Slave Controller APIs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +There are other APIs provided by the Controller library. These are used for
> +binding the I3C Slave Function device with Controlller device. i3c-cfs.c can
> +be used as reference for using these APIs.
> +
> +* i3c_slave_ctrl_get()
> +
> +   Get a reference to the I3C slave controller based on the device name of
> +   the controller.
> +
> +* i3c_slave_ctrl_put()
> +
> +   Release the reference to the I3C slave controller obtained using
> +   i3c_slave_ctrl_get()
> +
> +* i3c_slave_ctrl_add_func()
> +
> +   Add a I3C slave function to a I3C slave controller.
> +
> +* i3c_slave_ctrl_remove_func()
> +
> +   Remove the I3C slave function from I3C slave controller.
> +
> +I3C Slave Function Library
> +----------------------------------
> +
> +The I3C Slave Function library provides APIs to be used by the function driver
> +and the Controller library to provide slave mode functionality.
> +
> +I3C Slave Function APIs for the I3C Slave Function Driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This section lists the APIs that the I3C Slave core provides to be used
> +by the I3C slave function driver.
> +
> +* i3c_slave_func_register_driver()
> +
> +   The I3C Slave Function driver should implement the following ops:
> +	 * bind: ops to perform when a Controller device has been bound to
> +	   Function device
> +	 * unbind: ops to perform when a binding has been lost between a
> +	   Controller device and Function device
> +
> +  The I3C Function driver can then register the I3C Function driver by using
> +  i3c_slave_func_register_driver().
> +
> +* i3c_slave_func_unregister_driver()
> +
> +  The I3C Function driver can unregister the I3C Function driver by using
> +  i3c_epf_unregister_driver().
> +
> +APIs for the I3C Slave Controller Library
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This section lists the APIs that the I3C Slave core provides to be used
> +by the I3C slave controller library.
> +
> +Other I3C Slave APIs
> +~~~~~~~~~~~~~~~~~~~~
> +
> +There are other APIs provided by the Function library. These are used to
> +notify the function driver when the Function device is bound to the EPC device.
> +i3c-cfs.c can be used as reference for using these APIs.
> +
> +* i3c_slave_func_create()
> +
> +   Create a new I3C Function device by passing the name of the I3C EPF device.
> +   This name will be used to bind the Function device to a Function driver.
> +
> +* i3c_slave_func_destroy()
> +
> +   Destroy the created I3C Function device.
> +
> +* i3c_slave_func_bind()
> +
> +   i3c_slave_func_bind() should be invoked when the EPF device has been bound
> +   to a Controller device.
> +
> +* i3c_slave_func_unbind()
> +
> +   i3c_slave_func_unbind() should be invoked when the binding between EPC
> +   device and function device is lost.
> diff --git a/Documentation/driver-api/i3c/slave/i3c-tty-function.rst b/Documentation/driver-api/i3c/slave/i3c-tty-function.rst
> new file mode 100644
> index 0000000000000..3c8521d7aa31a
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/slave/i3c-tty-function.rst
> @@ -0,0 +1,103 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI Test Function
> +=================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> +
> +Traditionally PCI RC has always been validated by using standard
> +PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
> +However with the addition of EP-core in linux kernel, it is possible
> +to configure a PCI controller that can operate in EP mode to work as
> +a test device.
> +
> +The PCI endpoint test device is a virtual device (defined in software)
> +used to test the endpoint functionality and serve as a sample driver
> +for other PCI endpoint devices (to use the EP framework).
> +
> +The PCI endpoint test device has the following registers:
> +
> +	1) PCI_ENDPOINT_TEST_MAGIC
> +	2) PCI_ENDPOINT_TEST_COMMAND
> +	3) PCI_ENDPOINT_TEST_STATUS
> +	4) PCI_ENDPOINT_TEST_SRC_ADDR
> +	5) PCI_ENDPOINT_TEST_DST_ADDR
> +	6) PCI_ENDPOINT_TEST_SIZE
> +	7) PCI_ENDPOINT_TEST_CHECKSUM
> +	8) PCI_ENDPOINT_TEST_IRQ_TYPE
> +	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
> +
> +* PCI_ENDPOINT_TEST_MAGIC
> +
> +This register will be used to test BAR0. A known pattern will be written
> +and read back from MAGIC register to verify BAR0.
> +
> +* PCI_ENDPOINT_TEST_COMMAND
> +
> +This register will be used by the host driver to indicate the function
> +that the endpoint device must perform.
> +
> +========	================================================================
> +Bitfield	Description
> +========	================================================================
> +Bit 0		raise legacy IRQ
> +Bit 1		raise MSI IRQ
> +Bit 2		raise MSI-X IRQ
> +Bit 3		read command (read data from RC buffer)
> +Bit 4		write command (write data to RC buffer)
> +Bit 5		copy command (copy data from one RC buffer to another RC buffer)
> +========	================================================================
> +
> +* PCI_ENDPOINT_TEST_STATUS
> +
> +This register reflects the status of the PCI endpoint device.
> +
> +========	==============================
> +Bitfield	Description
> +========	==============================
> +Bit 0		read success
> +Bit 1		read fail
> +Bit 2		write success
> +Bit 3		write fail
> +Bit 4		copy success
> +Bit 5		copy fail
> +Bit 6		IRQ raised
> +Bit 7		source address is invalid
> +Bit 8		destination address is invalid
> +========	==============================
> +
> +* PCI_ENDPOINT_TEST_SRC_ADDR
> +
> +This register contains the source address (RC buffer address) for the
> +COPY/READ command.
> +
> +* PCI_ENDPOINT_TEST_DST_ADDR
> +
> +This register contains the destination address (RC buffer address) for
> +the COPY/WRITE command.
> +
> +* PCI_ENDPOINT_TEST_IRQ_TYPE
> +
> +This register contains the interrupt type (Legacy/MSI) triggered
> +for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
> +
> +Possible types:
> +
> +======	==
> +Legacy	0
> +MSI	1
> +MSI-X	2
> +======	==
> +
> +* PCI_ENDPOINT_TEST_IRQ_NUMBER
> +
> +This register contains the triggered ID interrupt.
> +
> +Admissible values:
> +
> +======	===========
> +Legacy	0
> +MSI	[1 .. 32]
> +MSI-X	[1 .. 2048]
> +======	===========
> diff --git a/Documentation/driver-api/i3c/slave/i3c-tty-howto.rst b/Documentation/driver-api/i3c/slave/i3c-tty-howto.rst
> new file mode 100644
> index 0000000000000..11c8900fd16f3
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/slave/i3c-tty-howto.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +I3C TTY User Guide
> +===================
> +
> +:Author: Frank Li <Frank.Li@nxp.com>
> +
> +This document is a guide to help users use i3c-slave-tty function driver
> +and i3ctty master driver for testing I3C. The list of steps to be followed in the
> +master side and slave side is given below.
> +
> +Endpoint Device
> +===============
> +
> +Endpoint Controller Devices
> +---------------------------
> +
> +To find the list of slave controller devices in the system::
> +
> +	# ls  /sys/class/i3c_slave/
> +	  44330000.i3c-slave
> +
> +If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
> +
> +	# ls /sys/kernel/config/i3c_slave/controllers/
> +	  44330000.i3c-slave
> +
> +
> +Endpoint Function Drivers
> +-------------------------
> +
> +To find the list of slave function drivers in the system::
> +
> +	# ls /sys/bus/i3c_slave_func/drivers
> +	  tty
> +
> +If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
> +
> +	# ls /sys/kernel/config/i3c_slave/functions
> +	  tty
> +
> +
> +Creating i3c-slave-tty Device
> +----------------------------
> +
> +I3C slave function device can be created using the configfs. To create
> +i3c-slave-tty device, the following commands can be used::
> +
> +	# mount -t configfs none /sys/kernel/config
> +	# cd /sys/kernel/config/i3c_slave/
> +	# mkdir functions/tty/func1
> +
> +The "mkdir func1" above creates the i3c-slave-tty function device that will
> +be probed by i3c tty driver.
> +
> +The I3C slave framework populates the directory with the following
> +configurable fields::
> +
> +	# ls functions/tty/func1
> +	bcr  dcr  ext_id  instance_id  max_read_len  max_write_len
> +	part_id  vendor_id  vendor_info
> +
> +The I3C slave function driver populates these entries with default values
> +when the device is bound to the driver. The i3c-slave-tty driver populates
> +vendorid with 0xffff and interrupt_pin with 0x0001::
> +
> +	# cat functions/tty/func1/vendor_id
> +	  0x0
> +
> +Configuring i3c-slave-tty Device
> +-------------------------------
> +
> +The user can configure the i3c-slave-tty device using configfs entry. In order
> +to change the vendorid, the following commands can be used::
> +
> +	# echo 0x011b > functions/tty/func1/vendor_id
> +	# echo 0x1000 > functions/tty/func1/part_id
> +	# echo 0x6 > functions/tty/t/bcr
> +
> +Binding i3c-slave-tty Device to slave Controller
> +------------------------------------------------
> +
> +In order for the slave function device to be useful, it has to be bound to
> +a I3C slave controller driver. Use the configfs to bind the function
> +device to one of the controller driver present in the system::
> +
> +	# ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-slave/
> +
> +I3C Master Device
> +================
> +
> +Check I3C tty device is probed
> +
> +	# ls /sys/bus/i3c/devices/0-23610000000
> +	0-23610000000:0  bcr  dcr  driver  dynamic_address  hdrcap
> +	modalias  pid  power  subsystem  tty  uevent
> +
> +Using Slave TTY function Device
> +-----------------------------------
> +
> +Host side:
> +	cat /dev/ttyI3C0
> +Slave side
> +	echo abc >/dev/ttyI3C0
> +
> +You will see "abc" show at console.
> +
> +You can use other tty tool to test I3C slave tty device.
> diff --git a/Documentation/driver-api/i3c/slave/index.rst b/Documentation/driver-api/i3c/slave/index.rst
> new file mode 100644
> index 0000000000000..69727ccf985db
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/slave/index.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================
> +I3C Slave Framework
> +======================
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   i3c-slave
> +   i3c-slave-cfs
> +   i3c-tty-howto
> +
> -- 
> 2.34.1
> 
