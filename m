Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211817DA3C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjJ0WzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjJ0WzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:55:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95D10E2;
        Fri, 27 Oct 2023 15:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4CCKY+GyhGDhfriPtx5ndFGTjCXDIzBAi+BZ4+bQhydZ8dJJReSeQrg3EyPRzdJ8ivky5jefJBCCzFPAbxydWHCfPoasmxrZB6lMtw+ZYoJ2GC9WI0tMXYB00QwMt6lRskJ56Ye2jdAYnCdOMZ7PioMMBlmhHfH4HOfcd9vWCb+LyKHZU9ii4c6ePK9vFkmcFlFa+0dtQ41AWqW9cx73RPGcDg/AH8/Z1Hi+INXFQmgLWaQ4S/qo2pCOjzr3DnPUO6ykRkOocQ6LHBzM5hcatXNZAFxcX6MKcRtjNJXwji8hoCuddsghdTaDMSoe0Cw/mqfUb6H9OtFSRtz5P9bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4HK5ZbtNowELZ798ixidKEsYtaRya4EmOQE6JzDLB4=;
 b=WEYSKWpf40liUGk8YY0xC6Mv/qi/y4BUPtWiFPEvHKtOFbyVBSlkK7xKVqn6qFN/VKBSnodNHyIx40QUVEEHk1kXhG3c1jNz5520GFBjreiu2vnBge9otG6yfUtuxtguF2UGwHoHGeHOsbG9mFpeInodxrN1WJvPoip9rX3h8TY5U7UR2NUn7zrOm7mxC4fgCpLfX12SPZtclESznKb3Zwj2b/gsDQa9C/6cHOCB1yDgHzOIoBHv4TMYqubjWvkqiR3GqWv35wu8KNRCIZoQctZ4imH3bvCGiT0vO080G1tldq7oPOUB0D61BAXZ7KAmdvRh80AQTno35RuelS3nFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4HK5ZbtNowELZ798ixidKEsYtaRya4EmOQE6JzDLB4=;
 b=D3Ot6Whziy6G0WC49GDTxwPUWT03xfUodHRrGhfMDTVcMNArHGSw2TSwYAGYp7RsDAJEE65KsBGtshqKnNCith0V4SMqzuCZqp0JOL72cIRmS2t+xN++ka62MgzaBiBWTi1pCfxNsBJH4aGT1atduIuA32X+rGJTiSiUQ+9ljkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 22:55:08 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::302f:131b:a9e1:7751%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 22:55:07 +0000
