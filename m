Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA29785AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjHWOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjHWOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:43:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F3E69;
        Wed, 23 Aug 2023 07:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAZG4/QCN/BzD9h1xwcfHTX83Q0/zy2/+GXEVynT7Q0F++Cy+HeRMBp3goUamclINQo9jXdeH+mkqXB3t3CnMF9GPZy7xV2BLDaYUhlN3zthqtfAQzWfV+qN2Dm9q53EsKY6vBTseEPKoduLenTCkQ7ZiNRsu6qynuY2/12cOWsIn8grMjav7vLiuYC6Ab8w5wwdoO2qFlchENCjRHcyVg0J5MIuqGGkb5eYPd+efK8MasQAqD1O0OyriExEnXjM1OgsAV1R5CWvKY8otk4rKtqJlSt0gUb/4PYsQz9E53gbVjFUJliXyGqqI5xxNwAbWusmzQOaQUXQGcDh2oU0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frq/NU3jHsheS6ovx5bYTiCxAO+vg5nPKIbo6BWhs3c=;
 b=UVC9AJ74zS0Fl0KVfqDCU0wIEhXASON4XuWF40CKF1crqDs70aMTNf394/8Lr4Q2m4EgV+74vGZF8pMNQ0xNhyyfc60YTAz1DWLKUrujWQGD/RSkkwZoHZkMAT8LqJ5z7t7eDoVpWBPD7korUKpkdDO4cmv25gbLmrx9ipMzNFnB0uE8Akl5igQtxTN6jt2hSthzNKkk1ejSgGWpAjyZX6s6l7/CQ4PA2j4O5E0jfc5ZeLnlGg/D4152lzRh17JWaotvcIVC4JFzhei+TwGTmb04qR/tO3B4nERThhvu7hXZpNyynxMOran0DcvXyC+hh0QvcuxiDkV5nBIrsCnmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frq/NU3jHsheS6ovx5bYTiCxAO+vg5nPKIbo6BWhs3c=;
 b=rEtYA+Am3qndWKd0NQDFX79j3E/XcdoRMKOC7pdSMdonh6+uKsILa6BNxfMFRBc4sOq5mS9rtvOzJjDazxak0qG7IiubAmBzglvPADPx7RdLEm2IagQnFYPHGyybwOhBZznLN21jQm6bLWCaWyIxrsEsUbzxSv+AWjXX9LI3YNfjFPXpInWnFaUPMgI7N+6ye31KOcM7Fdt9gXfsDWezs8gqUAoOo8yHeJ6hkHRsYAstCXnXrQTHDUf+mVo2SoQ6ND7U8gt/FQqNhCFDSu8c6kO1Eit5/zFkOXIooVmewhLx0CoisqyOrmxAVq1dOPVOi4wFBUp41wpAyi4lqDfBYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.26; Wed, 23 Aug 2023 14:43:38 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:43:38 +0000
