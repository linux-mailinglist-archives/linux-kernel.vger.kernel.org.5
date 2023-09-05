Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918F87925B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjIEQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354583AbjIEMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:45:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77250DA;
        Tue,  5 Sep 2023 05:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noExXijlI5lZijFLmJUe9JyW92gwQR0V+bc22E0Drkd3UjQZaZq/4MTE+b1DCcqhLbZQPEbCAGjpxTuxRnjbUOfANI+GV4p+dUY4IrKDcTYOL/znxvOOy+SbI1puQpZwAoHguAdm+yO2UcOOECT5hNAT14WufBkBxLxh82AANlRuN+c030bZK7/LKFiQi12dnZdC2wbjZNA+sjNcCfx30LbitVzBpRWUObalr6WUYY8vqTNYgWZ3MoTVHWASK0xYeBonLZi7H7VMd5rj+gNjnFNQfQME/vBTNqXZf0BMU9GR6Njz4AHUhwX+eiZmltZBa9kIBvFApThqiWSLmP3uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNHN0aqnUGRGK/NsTOGjSTGKz4I4m8qDYT5dFw2EaBo=;
 b=WncGw6b0PT3l6OLbZxDo0DznMzDyT/9N+HbiHGawSmw7NNe/DXqu3Y2kDwzy1vOEPWyiZErZ91Vpule5FCdF+Bs4nEgUrg7NRy/gPHOqK5HVGszG8iPPJgH6AaS+6PCpYolehK/fWMpaYLPfTNKCBjhoJ+AoUQj9f/3gbSNyy+DXv4FqH/hUWONNmXn+VoEuf0aIK6e0gbQ2gl4J5ER18ZzLs8WhUPLvz/3fQwSfZ+2iwp9000o9c0n1PSlV6BJQCs4mgQyd57XqGWuyXvg9snSIDqp/VpicOYKwLeBV+efOlBHuFN3tlOVr99z3gE3L8vx4uR5jyTECybLZx+jyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNHN0aqnUGRGK/NsTOGjSTGKz4I4m8qDYT5dFw2EaBo=;
 b=LQfz0xezbMQdhO3/8VJ/pT0+/5pq3XIhQblDfm5DwqBtusYPfVkc+RJOStKtceCyJiWVHmIlP08i1b6a7LDxeudMv7L48LvyxbNaAGqsnfgjtSGLp52NPvib+xF4KuNL1MgNfOprF553Zu6N0YJu2+W5Z5+89fwhjIrl/FIdrnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:45:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:45:25 +0000
