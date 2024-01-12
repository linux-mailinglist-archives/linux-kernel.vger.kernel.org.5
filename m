Return-Path: <linux-kernel+bounces-24332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B606382BB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01F1C24BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F35C8E5;
	Fri, 12 Jan 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="n5tF+X+R"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1E1B28E;
	Fri, 12 Jan 2024 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40C3xCKn005564;
	Fri, 12 Jan 2024 06:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=jLPPGGgZP0vMte6r1GqUyqkzxxFEQ88chqsE0l85Uj0=;
 b=n5tF+X+RfKha2Tm4ZCZ6E0as1IbbG7y5+Y9dLMvLrLXanzvCd9hiO1u9oVoLJfjS9eov
 ddWSKhiMchaK2iikwgzXm+EPf+xFMMWRvviOqmYUmBuhMzZdHbpqqPwQzUTfou8NeqpI
 9grvPLDcWge5E7RIJXT4wAmO5o7m2UHU3Xzkz3+FVdQYT31Vhw5XK7r4mj5MCC6svKhK
 DhzxVLqPBor5Qu8TZLEzZuOs704KRykXIgggPZdVhY+dpu9fubRnYNPjauLsAb6JMtF6
 HTYdV/yXCUw+2GvhAhMKITD1oTWiYJBg5ZGlCDNCqBB2nPHAfEl9NAC9DwU8YtIkjuRD Ow== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vjx0agqx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 06:00:25 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C5A8D130D8;
	Fri, 12 Jan 2024 06:00:23 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 Jan 2024 17:59:46 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 11 Jan 2024 17:59:46 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 Jan 2024 17:59:46 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZOFyoK+uiarbJCFosUhJvGMCBjIu/uSkt14z+iDL/A1o8UcPO9caPz5k1n949yc0Cq9r/TtQf5UjqpmD47KPuxI8RSXUhk5JzJO/LNfMHnYd6hnTYnV+gVkRk33UuVh9zUX3iHeiYsjrju0qGH4lLTrpox1kzQoZt13xSkDO9wY74h6VKW0p6D2q7v69QqCPPPT18IaYhjrD5ptKDxzkqTwX0IXTgv4qR9mLO69ledCC9pH8oYJedW2GPfJHnBfNvL2enpSxuUHUmuuEbWQtmYsXKR9BlXKPFWoy+TlWclsHdeC0Azhek2mTuybqRPxbnnerGfmELGCb5gtL/FAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLPPGGgZP0vMte6r1GqUyqkzxxFEQ88chqsE0l85Uj0=;
 b=kVk6CCvPw5b2vQw8rlTrkSso9LnZP/7g4OyLxrb2j9++eI1zfc0vBVK4SOvMHyO5fbjVNOFKekc8C56/uAqQMGuzG/2r5lnOixwj+S9he99+xtc2t47jNULqwF+XlfabTbOc2Tt+9SbM1nSENPkkp5rfPQoB75drjBMaENI5gnPxdr2xWZUDNfvUzrDxbT4/0OiA7VEZ6jvRu/ZlOndGmudmGjFCEM2+ZXeQG8wMQHiRfH9HZEN/Ap+fSup8VuV9QdW48+3mDgxhBqd87g7j54VDh87+RMb8hETRhMUZc9Kmq3YkyQlTOs1KMukiedQfoIcGgxAlNQjeooXdf+6H/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Fri, 12 Jan
 2024 05:59:45 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::34e9:23ae:983e:504e]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::34e9:23ae:983e:504e%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 05:59:45 +0000
Message-ID: <a8ad036a-7d65-4dbe-8c87-f569e54d7a57@hpe.com>
Date: Fri, 12 Jan 2024 13:59:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: include header for EINVAL definition
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
References: <20240107132842.4024084-1-clayc@hpe.com>
 <CY9E6M2BYETA.1VE73N3UHD4B9@suppilovahvero>
 <a77797fd-cbe4-42be-abd6-54cc815d360a@hpe.com>
 <CYBAG2X330P5.2SIIYCQ1GN44G@suppilovahvero>
