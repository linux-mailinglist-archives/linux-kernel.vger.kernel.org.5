Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1378A145
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjH0Tnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjH0Tnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:43:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176013E;
        Sun, 27 Aug 2023 12:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyQipN/QQrfL5TWFTpJZ0Ie6MQ0xXmQz0e6VIigIHS3PSkRiezLIDM6fAqkgldNr99SY1XTiDhg7c7a5yqXnwDlj0odbZ/WJrfubYzr9m4N58YsyEvWKolOj1J7F2+8TLHIu3SAeJu2mC/XoA4EnQVrekzn7s996D4p8qVgO/Pft2sXyMoo5hNbZ776MSem2GL+g1BLjDRv6WVZ9twl2tuCC5x9GgPBPY32XepqmHnOsUW391Lor/qdy8IsVTyEeVMmGOurCy+Husfvx3zr1Q7Oj4bRoSzBFMxAF6vjFOmxY1boLJSnzisBgwKwGMN1A5UR1z+UpfoJ7VpoM2qGM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT6jI08fcdZE5f8l5YXnc5DylqZ5fEaYjD7lQw71tE0=;
 b=ix6MCkQ9+lU7ek4XphW66MmnRZJJsqfudYRXpkDeJo2jTTr7ugMWzzboUvKlVX9BnEoEx+ylzMioVRXOVIib2CB+vJI0TA/FoE+o0bfi4WLpYOxS9Z9VU+UFtEEOG2KCtl5fz7vRNGMPJ36xPRz7rDsdjgN2DOXoPYQiwPpKk/i0CA8SES77pK++Tztt77rC8tsiF0W2i+7A7O1fCVOAyehFVSv5A7PWaQCUwd+JsIjd1XRddYDsB8yoXOBakn59dP2YPEWe4Op8cZAmzC5lty2rNpbnukydPUH7yDOD1UXTKADNcpMwbrl4wCIuZTN62Yf3+Z0rAN+8GRLG5hsOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT6jI08fcdZE5f8l5YXnc5DylqZ5fEaYjD7lQw71tE0=;
 b=JxfD2juHfDT0PSPbk1B05MgS7U+eoYbttZiiCUA9IQk48D3y+/sCTceKbt1GmHRgi5SWWF8UfmSZUddSDdvAIQcTpzK2ceV/LB0HCYjLlWve85hUrTO9hgL38HQXCpK2IWgw14ArjF11NidTIUY9DBTHClQuWhndYN+snktP2JqAUohMCvxtvjVs/7qrZ0+b6HGJKGD83GNoBPih/Hz6MOUFtr4jiY6EcFCBOCn0jiP+Bj8pLil78lk5UGEjp+qgmu7SbpKShWOeBfkPdqAAcyKPTYi6dUUtZfUhFTIDaS/2pMsfi94HClqZghB1hJbtwrPOnYU88GJrka8Y6UdwJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 19:42:06 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 19:42:06 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: nvidia-shield: Fix a missing
 led_classdev_unregister() in the probe error handling path
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
        <bf19356b4ccd6446245570bf526d6940cac25c09.1693070958.git.christophe.jaillet@wanadoo.fr>
