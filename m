Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C07D1938
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJTWgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJTWgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:36:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53219E;
        Fri, 20 Oct 2023 15:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgRH63/KyvYi0sx8jEQNAca/6iu7gOWJwDii59G+0HEG0Y2m1wc2JZfo6o15DMELNEzNfBgNEdOdfDLkfAup1zGIXcr07QDn1+STBleaB8MeBis/Y0bpl3H4dY9GSTr+PaN2Vn4TVa6FbRI8Y5GXw7MlZjgvdDVzn0m/yn19zKnUcmGprPHXubTlk4DoIlFDuasKEyMTSnlat382U6po1lgaP8urlahmxFmz6IWVj0VPEVJpGc5kasPkTlix31BjZ3VTwJYhOZrE7qsketj/6IK4++/7S5GYhrU3KeyAoyaCtAAHDEcTwZDxaOaKXtSrFrkTD0/+LawZRunBllEzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vvBu3zF4ozbBpyzGxZfrcwbNPXq3veibqGamDvg9bc=;
 b=JT0TVE3sOIHNFa76YAJHrmGYQq2UrIgXt6C7Xn8KifKYOQSWSG95BASGiWBNlkx57i6Boq3/vQS6A6EYtAjzGXFZGK9B2KXiENENvHIp9ryU3ckg9RATQZzKcOETNBKtoQLhQcTzygHckcrILLMegmm+uTL4IT4B6MNC+88ekRgNlzJHNFMD+FrBDqTS9X30fziPk3g80XKk7IBtYGHLFTPfU9Dbztw3JtIDHAFvGKaqW6iw5PaIQDBqn0kCja2TzZWENYi3x9ImDqh4HAQxc7tssrx9B1GqA7GMkrktA5A+ej6zZl9YEyqnbgeuicc6ZdVLkGBBfMg/bu9GM6PNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vvBu3zF4ozbBpyzGxZfrcwbNPXq3veibqGamDvg9bc=;
 b=GCGZBAiV3s87GjX4IG1/iQb0E1bhqnf00Z9/viYKK6GdlHoSZtMem6x81r46n+vbCvMqExnuM4P3TI+wi6iS4MULNDo89G4Ijt4sXHeS79r6nso+R31ZtoaG9QbUqyA3I7GhK8y9Tw6WflIqWsNs55YjgbUYZ2/hiN/e8nmTozg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:36:45 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::befc:607d:b3ce:7dbd]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::befc:607d:b3ce:7dbd%5]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 22:36:45 +0000
