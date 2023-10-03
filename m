Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E167B63F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjJCIWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjJCIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:22:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728CA9;
        Tue,  3 Oct 2023 01:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZP9XISeARgXMG4o20r77FbPn/CQjOOdzHS8dK03ZbRt/C8DKUzWdyi82K1G2heHGUJB3+B4Lk1QxRKDNT/8kKGakGu+roO7rh5EIaIMtI8JnQRI3e5ChdkLQpWV+Yy4pMp77Pei5jS9lM9WF1kpxiGfSv2iZr2Jy0TnCi1jG8Zuj3xqhEXEvPND4q4D992Ue4L3vvVVy4RvkhC5IeNHzWxbf9k2s+Vt1b5MU9T01ww7g+TGtrm4L3aY8w86ye+XshcWkTV67zM79sGyVq8JnWlYQx39gRCaTq4DGfHsSZfxcUL+eWvb2YBRHYRBnV4JftSCOHrY6tl88Bmyz6CXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWmZxeBHAt848IHd078G0wC6T1vcwDdPQin2K3Jb44c=;
 b=iXV7clsE/FJ1UMVuyDGHb2/ZKL9/qlB6nsTEY6c4PFOsCh0vPqSbvrIZcXKxYxTY4LCBaR4FFB1aZm1gekZCs9McXsH43q6/7braXa5XFV6O5B8BJFdI61/8atFalcgyESB+NdEsgi20wCN1EUCFHocHLxxXXJfJ5W6k7OlShtc1TZxusKLcaAd1zCwmCfc4mkD6S6aq5Xq2DVb9GGb+rGvlfRmAgmp2yB4Q+M//FXbzmV8J4R9FIok2+7nXCn4BXA9lHrtoEMrjcjhhTUTM1/36rMS8l/ip4e+QiicH/yHdtcx2AJN7maS2wKKVoLg45pFirTCBA1qgu6eAAkRATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWmZxeBHAt848IHd078G0wC6T1vcwDdPQin2K3Jb44c=;
 b=LD4fibQ2r0B9hpXVE33iOQ6SkH6BDoCQZjsVJTM2kc0ZlW5kuO4XOvgMrw0Dqs3fv92MWgYGBfJSvny35dBe8R87nWqv1yvgQU85E0s+YQC5dQDGX4gATFXRJp6fDa6Fi9pE4rVAw01EE8/b7MlHHyywTj5oxzeasatFjiN+DoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB4863.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 08:22:41 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 08:22:41 +0000
Date:   Tue, 3 Oct 2023 16:22:37 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards
 not work by default
Message-ID: <ZRvPTa5L35ui9/q1@moxa-ThinkCentre-M90t>
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-4-crescentcy.hsieh@moxa.com>
 <73a6b0ae-d94e-4a9e-9964-0484c95c8226@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a6b0ae-d94e-4a9e-9964-0484c95c8226@kernel.org>
