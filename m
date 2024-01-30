Return-Path: <linux-kernel+bounces-44027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0206841C60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B5BB2302D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3C4CDEC;
	Tue, 30 Jan 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fyzWT8Hl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615C537F8;
	Tue, 30 Jan 2024 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598799; cv=fail; b=n8CUnuhqRNkfbnWz9WI/H4yHRAF5klRWAE/jwMgUVSxMCDDsD3+O0uZGfNt4v+o42rVO4VyoKhYpgTXRxdq+4bU89U6nesbgMaOOfpGbvG+ruP4pvfjJhC7MvthwPIu+hxFx+Uhq9LwPwJ08h6lH3oyoYr3i2Ufz9BbYtzUtH+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598799; c=relaxed/simple;
	bh=q9CuDeCy3iDbuS8HHQy0fciaXQ3rF1x1P5vJOorWUpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aW+nGdUVX30Y5JaJFpyJLVHHZBtnbZmqdNCORkRLEUlxnhNfRwEfxf6aHZo4J+F9eIkVCdEfaijjNRwLlD3is/GXyrWyPtGT5iMcpJj4SUvVp/WnaGaRbxAOUc0I6DIoY4E/VSEO/HHNugGMJB01Te3lN7BAMQ6PRZede8yaZ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fyzWT8Hl; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mahQSou72zMGeqD0mxXHx38SikqNnZhtvL5f+l9m0hhmwtiACzdBnDiYQQL4VSIOgiHhp7AFFgG4N0NIlJ7LgYrXXUqprGgWanIHHvY5svT2HXCB1W5HAEdpZLDN0J9llF6jILbe9ltD1rQh0N7L5AFCjYtk3XfM8GjaqZTotggKBNstIpCfH47yCRqG3PVbdHL5IPP+nrdcCCUzRy/0WyQPgQ3EZz4yuLBqfKbwmfeTgGHmP/ruUjJlHbJXYkVQyPcyV8Tkx/eeFzSZLetG2F9kDfJKMKzzM45rtnI2SQP/wW+20S/BCJoT6cJ26gNpNm4jcB65wWNL/VCJ/zU1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2peciSiELEHhSI5cBWJ8imZ66ZEP6ZjbBL760nEwRg=;
 b=FOhzZPXo0qO4P+CFzLTwSjngDWvyPfomQnFlvP5ArmA1tJMcCpcNPag0nqsf3k6yHGmHZT9QV85iDLWOGgUPzH7JehGpeYNhQPh93oeZj69e8dM6XBKantUeyWVWm0dMxsIoidxmT6uLp6+fMooQ+N/7C0Suu/ho1ZSd2qVSTBfGOP0FtrPFk1DozAFEsCKdX2jpdaQuCt2rk+e6iNSNrfNEYYF3rpTN6zHiohWISBQIvazdyE4uHE/Y9a+blF0rjOjx6dF2wmqxVqJdfJQyzmrEt6UQ3Qak+kNwhKhip6g/fIsBG/Lj8it15Ovkae/Ho5wXWjhqDNIkxVEnbOtTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2peciSiELEHhSI5cBWJ8imZ66ZEP6ZjbBL760nEwRg=;
 b=fyzWT8Hlh7/innOuRgHVueb5YJyzt/iUxyPINI5U1/1mktPUWQeNFOoXtOhYWz89gi02dZjBv64reABFIxEVw7PBE93YZY8k9ewdDcmBB7ol48NjiFQ+8+EtEaLQAr8DeUr5nQOC+Op77/dHY21GoU+rdXJ9bWFq4qGVUUv0bY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 07:13:15 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:13:15 +0000
