Return-Path: <linux-kernel+bounces-64228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7272853C52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D502898F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37164612EC;
	Tue, 13 Feb 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xreowZjO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8B612D2;
	Tue, 13 Feb 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856683; cv=fail; b=Xf+EAtVtBK7BVnigFKDKtiBz4VEgt+A5rIDUYkERjXeD4a9c9guoUe2GCqoSJuhI9sOc3QeCWLtNe/XIT2onhcXlavPn64gpz2BBqqGWufvg2OpBrk/IaRXfN0j5NyKcxmwTdD+FY/dciyRmJOSyIQ1Ui1cuk1ecDhaGxOlWmVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856683; c=relaxed/simple;
	bh=U34l1ZBP5Z/MMwJbJG6KaKbgAFL/GjQLdUtMX7YgsjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QsUQ7vbiEdz0BSt2t/+loz+xMKHiITx1kX9hinAlFZRZOJ/l4K/b6b141rIIhaq4aGiEH/mu0umqOQ5qqo6CC/DXpWAMt0orNxZM88TL0wFRU84hA+/cCK5cn34gkOKABNxIs7QwS5vFRaFtDAdlRaM8UJp2BHHMvDZpJFHSRiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xreowZjO; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVwbk+dkoRD6l7k8ZmN7LsxzWs2qUcmxuey7sYDVmAPhCLQfMn02iTjKNityUiy8QW6DhlCB010ZUVSP4204/azty3IdaZftngfNZhm+7JSVAYSjYo9y9yAgUZhbpzzy1KNBvIisvyaPA9oHRct1ctwGy98x1iIr9U2S/QFnzae7jCPmHRNaWUTdz0rnrAaO4tOJkOFhLjLA4GCc5DkTBpx+UfhHkldnQvoHn0FpC0Od23ClNNjvRp4ZMCGPYCKN1UCXjClmKHNWu+0OOZbWTkMLY30MNJNG7y7f05n5TZF4v+GNxYEtSiSqou6Zo1mMAxH+FzU+0qzAMJQIaPmNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfYvuNqzRxf4ki/BdGABCrnSCOU+YnzakCVEpv56FaI=;
 b=d2GIWcYT76BsSH9vk+sTkG5LeOKFy6VNMjWE2ajIhsSPS6AY3urYAADh+LcX4sYFZUkUjCWHxP4RO/AsCKbRE6f/5DIsOQ6Kih7SJZIlWUzykC28HtxCPgpPUM3aNw/AkJOhcl5UcLqKoIosWzdhQYFTWqNFsAUxPtutHEIpwXa+YOyAts5p/GVxM4K75I8exjrlbcJIxx3qjbHLm5KCYahmGOkpPjubII369v1bcB4UimtLYn163q6AvD2LLVdRrp30JUT4o4C80SWbF31+0iZWM1eHJw5Y5ArIHBXNeuxnA3ud7pjc5j5B6rBUqN3vh0Z1LlVUhvEqnkR+UzwQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfYvuNqzRxf4ki/BdGABCrnSCOU+YnzakCVEpv56FaI=;
 b=xreowZjOxuWkqCZ3F/4jCB8tUlq+tz+HcuGk+2q+4wNLD4vVtVwbvJZMTQuVos2Nce2Ay22Fey2Gm72jIDbkQzXyAUy1YUx0fSvQ06FRnIsPSKrIEEzflIAYpg9wFllt2p2t8vV1D4FK95U5yqo8rBUH32WgPk85MrkMJjJlyRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 13 Feb
 2024 20:37:52 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 20:37:52 +0000
