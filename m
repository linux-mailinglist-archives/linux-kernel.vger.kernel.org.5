Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC817B15FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjI1IZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1IZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:25:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2033.outbound.protection.outlook.com [40.92.21.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA5B7;
        Thu, 28 Sep 2023 01:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3B46QEFe+jNJei0hcYl5+tpCDNPGiC47fAs78gwWfHrHd06TKuMBLtxR2pX3aZDzkofT7ExDCVR3Rb1GyCf7/92/eJDutFzthQebCfKI7MER7YcvnyD6PWTrg/1zZV8ifRg4vsc2QHhjRoI3lESo30V7LskSAFMhlar1D5BMzrAaCSW/IXrP4qgzqz7d08L1GjQjWFqcO9R9lTWLPdQtIeu+KS4RW9vqjcWjMUuNKS+f+N0QNFIW5hFi+z42xMUKW1ePY1EmOM82xWJPDOVMLvYdbygQUUiJuldqevdkqExY2FW2YE1NCOenOWQ2SU64QYp/yLiMZiDyM6fAR1Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqpKF6+PQNamG740LUokeS8o0bJiRZZ1dhN0YMAQOcI=;
 b=abuouaIosjy4/ZaZlJcQKWrxzZgbwUo7V+IITaybstcHY3DVljNVQias2deEfYXTql6kAXDUAawYirqyV9EFwzQnYgtbbBvCDCeJfQEb3HRkY8u5GBtPr814mBQUm6AHkiYvyZXu4whb0FxViKfTZxJJH82wDvWqfPejmT4TmiwCFBnjHhNI3b6BfNbnMEeX3TtoQyr3GF2rr185RKuGo+9cJY3FdDTyfUKTz+IK2Ef1gB37g5zdgSCLnIZRRCwckG39uHOOTsxJbmlKJbS97enqqIJyVVKLqKC802UN8TJMf32uOEx/41b57tD0LH8ljboaASbjdqdmW1ZTjbyq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqpKF6+PQNamG740LUokeS8o0bJiRZZ1dhN0YMAQOcI=;
 b=VEywPeHG9i96TY3mJAC+F8nrPqGdqHtU53Pzq9rNLdW6l2EAWjBCC7bEAZ7eHD3s45d+LaVOEWPFAIx1srZQvPFk1EZEcz/OiDLaz7HbNXrVGWMO5Rox+Uuc+y1a0o1tFOxEzvH5Axmwnvh0wcR5PQV7wWWF/6YIyEZPRh3SrSh+uuHmd+oq6dxSGxSLvraRFjxPHC88JydGPVXFXpcQzAcrMw4vMZFeCWShG+Yp/3Yz5kaNAUORsF0HuuxcVE/wM+qGV+eqUNwXNsnhce6sJwH84tjbR/mTAAOyvJ8DpIQamUe7uEa+e5ZlLgNG9uKixauAFI3/at1/rw4cAG9Yjg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3820.namprd20.prod.outlook.com (2603:10b6:610:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 08:25:10 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 08:25:10 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Anup Patel <apatel@ventanamicro.com>,
        Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Thu, 28 Sep 2023 16:24:54 +0800
Message-ID: <IA1PR20MB49537BCE9EF342B55174B829BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928-bring-gnarly-05eeeb85f3c5@wendy>
References: <20230928-bring-gnarly-05eeeb85f3c5@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5xUgt+3pcnHcJEDvjjDhQqmfUVPx5AxrwhCl9uoQbV4=]
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230928082454.116682-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3820:EE_
X-MS-Office365-Filtering-Correlation-Id: facd1a7c-dc9e-46c0-4433-08dbbffc6e29
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdksl9y5f+LIf1CcR3RDlxEEetpNGMg1fH9FopsL9ZplguMZrxL5gTVNSmYN2Y/q5yFpbCdGR4MjFLq2NoKaP5wirD0S4+KjCRbBe+RdNKYsUv/btuSm38J2rOUGG40iK6fT3GLXF3g7cfIQnKhWz0RNDIU8w8GuOpJVH5pq1shH5C39ZTZF6WH3+YWSq9VBbFHwmiygl+xM53bOigP86QNihlArpkZBeguXutA5Td4qh6ozgRUxXXiBTTvMsv4gzHysjv/K5yrzTMCycmPIwGJPbEkFYsStzItJsxgbEHsDMffYIYDetN4lXBCTgZubPUUz+dQHxRQWuEmdMY/6k/I/88Byw/5PiPpUZKJKuvXnDqCzIXUZwAZlX8WO77CQNmxmO1QBVXsmNjqx3GpuW0Ky3wSOI4zVQrgHIKsC073k97OaCaMYJT4qpgl9+D3wDq+mishMuViI5/JYHEySS2n03tj15NrecaBaNmRSvL7GCYV+LTvhq73lohfjzRG7eo8xyofYCIbfjXUBWTZ4obnZp/t0rovi4/Go0UVGTLnh8LluK7F8pzzblT1KaC/Sl8iTLAWO6D9EgVhDdY9Okr/HfQ1lP8tn5GuIy3eJy2s=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNi2MxSxOtbIfWhdhStknx9eFZEPz6PHObAuiXksJwpfesmq2Hf3Ro4K718a?=
 =?us-ascii?Q?bvfglwSB8dJOVWT1TcI0ATc0BvItQTn1d906NVWREMUkGj+cKpLkfZdDZUrU?=
 =?us-ascii?Q?pQj8X0cbbZ8Jtp+M0ONdrg1025DpUIICYR+GnRRK+Juufe/HYR8nDcWQkVua?=
 =?us-ascii?Q?KbOq/nxzD5RNI0nNqSAEoV/JUCL2oLP55q4WNSGfBhE0zJ0qLToN0mq9bwVn?=
 =?us-ascii?Q?MaqlVAQjs7VdyMYmRBnI/DF6kmrv1ZOK78gGhs+OLJ/qTug4zAmkvU9icdjX?=
 =?us-ascii?Q?XOXDfsl9n+GxECyKZFDH4RjShag3QqR8cI3pQo4SrxeIiI32CA7AQY4wq6yO?=
 =?us-ascii?Q?gl3GkO+JNFHvr4XgW16e3aVn2okNyppQvXfW7FhFhJzsdhIu5KB1Fm5pjSbE?=
 =?us-ascii?Q?LJWViYnxAN8Pd9cKVE7qi9V4MwNs8tmKq+6fxoMAVopdZ29+bwuWV8ff7DzZ?=
 =?us-ascii?Q?9OAjKomIL54j0eqJnmV6rGxtHS9mquilaCDka4q2jwnFsfLWF1WR0s86s4oy?=
 =?us-ascii?Q?KtJOHul8xb8Qk2sqaYZ5xXm+R02hF7CfIpR30MZYq9NvELsisr/j8v1wy5ui?=
 =?us-ascii?Q?YcQ+ZwY1VESLbFRmKo3dtSiAx5K9icEdtNWAUTMdPPsoFmtwhGf26IkvnXuJ?=
 =?us-ascii?Q?83CHDC6l6be1+DUrFgFXYj1IxzPkfpIH08oVxvIe/sfzdrrxJVmH0IhukR6k?=
 =?us-ascii?Q?YWL786Fx74gFjM7iL1ZF/wIqNoJno1btiTUJjnzO31v2jKpqS7Pdh2Qbpp2c?=
 =?us-ascii?Q?52PTFZUF6jGlWx86TG+bAhPGPIOttLUKbuT3EaInAftORmKrQcR349e8rr/s?=
 =?us-ascii?Q?ftzE1jH1CVvwSvYn7ux55Z1lthsZxHvF6rVL7iT/LO+pM3cutfCAZHF2IY23?=
 =?us-ascii?Q?yCcx+Btu7Hw5UN+Uw3allyP6o76RwOvbAWJSSP9wIEJOcbtTsqAMGszfbTha?=
 =?us-ascii?Q?V1juRHdKP/0Pc6NoCmPuGDXEgaGMYLw8kS0+IjccBGX+fhqg5JsmJd5ol3q+?=
 =?us-ascii?Q?61/IavHW3RAo0pCPUcvbbWr/yrfJg0zXrqvm8oTihNk/Jkioc//Ij/mIkI2B?=
 =?us-ascii?Q?LqXNUudbZPyFIHlRBn1rWgnl4so7bddCvcUXeHL2I4d/EW23ywKZvWNSPMbt?=
 =?us-ascii?Q?7qT40X1fYBgPtJevX6gH/6V4qyqDR6z6kVHNdsxgxhM2TAVdBX6CS0a3tDCg?=
 =?us-ascii?Q?gfEzzS+wlgHsakQnqoanSywxoydLS0xcGGq4p62doWEWyx/y0kv52xF6EnQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facd1a7c-dc9e-46c0-4433-08dbbffc6e29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:25:10.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Sep 28, 2023 at 08:34:42AM +0800, Inochi Amaoto wrote:
>
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: sophgo,sg2042-clint-mtimer
>>>
>>> There's only one of these, so you don't need the oneOf.
>>
>> Thanks
>>
>>> Also, is the clint here not a thead IP? In which case, you need to add a
>>
>> Yes, The clint is a thead IP, like that of th1520 and allwinner D1.
>>
>>> second compatible IMO. That second compatible then would be the one that
>>> appears in opensbi etc.
>>>
>>
>> As this is a thead IP, maybe use thead,c900-clint-mtimer is fine?
>
>I would suggest calling it -aclint-mtimer instead of clint-mtimer.
>

It is OK for me. As I describe below, now use sophgo as vendor is better.
Anyway, I will add a new second one in the next patch.

>> If so, whether we should replace the "thead,c900-clint" with these separate
>> DT to describe the thead clint?
>
>No, since that's a different device, right?
>

Yes. It seems sophgo defined these by themselves, but the T-HEAD. Sorry
for my mistake.

>> The DT binding said the thead clint is not
>> compatible with the sifive clint, so maybe this is a chance to just move
>> them out.
>
>I don't think that it really makes sense to do that.
>
>Thanks,
>Conor.
>
>