Message-ID: <ec0f347c-483d-47d2-b868-0c64070cc153@amd.com>
Date: Tue, 30 Jan 2024 08:13:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe soc-vvmem subnode
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com>
 <20240129-vastly-hunk-0680e152c03c@spud>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240129-vastly-hunk-0680e152c03c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: cefb541d-bd9e-4149-3acf-08dc2162ed8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5LuIMB5QGCbYdtgbPryT0fuca5DQHZ3cZ7KAzXS/uync/FmfO2nzJlYJCdG7mPKivRVvGr/OPzZvdp12I26EWSJtU3c74J4gsKZy9prntEcvbsKkbdMDT5pbHQi7bO2nAWlWfye9MZWnaAkgv8FtKT2kPZmWLZHRbC1up3HSgGujZICUaIor44tI/NJZqKmKwDBxE+wrmOJjy7zteaXmcGT/IqEp+X9JksIF3it+NM6vHvP8f7BcYjOzMg3V9CpBwh8l7IvO1rerAD9N3zYzLmDyvAc9b499nFLFtc3kuTwHMKealKqaWWD4nM5ZUS+m1oZ21m44T71nZo72xEtPjOxxpktwhPA6ItXF9Fzjg+YL9Hl86PjfxKD3B9g0fkLdNxWGT+hy0yGEWJ4rfxvdbhXih+k00BqtoOgaYrsQKuuss8VLqITSiH0dIocKs+BgPqV/gdCH6RUTogVlhQRxKiVEkFAyjkzKgDaAyBFGp/75Lbs6wa4ZPAFE/9AHVo5Hgt/uHgg3XjGxXsJ8g1yhMBK5pAvascDich3f+oYwMQdlAN0E6H+tFUFWD34/yq/dqHXerCnytgbxzmjWlONr77TGxUt/4+AiFEWylVgfkD2RusNniMzZlDGcgjLJWv9vZR0oKev9WzaGOpU7JxZ//g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(6666004)(6506007)(6512007)(53546011)(2616005)(38100700002)(86362001)(31696002)(36756003)(6486002)(478600001)(4326008)(2906002)(41300700001)(83380400001)(7416002)(5660300002)(44832011)(66476007)(54906003)(66556008)(6916009)(966005)(8676002)(316002)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEFWcnZBdUszalNyUEZxaTltWEtBSWxSd1JHTXFRM1lNdUlQTDhlbHZoZ3lL?=
 =?utf-8?B?b0tRS3BMd1JnM212ci9aM3A0WVYrcEsvcGlyczJIbHNOU1duUFZOVk9hUFhq?=
 =?utf-8?B?dm91ZDRPVS9PZHJrZFBRNXBFbTFMWVd4VjBkK2Zqbms2UDlUNXhXR1B4OHd3?=
 =?utf-8?B?UzZ5ZGxWQzFpd1d4UVZEK050ckhGZk5tUG8xWTNTcnRObnFEdER6RHRxWEtG?=
 =?utf-8?B?L2xJQkZvT2V3SStad0Mrb0paKzJRemJIRFBlYmtDWGQ4djhGODFrbCtrai9U?=
 =?utf-8?B?UUxrc3l4S2x4aGpzRHhTK0NtWFRXNUEwY0RvTEFPKzNwa0RTVXl5c0hsY1Ex?=
 =?utf-8?B?em9scHdtcks1cklQaTBaTjd2QU9tMWxheVFiSFhsanpZUm1uN1VDVm9SNzZq?=
 =?utf-8?B?VXVOM1YzRTMzK3B4WWMyRElTOUM5bDNiU3JOOHB4UUtPNnY1U0xCV1NSTVhB?=
 =?utf-8?B?RlVTYXdYeUI3MjNpdW5FTVovakFQa0F4dHBRdTQ1S1ZDZHFXbFZYYmZxUDFo?=
 =?utf-8?B?dElCZ2hPcUsyTFhyWXZnc3NOSWlUaUpWVm9WakFTL2hjMzBoSHAwaEorRHlD?=
 =?utf-8?B?WDZGZ1pmVjZsbGxpclVYTDNrYzZLVWNZYjdVbnQvaUt6dGVNeUhaNmM5TFFh?=
 =?utf-8?B?U2tyQksxREl4cHVJaDhiWWxQMC95UGxEbWhoWU1kcU05RlFkbFJjSVFiRHA5?=
 =?utf-8?B?YStZbzE4QTVtQzhGekdTbmhjN3c3R2J6eHJSK244U1NOYjJLTDlFaC80ZzJ4?=
 =?utf-8?B?anVXSXlTYjc3K0lyOFdMMkswMGIwbFpNSjB6cXBGSkpSU2UrU0RjcTZhSXda?=
 =?utf-8?B?elJ2eE1YdWdTUGdzYmNTd3dWenRxQWd3eFIzT3BDS0tzd0hFVllWMGZQTUxE?=
 =?utf-8?B?UzRSajQ2aUV2U0I0anJTcE5YNGNmRXF6a2o2U1FraS9RNDFKa1ljcUFvVWRw?=
 =?utf-8?B?R2o4clEvRndEUGtzTVQvYXorSGphbHZXREpTWjVDSkhRRDNmZDRlZHNZRWhC?=
 =?utf-8?B?dGN3dDIwTlBPQS90UWkxcUNXWWpHMi90elFDTFpnM2hTVVR5MXFwSXBuMVht?=
 =?utf-8?B?b25BbUdGSVo2QWU5Q0lORWRhaGNCM2d3cDNrODdvOFJjZ0JPbFVkV2pISENB?=
 =?utf-8?B?RWkxNEE1NGRnQ0VBd1JoSkZob3JsMW1tYzN3NDhPZk9lZCtIUTYrbHRiWVJq?=
 =?utf-8?B?cnkweXFKWC9rSzZwWThFcS9idWpKSEZjdVZKNTBVZ3hGK1c5S1BWaU4xOGZq?=
 =?utf-8?B?UkU4b3ErRUs1cTd0RHNKdXlaQVJyZXhIY3lWNHU4MWRRbHZKYkVSVGtMZWFU?=
 =?utf-8?B?dTJCa0ppRnBpRThqT0RPT3M5a3FPcDdpMmliYi9tUzZwaXU5clFjaDltM21p?=
 =?utf-8?B?TXlaNEJRV016Z3B2YXB2YTg1WU5OQWhKN2pwOGdaYkY0MDRrUmVLakE1Z3Zw?=
 =?utf-8?B?NjY1aTkxem40K1lRb1lBbWYyUWljb1lmTTUyWmZ6cHFla0YwM1U5ZlBBMyta?=
 =?utf-8?B?cDAwUEtYTC9LTEZwSENpcHVPYTNjWDlCUmlyMFZOeFBHSnJOMmhCVFFSU2Zl?=
 =?utf-8?B?WEJZMnZ4TFVKS2tWWTZpdlMvcEFNTU01UjZyNXJVWEk1aVErSm5LQTFua3BC?=
 =?utf-8?B?d25pTEh3RURqdjljR2dRejU2c0VtMXUxbUJRLzdqczB5OTNoTlpkcGx0NUJ4?=
 =?utf-8?B?Uk8wRG1Md3llN2paK2ltK0dqSGVuc2hZTUc1cXp3S0doUFk1TWFxNTZsRkRF?=
 =?utf-8?B?UU5CcU5NcFBNOW1ZaE1MaitGdDRERlNtR1JNaXNieGpWdms2ekUzdkNIMDAw?=
 =?utf-8?B?U21kZmZjOW4zd0ZpVXlyb0JZU1pNMjk3aDgzWjloeE9acHRaQWpRb0JnQllX?=
 =?utf-8?B?UE1SOEl4NGtyVlV3UWZ6ZjZsTmF3cHpYeFJKelp0SmNudmxoalh2bWNqS3Zn?=
 =?utf-8?B?eFBXK0VQTHZOK09pNGpJNkFSL1YyS2ovcnNGVlh0Q3RMTzVtL1NldjE2cEVM?=
 =?utf-8?B?ZkYxekVtQzA3K3B5MVlMcElvWXRHRldOTHFDNWcvTlE1VzBaam5nY0doLzlO?=
 =?utf-8?B?M01RMjNPM0tKTTlqUGZlQnpTcjNReU9VRS9yWWtvcnRSLzdZK1huV2JIdzVY?=
 =?utf-8?Q?CVqe1WeSz3PRYazDxdSbr3u3M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb541d-bd9e-4149-3acf-08dc2162ed8d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 07:13:15.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0T1ztNye2pkRUHPP2NRP3TCbjDpcna+NJU+KT20Dfd3W+O/zKcsIttE3UoTtpuM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012