Date:   Sat, 21 Oct 2023 00:36:39 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v12 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Message-ID: <ZTMA9xQTAMIifnTA@rric.localdomain>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-11-rrichter@amd.com>
 <20231019153045.000038cc@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019153045.000038cc@Huawei.com>
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: cb187f57-c4f3-42e0-5840-08dbd1bd09ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVU0Wn/d6VPjXl6TWEHajYjlEjSl1bJHtSC8f+41+5B3s0tjFFku+GHGBnVqM+CseNXco18Hc4xXTMaD5uqGxJnqmMfcusahskxiYBz1qFM+XpS4f1rMBgUoKKoQTiVnywx3bANeydnB9qStdvMf2RkHu0V0T/iWqZFbDVShZ8aZYvh4U/uJTsMPz1rRrJKr/23jLCbCbV7X7Mr9L3R4Npq5WqcaSfTjtd+Nzwyy3Lti3lfbRDX0jWfRN0cZIrQvaXt3jaA1gTinUG1YnFpvX5opnSpeqJOaQuS9LI1zhlD5B0ASx4ulyO3jbIDgdCAhNjud9LPcx8VlN/Gy9zSJRzSESNvwvbjyk5KYCuscGGQy1H0x6ZHV/lkGigPG8my6SKE7PoNQsuKAYHOUXElksR8MzdDfQND43biOcozgYL1+ZdDeJ2SQ8U14PxQx3VnTYRNLpT71Hpi/GsyndXSq+75odWryaBjmZkvlYzEPMKWvdFihCcHFlo5KgD2rg4IrI2Ko2t/98BiUmuumix1V/rCB+GRi/L9EigjwQaURqUlvyXoJTCaeXhj9PX6OkA2y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(6486002)(4326008)(8936002)(7416002)(4744005)(5660300002)(8676002)(41300700001)(2906002)(38100700002)(53546011)(9686003)(6512007)(6666004)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8EBZ+XYSPSyMxB7Hipk77d7q2rAPI5rZ6iCQg0QWl2S3GsaAAHcRZmwe5tM?=
 =?us-ascii?Q?qcl9h8jQTofuuwPEUa1bNjBPYqAn2cD8fL304pLxMQYlybpe8ccVsin5v67M?=
 =?us-ascii?Q?dgMuuHsJU35HVF+6BxFD5a5TiwUx8Z744dwJxIRPm4C+lyzjJU6osBkwdrR+?=
 =?us-ascii?Q?EIJciQ/h1v/sjyJy1klOAlTvUPKVVUTHLpFX8XBdCgcKBBNPHb14mnjLYAle?=
 =?us-ascii?Q?EkQ6YLFwUuhs7LR/NmfIqAUWkjXW1tQuU/CrTDclMw87ACkD6Lxha1QFna43?=
 =?us-ascii?Q?bwpEVnwykyaqbSmJ2tefpIFqHL/7g4BvEaFpD1D2UA4rOmYYD5A5T7VtHeBq?=
 =?us-ascii?Q?eEoPgfJiOwPHjSMWHwHpBU9b99KiIXmPUDMZPHTqb4fCXprufBQnCCpCelvS?=
 =?us-ascii?Q?/Irwfk7m8kqJJ2F8TjRpUflSG8Nuyw306viNF9RxjdyWb8RiXTpKzcT4CFFe?=
 =?us-ascii?Q?QAvMrVevEiQRq7LhopOeWAUpbHp8VAGCwfor/97O0e6H7PM2zAtLTZIP3L+Y?=
 =?us-ascii?Q?R3518TGLvUO7Cxl+ayOvOGAsoGjYlrYIooXbqLExbDHlZd5+Nnm4DQidBpH/?=
 =?us-ascii?Q?pM6f/mvpCw6k7MT0YA/1uztPkMsoJ6AlFnkqsPHqhEvxKQHbuD0PLElc23JT?=
 =?us-ascii?Q?FdxOpiSffSKdC75MbFG5gBpajBBw2nLVGCTrGikDG77FC/lmgnc149X6rHlV?=
 =?us-ascii?Q?jsV/94g16QS7NgmzL6z70f1vh0VWt29YZc7mC6vyAC67FD/fUjjdjhC0rYRq?=
 =?us-ascii?Q?4T5d0A/irQhjQK+yhzvOApu+fGG9KrHkv5HU4dEGfJXmLOefOQolQNzxZaF7?=
 =?us-ascii?Q?Dz5U3MSxBdRU52dJ2rPRdOuj1mW4N9h7lSbCZ+/Gu2cK4SJY+9wQYTjdEXt7?=
 =?us-ascii?Q?8AxXaEQ2KXD6CAyf3b4F44mDSMJi3a5t+bRiwzKi92eZspshlSXteYjytFJi?=
 =?us-ascii?Q?M1enOAXunesGwJIxGlxjhoHppIUlVep04ZlrBpCTGrf00VrKR2bnLR70URb7?=
 =?us-ascii?Q?7+suPw1E2avadYlDXQni5yYEGDPy0CEm97d02sZIbTVg/GYeneUvJT1DPETh?=
 =?us-ascii?Q?OWHwY6FzJNkZ/TR+hpfFjMJSziiS7aG/6WR6AUZ0ZhuJoS6a6zKVrdmI6ieq?=
 =?us-ascii?Q?MLieeBT9hCTJFN9vMp0By0C598YWdEHxA4qD08xgEsj+8PjUU5uIZFiqDN/T?=
 =?us-ascii?Q?YdK4651tGILmTJ1nTYn1rk93k6FSTRu7O55WpNEyth7jrGVKkIqdNHFUuAS+?=
 =?us-ascii?Q?p2SJo6n48VlaT25SygFUkn6nWKMwIPiyIg3RgYNNd1ICRtaizpi+I0eJ09AB?=
 =?us-ascii?Q?0RfGu9yuZbyWs7DQshnwTQPcd2Ky8HR4WwKQPcn5DdCNaMM/eP7Vigi4tQuX?=
 =?us-ascii?Q?1aiAgR1jYUYkpH76Y7EZKpePbCY9RxYhCqIZ+kGjNZDesGUDubjSdjR+da74?=
 =?us-ascii?Q?qGafJZLpfJvuOD5KIMrKnLwe7F3zyHqlRTMhUPAgCVM0CqVZ8EPOd1Q0s0Qj?=
 =?us-ascii?Q?dtYPHR84SHHy4vWAFev1ZLBL7CQWiOhCU3sX/0iffr9uPBo9nWMH/YmRs14k?=
 =?us-ascii?Q?d/9kztAI0volLFzh/D+cCt1w/r9O8nH2gDRzqXRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb187f57-c4f3-42e0-5840-08dbd1bd09ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:36:45.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylnJrtpmwqmVufoL1e4avWk5YGtb5McWzYKWfhog5D+4GtYrdV5qiCOUDrxIR6ch62GynxvqmydB41If9shhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

On 19.10.23 15:30:45, Jonathan Cameron wrote:
> On Wed, 18 Oct 2023 19:17:03 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > CXL error handling depends on AER.
> > 
> > Introduce config option PCIEAER_CXL in preparation of the AER dport
> > error handling. Also, introduce the stub function
> > devm_cxl_setup_parent_dport() to setup dports.
> > 
> > This is in preparation of follow on patches.
> > 
> > Note the Kconfg part of the option is added in a later patch to enable
> > it once coding of the feature is complete.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

many thanks for all your instant reviews of that series, that helped a
lot.

-Robert
