Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD17560BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGQKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:42:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EBBC;
        Mon, 17 Jul 2023 03:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZkYRbxNpwYlF+xjge687qURE0fJuT0maTyQ2rv4yyyd3bUWm+MmIqPPa4bFP+3VnyuS6vdE1aPgw3jHHAeSGx4LHL5JQcjZqosFhc5Byu/pZm2XkcSFZeN9S26DJwuoQt1Ed3+aMKdEajuuiuKS3grQKNfjAtHbPfxDDNOMoRLeYuF/csfyoaXpsfBjUMtKWLXMQbBl0uPSY2rmhQ9KqK1NDGrHIPbc4ZUfUyfOBX7CBE6Pp049lJwZbf8Lvc8+6jaN1/PY7OfJtBKTPuFb8Gl0xSnJjUTzX9LgpaPv6T3HCiRxoq7wAwenyqHTo0oe4sZlZ/kMe91vRfHfIyAYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVHj3u4pZxnZCGWyZisfQFsAyK8dZyRoV4PONKVPr4A=;
 b=ferT0Vv3FPWZqtuJiRS8e0kE4tB30QS7AtXZWwb9vbUorvKttcwf1FIiA3qShb7BMA2murwzyDYbezEuB/O1FIpdQEx2ec0wqtkLuwOi8eGzH+QiBysdu9joTr+jLl1abBMOLvlxUtq8fygl7xyFbgdJP523nscXCI0q2ipp4YFH1/5f4qWFUzBRjpQFc/Df6sCcRKV5cl0Np712YKqEfXIHswubwG3/jfp2hdqls4ws47ZQftk2frT13IKSzjBtSuojRoNuZo/p9Ouum3o8EXN828MZo9y5ln2fF2TrngfoGNIlnJyg1tAKS2LiSVosm8ccfz8bEXk20iBSVLr4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVHj3u4pZxnZCGWyZisfQFsAyK8dZyRoV4PONKVPr4A=;
 b=mnA7RFap50n7msL539+viR83W/bVLU2lBOvrRjXMj0N5M/0t1aojFNaRpHhfkc2pGQN0S41eRz/DpedV6Ju0lS5Z9GaBaJQkXUL44p4LjzcZEiGYXz1b2HL8bghVsmAYqmz9MxjQ0gfte6WWA5LxA0wf5QeIv1d9hSY3FeicaVVFJYTXE3D6FAMkL9offBMi6ZZ6HqVlz1Np4VNXN5pJdVTNPG6H7oDGfb8SeQC6wf1CwBuHr6zNY5Yh9mYBWvas6gAKMeBT2eKPxlROwnmmBEDnt+n/RP+PvVCjPPimH+26rze3qpE8Uu0ATFOLlPsMnTke6CzXvoIes33cU+Vong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 10:41:59 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:41:58 +0000
