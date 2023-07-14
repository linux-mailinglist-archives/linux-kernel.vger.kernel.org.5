Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B451754426
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjGNVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjGNVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:13:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDDE65;
        Fri, 14 Jul 2023 14:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaNDm9rcTgFmr/CYKn4g13q1fmHxBsPHcNH6dj6f/RzN9Ec2+rU4TcXJP9RuBflvxE6qd5urm7aUNX1lHTjK5NnV/8I3pfttxy18DrzIc4KH1rrmvw+SCJnbE0vjFph9cvh3XwnfdKEsrjwJvIGqHV8Ijhzbc2WDfAQjuYm4xeT2lBzBfjmBqv/Ztkba6M5txNKHii/MxbJToyVQN+ABTuVSOw1W780xqzrHVIfp3uycRngw83SW4+WPt0ItLR1WKPlayo7+4YdUdzPXWFEC4jFjVY19kGO9kAGXxdthQj1MgimCbZgB4VcxQczBIOak5TA6ef3UQg3YmGMP1AYMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AicPeDp4+swD9cxOGCiIEWIKlA0BAtxmBhhvIA7CDqY=;
 b=h+N/BywNShBqe7gZ5tJD8StPFS8TwEDlARVNNn7UrtbkjqIbFIg6RM6hUkMymzg+QxhetCB9LTwATU5feI68iqyHn3jfRPGDtLc8weg818CHKRN4tQOJ1qIYhugxKC6cg6EWQcI5EjmOw8Qix/HWN3rv7CRGxZl3y0Dmcwi4hJ1AR+8ZgfRmRldrH2u8eTwvW0k8vZYIng3DEeIYmHE3C6GL4q9mCPdbJztC3wmpJZe8WaI0PwKcmiTLl9hi2pH0pPiPJmHgghZLYNRcMFnGvnyeJYSqw55vUvPnn0OE1L0G9goa9G9+zh4ytPiDj7w+O8SPHSPzLc9uOBdlrsHMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AicPeDp4+swD9cxOGCiIEWIKlA0BAtxmBhhvIA7CDqY=;
 b=NEajN2lDQJucSQhXDEq5k60sWeB5KWjNXnrNYbz7uXkbs8DQfKpJtK0NKnEgeL1+vflmVD5+0KVnNClP+2o77IqMe0CcybUlYf3oAtmTXagZyOsqY2YVDWm1E7Ys8CCtw5rTyR8RAXqVNyRbKZWXJdEJPzdqx7OvdStjj+GX1MnLAt/p7opKQkuev3EBzf6wcsNHiextfjgsq2hTEBiO25iocAr71/HRjN+836gXgcKKltptynxpcb6GWJrywSirOaXVwRScmSNDSrMKkw2tHOjo2ctBnHjsRvYo+axu4oihyPEjD7jFqgLwa6qKnOLNDrQLDGrVOxNqg30rJYQOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 21:13:44 +0000