Message-ID: <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
Date:   Tue, 5 Sep 2023 07:45:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
To:     Hans de Goede <hdegoede@redhat.com>, bhelgaas@google.com,
        rafael@kernel.org, Shyam-sundar.S-k@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: df491f4b-4e4d-4a2c-29d6-08dbae0df954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT4AUGVeQuQdlzQOUvSNWQkF3CrZCX6y4uUgpT21BpDq5SX0NdABRH2hcDmatvdX+SSrv/LIRQ15kRez3fXiSsTb17b16tp76cRjVnDCtzyF/Fz3Dkpuc5GIuS6exb9yrue26MpPOZ9uu2PBLSgpNLo7lxuKIR58HoIBJf6RxkEzg7YxOPYqYj4R+BUStIZlV9TiVvVOiB+BF/HIsF/sxIM+XbZ8/Fzycavf/JWiJ3v8pX17fmmJkWxXrzPjfOqepyeWjtZVRTSwAB6KhB7oab99krn/uyu75+PvCJuE+Vm1km70s2ns4HsUcbApsvwD8rqctHR88lIuoed9quvTl/tc3L33BewmMWDn5dVtiw/mLuq9oECjZH5EbJrUsZ3EU6jVNkv/1eutkp5kMBOgRIawumyRsgQ/Ce6kADwl71XoQoRsoocTp4nUWNF6BBkttmSXZdceJm8sNSc/fVt+VluLr7mm9yX1baJsSA1hscTQJqterTRzhdyKLFWizkOCpAzitr4ihJ33uC4wU/3k1rAaHk5nhhKeBooPX/eeTb0R81+4gsDUpEeeP0Db36M+UOIDYXVfTgNz530Q3MmNx14mH242CNNG1CcKyfB3ptliUFxwtcyj4PFfRWeEkRuhnr9uw/nQobkm7izdiNFOAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(2616005)(8936002)(316002)(6636002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(6506007)(53546011)(6512007)(41300700001)(5660300002)(83380400001)(26005)(44832011)(6666004)(31686004)(478600001)(966005)(2906002)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtkY1JPTDlNWWc4K2xNYWR0NGd5R3ZsM2JaQnpsVjJoQUNPMUwrWXk5cEp5?=
 =?utf-8?B?VmtjVGFCa0lCcGNLKzJZU0NkbDI5K1krdS93elJEZFNnbGRPcGl6MlhpbS9w?=
 =?utf-8?B?d3UxTGx4QTVMN2orTjRqZXNaS2VhZHJHNXBMZUVnN09Ja3ZOQzRCMlJsYkpK?=
 =?utf-8?B?WG1kSnZqRVFYL2hGR2svMGltWkhwNEVsTjFKZi9sN3BqeElqOVBaaGppRG1W?=
 =?utf-8?B?bTdqUUZDbkFoSmxod2loN1NwQVZoOXFzSUpMUzlNUmtMR0haY2hJZGFiWHRa?=
 =?utf-8?B?RHc4bkdFVXc4S3lYUm05SFplaU5BaHZjMytFNWhRRGlUenVLYjdINGNpQXZL?=
 =?utf-8?B?czhEbDYrMk51ZjdDVGtLd1Z6OVQvU0ZEWENQQ1U1TEVMRWR1RjVIN2dxaE81?=
 =?utf-8?B?VlRrbGFzcHFJLzlyL0dRNWlHOUF1WjlLTEd1Q1k0VDJZeFJBNzZjMUZROUEx?=
 =?utf-8?B?SjdScFIyVnViWFkzYk9Zak1PV0JWVjBPMHpOcXZNUFAycy9IaEFkdVVUYjJU?=
 =?utf-8?B?WUh3enNRNEdBbDRVeWgzVHJaejdBWDR2L3hqcjJqdTRncVZScC9KV21wd0hK?=
 =?utf-8?B?WVJhWDkyVXdoc05RdndTeGpvZlFEZUVmOFIvMWhwMndwZGpTR2trSUpjcDRu?=
 =?utf-8?B?NlJZMExXcTR3S2JMa2hTZjlTV1liM3pOdW1kMitLR01USVY5QmRSTi9uei9Q?=
 =?utf-8?B?dUwrdGg0YzY0ck0remYxcnRSMVoyYS9oN0tzZkNNOGRtOVBMakQrTXVKWHJM?=
 =?utf-8?B?eWFRb1Mwb1BMaktvYS9idHZpc3gyWm02bkFnaVlBbnEreEtpbjM3K1JRUkRz?=
 =?utf-8?B?Y1o1VXpNemtxZ0tSSUo1QlFjaXoyS1owb01nYnJtSWZmNlRhTU9VVlFhdklH?=
 =?utf-8?B?TGI1VUQ2ZUhSRXFRbmhvU0FzdnM3OStTWjl3R0NtaFJVdkVPTkRDbVlMcXdO?=
 =?utf-8?B?b0psenNaMlk0U3ZLRXlnKzZ4R1Z6dGZtK0NKSk1nMkpCVkhlZXhUb3VXK3pv?=
 =?utf-8?B?ZTRHMVArbUpzQjdac0JMYnltakV2YVQ1cXNuaUdpb1FOaFNiWE5yVnRTazhv?=
 =?utf-8?B?a2YwWkZjUlVmTktRWnlwcnY2M1pkNEVvcFZmSTJNMGExY1ZyNkEwbzRYRVhF?=
 =?utf-8?B?b1RGUlVXL0s1Y2JnYS9leDlqYTBPQXE1dzdZMWhUN25ldkZBU00zQTM3SHJ4?=
 =?utf-8?B?TFVNQUt1V3oyT0xCb0VsT3ZhUE9PQnJpRWRyL2h5SlE1V1dqYllDcFlLYWN4?=
 =?utf-8?B?ZU5VRFVGckJmRkE0b0t1Slc0OGlTQXdON1E0eEFwbExnUlRqaFliNG5NcVpn?=
 =?utf-8?B?T25HeE53MUlSaTY0dC9VSmdRUXBLcFc2NDN1R25tMmxNc0RKNHdEb25ZN0Mv?=
 =?utf-8?B?NURCUllsOEhoTFZ5T2hISjhrRXdRZVZJWk5PYjVBVGVYZmdVaThFVkpxUkUx?=
 =?utf-8?B?aE9hTlRQMHV2Nk9GN2ViOThQZWJZcmh3TzF6blp0SnlFaFgvMkUvb2RnL3Fw?=
 =?utf-8?B?UHlsUHJERFdrMFVZZk12N1NaK2lOZXB3bU92RFJSME1ZaE9mK1dEZjc1b1o1?=
 =?utf-8?B?bFJVN0R0aXd5MU9ObWE2YVkyMU1hM1FpNi9VSHBrd3ZGa1oxcW9IL2I2bko4?=
 =?utf-8?B?aFQrWmo4WC9aTlRXUEF3bGhTMmkvdkttUzBmL09qZzhXbllYUnk1QWZXT1Q1?=
 =?utf-8?B?ei9senhmTzh5RUlPa0QxVFNzZ0I2YjBGampPcEpRZ2FsYmdRWHNjU0hNRDFM?=
 =?utf-8?B?N2RHdE1mTWw2aG90ZFIrRjNydUZtcGpSdXJub3BxSGF2RnljeVNtYlpMUm1G?=
 =?utf-8?B?OFRFdklMczIzai80NWNoLzR1YnA0L2h5dlZST0ZnQUFIUHJoNDFtZVRKQ0pm?=
 =?utf-8?B?Q3FwekdiTnhNL1FqZlJZYzliMXpFR3pqdnFVUDZXMjRYOGxqVE14M002RUFF?=
 =?utf-8?B?dUNnVnozOEx3Yk45V1JtS0RYczE1RHp5RkkvUWpSYmpMSG85Ky9hQ2c4TzdM?=
 =?utf-8?B?ZjF3TUt4TzN4dVNtbHlaKzh3dW5NVzV1cHd0WmM0cnVPdlZacEoyZ3JGblRJ?=
 =?utf-8?B?eklsTjFnSy82N3AwWWR2ckNLdUZ1eVRwWGNQczNmSW13ektkbUhFSjU4Vktj?=
 =?utf-8?Q?eCk+2XkaCBAve33aNKUV4ATyh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df491f4b-4e4d-4a2c-29d6-08dbae0df954
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:45:24.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q27g+FacnmC2WMd6p5e5IYRN1nvuKaFxzy5/8OMPIaM7j7dwQdLmKLNcpa3fDTu/k8MSxBwHefoym5FBSXOZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 05:13, Hans de Goede wrote:
> Hi Mario,
> 
> On 8/29/23 19:12, Mario Limonciello wrote:
>> D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
>> This series adjusts the amd-pmc driver to choose the same strategy
>> for Rembrandt and Phoenix platforms in Linux with s2idle.
>>
>> LPS0 constraints are the basis for it; which if they are added for
>> Windows would also apply for Linux as well.
>>
>> This version doesn't incorporate a callback, as it's pending feedback
>> from Bjorn if that approach is amenable.
>>
>> NOTE:
>> This series relies upon changes that are both in linux-pm.git and
>> platform-x86.git. So it won't be able to apply to either maintainer's
>> tree until later.
>>
>> Mario Limonciello (3):
>>    ACPI: x86: s2idle: Export symbol for fetching constraints for module
>>      use
>>    platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
>>    platform/x86/amd: pmc: Don't let PCIe root ports go into D3
> 
> Thank you for the new version.
> 
> I understand you wanted to get this new approach "out there" but
> this does not address my remarks on v15:
> 
> https://lore.kernel.org/platform-driver-x86/53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com/
> 

Right; I called out in the cover letter this is pending feedback from Bjorn.

> Bjorn, I suggest to allow platform code to register a callback
> to influence pci_bridge_d3_possible() results there. Can you
> take a look at this and let us know what you think of this
> suggestion ?
> 
> Looking at this problem again and rereading the commit message
> of "platform/x86/amd: pmc: Don't let PCIe root ports go into D3"
> 
> I see that the problem is that the PCIe root ports to which
> the USB controllers connect should not be allowed to go
> into D3 when an USB child of them is configured to wakeup
> the system.
> 
> It seems to me that given that problem description,
> we should not be directly messing with the bridge_d3
> setting at all.
> 
> Instead the XHCI code should have an AMD specific quirk
> where it either unconditionally calls pci_d3cold_disable()
> on the XHCI PCIe device; or it could even try to be smart
> and call pci_d3cold_enable() / pci_d3cold_disable()
> from its (runtime)suspend handler depending on if any
> USB child is configured as a system wakeup source.
> 
> Note that it is safe to repeatedly call pci_d3cold_enable()
> / _disable() there is no need to balance the calls.
> 

It's only the PCIe root port that is used for XHCI tunneling that has 
this issue.  This specific problem is NOT for the root port of "any" AMD 
XHCI controllers.  There is no problem with any of the XHCI controllers
going into D3hot.

So if a quirk was used in the XHCI driver, it's going to mean examining 
the topology of the PCI devices to find the right one.  I really don't 
think this is a scalable way to do it.

The big advantage of the way this quirking is done now is that it should 
mirror how Windows makes the decision.  On Windows the uPEP ACPI driver 
uses the constraints to orchestrate the desired ACPI states for Modern 
Standby.  In Linux we can then use the matching driver (amd-pmc) to make 
the decision.
