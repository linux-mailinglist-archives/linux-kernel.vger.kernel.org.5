Return-Path: <linux-kernel+bounces-6522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616678199EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183EF28580E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AF171DF;
	Wed, 20 Dec 2023 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YmgLmF//"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F61C69D;
	Wed, 20 Dec 2023 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2PSXxDQlV38KXPdMaV3ST1kr/QvAE0XBzp2cGSTAK6Ydv76ZDlPMN6ocLIMkQ9c/H4Pu8p68JTutECkZ1yUNhPqPZOwm+l8CaoCkJ0b5oNESMVkW1sA8hBRKsW4LhWlDJrxTTUCKokGqkIXQXW7+rYSEN26eLz/a9+MNNt+Zjy9ucaLpTWn7tuHq/P8ZOOlobDvfRJGh4/iEKLDyeV9nN7nERl2Jhqzo9cM4h5p6P6D3LTY9cR5ADk8y5StPI/bFkdQgm0cPZDNShvtEC75cYF2R09lsHRalsjP9gUZAEjodHUXlsR2kK03ye83XSZwXqCZ2frPO8Ysx6BVBIqJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6ivXr/WCHpORlfMWVSFcTX2HG6RsrGzMf/g6l5EScw=;
 b=KOpmHu5p91KJJNne0nrTWItR5L5/HbePygqZHViOMCmjHrYd8XOrLelrP1fUJ1FV7oiLiaOiifj3pyLPH9855NtUFp6QtUjLAC5QF+pcMLEousQSVoMhdMrefnBNHcmT+Bt7Wf4NNhsWJphOA80JMNizwjjL1eCI5ZxA44g7EZQo4xmZu6f0132RVmyi4hghtvYZSnHhVbt05n46KGakgN4QzB6C9ZUzkzLiHegigD2ivclcImUBtvxZZuavSQIvbsa1nArEvCXw+Vhil5HgZ4X/UO5iyF5MGBiBpV4nb5wudKGdXf0RsYuAlvDFSCPBDg/ikLXohc9gqr7/aGW46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6ivXr/WCHpORlfMWVSFcTX2HG6RsrGzMf/g6l5EScw=;
 b=YmgLmF//bPWZWwHX5eLvbEWcaeawjDEKAQSYcGFXMtXa8vLRbxux14i/SVxulN2oObZW2Kw7TaEB76/B0PLBbgBemO7u/ssAicMNYPEzirkjfrCHNMxnPcw8ktJpKHMe6zZmbFqZlo+N5jxJX2Nm/rcVTDVr9OkVfiIQ7QJWn/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 07:57:41 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 07:57:40 +0000
