Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2C793DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjIFNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjIFNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:38:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4A510E2;
        Wed,  6 Sep 2023 06:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvHxapto0uuJ7A0S+c0RTQjA5qlnznhfd+Jgznt9WiC/TE+WBIFG2MKmtWyq1wVi6OnH5KQ5z2BME2OIPNJSE1HTQBXnzIjwWasZROVHviulnlIyGUP5i6LbSxp3wLybvmAOD7upf7vjN/vswZcbhi1c9rjp5OH8Z8oXUPjeKekjbij8FV8X1yG6FgwXoizrWNw7x/69vsTon03wcA+ukCkNcStgL0xEMQdozF9Eb5ILj7XlwnbKQjAweZTjre0+219IySBnpR5e5I11Nxm/jEMC6zh0GBxZ3/w8wFeuStNk5gNtUYTq3EkD9BaHCa6UQ5iNa9OGGl4J6uu2XWL1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiK3I6KsWjZamW+5fXpqUxv+E7aQ/vqHMJNAfdIWt+g=;
 b=Cmos/o5WVJxQg+lwx/ljROxiNWVt2aJueplqWxacQiJqNNQHXjlWcfZksvVaJIqYctEo+l3JmUD+BNogBh6nOL3zHqEGgXFdORAEX8s6jwprzcn88YaWUgGfN6IvLmt9sPiDtQVz3t3j7O6I+ANVg41CbFrcvhxizWBnbQfOPd0krq7p48Bu46nEzLTrtKNgroirFEfsfKTw0shCXqNPvqybv2QyXcxF80EFpTpHHtFncAJpLtHn0QWExW3Xve5h6hx6HZdahk6zqSVPC43fIkYgbUJbWB5RUI08Qc8bffZacRi/8oZnS3KgZ5tVWqZxrp+uo/VLGxKBJVNafi1VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiK3I6KsWjZamW+5fXpqUxv+E7aQ/vqHMJNAfdIWt+g=;
 b=CdWhBf/zAc8zvpLDyXjhDwSFG2UL+31biFA3knZWB53TjnsFPfx/j6Juvjgp/w6e5PwcGSnurlN0R1mPQNs+rWHZWjZj5ZNDWsHFdm7pPYDkcf+DJsBJL63IyLgun5IWlZh1Rb85l6EMLFynu+TprKXh6yT+cN6olPSMiQblzXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 13:38:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 13:38:05 +0000
