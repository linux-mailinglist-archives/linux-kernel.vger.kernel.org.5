Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F17CE734
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJRSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:50:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B9E119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E62n64jO1Dvn90OzPo8xd1vb6kle9sLSYHBOy7eYH4Zxgu5X9JfFB9FadlaoZUBhV+fRyzdilpfAnkwDPWS/a62WboVF/U8kSgknTWlwjnj+S6Uq97I7SHc9Q+zQDldCN6t70G9MzxsUDCOq930dm4tuX6do7QjMPZWgRejeqaSPZCltuWXyfN90TZq0pvXAiQnQucr9mfIO+i9M+/hP/LFK9A30fAWS4xY08pq9LSzg7sRCT332cUZ1u424+nFX5h3w76slvLXjgX7h9mkrpQa01aTvIhu6aTkczLxE3oX0QTYnyMquaDP0xkRhDdqZ3HF19wyPry6EZ9yN2KwEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C51+ARizfX9PYnHTDjpgcza20RUriodf7Jaba07hGx4=;
 b=Hf08tp91bcWr+9B97/xPEYEG1jnUF/aypy54tJ/sf6BBa+bpsT9FIenN/7o3uo2ug+JtK5Y0CiKaWmubEQ7FZXdXVVvZAk3c3bgSR/dzPwS+anaaFEPX+FbeKCeW2D6PAO7b8M8huMorCTnlGFDLPcFVniWXfVF+O6URvNGXhB8AYllT0jGok6Uuv5TdG06cJH+hAnJeMvD5LP17y6R4FX0jRouD7kPA8F00kZFj84qgqnezsVhor0PJD7MpIscfPzuqSLYbmmF+5dbH43hGpjuVDuL+dI30pSoi265kydIW1cB4zixUgsKq/gg3fAXB6SbpdSdE9CbdVXVnaSADUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C51+ARizfX9PYnHTDjpgcza20RUriodf7Jaba07hGx4=;
 b=I3CaqMR3VTva/Rp8AQpTFqMEUrCsP8r//F63XRzDS1HKpi0aGiYxj9zI8OC5yJa3uW3rjjyw765vliPuiNpnbKPOAH+590wfLWI2KZNtPje6bx0WgFNGNt8toSIcu9NtSHQiDKbdnhlpoP1pMSZrDz0AnrE6EfLTi2XacnM3l2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 18:50:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 18:50:37 +0000
