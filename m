Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B22768C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGaG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGaG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:56:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1CCF;
        Sun, 30 Jul 2023 23:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRMvLXo34UhUu9EFZr9FzR3u7sndL46eLhm8Kcv2nvd4PpP0zUahXIy1ztcsaKfrgEqWvH8KTjM0JGLl3zVKiY9Y91urwUg7XhMfnXM0ZtCfeGn1nBnXITman9x3v+QubxHN+b1RudURQYDh3K/fVbJ6zgu9M0zJll1M8BeHlgbjqBni3gn0r8WmO2ojhtiDTXgtAMhh3KsmOieAVLmBGA7d1HtLAVbKVXXB9xiWqtbTaEds+BffesxI/dPk6gKyyEdGwqhwqVY9QZNnUz+UkgKswZhPy5TGNnd6KR7AM8WB9fVEa56xPxg/epelyRj6i+mk3+eao2Vlba4g/svaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYTDNjOuBzoqTp5mXAT4zQqVxunRjtBXeCxBFcLOpEY=;
 b=NFwvl94eVxAMwWi36ktgu+yongK7GUAigaJXKedyXRg8HPCwQuIIvYOUa5xAWkapgi3gnMdl7/gP6j8AgKd4LdlV1nP/nNEu0a/rMnyJkCzMgb0cpwvpnilCdqBm/1KgZLeGzw0zy55Dt6XtVg/p8tvETwm6xcwhwc96bMbi0N22mTFESSGvlBfzVdwpf38ot0rtiobs6jKACR2VhYJgRam+uS24503YyV1vCPPjSo3+jlgfiILt3ZJUBxIql+lOtA+ZGzMTceChNUBUwfC69+HzQrRYUWJS74ez9PmnTo+9T5S5/YxiH12GGBDJEpPtjStTXtsa4vXalxL2Qcz3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYTDNjOuBzoqTp5mXAT4zQqVxunRjtBXeCxBFcLOpEY=;
 b=k6p1fhJjacGw5ES3xfrIIpew0uoKcmfK7QkQRS+jyS4ZR7vVFqgZERDL1GOZzEMY+P02ocj3XWF8zZU4G8pvfi8zi+XtkVYFJsTdkW6kY4g3t3+pmDGYmStNLGFggataru+UWgy0h4B4q1UqIsrB1HivoV0qke3K2hy76G4fixo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN0PR01MB6957.prod.exchangelabs.com (2603:10b6:408:16c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Mon, 31 Jul 2023 06:56:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:56:32 +0000
Date:   Sun, 30 Jul 2023 23:56:16 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] perf: ampere: Add support for Ampere SoC PMUs
In-Reply-To: <20230728132928.GB21394@willie-the-truck>
Message-ID: <758d060-39c7-317d-9a73-6ca4f4809fbd@os.amperecomputing.com>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com> <20230728132928.GB21394@willie-the-truck>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:610:75::26) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BN0PR01MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baacda8-9d10-43d6-2fa2-08db91934577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqiSnLkbRn4cja/krZmWCY4eMbiZa9KCET0PauA9KxulBGz9DXvzmuFQPpJ56KToM9bLr3c/cWfM2hu6M64I6HP5Y6yXlNeEL4OUNJ8pRcWLw5Qle0Dh4Zx7xpOgVGIzK8FPKKwKCfwPvOpG8ZYqg1ji2xy2awgxOafizEFWvwCqaFviZmpNJvPNLqJ33RQaIEykICBwxMLuwfkniZ+55Oahk8nIy7PmRf037P5yMX1LRHOiTmjNqJtPppaoOMUKfyOu+QaZB+fZtJqLMG3IKeyBh3dCk7uLDsjNyc8dO0tYl9CfRdkTnvHpJdhWAqMlHOfJtBp8HriFQCyowYRil3iNUwtNMvpvKB1YSIK7vPCiH4cV6qS8viWyxyWorzBljfwiHdCf1jACsTSD7RV0uS3hlEx7PMc9fgAJKVpYdTNA4cp24cYP2xPsPgY3KQ2YBRjsEzLyU9kD3+QZJy3kPQEy+EpI8+Wv+pKTM450NzaPIaSf9zG3hXqrAP3KBQvMU65i6PKioWjBZjcf5QJf3bObRmzLBMOvyu/ZH9s8pvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(451199021)(6512007)(966005)(6486002)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJ25ezjGMTez4TGLW93DEHXT6cmQxeCYH6Cz5qRgjOtjpqVLGm+tZ7Ukgc5z?=
 =?us-ascii?Q?EHZHgXKldyu+N/J0KWuTPPZKWyoCIy+fs0mPrAtuLgLxRgbw3G/3q5eIaaH1?=
 =?us-ascii?Q?GXB7D54LJI+7vq938rng/iLB10LD8EZpzUyoUEZJvbm2OITbVJA35VURSDUu?=
 =?us-ascii?Q?shIg8735OpHxmnbGgP1sdjUHlQm+dQfbfW0MzykzMEWGcF37Y8Oh0AghUTVx?=
 =?us-ascii?Q?gGGaaiqkv+NH53N5Bva2nVd3KTGJgsHBvNOTUrNe9Yxlnr+Dj+u1CU/fvXIw?=
 =?us-ascii?Q?hdYCnRdqLmXzZxx7WeNAR7BR+N2IsYQRY1jWrp066nc5SGFEiPSv2RtZqOKW?=
 =?us-ascii?Q?TYHpDlq0el5daYM0JobpGXWLV34R+auioXiuD0sUAuIOmS+SDKpFuDPmUFeZ?=
 =?us-ascii?Q?IcmH+8VymlXw7HCFqYcAmkNEXQmlPdVPbL58kKhVYgCjFNBV03vr0hbtdCD9?=
 =?us-ascii?Q?ylYt2vBumEzQfujR10YLW0X7+RlslmztuWOL1ZXGjMmNjc1war/wq9OAsK/3?=
 =?us-ascii?Q?RxpLieNQfwfzmHOfcr4iJgeNCwpWh0bYiz+PcBE99qLp7MI9uQbUMswsHSeC?=
 =?us-ascii?Q?v2R+6XOr11qGoTPQfL+r9nZlooUnARMLYNH7BKZYfdVZPc8xDLeL7Ho7b/po?=
 =?us-ascii?Q?5cnc+BKR4yKL+lEDTTbefcKxoUhZXG7jwM/6KNfF9aEJ54yZzET+9EtTW7jC?=
 =?us-ascii?Q?z0982HG4sxv0xol+LAdKqmhFBFiZe267Hcg1LtrRVFy5uDV8lYTLhQ0zVJMh?=
 =?us-ascii?Q?uoaKssqoOfkODES+K6EfoXGHQJHAhNVStsZ0DGrc4ntN+0lQqyBMIB1RDsLe?=
 =?us-ascii?Q?rp7nAsJ8Y2jdnpyGFi+wbYgbZEXQ1yPPjU8VAdR+CnhNEjSGPX4YZLAftWf3?=
 =?us-ascii?Q?LRAL+P+ptKkx0FBUuGZaLF0uHzriJ2zaPfB9ubu0r4tfiTiC12SwBtMV9xd9?=
 =?us-ascii?Q?qj1UhFtnUt+BH4Nq60do/8Oui6yLn/cgV/eMNJ5tY5027JRev4Qaf/22mP0T?=
 =?us-ascii?Q?LhJsocPPkoLZYuOllPkTohcavA0Afid9iIGJu8n59/cvvntoI1K1CRTG5bFC?=
 =?us-ascii?Q?WwMggRu3A7nTlHbFhbMgB6/fA7AX9SEq6qLZRpX1X636pyJbDQDbafRsggUG?=
 =?us-ascii?Q?wZRGmoJ8EGa+w+rZJfZNfEVlz8LpcVCUqHSkh88yZiyhp0SgLNxXYNHKAUey?=
 =?us-ascii?Q?WF+Fx4LFvv7rWjbbEg3488INJiyt+BnawDBCAXjvWSueTUzkDey7Ds00CZQr?=
 =?us-ascii?Q?8rIyKEv+g0c4Yg8vhCe+U7qCAnZTG8mafmG/ipZKnUOwzVOF6/T2u2P350Gd?=
 =?us-ascii?Q?ZeCQZ94lXDckdqqu/5g8/l6DS9r0zK6EVErhN+yAIKPHy2K1wQ0t7y7NJVwq?=
 =?us-ascii?Q?9sAF4qnjzxIkv2iirZGXG4KvSVtFCPfngrre50eSOHzMOmWx1n9HdjAquCOa?=
 =?us-ascii?Q?0acGGDejrmga6Gyxkz5+AA2uM1y9s4ExhfForSgEmSmP8oQpf2DKRerQ0kCv?=
 =?us-ascii?Q?NfO5PTyP0lyPECwPMhmV+r6jAMypREZauoYBJDdHY7rd5nKF2G9oRjhKE8oy?=
 =?us-ascii?Q?4ho5T82SNEbWNpqiMVz7CHkHGjBSTJelvmztiQ7imADOv5Dyfw9KWgfhgq2E?=
 =?us-ascii?Q?LgO2vm3cKgV8zmQUJKfVe14=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baacda8-9d10-43d6-2fa2-08db91934577
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:56:31.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agh+r6kAvahH2RVw3qwpWrXRsdCMh0VTYYd/RuDdMZW1BXGYWEHub3RwMG7mhWuWiTyw8UM8Tw9y+dNloJNaenXCLCkPoXxFAhoDfvCjsggXzGEeZS681ZGFgVN+4QqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6957
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Will,

On Fri, 28 Jul 2023, Will Deacon wrote:
> On Thu, Jul 13, 2023 at 06:01:37PM -0700, Ilkka Koskinen wrote:
>> Changes since v4:
>>     * "Support implementation specific filters" patch:
>>         - Added comment about filter and impdef registers and reference
>>           to the Coresight PMU specification to the commit message
>>
>>     * "Add support for Ampere SoC PMU" patch:
>> 	- Fixed the documentation and added more comments
>>         - Changed the incrementing PMU index number to idr_alloc()
>> 	  (Needs a impdef release hook patch to release unused index)
>> 	- Fixed style in init_ops() to more reasonable
>> 	- Moved bank parameter to config1
>
> This looks pretty good to me, but I think we should merge the series
> reworking the backend registration first:
>
>  https://lore.kernel.org/all/20230705104745.52255-1-bwicaksono@nvidia.com/
>
> and then this should slot in quite nicely. I've left a minor comment over
> there and I'd like Suzuki's review, but then we're good to go.
>
> Cheers,
>
> Will

Sounds good to me. I'll try to find some time to do the needed changes to
my patches and rebase them on top of Besar's patchset.

Cheers, Ilkka
