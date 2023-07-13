Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA23E751505
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGMAMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGMAMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:12:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206E1992;
        Wed, 12 Jul 2023 17:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD1/40MBK+kyE09i4tkj/KC6uJI5GRzUsl8ipY8jkbbZ1NfGh6eqyUnesDgSVrmtonIp82ey171yf2VrhuYj16R01MxdDbQQPTP3k7RsuZ7O8FL80CHMCkAJaL13d1lUFZnc47pgflKHgvpVVXqIkdzDyFEYetA9Rgpv3kG17+vd9vKIhlayOdWN0iNBJJFSxIQ6uKtzy/RCVQajUjprGzTxEQSf8FKFzA7xeHiB5E1NwLAAAbhR4A8M5vJG13Exok+9rbfKlU6WVaAQymEyaRgdwHqbyVNgEbwQstfHroY4AfsCUrPZEsGOPz/pXMmKv+Hwcb88AXfVxhdsBH8WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiQK5wVykdGXxGNGavgjSU+oRZd64YWp9kAG+rEbVzo=;
 b=m+QuYi/L/X49W00vjoimNHx23xjmTm7t98dRc+9jD+VganLbLMsnKO8StN79o54Q+n8l2OzE7+kk5jAuP+MYlkqSIkI+Co+qRZP2XlLQQrWI2y1mBfYtRl1iuNClxTxW4bXpTWxpfjfej9fdMgzSOFoPCzDpXIFLQjAhr9Hf54BSSGlKSNZvNgINJW2VuC+vg/PS+qwYdS0+7oRT6QAwm/g+OzQXhxU0nRnEfgktj+E9j+/9Ic3MSeLn8r2Hex59IZA2rrlVOgatouf4EIZdG+dOLV/IbgpqH5DUsI3q7Pvh33GvMIq376rkBepJMPKsKuUF9SgLA6jR0Nvyaj5iRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiQK5wVykdGXxGNGavgjSU+oRZd64YWp9kAG+rEbVzo=;
 b=t9i0qy4eGKyhIdtKdukPY80YqItByh/D22jKQn/LuA8HmA5FKgghYw3CFY3Iq8Ps86DUyDejLjYJYOU430xtKWY2yfgHd/OHv3m08+6LXZHa2X2we29IWvp/QDSEqUXeRO+pKnXxgr8P3NyIv8UGIllgaZ/nwna09Llao9CSLzcAiSoXrDixuBC8eQX5T9PSOBLNhTKFuVntn6i5l0cN1sT546/78Yf7IupUvWnvSx2a4HXsj1VPCz1r4WsgMBpy9TYzzw5Z3xp+ebzS5Z5s/G3PTzyp/gPBwutM2UECVBNn7oOazabwolQddQvWSJGhzN6ToiD+sY7PxMGAyTLMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 00:12:08 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332%3]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 00:12:08 +0000
