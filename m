Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BD7EF82C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjKQUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:09:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA9D57;
        Fri, 17 Nov 2023 12:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3qCnPjXwtHauV2tmWFOVOJC9NLrZ8qq6jMIrxUzh5OsPzJN6+eVgPxBcw/E0MDDzMmgDxycGGyT2kuLkUXTV59I4DqcTpmTggowL1sQsTmdi/OzvTQy/SW5EpAGHnwkn27elDWqw9x8HLWfrOaftMTOiVqO9Jy5hIPxhEFmGSEiqr2lIgxSahGuI5ZsvTBZ0rxsqVJsJSgozDp88C9+uf74BHtDpozItKWeUwWKPFZ+KqBTkHFutrbyK7VeTqH9H7yuulBbpd/BVjHSOiezVzw+89zDKqMerWCPGGYvSvNzjD2Az/v/IzvIEJJ50mZMNSmVPcjKdwiZ3sQEJvg0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl4ACIyxG0KEiUe5MFndfeRZy1acSZNFms17dbRD0Zo=;
 b=fJs2CkZTbtQsdnHWuJeJWYpHW2TQbC48usFocJ350ZfK9uhwV95q3X6HUm1JB+gHZlpg4mT+5mbWOA4BdXYKcNxMvvPPCene1RNhgMdDFmuDmtYioAuytMEZOOjvPkn8oK8byEbHYA3W7c7+77MHqCIlI2meUwF1R60vnRkcPyI8VyMasiFqCBSr+fP83RFyaalQl5xWKKPkloA9B35vrxdvFd+ggQOiUFLookDugRmCo2aLaWp1MBomnIWtq3rlPIwU28yEo7oz5nqfbFiy0eVfsH5L4ISwiyYRWCxmTdVCslcIbfWvfNzGvoYvCOblUE73BCbSLwBTGdBv+RZtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl4ACIyxG0KEiUe5MFndfeRZy1acSZNFms17dbRD0Zo=;
 b=MU3aDuJdUpjEbi6qm9dhi8ZoAy4AkevVQZjm/VnLdnJDZujmDPzF1MX17ipXYn6j73lQuj49ZnfyhhhtM3A7Xwi0haelOoEMW6sudxcTSaLnQ4Lkc8/nQDiSsprgwkWa1XMwqgW88xTJDASmVpvpz/l3hU3EqfJSpOLKYMyvhGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 20:09:18 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 20:09:18 +0000
