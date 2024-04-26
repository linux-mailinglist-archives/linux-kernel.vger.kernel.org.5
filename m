Return-Path: <linux-kernel+bounces-159586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A68B30A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9BB223B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077013A87C;
	Fri, 26 Apr 2024 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SvGoq/CZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61982F36;
	Fri, 26 Apr 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113598; cv=fail; b=kpfOYLWTFEuFbPhbu3SRH3y6Dn0Qr2HiTVwv3tBC4tUcPiqjwjllt9P+8EFZtHC/MjLZ3A2lHuigKTvdnfIm8OVex5DMBGZ4gI8EL5xim4N3TdFO/r9CVg1O0MkXCNqWnSwrFyY2o0b+GB7G3WGw+keIY+fsJV8IgokN2H9S11Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113598; c=relaxed/simple;
	bh=nFrxu4JpaSCA8aJJ3TTBduei/xHGgq0I94g/dJRrW3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuxl6ye8kCHuNIf0I9JxVdOHI3yyS0VOFiQijw/rL4CcE3NZCNjNKz5YEuF8lJKa0xDr0QzeRrhTZMe1RZ1XWjMHrBGT8Brr7naJodN+Ct1N/7+bAPZaqjs1gocA2BISq+LVQGnoIhKH/I98NJTj72KLW7qsaKovzuwFTmI5NdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SvGoq/CZ; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjlfmkYbcUx3KXD5QsKrJQXjykEEC/LpiT80mtsoDCqqNIjQjyaVYr6iHDT33st4VOrdWr2MjdNur3rc13nIzLrxtL/qlIJ5rY+Ceuglit2/5nptPI7j3Pi5j/+AqCE2lLrhpZeRNwEfqDTk6/qencU9V6VZOEtgyQ4bfHQtgbd1gk2kreAbRlN+fty7czpfvwIYDdDJb5GPK8+SJqv8jwlTnVK2Bh5nDRFW/narzwM6oPufNri3E1BUUWWzhUZMsNIzdMPI88zKHrL9A0CoPMB31lkZ5h/W6tVKExY0q95HlJK3IQ2m7gRJdU7HDyS92agLcbXEw/x+73yf8+JM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFrxu4JpaSCA8aJJ3TTBduei/xHGgq0I94g/dJRrW3o=;
 b=k0IZ9EM7THlNiTgdqTTx7equiYxxxeWPt76xOXQsEzgqYbHxxYt2HeG/XzFc57vhzdgvTVcLPU5rObhDH0oT3mdeZRSxtBljnMauVR93hzXavMjSVKmbhCm9OypSmN5eXMJcH0BoBaBXauKiM8K3K2CMDkwNQv0XQDeYZdRwBhOvibaNc3o4T4G2pTl3AjRXVs+6iPgMYNP1VNrAHIREPUKsAqDTLZNyX7ygYp7JSLgyKOIaSoidKgKy4vIvmXAVkTtV+2nf+LDk0wQAShXmfzHpnnJKhkKFUMm0huF/dGnq8sH/gC5dkgM3lG/ZvCg174XIyQeHUiIa7/0d/kfqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFrxu4JpaSCA8aJJ3TTBduei/xHGgq0I94g/dJRrW3o=;
 b=SvGoq/CZ1VJ7OPmgwfHrN8JI+wVZ3leKM+G3BFZ4nszad5ovVXNoFD8n09mLd2vl2/4P9fVIKOfx+2Xxqch/NVRp+8I2jUdie//I8IB5K+UkJ1s0XsVK1pHFquKldo+5PC15mXtCmC6djBUOoWj4dVBt9eXvXiadVgV6LnllfgI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 06:39:53 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 06:39:53 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
CC: "Huang, Shimmer" <Shimmer.Huang@amd.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Petkov, Borislav" <Borislav.Petkov@amd.com>
Subject: RE: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Topic: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Index: AQHalVofCwa2vRobwE2RC+5zsRgs9rF5gUCAgACcX/A=
Date: Fri, 26 Apr 2024 06:39:53 +0000
Message-ID:
 <CYYPR12MB8655F00474B6B7E5D0AA23E79C162@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
 <6c2470ba-e883-47c0-a75d-7d1b4c918aed@amd.com>