Message-ID: <d4cc1576-f4c3-a074-9bf4-937cdd3ff56d@nvidia.com>
Date:   Wed, 23 Aug 2023 17:43:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     David Ahern <dsahern@kernel.org>,
        Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
 <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
 <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ff2e4a-e2f2-4877-526a-08dba3e75614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkUmAf5A4RPTSHBEKkZ9Q79dVxPG10rTw7LYubMqhfeQWAotDNjrhT/NyhjeQ7MKZeGTgNdpQbQkQdN617Ylc1czxqDLeUHYJLIRS7hMZRTQXK7L+jRmSE2KaBk0MTw/3aTlQXPCZvfFhw79/NkJEIJQY+58rE7T5eIyZuwjmPojN5DnD36U7Y3Y/gRuHQ25kq/J3+D4pxUxlUvU5SnbMPUMa/VbTFmRmTK+7w3J7ueeEfXoHksxFYn17lJVV/St6Rk7YNQyVQFJgXQBvewrui1xXo2lGX985x2drJYFdumGfSCP/4ZKLIw5eGC3o+ahPKToF/X3b9sy2w0m7bHIS3VQ9fZ2tKEeNPebWi+T//eOYIXtEFM1JCmANWAz+/o2boSr/M4ByQxhY7IP5HfyDoyVI3tXX/0mrX10Deqb0AQJFnV/cBuZA8fSfYsat2l0NsNLjKuGwAHsSD2DufbdP5T9gOKreIZlbFonV1vz0xB5QP8jMasX7WX1MJmRrlJMfKpmhs6BtEutNLuWVgb8kKn+EH8sF4Nm+Fy6muw/04+paYmvg21qdE6o0XO754KPIu1dQOtXmXfHTMJoT9fR4pol3SdeT+OoRYsiMi6hd8+oEvltlwRZ9q0VPaSS9cFf54poeFWzjIKr8PHh913MyAz9BvE1o2FBgG5Gh1xs/nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(1800799009)(451199024)(186009)(38100700002)(110136005)(66556008)(66476007)(66946007)(2616005)(6512007)(36756003)(478600001)(6666004)(6486002)(53546011)(6506007)(31696002)(86362001)(26005)(8676002)(8936002)(7416002)(31686004)(5660300002)(41300700001)(921005)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3gveHczdG45YXozUitNL21Najl3OGlkelpnQUZjWThDZGc5bFR5Y0IxUmds?=
 =?utf-8?B?YVlsNDREc0t5SFBCWWRGK2JlbndrdmxXYkNSQTN6MEFWZUxPWmpWTkVwdjc3?=
 =?utf-8?B?VnEyOVRxWVpJajlxaUxNQ2ErRXpPRFhsZTNPYWoyeEwrb3p2V1lveDhncGpG?=
 =?utf-8?B?YW9RcERwNkt1NVZGNi9NYlU1MTJPWGRyZVc1SVJBOXhtaEo4WHkwbk9ISmlX?=
 =?utf-8?B?R1hlU1JCaUdSMUJmYkFJSUZVUmNjZTZHcnh4ZmwvL3NheFNhVHBrUDU2MCtx?=
 =?utf-8?B?ZDJrTlNXR0NZRGwzTTlpNldHUC9vb3JScXBPZ1VpUTQ1S3RXTmRXRXphYzZx?=
 =?utf-8?B?RE9uR1dhVCtZSGthMWZoekUxRzNOUFAxUzh4c1ZybDZuQUx1TXZ6bFBuOEFQ?=
 =?utf-8?B?M3pFNzFZV0Y4aDljVUwzeGwwZkhiNWl2NkFXUDFLQkhBVUdlb3h5Tk1vYVYx?=
 =?utf-8?B?MXNUakx0SXlHRjZNYUNSanA4V0RzVFpnbWJyQXNXdjRMWDRsY2pmTEQzQ2U2?=
 =?utf-8?B?NDQxYWtTYnlhTVZTSmZtcEFOWUs3ZFdJSjR2N0pqNVZJQk9sS1VVMFNLaFE5?=
 =?utf-8?B?RHJsUm12S3NxdC9BWDZwM3RNWVlueWV5cjhiVVVFeVo1ZUY4SUVZenBkM2p6?=
 =?utf-8?B?ZWR1M1JMUExTTlduRUFiYXdobUhLa0hPUFoyMU93UFcxN0JKcS90UTkxK05p?=
 =?utf-8?B?OGUzbkJpUE4wcHNWcExlWWdvZWtkZmo2dG5lWTBUMFhYbVdRTzlZa3kwL1l1?=
 =?utf-8?B?V2RoNHVjdUZxQlZoaDBxQy9BbW9xaWhyQ2VneGZieHQxTHdQdEVFbmFzaENs?=
 =?utf-8?B?MDYxWHk1a2FiaHFKVFFFVjVWQ1p1NWdKS0JoL0J5S2JJdmIrV2NNZHMyWXJu?=
 =?utf-8?B?NFY0eURSWkdlUisrZWlHMWVHREtLY01lYUp0ak5VTmh3bXppQmU0NWhpZWJr?=
 =?utf-8?B?VlNCakM1WWpxbXE4dUJkQmF3SWtTZU9nT1RGNGNVYlJuS0pPSmVOMUpOS25k?=
 =?utf-8?B?VlJVNUpQb0VUeVJwRFkwa29DUFpIMFJJQ2R2SEtjSThJT2kybFFWSnFWRllQ?=
 =?utf-8?B?Yis3aENkdWIyZFFEMzluY1BEN0xJSy9zSk1yUHlhcVR3VDlKbFN4VzZVV05V?=
 =?utf-8?B?UE02ZzFyVy9UdmpRZWZQOFdneWxEL1E2WWhPbTFrYVdPK1VST3VYb2pYSU5h?=
 =?utf-8?B?bXVWN1YxZzZhMExHTnJ5V1g4QlQxNkJNeFRsZ0pMSkswbkxBSE50bUw0WHBs?=
 =?utf-8?B?K25QSzl5RVcya2hqblUvaE5mNjliTFlzSER0Yk05b0twUlRUR0M5RjVIbEJh?=
 =?utf-8?B?aG1JcFFERzJlV3E4WkF2SHhnSTlUdVNkVEYrUUM1a0NYOU80Y1ozanZZeFZk?=
 =?utf-8?B?aDAzRUhSaFBMdWl1bHZPR0R0UW9TY0UycVNaSDZyaXJuYk84Q0h3SDZzemND?=
 =?utf-8?B?dUZ4Z2dsbjJwZ3hEK1FVOUIvZFlLZkdIVHcyQnJmelV1cTlCakpSS3BGdjNk?=
 =?utf-8?B?K1hQZGVmZHdWQ2k4NmpYR2FLZFJSUDlvbnJuc0Q1eFhUQ1FmUm8zQkNLU0k0?=
 =?utf-8?B?cjRJSmE0SlByNnFSdEpLVlB6WjJqZnRYdUVTTGlTWjV4NWVwQVNzUXErVjhO?=
 =?utf-8?B?ZEhLQ1Q4d2VJcGNjaDhCTkFEbDhRdnI2NTJUTytFSXRzSThsMUU3OWRCM3pX?=
 =?utf-8?B?RXpCcHgxVG4za0o4SUc3eitpUGlWN2RGWGgzdXFWdVozcW1aUkdqVzZhQ2p5?=
 =?utf-8?B?NzQwZy9ab3BEY1Y4MEpyd0xGVTc4ZG5Telp4Rm1NYWt1S2o1K3RvNlJuUjRY?=
 =?utf-8?B?amdYV3hpampGUllCdGk2V2w2YnprcE45Ty93L2tYTGpqVFV0WFhaU21PYTdx?=
 =?utf-8?B?bW5jdWwwZnZRVGNZMTFldnRhVll2eVFocGg1NkZuWE9DMnFISjNzS1VucmNW?=
 =?utf-8?B?T2JXMkhqZDVaTFFud0U5VnQzbys3VjhFQTQ3Rno5Q1BtTnJhVlRLeDliczYv?=
 =?utf-8?B?SGJQREFBd1UxczJGYSs2UWlFVXZ3WEVpRjJ2aE1lVmlRZmZXcG4zNWQrOFhS?=
 =?utf-8?B?RDIxQ2xnajNoYUxnRFVqS21aYTUwT0FBK2tyNXZHMUl3OElzaG5MM2I2YUhL?=
 =?utf-8?Q?ZVUKVsQJL71tQxSBdrvI4MA2a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ff2e4a-e2f2-4877-526a-08dba3e75614
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:43:38.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP2fl9xJKZXXobttoTdt066vyjcu1lwMiMqyA+BFH1jN1qqTSWqesyBAvYSSJ35f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 17:19, David Ahern wrote:
> On 6/28/23 6:42 AM, Gal Pressman wrote:
>> On 27/06/2023 17:21, David Ahern wrote:
>>> On 6/26/23 2:55 AM, Gal Pressman wrote:
>>>> I believe this commit broke gro over udp tunnels.
>>>> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
>>>> is pretty much zero.
>>>>
>>>
>>> Could you add a test script to tools/testing/selftests/net? It will help
>>> catch future regressions.
>>>
>>
>> I'm checking internally, someone from the team might be able to work on
>> this, though I'm not sure that a test that verifies bandwidth makes much
>> sense as a selftest.
>>
> 
> With veth and namespaces I expect up to 25-30G performance levels,
> depending on the test. When something fundamental breaks like this patch
> a drop to < 1G would be a red flag, so there is value to the test.

Circling back to this, I believe such test already exists:
tools/testing/selftests/net/udpgro_fwd.sh

And it indeed fails before Richard's fix.

I guess all that's left is to actually run these tests :)?