Date:   Sat, 28 Oct 2023 00:55:01 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <ZTw_xd2_uaApAzoL@rric.localdomain>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-2-rrichter@amd.com>
 <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 0908dc7a-12ba-4824-50f9-08dbd73fc3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B5aL8t9IN3vgaUXPq9NAG1lDphDwFAYPUmysinA9KuVAqiwSxIMDSdJ19Yk8md14jcI6kGEX9JzSzfYyPls4eqIo7dJEMexzZg5POQxtFNAa66DMHaeMGNHmSP7Dp7GyulH5GrknR27qXmp/1Xt13aCnT+Nb23Hx1vXQSH6LXtNndr0xJpqDr5rAeRThMcrtw2vbNAmzOmCzM40foJpxOeSE4m64EbD63SwH2X+LOcrZ0hPAOj+UaBz49j9q9f8UL+oz65aR7VZ4ulyvxaW/5bAFHOJcNN1RcLZlodztf5aajBueX1lkdCkcr5E0eistLwIiCS60Q+c1AfjBfX6g2ce+0H892FTksGfoukih9NK+ULFQPXjvgDCGPdiqDq0LAnLf0RBixz1m5lH5frX9ZCOfi9Smnc6u62o0IZV0UVlr4CHvZprO7ASiN3+GCiGXHDm8wuoNmSKP5zE3J1f2LOoxtc0yhe5oic1jKy+/Cu22k3H/qkAEdhxq6XzjuOOxXYNA/a49Z9W9BCk2wqGhTJJKzX+yoTbmIH3RAqW9fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(66476007)(5660300002)(7416002)(41300700001)(4326008)(8676002)(8936002)(83380400001)(6506007)(38100700002)(6916009)(54906003)(66946007)(6666004)(316002)(66556008)(26005)(9686003)(53546011)(6512007)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJvMWPOG8u9X+PrmfZAjkg+VUkowxJV9K9AVBy+LM3udT256R9aJzXXRPT2x?=
 =?us-ascii?Q?Inlt/JfAWUecuTXV673vd1LAYGEd/zMCp1TuoNVAlQoTKsuKAAekN3QrVxfo?=
 =?us-ascii?Q?L8g076mHwTBUu9XJ5staMVFMgQndWUInRUWQ3xOP7Oy71GP0C0iyT9106S4L?=
 =?us-ascii?Q?dffKbj6lU7CSYL837ZoGVPfLRhenXPBviAU6vDSSiui3P9gw6Z6XHyor4pwo?=
 =?us-ascii?Q?3lkSuM+owi63FBRMjTAJ2XuqpDycxRqbyo1IDAjR6QSjA4q9ir4RSebG6jTR?=
 =?us-ascii?Q?1AcAewQV62II8TCjhkMno2O4rGEM5Pjp9lMJR7usr2bOtNM1ao6q/c528fEZ?=
 =?us-ascii?Q?2NMkcVAOXtqBmz3ed0woT8Th5FeaSA3JHSPGKyeb7Jahpq82lLc56ZndNgXO?=
 =?us-ascii?Q?QdEiGN4Ix0XSQUsEgfOAclxhUBbrBJT1TGdoVEqRqmzisqC2xB6ptE+3let0?=
 =?us-ascii?Q?VIsaKd2/BxuM7BlqiXNSvBjiXnLVvg+12gahGdCk4kPWPA5K1CY8Ysa8D0N7?=
 =?us-ascii?Q?Uz449W/T8VtRK4Jc9F0W2v4g4MX+RNX/OrIQMFKJFtHFNGGUHzF9Y1fg3VOn?=
 =?us-ascii?Q?nL2riFr8+PKJZEsQ+9szI4Srs3/LPNV3tiOa9gytJopuSlcfjyHZ6t/Lxp+2?=
 =?us-ascii?Q?MckzVmyD7rrUX6UDMEjqDhhTQZReLpMl8aLMfseUzHpeCU8PumdSKP/Qo+nQ?=
 =?us-ascii?Q?PtAjzwEDVCqOOfdGlGc3aXawERQE1iLi0T50pLirdDFPisgo5UR7ZUp74uPh?=
 =?us-ascii?Q?x1zFiPc+GYesGLNRVP8AxR+WcIxFNCnI5suYQVY18oaGGIHzDWyJSLQkLe5T?=
 =?us-ascii?Q?NA+/ot404xPkhSrp516tZSh/3cEz7eMEP2ZqUC6if6a6yNrGYr592uC29XXv?=
 =?us-ascii?Q?Ojq4IDhFSA0sh4vZh2DKrgb3uuIg6GPKSWBrRbXdJdJ94NM52eZrM25Kj14f?=
 =?us-ascii?Q?FapCswx6MiIZHzvp/L28nFjaKAdj5wjls2umfgF1wBCVcKqbO3ohOXH8EpGY?=
 =?us-ascii?Q?YRfz13ze0xvqIUH9jmSOmuGhz1go5ODjeuikmXUphXgZXjWhzKvDfFHl+gDe?=
 =?us-ascii?Q?DZgKaGPIzlHQKs3ySs/5+3QVSMi+/27Mliz/mGKfqSynLyfhCDh766g9TiRk?=
 =?us-ascii?Q?I1w/IsBDjT0wSnVaOdqKTPJ+eKPkcMlweMgHqKcpUnONs7T/Z6cTg7luBhZv?=
 =?us-ascii?Q?Z0xx/XTqOx9Aomq9s8oj7YGpgTIL+hFbw3fnMofVdHrz3QboKgaNl9ZG9Aue?=
 =?us-ascii?Q?o6SsFpHuvsyUjW0leARe7ejQPG24zdc9l0wOIIN7hh05nUbFZfyTQUrrH4Ky?=
 =?us-ascii?Q?XvvM643UJ6LUvBGO4JIw8T4rxfRLDJnviHfcs7HM0LBg/waYwWWXd0KvPb4I?=
 =?us-ascii?Q?urIVmZnVWgPi6hB8FidJvvBnqBD6aVCBgKI881vVS9i7qXlLAW9i6wQ7f+Ok?=
 =?us-ascii?Q?Vefxn8meqnmQnhky8ePE/PElKPZ9jZWwaG3QhieX3SZbDhIrP4dXLc6Be0Uu?=
 =?us-ascii?Q?TkDSX1qEC4xBOBaJJisK9K2bmU5BvtWHPxwCCrDFB7n1pyEAGO8Eh+zF0AbK?=
 =?us-ascii?Q?8UrcanmyKM2PCb2HR/rSacotfC9AJpgnEGPgIV8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0908dc7a-12ba-4824-50f9-08dbd73fc3ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:55:07.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC8c5IVYyjoJR/+H0UWQjT8Gf0bUUCvRRGDvDPQi4H7OUmCJhaI43stuSN7nE/7j5+UG3N3n4phS6/sy8kcTDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 26.10.23 20:46:33, Dan Williams wrote:
