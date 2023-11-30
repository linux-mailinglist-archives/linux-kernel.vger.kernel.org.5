Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7F7FF45F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjK3QH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjK3QHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:07:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708C90;
        Thu, 30 Nov 2023 08:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS83n0QjYfzgzMtf/PNFjPBLqnxwiLM1ISsJhhLynRopMg5FJ0C6T4cTgLlCUraR9yn1TMcM9H00etT0cr9QP1OJPXYtJTPrNr+bSPXU0XoZQLfm5aufzZKBNlFPo1BqZFxZf6hi7jgRZAXjz1BrUjimOZuKXEZJuC12JUFTPwZoU1ZLpCatjjnne3+Dx+E3QFEjxqtnGOPsqi0k7WmrCXDO2mMA4HOubmH+d7fNbDVCyZbiz+cUOeP44/FzRxoROEnPsoqADOnCwLMbjk/s/YRlNcUIIweS06B5ja9/Z89tEMKnU7OFbImWaEXYrNUx/QRbSvrULr/oLIsbkIcr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8wZl3OIJachGdJiD1jgnQNlTvGBKtldRHwQugqIQ2c=;
 b=F697VWvYGE4k6QJ+2L+Q8rzjOtwISHsSi5Gp73zCefMhjghJK5EdFBk3PUGhsf1L1UY9LIdx8WU5mA6ryklZRTOx6k1H+XRRbKmwDbyCeaXqLwmlSzr01Rr+uLSHwBAu8i5cJba53EUhwGG/jw5OZ9ZafcL/JmvbCpw1CUiVNyjJSJjRUrvB+Zh2dK9RQizLSM/3zsm/KDo0e1e+vEM1jKqwAY2IhJHYY8sUb82IA9Z6WA9tuHlLYR73FfMtyx7AiK085K1FPR9o/aP79KLPopFZ4h4+WhKMtSF/5otMIiJzAPtR7Mj2E2LBLSY33E4ZyAOCWJ2XwoofBt+lN/12oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8wZl3OIJachGdJiD1jgnQNlTvGBKtldRHwQugqIQ2c=;
 b=rkCsH2BtCa60+ikwNSurtAAFZs/p8Yleobhofj6nL3L+9rtrH2jamYKb5h9Lk22a62EBympnNU9yHwiutupTCqSGX9SNxnc0PXZH8qqUd7bXN5A3fbACvg7N2nE2vicPOSsjBm3boOQhtR6F1KczuzDLhgpQLlkW48EUpeUWQZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 16:07:28 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:07:27 +0000
Message-ID: <44244ba4-9d18-4cbe-8592-a7a41e22d725@amd.com>
Date:   Thu, 30 Nov 2023 10:07:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Fix kernel crash due to late update to read-only
 ghcb_version
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, brijesh.singh@amd.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jroedel@suse.de,
        stable@vger.kernel.org, ganb@vmware.com, tkundu@vmware.com,
        vsirnapalli@vmware.com, akaher@vmware.com, amakhalov@vmware.com,
        namit@vmware.com