Message-ID: <7c879ceb-9133-5794-5248-f44160fec62a@nvidia.com>
Date:   Mon, 17 Jul 2023 13:41:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Content-Language: en-US
To:     Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230707122627.GA17845@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9fa700-7605-4894-44c4-08db86b27253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nu97Gqd54mWxu8qjC/avpYOAaz4DHzZwDJj6UqSWBv1P3CaLk1rWJBshwaXUTMUqAIFDK03rIlgEPy+FlvGVNVhMWuSON4cc3G3/xMUKdJP5tajc38oaF0D6fftUWCy5z+2pwsVxCVd8LJ+cvsXI6cnOSCfvlk0SmHQgBriht2eot5uiVDG9iAC24lSkg4CqbjJdQn/QmqLl1gg8diWZIuNa1Ppkx5YXhaMifAtoDOeBJqRQNOI8IYBGNSwQtcQd5dn8CaCLp1u298IScJHrpiGMZuMxpybyXDTkQGGrCUGqGMnYFp6CR817zpIbgbvNJHE3n4nirBmHWfwN3RUyiIWZijpLSEtyeWbi4mxcoMDq6+1KIbPupzVy/vgybk4ZiMkPKLPxFXfErEb81/B2MnjQqF4d7zuUGYV5RBbOzZSVPwW1GlfxahdnYi0Pe1bo1QtHP3SUWhVVgtDSVP8+jCqexJih8kRVub0venRF/JfMXSZXfSLhadzEB01sQN9bzo7VV0h2RXpU0sSd0CbEpIfn6XZaI0qh/nq3inm0KHJDATazYAEM4mMYWhOnCBism9tcQAWpEIGQqi+FX/ASF+X/uK+z3KDPrwHt75MOpsv+6RMqjkxDK/wPkH77KP428AothWtJAw0Y7w537jAqqCvjjMr/7/EU8kncbG97XGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2616005)(31686004)(186003)(6506007)(53546011)(26005)(6486002)(6666004)(921005)(478600001)(38100700002)(66476007)(66556008)(66946007)(2906002)(4744005)(8936002)(8676002)(5660300002)(316002)(7416002)(41300700001)(31696002)(86362001)(36756003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2l6b0gxbnU0WGw1azlDaTlpbWdhbnVmcUgzbXgveXFrTFpBZktWYmVnazNH?=
 =?utf-8?B?dTVYcWRJSGJEZU9wb2poL1BUSnNwZVkxdkl0ZWI5aFpqZS9naFp1UXpEellY?=
 =?utf-8?B?MTFIT2E4NmdOQy9ES1JGWlZsZTZVaG9rZ0NwQk5jOFo3TU1MbVlnWmtmTkRm?=
 =?utf-8?B?UFFLNDdGQVhDRy9hUlJXSVI5eEtFWnJVSFlOekYxd3ZFZ1FPR0JGQ3VKQWs1?=
 =?utf-8?B?aGU2cy9Fbm1CaFFEczVYS3p1R1BHM2dxY2M0RU5tYVB2dzRnWUlwTkFGeTdP?=
 =?utf-8?B?SllTeFFBVFkrMklSOGNBeG85a0szYVhIcjVERm8ra1B5QUFaa1Vvck1EbWdP?=
 =?utf-8?B?UDQyRDBsV09LNThseGxZeENYbkxCWTVMZjJRYldOL1I3TlZNYitveUtKNkly?=
 =?utf-8?B?UWlqQWlYVm54NFRVeHVMRTdqMVFFSmttZDJhT3VsRmRiTmErZXdwOTNuWHV6?=
 =?utf-8?B?WGpINFlIWUNIQXM3YjNqZWFJcmxRTHZRajdPdStMVndrNjZtMmxiRXJ5K2dp?=
 =?utf-8?B?ZlFySHphY3E4TVhhVTlOSXU5dlJXVUlibU1JZWtkV3RaZGwvTEt0TEUrU1lG?=
 =?utf-8?B?MlRSblJ5RkxoZlNuQ0F1eTdDVkV4dlhuZHNNU0JoWlV4QlF3Y2pmczhmekVS?=
 =?utf-8?B?TFAvZ2U5QjdWS2hKSjQxOXR6Z1RnZFJEUHRNQWk0MDhza0w2Znp6N1NNbWFs?=
 =?utf-8?B?eHdRWGxDb1VzTHA0STNMZDgwRmZOYkJiY3FCME15K0J6UWUvNlk4THNKUm9C?=
 =?utf-8?B?d0FBRGhxZUtJQ1pLMWR2K3JqMTcvRkxWcldvV3VCYkFQZW9OczJKNkdHc3Rx?=
 =?utf-8?B?WFA5dGRRUWc0MEpOYkJpV1pIcDFMVXBhZER1NDVZOFp3RnZWL1Y0S2JrUHN2?=
 =?utf-8?B?WG9ITWxNbVRBVTNMQ2VmTkZNdFNOY0FGRXY0S1J5VThWRW5ONzhkNjV5MnRW?=
 =?utf-8?B?YzF6WXNxZGp4K2hkc3J3QkluM2t2TE9QcWViaVFLdnpueHBiL0xkZVljQ2lv?=
 =?utf-8?B?Q21DTGpaVE1qU2JzT1NiOTl4bkhrT2lVMjVKVit4WWdVdVpaRzJPb2hsOWIz?=
 =?utf-8?B?MHN5R3EzdVRuZnBtMVU1NmtWa2pOVFk1Vnd6S2hqL2l1SXdiWDE4RUUya3JQ?=
 =?utf-8?B?bWIrc0lMZkExOGsxVTNvM05IcW8yaVJiVkFQblJhZWZyZGlEYjhVVnJleVZM?=
 =?utf-8?B?bWhmcDk3bkdmVERaRmt4ZTlJYkVEd2IydTVsdkE0VU1jTzJvODM1RTAwSVZI?=
 =?utf-8?B?TmZhUWhOMjZ0emN4S21yUWpUWWVNMW95Zkh3MWVQWVE4L3JZaFNtZHNTQldo?=
 =?utf-8?B?TFdJQTVxTUhhUDZoSDhYd01BaUFqY1NxcTBKY3MzMXRWTmlFVEVPeGF5bFpK?=
 =?utf-8?B?SVZyU0ZZbEJ6cU4zOG0yMWd4TWgwL3ljSFhCdjJtSG1Yb3kvejgvQm1ZbDRi?=
 =?utf-8?B?M29ETVJuNzVML0hRRHp5Q050S3FEYWRFdkNkZEdCbGJ3RHczc1NQaE56RVZv?=
 =?utf-8?B?cExkQTR1M1pKT0YyUDVBb2p4U2tUSlRvL2EwK21tUFpwYUNOSkh3cWh5ZUNL?=
 =?utf-8?B?YmtDRjFHYVY1S0RPbG1RUXpVQnRGQUZWYVdaTy9OTGlwK1dSU0N6NUdxZDcv?=
 =?utf-8?B?WWFNbkdWdldkVzg3N2JBU0FGVTlwMUdueXpWL2RtTnQ3VE41dGtmNUhLVmRG?=
 =?utf-8?B?aHpaYVFnYU1rWGhEZkE0RW9XbElKazQ3ZmFMUVFzcjVtQlhQWTh0eWR4c0R3?=
 =?utf-8?B?dFY1VHppRGhuOGwxVDNHWU1iK3lsOXI3NlZSbEdYalQ1Nnh5VWhMcHd1N3Mv?=
 =?utf-8?B?UDRLSGhCc2ttcnNpZlZvbzJ5ZVh5UmlwWUpGRzhXZTdNSm5RMitCZTcxNTZn?=
 =?utf-8?B?ZFo2ZTV2QXMwRWRYTTVCbGJ3UFdPc3IxMzQyNWlvUjZZdVQyWWNhdVFkLy9K?=
 =?utf-8?B?dGNFV0E5ekZydWtraEF2NG9sUHdFMVJLVGxtQjFpc3BkdWgwNkd6aDVTMzFK?=
 =?utf-8?B?eEZrQzltN0FyRHFpRzNuVGZkTlFqZTExQyt6QjVWeVdqb01qMXppTlNyTnZD?=
 =?utf-8?B?Vmg5ejJiNGpScU0rcXczYVFoL3AxdGhSWDYvaUhPTXdZaDA3WkZkSVZ1eEV3?=
 =?utf-8?Q?p9xrykmpXTJzyyLAiN4bIvPbj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9fa700-7605-4894-44c4-08db86b27253
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:41:58.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdLRqw5pGWNmHXOGps115/CwbpIhnFKLg/MLjW0w/P/EqyERb8dfJFu14gQviaQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 15:26, Richard Gobert wrote:
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
> 
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Hi Richard,
Are you planning to submit a v2 for this patch?