On 1/29/24 17:57, Conor Dooley wrote:
> On Mon, Jan 29, 2024 at 01:25:06PM +0100, Michal Simek wrote:
>> Describe soc-nvmem subnode as the part of firmware node. The name can't be
>> pure nvmem because dt-schema already defines it as array property that's
>> why different name should be used.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Dt binding for nvmem node has been already merged and it is the part of
>> linux-next tree.
>> Here is the reference to it just in case:
>> https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@linaro.org
>>
>> ---
>>   .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml   | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> index 7586fbff7ad6..108772ef574f 100644
>> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> @@ -62,6 +62,12 @@ properties:
>>         interface.
>>       type: object
>>   
>> +  soc-nvmem:
>> +    $ref: /schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
>> +    description: The ZynqMP MPSoC provides access to the hardware related data
>> +      like SOC revision, IDCODE and specific purpose efuses.
>> +    type: object
>> +
>>     pcap:
>>       $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
>>       description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
>> @@ -110,6 +116,9 @@ examples:
>>       firmware {
>>         zynqmp_firmware: zynqmp-firmware {
>>           #power-domain-cells = <1>;
>> +        soc-nvmem {
>> +          compatible = "xlnx,zynqmp-nvmem-fw";
>> +        };
> 
> Would it not be better to have an actual nvmem-layout in here? The
> ~empty node here looks rather odd.

No issue. Do you want full or just nvmem-layout with compatible string (which is
required)?
        soc-nvmem {
            compatible = "xlnx,zynqmp-nvmem-fw";
            nvmem-layout {
                compatible = "fixed-layout";
                #address-cells = <1>;
                #size-cells = <1>;

                soc_revision: soc-revision@0 {
                    reg = <0x0 0x4>;
                };
            };
        };


> 
> Also, there's a type in $subject of nvmem.

will fix.

Thanks,
Michal

