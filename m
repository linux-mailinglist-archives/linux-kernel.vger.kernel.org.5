Return-Path: <linux-kernel+bounces-146231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5298A627A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E2F2824C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15C37152;
	Tue, 16 Apr 2024 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="t3Lrh75t"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2121.outbound.protection.outlook.com [40.107.236.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2712E4A;
	Tue, 16 Apr 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242353; cv=fail; b=rW7xI6vskn4dZlDGFmmg9Dk9+LRCf7LAmBO5OtUtELyP46HNu2GdqPL+BQyKM66bEV1nTMe7cCWBNa5stUDsA3CS62nayeTRjKhcg/aARFK1JxfrW+wClKboYl9L3ti3OmUfciBGeYJ+zXNWILSuF9s57xQUWzyA0Ti4RXTjWog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242353; c=relaxed/simple;
	bh=fXArbvZl3ymYODyLpBqNAOk943FAWL0hnpf/wat55oY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GrGs/87M/J0oh3KO+/SM3Yk6Qc6gDt8MeA3rsSL/w7u79afA/VUmIE7SwnEqerVJ8bUxKB1hAAmNTC8SSlk06ctzAiZY/QwbGELNsc3Tkq1hYOWbV0pie2YivzUPFAfGREL+NOAiwqLN4lV2vzCgOu/OrnxnszbDFOfMG0ofgNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=t3Lrh75t reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDMfBNcwMbXHaehsm9XS3hcCxIUOoEoHkvhLTQkh42OyWtypLrPdn8P+fig5wFuuZmy6/IzWEBSCdFO2d7mLL5Saixev+ElrpaIdHdqhWW1a4yX2NxGyTaWC2EWwbiEyRw/0wedzwabBj8gTNQw6RpDPGzN5snFNenbRzZpHYicXBPeA8k6hfs/UhNMfvq3u8Ytb9bJdJvwIw/eRuXHa9wq9g7YtcfjFmn64YNRadP0O0M0sVMZMl45KPJWNKMvhfB8+X8eORrqDKrXHDTwC5ZLArPqROZ3Ow09CisJ5bT1eZ6elEVC9cjxi4ZH9s/bSjx2GT6/NcOjxaugs1VCkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax5DanL14r/GomlVtrD4nbwtVqEQc0x+zpwIHeLB6k8=;
 b=hSxM0j0wot7RRClgaLTdoMKhDH6pmJY85HrLykaYS3QIw6nP46bqiHHWlGS4fY2igLp1j+UupvsCaq3ms3yv8E+56k/aAO6dzno2FAuPWj5keixRCDeV6uEHM7A62hgYEpVBwjbRrqXZeRB7J3/UFdOujC8zL2aeZoRAt3uOll10Uma3muRqchPzpzbh8BeOaY61ZAfqSO9zwnDhX8k4XX25V6UQohLwmfbVpTjxnCYxew+xEuuuREkodAUYT+THGDmIiiDA8gsGjkjOhAHufTVhed/u5xFFDBZPbHUKlXqAn80cF5B+k4ub2KMOnRRLYyE9VI5xt0kEE1bQ4Da83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax5DanL14r/GomlVtrD4nbwtVqEQc0x+zpwIHeLB6k8=;
 b=t3Lrh75t3DpDryTK85PK1136ubJcd3WwaiOHrSI8b+5q3/iQU1RB6ejctvdigv2XRlOx9C913j9IOTZtV+kAmlaxRg4FB2uJeLFv4FXDdwq3s8BrkH0D5tT7Njr4GzcGVwGoLYPKDzNoDsntgB/O4GntPSLtkmWuk0y7+LwnQPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 MW4PR01MB6435.prod.exchangelabs.com (2603:10b6:303:76::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 04:39:05 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 04:39:04 +0000
Message-ID: <15faebc0-9b20-4d0f-a946-c047bc6ae564@amperemail.onmicrosoft.com>
Date: Tue, 16 Apr 2024 11:38:53 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Add maxim max31790 bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-2-chanh@os.amperecomputing.com>
 <80effcab-74b8-4e15-a4db-9982b000b6b1@linaro.org>
Content-Language: en-US
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <80effcab-74b8-4e15-a4db-9982b000b6b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:930:10::35) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|MW4PR01MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5503807a-474d-49cb-1d23-08dc5dcf251d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnA1dnh6cFMrY2QyKzIwc1NkOTNwV1VHR2xyamtyY1ZHdW5HRi9Za0dDalo4?=
 =?utf-8?B?VXZQOUx3L1VCVnRiVGhBSG5KWlQxZ1RQREZRcFBtekJtWEdLVStwOEk1YlJ6?=
 =?utf-8?B?YXAwSmsxTzNucVZXZGlzbzlOMlFoT1lwWHVkTmJ2S1pQczcrclBwT0RvZ256?=
 =?utf-8?B?K3I0WGpqeFBJS3U3S0lUS3FmYXQzK1NTYjhHTWdnK3p5S3liT2hkM3BJeDB4?=
 =?utf-8?B?VHdRalBIck4xc05maFJsbnJFZzZuY3VXVXBDV1VXUHVwcm5tSS9lNEp3alVZ?=
 =?utf-8?B?UVNpWGg0VU5MNkhJWnV3ZmRYMjNTNUN5WjFwUzV3aDcvRW8wYnFBSzdlcTVP?=
 =?utf-8?B?WWxQZW1INmxQaFpZVzVSYVl4V3hlOFgxbnRGcUN6OFprSGVKVHF5aXpFUm1S?=
 =?utf-8?B?UXMyZnRuVTYyZnp3OTc4TmlRM25peXpyTlJBWlpBUzVLSnBKZTcyN2FpVysv?=
 =?utf-8?B?MmVrY2pGZ0JHTUt5T21vWEwxZWJPL3FzZStBcjFYT0NUeXVET1FZUGtCc2RO?=
 =?utf-8?B?K0N2cDNSZkR1VnZTaHQzNWRWTy8yZVZnclI1U1Rhd0NwaFZpeTg4RWpBZXMw?=
 =?utf-8?B?YWZTdGhkSGlLMjFtUFlJZjMzNU9BNmdWbnpvMkliSGdJSjdJVjhmZHh3MENW?=
 =?utf-8?B?d0YxWkNqUWllRWlBbTFCOVR1WVArMWF0cFlFQ3pDR3E4RDFKd3ZMMGZqU09S?=
 =?utf-8?B?SnR6NlBTZTdWMm9RUDkyeXpoTUFBSk9PMWlHWTl4Rjh6REpmNkpISlFHeWN2?=
 =?utf-8?B?ZGJYcTRoRnFselFxcGwrdnQvZnNQMUtRczhaSkNyUWVFNEU5bFdWMFEwcVZ4?=
 =?utf-8?B?MHdydnJ1dXdmWnlNb0gwVzJpcldKYmFlckFjUkcxeTdBSlpnQ3FZb2VqMDJU?=
 =?utf-8?B?NGVJYUFnNVQ0SDBxaUI3aXYxcEVNRlBKU2k5eDNtR0RwNE1VRzd6LzRZK0ln?=
 =?utf-8?B?SHFlM0ZhY2ZZZk5CNkUxNHYvQkZ5U2V6THFqclFFZjh0VytPV2k0aW54aGRO?=
 =?utf-8?B?b1ZJOG5kSjVveGltSVA3Y3BpWmloeHpPUnVpMVJtRlZCWEtBSExsMUN4a3Jt?=
 =?utf-8?B?em9vck5ZdW5SOVJ4UGdPdXN0TVZ5TjhhVmVzR0VCd0xHN05JRUFOSFFxb2ZH?=
 =?utf-8?B?WnNSZS85clhlUGUvelZhZmxHejUzSjBwcHFpWXIxdjFnUjMwRllKSzdWQWFl?=
 =?utf-8?B?aGRyL3hyRVlDQ2FnMnpHYzVvTERsdDhTQkdXMW0vMHE5Umh1RXo3dWNLRTds?=
 =?utf-8?B?VUQ3d2hKbERFVncxQWdnSjNQUmgzUEkwN3h6VW5RVlFVdWpUZmRheWhicmtH?=
 =?utf-8?B?em5kZ1hrMllpbGNzQkFQbU13Rjl4ZzBxdWYvTkQyS2F5dGJ6dEo2ekNuclds?=
 =?utf-8?B?QjV4amdoN08weVBtQlNMNkF3bDJoSzdzREhHUk8wa3B3V1UwZG9wLy9qSWRl?=
 =?utf-8?B?RFdJUnVJSUthZW5JNUZEQk1sSGRZZzRmQ1dHSk1KQXB2bUVjNFh3dmdyRHE4?=
 =?utf-8?B?UHFKUGN1TVFneXAyVVhWdUlHcUdmanhmUGRuQmRwL2JPblRucWE5OW1MeDNR?=
 =?utf-8?B?ZXh3dHE5VktrdW96K0FYNnpqbUtIWlVqbGN2alB5QnpRbjZvckZvSFU0dzRB?=
 =?utf-8?B?NHIydE03VGhSMFJLcnRXbGdOeUh1dU1HQ2hhQktxanhWVVVJVVZKVjNWYWJQ?=
 =?utf-8?B?WGprTHRFTVlLWVdlK0VKS1JLTDZrUk5SdjhQR0lsZ2FDc0IvRUdXQjdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2NraGJSaTBlY2VRYm5ydzB4aENFVUplUG0rbW5qa296K2VtYkozSWpwNkZa?=
 =?utf-8?B?Y1VrNmlSaW5LeEpWWG5yVnJkdVF3dU9iZXlEZGlGK2ZHSXZJNjZ2K1pnaHJw?=
 =?utf-8?B?UWlMVW45UHNoV25hb29oRGlveEJYMGhCK0M1WXNlczkxTFNwQUsrUnRNWS8z?=
 =?utf-8?B?VGVpVTM5UlVTczU1aUo5ZzRDanYxV1VlYS9yUXpGa08xaUZDdCtrRmRCSW5I?=
 =?utf-8?B?TUcvNjN5MGVCUFM4YkM4bG1MdTJCVklCdTlGby9idksxVDhITU9Ob1FzSUY5?=
 =?utf-8?B?ZkxFZkl5UEl3TkxNbFVVQ3QwVXVjSVFHTFdxdUpXQU1jZnFkbEpPTTNSWVlN?=
 =?utf-8?B?Y3hvcURES3RnVnpCY2FlM0p4bldPWHByU1hwMnd1RnNqL1RER0RmQ3J1dFp6?=
 =?utf-8?B?Q3ZhbWk0aEpWUXh2U0lPSWM2TER2U1VLM2RuYUx2Um03NEEzVUtlN3FIcld6?=
 =?utf-8?B?aUxvRkJuS1ZKZWZnOERlUk5PZCtjdStnaGVyNjU5Qkl6ekRhRXZOK0w2dkhz?=
 =?utf-8?B?VDRHTkY2bmhrRVprL1p6RGhNamhuQzNTV0Z2VGVVSWozeXdOYzdqemNKQVRx?=
 =?utf-8?B?QlpwZzM0M3NtZmhOYnlkSmtCd0IxWSthL05BRnd2LzJLQklFNml3eHdYajR6?=
 =?utf-8?B?M2M3SE5iS0Q0L3JNaEczSENUUnhGNnFRN3NXS2puajVMSkt6NHlLY0ZxeHda?=
 =?utf-8?B?V3dxd1F4YzNmS21QV0ZBMG8zMUZLSFIveW5iZnZUajRkVVNaeE5pUWdNdGFn?=
 =?utf-8?B?WVZlMzVZV2Irbm5RaDhaN2lyblRlRlgwOEhEcFo0L1A0N3FtQksvaEpEU0dB?=
 =?utf-8?B?eGJtaVlsUFIrSHUrVlh2b2hheEkxZ25vam4xWlN3ait0VWVUYVE1Qkt1ZE9L?=
 =?utf-8?B?emlldjQ3a3FGeDUvZmNOMGNyNkd3Zk5LR01ib0ExS0d5V3prMThhSE5RK05G?=
 =?utf-8?B?NGdrMXoyNEltLyt6TnVOaEZwS1NFUWcyY1MvL1NETHIrRHRHQy8xRW5ya3lF?=
 =?utf-8?B?cEZoU21tUUxYVUl3clFNTnEvaUZ5NHJUZ05wRXhPNUZDSDZFTmg4R1g2Qmtv?=
 =?utf-8?B?V0JEbU5URkI5REV4Rlc1TGZCaTlkL2ExdVBka3FNN3diMWYvSDRLZTNpNTBH?=
 =?utf-8?B?RkYveVpnUFhkZjNSdGg0MmpOZlpGUVZDS2RXNC8zTkU3V01UUWVGU1RuMDd5?=
 =?utf-8?B?dnFWR3QxbHk0T2dKMVp5OS9BcE5kZkR4bnFhTGcwb21GUlo2MzVLcVEvZnpG?=
 =?utf-8?B?VU5rQzUwa3pZZEFZOTA5ekVCdzQ2N2h4WHJmREZBTlNjQlBzR2Vid25WOWcr?=
 =?utf-8?B?S0dmcTFSR1FHbnV4UmVmdDVtV3F5TVJVcU90S0VxZ2Zmd2xITjQ5R2Y4Rlhz?=
 =?utf-8?B?SVFoTGJpOXZZenc5Mi9zaWZTM3JmdVJ5eGVXVUQ2bnB2NzNhUEZWMWRVKzhC?=
 =?utf-8?B?ZVlZWlljT0tkcFhWSjgwUWt5SG1McllaMk83cTZ6ZXVUMDhXRG9WbXhqMlpn?=
 =?utf-8?B?bU5qM2hrOWg2R1FYbm9DYU1BT3JhcEl3dkFnMko4R2EwTDRhTk14QjArdy9V?=
 =?utf-8?B?TVplREpXcU1PODcrdmpuTTNBU2hTY0pTcEtnR2RiS2tqS0VKZXRybGY3ZWpi?=
 =?utf-8?B?QmdHdWFvU2tDV3ovbTBqMWJFTllPK25MRUFZTjI1Y0s1V2Jpam9wWXR1QndL?=
 =?utf-8?B?d3plQ2t4MjlwL2xKajZiYkIwNVZjLzdyV2F4R042cEV6V0d6REJLSnZjK01x?=
 =?utf-8?B?a3BuVmRjengxaUtwVTFUc3VYSkJHemdyR0lYMzVXWG9xSFo3bzIwdFpqSHkv?=
 =?utf-8?B?MFBWR1BEUG1Ja0Y5NUc2YnhNL2Q5ZmxxSjdKTjVlWVVESGw2YVMvN09VZHEr?=
 =?utf-8?B?Rmo3TWNqRGdJbUJGK2g4Y291aXpRNWdXZVltSHRHU0RMRS9XUVlDemgxNHRa?=
 =?utf-8?B?WTFtd3cyc0IwV1BYZmM0Z2xBS1dockdXd1RMQzdNQXZGNDhVR2FJc096RWY3?=
 =?utf-8?B?YnZoNFFFUWxWTDIvM2pnN3dhazdhRFlka2lIRmVrbGE2OXVRQ0poZDZvcVpp?=
 =?utf-8?B?d295Z1NUMHBDM1AwTzhPenJBVS8yd29DSE4vWFlGc2NSV2VjOWpJZ0IxN0J6?=
 =?utf-8?B?YnlaUXMvaFRXa1dPM1NGVTdnMHFSZ2IvOXhOWTJuZnBMUkUxNElNNVl0a3k5?=
 =?utf-8?Q?4TUvcXpB0f8oIptI1vakWuw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5503807a-474d-49cb-1d23-08dc5dcf251d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:39:04.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nyr2HFYBFo1t5hFZjAEoPF/QVj57c1u/LsW+SNry+kXa3tgKMWmfniz/LePE/c860sD15Wu8UFWn/t0a0lEAGMU8l/C+P6nopyrsRs8lB/b3coBigzta0rhQ/2XiWSYj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6435



On 14/04/2024 13:03, Krzysztof Kozlowski wrote:
> On 14/04/2024 06:22, Chanh Nguyen wrote:
>> Add a device tree bindings for max31790 device.
>>
> 
> Nothing improved in commit msg, where is the rationale of split of bindings?
> 

Yes Krzysztof, I will use "tach-ch" property from the fan-common.yaml to 
solve my case. So I will not need a split of bindings.

Finally, my patch series will only be two patches. They are 
"dt-bindings: hwmon: Add maxim max31790" and "hwmon: (max31790): Support 
config PWM output becomes TACH".

I'm going to update that in the patch v3 series.

> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 

Thank Krzysztof, I'll drop "bindings" in commit msg.

>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>> Changes in v2:
>>   - Update filename of the maxim,max31790.yaml                            [Krzysztof]
>>   - Add the common fan schema to $ref                                     [Krzysztof]
>>   - Update the node name to "fan-controller" in maxim,max31790.yaml       [Krzysztof]
>>   - Drop "driver" in commit title                                         [Krzysztof]
>> ---
>>   .../bindings/hwmon/maxim,max31790.yaml        | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>> new file mode 100644
>> index 000000000000..a561e5a3e9e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: The Maxim MAX31790 Fan Controller
>> +
>> +maintainers:
>> +  - Guenter Roeck <linux@roeck-us.net>
>> +
>> +description: >
>> +  The MAX31790 controls the speeds of up to six fans using six
>> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
>> +  are written through the I2C interface.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max31790
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: fan-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      fan-controller@20 {
>> +        compatible = "maxim,max31790";
>> +        reg = <0x20>;
> 
> Make the example complete - add all properties, like clocks, resets and
> any others which are applicable.
> 

Ok Krzysztof, I'll update that in the patch v3

> Best regards,
> Krzysztof
> 

