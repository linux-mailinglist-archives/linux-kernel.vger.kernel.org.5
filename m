Return-Path: <linux-kernel+bounces-24229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1082B975
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB71C23CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF24139F;
	Fri, 12 Jan 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mf/6KC/u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x0yYFOPR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B1136B;
	Fri, 12 Jan 2024 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40C1AGWQ003400;
	Fri, 12 Jan 2024 02:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=phDZoDxnXn2C0XqNUVkv6DN6RJaUZkIFuIKrU7now7w=;
 b=mf/6KC/u/h4pMnafxVGDG776/qbCfxZHEBASQvDFqhxTPLSP1tdVD/drtozZVnjilVn4
 97Z3fogZstT/BnmUIn3iv3J5nSxZhd8v6lVGzKYby28EW/FEBE8kacVCc/L/TuGLOfiQ
 bOm8hnc4fr/S8bGpspF+IsBCrLjFKA8v7n3x+5WuJkRosUS3n3nPyBeqCz3PMFKB9MKy
 7OCKlQxkcHJsiW1rWvfL1cFLbQvFB/bjqInghuwFSyc/yarlpeUNeKvj9cHxoAfxmsGE
 V915zgyqPdW3/sFT53mXNz5XtkLaGEeq5pxSrfGepIdJigbzhGYnZJ0aNKSFpb7zWj2Y YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjnwv8xwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:21:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40C17n9j008761;
	Fri, 12 Jan 2024 02:21:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuup33un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrSLJz5HSE7UFW7ettnpRBVHV0r3dz0nFmMtMtGZzVdpDu2iHNZuWk1oX93TANQ/9lBVKDxZRIb44QvjBsCaB8oqq7hXitNvy8UiSHxtD0Nhg7GwfORoRmF7m9wYYmdlP7IPBEzsnS0xZaSGuCB0hX6WkSg5QA9arJRkjXzkKr9XinDZW/P6WQ0O6Vnbmv0sp14uOoufvVOiLaRVBtUEm3+lGt3vJJM3TVeYYQXUF0JYo1krDUb0cLt9wer8IPmE2A7A72qm976S/VCL1cHRiWxkEn618DZUX52CrqXdLU1nOzrEkI6XXxhLT/ba6y3PF2TD3Je1RxEsO9v/3OLmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phDZoDxnXn2C0XqNUVkv6DN6RJaUZkIFuIKrU7now7w=;
 b=a48qx4AWhQz9CB1lEJsSaDkUlg7fzGzwTk2nLa5apGCduufqHLPk3qrRiLOGkNdfB55rQiANk0aqUT8bt7t9gXeBUBcH4Kf8Oh1J0VHwBwL7fSkf6Fs1Ztgl4x6hFX8ls3slL1oRNk1knQ9zLpT6FR07GLINqpqv1nfrfyPK1IP1YhZTHcXTKntQKMWbbqw5SKiz9WSIOAN/RMo1aUWDey7uszZsGcnhAuP87GcJRDX8DFeaVbmtCJkAH0OtMY7chkqjRznIxypz5DPwKgSKXJ1mccmnMltIdhAvjDizLdtkDM3867V/ZGJ3tpk0UJVNYQaRZuheU97twz8HgGIn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phDZoDxnXn2C0XqNUVkv6DN6RJaUZkIFuIKrU7now7w=;
 b=x0yYFOPR/0RScovC8OBSSJka/ebHiKUo2PizO0UZ5lfzmRcYRJUG8W62Q/D9rrqq1BvQTvLmkghXCJWDWSTaSSTir71mwBCHCf5Twzp0n0Jn6wv/rpJ2pkXox6hPAr81yOQJt7N7p6XKprnRL5Pb1KT9JzFJkuV35sSaUO24w/U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 02:21:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 02:21:02 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Pavel Machek
 <pavel@ucw.cz>, bvanassche@acm.org, hch@lst.de,
        hare@suse.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: scsi_get_lba breakage in 5.10 -- Re: Linux 5.10.206
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1il3z5m4y.fsf@ca-mkp.ca.oracle.com>
References: <2024010527-revision-ended-aea2@gregkh>
	<ZZ042FejzwMM5vDW@duo.ucw.cz> <yq1jzoi7hrt.fsf@ca-mkp.ca.oracle.com>
	<2024011047-clench-scheme-1f46@gregkh>
	<2024011121-unfailing-backroom-14e6@gregkh>