References: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
 <ZWhWI2GvfleyGKsa@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <ZWhWI2GvfleyGKsa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:806:125::11) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faf7444-bdf1-4db3-a2b1-08dbf1be727a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVKUt2jeAK2z2PqqB6B448PztJVh6gqzB1jWjJ8wh6IiVx3DiW/EWnd9W6e0o6kZEGhqwEqLQE8hiAa3y+oLeIneMW/YCW2sAUE2v6nsEeT2FHSVdUWm6F905MRRMDhpL+LfeRmv9jOGfFqnfzSle9UoWZiWWKb/du7rzubOdhNiEcsIObktqY5yXmjJXH512I7kZX/qX1vGXWjWVbgDbN+CExEuPnUucqokX5kXqn2XMtMfYUGlS2I6l9twKyzm1pUpV+95WgxLEbxAEgKq0p1dXoRUuY6i4DJk24thKli9KjwzcZH24K2mkDx/52Jvl4oz9/RrymH8hU6yJQ500kANpLC3S6PggxXZtnUFXlr1NWY5TGY/BpcC8NMCbIXX6zjOlJkM1tGOhGx535/YnqSZvmeqoOLFGhn7gw3U2gFwzTL5KyUTtjFyH4KfqW+6okoXs3VhHqSQtASwkvw26RhNDZDOMbivnHsbYV/18cYLblSKUFpLNrbbRTpLWJgJNJQ5APa9vVgFf1cxheYhT2XWSlfKmYWlKcAJsz5Be5nFfs1vzoQ5FxFzUFN6kjEhwMjUWBt5NFcdHWz4JKr1eRLr7/AszDOF1LA80fuQusJyXFZT9Vhrc9WPO+F/5atLD7jZ5WR4+kubpsvE7WX8gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(6666004)(6512007)(2616005)(26005)(53546011)(2906002)(7416002)(83380400001)(15650500001)(66476007)(5660300002)(41300700001)(8676002)(110136005)(6486002)(66946007)(8936002)(6506007)(66556008)(4326008)(316002)(4744005)(36756003)(86362001)(38100700002)(31696002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VVTGpHemsrRUx3R2QxTmlWMzJQNFRoS1l5TFltUXhjU21WMkhpYUVCU3Z5?=
 =?utf-8?B?QkdleDdRZGw2dWtkclpaY083R1cxbHBnNkhzTEN6ejMvU0R4aU95SjNJTWgv?=
 =?utf-8?B?MkVXcnJiT0RsemJKK0M1QkpKeU9WQW9Ba1FLVjBaWlcyaGZGbFRUUEpVa0RN?=
 =?utf-8?B?U0JFa0lBNTJWWnVWc2NsTWxIOXdIQ1owUlNjbE00eVVmYi8xa1VZVTdJeEw3?=
 =?utf-8?B?aC9nSDhhNU9FOGg4VTBKeW5STTdqQk03RW5EZ0trcTdkT2VpT0x5Wkp1UjVV?=
 =?utf-8?B?RmdCZmVoakVvajV6U0ZwdzZta3k2UC9oZnFzTUIyWFIrOXpQUHdhY3JSdEdO?=
 =?utf-8?B?ZUNtenRVTkdGL1VCdi82SE40Nll6dHpja3BReXVVRzJaTGRRYnZlMkczNzBl?=
 =?utf-8?B?OXBFenEzK1dnYTdGS1F4MUJZUm9mUDU5bVhSV1NmaGFkUHU3MUlIdGY4MEpT?=
 =?utf-8?B?ZHF5NGsyR2NHOFRybWJIWGFJRWkydVFCQUMvZlFMcU0wbEFZeWVHa3JVN1NG?=
 =?utf-8?B?dUFPdzlUSVB4SnpiamRuVGY4ODV5OGpXVG9JZHo1ZTZQemUydHdjSitpOUhh?=
 =?utf-8?B?TDNOaWp4TGx1azBKL1RQOEZyazVIdm93d1QvSml5aUVPR0I3RmdVemhDVmlo?=
 =?utf-8?B?MDhZaGVoZ0Jzd3hPakRSd3MyQVR6NDhNNVBXQ2hlWEZZMnJ4eDFWUzRtMVFs?=
 =?utf-8?B?NlQrM2ZHOGlhT0JRRXlpODZxa29tbVlXdGI3ZEtKOTBsWW0weDBJbWpKTERy?=
 =?utf-8?B?Y3ErbCtlTTZWSm1nWldnQ28zUWlTdEhnRmpGNmpEenVjM1JWTkk2R3NNeU1q?=
 =?utf-8?B?MlVrMTdOeUVxSGkrYXVxcHZRM3RIWlcyMnJrc1FZYjY2WnQ5ejJIV0I0RWxO?=
 =?utf-8?B?VnRlUDdvMngwYXcrNmxRRDdzeU41TnE4eUlETjF3NWdOYlpUU2llRHVtZXRD?=
 =?utf-8?B?MTNlUnE5RUJQQjFSQnhyMzVRWmhpU1lNT0JqcnJWeHhVV1dZblMwamJwQ1Zh?=
 =?utf-8?B?SUc5dmpBQ2hIRjR0RzRQN2NQcU16bkhnZFBoSGdpMkp6QnVpZGRkRW9mTWhz?=
 =?utf-8?B?YkpBSUczNm5tVDJMdURvSHVvWTB4b1Y4T3pnQ0hZdTE3MitoQUdKMWVVMWtI?=
 =?utf-8?B?Qy9UZlYxTEJwcjE5WHplMDcyelFYckxXaEdRd3pMZzlzNVIrWFhpdVdTTWpn?=
 =?utf-8?B?TEVIZit3cktVaXB1c2VSSElzMGh6MVhWWitzQkRFdmdQZFRPNFYySndjbHM2?=
 =?utf-8?B?ZEVtVkg5NjZmMFE1TjZMbE1TTjBPbkF2KzlMSHljdmdjV1pmcWVzK3Y0eGVB?=
 =?utf-8?B?R3N3YkZ2K1ZrQWN4SnQ3UGR3OEtESWIzSXlHaWJ3dk5zTnl3bVZHVGVEbFpw?=
 =?utf-8?B?SWlXMnZhTWlpNzg0dlkxWUIzbUY1Z3E1L1BHQ2hqT2tqcitMSkVuam1CQTVp?=
 =?utf-8?B?S2dNcE1EYlJQcWNXaTUvcElzc3UyV3hmZmVZQkxCYUtNOEhnWW5CY1Vydmp4?=
 =?utf-8?B?TW5lUUo3dTZzSzlzaVBDVGdRL2xRcStWLzlvdmRlVVlrZDFLZTVsVEgxL0po?=
 =?utf-8?B?dmtHSjdLbHpHdlJLdEliNmgzZVAyMEo3MWIyWVNUZWw4M2s0S24yVFBTcjJr?=
 =?utf-8?B?WEM2OUdrS0NVbWZ0djJkSmQ4ZGlrTzhGODEwSUtuWnhzQUo5MnJlb0FhcEly?=
 =?utf-8?B?Ymo4a3UydHZOQkt6eUZRblhPQi9lZzJZSDFsY0RXNVBqM1RXMnkyZytFL1RN?=
 =?utf-8?B?TjVqWmJGaVROM09KZ3hTYndRblBYWURiMTJTZ3RQTUN6K25QV2xhNURVRFJl?=
 =?utf-8?B?MFlaQ2xQYmVVQitxOGtVbVNFRTJwcUxxVHlwQ1VXa1hsTnBpdmVzNHNPWW5T?=
 =?utf-8?B?RVhNdEhJbVMvS0FRbnJUZGFxbk9GQkQwekdQNzdSR1ViSzRPOGRiN1ZwTVF2?=
 =?utf-8?B?akZwMHZEaEE3STdiM21DcGl2WFppWW92OStxdzZ1dWxWN0hkTVNTYURVbThY?=
 =?utf-8?B?SFd2ei9kMWhzdm5MQ05tZXR2MGRNN2JVeWtwSk5kY3lNUGQ2V0hVcHZCV2Jt?=
 =?utf-8?B?TENHeWpHMzl4aVIrL0t6dHVuY3BuM3JZVGxhbHNhWHlwblkraE5GT1h3Vi96?=
 =?utf-8?Q?Djb3vhTxbzy+hyxNDu7zQPVfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faf7444-bdf1-4db3-a2b1-08dbf1be727a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:07:27.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dpqY6+cwiQUfztnVkvON1stVk1rx+5JvU2MEao27c00yzMpRBdQN2PcJRUZ7h5LeO1ha8ktMvpWaiqNYkt84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 03:30, Ingo Molnar wrote:
> 
> * Ashwin Dayanand Kamat <kashwindayan@vmware.com> wrote:
> 
>> From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
>>
>> kernel crash was observed because of page fault, while running
>> cpuhotplug ltp testcases on SEV-ES enabled systems. The crash was
>> observed during hotplug after the CPU was offlined and the process
>> was migrated to different cpu. setup_ghcb() is called again which
>> tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
>> is a read_only variable which is initialised during booting.
>> This results in pagefault.
> 
> Applied to tip:x86/urgent, thanks.
> 
> Tom: I've added your Suggested-by and Acked-by, which appeared to be the
> case given the v1 discussion, let me know if that's not accurate.

All good.

Thanks,
Tom

> 
> I've also tidied up the changelog - final version attached below.
> 
> Thanks,
> 
> 	Ingo
> 