Date:   Fri, 17 Nov 2023 21:09:12 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH] cxl/cdat: Free correct buffer on checksum error
Message-ID: <ZVfIaNhiSc-yQZo5@rric.localdomain>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 86117f81-b4d7-4529-9896-08dbe7a91474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jw1/dI4rlC4afNo8wlyJBsHzwEOAxZQIE04k7tEw8co8FO+ksg7SloUjVYQbTXojz0Ukr4fMPGVkKecRlPiBkzsNcoeLfiSHkVSras0MWrKy/Od89Wcvxu6Mfy/EL69Roza8Hn3NtRXSvXUbdVMJN8n+DgGwAoFd+7d+1OXewoqsNRqgd09iuyUHan2RYxMhI//aRLPRB10ZfeAmkmyNKdkZsMbYl1w5U5ahCF6qLftJ7HJTYcAnaLhIBdrYIwn8jWQZnsMX+/OFcmC7oN41VbkUueoY12O1iBWf8uzRjoXZmiPU51fhnF626nRPyYrKMBQnFSoGw5ckmbPZeck6RGm0Za2Km3YLCmqR5IhJoET/edcOCqbGVX8Bs9aNtgFlm/pin7/Bu4BXYBjUKxTOWu2PJMw+Yt5fEW3DuOs0yOsQ+/Hg3yMmHWYV3UkpfK6Mede1uzrzSpXqFd1pkVnIqvBAWc0DaQraIUQlu1UhujJDR31FhZ/BIhCkaoNfAjAwcF2PYps9S3nSmXsSh9yt4zbUZOL2IcY8+JQstUBV9O9eX8ejpVVHiP6i7UuH47v09FO/bNH7OCu6usvMMS8jz0gfPpOb22A+/m/fCkOAY8ngcCNcb34e17l0F0T3uT6W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(7416002)(2906002)(5660300002)(41300700001)(38100700002)(53546011)(4326008)(6506007)(6666004)(6916009)(316002)(8936002)(8676002)(478600001)(83380400001)(6486002)(9686003)(6512007)(66556008)(66946007)(66476007)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u8bgF3B2W1LF7bEoZaROsNFx3ERurTNGxUzFIQ65P++CsHPY/dw/KInqUEe9?=
 =?us-ascii?Q?4iU/erhWGIuRDe4OztbJeOtPbxPZtRS7Q0r7603/u/sMVwgbd4V+JOEroy6c?=
 =?us-ascii?Q?uamI6wn30E4ZT8HSL+8htYK5OMCPY1gL7pBoLpMCbnP1P+hngGL+p7OBgUZa?=
 =?us-ascii?Q?hMxefmJRgvibf/mbH7hr5qa6dZ4nGjdZdNyerFNakVND+x0fVVf9rJZdVdwL?=
 =?us-ascii?Q?4C1VZj3d4vWmsxE7vBTJKsn+OmDCrYPse1VNyYdbEabf/4f2qG39gFNSjcan?=
 =?us-ascii?Q?ihzz0hLVf3HmGRYVjfuvRe1RxyvRPFJZcMR0PCfr2duhw6Ui5z66PbUZXfQC?=
 =?us-ascii?Q?3C9tCYOnJMe5cmPYnpGfdvzsidsBtF0oXLDoNwLIlMcaURyr+NLFzwRxfWEC?=
 =?us-ascii?Q?HbkPdqoFXZnKWTw6kxll+fNdFxPGPsZifpyvCbRx+mJAyZblVpgq+uNKYdT+?=
 =?us-ascii?Q?NQAmLlTwqnCYX+ZDTheDOwe1U/gLhiczkjkpHJ2dhEVYHFfvmOgygxMqwu6t?=
 =?us-ascii?Q?PWGmXBIBIzqLGaopIXpHDyXumdK7iJ/rW3C4xwL7/es2ioivTVhgIvq5QQRr?=
 =?us-ascii?Q?1KOWMxUoQuI5EZlgQTB0S/2KtsWtR18YG+UsS9XGu2XUJzBwQLG0/swnRj7c?=
 =?us-ascii?Q?C8H81bMTivtnl2tHR/t2jaS+AzPlc0TA6Ji6uG4Nm+yJKR9zf/itMFWifA2R?=
 =?us-ascii?Q?0mj73g08Gs2/0V2TNQz0k68V3aM6BfgJQBspxYqp34TJ3p2yjJK7ZmqUro6k?=
 =?us-ascii?Q?1jkLnlFTTw2qMxtfLQH1X56W3j5iIMGEb2ylD6SfbVfOZlqBYWDEYqaVXOSN?=
 =?us-ascii?Q?MPS+8lciKvxeZE4vG9qjckGJBxdQc5F7JeD7PEh8D8lzTowVOkfcEH0lyi4G?=
 =?us-ascii?Q?xD8G2KCRhpdDbn7+SCiqShd4Y12plZJ8ixnlSaNhRTSwl/E2CDTMQD580mqK?=
 =?us-ascii?Q?vhdqgdAeyE52yeDgN6HX2ghG8cjefPXwJSlULXM4Y5c2fr9zrDdNJkbWAxs8?=
 =?us-ascii?Q?Pqx8EGGZOHPDeKv2KXwz3ROEV6hcME3gWhaKTvYHeZd9dAx3wW5QPCPHHKBo?=
 =?us-ascii?Q?uIQ4DWvXBXp1USnhkpHnjAIS8NfojTRAwf7OU6yVwWvXdrzSo+yD2PyVFtn7?=
 =?us-ascii?Q?5DT61wat6elfJeTx/Khj02Ab/HFpld+Hla5jlBnc6LpdGpWrSXJ23ryJR2CK?=
 =?us-ascii?Q?Q7CAR7F40CH/+tpNfIZVT+l1oqSebWt0qGnbTgtSDc4S43yKjhkUy43rCVOH?=
 =?us-ascii?Q?7LCWDJL/AMGT+stLeETuf56jqsJeFDRUOua0w58WUEswLY1o2WUyJUKOKb1m?=
 =?us-ascii?Q?VJBooHFW9DL67GtQmFIHO0j1FBRZS3l1oCBgR4IfrtrZJ/y2EdiBTo68rEkv?=
 =?us-ascii?Q?qKm61OzISx2VyFXtrL/d0AF9QM0YDSEGcgbgtsHU1izAXp21xlyagjN0iiO0?=
 =?us-ascii?Q?eooQJ4a1xkU654KkQUuAygDmEtqEw7ZvvbScRQ+d67PdllPmwagcN01JrhDG?=
 =?us-ascii?Q?sUwvgdMy14N6ji/s1kYwuT34bVPF0L9AgeK+tt11j8ULIr+90+qOFo4pgU1+?=
 =?us-ascii?Q?B0HHiO+zGnvqrYY6JlF3sDI1MN79BD95hpoTzDCT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86117f81-b4d7-4529-9896-08dbe7a91474
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 20:09:18.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzyA+1XCyVJXTs1fVMcHY4EdsSfApSweD/LZrfQawd2W4AsFhL8w/D3B0lzXKh9pTxqOujmhpIcBjl+V8Nyj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 16:03:29, Ira Weiny wrote:
> The new 6.7-rc1 kernel now checks the checksum on CDAT data.  While
> using a branch of Fan's DCD qemu work (and specifying DCD devices), the
> following splat was observed.
> 
> 	WARNING: CPU: 1 PID: 1384 at drivers/base/devres.c:1064 devm_kfree+0x4f/0x60
> 	...
> 	RIP: 0010:devm_kfree+0x4f/0x60
> 	...
>  	? devm_kfree+0x4f/0x60
>  	read_cdat_data+0x1a0/0x2a0 [cxl_core]
>  	cxl_port_probe+0xdf/0x200 [cxl_port]
> 	...
> 
> The issue in qemu is still unknown but the spat is a straight forward
> bug in the CDAT checksum processing code.  Use a CDAT buffer variable to
> ensure the devm_free() works correctly on error.
> 
> Cc: jonathan.cameron@huawei.com
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Fixes: 670e4e88f3b1 ("cxl: Add checksum verification to CDAT from CXL")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

I will send an on-top patch for 6.8 that reworks that code area to
remove the pointer arithmetic.

-Robert