Date:   Sun, 27 Aug 2023 12:41:54 -0700
In-Reply-To: <bf19356b4ccd6446245570bf526d6940cac25c09.1693070958.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 26 Aug 2023 19:42:17 +0200")
Message-ID: <873504qnlp.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: a08f9350-e5ff-4c6b-8c59-08dba735b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AME8YhGsvOlPBxZjbDyQazbmk0Njfl5D3GGr2jeh5Ag6Rxuk8uQqEcMZ3b2DQ+EpZJI6z149Yl7UpWysqM6yjfSIubHYQP/k01Cg2fkts7UgnLMWWiDee39VuKu2ncmRNUZJX4AQlGKRW6wlgfWODZ1lg9+8s/zIqw1IHYK1TTZqjMWklMsDAo/Vt/7TfkMifd+OpYOHbRxnZT0MYG2DB6HBLbUWdDhDibQHk9G+g3A727ontqlbVARYqp24JEf85O+JZAWeq3vF4WzhTlwnmjWOWUzc4u+Nf7LWd9p/gRUfY762yVcCf27BVLnJ5NGj+DzDq0NqzI5huhl1XLDc5Pa6Ldk6vuYe933QH4SpHQLgYowi0HfQ7CJ3tmkw4HUXmF5trQNTKOIrd//JQ9Yn+9X/OjaeIO9VsbtXlfiT6rktgGHpNUMVCZ3wi13S7Tp37EXoOwJgLXAV3IqpAH+K016OR7o6z8X3PHeVui231igNfYsDjjWLQ6D6zt0hBfNKEh/SWHt4BMQAx/GAsYFW0FQ1vIwvUsfFi0Tde17wdgYtPS4vDnUf07PjIn58EbICtnXfQzfa36LmYLb1k2UeAHeB4x7mWpM6CT1Duzyx3d4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(6486002)(2616005)(2906002)(5660300002)(86362001)(4326008)(8936002)(8676002)(66556008)(66946007)(36756003)(66476007)(41300700001)(316002)(38100700002)(6916009)(478600001)(966005)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNv+w3tV0wGcSfRbSKwkmLGZVvrB6bcuCdid/WEU7mHMeV3FV9eZrdVvYsD4?=
 =?us-ascii?Q?3P5j58vgMTWc0ZH9yqhGh9n2WhDX9LkrxHqw2525fAu0jbl2SDQk8WPP0tvg?=
 =?us-ascii?Q?EcoWdr7VL8v76XDpijPOvmqSN93+tSA0IWcE8w2MWJEYW0qxO/Gb3VdffAcO?=
 =?us-ascii?Q?+vhiq+y1WI1B2MgVyr28eI/UjGV4tyQaviJBmcEiay4A2141//odX+8NfBPg?=
 =?us-ascii?Q?cfrBjxRAjx6EUpYjqGu47P0eqpeOdG7hUCaLislp4W8vlgQ5NjIMukzEwscG?=
 =?us-ascii?Q?WrwX60+IMeVK+rcA80cSpAw/j+Z441yj8rSxtu0nozVxDHQQ1B0OIJNVyxHV?=
 =?us-ascii?Q?ltFvT6z437lKcGJW6ZdJyMIupWNkm7K1GBl9zJPBYAFsjsNp/70NIAnRxBvJ?=
 =?us-ascii?Q?PMTsw2PwGQ3CH999ECH7/13E8/jn+Gd5CQ18ZwS51xnKiD7zcz6/eGwZYqMM?=
 =?us-ascii?Q?Yofu67DhXu7p2uPeC40awWYHQhrT1DfHMdVlLaQyLFS212fmwHtoWXJ/q8XX?=
 =?us-ascii?Q?LlD5Z/NDx+y9J8dG2XBAJNTPDZR4G+4KRg0UTEhnPnCKLlV7Wx9pP+EJjbBo?=
 =?us-ascii?Q?AgFRf8LeSWEc5oiLwCsv24RRx8Q/sIGcm2EdPA3WfbkhLIHDyMd2+3iRwCuC?=
 =?us-ascii?Q?nRwpPq84tQPiDI5Xv01tiyv6NZuhlqRm4meZFBpyVG+qN+TMkT1nHw0iJL87?=
 =?us-ascii?Q?dwzqeeSikqfZy8RT6BxVf0D3CvQ/y5xuULwTASm89Z6CkFc5JxI/h9AUkaM1?=
 =?us-ascii?Q?v9kavahBKwMf+TNYwQQRDlo5tYL9qxxnfZCSB1NANvTjOs8PGmHA/VSEBVWR?=
 =?us-ascii?Q?bq3NiBsbnv0iYjNEvxbnbgKpW3iZ86l3iRyeDa2B04QSJi+lo/UQrI0KIdsQ?=
 =?us-ascii?Q?yhldpQR4iPSNSSg9Yi3eoIub7Pt8ucIs2AlAlI0tIX7+YL0XV2f3zLHFivVv?=
 =?us-ascii?Q?I4aoGJKUDbiNXmw9HZAcETijHpVaoVrvmDxfevKs8zCl66Yrs5zkp5CfCm0A?=
 =?us-ascii?Q?tHaOocTJoWdkDG8GZMLpRnRkgwQQiaqnxUYZ3+Q8Hhbn2xv4cehH4toA+rCe?=
 =?us-ascii?Q?QF918T6H0bmczM9zZLVJVKpK5hC40/WlEODwcZvl9PZJSpr09iwai9FCRLu/?=
 =?us-ascii?Q?JRMEMAFeM2bVkhxTyBCG0Vq8AJvFEF5frW9CjgMOm+a4uldsL6KgXxxhshRi?=
 =?us-ascii?Q?HxYIIKW2uxdodWGvF9sfaBp4GyxDgxBt4V0C97GYkZ3td+DY+zC1zzmDWxi9?=
 =?us-ascii?Q?ZMq2+0N9pYzWHlV/lUgbi48a4huJXzBKmjWn7LIQCXEEEvjv9YGZtAa3IB3j?=
 =?us-ascii?Q?ivHyeIzihlViMgVgwPQfI5iy83MewCPJD7cUdg16z5/ejouQDABn0/iuaqWD?=
 =?us-ascii?Q?XafWSJay98XVgqcXGzb39XOqwYyIWpRurPEbywl8vy2XMEXaCDAGEtzp2bbD?=
 =?us-ascii?Q?83oo1rrfOyvY+cHJzOXYzWpTOP8Zb020W4+3nZzaXsyrkU+Un72Rr67S8Qmc?=
 =?us-ascii?Q?2k5j5Ytlkt/hoRLp2MPye1H4PDs6qWi5a+eL9n6wVINKEvH/jgvAXp+xhFij?=
 =?us-ascii?Q?+P1LRPX4fC64cqXPmZTDH7hmyUMxWVbBU1W3AKf0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08f9350-e5ff-4c6b-8c59-08dba735b1c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 19:42:06.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGPAWt8X3dRWxlfp9DKgqr0TPCNx8XgMeh0fSEYO/x+u/q1nylKb2Q5Yqw47zkChTdS+eWfaz4XaNLp5K+8M2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug, 2023 19:42:17 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> The commit in Fixes updated the error handling path of