Message-ID: <bcc3a802-70cd-425e-bb33-3ced81c038fd@amd.com>
Date: Wed, 20 Dec 2023 08:57:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe missing child
 nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 Rob Herring <robh+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, devicetree@vger.kernel.org,
 kishore Manne <nava.kishore.manne@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <5bb16305a05692de29ee2aa2accc793e23b68dec.1702997680.git.michal.simek@amd.com>
 <fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::21) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ee2939-18f8-44c6-a9e7-08dc01315706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Crr4xZeW67HhB+yfsla44u39KYX+GNOroa8ZtMsROWPTU2hrrOe2XdJvdBWOjKYeS/pvf8cED8LFpzA1XNDpsuL8r8q8aS9lVTWa6BWsQHFELIgLzw+O5qFbG2HjGTxxyYbLWIiZUSMZQ2OvMhxm6lp3FeUVBnMkZK1lRraMoumVd5w+sceQnQp5bgfn3xsi2zufpMzPWYPE92AMZtOC7sqXjyFCofX934jcBrWML5Y7LcGbkR564Tr2yqY49rl4h0walo19kp14bCLaHdsypSOsKsCoCKq0c6f1gRAvHLROj5xNoe/O+NZQsJAyNk7RTantawQdN27eJjsEvGiWFdrbpwjqrwxf8wNA8he+fhCvbnUmoNsBAnCMWfpc2c8vOPL6Cb/LyE+T/z/IKk9IqJWcTXhFJXtjTluiWlA7vRTTX9tQxtF1Atf7ISHqTP3dWgSLHNjm9pl2PCowzHCe9ySAHgcuUkj9lHYhqF+RgM2C7ktKF3JEjSAngvZ5WZSaYsL59r7cMIENAbMiThSGOuW+Udf9sWa9ZlHsoz3ghfKAJO/FQ/SZr1X03EY7ua9v0rNB3o/p4dHx5uQH0vc+OL0QeeZ6JSiXHKVzG9rF75Mmr8hquSwIuWq09JyZFEGab3QT8HLTCwQUWiuZ7cc6KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(7416002)(2906002)(31696002)(41300700001)(86362001)(36756003)(38100700002)(6486002)(26005)(83380400001)(478600001)(66556008)(66946007)(54906003)(66476007)(316002)(2616005)(53546011)(6506007)(6666004)(31686004)(6512007)(44832011)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZrcmxISmpVQWJhazZPWGtpczdhUzVvZkxZZ0V1U2ZaRTMwSS9rQUs4MEhX?=
 =?utf-8?B?U2RFNFVsZ0ZKSHRuc3dVLzA4aWJ6Tk1OUkx0WkZOWHgvdVYyN1Y5THd5VDZM?=
 =?utf-8?B?ckJUR2pUZXRsY0RQMmJpWFZHTFZTbW81cDFVVTF2WkZoa3NTNFBtakl3eHlD?=
 =?utf-8?B?T1hpVUE3dExaVUk0S2x6Rk9xaUZCbDhrcHFYbG5YZDFlVTEyQVJIS2xaaDJ3?=
 =?utf-8?B?QVFNL3J4T29NbytnOWtKUXR1eW5LK1p4ZXo4bVNFSUdUaEpIbDNEdzNWNlNG?=
 =?utf-8?B?d0RFQW1GcWV5TkRhVDRNbjdlVHVzMWkzMHNhMEgzUDZoWmZvY1NYNGpGajc3?=
 =?utf-8?B?VXFsN0ZrR0lKL3lNcmRZNG9RMlFubWI5STdiSUdTVFlEWG1JYVZkd09STnhr?=
 =?utf-8?B?YmdBSDA4cCtQb1pJRGFHYnU0OHA2RFZWMTV0UWluM0FnbnRndjd1ayszOW1Y?=
 =?utf-8?B?YXZSZmI5RW1XWFdhSVh2aVdKUjVKaTAzcjZUQU5OUDlhd3lGc2RZVktqblRh?=
 =?utf-8?B?eUQwei9zUTR5bEF5TzJyd2doUmVsbHJzTENaZEROWVRKMEJQSmViZnozWnE3?=
 =?utf-8?B?bTJwZVhtbHBzSkF0Tm1Ea2V4MjFQeEd4c01mdWxRaGlCMjZ4b1lDWllEV1Nz?=
 =?utf-8?B?MjZaYmVvcDJLV1o2dTlvN3IvajY4SU5WTjlxTjR6T1JhOEdtUzlqU09ldkJv?=
 =?utf-8?B?bU1BN1BsNjJRb0NHbGdhai9QMnAwKzdSNzBrQ09FSDZDYnoveWhaallEVzBV?=
 =?utf-8?B?a05TOGhvMmRmdEdlNExEZ0pFWk4zNXFQNzJCYUlrTGtlZGNDNHR6cUpDZ1FD?=
 =?utf-8?B?bTJiSFZIcmNhMkx2UnpSUGI1b3BFMUFNT1lKTnRQaHFmc21zOEJEN0RRU3VB?=
 =?utf-8?B?emNkZ2o1MFFBUEs0N2NpdzZOa202YUtmOGppYlNTcmJIeExjZEpIZEUrUG1M?=
 =?utf-8?B?Vmo3OGx0bCtJb2dzRWhBOE0reHVBT2FtbGI3UTdkeG9jOU4zbFdoOVBaRHRI?=
 =?utf-8?B?c3VWcStwK0JOUlk0UHdEQ0s1R0FkOUMrZmdQVUh1Ui9DSkNqclRrdkU5eWpZ?=
 =?utf-8?B?emhFZTVmb2RSY0dFblhwQ1ZnbW5RM1AwTEdYVTVRYTRZYjRQL05yOXRlV25M?=
 =?utf-8?B?VEYxZExqU1lLc0YzQ1h3NHY2YUhlTENDYUZ0SURzMzI2WWpKUVRvNFJNMFN2?=
 =?utf-8?B?ZDI5NGt0MUUyMUhjZ3p2eUpEOFBKckNPNXFDMUJIdnpzbjVjWWxHZHV6UGNK?=
 =?utf-8?B?N28rK25FWFpRQ05UNFJqMDRYT1dIYWwzN0tSNDM3U29ZRXBQSEZ3TmdIdXdD?=
 =?utf-8?B?Wmt0YXZGNFZFMnIrR04yMnZlcGxqVkJqTmZPMUQ4SjYyWVd3ZEE3S0FSWXVq?=
 =?utf-8?B?VENBNzBxT09yOWQ4QVluUDFmOEdrbGhteGRVbE9vNGZaT3dhYjBreStGZXVk?=
 =?utf-8?B?VkxxZDc5OTUraURlaDcvUGtsd3ZOaFhhUExUclY4cXVuZTNCNjRUemEyMk9r?=
 =?utf-8?B?SkttMkJsRHdMczlLcUsvVWdhTUg1TmY0QXRXVjZGUEthUWJ3RURoMWFnMU5F?=
 =?utf-8?B?SWxrT1FiSG5zY1MwcEFBT25Gd1hSazVUZk1GMVhwMk9yZjRzMys1bzY0enBy?=
 =?utf-8?B?cSs3dFF0dDJ1ekpLb3lsa2Vna2Q4Q0dtbU9peUhKTDlBT1VvelN3N3dldG80?=
 =?utf-8?B?ZjV5M3NmQjhINVpjUGNuRENKbnhFRzdYY0d1cmtZc0ExOUxxd3dpcGhSelQ0?=
 =?utf-8?B?ZEw3LytLOU9pQUo5T1BmUE93eGVobmt6ZEVEdWcybUl1UGc4T29EU2h4cmdJ?=
 =?utf-8?B?cWVob3lxMktlaDI0RW1pWWFEQy9SYmxhRnI1TWFUMUJGOHBrUkw1dEhsL1BI?=
 =?utf-8?B?UGxXSmdJZDJ4dHhsNXZzOW1lLy8zaXR5eEtsWk9pOVNnb3kvMnNYRWlhZ0Vn?=
 =?utf-8?B?blhtNUNKSU9XcllhVFVqeDdkL2RUcFVKeVp6V3hOY3I0ZE1DK01iT1RtcTNJ?=
 =?utf-8?B?UzNoM2VJdHJYcTZLMTNlVFI4MTFtSVBXMkRwT2wrcjZlMHhMTVpYSFFMdjFw?=
 =?utf-8?B?amZSWEM0K2ZkNFRsblVQejl2RnFPTlUybnhjTTl0S0FzeDQ4Wk1ORFhZSDRB?=
 =?utf-8?Q?gYsPRXih/I/p4x6SWh3XVDLBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ee2939-18f8-44c6-a9e7-08dc01315706
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 07:57:40.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amzizLgxPZ6nOcqEH49/GaKC0uJWy3LuVaMKHJ6ISP0ihrvngHrgY5GTFG8n2vSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828



On 12/20/23 08:53, Krzysztof Kozlowski wrote:
> On 19/12/2023 15:54, Michal Simek wrote:
>> Firmware node has more than fpga, aes and clock child nodes but also power,
>> reset, gpio, pinctrl and pcap which are not described yet.
>> All of them have binding in separate files but there is missing connection
>> to firmware node that's why describe it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> index 3d578f98ae2c..0662544f86f0 100644
>> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>> @@ -53,6 +53,37 @@ properties:
>>         vector.
>>       type: object
>>   
>> +  zynqmp-power:
> 
> Can we rename it to "power-management" or if it is a power-domain
> provider to "power-controller"? Assuming nothing requires the old name?

I don't think there is any name dependency and node name can be renamed.

> 
> Also, all these nodes/properties look like not ordered by name, so maybe
> it is possible to add new nodes in some order?

I am fine with it. Do you want to sort it before adding new one or add new one 
and sort of all them?

Thanks,
Michal