Message-ID: <29ad9d0b-ccb7-49d4-a712-53bef5c73181@amd.com>
Date:   Wed, 6 Sep 2023 08:38:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, bhelgaas@google.com,
        rafael@kernel.org, Shyam-sundar.S-k@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com>
 <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
 <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: a7696b7c-0562-462a-6d3c-08dbaede7fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vl/xFQ5JIsVOBsmJDrr2kLt4o75qaYKgwknMZz1j5wYsXQR+mvproi/GvhqQtJ9Zlevk75kdwSM7kDcLpbZYZM8kKnkzg2mP2j/BseZhcsRSYj7lO1xKFVz/kbWLgloNveHX0AcyeYgAZSa4jV0z3fwfvpV4nsJJoUTX1hQrj9Wgrk0wyBmwKHIbmC8LXgJvfgPW4N4w1jYKQnZLWDINDXoQlE4yIS0fO/TO5DcvjxQ4aSD/36HiIft/g/oJk1kbha3iTH6ygLGlFWYEFANDZdLZX9FuBHM2a5W9AfSMSQbitEz11U8a5/GLtU90P3UltwCFZp/Vfm/1blEx0q3niqzWQ6ruXS8ip97ft2O2fY/NB22nOMMQZA3llduhpqgYBIc77KRX8K9OXLwpgUzdUUA3NsjhQWgZyAl4KiCeSCWw6d485/ZK8TsoZ/Vk/pdXBp/Ya1d4uWVjYVqrUuMgEW4TM380bS0D7nLbldEPoBdDx2xo5Zwf9+Bj8+/xwjOEs/S2BhRDx+qgxx/J6w5AXy66nK+Sd2CgeNdVXtWvOkRzoMoovPvTeRqzYexm/lx+PaEkdLPFrmSf2f6taY5DKoOhk2pBl893AF73Vsha3sGhVd6DiUavuVtCeU3VVOl6k8Q51yxpE/VY8Y0mawSMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(186009)(451199024)(1800799009)(41300700001)(38100700002)(86362001)(6666004)(2616005)(83380400001)(478600001)(31696002)(26005)(6512007)(53546011)(6486002)(6506007)(66946007)(36756003)(66476007)(6636002)(2906002)(66556008)(316002)(5660300002)(31686004)(8936002)(8676002)(4326008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVKWEJ1MHBCVVVUNGdVQ1hYK2tidWZQNVZTbVNqQmxZTDBvNUIwNjhtVjBB?=
 =?utf-8?B?VDlTb1ZOUGVGVGdlMFlMOU5zOGhvV2VLOHBHWm5ROUNWUnJ4ZGVsRFhMMU1S?=
 =?utf-8?B?Zjl1Q01sbm5uN3Nsa1lvbVNCK1RacWxzZDFod3M5M3I4ZWtuZ1EvZGRKZWlB?=
 =?utf-8?B?T2tCbmRPSUc3VndlWm5WQ0ZtcFN0VnNlZVNHeDY0dGZETXE0dEJWcXByU25J?=
 =?utf-8?B?dUJaTXRodUpELzF6aGoxYmxhUGo3a3hGbERvbndTdDAyWW5nQVZHcWpiQjN2?=
 =?utf-8?B?ZUNKSHV5MnhZaElRb1EyTnY5SnlNOTlMKzlTOUZrdEJpa3VaOUM3TGtjMk1G?=
 =?utf-8?B?aVhkVlp2OG9wbllISVJSdHVYbnBYS3ZsdWF1bXRBWkk1U0laTHhJbk9oekk3?=
 =?utf-8?B?b0F5bXBNNndOdkJUc28vazhNTmJXTG9nRFlyRVh0bTk4bERHQTB6U3FuTFJR?=
 =?utf-8?B?UnoxbFBKbUo4RllaYU1FcjYzZitQWkc4aWZ3MnUvNytSbXlTaldWZHljNGR1?=
 =?utf-8?B?aWRBY0x3VkFReUdDSll2d2tBS3ZTQmV3bHM5K0ZJdzRCY29pUXNaRU1yN3Rr?=
 =?utf-8?B?aHJjb0xVS0s1UTV5WUNJalZYR2YxS1Z5b2RvU1NsZVZ1QXJKRXVZVlNQQ3Ux?=
 =?utf-8?B?dGV1REIxRDFJUS9qbnNtR0pKQnVaQmFueHFORVVSeXlhMUl1OUIvZ0VIMlc0?=
 =?utf-8?B?eDJFeVBWSm5IaGk3dmtnVHU3YmI0VWh3c3FaTHppT3JWL3pxQUhCZ1dwZ0NH?=
 =?utf-8?B?S1dFNTdQUkg0M2FYaXV1aTZzNlh3VFdpNkMyelZiVjlQbXJ3TkFQTUdSa1V3?=
 =?utf-8?B?cXNBYnMvc2dMczJ5MGJBWTIrZkpacWlwUCtsTTE4bHM5c3JtM0sxU0EydGJZ?=
 =?utf-8?B?RFVPMXdYcFF6WTFOb2ZJbUt3ZEJhSWN6RFJncWtuaHQ4dmhndXJrOGdxMEM0?=
 =?utf-8?B?dzRCaGRaN3JrZzFiRXpmbmJvZTB3eE5sSWVLcmtWMGpxVzR0K1RFTUFNekNw?=
 =?utf-8?B?ckpkL0JKU2lPbHFLTzJQMDE0MWoxV2taTE1tYktteTdMeElGeGtSSytCMGRQ?=
 =?utf-8?B?MU1OSDhJMER4V200cVMyRjZ3ajE1bS9TRkcvM2N3K2hxVXlxWjQ4Mm9tNG1Z?=
 =?utf-8?B?TTZqRE82OUIyTDZ3b0RrZHZidjd3R3V6QUoyVWE2VXNWUjMrSHA5VlpvejN2?=
 =?utf-8?B?NnZ4MGdQbGZKOGFFOUt0ZnBWMUJuTCtmbFFBV1lObG02R1BkQWI0M040S0pR?=
 =?utf-8?B?d01ZMXdqTjU3UzBKaVVxNDgyc2laSDBDTFFCeHBTNDVuZ0ZUYVhpcHNyR21v?=
 =?utf-8?B?SlplMUcxRFQ5MitUK2NmWGkyTmFWQmVnZTR5bWw2bm45cDNXOXNFbFBCMzM4?=
 =?utf-8?B?SnA0RVZWWklzNEY0TGttRjBucXYybGZjNGdXTG1aMHgzQng4ekxIL3M3U2Nn?=
 =?utf-8?B?bklNdmVoQzNKQmF6a2tLTnV2eHBCaVhkbUZjc28wSGpQUTAwU2dXekRJWkhG?=
 =?utf-8?B?VzJUTFQwSm16YkFMRlFUZFAvRWhiRSt6Q3FHNnJhTXZRdnpYUGYxYjlRV1dk?=
 =?utf-8?B?RkhjaVNWTURMR2lDckp0eW1TeTVMZ2ZsMkNKZUtiQ1VXY09weWI2bEkxSUpP?=
 =?utf-8?B?VUNrNDNhVE12L2VDSmc5cE9sWS82OEoxR213TnQwT0xNaUViNEJDZDNiNzlF?=
 =?utf-8?B?ZmcxQ2tlZ21SZFF4N2xWbnhtQXkxazZjYzZCZUx0bFZRdnpCVWd6d0FrazM2?=
 =?utf-8?B?UXNDTURGMHg2bUFtakozZ28yaGZaSHhReXZja1NhOFlib3MvZWl1cVFHUkJy?=
 =?utf-8?B?aHRoWHZ0b2NIcmltSXM5SHNleUhGSStDa1ViYWUxZlQrN3pQUlo5R3dETFJo?=
 =?utf-8?B?YkxIS3ZWTW9RQmJqT1lGaWJQME5vY21nb3ZCYVRyZHVFeEMzTGVjbWYxeEgy?=
 =?utf-8?B?TjI0dkFDazAyajFNYk1uck45bjJUZzR4clpXQTRJS2h2dXJzY3VrMHVYUWc0?=
 =?utf-8?B?QUkyeU9XVFd4MmZwQ0FTcU5pS2Yxb0VETVhRemR2WU81NFVzanU2bFhNWm9q?=
 =?utf-8?B?R0RQT0FabEtyUXN6SFZUbC9KZlpBNzBlZ1I3czhxNFVYRE1RUkpnQWRlbUlG?=
 =?utf-8?Q?i5SuZLYBtqErveZ/WbxLXDSyp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7696b7c-0562-462a-6d3c-08dbaede7fd9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:38:05.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTIINVuScTkA1ACA+HEgvjiL2S0c+KwOOHy1zpx5Tv7ECHcz2JkTgcrqvFIR6ER2ZYYzmk62GnESc0/sx91OSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2023 07:24, Hans de Goede wrote:
> 
> "XHCI tunneling" is an unfamiliar term for me. Are we talking about a XHCI controller inside a USB4/thunderbold dock here which is connected to the laptop over PCIe tunneling over thunderbolt ?
> 
> Or do you mean the XHCI controller inside the laptop which is connected to a USB4/thunderbolt capable Type-C port which is used when that port is in USB3/USB2 mode ?
> 
> As long as the XHCI controller is inside the laptop (and not in the dock), presumably you can identify it by say a set of PCI device-ids of the "tunneling" XHCI controllers on affected AMD platforms. So you could then still call pci_d3cold_disable() from the XHCI driver on only those controllers.

XHCI tunneling refers to XHCI over USB4 fabric.   The problem isn't with 
the XHCI controllers going to D3 - it's with the root ports they are 
connected to.  And the issue occurs with D3hot.

An earlier version of the series did do something like this where it was 
quirks for the PCI IDs for the root ports but it has two problems:

1) It covers too many things.  The same PCI ID is used for a second root 
port that is unaffected by the issue.  So this means the quirk needs to 
look at the topology to make sure the right device combination is quirked.

2) It doesn't scale.  I don't have any reason to believe the constraints 
requirements change which means we'll be adding new quirks with every 
single new CPU.

> 
> Note I'm not saying this is the best solution. I'm just trying to understand what you mean with " the PCIe root port that is used for XHCI tunneling" .
> 
> I also see that Rafael has said elsewhere in the thread that he needs to think a bit about how to best handle this ...
> 

I have done a prototype for your callback proposal, and I've got 
something working at least for amd-pmc.  It only calls the callback one 
time rather than at suspend.

Unless I get some feedback from Bjorn that the callback proposal is a 
bad idea I'll post something later today.