> thunderstrike_create() and the remove function but not the error handling
> path of shield_probe(), should an error occur after a successful
> thunderstrike_create() call.
>
> Add the missing call.

You are right that the led instance needs to be cleaned up here.
However, there is another bug that is introduced by this patch since
this is in the error path where hid_hw_start failed. The problem is that
led_classdev_unregister makes sure to set the led state to off in the
cleanup actions. The problem is that it is unsafe to do so in this
context since we cannot send hid_hw_raw_request at this point.

I discuss this in the following patch submission.

  https://lore.kernel.org/linux-input/20230807163620.16855-1-rrameshbabu@nvidia.com/

I think we should take the alternative approach I mentioned in the
mentioned patch where we set the LED_RETAIN_AT_SHUTDOWN led_classdev
flag. Then in the context of shield_remove, we can explicitly call
led_set_brightness(&ts->led_dev, LED_OFF).

You will want to base this suggested change on top of the for-6.6/nvidia
branch in the hid subsystem tree.

  https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.6/nvidia

>
> Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thunderstrike")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/hid-nvidia-shield.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
> index 9a3576dbf421..66a7478e2c9d 100644
> --- a/drivers/hid/hid-nvidia-shield.c
> +++ b/drivers/hid/hid-nvidia-shield.c
> @@ -1076,6 +1076,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  err_haptics:
>  	if (ts->haptics_dev)
>  		input_unregister_device(ts->haptics_dev);
> +	led_classdev_unregister(&ts->led_dev);
>  	return ret;
>  }

--
Thanks,

Rahul Rameshbabu