Message-ID: <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
Date:   Thu, 13 Jul 2023 03:12:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d07051-057e-40aa-82f8-08db8335cc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGkBhzEXUREOVGkm/27T0Aau+ntsgN5xeXNhLcMVEdsrU5akToXOLsk3gQn6ZN2eHD3uD+ip+5PaYptjfjTLLczLfRaY85DZt8re1GoMVHRhpKv7+cHL6uRc4nHMZw5bS3F5YofmhsnIM8DxX+g450yUi5j1Vvp1A6TtzUbeWlsqAdGxmiiomhMiHb0KwDCJjxDTGj5yXUceFBtZyP5gL4BXmQ3Hb4LYfqOboIDrwk3fdxibu3n96F0rvxN3TpWKCb0hNsbMo3OSbHjZbZ6/AJ+C7VKpXk3C7I+S8+r3gJ0EJMmUMJd+c9HjzSUFpVuuXXYzZWHEJEuN3bb8DmWTdUb+TIkIE03rnGY4KiFP1UWHxIpSjO9+iwU/oI3eSRidEN0xjRXKh1ZI1/5+q5vfBEWXX0RNPcomToGLgiR35lz+YehdqdTJKg5hNu5a6WpvQ7Fyvvcm2Ey0KUdRwv/xIw5/pBzhOJOhpcil5lepPR2T10TGj8nOhaHq0+dIHLwaf9vDehJqYE06btBrLQ7ghmKBWdDibkTWHRaldKqAXTD/alM92lZaipPWv9ETxcnNvXs+OvXIdrWUvNeMzfP6ZR6m/RweBldKaX4Ag9raL0mP36SliN2j4BMOFLdPEUI9vT9DDB7DL+0on8DZ9/gfMBQXIGyeG8IEdI1sSoTgGGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(186003)(86362001)(53546011)(2616005)(66476007)(66946007)(66556008)(316002)(31696002)(83380400001)(4326008)(6916009)(6512007)(26005)(6506007)(478600001)(2906002)(36756003)(6486002)(54906003)(6666004)(38100700002)(41300700001)(8676002)(8936002)(5660300002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZFQ1A4RWJNR2pxNE03K1pEdnR6eDhVZHZGRGJTRFk5VUh5eEYvVmxIUDBW?=
 =?utf-8?B?cE9yZ1pnRGZta0Z1cTlCdmtoWWZEWk5WcFJSeUxLNTN0cTRXc1l5QmlWaG1h?=
 =?utf-8?B?MWs4Q0NkcWpWaUVsV0drYStES25uZ29jYysyQlg4cG1WNDljN0cwdXRjYWlp?=
 =?utf-8?B?S3YxY2k0TkdSK2RsczMwRnpUMDMwNHhyTDRNSEVIWTFTbE5VMXB5YTdTcWtO?=
 =?utf-8?B?c0U2TzZjVHFxbGtIRWpnTytXakdTMW1SVnVqSGF6ck1TWHZhMllValFhcGJK?=
 =?utf-8?B?cUdFNUFROGYrRnZrOTJHZnJwTmNJb1lJRXBKSFR6a0I2U3N2cnJsbGQ4MGRL?=
 =?utf-8?B?SXl1WEtoMkd4K0xNN2FoSDF6ZkxQVER3b0NDaWlBWXVsSTYwUUhTS0RNRFdP?=
 =?utf-8?B?OW9OOUFsRUlLSXhwNnlHTUJIa0NuakNud1RoZk9CR09TS1hEM21FRXh4MG9N?=
 =?utf-8?B?d0t6UGYySVd1VG9MLzNGMWRMcTAxL1NyaWgxK3NuSTlvMWd3dU1pRWFQYmRX?=
 =?utf-8?B?d0hFdGNVTGZiYjFzRlhLZklMS0NoK2RJaElKdWhuODBQeG53NnNtM1ZqUms3?=
 =?utf-8?B?elh5WTdDWTE3eGpjQ0dneVArV2tLamtYNUNwTSs2Z1prM3RHQ0JnQjlKdWZB?=
 =?utf-8?B?dTRRQ3VhcG4zQkIwdDFmSDlkSXB2THhWc0dKaVN0NnE3TWxTaGl3amhCdmJy?=
 =?utf-8?B?RG0zSmx3YnU3V0JBMlAwb0paT2swcFhhVXpnL0cybUhnU1JFeDRNcGpGanph?=
 =?utf-8?B?VmQ1dXM5NFczVWRsSW1HU3FRVDN3bllDS3hvMWVYSGFjNGRYMVYvbkJMOWlQ?=
 =?utf-8?B?NnNuQmcyWXBndW14T1V2Z0hEb0ZkMW9iVEZTMVllZHVoVTBndzBnejVSdVRn?=
 =?utf-8?B?MjlCdDdZYnJGZGtkNGVnL1o3S1orVjRjSDhqbjZwZldZTEFWVjlqS2owTnJZ?=
 =?utf-8?B?QUVrRWJPSEg4SVR0SlV6U1lxb1Y0ejI2c2tPWkFNb0Fob3M2NExmUGphdGJP?=
 =?utf-8?B?ek5kRHZlM3ppeXF6QmRhbDBJVGVuRlhFRVRUN0R3YUJNbG9oQVFEVys1NHp2?=
 =?utf-8?B?VG9KZUZXSlIvU1A4M3FsdWkzWFN5VlZZQlRBVGNkV3Z2U25QQyswOXhnMzBw?=
 =?utf-8?B?K081UGgvMktzS0J3a24vdSsrK2dMTUtHODIxanRPQTV4TXJOYVJVUm1nTG1W?=
 =?utf-8?B?UEJMbmg4Tys3NmlMWGFUbjZzNWprblJJWkhmamFJdEtsKzIxd1lHeEQwUDBm?=
 =?utf-8?B?WHVwdDloVkxJWlNSai9yalJVMjVuK3dud0tiKzNPTm90QXBvUU5rNUtoOU44?=
 =?utf-8?B?MTFpTHpraHJTMmtPTUtRRXZVQ3lDRFpTQTRwZkUxOGZFV1JuakN5OXhXWnRi?=
 =?utf-8?B?VzdUVVR4UmFnU1Z5aFNybGJJaU9jak9PeHY1T213VjNpV3RsbjhPUDd4OVZK?=
 =?utf-8?B?RVpXeSs2dWY0bVVhaTJORUZpK0UxeVdTeFUxSWhlVFQybjRROTA5c2dDekNR?=
 =?utf-8?B?TU5HNloyQWk0ZGxrSFYwcUIrWnFZWHZpWGwzVW9Ca0R3d1JmVUVUWmZNNzhQ?=
 =?utf-8?B?WTVETkN0Z3JHQnpaVFRwZmtHY1JIWkgyZDdzTnNidjJLaEpDcGNMY3BvNHgv?=
 =?utf-8?B?Y2VyVXVGK09Kc3J1RnZ5UjhEVEdYSHFxZVFEMUJIUXArdjE2UjBxV1BSakg2?=
 =?utf-8?B?dEN0dS9zMmpUNUdQUFBoZmZHRzJheUN3dkNXYVZwQlVWelFSSUNOdElDUnRy?=
 =?utf-8?B?S253MitxWXBVS3NyRjhIU0I4TGFaWG5JK01LaVhQdURrVTBzSm8va0hrWEVq?=
 =?utf-8?B?ZzhRNE5rZjE2YUlVS3NWTGluTFVwYUR6eThjL3djamtBU01kNXd1T2V2Wld0?=
 =?utf-8?B?WnVpUm9QOGNxeXZNWjk5M1dFZWxESkk5MVVOejN1MGRrTXl3VWMvOFNGd25U?=
 =?utf-8?B?cXVGcWVRSnF3aDJWcFh5UmlOaUZiZDN3ODVsbGJ0NDhzQWdmaWY5NEZmVHB3?=
 =?utf-8?B?MVdMWFY0Z1BCSURoS3NVT2NPdVJGMFBLWUYwZ3NUZFdSejRSY3NLcDVHZkxZ?=
 =?utf-8?B?K3g2S0Y2MXlKWk1sUHU1aHBrUmg1S0xXTXRMNmNDMjhNV2diTzJYS003T3dG?=
 =?utf-8?Q?R/u8Q/CbePULXE3PTA+AoRyP8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d07051-057e-40aa-82f8-08db8335cc14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 00:12:08.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KscQG4ro+row9R3ZsHUnd9NEJmuTh9X5HsjfWGZ0b2hNIEd2WgYpIwWtDXiov7Q1S0ALiLoaHWr3ToMEIF59YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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



On 12/07/2023 15:04, Daniel Wagner wrote:
> On Mon, Jul 10, 2023 at 07:30:20PM +0300, Max Gurtovoy wrote:
>>
>>
>> On 10/07/2023 18:03, Daniel Wagner wrote:
>>> On Mon, Jul 10, 2023 at 03:31:23PM +0300, Max Gurtovoy wrote:
>>>> I think it is more than just commit message.
>>>
>>> Okay, starting to understand what's the problem.
>>>
>>>> A lot of code that we can avoid was added regarding the --context cmdline
>>>> argument.
>>>
>>> Correct and it's not optional to get the tests passing for the fc transport.
>>
>> why the fc needs the --context to pass tests ?
> 
> A typical nvme test consists out of following steps (nvme/004):
> 
> // nvme target setup (1)
> 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
> 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
> 
> // nvme host setup (2)
> 	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
> 
> 	local nvmedev
> 	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
> 	cat "/sys/block/${nvmedev}n1/uuid"
> 	cat "/sys/block/${nvmedev}n1/wwid"
> 
> // nvme host teardown (3)
> 	_nvme_disconnect_subsys blktests-subsystem-1
> 
> // nvme target teardown (4)
> 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
> 	_remove_nvmet_subsystem "blktests-subsystem-1"
> 
> 
> The corresponding output with --context
> 
>   run blktests nvme/004 at 2023-07-12 13:49:50
> // (1)
>   loop0: detected capacity change from 0 to 32768
>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>   (NULL device *): {0:0} Association created
>   [174] nvmet: ctrl 1 start keep-alive timer for 5 secs
> // (2)
>   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>   [374] nvmet: adding queue 1 to ctrl 1.
>   [1138] nvmet: adding queue 2 to ctrl 1.
>   [73] nvmet: adding queue 3 to ctrl 1.
>   [174] nvmet: adding queue 4 to ctrl 1.
>   nvme nvme2: NVME-FC{0}: controller connect complete
>   nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
> // (3)
>   nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
> // (4)
>   [1138] nvmet: ctrl 1 stop keep-alive
>   (NULL device *): {0:0} Association deleted
>   (NULL device *): {0:0} Association freed
>   (NULL device *): Disconnect LS failed: No Association
> 
> 
> and without --context
> 
>   run blktests nvme/004 at 2023-07-12 13:50:33
> // (1)
>   loop1: detected capacity change from 0 to 32768
>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"

why does this association to discovery controller created ? because of 
some system service ?

can we configure the blktests subsystem not to be discovered or add some 
access list to it ?

>   (NULL device *): {0:0} Association created
>   [1235] nvmet: ctrl 1 start keep-alive timer for 120 secs
> // XXX udev auto connect
>   nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
>   nvme nvme2: NVME-FC{0}: controller connect complete
>   nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>   nvme nvme3: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>   (NULL device *): {0:1} Association created
>   [73] nvmet: ctrl 2 start keep-alive timer for 5 secs
> // (2)
>   nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>   [374] nvmet: adding queue 1 to ctrl 2.
>   [233] nvmet: adding queue 2 to ctrl 2.
>   [73] nvmet: adding queue 3 to ctrl 2.
>   [1235] nvmet: adding queue 4 to ctrl 2.
>   nvme nvme3: NVME-FC{1}: controller connect complete
>   nvme nvme3: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
> // (3)
>   nvme nvme3: Removing ctrl: NQN "blktests-subsystem-1"

bellow sounds like a bug we should fix :)