From: Clay Chang <clayc@hpe.com>
In-Reply-To: <CYBAG2X330P5.2SIIYCQ1GN44G@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:5:74::45) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|MW5PR84MB1572:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c423cc-5645-4a7a-87c8-08dc1333ad2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdN+tC+/OMUA7KOvodDUExAci870cvNHuoScfNcL6bApzYjBK/F6ealzN1X5kXdNcpzID70Lj9Lfbz3cmv0GPaLvuIbLPlas900TnijRKw3dIWncu7Jnr+SBUuVR+hdLRd3eInILZfamFS7Giai/scZ/qNJ3o/N0M6F/e05jvDOUi8jzUBWr5Y3t2monhbA7ls2G0yhehvJo0cTL3KRgrhTlyuCxgqMh/GuHRIeqFy3t5jxbQOnicCjpAlAXEJMYg7PcvAc/JCRiry0KSlFkpf1Wvc4lfLFRRemBbVu0dVlnbpw08LV5N7N9WlL49hC7FoPRTh0PY9aGW58UGkF8kDh0ZG2vLn6VjhUx9WAvaooyZy0Qb5+RCFxC79rLU/kZ3etR2x0bXTdMfklcCqY9kDejmYo7GHb49gwGzuPO4TXLjxpzteE4+CO3/LeD2m5yz2tTOdUxBEocljSlUOflBxaGMtN9rLcLH7HIY5RIbwumrAmWsh6BN2TAG4ATtnTo6RDKfGOItBEFcjXh04PAjNmUa2XA4b/UCmh8Y5dGhm7/dm5yHPcD4wBHjzAfv7SoLqjdHojwOEP+gNSbNJVH+VBDdDv6n/bPgkpgBZACu9wkhc2XKLO81hDK+NLDDHVB9ftf3ASss/km3N8kf8tKfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(26005)(82960400001)(66946007)(41300700001)(86362001)(36756003)(31696002)(6506007)(38100700002)(316002)(2616005)(53546011)(6512007)(8676002)(6666004)(2906002)(6486002)(66556008)(66476007)(478600001)(8936002)(5660300002)(4744005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWd4eVM3dU5qY1BRNlZlZmFObENGNkJGZWlYOGNmUTRCOXd0NUdmYk5ycUVP?=
 =?utf-8?B?OFlHeU5VbU9PMnArbDRjTFJJb0lzQnhFVkpIOThmdUt3SnNiWFZ2OTVJNUho?=
 =?utf-8?B?ZXl0OUs1TjJTcTAzTW94Uy9vQlpocU5NUW9ndlVhWFBHMVRTcmFNNnI0bWJ2?=
 =?utf-8?B?d3F6SkN6K01PdHRzY3k5SmVZSTZsTHA5bXlrWWJQTkNSbWtzWmg4cVJrU3ll?=
 =?utf-8?B?ZWJ5VURWN3VtRUdDMnhFdkhEczBBRGZXSStkcnByVHlQWENYS0pxWHhvR3NK?=
 =?utf-8?B?dFNMRnhZQzNZbGxaOU1DREVmRkFBdXJMRUlHR3J5ZG52MWxQcWJTQjRGbUVO?=
 =?utf-8?B?dTNHRHBuZk1STE9GaFEvc0JYZkpYZWdLL25UMElHQWo1QzFORDA2TzJrZ0I4?=
 =?utf-8?B?TEpzaTg4OHNRM2pTL1lNak1QTFFEVXNwUysrWEZIN2NNVE9vSE5ROFRJQkRB?=
 =?utf-8?B?WDVobkdkSmorT09MMkhaWDV5Q0pSbldKSVhGYVhRTTVKTjJDamFLam5ZMVlo?=
 =?utf-8?B?eFdjNHplTVZCeVFLQVByMzlIWEthZnU3TFpLdmoyL3dGazRnVUdpRTZrM1No?=
 =?utf-8?B?MXJjUS9za0ZDbXdKeDhIelQ2MGxXUXNwVnozY2l6TEVoSG51VzZwRjdjNFJk?=
 =?utf-8?B?cnllaElkRUo3WjVuaDNreDlDUWRvNzRpOStDdE5jRUhSdEVyU3BTd01wWWxR?=
 =?utf-8?B?RlRiY3hUNUcvV0NVb2l0ZndKNWlsWGZxaDRJMC84VWYwWDhvc1hGVnpKNjBm?=
 =?utf-8?B?cHRiR2xFNlU3eDJNUDVheW9reHZvTjlHY2VUbXhPUUZRdFhmK05yRXdhR0Jt?=
 =?utf-8?B?NTNvQlMvbTl4eDZpcVZsSktMYmg2SEYrSW1ydTQ1S1dxSHFzVWExUXRENG5F?=
 =?utf-8?B?bGhSc1BadW5BelhyencrcWFBZ2Z4RlhXQWsrMlVoc1J3Q3NGZWQ1OWdCSXBE?=
 =?utf-8?B?QW9IRW5TOUl6OUd2VlpzNE93ZldJQ0pWMkVaWURnQ2ZmK0p6MUo2RWV4VkNU?=
 =?utf-8?B?WnNURVdjbzFDL0pwMEVVLzQxVGdJWXNNT3hIYlpHNzBvczBiTm1sYzdEeklX?=
 =?utf-8?B?TWhmaDlIbko4UkVkOTQxNE9NWkhyRkcvZThCbWw0anlJaWszeUFvNS9iUGVB?=
 =?utf-8?B?RnpZZW5WdENwRW9IOElQTVc3QmRlWDhkTmpSS2FvTEdPbnRHL3AwdDc2azJx?=
 =?utf-8?B?aCtWSENXSnAvUUpMdTlWeEV1V1VqV1ZRdXIyTkFMSVRuY0krLzkyaGxoVFZF?=
 =?utf-8?B?L0s5elJLSGFQTTI1M0VZTWJSL3dJTEN1ZVRHVDkydlZrRHBEdUVOQ3FROUFs?=
 =?utf-8?B?aktqUEZxUW8xVUdmVUdYVGd0Q1Y0WTd4Z2FGMi9yN0d4bXVhTkFLS0trbFc4?=
 =?utf-8?B?WHIzR2I3dWFaN1hNbTlrYTJwbGdTQXZvWXRYSDhrQkh0UGZPZTV2ZVg2akRw?=
 =?utf-8?B?VUc1elBLQXc4QndxbERqQ3ZMaGR2YkhCMmRLcW9lUDRyeGZnVWRIc3pya1lv?=
 =?utf-8?B?cG00YlNjY2FRZ0VkMGYrZWJqbnNCZVRsMk1RWmtoTUdjWkFmT0VXS2srT0hz?=
 =?utf-8?B?WkdEM2RKRzE2UEVzak1WSlcxbzhicDBnY0drRllMR2w2ZjB0dHRMZi8yTGdX?=
 =?utf-8?B?amtLWE9ES1RSeGUyWEZEVnNBSTNUWU9YeXlIRWwzMTEvTHd0Tk01d0JQc3p1?=
 =?utf-8?B?bjdIMThabzU5Tzhjemp1ZHo0ZEVMWEFBbmY2VWo3S0FEZmhvRDNwNDZ0NTFt?=
 =?utf-8?B?TkN1SXpCdFdyMHJUOTdhZXllcndrMlp4ZEFrYmFEeWVHYXJoYTVmRFI0L3BI?=
 =?utf-8?B?TS92TUovQytaRkxtMkxGYXBzbkJ1WFVGWEQwWDVlb1psU1RMbEVnTjVGQW1E?=
 =?utf-8?B?TVJBSGlJdFZ0Q2tZQndxWlRoZHVoMFJQR1FUOFBQYjJmbHlZU1NYYStDNjFm?=
 =?utf-8?B?T3l6OHh0YU94Yi9qbG0xQmxCQW1aSEgzZ1hmVHZUKzQ3NjFJdUd4YnZEZHVW?=
 =?utf-8?B?SVlqZWMwWmJzVmJlVUJ0c2NSWVNMdnFwUzZqUC85RHJlcng2aFk4N09iOTdM?=
 =?utf-8?B?ek8ySnRMdkJySHM3UmgzTWk0Z3dtZUFndUc3dWVpTDlBTGVqNFlFdDR3T2FE?=
 =?utf-8?Q?Ij8CjdEsvN1tX6wNYzRVFp0aB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c423cc-5645-4a7a-87c8-08dc1333ad2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 05:59:45.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EuHLd+XicB7mwCM9FYYBmHTIQhdN8P9zWQ5UBeQpk3w6lNenrIOhTb+MHmd+GQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1572
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: id0q-i_UoAg96gx9SqjsSKSp0b-pYCni
X-Proofpoint-ORIG-GUID: id0q-i_UoAg96gx9SqjsSKSp0b-pYCni
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_02,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=509 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120043

Hi Jarkko,

Yes, I have. I am working on an OpenBMC project and the kernel .config was generated by merging several config fragments. In one experiment where the CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not presented, I got a EINVAL undeclared compilation error.

Do you want me to show the full .config here?

Thanks,
Clay

On 2024/1/11 3:54 AM, Jarkko Sakkinen wrote:
> On Tue Jan 9, 2024 at 4:10 AM EET, Clay Chang wrote:
>> Hi Jarkko,
>>
>> The issue was found when crypto/public_key.h was included, but
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled. If
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled, the
>> public_key_verify_signature simply returned -EINVAL, which was not
>> declared without linux/errno.h being included.
>>
>> Thanks,
>> Clay
> 
> Do you have .config to verify this?
> 
> BR, Jarkko