Date: Thu, 11 Jan 2024 21:21:00 -0500
In-Reply-To: <2024011121-unfailing-backroom-14e6@gregkh> (Greg Kroah-Hartman's
	message of "Thu, 11 Jan 2024 10:45:38 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b6e389-d9c6-42f1-bc42-08dc13151f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	882RNh1eeCnsyu0dJc38LrO6oON5ZXVlGhxfS+tc4HeniDP5Da31PY70cEBE7L4E24cJMqc66I6P5MMX7UvBT9Eb+o9KCcNFJy+cPyCZztc4HwIUL+pK3+UIrvVkqZAyaxLlbFruUVhUBMGY3nuxMNqp+2heF9UGGIbYxVi+mktP1movETZrq5+Fr8pX30ElIfg3kUITHldiJF8KzjrEKtIVfWa1H9/rNrVqCHpzNS12/OEQLduan31wey23/k+n2e+6HmBx6x4oC+9RkrNX+VcacNRezIc5JLCUGoyJX0rga2jdag11cv+Z6hq7cgGtrBuD+pk8/i2jTH/pWbN5KmgVb0Hz5T67DBG2Fr7CcxPP8CT2/AJe5uGSdYmSa9Ll8CD+Qt4s+2QV+I0W3gdusb7/jqSLILyazndVudPhBUKaSWs3EO/fu7cqj/7cuIlipZGIL7lA4flcyn/qbEla41kRgkiXOC4KfXHsF3y9B/mKaM/fqRIgWDikAcSTLQuisrZ/wlAT9bcQS3Lb7GtFJeCHjf6pvQKQBl7ATg6tPDj2EkTZwR0WLfNFlr3J/PFl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(8936002)(5660300002)(478600001)(4326008)(38100700002)(6512007)(6506007)(36916002)(4744005)(2906002)(7416002)(66476007)(66946007)(66556008)(54906003)(6486002)(316002)(6916009)(26005)(83380400001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3KawuotghE91fqTlZlbfX49D7MsH/Z5o35Cf/YOVOuBA+c5P62REENVjeiNf?=
 =?us-ascii?Q?rQDU1UT3xNnCM4enxfmoKHD+q/3PSx5Fhn2idUrKOtNUZMOstCMLX1yIE7io?=
 =?us-ascii?Q?9459XGBa+h43Jvi5evVK1FgckeFOhiz1UMnMicI/8orNs2zrWoqPekC+ia92?=
 =?us-ascii?Q?fvGDbVT0lb5PkReYRd8ddPSN5QWXJMOaoPJonnJr6pvlB0xcdh+R9wdRPSnU?=
 =?us-ascii?Q?R8BySj+2WMAsP/4UmZcjDXxxmcJ3MMOHfDi44vk6gotQOTB2cm2Rl4wLphMt?=
 =?us-ascii?Q?MLT4sOwj5Ing3Fppj9IycSi9X/RV9otg9mm65+aDHeBqKxz59LNtAgEpT9GF?=
 =?us-ascii?Q?a6vIJ7seCdvimG6rA5BydgHppWPUden3YiO6FQo+DHCVbvfa6EScxAfhx3kv?=
 =?us-ascii?Q?EMARXCWnSR+0RWU3kD7qtW2Zk/VM+ZA2/1+OyZS93FLD+cRENr0Lf7fHtmnI?=
 =?us-ascii?Q?suNNSr3dPsCWYhrKLWmz4yayVRXFsEhm6rvSx0/fq6DXNjmGlNvddf8nqAo3?=
 =?us-ascii?Q?1o5snCJHfQR7U9cLrQML7Xg1eIrafwqH3p3S38OxU+4cJRv12FIS7Bt6IR/z?=
 =?us-ascii?Q?AOVo2r0svMLKzAaHgtNUdoCCEpHAl2/+PVx/hlT2D3Wa80wrG4nKnkka7rlW?=
 =?us-ascii?Q?PLbiEQUnoLu+Ou5qF7oAJJZ1m+1p01yde4HI9l5xvKUSooHXYoPFfeoRvH/5?=
 =?us-ascii?Q?Pdzx2YvoyfcjBHT4IhosuEAPT31uE6IYcNooSn8oTmqgz9nKYC4UZskfV4Hk?=
 =?us-ascii?Q?i3pJP7wHJeB02GF5cWWkVV3Ilz3vtb9JKu5mpDagLDzTBORJ0G+rhdruU9s+?=
 =?us-ascii?Q?8BOThQnb41XaTsFzlWixlrn0NWGFkOuKpy76xGBOiShKBnUOFWAVkWChGFRI?=
 =?us-ascii?Q?ceChCIaVOjAWJtIRON7xh3KBWhKP+VBOKPyfUM9sAU+sK1sO4pLPPkQVp9d2?=
 =?us-ascii?Q?kIlBMC+pGMLvZsb4yTa1ZIQQ8fDZmZaY4q4H07yx+AS+P6xmLASQoWz8UiAd?=
 =?us-ascii?Q?0yivDEX6P13OmLDQd5cFBc3oJI/a9MegDZKzZeZNHCx9nJLTxTbvhR8Pdg+G?=
 =?us-ascii?Q?a3TZTj9Pay3vaYb8wrMhVUNxtmNCaZB0dFkgwZgBSRx3PKMxKq+uf5X3ky77?=
 =?us-ascii?Q?Grf+q6vvUe3SJT43vvkAb0GR5K8DQf/+aroS0tof4Eg4iGrVHTms/lomeXKK?=
 =?us-ascii?Q?7E/+CXTgIYvyZv36l/Q9HM8+SH1h7HtmkoRfy3ldlS4fPwTs3qq5S4oUJCLj?=
 =?us-ascii?Q?1MN0CIZgYG4q+SJpuYR46EHukrBfvdd2LCDOPh+BRheJSz7gHjMAuQxKTnX3?=
 =?us-ascii?Q?tFaCcfZ/gGCUdCsQjXO8AuKzGJ+114DX0i7DAfwKcfthHM2H44DIMbSUwRqy?=
 =?us-ascii?Q?RYTScaSjci84/3qKgkrz5zP3F4j4nZBr/3vqnWP43/gU916GZkUIRkev4pk9?=
 =?us-ascii?Q?LrzRplz/LIs+wy86ClhxxJOvWJYkivVbU1e/2PXDAPwF3ESfGa9KOZFEb81O?=
 =?us-ascii?Q?/BT7qnN++nJg3nd3so/WVhwoJqMTepOXZTAijhqKgIRQ3fLT/GJf4xQYSWEz?=
 =?us-ascii?Q?nw/2T50rUQaIy3GGKXlQtv38mtLDENMpoNNOjJEu0wGo+k5WsfZO188l6SN+?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vywfcy1lTpPgz95M7gQbUV5F79WE92Tnzq92r/VShSfezt8UQ/ClqT9fsfzw6jGPp0QiYr6UA+ZNSvZiczBxftzWj6qNauPIfC/lXYpcH/mzFcAQgvO3mB8T3QgObojzT3lQAvxQvlWzpumJfaGnj9MZ7+7fU+rgbHWsCLF9EkzJ8theKj397rlgXzQgKTalRDRiPMwmcpqDcfOlKsoRUSfoqQ/DTgVvH564DE6Bh5luLZRyddTHQ54m/voNdnQeXn6XFBNvUskHsWPExjei7hzBj/1OdYket0EU5tqQSZ5R49tmXtHuojDEwl5Vi8u3qOiMe5+vnLaAkWoOom0Q+4OTD9iC0vcld+Sob8tVSFiIKKQhoHx9aoSE7EdsiPzcuFSMpI6w5uZYwjSNT0dhrGdM4MAt14MpZ/l558GMWtVMu6OaVzwvJqb1deI8ZfR369chMFOMZPxM0dsH37z5d5CvfJfZvVXtCq4+tfxLOEgnYRtKqm7HRtZ4dcwbXmcGiwUnag1IaC51GQ77oW9ZZRuCdp+GPVRroFOgykaq4PISiQl4aDl2adDZO9gKORyzGcRlqUUQJjsPCLGBc3hYZZy1sH3e9HrbJzVvR/R1vvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6e389-d9c6-42f1-bc42-08dc13151f9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 02:21:02.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsZhnBFgOhRQs3u9IbnIoLciPPBOXU17YmYAI7Ptb7JAguA9OT8Rd3cIA7v2Vynila/9ad5gYuxArMHFmTRSkgiyfZnAQyKGgpE21b6il5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_15,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=968 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120014
X-Proofpoint-GUID: yWpU9yXzRgewfb2SKcf17dezgBpQPBV8
X-Proofpoint-ORIG-GUID: yWpU9yXzRgewfb2SKcf17dezgBpQPBV8


Greg,

>> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
>> index 0c4bc42b55c2..3d3d139127ee 100644
>> --- a/drivers/scsi/scsi_error.c
>> +++ b/drivers/scsi/scsi_error.c
>> @@ -1069,6 +1069,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
>>  
>>  	scsi_log_send(scmd);
>>  	scmd->scsi_done = scsi_eh_done;
>> +	scmd->flags |= SCMD_LAST;
>>  
>>  	/*
>>  	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
>> @@ -2361,6 +2362,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
>>  	scsi_init_command(dev, scmd);
>>  	scmd->request = rq;
>>  	scmd->cmnd = scsi_req(rq)->cmd;
>> +	scmd->flags |= SCMD_LAST;
>>  
>>  	scmd->scsi_done		= scsi_reset_provider_done_command;
>>  	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
>
> Ok, I have now done this and will push out a -rc1 with these changes in
> it.

Yeah, no need to bring in all those PI updates with associated driver
changes just for this.

-- 
Martin K. Petersen	Oracle Linux Engineering