Message-ID: <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>
Date: Tue, 13 Feb 2024 14:37:49 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: andersson@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-remoteproc@vger.kernel.org,
 michal.simek@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 ben.levinsky@amd.com, linux-kernel@vger.kernel.org,
 mathieu.poirier@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-3-tanmay.shah@amd.com>
 <170785205177.2155555.1311787541370066483.robh@kernel.org>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <170785205177.2155555.1311787541370066483.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0139.namprd02.prod.outlook.com
 (2603:10b6:5:332::6) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 834f90c7-7213-451d-9f7e-08dc2cd3a641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ESfaontTFqnQWGCsLUsdu5l2fem2r6HOoiPkG5f5HTjILlX4SBQxWioUxW5Ng8/grVTHZbzcKRgaWgPGh8q8yABS1JZx79jdk1iyfT1MJdFYOnhM76towURwhIrCV+9KzCoB3ADQnw0ojFhaXbHoJWCHR1ryDvXgondDAV76vmCwLjOMsrIEsYk2JrakX6D/I1iczr6HTQEuA1/wGyVsPyi2QGtYCOCkPhvaQ6+A2DMwhWzIObwPJvDjq6rO/GNdjkHHe17KFa3wwlfn63qmMVndH28Ihx8/DVKIPfQEijYl5yU27FjZ61VZGYAyDTWUWE5eJ42wHJ0mBj+LyxL+//E7FzCkVBZRTv6URJLDl7mTKzy/c/4Nfp14EgH9E2Qw7D2WbLBCcGylh5FSJZ1ZtaPNm6CIwmz6C5TskgX1Knx+2nN3mwZbgHnauYlYv7KPnVTE4SavDnMH53RUUxaqqDu18iHaxUvfGK1gVmDCinpqHINTvG5C3414I5qMwVaXiY7GS8dJKD/VP53EI09GH5X66lJvTq3wOlk4as9o6Z0/PlCH7BD9Q+x5NdTp7Zcb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(2906002)(8936002)(8676002)(4326008)(5660300002)(44832011)(7416002)(2616005)(36756003)(31696002)(26005)(83380400001)(38100700002)(53546011)(86362001)(316002)(66556008)(66476007)(66946007)(6916009)(6506007)(6666004)(966005)(6486002)(478600001)(31686004)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmJJaVVMcC90MTlsbU1wcFdobjEwMWNnazhuT2MxUFo0enJRSVpEVTUrZSt5?=
 =?utf-8?B?amhacmpLT2hQSVNmM0ZqWW5IT1lvY0hQU256MkFZY3NjWFNnVnFoT3JER3ZC?=
 =?utf-8?B?UFNlVnRzNm5uMDg1M2tjdHlHcFYxMlg3NTkvQ1QrZ2d5aUVuOWxpRzN1K29j?=
 =?utf-8?B?S2pzbU9LTFlKeGJEOWxkMTBubFBTdVBZWmRYbmF2NzY1VzZVWStqS2FCcS9K?=
 =?utf-8?B?bWhaTEpYUzJVZ1NRNUZ1bUE1WWphaGFWZm0xSVlSanRKRlk0Z200RndiR1gz?=
 =?utf-8?B?elFzN1IwNElUcldSZVlyZmJSa0ozSTM5V1RzOFVsZ1hpYUlWQ2llYlNCa1Yz?=
 =?utf-8?B?WlNiT09pN0ZpUkRxQmtVUld1dm03UzZGckxTZEFVcndnNjRDVWVRbitvQkxY?=
 =?utf-8?B?NEcvT3owcHRSMk5YeEwrMDh1WnZCREwrNTkrRmszVHBCMUFlWUFsQjUzRVJy?=
 =?utf-8?B?MGR0TlhMdHNpa2I5MU5DaWdsdEhybTRaUnVuYjBxWVJ3aVF2ZmptMDBKNnFt?=
 =?utf-8?B?Sk9YVGk3RExxeHFEd0MydzdPNHMxeVpERzRLTHF2eFRIdzJ4TXZocGdRUlhX?=
 =?utf-8?B?dUpFVFFrSFNXQThYVkpSY284VVJDOVcvbDFyQzdGRCtzOE5WdEpjYmw5clhX?=
 =?utf-8?B?Ym9PWGhXUFR0R1VXVzUvbEszU2s5cDRPK0hEOGNQQW5ZVVM2Z1ZGRExCbGxS?=
 =?utf-8?B?cU8zdWJ2ZmRiMnhmalVsMVN0SUZRVDBKUmpxbWFNV1JNaGM3cGZIWnloeC8v?=
 =?utf-8?B?VG1HWURBRC84Si9EN1IvUmlKMy9OeE56VlpIZXRrbTNTMktwOU1BcHFJNTcx?=
 =?utf-8?B?S2ZPMXNmdlRWN0VjYjV2ZUJNTGZCUm15c2dSRU94cTk5OFptbUpld1JLeUdm?=
 =?utf-8?B?aWpwK3lSamsvVnF1bDQ3eW1FeDlLa2lBdDRPd3hJajV1MVZVS0E5QWpJUTE4?=
 =?utf-8?B?RnhrMksyRE96SFNITjR1Y2hiNWZINmxIdEJRQXVvNjBkdkg4bmFMRyttSHYw?=
 =?utf-8?B?QnhvM29pWnJiSkxvK2NMU2tmWldUUllUN2I2YnNSSitDT1RkVzhuWlBqQnJm?=
 =?utf-8?B?WEpsZmR0L291NzdGMk1QdUdnT21Cb2NiQlhvT1VlQ0NkYzhSdVlMdkZvcjRq?=
 =?utf-8?B?d2hLVllKRU9McUlnN1V2WSthN2VZU0c4YitwQU0zOHlDWGwwWUsrZDNhL2or?=
 =?utf-8?B?V3UzaHNSVi9jNWVrRWxlREN2TTVJMTg1VUlTMk9mVUIwOFVuUXIycTFyNEFQ?=
 =?utf-8?B?RTRUVElQVTRXYjR0TFVuWi9OWng5SUhaWmxXQkl3ZUc4ZDZVY1U1VWJBdWt2?=
 =?utf-8?B?S0MzcVRMRFNxMi9HdlNVbk5odnUzSThxTXoxc0h3ZFkzcTdIblBrZ3h6bDFi?=
 =?utf-8?B?K1Y0eUNQRmVPS21Temk0akNuVGx4R0NQSnVXbVdDdXhkeldVRWxDOTNpdUJB?=
 =?utf-8?B?UTBHRE5janR0RThaL0treEIybXZUZGxGQlg0QnpGdkNNcU9odW1ya3dLUUh5?=
 =?utf-8?B?cmt0WlBYdVF0K0lmeCtPSTJWVGFnUEczQWFJNUVmNmNRdzVSZmozMjlnUmd1?=
 =?utf-8?B?QXRXY29waDlMU3BiVWs4YnhBWStnbnAvajgyS1ZhU1FEOStUYmRFcDlZZUJs?=
 =?utf-8?B?bG1ESTZONXIzVisvMDVOcHRYOVMrOHV1enZRVVBOL0V3a3NRY3ljUW1GUjYz?=
 =?utf-8?B?aXlWYXAwZnlxMHl0VVlldWxma1dOR2dBejJlcE53aXBsbkxJSG1mNjE2SVM5?=
 =?utf-8?B?Q3hFaWVkYXpLRzhrL1YzemFDa3lDSXNsNUUxNmJDend2OFkvVlN2TjVETGR0?=
 =?utf-8?B?RERmMG1KbFlqeFBqYm9HMTB5bjh2dXRFYWg5djBUUDNKT3dVOUZNSTFxS25I?=
 =?utf-8?B?SnRYalZkRHFpUHRFTVlHVWNDUWN0RkZ3OS9PYnhSUy9VRGd4czFiTVB2VmU4?=
 =?utf-8?B?ckJWN3BVUk5LU0RhczU2K1JMQ0xJVm1ucmx6MVRVL1lvekFIODltbXZOQ2Jk?=
 =?utf-8?B?cGhiQktIeTkwRnB3NG1LekI4WHVuY3JBL1JmNnQ1S2M4N25pbjhWc0ZiR0E5?=
 =?utf-8?B?b1BmdnBFMmo3czFkYkhObVVwNXh6alBMR3pwbWRzbWRYMEJxUUVEaW9DVVRT?=
 =?utf-8?Q?FxOWKgMcFYCKxeSBinIps97Js?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834f90c7-7213-451d-9f7e-08dc2cd3a641
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:37:52.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw9A0DFLUg+SZdzF77Bzk8U3X6lxOO7AyfSSdDzCE8AZJAh3IahQtPSipwdV2XfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

