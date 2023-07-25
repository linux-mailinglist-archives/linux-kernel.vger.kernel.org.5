Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C07622AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGYTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGYTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:50:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2118.outbound.protection.outlook.com [40.107.102.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41510D4;
        Tue, 25 Jul 2023 12:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LylnVk7WW1C4HJ6pXjS0nhai3RStKXiXBOjvye0qfbXzFhbOLLLmKuGp7YcdBG9hE6N1HzyHlptGIkt0j4kK/CkmYdnezMmt1yCNOiBrj73bHcfINejzFKddVrjXPOr1WBTIOo6hdq5LqLX5IOhbwz6UQxdPveUv8jvsX/+FG5VGZQdSv6CUpjBsN9IOXkoKDCo+0MMSgLYaUBGQmhCr5iCr4dhGGaJJZo4JpR6OdGh4Wd1qMK5DQKsgdFJu14mItEGDe/BzMvXFDNYWxCh3jBdtWKdYBuRi0Mjs/I59AzBT1ssdWufFU9NzJs/FAOtjlJh3kbMExO49Ipp4gv6spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIZFrdAvnjdSbi5tBtDX7CsMXQwWH7kGYs9tRGOOTQE=;
 b=c5uSGWd5WlUZDsfXWUav0tTS6z0OJY+wn/gJSS/xTABedh3KT9ymJSlVrUKHPIV+pCvk91XLBk78NUx0BnGc19C+AVHBvNQJrc+ylJ1V8SYUkneieAGVRB0zVSYySr3pFWzP+MTf3CuuKlH8uPjYyaa5iFRCWx38BMZJNnMaD7kGHZh1rXIyvVp+r/x4sC5W+F5mQuFtPowJP265fEMjkqTTKyZSd3Mes6rGx5bq2oHmrblMkdHRv8RK6F0CgY2rpZXPfD06EU3MmYv4gq1yRIWA5nox19XuiNA1RjkWuvYF3MvlhxRWjuYVmqf663BDdKwx0qDEv4nN85Cu2XPSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIZFrdAvnjdSbi5tBtDX7CsMXQwWH7kGYs9tRGOOTQE=;
 b=klaL49PqRyItwYhvTaqnmeLqrxiy8AtDL6EQveFnxaIoppg0u7caujRdy0fIt/HXx2OUXAnVofymR8p502YUw93ECv0uL52e2P1UKLsL8QQ3r91Hdb5zR26b8wYtO5ipG3EGOe+uhdhPX6EQxm2jYWb8LzTBlKfHg7I8ud54i3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5297.namprd13.prod.outlook.com (2603:10b6:510:f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 19:50:53 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:50:53 +0000
Date:   Tue, 25 Jul 2023 21:50:43 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Message-ID: <ZMAnk5Kl3qp17fko@corigine.com>
References: <20230725032451.505189-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725032451.505189-1-rkannoth@marvell.com>
X-ClientProxiedBy: AS4P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d015b64-fd28-4e8e-e799-08db8d48743e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tQLgncjiXCHHwJUyT+rc/fnjL4VEsH2RGG3XrPd3hKe2ALWbaTT3xT3/Wdk+7beDSIJ1Hii9dsCnU/poTu5sf8IWwbwPZgBKmJS7tU9LSmvX69I1R5HqwGcAR9Tc9BMcHm0l3+JT5K/vcwGCF2eyFNVs3Vyq+YuI3CdaeQbnfvYA6bYQYqs0Xm+w6yIEMcsIlLHk9LoCRirYCWUtv1IKxydVFKcJIxvGB40RcSjmXHtL1j7pHLXgJfLGOG7sv3vPaPHyQ8wlk/7mSYcKu7C9MBuLNMjaot4dnYS4iXTtvfi6TPX3bvK4gx+i1K8HGRrfrkIfurI26LYu+z3Ew12TM5I0d1tcu7V5MqaAQ9Z/npo1HQxWxg3wZBRmY47NhdEZo1SPp/r9jJ51jbt5mYyDHOIzB86mCnpZRztXQwdZBJL5bhCSROYdoafTvzcowrMAP9xSnzu1H5yoaObLDEkWmiiHTluzaPRBuCmje8SQUmWFIkTAK7vpBkQ1lezJh+a8KjmKd6rChebka/I07O84wAEiku1PVE1IAVx2YRnUmKEXAQVWVrWQFTBT7Mhs/OVJJZa0o8mjMmktz9CUF163JFflzwfPQV6fnJLtdP6/ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39840400004)(451199021)(41300700001)(6506007)(186003)(83380400001)(478600001)(2616005)(6666004)(6512007)(2906002)(6486002)(86362001)(36756003)(7416002)(44832011)(6916009)(5660300002)(66946007)(4326008)(66556008)(66476007)(8936002)(8676002)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rEd2o5jmg9xd1rSqNv5w1LPEQexgqIAmxQ84NicQkeKFNUDD+GoDwW7hRcF3?=
 =?us-ascii?Q?/xiNaBETv5p9Gd+sYNlg2XrUQMV6a0qk0DIqhAINliCkVr2l8TKl9J4bAo7d?=
 =?us-ascii?Q?RkLeCxejDdHO+kBEjQ8+mPqO+oXWWAdiKw+hlMwOUDTEzA6YIzPTQlYiYBYn?=
 =?us-ascii?Q?Wb7HqsI0XB/4RTf9P2qTZT8Eu5T8XmRjST+D3aXaKgHQB6A3U5WUg1hE5n9W?=
 =?us-ascii?Q?8ByqpNfZ5ZvSVxOFqSeZyQNZXpMiWQAWhsXVJxC+h0TIUHHggvS/V2jE7BMc?=
 =?us-ascii?Q?rJXBpCyVuMh3Xj4udEFPTLNRAs1Y30Mj1/uAvzSIJqwMsHRXr5vX9NMGoDJz?=
 =?us-ascii?Q?LB1BSRPjlBpb047gFSfAAPwboizWXX2iumKewTUmtSxHWp4cnQx/Ia3vA4Bz?=
 =?us-ascii?Q?DeNsOCjkjNB2YJJRm8WsgwAhzFFDbgsrEuHuXzwnR5wEM0Alu8euxv3qTeS/?=
 =?us-ascii?Q?vwx5aflJnsQKKaUOe7Caz30qUF0jPK0tbXJqC5XHFHTykRElnHT0jF1lASGr?=
 =?us-ascii?Q?UDoNruIoNxJ1d4wyobWd6CfZCQ3gbuUyz9szWNKrzVHYBZFyRXGoApyxD9Ur?=
 =?us-ascii?Q?GiGw1hlxFiq3RM2X2cauEOw7HaSLqVFazGrIolPloIuqo6bFY9t9FvEpEcUl?=
 =?us-ascii?Q?hxG555T404rDsEYhomlVLKJ5gIE6Q2KiAbOwjKej+UmJiOx0hd+HNmsGXUHI?=
 =?us-ascii?Q?Cgf3IqxBjg4xXfm9WAQDl6GI3WtC7VjPDxWT8Pve0+Jgh8kiPeQ60TtAMlX6?=
 =?us-ascii?Q?FuJKqaTLHzvz/aXusOc0Y4Lybglg7u8rVUReDVR/TNW5Y0aVgA8G0dmOh3Ep?=
 =?us-ascii?Q?zOBJ3VCnlzDX3gPpDfBcAp/ygGSn8v+5JWr+MJ5Ngoks3lZ5yNxQ9wPLKjAw?=
 =?us-ascii?Q?j+/bkRTj5OyitbLAy9SBPid1qdXFJ02OyauUDzxUWLRQqiDola5PiNfm/hJs?=
 =?us-ascii?Q?KohqXF0v4BLHOVH9p3FdNoY+JjmmAJgtdxcj9kt0NWF+ZERgl8r5sLNPUymT?=
 =?us-ascii?Q?S3337VNbPToYq6l0h0XZtXqLT/MWAPtVHxHeJ4BAU7acDe1kKEulFO9QB52N?=
 =?us-ascii?Q?a4r1z15+wyL2bkdItlnzixGw8PCjQt8cgd6Jspoi84V/rYlOnYhogfO+aGoL?=
 =?us-ascii?Q?2dXoQYPbKk5GBO87v4la4Qn7cFLgCI34olx9P2VZWFAv7X6CSED8WoB9M8aF?=
 =?us-ascii?Q?zmbmbok82RPm037IRjjTUI+ZCVfIf7hMp2uuJHkWNhfynQFP8KNdMKqow9iq?=
 =?us-ascii?Q?tHGtJxKDksY3zn4k+qw4IMLXTnnJQ4aCHHxh7XCfdG5yMQBl6xu+iN/is9rt?=
 =?us-ascii?Q?gaIGQWCg7/Y7eSYgGM0zLl6emqMvOlMjBotvVkS1vPfn6acATsUoOjAvZVzL?=
 =?us-ascii?Q?YT/ONLDEH7CYY67Hm32h2HCcvJojpFYPbQIrkj8YMyfGvpUv3F3Be3tiq6zK?=
 =?us-ascii?Q?iZrqDRdF1LO1yEGOWp5Zct7nByOrPSGpeqalEYO5QdOHWr7jiVSflneiDg+a?=
 =?us-ascii?Q?e3lu3YulCCV/Fc6gMq9xYWw9FGZZt3QQ+PIV4f6Y4YatV+RSneB2EmpeE29F?=
 =?us-ascii?Q?CqloeJtehTGV/baESyC1PH3RU+7m2EcOiQMf664reJHCvQgKEPtaE10qHJiW?=
 =?us-ascii?Q?5WRqLP2mrFqlaBU6tynqzkERK7b1gIIkno7pEZzmNIAGeQmFbCUqC4KYCOqb?=
 =?us-ascii?Q?rdVUFQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d015b64-fd28-4e8e-e799-08db8d48743e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:50:53.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hmpqVQgFhuOHJ1qIxLZ5r/C+VQB1L/sMvrUyz4wOPGr89l8mpu9+hy6jnbv3TULe6zlY2X1+xQZQkpvSQXUOGGbNj4Si7P9/3RifSGhkPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5297
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:54:51AM +0530, Ratheesh Kannoth wrote:

...

> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 8664ed4fbbdf..ffec739f049a 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -301,6 +301,14 @@ struct flow_dissector_key_l2tpv3 {
>  	__be32 session_id;
>  };
>  
> +/**
> + * struct flow_dissector_key_ipsec:
> + * @spi: identifier for a ipsec connection
> + */
> +struct flow_dissector_key_ipsec {
> +	__be32 spi;
> +};
> +
>  /**
>   * struct flow_dissector_key_cfm
>   * @mdl_ver: maintenance domain level (mdl) and cfm protocol version
> @@ -353,6 +361,7 @@ enum flow_dissector_key_id {
>  	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct flow_dissector_key_num_of_vlans */
>  	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe */
>  	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
> +	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
>  	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
>  
>  	FLOW_DISSECTOR_KEY_MAX,

...

Hi Ratheesh,

With this change, this enum now has 33 values, excluding
FLOW_DISSECTOR_KEY_MAX.  I.e the range of values is from 0 to 32.

But dissector_uses_key() looks like this:


static inline bool dissector_uses_key(const struct flow_dissector *flow_dissector,
                                      enum flow_dissector_key_id key_id)
{
        return flow_dissector->used_keys & (1 << key_id);
}

And the type of the used_keys field of struct flow_dissector
is unsigned int, a 32bit entity.

So an overflow will now occur if key_id is FLOW_DISSECTOR_KEY_CFM.

This is flagged by Sparse.

-- 
pw-bot: changes-requested
