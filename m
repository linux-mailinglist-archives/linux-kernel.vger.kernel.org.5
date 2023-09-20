Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7C7A7585
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjITINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjITIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:12:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC852AF;
        Wed, 20 Sep 2023 01:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1insXHOI5sidCgbqJkWBAvusTIbgQzQPrdsL9rId5Z/F+cv7u5wED3qe982WafxsRvaLpQF2hwk9ZEB62nPnABhJcy0AEIvxPz1V4hrM+MCqsuAImnwUBBbAxANa97KnjGAm8g2yiS2lI9ej4Y+eL8TsT2BkgwkUuNEXjaAeHNneGlZRWD+qMoq93+jiHawD+9g9ajflXqUwKj3glJNwjKOkNz9qo5iVR6z2l+Dvs1sG9VVt+lvaJlMPka0s1Pvpjk0DCeJJThM8j2th+3FHTPXU2YtRv8/wJbwLmwjqkCJaZSIORNwCtFboacVWMHMIbZ0EPT3NtEWzWZlCDxwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z42GGT81J/3/yz7Xlnb+SAvZqNoMs4EQ8nfpfl6c6Dk=;
 b=kPQQfpseaYY+q7YypFcL4N8amY41xU0vfvijfWJCvF5SdHfmFvYyA20xTIB600hp97h2012rQ21loRt9tYlpBfpZqXOtggUWmXG2cVzURLavbbF4K5tUkvH5lzRrSLd7QtBwoip8Gp8wpddv0G8V66hyiIEyBWPRJi/REzKWoyt1CkNVhr1FsqK3H+2fLGgIImD9R+kMDdkoQxWsMSKohdGDZdqksLwvYIxvpc1MgJ2U0v52B3oyRE1HLXY+sSOD1gJ4MeZqvDV9RI1L2XbNPKS12BsT9gxhK0UBSPbDMQZg66ao9EfgaTrlIbpR/ek4ZDN9zbTWriHgpT5pIk6rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z42GGT81J/3/yz7Xlnb+SAvZqNoMs4EQ8nfpfl6c6Dk=;
 b=ZKA7T+CJM4xa0AKlmjvy9tY/v5WQ2JgrgmSI8kunS60gFn2bSBDkEE4J2A0a5b+XT59JSyYxifAyiyhy793trdEZN4/JOo36EZDv07zU6Np/kDdXtOmQ0e+XZS8GbowDCFvE+fi62mIFPvnRV7/RE5xia2A+zY7F0P1fafz52Wn0ZcVOVa2fO9fETvoLNVEtZZISEG+k2vp8wy+9sV2iO+OlG9Qpg2KTyq5t7YOH2RCsRfzB2Nh0/jncRoBu9FoiNH/KYOLuhHDH8T+B1MjEZbeJ7b6RHOeBVLfgj2p5/9AajPoeqLC6FoCk5DJTCCV6rb3e4LsV2a0WlzDfjkC1zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 08:12:38 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:12:38 +0000