> Robert Richter wrote:
> > Binding and unbindind RCD endpoints (e.g. mem0 device) caused the
> > corresponding endpoint not being released. Reason for that is the
> > wrong port discovered for RCD endpoints. See cxl_mem_probe() for
> > proper endpoint parent detection. Fix delete_endpoint() respectively.
> > 
> > Fixes: 0a19bfc8de93 ("cxl/port: Add RCD endpoint port enumeration")
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This patch causes cxl-topology.sh to crash with use-after-free
> signatures. I notice that this path should just be using
> endpoint->dev.parent and is missing reference counting on the parent.
> 
> I will replace this path with the following:
> 
> -- >8 --
> Subject: cxl/port: Fix delete_endpoint() vs parent unregistration race
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL subsystem, at cxl_mem ->probe() time, establishes a lineage of
> ports (struct cxl_port objects) between an endpoint and the root of a
> CXL topology. Each port including the endpoint port is attached to the
> cxl_port driver.
> 
> Given that setup it follows that when either any port in that lineage
> goes through a cxl_port ->remove() event, or the memdev goes through a
> cxl_mem ->remove() event. The hierarchy below the removed port, or the
> entire hierarchy if the memdev is removed needs to come down.
> 
> The delete_endpoint() callback is careful to check whether it is being
> called to tear down the hierarchy, or if it is only being called to
> teardown the memdev because an ancestor port is going through
> ->remove().
> 
> That care needs to take the device_lock() of the endpoint's parent.
> Which requires 2 bugs to be fixed:
> 
> 1/ A reference on the parent is needed to prevent use-after-free
>    scenarios like this signature:
> 
>     BUG: spinlock bad magic on CPU#0, kworker/u56:0/11
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
>     Workqueue: cxl_port detach_memdev [cxl_core]
>     RIP: 0010:spin_bug+0x65/0xa0
>     Call Trace:
>       do_raw_spin_lock+0x69/0xa0
>      __mutex_lock+0x695/0xb80
>      delete_endpoint+0xad/0x150 [cxl_core]
>      devres_release_all+0xb8/0x110
>      device_unbind_cleanup+0xe/0x70
>      device_release_driver_internal+0x1d2/0x210
>      detach_memdev+0x15/0x20 [cxl_core]
>      process_one_work+0x1e3/0x4c0
>      worker_thread+0x1dd/0x3d0
> 
> 2/ In the case of RCH topologies, the parent device that needs to be
>    locked is not always @port->dev as returned by cxl_mem_find_port(), use
>    endpoint->dev.parent instead.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Cc: <stable@vger.kernel.org>
> Reported-by: Robert Richter <rrichter@amd.com>
> Closes: http://lore.kernel.org/r/20231018171713.1883517-2-rrichter@amd.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I have tested your patch.