X-ClientProxiedBy: TY2PR0101CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6340c7-16db-4b83-8787-08dbc3e9e982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2dTbGP+RHj6toyCYhVo6WkLJyLTHC8sqoQOrve7eH3VffkKDg0XyBw29YrKtN8NWqf+tPVc9lvQJ5r7gFqUbACxicYQpQQ/RD1897Ef1VzUhFbqDoETVTN8kaw7AQpfrbzwh6VWHekJ+89xns48a2nEwM0W6zO+f9EpkSNQDJPdfHKXCIHUb7VGc6995Tb6YCLc8kWiXXq9TI3vf73XxQV30Qi1iGyweS3DXqvc+OqJU48Vsxzgc3a6l+5QDB0EqenI+BP1W2LUbxOlCqrvMq8sMNB90Zl2dlxtYIfHisgM5ylPI6lAMnhtHBl+KrOv8nXrFRv5z89q9s4p6YvShwxPpDY14dCZQf6otptvMYz0DPH8kjGgB/7aiDZ8Zvy54xDiqatx53GMx9IWygz2or2xkIrIWqfm3m69fzqOr/p/N3by13CWHvOLkVM+2bNx8FjAVLqyV2kfI3V8/orS+DNUlwRWbAbKDE1oZBhME4Bc23AB5QQ2OTLGscBmqCAEJWZOPXK5436XTLbACDpz79PLChMGZzvRpKWbZ9CL84le6v0jQaLMrSpRcMXWtqKBgsPFsBaJ+4sjQ01Sakil5+uYVPIN6zRyx0Rk4zDknrUhpGu27pcCM89J2/QG++OJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(52116002)(6666004)(6486002)(478600001)(6506007)(38100700002)(86362001)(38350700002)(33716001)(41300700001)(6512007)(9686003)(26005)(2906002)(4744005)(66946007)(5660300002)(6916009)(66556008)(316002)(66476007)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhFMKpDaO3iGMdDbRs6KVWflWHZDZkcuKSQu2Wfnqf8hsG1Ca/7vNZ4khqy7?=
 =?us-ascii?Q?FFRwpiIg9o4M9I/dimtlT9nOJWL76Po0ITHZjSOCXsah+tSTUJ9ZmqGG4wVV?=
 =?us-ascii?Q?rFcmOWypWCQdFUM5BpPZTSDUXxlF2PFC3fBXHfwmQfWRwx9diwzp+geEkQdg?=
 =?us-ascii?Q?JAnwrznkVHK8kDfu1fXtrLLTmXyXNg7RPF8FFJdIvxz102VtJ9RoRBBLVLCm?=
 =?us-ascii?Q?Hl5sSVwXik8lD4s96wWtEnIc8ceEQvhLqEdKAfgM7H9mAxzYRfe8npochjsI?=
 =?us-ascii?Q?A1+DWtiVrSoch1/4fMEXfNP8yP1repdyn+gvpxUcHHNBD2Li3Db4v+hqxVd+?=
 =?us-ascii?Q?CTKpOxDdnBwOSkP07ofx4Ur0KUi5R81wt62zSxfUMaNPiVErBaZhRkZ+oCvl?=
 =?us-ascii?Q?RarBUMDiOa0u1zqyt2HmVwrZfM/i2+35WCRiKLtrfD5uuE601aPGVb/32J/y?=
 =?us-ascii?Q?qYciAhcFHaT8nK5E7xiSbeGb6m9r/XLhmlovKl8TvsG9i6nYUics5OQW5pcB?=
 =?us-ascii?Q?AIOzQAMcefcnSDG6ADY7e65zSE7VncPhTpRxZiwcdvVOEa1vt9InNds/wrpY?=
 =?us-ascii?Q?UPRFNr21GEE9ATk9nmBPqXU2O22EtFvmAJywBahkJJEsB27QMN+HYGYFBTkT?=
 =?us-ascii?Q?wYW5X2S3a/krSUx5AcYYqD7evCaKv9Enu5KgXKR7kwwkx+K/vReUGlt8e6dC?=
 =?us-ascii?Q?WtaaxnihKrfK/srheC77HMn8hKl8Q53zaQzxOjgmm51WcyMkFv6fMy88IAqf?=
 =?us-ascii?Q?zHeLgF4vJu5imT83NEKOqNMAZyj0pJ1PD9fqwRtVE1d5dFNzFr2hHohX5JCW?=
 =?us-ascii?Q?/aca+h5CP0JCI2XECpTOHLeEOxvv+n9vp/2rWxVurxqfkgQ4qtIu1s1HT3T/?=
 =?us-ascii?Q?qSN65NxtezrJzKERHRm7Rc5FSq+MlY39r5Le6A/x5OdhEHgEWzjaQomj352Y?=
 =?us-ascii?Q?WWAJ0xbl7QiHKORvAHyFLihBYuz+5GPl0iDzRVCrO/niERFHxL+3BLZcLXrY?=
 =?us-ascii?Q?xyHu08G9HzSNra7Y52xSEBKGHRhdMTeyv8N5hCPh9Bhbj0CdRlsEFPDic0dj?=
 =?us-ascii?Q?JjTI0VHXU85WXZtjGJeKSO2F0zlPbwYmoLwVcZn3u8JQ9ru2Aky97UUDniKR?=
 =?us-ascii?Q?9u6uGkP11WeAyOMJ5Jjj71T1eAonuhlvj8SxtBjaRK26HE5omTDzRS4SWQl7?=
 =?us-ascii?Q?1EXbVo341dzuB+ioihij0ENTB9ccnMml+UocOS2gRFtzv0CRDzSohdI7mgVj?=
 =?us-ascii?Q?CHC2KY6RMxg79BBAZYwh4M+q4RqmImvt+fsyV7BJvzJmIJcS6TjdxYp8+nc/?=
 =?us-ascii?Q?gFmjnUgxAUCRRyUk2JDXDwAT1wqkPoOI53+N1JQhPYB4ikq/rqxTAKOSF+g1?=
 =?us-ascii?Q?N8dNVKKfC1TItUmxvpn7Uxj19BvEx4LipO/OjeYBTqdBZAMH9Kj9KsHUYaKG?=
 =?us-ascii?Q?yk59cpx/mA228xXkhzmxJlXTX5hVQxvoGXpX6GScTLPlB1mh1RAcM1KiH+wC?=
 =?us-ascii?Q?SA2sKB7YR7tBMgtNeBLjJCgBDH4blQ41lQkwYWZK9CB5gmHfr4LQ7LiI64b9?=
 =?us-ascii?Q?v0I/gAScHFczZjDyNFlVtL0Qtud1b2g50s3gf9uL1JfVrzubM4V34zbeWvXw?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6340c7-16db-4b83-8787-08dbc3e9e982
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:22:41.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akBpujpakxNBrXTfW4/qV88i0yT/VAqEbpsQnCRNTQTsmDk0IngiJ07sukTBCgW/Fs6tGyzzoxNnSMNR7nHaW3OtbQ0A3Izdh28wcF2ngtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4863
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:14:32AM +0200, Jiri Slaby wrote:
> On 02. 10. 23, 3:57, Crescent CY Hsieh wrote:
> >   static int pci_moxa_init(struct pci_dev *dev)
> >   {
> >   	unsigned short device = dev->device;
> >   	unsigned long iobar_addr = pci_resource_start(dev, 2);
> > +	int i;
> 
> unsigned
> 
> >   	int num_ports = (device & 0x00F0) >> 4;
> 
> And this one too (in the previous patch).

Sorry, I am not sure I get your meaning, could you explain to me?

---
Sincerely,
Crescent CY Hsieh