>   general protection fault, probably for non-canonical address 0xdffffc00000000a4: 0000 [#1] PREEMPT SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000520-0x0000000000000527]
>   CPU: 1 PID: 2076 Comm: kworker/1:1 Tainted: G        W          6.4.0-rc2+ #7 f2a41a58e59b44ee1bb7bc68087ccbe6d76392dd
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
>   Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
>   RIP: 0010:nvmet_execute_disc_get_log_page+0x23f/0x8c0 [nvmet]
>   Code: e8 c6 12 c7 e0 4c 89 6c 24 40 48 89 5c 24 08 4c 8b 3b 49 8d 9f 20 05 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 93 12 c7 e0 4c 89 74 24 30 4c 8b 2b
>   RSP: 0018:ffff888139a778a0 EFLAGS: 00010202
>   RAX: 00000000000000a4 RBX: 0000000000000520 RCX: dffffc0000000000
>   RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa8af3a88
>   RBP: ffff888139a77ab0 R08: dffffc0000000000 R09: fffffbfff515e752
>   R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff1102734ef20
>   R13: ffff888105563260 R14: ffff888105563270 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff88815a600000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000824220 CR3: 0000000106512005 CR4: 0000000000370ee0
>   Call Trace:
>    <TASK>
>    ? prepare_alloc_pages+0x1c5/0x580
>    ? __cfi_nvmet_execute_disc_get_log_page+0x10/0x10 [nvmet 1da13efcd047161c3381cb240a95399f951fd98f]
>    ? __alloc_pages+0x30e/0x650
>    ? slab_post_alloc_hook+0x67/0x350
>    ? __cfi___alloc_pages+0x10/0x10
>    ? alloc_pages+0x30e/0x530
>    ? sgl_alloc_order+0x118/0x320
>    nvmet_fc_queue_fcp_req+0xa19/0xda0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
>    ? nvmet_fc_rcv_fcp_req+0x9c0/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
>    ? lockdep_hardirqs_on_prepare+0x2aa/0x5e0
>    ? nvmet_fc_rcv_fcp_req+0x4de/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
>    nvmet_fc_rcv_fcp_req+0x4f0/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
>    fcloop_fcp_recv_work+0x173/0x440 [nvme_fcloop 05cf1144b564c4e1626f9f15422ccf61f2af41de]
>    process_one_work+0x80f/0xfb0
>    ? rescuer_thread+0x1130/0x1130
>    ? do_raw_spin_trylock+0xc9/0x1f0
>    ? lock_acquired+0x310/0x9a0
>    ? worker_thread+0xd5e/0x1260
>    worker_thread+0x91e/0x1260
>    ? __cfi_lock_release+0x10/0x10
>    ? do_raw_spin_unlock+0x116/0x8a0
>    kthread+0x25d/0x2f0
>    ? __cfi_worker_thread+0x10/0x10
>    ? __cfi_kthread+0x10/0x10
>    ret_from_fork+0x29/0x50
>    </TASK>
> 
>>>> Maybe it's worth cleaning it..
>>>
>>> It really solves the problem that the autoconnect setup of nvme-cli is
>>> distrubing the tests (*). The only other way I found to stop the autoconnect is
>>> by disabling the udev rule completely. If autoconnect isn't enabled the context
>>> isn't necessary. Though changing system configuration from blktests seems at bit
>>> excessive.
>>
>> we should not stop any autoconnect during blktests. The autoconnect and all
>> the system admin services should run normally.
> 
> I do not agree here. The current blktests are not designed for run as
> intergration tests. Sure we should also tests this but currently blktests is
> just not there and tcp/rdma are not actually covered anyway.

what do you mean tcp/rdma not covered ?

And maybe we should make several changes in the blktests to make it 
standalone without interfering the existing configuration make by some 
system administrator.

> 
> Thanks,
> Daniel