Message-ID: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
Date:   Wed, 18 Oct 2023 13:50:35 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        tglx@linutronix.de, hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Petkov, Borislav" <Borislav.Petkov@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: PIC probing code from e179f6914152 failing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:806:27::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: df8b697f-27fa-41f6-2196-08dbd00b1dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w65JieqVvoTH6Go1cops1hkrRoWJUr7USVFYWQlYIYm5/NnGILMNW2YoKSbGGUWDdnPxrqD4vxoz1CnvVrorV6xkHQD7lBj48IML95bxAnD5GN5WpKEZoL1zC5yg01z7HPNVkX3JGZ4CcquejsFOCQHixpnACuu54bUsEfdj1Lhw5YeB2OpsrS2mR8OVGwGqiRFIiQVeLJE+1WxbzGx7fkfJLKOr2A10DnzAyBTiNO9NCa260HcI9RBFytZELxNAzRM18FEu8FSOKSaw/+oeInh1RvZmp15NiOJHt4F7/bg152xn4rjWuQ3Mryz1ma5HLnYx9b2nWbge73/OUAHBpJG1fBGyTpyhmI0jew3methHvmRKuKFI9qp/sEJLrxCFO1vOxylDbyrWFvoDrNhz3FA02lfIIkI5GNWAJJdgW7bEtMoLBO1Eu3BSUfhppw5DOIcx657ymdEgXVAKyNAztdn9ny3wb8iIrjysQF7mYEh8T+H9Y1Nt1+G0XQoGGMTHQhb0gD8DLpMFHfpSUCQ+G518fV6f7kexd34CVxy+7ElLBZCP7Lq9TDRHxos+atz398MJBw07kk8+TWZ5JHFE7WYfNoLMlYFoAUyOZy0CKRoQe6mVy9yMRs1Y45zyA7CU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(38100700002)(4744005)(66476007)(6512007)(36756003)(2616005)(86362001)(31696002)(2906002)(316002)(66556008)(66946007)(8936002)(54906003)(44832011)(41300700001)(5660300002)(8676002)(4326008)(478600001)(6506007)(966005)(6486002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1McTU3T2dKWEdDSDF0UTFRRmhMOU5pT1Y2Tk1WVWw2Yis5TTMvS1FzMFln?=
 =?utf-8?B?RDR0TVN5K2hNY1JCc1FYVVcrVUhzUXpQczV2ZkpIZURZczRQdEhacU4xelR3?=
 =?utf-8?B?Wm9OVkRwTmhmSDhDM09zUXJJTFh3eEFValFFWUsxWC9aUnRFRmp5anNLaktZ?=
 =?utf-8?B?OWl0bjMwbkI3NkVJNlM2dXFYOTU2bFZKbjgxcklWK3hpek5DQW9FMDA2cHlC?=
 =?utf-8?B?YU9wNG4vSk5XZkc1NU15OGF4VFQ3b1hZMERNQzhmTEdqenRmd3VOeEwwMEtH?=
 =?utf-8?B?S1ZsV3NoSHR0eVhyRjJCVnNmTkQ3U1JOM0VZTHBuWmlYdWxnTEJzVXRhZ0o1?=
 =?utf-8?B?YW9XN0MwN1o3ZzZOUzRaQ0RYWGlZQmhSOWl5eEQzZTR1ZWIvSVFrTG9KeGll?=
 =?utf-8?B?dFBER1ZuRUJ5MWdqNjBpcmFJR0NLeG5abjY3bkZyclBua3UwVFBlMG5zNDhW?=
 =?utf-8?B?U0UwdU4yWjhvVlV1SHlaZ2xlZ2dNU2I0VnlnTW9qV1VERXp4czcwUUExSWds?=
 =?utf-8?B?blpkTWpPSzBaQVZTc3NRT3FpWlVlZ2lKN3NyTUM0d2luZEZPelo4aExWTGwz?=
 =?utf-8?B?T0ZGM1pJTGRldE1aTmRya29renAyaDlJQnNWMTdtbWhlRVRJeDFHNjFvVVlV?=
 =?utf-8?B?d0JpeURTcUVuTytZcnNFaG9vNG9mdlNBNTN3aHVHVk9HSGtObFY1VnluNjRa?=
 =?utf-8?B?ZDZnU29NK1BjQnlxTkdoL3BudkNOb0I5KzREK2VNUk83bU94U1hZVkczNGlr?=
 =?utf-8?B?R2ZkSDl4RCtPb2UxY1poVTZKWDdUdXVZRlRLL2did1V1SGI0L24zcVBzbDlY?=
 =?utf-8?B?RVlRZGxtdk5LQjVUVU9CMmgwekhyYXhVMytyd1d2RUdIRUNmeDV2ZklGVkVN?=
 =?utf-8?B?Zld6YjRqRXFlVmVLVmpxWkJWeUE0cGw5bUQ0QkJGRUlOd0o0YjQ5bEsyZ3hD?=
 =?utf-8?B?ekdjSFJpaXhNN1hiVFg4cG5IZVM1TkdwL3krK1V5dHZKb1Z2UmFwRHZJblho?=
 =?utf-8?B?d2V3UERBL0o1ZWJKTURQWG5DR0E4UGQyK0hZTGVnZk1nY05lZm1Sazkva05a?=
 =?utf-8?B?RjhCWTJWTndJbHdZV3FUTUorSmE0TEFISmRRNnRXaUhIUTFtWjlmakpma2Fr?=
 =?utf-8?B?SDQ4UFp2SkphQkRYb0RmeHAzV3oyMHdlaW1ENUt3dFgxOWhjY0drTmVMQllK?=
 =?utf-8?B?SW8vS2QvVW8yZ2hWQzJKL2twK3NwS1JXYjlFQ1FVeVJDOFY1eGpOVDJXSjJ6?=
 =?utf-8?B?Y3htZXh0Qm4xRnhxQkM5bW5ZRUpveVpKREN3b3k2RzNoU2kvZE9LMXZYdWlH?=
 =?utf-8?B?YXZzRVJxV1h3djZuMCtsVnB0Mlo2UlhEM0FlYkdKOXZmbUZKWGlPc3hIbEFk?=
 =?utf-8?B?Si9yUXRkNnJWU2lmMFpWVVd4QmhlaHZWSzVoSWtlNjNQenJ4R25jU2tEUnNa?=
 =?utf-8?B?RDc2RzdBSStPQ1huL3BJV2dUUVR4TmJNUlh0UWxYTnd1N0F5bXBwNUt4aGVr?=
 =?utf-8?B?MFFDOFVqUmJ1ajFGL1FRSWF5cXlTdlBxSmI0ejVZNlIvTkVpTmVSRTNoWmg2?=
 =?utf-8?B?ODNscHJoSHZSQjgzZTNTTDNtdjNqMW82eWUzRDZqQ2pEV0tXVnl0NEgrTEZ6?=
 =?utf-8?B?Q0JORkwyR29udmRUd0FLTldCdjRsTnYxbVhLTVVUWjd5MG54aVVIVlR5Q1No?=
 =?utf-8?B?S2llR085QjYxdEduczJhVCs0VFIvNWZYbThMVmdoUy9YSU1JYU56YWgvY1Nq?=
 =?utf-8?B?eUVvOGlDQmlRdlJvb1hHcFg0YjRtM01PVXRzM09BS25lR0VFNEdRakFnMjZE?=
 =?utf-8?B?ZmFpb0NTUUw1M3FEVlZPK0NERENZODRFMzRFaVdvWC93NjgyWjI1UFdsb2dt?=
 =?utf-8?B?LzNJTXRsdnRUZVpjcWFyLy9ZblFnU1NQR1FVNmpWcEFqTTJiZFpqTmc4VXpR?=
 =?utf-8?B?d2hKckhmai82YS9VTDhRNmFDTnpBVUhxeDhxWVBSdXprcDlrb1hwK0VvK2tV?=
 =?utf-8?B?T08yUDdIazdEQmo4OUoyblV5bTJxVlppSDJxdTNOM1RTSDdiTkxQdUVZbTBy?=
 =?utf-8?B?TUtsbWNTeHZFTDhJOFMvUUJNZlpiTmRnR1h1cUl4LzlRMmMwWTZxR0c2emRa?=
 =?utf-8?Q?xR9jHlGhgZkMEZQU8AWDXKPjI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8b697f-27fa-41f6-2196-08dbd00b1dee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:50:36.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE4KOo8YoPGUvOZqNBv/UWeNzyG6njyFeL2dkl+Rql2bPF8nHC20q3RrvyXGlMTH2lJH6FdVaZPzKwPa05KGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently an issue was reported to Bugzilla [1] that the Keyboard (IRQ 1) 
and GPIO controller (IRQ 7) weren't working properly on two separate 
Lenovo machines.  The issues are unique to Linux.

In digging through them, they happen because Lenovo didn't set up the 
PIC in the BIOS.
Specifically the PIC probing code introduced by e179f6914152 ("x86, irq, 
pic: Probe for legacy PIC and set legacy_pic appropriately") expects 
that the BIOS sets up the PIC and uses that assertion to let Linux set 
it up.

One of the reporters confirmed that reverting e179f6914152 fixes the 
issue.  Keyboard and GPIO controller both work properly.

I wanted to ask if we can please revert that and come up with a 
different solution for kexec with HyperV.
Can guests instead perhaps detect in early boot code they're running in 
an EFI based hypervisor and explicitly set 'legacy_pic = &null_legacy_pic;'?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218003

Thanks,
