Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98527A2570
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjIOSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjIOSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:16:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD481FD6;
        Fri, 15 Sep 2023 11:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWOmJsoi/F/uthouoqqYHrOR3QiZ+BuiKeVvcAyfdrHRBRHQHQVKCDNz1ygt5DG0XvG03zefoEIiBmMzrHHZp4UI8W9z24BEiRwWliuQ1Papq8WBc9gN2i57QPGUt33AuhLlltLXpZfEjrZ/SuHENeXbV98BgOvsSjIMtcHNNevfZraWKArmMeKQmBtybCk0xk+Agilf3pAhACIpB/xDyzXHbe6zaN7/7FKC2krqrFvRVDx1KpfHXC0u08b+aiM9k603eog5xGm/vhMkkKYMgDripnfsgVs0EKBd0zoKMr6eHQM0xQtdHEiWhgnRBgBBQCAM/AwUbMOfquutYqSHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTctMl08l3M42QuqKSPeQh6yRf2oQWOAOo0ckt1Z8H0=;
 b=fFOaw1ZQ6gnBuASDTHYaB0Y2EhEQNbtgXddMYmiqKQrRX/5Rj34LAnbq2MyBRvaCnaHlI5j9mV8vp5q6erod4559FcPzqGLXyJoAvdgHFqU5MnVYamZO6XpqWvQ/Xl7HwvvSTcYCEmBkKyiKinp2KbPvW/aWiVNN281eOf+6/xVforYnMBw3711zvnseMgIwBYJm6mZf16rd33juLTFmzt1Bkkk00NhklGIlXraaJylSvGREfeW4mr9Q30ht2SOCqy16BYPiVltR3J63RRWK/6F6qYydrn0wRarVfxC4PeYPrnt0+EC/1mbVLKT7XofFy8MDlVUBGGBU5Z/Bw5ljog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTctMl08l3M42QuqKSPeQh6yRf2oQWOAOo0ckt1Z8H0=;
 b=PGb+yvPA0fS2jDhGk/8mwP4+VdsQxxvhSURJhTu0URlfrfviGnwA6cgJPVjWy4GHn2Gz2eneuKvpmWbuz5zNqQpuD783yAC1wEOq/QS7kxMniXtwUg1Okx4uGIwaKwt1YzICyjR6LUWe4aaY+DV+J/ROXPKqMj1Y0bwCXF/aI7Q3csMex9BLH8YXinzkYZ+lGwTnHYo1yy8tAhcSPqEtXkYSbMc3QltU2E03IOOFHcseJeR9YGOT4/G/IeIhQkfrVo56pGsRYYcce1ZOQg1ClqA1lHDvZez0Ui71EW0sARfY3UBG3Z3uYdLKIPjj5NHbORzXTU8Ub3fX5g+cGo7cOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 18:16:32 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 18:16:31 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: nvidia-shield: Fix the error handling path of
 shield_probe()
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
Date:   Fri, 15 Sep 2023 11:16:20 -0700
In-Reply-To: <cover.1693070958.git.christophe.jaillet@wanadoo.fr> (Christophe
        JAILLET's message of "Sat, 26 Aug 2023 19:42:16 +0200")
Message-ID: <87msxns3nv.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: b34095c2-a56d-4200-7590-08dbb617e31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzNgJu/2LQuXWU518j5g4YPpb3l9X8Ich96x+If+Y0NIQZmnrFrtPRB3rd9JlrpwN2BmUFsQC9QMthiG62pD2msC6FhjRyLNzsuanUOwdQyPe6MPQfQmUUsLc1xX12PvPjrxP1BB4fgSV4MilUDDqIKGYCOC7crgSqs2Jr9mCJAixFst+RaJei9osFfG8ErJpwmIAsDjVWDz6Ehts9uhNkwGrJfubgdiHuLTYGeun8ce2/iV2Dd6gWOy+4YLIJplviesMsMdyKZ/PKDUOloVsvOyrW1nDbDL7Fon0ECjakCcsk6+o0vsDRoIY/3B893MwgWVCjUqYPW+PBpbAZ87JAHvJKmMo8zGTgj7N419NAz3mgwCR7ifTMJYcocdbIdgw9GUg6V9OKKMl4tzKsSIdMuo4XPJd/pwiCh5iv1EB9IFUbE5y4UBJDKheDx5tlzKW0cDuY3Jd6O551UyMBJJHz6YDF902nXrh9Is1OU8blWpprE0l2R9pDYR6yieYhspJaSSBLS/eCEeuSwpW7m3oEK7RO/OKw0AxIIIoao0zBMize5+rBo4M6z6sPUHpIwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(6666004)(26005)(478600001)(41300700001)(5660300002)(66556008)(6486002)(66476007)(6506007)(6916009)(66946007)(316002)(6512007)(8936002)(2616005)(4326008)(8676002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbG78aR+UIvGwZHlSJ5kbf2WbM52CKJhPJCx/RuhUFTGrDmEUV8ZONWnn7Xo?=
 =?us-ascii?Q?Bq1XDvTbEKFjFRqVpCe2FeNQPluO0BuTFuWD1GPhfOQMQvLEHdbsphWOd1/z?=
 =?us-ascii?Q?ND5WrBVO2YVCYUt+uaCJT1/zFShffK40KeLVB7i3SZ2zJzf+oc9NSrdUGm3z?=
 =?us-ascii?Q?yLWipf1nsSrGQqkSdKC6JaRGHk21sgTNYCKXasFvavqTI0iv9EtQeZUoCIBf?=
 =?us-ascii?Q?Yq+P/oFifl7tIzskJGNQfKRtIumrvNdihBXkEqCqATlttwKcRnNY5sO/KQKZ?=
 =?us-ascii?Q?6yTSpxXMumIHuuloWo5iu8m0i8LeDNo3s6m5TMLfvEDGc0JMZcEUn9ETAYKY?=
 =?us-ascii?Q?0EjqzECIHMMqNv9YzMOaI2vc4D2dki1M1x9tsRqd30xNMux0afuPG34s9t3K?=
 =?us-ascii?Q?CZpP4VCbd3m+KWCO7uGbdw3R9Y23T8ek/dpDCsjxvMBcnpmlzyPbiIus+q1J?=
 =?us-ascii?Q?hma1XJw84lgmEASNJppKNj8IVdGPNRVTLjrrRZKr1iY6i/jlA9cUy1ivfHZZ?=
 =?us-ascii?Q?rJzslQEkdlwXRfv8a3TqPc1MqJDbAsE37XL0QPOW/DzRUjCJU7EsZtnNhzSK?=
 =?us-ascii?Q?zBWynM93UT1ohVYe8AcqyAe+Vmzys/4fUUQxXk1syjuwvN07hx3vPScPS9gw?=
 =?us-ascii?Q?UycNnVgCEZbnXtuYSbIkvbQtE/cI+nv9+W+0LC4CkyU/48M/02FgFb5n1Xz4?=
 =?us-ascii?Q?tKPhhnujgr7qU52oY7UdCgEDp7f+8alSWYIRi/D4FfHaR+unaWnoqLXAREzL?=
 =?us-ascii?Q?Ivquzvw0OpPYp9dWKOadpfE+LE+hk2MOHcK7DsEGdt3A/5wWoQzVmbl8ghcd?=
 =?us-ascii?Q?nym7JWtKG931sDMM5wxbzeR3ldtF1YWhfZUJkpYhmCWZ3sJKjoxJgMv0BXn2?=
 =?us-ascii?Q?TxbYVPXCwlzaKrZ1sEKP3tbuJyA5Nl78pucdwsUACnwJmGNu4ulRDYG/61pP?=
 =?us-ascii?Q?FdvJSt0mGAxJdvlTuwbRrry68y7/Sm/FsJT9Zxg8EeeicihmKC0NJCnzmYC+?=
 =?us-ascii?Q?wZVWVW/qi1+f4yCLYzvuFp9pQLaFdurJILv/0Okd2wYDSMw3jTIKt4saOBQR?=
 =?us-ascii?Q?lkNqA/6K8HUODrS66iO1Q7JnAgi6GWRB4N3zCEgZF/YwsgRzvJt83Mmfqk7f?=
 =?us-ascii?Q?UJder4izBRRQQ/xtzGpujnfjiswZ5+a+lrnKwtSzu8g6B+nw/13n5r0BsSNJ?=
 =?us-ascii?Q?EIz10iJ9hSPst+pRvjIJX90ED49lnuwhfHATxExLNzur7FNAMPUDA5bpqRxD?=
 =?us-ascii?Q?zcjYChd6jZww1rDTzoAwUqCAwzyc+wk5FAF7iKkcGqWFmW6i30HPXVuMJf+5?=
 =?us-ascii?Q?AxeAn+nAMO2c4lg5t0fHSIEePa3zD1pvI6rHw5cz19+00lFsQmKaMBdMoJ7e?=
 =?us-ascii?Q?xPu3tyUTyf3kFrDgpmrMOqMRuAKXKM1fI8XZegUJlyCwLsPL/YKLXubHI0Sg?=
 =?us-ascii?Q?48OLm6efzrE27Xba41MoQR/FSlE6hTrP1oIWF52LUqYgsP2e7rkMqAV9qcNM?=
 =?us-ascii?Q?g4DJZzAuGEF7iKN6gVf3PJsjp8RwveJGhESDleqznKGMw5TafHY7aCSJrkdl?=
 =?us-ascii?Q?N4SQ6C9DHYTtQ1WzA/kj0XcGsU3Rocktx4MXEjOe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34095c2-a56d-4200-7590-08dbb617e31b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:16:31.5833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y355nKx3CfKJ5Ob8Ss+EKXp0Ofp6sXt7N38dy/knsbmznIyXL+bsKE97zS/B8g/Om4i5PHAbua/CteGCaxiJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, 26 Aug, 2023 19:42:16 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> This serie fixes some missing clean-up function calls in the error handling of
> the probe.
>
> Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
> patches)
>
> Patch 3 is a proposal to be more future proof.
>
>
> *Note*: I'm not 100% sure that the order of the functions is the best one in
> thunderstrike_destroy(), but it is the way it was.
>
> My personal preference would be to undo things in reverse order they are
> allocated, such as:
> 	led_classdev_unregister(&ts->led_dev);
> 	power_supply_unregister(ts->base.battery_dev.psy);
> 	if (ts->haptics_dev)
> 		input_unregister_device(ts->haptics_dev);
> 	ida_free(&thunderstrike_ida, ts->id);
> This order was explicitly chnaged by 3ab196f88237, so, as I can't test the
> changes on a real harware, I've left it as-is.
>
> Christophe JAILLET (3):
>   HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>     probe error handling path
>   HID: nvidia-shield: Fix some missing function calls() in the probe
>     error handling path
>   HID: nvidia-shield: Introduce thunderstrike_destroy()
>
>  drivers/hid/hid-nvidia-shield.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

I was wondering if you have time to address the comments in this
submission. If not, I can re-spin the patches with the needed changes in
upcoming days.

--
Thanks,

Rahul Rameshbabu