In-Reply-To: <6c2470ba-e883-47c0-a75d-7d1b4c918aed@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b2f309cf-a8ba-46b0-b229-8784160cf269;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T06:37:09Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB5880:EE_
x-ms-office365-filtering-correlation-id: 5a10ea9b-3a70-4234-ef59-08dc65bbae39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDBTQ1E1M3Y5clB1elZYNTV1R29UNEtPOG5LN3ZKMEk5dnRaWGsvbGFtQ2V4?=
 =?utf-8?B?Q20yWWRNc3ltTFFqamVSQ1g4KzdoclFCU3FVdnh5cjI3WTdXZFp4a2dpMDFH?=
 =?utf-8?B?aTZQV1NUWmwvR2JQWTBUME9abDAwK2hkYjZRWE5jQmhnM3JJMDB6VGhUNEV6?=
 =?utf-8?B?aXpTRVlkVXhjcnVtUWUzc21MZzZNc2ZKaWswN0ROVGRmdk04S2xVUHg1YmYx?=
 =?utf-8?B?Vi9JcmtXV1I1RjI3ZjRGK08wMk1Xd0JUTE5xdnNnYjNnUzBrSHV0YSs0VnBY?=
 =?utf-8?B?eFM5Uk5ONHI0RVVHODRtNm9kRWhYQk1mT0g5NVgrSTlEZkxjczRiY1lERE9N?=
 =?utf-8?B?ZG5mY2U2dloxTE5qc1pKSXFveVZYcCswOURLNGg0NHRJbURvMDJsNnRyc2JH?=
 =?utf-8?B?bjFMbUcybzIrS2Q5K05vMUtKYXpJSlhZTHdRYjR4L1doWVNQZlZiZTZTZDE4?=
 =?utf-8?B?NEJ0OUVDU0N2bGVLYitaTmtNeklWYmIzb2JnSTRvUWo2NTI0RVd4bzhEQ2Qz?=
 =?utf-8?B?cUNSbjN0enJDa2RLLzZjNm02RnkwTnowVG9icERQWTlzNVh0Y2lnRE8zb0pX?=
 =?utf-8?B?VURLbUdYTEN6bktzK3JXVmFZZWhqV2luRTljTnF3Y0t6Q2lKSGNsdkVrdUJy?=
 =?utf-8?B?V25KMGFhZVB2WlUxZXZpRmF0TDVVMmdVeXRKRnlIWHlaTVhIU0hQR0phU2ow?=
 =?utf-8?B?Nk9RejhXakdDZWlUS0ZEWHdqWVpMam5BTitCNm4vUTNWWDhhWDUvSG9lSDhB?=
 =?utf-8?B?bzJuS1JJSFFSdGZlUFYyTCtVSjhySTBtUUV1eVRMWld6QjNlcDNRbEs5Zmhp?=
 =?utf-8?B?U3ZKMk1IUDJTREs1dlRXOGliR2lkeklNOGNmZTJqaFU3UFRzL0tHTnhhSHNq?=
 =?utf-8?B?aTArTk1VelBpZlplQW94c2s4dXV1SjJHcXNuWU85WHJpZkpnQUtYalZ1UjJU?=
 =?utf-8?B?L2hpSndQMzlRd01GK0dubGhtTVlRUjduUExGSHJjaG9qL0lzSHZHRVY4VHRx?=
 =?utf-8?B?VWpHMDhPaUtCWXN6OXJJUlFUbVpBU3JrdS9RZCt0STUrL3FPN1RaV01renJ4?=
 =?utf-8?B?d0xoMGhpUjhJcGc0SEowOUMrRG5NODJVeDh6dHU4bXpQeEV4NFNvdDBSTGpO?=
 =?utf-8?B?UkRDZDRINzFkYm5MNjFneTgyekQ5MW92N1FMTCtQZEYzOE9tMVRVL2JPVEI1?=
 =?utf-8?B?b1Roeld3cEVjaytUUXlYY0dLUkQwQTNTK2k1STFrTDBqZHRiUjIxMUtLTDBo?=
 =?utf-8?B?MVJZSHp2RThnVWgvRmZUMitTRElKYUxrRGoya1JNa050aXUrUmlEenZYNytQ?=
 =?utf-8?B?dExzcDdTL0dod0pVMzE2WGM1SXRhOFZaWm01Y0ZUUFBDb3R5emNMS1dzRnRB?=
 =?utf-8?B?a251eUJESFpaejFXcHFwbkprUjIvR2hDY2lQSG1MdHBUbDNPeWhwRzFmZEs2?=
 =?utf-8?B?dVk2SGNpMHJwSENrTnJvZHJScUwrRW5mc1k3eGw5MExyZXp2QVM2bXRha0pD?=
 =?utf-8?B?T0VXd2xrVW1IRERIMmg0a1VLY0NPVCswcDZENTM4ZVVpd3cwNE1vOXZCWGs5?=
 =?utf-8?B?cFNqd3pKRncyMUtkNE5WR0ZQNWdibnNuYnorbTBaVGE5UElkZFlwY1k4WitN?=
 =?utf-8?B?VndobFppVSswSzZzU3BjeFA0UXNSUjN5K1lMdXg3TVdLR1dKcFBRMi85S0xO?=
 =?utf-8?B?eDltOEpiSUtaYm14cERHamxheWdNMS9sMEMxRDZpdlNXb1NGVCsyNDlSU2h2?=
 =?utf-8?B?MDBlK2Y5NGFMWFQwQ3BnWUlRQlA5amgrMmxvK1NDT0ZjcVRuQjJtVzg4dEtk?=
 =?utf-8?B?WUdlVmhXaXk2TERHWUVLQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDlkYTU2b1ZHRllwNGNzKzRWYWswTllUUlhJc0hQVG16amxlN0ZjU242dGVq?=
 =?utf-8?B?SzgzM053b2pOdU9YcFhMMkRqSnZXZHR4UFovS05qZnFjTlJhKzJqRE9wZDhp?=
 =?utf-8?B?ZlVNVHJtNTRVUm53Q1BqaDVQVjhCSkJ1RDFJd2JIeHU5dlBDeDFXdFhFa0Js?=
 =?utf-8?B?MDR2TWlyakt6WFhZQnE3Uk5aNHEyVjk2MUl4MmJmWm9BVHlnWEI3a0tlL0VL?=
 =?utf-8?B?RDhFdFBZRTIwcHdGM0lhcHBwWUZGajRqb0FQUUVVQjhtcks2UlJ0N2JBL04w?=
 =?utf-8?B?cFNVS0RyUTdzOVFWN3BzcUd3RVBqVm9uT0lxUk1OcHFyaENWOFpJZHJZd3px?=
 =?utf-8?B?Y2lRVzdibnRUenZzc0NHQkVwTk1KWWRPQUloNlBQT3UvbHFORGZORWM5S2I2?=
 =?utf-8?B?b2Q2ZE14eFIrcXJ1aGV4SEdsQkowN1dGYTZPVUtERTVNMnlEL3NEbDYvTEda?=
 =?utf-8?B?czhDM2l2bFFrQ2JuWDdwZmkxZnI4V3k2d2ZRbzN6YnIvblI5UE9YV1M3N1BG?=
 =?utf-8?B?VTVBL0Q0S0Y1bDZpWitZQ1Z4aUs3eDZtSTBRWk5zR1Q2WEVWU0M2QU93U0RO?=
 =?utf-8?B?UUZwMlJ6My9VQlkvbDUxOU02QlRSTzNBNVNjWWQzZlJ0b0svMkg4bjYvMDFu?=
 =?utf-8?B?OWp2RVpJOHFHNFBKb2kxT0MyZW10ZWREN3dPYlJ5aGhTWVR3ZmluUVhYZHNQ?=
 =?utf-8?B?Z0xyZmhjTyszVEkxWkEzeGUxUVBBUmQ2aEdpeDdSNzY5bXYyR2xaUTdZM3Mx?=
 =?utf-8?B?NTVublp6bWtFdDIwTnJ1Rk93L0V4NmJwdURFYjAvWm1hN3czMjBsUHU1bFBo?=
 =?utf-8?B?dUExZGlhbnR1WGYvNkIzVWFzWVhjN2g1V1BqbGYrbHFVMHE5U0J1SWpWV1NT?=
 =?utf-8?B?RDZmSXhMUmIzVkFXRnRvZjNvdkQrb3RuMEpQZ0tpaFQzWXdnem5pSjRpS3A1?=
 =?utf-8?B?a2Y1TklyblAyZS9NVFRScDVGTVIrTVFGY2hiUDZOeTczNktyZlppRW1ab2wx?=
 =?utf-8?B?UTRVMGJpU1hYWjZYRE1SQllIS3V3NE03VFd5cEx3MDJzdFlWQkdla0hQeFF0?=
 =?utf-8?B?QnllOHd1NlovZ21nUnovRlArU3BnaHFjVVN3YXY3bmpTSXVHUUJMa2Q2OG1w?=
 =?utf-8?B?dUUwYkZXTFlyOElaSDlSVnc5RHhqUENHNCtyK3R1VUNkQ2JnaGRWUGgyY2Q3?=
 =?utf-8?B?SzNIM2IyMkx4Z1dCaXBPci9CN0ZwZGI3VG95TGZBYnZ0dUFsdXFzZkoyaks2?=
 =?utf-8?B?My9lb0tqS0Y0d2dQME1CWGlZS1NSd2hQN0gvd1puL0xUSEViMzhWWENrU0xB?=
 =?utf-8?B?ZTF6WFJFcUFkb25zRDBzY2ZDQXE0OUV4V1ZmaFNsUXdsZ0FtVDByRlJWazNL?=
 =?utf-8?B?eFFQTWxCeG8ra3pwNTdYTUw0eW5iZ0pLV25xVkJuZ3owcEI3RTFCeGRQcTZ1?=
 =?utf-8?B?OEw3d3gvUzdjQ2ZVVkJ4RGN0eDdGSm9jd3krQ3g2LzloWi9pdGFycTJISDhw?=
 =?utf-8?B?MmxsTDFGcUhZcEIwWTVOYTB1d3JCMmttckNSTHhjRXJNcVZHNTJxdHNXNFZw?=
 =?utf-8?B?M0ZDRW5zU1VwdTlrRXJMdEdqWGpkdjhiNXhGZ3dwOXFxSkQvWldHVjdiRjBt?=
 =?utf-8?B?alVjQUVvQjFvYm1aTTlNTGhmRWdmQ2o3MksrZVlSdktNd2N1V3crZlg5Mklq?=
 =?utf-8?B?OXNRdkZIOHhGWTNqeFZFNlBneE9kcHRCaTRmMURDWERXbGZrcEtzS2l1UnM0?=
 =?utf-8?B?b1BJNkNEaWhEdDUzMll6Z29KTSs3aVVzY2NaNEZGSERkN0RobXhpa1ExVEZ4?=
 =?utf-8?B?ZUZab2tuSC91b3NEMG5MTGEzQ29KdFllckpwWml5bUh6WWpJOUVsMVlkbFpm?=
 =?utf-8?B?a3A5QU1LbndxUkN1V3lvN3dqWUQ5WVQyTW8vanZwYzFObXNPSnp4QlA2WUFp?=
 =?utf-8?B?YXQ0ZTI0emdidEJzcWlyUTJJSUJaaEp2ZlJoNGd3WTBqajRqaDRLZ1p2MC9D?=
 =?utf-8?B?VDEvbjcxdEhYSlAyNEY1QmdyV0Y2M1FIa1dEL0U1aDBJeEU4SmtIbE51Qnhn?=
 =?utf-8?B?QzdLYUpwbDRmSTYybmpBU1U3NVR0ZStlR1ZhaFJFQ2tzVWkrWUJuTWsvYmNQ?=
 =?utf-8?Q?vmQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a10ea9b-3a70-4234-ef59-08dc65bbae39
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 06:39:53.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXNcPMlgRlhtd/XTyi7wraZd4cHIWJ437ZjPlQ4E6kQTj+H0UB6rTJEvEiKPl+NfOmHaEb84GfFbjk+Smc1zrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvDQoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjYsIDIwMjQgNTox
NyBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5
c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgU2hlbm95LCBHYXV0
aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwgQm9yaXNsYXYg
PEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPjsNCj4gSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
IENjOiBIdWFuZywgU2hpbW1lciA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgb2xla3NhbmRyQG5h
dGFsZW5rby5uYW1lOw0KPiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5n
LCBMaSAoSmFzc21pbmUpDQo+IDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NyAzLzZdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGltcGxlbWVudCBjcGJfYm9vc3Qgc3lzZnMN
Cj4gZW50cnkgZm9yIGJvb3N0IGNvbnRyb2wNCj4NCj4gT24gNC8yMy8yMDI0IDAzOjQwLCBQZXJy
eSBZdWFuIHdyb3RlOg0KPiA+IEZyb206IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4N
Cj4gPg0KPiA+IFdpdGggdGhpcyBuZXcgc3lzZnMgZW50cnkgYGNwYl9ib29zdGBjcmVhdGVkLCB1
c2VyIGNhbiBjaGFuZ2UgQ1BVDQo+ID4gYm9vc3Qgc3RhdGUgZHluYW1pY2FsbHkgdW5kZXIgYGFj
dGl2ZWAsIGBndWlkZWRgIGFuZCBgcGFzc2l2ZWAgbW9kZXMuDQo+ID4gQW5kIHRoZSBoaWdoZXN0
IHBlcmYgYW5kIGZyZXF1ZW5jeSB3aWxsIGFsc28gYmUgdXBkYXRlZCBhcyB0aGUgYm9vc3QNCj4g
PiBzdGF0ZSBjaGFuZ2luZy4NCj4gPg0KPiA+IDApOiBjaGVjayBjdXJyZW50IGJvb3N0IHN0YXRl
DQo+ID4gY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0DQo+
ID4NCj4gPiAxKTogZGlzYWJsZSBDUFUgYm9vc3QNCj4gPiBzdWRvIGJhc2ggLWMgImVjaG8gMCA+
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+DQo+ID4g
Mik6IGVuYWJsZSBDUFUgYm9vc3QNCj4gPiBzdWRvIGJhc2ggLWMgImVjaG8gMSA+IC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+DQo+ID4gTGluazogaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc5MzENCj4gPiBMaW5r
OiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzYxOA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA5OQ0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
Yw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCAzZDg2Y2Q3YzkwNzMu
LjQ5ZWViMzhmY2YyMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC0xMjkx
LDYgKzEyOTEsMTAzIEBAIHN0YXRpYyBzc2l6ZV90IHByZWZjb3JlX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiA+ICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwNCj4gc3RyX2Vu
YWJsZWRfZGlzYWJsZWQoYW1kX3BzdGF0ZV9wcmVmY29yZSkpOw0KPiA+ICAgfQ0KPiA+DQo+ID4g
K3N0YXRpYyBpbnQgYW1kX2NwdV9ib29zdF91cGRhdGUoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVk
YXRhLCB1MzIgb24pDQo+ID4gK3sNCj4gPiArICAgc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xp
Y3kgPSBjcHVmcmVxX2NwdV9hY3F1aXJlKGNwdWRhdGEtPmNwdSk7DQo+ID4gKyAgIHN0cnVjdCBj
cHBjX3BlcmZfY3RybHMgcGVyZl9jdHJsczsNCj4gPiArICAgdTMyIGhpZ2hlc3RfcGVyZiwgbm9t
aW5hbF9wZXJmLCBub21pbmFsX2ZyZXEsIG1heF9mcmVxOw0KPiA+ICsgICBpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArICAgaWYgKCFwb2xpY3kpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIC1FTk9EQVRB
Ow0KPiA+ICsNCj4gPiArICAgaGlnaGVzdF9wZXJmID0gUkVBRF9PTkNFKGNwdWRhdGEtPmhpZ2hl
c3RfcGVyZik7DQo+ID4gKyAgIG5vbWluYWxfcGVyZiA9IFJFQURfT05DRShjcHVkYXRhLT5ub21p
bmFsX3BlcmYpOw0KPiA+ICsgICBub21pbmFsX2ZyZXEgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+bm9t
aW5hbF9mcmVxKTsNCj4gPiArICAgbWF4X2ZyZXEgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+bWF4X2Zy
ZXEpOw0KPiA+ICsNCj4gPiArICAgaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9DUFBDKSkg
ew0KPiA+ICsgICAgICAgICAgIHU2NCB2YWx1ZSA9IFJFQURfT05DRShjcHVkYXRhLT5jcHBjX3Jl
cV9jYWNoZWQpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICB2YWx1ZSAmPSB+R0VOTUFTS19VTEwo
NywgMCk7DQo+ID4gKyAgICAgICAgICAgdmFsdWUgfD0gb24gPyBoaWdoZXN0X3BlcmYgOiBub21p
bmFsX3BlcmY7DQo+ID4gKyAgICAgICAgICAgV1JJVEVfT05DRShjcHVkYXRhLT5jcHBjX3JlcV9j
YWNoZWQsIHZhbHVlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgd3Jtc3JsX29uX2NwdShjcHVk
YXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19SRVEsIHZhbHVlKTsNCj4gPiArDQo+ID4gKyAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgICAgcGVyZl9jdHJscy5tYXhfcGVyZiA9IG9uID8gaGlnaGVzdF9w
ZXJmIDogbm9taW5hbF9wZXJmOw0KPiA+ICsgICAgICAgICAgIHJldCA9IGNwcGNfc2V0X2VwcF9w
ZXJmKGNwdWRhdGEtPmNwdSwgJnBlcmZfY3RybHMsIDEpOw0KPiA+ICsgICAgICAgICAgIGlmIChy
ZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJmYWlsZWQgdG8gc2V0IGVu
ZXJneSBwZXJmIHZhbHVlICglZClcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgIH0NCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAg
aWYgKG9uKQ0KPiA+ICsgICAgICAgICAgIHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSA9IG1heF9m
cmVxOw0KPiA+ICsgICBlbHNlDQo+ID4gKyAgICAgICAgICAgcG9saWN5LT5jcHVpbmZvLm1heF9m
cmVxID0gbm9taW5hbF9mcmVxOw0KPiA+ICsNCj4gPiArICAgcG9saWN5LT5tYXggPSBwb2xpY3kt
PmNwdWluZm8ubWF4X2ZyZXE7DQo+ID4gKw0KPiA+ICsgICBpZiAoY3BwY19zdGF0ZSA9PSBBTURf
UFNUQVRFX1BBU1NJVkUpIHsNCj4gPiArICAgICAgICAgICByZXQgPSBmcmVxX3Fvc191cGRhdGVf
cmVxdWVzdCgmY3B1ZGF0YS0+cmVxWzFdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEpOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+
ICsgICBjcHVmcmVxX2NwdV9yZWxlYXNlKHBvbGljeSk7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4g
cmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBjcGJfYm9vc3Rfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+ID4gKyAgIHJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiV1XG4iLCBhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXMuY3BiX2Jvb3N0KTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgY3BiX2Jvb3N0X3N0b3JlKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmIsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpIHsNCj4gPiArICAgYm9v
bCBuZXdfc3RhdGU7DQo+ID4gKyAgIHNzaXplX3QgcmV0Ow0KPiA+ICsgICBpbnQgY3B1Ow0KPiA+
ICsNCj4gPiArICAgbXV0ZXhfbG9jaygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+DQo+IFRo
aXMgbXV0ZXggbG9jayBzaG91bGQgYmUgYWZ0ZXIgdGhlIGNoZWNrIGZvciBjcGJfc3VwcG9ydGVk
IGFuZCBrc3RydG9ib29sDQo+IGNoZWNrLiAgUmlnaHQgbm93IHlvdSBoYXZlIHR3byBjYXNlcyB0
aGF0IHRoZSBsb2NrIGRvZXNuJ3QgZ2V0IHJlbGVhc2VkLg0KDQpZZXMsIHRoZSBpc3N1ZSBoYXMg
YmVlbiByZXNvbHZlZCBieSB2OC4NCkkgaGF2ZSBtYWRlIG9uZSBuZXcgdmVyc2lvbiBhZGRyZXNz
aW5nIHRoZSBmZWVkYmFjayBmcm9tIHlvdSBhbmQgUmF5DQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL2NvdmVyLjE3MTQxMTI4NTQuZ2l0LnBlcnJ5Lnl1YW5AYW1kLmNvbS8NClBsZWFzZSBo
ZWxwIHRvIHRha2UgYSBsb29rLg0KDQpUaGFuayB5b3UuDQoNClBlcnJ5Lg0KDQoNCj4NCj4gPiAr
ICAgaWYgKCFhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXMuY3BiX3N1cHBvcnRlZCkgew0KPiA+ICsg
ICAgICAgICAgIHByX2VycigiQm9vc3QgbW9kZSBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoaXMgcHJv
Y2Vzc29yIG9yDQo+IFNCSU9TXG4iKTsNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgcmV0ID0ga3N0cnRvYm9vbChidWYsICZuZXdfc3Rh
dGUpOw0KPiA+ICsgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+ICsNCj4gPiArICAgYW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zLmNwYl9ib29zdCA9ICEhbmV3
X3N0YXRlOw0KPiA+ICsNCj4gPiArICAgZm9yX2VhY2hfcHJlc2VudF9jcHUoY3B1KSB7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgIHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5ID0gY3B1ZnJl
cV9jcHVfZ2V0KGNwdSk7DQo+ID4gKyAgICAgICAgICAgc3RydWN0IGFtZF9jcHVkYXRhICpjcHVk
YXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgaWYgKCFj
cHVkYXRhKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBwcl9lcnIoImNwdWRhdGEgaXMgTlVM
TFxuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PREFUQTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgIGNwdWZyZXFfY3B1X3B1dChwb2xpY3kpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfZXhpdDsNCj4gPiArICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgIGFtZF9jcHVfYm9vc3RfdXBkYXRlKGNwdWRhdGEsDQo+IGFtZF9wc3RhdGVfZ2xv
YmFsX3BhcmFtcy5jcGJfYm9vc3QpOw0KPiA+ICsgICAgICAgICAgIHJlZnJlc2hfZnJlcXVlbmN5
X2xpbWl0cyhwb2xpY3kpOw0KPiA+ICsgICAgICAgICAgIGNwdWZyZXFfY3B1X3B1dChwb2xpY3kp
Ow0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICtlcnJfZXhpdDoNCj4gPiArICAgbXV0ZXhfdW5sb2Nr
KCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArICAgcmV0dXJuIHJldCA8IDAgPyByZXQg
OiBjb3VudDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFtZF9w
c3RhdGVfbWF4X2ZyZXEpOw0KPiA+ICAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8oYW1kX3BzdGF0ZV9s
b3dlc3Rfbm9ubGluZWFyX2ZyZXEpOw0KPiA+DQo+ID4gQEAgLTEzMDEsNiArMTM5OCw3IEBADQo+
IGNwdWZyZXFfZnJlcV9hdHRyX3J3KGVuZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlKTsNCj4g
PiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJl
ZmVyZW5jZXMpOw0KPiA+ICAgc3RhdGljIERFVklDRV9BVFRSX1JXKHN0YXR1cyk7DQo+ID4gICBz
dGF0aWMgREVWSUNFX0FUVFJfUk8ocHJlZmNvcmUpOw0KPiA+ICtzdGF0aWMgREVWSUNFX0FUVFJf
UlcoY3BiX2Jvb3N0KTsNCj4gPg0KPiA+ICAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9w
c3RhdGVfYXR0cltdID0gew0KPiA+ICAgICAmYW1kX3BzdGF0ZV9tYXhfZnJlcSwNCj4gPiBAQCAt
MTMyNSw2ICsxNDIzLDcgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVfZXBw
X2F0dHJbXSA9IHsNCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwc3RhdGVfZ2xvYmFs
X2F0dHJpYnV0ZXNbXSA9IHsNCj4gPiAgICAgJmRldl9hdHRyX3N0YXR1cy5hdHRyLA0KPiA+ICAg
ICAmZGV2X2F0dHJfcHJlZmNvcmUuYXR0ciwNCj4gPiArICAgJmRldl9hdHRyX2NwYl9ib29zdC5h
dHRyLA0KPiA+ICAgICBOVUxMDQo+ID4gICB9Ow0KPiA+DQoNCg==