Hello,

Thanks for reviews please find my comments below.

On 2/13/24 1:20 PM, Rob Herring wrote:
> On Tue, 13 Feb 2024 09:54:48 -0800, Tanmay Shah wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > 
> > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > UltraScale+ platform. It will help in defining TCM in device-tree
> > and make it's access platform agnostic and data-driven.
> > 
> > Tightly-coupled memories(TCMs) are low-latency memory that provides
> > predictable instruction execution and predictable data load/store
> > timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> > banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> > 
> > The TCM resources(reg, reg-names and power-domain) are documented for
> > each TCM in the R5 node. The reg and reg-names are made as required
> > properties as we don't want to hardcode TCM addresses for future
> > platforms and for zu+ legacy implementation will ensure that the
> > old dts w/o reg/reg-names works and stable ABI is maintained.
> > 
> > It also extends the examples for TCM split and lockstep modes.
> > 
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v10:
> >   - modify number of "reg", "reg-names" and "power-domains" entries
> >     based on cluster mode
> >   - Add extra optional atcm and btcm in "reg" property for lockstep mode
> >   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
> >   - Drop previous Ack as bindings has new change
> > 
> > Changes in v9:
> >   - None
> > Changes in v8:
> >   - None
> > Changes in v7:
> >   - None
> > Changes in v6:
> >   - None
> > Changes in v5:
> >   - None
> > 
> > Changes in v4:
> >   - Use address-cells and size-cells value 2
> >   - Modify ranges property as per new value of address-cells
> >     and size-cells
> >   - Modify child node "reg" property accordingly
> >   - Remove previous ack for further review
> > 
> > v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/
> > 
> >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
> >  1 file changed, 170 insertions(+), 22 deletions(-)
> > 
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml:118:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
Ack. I will fix this.

However, can I still get reviews on patch itself so if something else needs to be fixed I can fix in next revision as well.

Also, I tried to run yamllint with following command:

make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml O=../build/zynqmp/linux-next/


However, I see following logs without any error on bindings:

  LINT    Documentation/devicetree/bindings
invalid config: unknown option "required" for rule "quoted-strings"
*xargs: /usr/bin/yamllint: exited with status 255; aborting*
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.example.dts
  DTC_CHK Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.example.dtb

I am not sure if my system is missing something but, yamllint tool is failing.

I appreciate if someone can point to quick fix if this is known issue and is already resolved.

Thanks,

Tanmay

> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240213175450.3097308-3-tanmay.shah@amd.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