Still the endpoints are not properly released after unbinding/binding
mem0:

root@onyx7628host:~# find /sys/devices/ -name uport -ls
   258978      0 lrwxrwxrwx   1 root     root            0 Oct 27 21:27 /sys/devices/platform/ACPI0017:00/root0/endpoint1/uport -> ../../../../pci0000:7f/0000:7f:00.0/mem0
   258553      0 lrwxrwxrwx   1 root     root            0 Oct 27 21:27 /sys/devices/platform/ACPI0017:00/root0/uport -> ../../ACPI0017:00
   259363      0 lrwxrwxrwx   1 root     root            0 Oct 27 21:27 /sys/devices/platform/ACPI0017:00/root0/endpoint2/uport -> ../../../../pci0000:7f/0000:7f:00.0/mem0

Here the DEVRES logs:

[   47.756076] cxl_acpi ACPI0017:00: DEVRES ADD 00000000b864173a cxl_acpi_lock_reset_class (16 bytes)
[   47.776194] cxl_acpi ACPI0017:00: DEVRES ADD 00000000f2889cb8 devm_kzalloc_release (64 bytes)
[   47.795361] cxl_acpi ACPI0017:00: DEVRES ADD 00000000456b3844 unregister_port (16 bytes)
[   47.813519] cxl_acpi ACPI0017:00: DEVRES ADD 00000000c531ceef cxl_unlink_uport (16 bytes)
[   47.868008] cxl_acpi ACPI0017:00: DEVRES ADD 0000000034c233ab devm_kzalloc_release (160 bytes)
[   47.979283] cxl_acpi ACPI0017:00: DEVRES ADD 0000000028cfab8c cxl_dport_remove (16 bytes)
[   47.997641] cxl_acpi ACPI0017:00: DEVRES ADD 00000000fce74ad0 cxl_dport_unlink (16 bytes)
[   48.026608] cxl_acpi ACPI0017:00: DEVRES ADD 0000000087096c98 remove_cxl_resources (16 bytes)
[   48.467055] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000439965a5 pcim_release (8 bytes)
[   48.492875] cxl_pci 0000:7f:00.0: DEVRES ADD 000000000352019d devm_kzalloc_release (688 bytes)
[   48.593561] cxl_pci 0000:7f:00.0: DEVRES ADD 0000000093b19b3d devm_region_release (24 bytes)
[   48.612509] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000f2a2b9ff devm_ioremap_release (8 bytes)
[   48.631460] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000a4df0705 devm_region_release (24 bytes)
[   48.650416] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000a35318c5 devm_ioremap_release (8 bytes)
[   48.669359] cxl_pci 0000:7f:00.0: DEVRES ADD 000000000411c084 devm_region_release (24 bytes)
[   48.688302] cxl_pci 0000:7f:00.0: DEVRES ADD 000000003c2ff619 devm_ioremap_release (8 bytes)
[   48.851787] cxl_pci 0000:7f:00.0: DEVRES ADD 0000000092a86a29 devm_region_release (24 bytes)
[   48.918272] cxl_pci 0000:7f:00.0: DEVRES ADD 0000000029f3d56b devm_ioremap_release (8 bytes)
[   48.943092] cxl_pci 0000:7f:00.0: DEVRES ADD 000000003a7c75bf devm_attr_group_remove (8 bytes)
[   48.962428] cxl_pci 0000:7f:00.0: DEVRES ADD 0000000038e85a6f msi_device_data_release (104 bytes)
[   48.991467] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000fb668702 pcim_msi_release (16 bytes)
[   49.433956] cxl_pci 0000:7f:00.0: DEVRES ADD 00000000ceeb66f6 put_sanitize (16 bytes)
[   49.458405] cxl_pci 0000:7f:00.0: DEVRES ADD 000000000732acf5 cxl_memdev_unregister (16 bytes)
[   49.477751] cxl_pci 0000:7f:00.0: DEVRES ADD 0000000062830d65 free_event_buf (16 bytes)
[   50.641360] cxl_mem mem0: DEVRES ADD 0000000053ef2f50 devm_kzalloc_release (16 bytes)
[   50.658961] cxl_mem mem0: DEVRES ADD 00000000fba70c16 remove_debugfs (16 bytes)
[   50.783295] cxl_port endpoint1: DEVRES ADD 00000000adbc4e00 devm_kzalloc_release (104 bytes)
[   50.819057] cxl_port endpoint1: DEVRES ADD 000000000cad4cbf schedule_detach (16 bytes)
[   50.845695] cxl_acpi ACPI0017:00: DEVRES ADD 00000000bd0ee305 unregister_port (16 bytes)
[   50.863853] cxl_acpi ACPI0017:00: DEVRES ADD 0000000093e8b578 cxl_unlink_uport (16 bytes)
[   50.882224] cxl_acpi ACPI0017:00: DEVRES ADD 00000000afea8cbc cxl_unlink_parent_dport (16 bytes)
[   50.921823] cxl_mem mem0: DEVRES ADD 00000000acbd776c delete_endpoint (16 bytes)
[   50.938423] cxl_mem mem0: DEVRES ADD 00000000c504d947 enable_suspend (16 bytes)
[ 1187.191399] cxl_mem mem0: DEVRES REL 00000000c504d947 enable_suspend (16 bytes)
[ 1187.207813] cxl_mem mem0: DEVRES REL 00000000acbd776c delete_endpoint (16 bytes)
[ 1187.224426] cxl_mem mem0: DEVRES REL 00000000fba70c16 remove_debugfs (16 bytes)
[ 1187.240845] cxl_mem mem0: DEVRES REL 0000000053ef2f50 devm_kzalloc_release (16 bytes)
[ 1194.935890] cxl_mem mem0: DEVRES ADD 0000000049747689 devm_kzalloc_release (16 bytes)
[ 1194.953479] cxl_mem mem0: DEVRES ADD 0000000025dc7c28 remove_debugfs (16 bytes)
[ 1195.085016] cxl_port endpoint2: DEVRES ADD 00000000777769c7 devm_kzalloc_release (104 bytes)
[ 1195.135858] cxl_port endpoint2: DEVRES ADD 000000007b7aea26 schedule_detach (16 bytes)
[ 1195.162482] cxl_acpi ACPI0017:00: DEVRES ADD 00000000499f1a7a unregister_port (16 bytes)
[ 1195.180650] cxl_acpi ACPI0017:00: DEVRES ADD 0000000065d85ed8 cxl_unlink_uport (16 bytes)
[ 1195.199010] cxl_acpi ACPI0017:00: DEVRES ADD 000000003b0c1f03 cxl_unlink_parent_dport (16 bytes)
[ 1195.229479] cxl_mem mem0: DEVRES ADD 000000009973885e delete_endpoint (16 bytes)
[ 1195.246100] cxl_mem mem0: DEVRES ADD 00000000512c0cc7 enable_suspend (16 bytes)

delete_endpoint() is called here, but the uport etc. is not unbound.
Which means this is not true:

	if (parent->driver && !endpoint->dead) {
		...

I don't remember this with my patch. The parent is there different, so
that could be the reason.

I could not yet look into more detail but wanted to let you know. Will
continue.

Thanks,

-Robert