Received: from BN7PR12MB2740.namprd12.prod.outlook.com
 ([fe80::d658:fc9e:6893:bd6]) by BN7PR12MB2740.namprd12.prod.outlook.com
 ([fe80::d658:fc9e:6893:bd6%3]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 21:13:44 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: hid-google-stadiaff: add support for Stadia
 force feedback
References: <20230709214410.3676224-1-fabiobaltieri@chromium.org>
Date:   Fri, 14 Jul 2023 14:13:34 -0700
In-Reply-To: <20230709214410.3676224-1-fabiobaltieri@chromium.org> (Fabio
        Baltieri's message of "Sun, 9 Jul 2023 21:44:10 +0000")
Message-ID: <878rbidwn5.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To BN7PR12MB2740.namprd12.prod.outlook.com
 (2603:10b6:408:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf8544c-d2cd-4db2-c417-08db84af349f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRdaAAcQLGlYE12rsl4AxZwrOtub4lzRCkVdG52FO4o9MCQn/fQ71ixdEjroeZxvhVdSkiQzkUYDGOes+BO2xk/ez6RHL6S+VPLb5lV+Mu3QrMldSzfJHQLkf4dnrKwd/hJREWXgeaEJQbzQ5nfqUv9pWEB2ZhHdlerTfUHaem+iMU+lSQEWNMvgQ6HpOcROwvxRgE2xS/hh9YaFO4tbv6EMPsr+i9Zm3FeK21COXqlCRtMKLxVauczSrVwTuc9P2sfw/Jn6AH2EDEEN5D/u1Z3ZtLKLw3fGlDBDxnDgiVRF1VbVOdGakBPgb+psq13IaI+vzQYPMqe31orZkIXmMQNfZtQGBfQCBMilaQQ3Hc49dM3Z25aY2DeaF297lqhiMpcuRc/WVgqbEb8woFSUFYexemmRk1IEwirulyC7THE7oPv5SsOn9MJS80rvdgAZRFBDX8b/Ecl/nuyfKLI+tWu255fqLwwcx7nxK+CYjr4X2cBThQpEz8ted9ydA7xSqH9GAF9SP+b+7M8bcKTExgQ0TnPDKP4cr9WEIvf+SGbVFnQi2oU6V4yOZQUSD8GQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2740.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(6486002)(6666004)(2616005)(478600001)(186003)(36756003)(6512007)(6506007)(26005)(4744005)(6916009)(66476007)(66556008)(4326008)(66946007)(54906003)(41300700001)(8936002)(8676002)(316002)(38100700002)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZT3le0ICaNLB9c8I5ltMgrFJC9h2NOAraWzib39iQtNsFBRv0v5FzDSuyC7?=
 =?us-ascii?Q?Ld9toKVVnGhM73+2c6JsrI/Rb7Cew1IeaU3a+SpmO1RjIZVHgad0xBTN5aCT?=
 =?us-ascii?Q?RzjonAdn1wh6ubF/oL029Qa3Mvak+nTPYKAIIXFR5Ui9WaSKxL5DTkKtZCY4?=
 =?us-ascii?Q?kOspvTmZ+Gpj8mrGHGN/cGMsmRBAWm3ZeG8j9wKxAXmGyf60biTWHjLuvFon?=
 =?us-ascii?Q?/3K5HfKyoft1AxfzqBeK7nuolBpU1zVXWz25lIKaTDJuml4wFW33NjKSRFuT?=
 =?us-ascii?Q?/Tla+dnn9f3OYrBPPXO83McwVjPbkSiSWWv3YOQlra8u1UPU/NMtBKK4d5Nh?=
 =?us-ascii?Q?m9662OcZnFwNyTIkNa/fYgzC3SoZy8z+oPG2ljfa2BV8E3aVpz5diBlHWMrP?=
 =?us-ascii?Q?SMBVXjdCXqZGy8N0cPG/jN0RrE9L6/QNt3Yff3rU9MVWKUQ0cZ9Mx7VKykCI?=
 =?us-ascii?Q?1nNU6EJCt4ZZAwtCIGPeD4V0sWd3t9BdHT/+bFOhN0f1cv7Z2dAgGLaHPTgB?=
 =?us-ascii?Q?CJ1QpAmLSFBNN0kfTODeb/etJqH8RrEgWgzrUHpLJCUChNEpUEF3xgv+k51a?=
 =?us-ascii?Q?//+fN2quXeUIKmm3bFrJcyN+qfYCO0pXFe69rXT7RllQUCus96t1+Jhmxeo1?=
 =?us-ascii?Q?xGMyhq2nieyziVyAIDDU3KpiKb2dcOHoHSCUE9uxthkyPzKiu+9gfju0jEOx?=
 =?us-ascii?Q?H28m/uQVqWxzZqHRTCUCBfLA12uga7wDy+kSIIZ20igBcK8tAajdDzAkZXVj?=
 =?us-ascii?Q?DENF1vDXdeMFCD/B5JT2WgoUOzRyAAhN0PNBbUySSNR+tIjvwhzVcgkeklk8?=
 =?us-ascii?Q?LvgAAqk8TU88omblH6Gylr4YhS93a9KBpDaYQeb0ncFEmLiLFTjhYIbA/dN5?=
 =?us-ascii?Q?+YtU9xVzzmIQ6rg0kPK55GxnMDPKzzagvZqEZIu/1RYBGzkq10TzKZPNb1MY?=
 =?us-ascii?Q?AWPsiXQgEfeCref1SNt79hfre46icWSueDY26ovHJ3kAETm2Ieyt2BNlK1/+?=
 =?us-ascii?Q?ov8N9gRemTQUpRcqYab3qXfR7pfgrUqTyAOeK5B2zxxPyR2l/wHpyGf7tvs7?=
 =?us-ascii?Q?ZG5gQ312StYkXbFzo9/AqMg9ZXYOh1Rj6dyVBekfsdjsk0G5O0qMbgkJTol9?=
 =?us-ascii?Q?/S3qpng4Eff/+ozEV0EOb6QTi8tDPMIlp9/59FStr6zmS7pnq+i4b7yCi/Y4?=
 =?us-ascii?Q?D649Nv9XgzXzfBJ/NvKyIA0vVqaFPuO+k+V3CrYt/Vklqv64o0PE3hLpXt8u?=
 =?us-ascii?Q?0rY4OW89LFK09yTGbZatzE5tpacrvF2Kmfg4hIobLfdyIsGefOPbHKAelNWx?=
 =?us-ascii?Q?lVi5nhaKdBF069sbqBH47jiW9dFzsUsnZRsjjBjoJAIgnQCLNJkYjNHM5VUv?=
 =?us-ascii?Q?NpMbCg9ubZchFDiOy+uf+s+rkjCjS69SJ1BOIMJZy1S8aE01OhjU5pOaSg4I?=
 =?us-ascii?Q?SQIiMjCSW2rp5bL8OByoWOjwietrA9h9xxIA80HXV0zgXYv1h82z7p/+qpiw?=
 =?us-ascii?Q?+e8QZ1bAuNQXraen+4G+N5mQgwCnsUp65+qp6N6zXMNNec4znBPQFn0XNmh5?=
 =?us-ascii?Q?gzVBnO263hISyHmLk39j6IRuaiYK1XwyMQJnNn/HJCnP/7pSsmAV6KmloYjQ?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf8544c-d2cd-4db2-c417-08db84af349f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2740.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 21:13:44.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqTNCq7TN+9Bm2HZQmA0QBpAUk5XIvzn6w6fLBtNxvUE/Ihvq+6q/JJQQz7Ez9V12TBG/OqsLNsJwv68YlfHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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

On Sun, 09 Jul, 2023 21:44:10 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
> Add a hid-stadiaff module to support rumble based force feedback on the
> Google Stadia controller. This works using the HID output endpoint
> exposed on both the USB and BLE interface.
>
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
> +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	ret = stadiaff_init(hdev);
> +	if (ret) {
> +		dev_err(&hdev->dev, "force feedback init failed\n");

Error handling looks good to me now. Is there any particular reason you
use dev_err here instead of hid_err here?

-- Rahul Rameshbabu