Date:   Wed, 20 Sep 2023 11:12:29 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1] thermal: core: Drop trips_disabled bitmask
Message-ID: <ZQqpbSYsUdAZrcrT@shredder>
References: <12296181.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12296181.O9o76ZdvQC@kreacher>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1be4be-3ca5-47a8-5132-08dbb9b15a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5CNr+L8snVwd561DNt0O1k2wbsbS9WXWM59isOrpRvAgEYNJ2qIGHxTkkc6Z4ANPx5eExkdxaP5sLRV+qYaqAZPiirkny+gCNLA7ySw6Ygb48MC6zZpSrladxRMYqwxZSiRIEYOgss0QmqZb3eGj7EjdzKEYcA96nkrMQxfqHqckrtBnvvtoF01kQ6FCEfaEY82AyphjnNWMFLTbj8A9vaqCxjgk2sfnU0SK+S2B50+Ak4Lr1MhjSnHZ9SyQl9s7tQ0CYA7Nzk+/HQWFkWlH304htX5qWG2Pen6W5Rg5354NBouXXK+AV1KVypOIpeC4U/jBzsaqmyWbV7CySwB3OyUZOCqhM1MZ1WVi+E2NrqUgg4wa8J8Ckgdewj6jhAAQdY83T7Npt1jcf96t/sxHP3iTnJL8Ljm1MoONUZLjqVu/5t7joZcW5EaJQaz32uPtSZr8EbPiH9li5k/ASf2fWalrcrenhK08TIesVqaHbua5Qiyuct+b1owgB1HxATTZzm3tmrq910cOBLrDgcBvChvWXZzCFRGyiDcwSX7yr72ifTh7xYtEGWsxWsLSEkA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(26005)(8676002)(8936002)(4326008)(83380400001)(2906002)(33716001)(86362001)(6506007)(6486002)(478600001)(5660300002)(6916009)(6666004)(316002)(54906003)(6512007)(66946007)(66556008)(41300700001)(38100700002)(66476007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0mXbhcA9aHQP6jhFF68hRs+nlD7TqSyTW3yFmfyT/GuTLayuaqqb2t5ftxX?=
 =?us-ascii?Q?2IvlTYHBLTNuhmwaCgnYZ+fdTONLdXoCuy/kUI7INyibPwSNPMa48fBdTL0D?=
 =?us-ascii?Q?R7JXN/hu+xZKOgaCH7X4OOH3MBnQNGLk7DhqkrRC3clJhhnbYV5gWvZsRw/1?=
 =?us-ascii?Q?gn0tsyooA2JUz02i1yPWSDbRIt2JLgL3rwM0eQS27VY68If5c6sUsE8Rr0KH?=
 =?us-ascii?Q?mbYMwJKVjzvZqY+2FVGTYhx2My2pj3lqeT3RdI++WJC0NVpr89Czyt+V+jeL?=
 =?us-ascii?Q?OFdY6W4Ngwh8+uf8rbuyuAevZFPaEWobroJ2RNoo0+ICMogx9z7I9L0lP218?=
 =?us-ascii?Q?w5ukm9MCZUtnYLAgOouL+zfa0+Ab7ilCxMhEPq8Fg6W/UmeX+GOJw+PfLsce?=
 =?us-ascii?Q?bUQj/FwvwoJKEjwyCtoYWz7KgiOkC3mPS/mbruOR7IqNqhi/3lwXjPGcjerf?=
 =?us-ascii?Q?RIxzb4rri5NMr9Bqj+LVWUwT22o5F1Spx2NnSxdWIn00jTNH4DLSiKi5t44R?=
 =?us-ascii?Q?3jubFRut7nV2hqOpPO+2ewrz3N3oZG+irTdA9UwdSdbUasyox/WMIC/tLCsl?=
 =?us-ascii?Q?fw0pfhwjklyn3XA328DTDsve8/xtuJOlSCYYY+PPvKT3NOxPu6xfmu/xu/nh?=
 =?us-ascii?Q?03wdEo1snK6QA7qtNPXIV2QjmfWKc8Leh5r5vDB3HOVG7p9pHLFFcxMpRHAD?=
 =?us-ascii?Q?DQ+2JpiXLpS/JKPrb7sDvHhRzRefHtDXj17Qhiv6CaJlLhedRRIhBloxtUYp?=
 =?us-ascii?Q?ftTsw6yGbLcqEa+AgKGOB9xA5eNJsz/jbB/BGgTedlov2bbuF2xAn2jNDt/i?=
 =?us-ascii?Q?JLl4miXIAUWgRyZELy5pavf2cKY/cq2yRd3oe7rD7gDxHEQDCV/Vqz3GWSzf?=
 =?us-ascii?Q?lYdMPclaJd34lGKEwZXKYg61t2jZ6YpdxVB/zm2Qnhl47iZzuMVr/plB1urx?=
 =?us-ascii?Q?7m+W90erfQlETeFTDS+E9ecHdJIVCLrQdDlM4UGCYnGwGScpUDuhWSlvHZch?=
 =?us-ascii?Q?moUGjUlhqvaJCreLKQNv+MYwNtwFbFdySqEgWCO2+wHEIovLd0OUsNLCnF3n?=
 =?us-ascii?Q?IACkQqKLcgYItXLIspDzIooVzlMwebmfFXsVBdFNuDNpCgUHN/d/UrQqqN7A?=
 =?us-ascii?Q?SRsZbqe4mmK/EW99TtKa8+RlTM4n7whTVcGJwPQTkMRylEyQmU1GOVeKr/cT?=
 =?us-ascii?Q?rJLC9mwgjRt9pohmx6oUtswUg97usGSy1OvVTgG//CYHAcV5fOGxoMfI5W0y?=
 =?us-ascii?Q?ZQqggRRe5ZpuwtIRlYzSCRDBGZMda4Tt9Ez2rc32QA+1W47QhOtFr+AG+1j/?=
 =?us-ascii?Q?3j+pPXcVYJqpFIxds4WWPTbHKSvCRJDHihhQadfnmQiU9oJJ5/OhI2dUTnFz?=
 =?us-ascii?Q?hcYrf0jPJiI06vjf6fCGQr5YDArn6dRzuqS0X9PJT3w0eVRF5V36VaONlp0i?=
 =?us-ascii?Q?o+BOOxeG3c7LNppQNw6Klwqc1gk85kaLU23PFqYlZTfjJYvW2sHU//14yEJN?=
 =?us-ascii?Q?cP6G2SHE1SzzzIW/cGTXSLJnt7iImLmvICw2QXQkr2NjBaExbK4xycorhBcl?=
 =?us-ascii?Q?ypTQ6hU4D5CIdQh3SpxRt52mNGsGsjwImZmglF0W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1be4be-3ca5-47a8-5132-08dbb9b15a5c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:12:38.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5kc9bhAXnrE3ASz/fs2z5mu40lDZJo8EkQYvUsb204lFgrjdv/uBG0r8bMMiJlLCETMpbao4X80Dg5YVXveTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:54:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, thermal_zone_get_trip() cannot fail, as invoked
> from thermal_zone_device_register_with_trips(), so the only role of
> the trips_disabled bitmask is struct thermal_zone_device is to make
> handle_thermal_trip() skip trip points whose temperature was initially
> zero.  However, since the unit of temperature in the thermal core is
> millicelsius, zero may very well be a valid temperature value at least
> in some usage scenarios and the trip temperature may as well change
> later.  Thus there is no reason to permanently disable trip points
> with initial temperature equal to zero.
> 
> Accordingly, drop the trips_disabled bitmask along with the code
> related to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I guess I was copied because of commit f1b80a3878b2 ("thermal: core:
Restore behavior regarding invalid trip points"). Since then we stopped
relying on this behavior with commit 5601ef91fba8 ("mlxsw: core_thermal:
Use static trip points for transceiver modules").

Tested your patch and didn't see any regressions:

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks
