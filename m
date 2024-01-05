Return-Path: <linux-kernel+bounces-18062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318082581D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D0B284D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709B2E846;
	Fri,  5 Jan 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N+rBE7iV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FboBZ81s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA22E855;
	Fri,  5 Jan 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405GF2Ae032032;
	Fri, 5 Jan 2024 16:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Ba/qok9jw8+75sTYDicble5qamSOdS4vEWKPmyxhL0g=;
 b=N+rBE7iVLRoEIi8jFdEYmW2qrCSr7ZecyNGyA3vDZogZ0/+phnxiZkoDgJruJQgaadoD
 sWWLoKQ4b/bUNkC7slVu/xPz2jNfzwQJa5yWNlTefto/q3ZRiAOE3EQp2wWHvWSxyK+g
 u+t5k6NXu/v8o0Gvs/qLA86TTkFcta6foPRGcAkFwml8ZaW6A0fC3Hh1ux9pjyCdP1SC
 5HaDthAavvx2boMa43gSMFVO7uWeEGFpLDFE04a8QPrguDNq3lRqhyrypU8hExMjyRUJ
 EPEhDIAWvLdUu0i0E/eccpOpG5C0KOQazYiMP0qrdDHb1cn978M2SMVHQm4EvOz0ddGh Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ven4081ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:27:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405G4YQS023320;
	Fri, 5 Jan 2024 16:27:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ve1n7hfug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP2u5ZQKv3F+ewmaPt0HaIq8PduVOPjIfWJdAzgrBNM7CVc1hQ8KwGRGxMoc1dGTZsH9y1Uxnv5lcewB8TDEqxpKzDZ6gqTSN5rwktsEszpOmTvaQL/UQZ7yS605+20EnmJl34TRmsZDLJP0cp3T7xb9tVMDHh83nF96Zd1GbjG9jXusxH6z24SuM6lN9bF20Uq59PiJoo70VNHRl+P4l93gCog9Q0ZZ1FMwkZfRevWksgWeoKkjNubGUGdVIPUNY8WhxxJ3vv2PT1+L8I5Yx2LKASF8C6vymk+oPkNAvjbC15QaAbLfXi/5xM9uRdDLzrA4OTwruitwgc2HlejEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba/qok9jw8+75sTYDicble5qamSOdS4vEWKPmyxhL0g=;
 b=QqFLEu/sfiF5rsq5YH97RbOQcka0NdXxaRfUEjhJJwSaAcDYWcoLA3Bj+xX2MK4u8/ImM2a4prr2IfMJwczLvzU/BI1Jf6lJutZSuVUb1nSbf2/n3JilOJK296s2NbBOS+Tzta8RfSeCbU5u9rFF7fBRngZUoUNtNmejtBYLqOLKJebkMRpEcQ2wiNAJ+pis6TtDtUqiCl53msgeFvtAh0WZfbq5K9vyoxiXRarCv4tljNwiYFYWpmzTEE1QzUjWgQwrgY/9uMykAViRBlsqG30JaAGqkomWT/EcNqZNEN8c3x0Cm6Oa35tskB8XgH0kOP5yg9heqdJevFitOj1goQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba/qok9jw8+75sTYDicble5qamSOdS4vEWKPmyxhL0g=;
 b=FboBZ81sqJG38AtRSfahi61PjvHTZmBY4Z1++VOUKQcidiZ8WdgL79vKpn/Yy8P2zIKJnHYACqyBYt8Mc7q6lKfzBKbBzW1u+HeFv2yC6HDoPKFwJpuRZHTUbYiqpfzp+VvtFgi1EAsnnFYT3MPg/7whVAF5Qmer9hMilsDBsvY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 16:27:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 16:27:06 +0000
Date: Fri, 5 Jan 2024 11:27:04 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <20240105162704.7gulfnerq5tvmjbg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Feng Tang <feng.tang@intel.com>,
	"Sang, Oliver" <oliver.sang@intel.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
	lkp <lkp@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-mm <linux-mm@kvack.org>, "Huang, Ying" <ying.huang@intel.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
 <ZQCAYpqu+5iD0rhh@feng-clx>
 <ZQCLdzmtVcjxZWXt@casper.infradead.org>
 <D00399D9-D629-4CE3-AC32-636FD6F06C24@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D00399D9-D629-4CE3-AC32-636FD6F06C24@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: cda2d99c-b28b-4011-1ce8-08dc0e0b2870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vn+i3HgWWMy204U0sIc3e/ND9LvI7OybqQjHlDxwV7ltpWDmAx9KAaNEJoq00lX9jCWuagbgYlcvJO7gzdvZWN64Xjxs2IJ6g6CIaeam/EaN9syHj5ZNjlcsOuu2hic8dEi3fhhSHE2Z48zWFpm+pU/NaGepi8RDgSARSXBKh7qChVp++lGTfd+ophOcJ3p5ID8sNCXdyLoJ4verO3NAi3ULInHIyF1dHd5mqIeJDt3aMItb4J2hBKJNYNNKGdoO0vlgUlyBEiLAAk31fswriNEOuWUrEqQma8sB6/I1/qOgyeEzTPdgXjSNBIOTj5bFCIUyic+Jn1RhR3BJZfxnG18VkvBlH1GKoUDLGMS+67AyZP9HgKCmfX6GqgOd2KfQZUTtlMVx1znpfzgVuGq3baWEcblYKmXiM88KT0gfeaW/0NIvAuumBWzU0uVOmO9GBAzl88DZoQQ95a90K9pn2MNSHJhmTHH5Ba1YnPM+7r36C/7IJjGHOraxYHV6rO2SPtvAF2y0xpWC9xsYZBcvODg2UTS8+Fyyy8LI1UfWXQdErukWnCITK5QfjqtYbYo+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(33716001)(38100700002)(1076003)(26005)(478600001)(86362001)(83380400001)(66899024)(2906002)(66946007)(66476007)(5660300002)(7416002)(66556008)(6862004)(316002)(4326008)(6636002)(9686003)(6512007)(6506007)(53546011)(54906003)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjdvU09NNTF4akptZHFocEVaa1RlK3BETTNiOXgvUzg1NUFWYzZqcmUvai9V?=
 =?utf-8?B?aktlSlpxUU9EODNvSWhuN1ByN0tqUjB1ZG9XWXRQMWQ5cWhKdnJ4b2luNGpU?=
 =?utf-8?B?dTVOQjRrQUJtK3QvUlp1dm1scThWa0VVNTV3TnoyMzBwempCT3pwdGszeFhC?=
 =?utf-8?B?a2xUVmxyUHdRamhUQnU4c2krTkJVK2RReXU1Z2c4SnZlYjNvcDNqSjJ3ZkUw?=
 =?utf-8?B?ZWNkbWNBNmxPUXNLTlYyb3BRSTVmbGZONUg3TythL0UzRVA0YWxnaENRVVRH?=
 =?utf-8?B?QjVWRkphZnp6TVUrdjBxV0RSV0U1NkZUNFltdWJQSmN6OFdQTU4wbmNWcVhh?=
 =?utf-8?B?UFdSN2czVTIrR1pnUG4xUmJTdHg2K1lCcTNRVjUwVWNaVm9VbTFaZWxKb0kr?=
 =?utf-8?B?Z011dUhoZEZZMlozUU9VblhmekdGTUdkZ2NScm51SHJOaDZRQlU4NmoveGNh?=
 =?utf-8?B?dEkxOU5HQWN0MGM3WDN2eW9TQ1NpRVAyU0kwNnFWb091SlVKZ2lQcHdrai9J?=
 =?utf-8?B?TWF0MEN4NTQ2TVRURHQwaCtrVmxzL3ZCT2llMENtSHVrMlduR3hPdk1XVW5r?=
 =?utf-8?B?ZHd1dVhZRnN1NUF3SVZ1Y2tFUHY0dkkyeWN1NjlhQ2IrV09tdHM2U2NodDd1?=
 =?utf-8?B?WkRqNy9NZzQwSTlnZVY5TTdKOXpXY0dHR2tHT0FTQmEwamtBdXlrYzBqT21C?=
 =?utf-8?B?VlV1NWZ1eDNNM1d6NE0yS0doM0N0SmlqWG1RQnFVVFd1UmhBRVdZTHBiRE1O?=
 =?utf-8?B?UnVmYUJRNUM1M0ZMUVhyZDRtYWw3V0lvL1FWalJyM29XaXNXQXh4NkV2cEVW?=
 =?utf-8?B?MlFUdUNtSlJjOHFhT2FJQUVXbkZCNTNqd0VhWFdML09CVzlFdjMyK1lXeU1n?=
 =?utf-8?B?VEhvSjlxMzA5ZEFGekZQM1JSZlZ2QjE1R2VNcHhrYU53T1RvbUxhOU9FUDJF?=
 =?utf-8?B?RzROWVUzeUxKM2xGU3p3M1NIR2t1Q0tvNGxrdHcxS0s2Wllva3VrTkNZS0pK?=
 =?utf-8?B?T3pzeWdzbndWTDNodE9tejB6bXlDOTJVUExmdmU1VERQa2U4RDJ0VGU1ODh1?=
 =?utf-8?B?TTFBTlBXSE9WSnh3MU1aWFdZanFLY1IxZGlBY3Y1ZjhERVljVjhrcnlTLzdD?=
 =?utf-8?B?bjNDVEY3WDFsV3BLMDZtelZJdWxreENoKzBYZ3E0TFVjY1JTeFNNRExrcFQ3?=
 =?utf-8?B?T0o1Mi85UTFSOVZyb0pnSEphMG5aVmJyeUpMUGtYZmxWV1Q3Vjc3VWRoeTZR?=
 =?utf-8?B?dTFHMEVPK1BkNyt6YXBKWVZKQnZvcVczSFdJMVBrdnFNSmJVSzBZdXFoTlBy?=
 =?utf-8?B?OSttam5BYzdiSFRHZjRRVGxyVUhhdld1R2ZONWtUUGh4UVBVWGZ0cmdteTNy?=
 =?utf-8?B?Z1R3NzJQRTFyTzdnL0JuR1h0bGNtSnZCelFCMjc3MEtucUt2VEdCMUlnckM5?=
 =?utf-8?B?Q2dZZ0t2M0xqUG5SVG95WnN6aU1ldnZNTUhYZ2xwMXI1K3NxRGFJUFZUb2Vk?=
 =?utf-8?B?ZWpBV0Y3bW5HK0tVRGIvb09SRDBuc2pzZ1VqeXZtSmtSNHVuVUV6djNEZUtK?=
 =?utf-8?B?TFY3WjlWWXBwQlNYN05CMHpLYXZiMWJ2SXhMQnFNQmdyNkRMc3B0dGV5ZldV?=
 =?utf-8?B?WnZPQUMvd29KbmtyVitQeWt3SFdMSDEvYTJyT3Y2QUxnSzF1T0liSW9GK082?=
 =?utf-8?B?QXBCTm8rSitJK0o5emI0ZVdlNlJJMUhnWC9SQmRHWmhFYm03NkN5ZG1VM0FS?=
 =?utf-8?B?R04xUkRRQ3k3WWxqaXlSQXZ5eCtTa21GZnF3SGtraWFEVGRra1R1YjlYSWhx?=
 =?utf-8?B?ZWZ6cmlRdTFRSlc2Z2RUemltUUVWWXNCK0VRQ1BMbzVab1cwOUs3VkFLQmxG?=
 =?utf-8?B?Nkc4QUVzVjhBSzNnN3JiY0dGQnQ4TzByRVo1QjFJNVhmMTBEaGtZcHQrcEx6?=
 =?utf-8?B?UHk3NStMdjA5RFlENC93YXJkTzdVSWx1MDRJNTFzaFhFZTVSWjN2RHUxcTN3?=
 =?utf-8?B?d3FVZDBSV1B5QVZxbUtJR3AyWWxVNTFHU3dmNkhTY1RwZmpFNW83b0RNWUhj?=
 =?utf-8?B?RG9PYkM0ZVR2UlNURVdYZ1FMYWNxQTdoMUZjenBZUUphcHVXMG5ZRWlhY2s0?=
 =?utf-8?Q?cfvxF8ph9ayDdg6Odfr/HHZDa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TyJOFIg3WqVShtm8T49wroEFH8TRAL4O2U8JerVEYFwNb3rQYRxTMcF0lW1vJC6MLqQDYZerOdoEZzwr1rDaGf8IwOkt1WpE9Malbgq5PZ1y4P+2mc9HvJeWP5Zn6cv0GoXjGZJJTFn1sOrh/MIdYkrTBz2vAO1hQVVDmFXlNVEAIFM2yxSrchwTe6CaMbKNdcz1GLK1I2pWGScF+TUVLd/fPeL7CBdrdKGImO9WWMlX4DCDpVYKIRm0fmwEjseWvdm6DjubOlVaLm9+9atHd0JoW2OePSzLA/Q1yf+upFnvg3ynFW9ODm2FykLpG//FBUPRQZVjEUxHjnoOo723dJhYloeVhki6edeLjvvlOu9Dsq+jE41jhOLxTJeCDK7A7AvglDkf1TiWfQXNdcEONddtprqTErdFQdxCfKXnG2GFD/rzwMFl8r+2gA+bbssGzvtfaTkojN9mTFEfSn9SYb08IYTppAyPdLE985b78lS5ElCDVHwCrtTyZQEFr4hBSMX3Fdf78reQOyVYEjEJD3wz/fon+nvj5SyG+1LoFGc7kLx5Qm4RTmGLdITQ15vyOn8kao0eZsou3q7zmYItiQ7/SO7/dpSDOm1lBvi7CFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda2d99c-b28b-4011-1ce8-08dc0e0b2870
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:27:06.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLO3IAcyJ0+iUDbhacK8yWgx1mtHIlqINwQyStHFSs3HT+J3GrtwxHaLnGT72ayuoimD+5vwOzfAej1Hx9Nt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401050135
X-Proofpoint-ORIG-GUID: Np3YLvrAFKCVfEHCsDRTM7VYw79NhoTD
X-Proofpoint-GUID: Np3YLvrAFKCVfEHCsDRTM7VYw79NhoTD

* Chuck Lever III <chuck.lever@oracle.com> [240104 14:33]:
>=20
>=20
> > On Sep 12, 2023, at 12:01=E2=80=AFPM, Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >=20
> > On Tue, Sep 12, 2023 at 11:14:42PM +0800, Feng Tang wrote:
> >>> Well that's the problem. Since I can't run the reproducer, there's
> >>> nothing I can do to troubleshoot the problem myself.
> >>=20
> >> We dug more into the perf and other profiling data from 0Day server
> >> running this case, and it seems that the new simple_offset_add()
> >> called by shmem_mknod() brings extra cost related with slab,
> >> specifically the 'radix_tree_node', which cause the regression.
> >>=20
> >> Here is some slabinfo diff for commit a2e459555c5f and its parent:
> >>=20
> >> 23a31d87645c6527 a2e459555c5f9da3e619b7e47a6=20
> >> ---------------- ---------------------------=20
> >>=20
> >>     26363           +40.2%      36956        slabinfo.radix_tree_node.=
active_objs
> >>    941.00           +40.4%       1321        slabinfo.radix_tree_node.=
active_slabs
> >>     26363           +40.3%      37001        slabinfo.radix_tree_node.=
num_objs
> >>    941.00           +40.4%       1321        slabinfo.radix_tree_node.=
num_slabs
> >=20
> > I can't find the benchmark source, but my suspicion is that this
> > creates and deletes a lot of files in a directory.  The 'stable
> > directory offsets' series uses xa_alloc_cyclic(), so we'll end up
> > with a very sparse radix tree.  ie it'll look something like this:
> >=20
> > 0 - "."
> > 1 - ".."
> > 6 - "d"
> > 27 - "y"
> > 4000 - "fzz"
> > 65537 - "czzz"
> > 643289767 - "bzzzzzz"
> >=20
> > (i didn't work out the names precisely here, but this is approximately
> > what you'd get if you create files a-z, aa-zz, aaa-zzz, etc and delete
> > almost all of them)
> >=20
> > The radix tree does not handle this well.  It'll allocate one node for:
> >=20
> > entries 0-63 (covers the first 4 entries)
> > entries 0-4095
> > entries 3968-4031 (the first 5)
> > entries 0-262143
> > entries 65536-69631
> > entries 65536-65599 (the first 6)
> > entries 0-16777215
> > entries 0-1073741823
> > entries 637534208-654311423
> > entries 643039232-643301375
> > entries 643289088-643293183
> > entries 643289728-643289791 (all 7)
> >=20
> > That ends up being 12 nodes (you get 7 nodes per page) to store 7
> > pointers.  Admittedly to get here, you have to do 643289765 creations
> > and nearly as many deletions, so are we going to see it in a
> > non-benchmark situation?
> >=20
> > The maple tree is more resilient against this kind of shenanigan, but
> > we're not there in terms of supporting the kind of allocation you
> > want.  For this kind of allocation pattern, you'd get all 7 pointers
> > in a single 256-byte node.
>=20
> Hello Matthew, it's been a couple of kernel releases, so
> following up.
>=20
> Is Maple tree ready for libfs to use it for managing directory
> offsets?

The feature you are looking for is dense nodes.  It will allow for
a compact tree when you have a number of single indexes mapping to
entries (ideal for many ranges of 1).

I'm actively working on dense nodes, which will yield 31 entries per
node when they are single index mappings.  I'm hoping to have it
completed in the next few weeks and start beating it up with tests
before pushing it out.

>=20
> Should we just go for broke and convert libfs from xarray to
> Maple tree now?

We are trying to keep the API close for both the xarray and the maple
tree, so if you do the conversion to one then switching shouldn't be
much work.  I'd try the maple tree to see if the performance is
acceptable today (I may be biased), but I don't know how big of an
effort this conversion would entail.

The maple tree will compress the NULL indexes to a single entry of NULL.
My main concern is the density of information and the number of
allocations the tree will do to keep up with the workload - both will
improve with the dense nodes feature.

If you convert to maple tree, you will get the update for free later as
the node type the tree chooses will be transparent to users.

If you need tagging then you should use the xarray as I haven't started
that feature yet - but I don't think you need that?

I also noticed that Matthew mentioned xa_alloc_cyclic() as the potential
call into the xarray.  The maple tree counterpart isn't used much today
and may need to be optimised.  If you can verify what this test does, we
could produce a test case for the maple tree test suite and optimise if
necessary.

Let us know if you have any other questions or need some pointers on how
to get started with a conversion.

Thanks,
Liam

