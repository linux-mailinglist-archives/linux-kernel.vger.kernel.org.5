Return-Path: <linux-kernel+bounces-76869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3285FDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E822B2216C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E714E2CB;
	Thu, 22 Feb 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8ndCatU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OnrtRbFG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02791B7E6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618967; cv=fail; b=njT3KCuIg6XJ6pbHi5TjmK8W9livQtLJVe59l1f48cRlpsRq4yoVpV6DJeSym9rqJd1fdgtAAxaGDcDEHs1yDGuWxNruj2+O/lGQcs072xSKvZoVzPDHjjCxYg6ErbwPl7DcDVgu21exp/dT/eXZMbebK/hcEJXbr5Fw3ZnOXe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618967; c=relaxed/simple;
	bh=r9LOkAlMyX0P/gUfAaiVzK1CtcGA1HtO27OTohT6Mrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eijMG0so4ecgx1i+brA0vppzMNtuTdOwKRRwX1tXPBu4byLsgZUxTtkxxAZ7lpPFOtHEZLCh9y++oAhQCul3yqzPYxkeVPLftvEbIJFYr4snrVYn96eNVmjSMWz5oQFWQTRVGGXr7iZYs9bU2W4bj0uW1df7+9vQE/IRprgZ/hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D8ndCatU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OnrtRbFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGLQ5N013954;
	Thu, 22 Feb 2024 16:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=V+IRwCL9YPu30JVcjBpopf3YjjQrSCUC+UrdiUHaxj8=;
 b=D8ndCatUJMdaXIBOh/eqca1bjxNpZpKybmx/VMP0cdxkfZfKLTQBFzRODI4i6NwxLE5p
 hl9Wipt1hgssOg8cQ17ftcKejAXGDhso4mKmRnSP3owFcCGmUDRxYXjGPvqWOUdLQqA4
 FhQIEHu6E0Ddwm/0LoGXdJHtR1o71d5b2cr5NnGojJ58aNjg+nAp7XSW4YHzPl7fh4hP
 BYfi4qlpBkI3oC3xR4nJmXi5n4+sFUaQaabbC8brNdw2LtoSmUH9hLX5AQa85LhtEUml
 62g25/7MytDDxhRKZmkZOPa9CZvKoHjpyeD5jp8FD+e2l78P5otOgfJmQz1gF9k98Oyo Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw4vrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 16:22:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MG8con035651;
	Thu, 22 Feb 2024 16:22:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8auecc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 16:22:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7z2MSpARk+hi669ZfCarue4qpYhWvPwWU/+PlSzML0XUHWGK5XO9Fdjb3Li2fNppuw5W3NYdXeRroNz0Dco/UcWqAdD7ziVB2JaKiQCGnVVi0/fnYwl62BEEhYUJLHZk92uU6+BtjEUleKiwlLib7106ZT3EeRLSrw7SJZEVTaF1hu6eGWOmc+7FCyIFL8WGTlUZ7IYXb6iA07GDxX5uRevecyThclU0Dmh+jqf+9J8C0WBa1Vi/4knd7jxVP5q8gBnYDWw6ZISSr8eZzoL2zbRQxV3n6Pq55bvYahA+4QId2vdJ2VFw9uy0/Z1kzOr2b7sFivcyJt7OiPiyxuZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+IRwCL9YPu30JVcjBpopf3YjjQrSCUC+UrdiUHaxj8=;
 b=Za5LB1jNhNwIVZd/9+geb+cLt46GZVj+MhMmqB/7jZYQ9M1ufOi1obgHQ6tqQKaHiLntXYIbeO34eVswPCc2j95QqpjGO0WS1t0g90GoKxBlK+tSlhrzejfjR+Nh2629NPZsMbQzkCZ2yHdkTgHfFXrYTYTHmzXBIN4zS+U1ho4QUyOzAmYJeLr33vGS0bV2KMM+ZN3I4BLMesJ7iKE5UjcEBAx2TyaCBwtZhxAd8FhP0FASI1yocIGBtFUPccolwTSy0NEXjsqHgVWuD5eqH2gHuM8fhSizpHJE9N69EAM4bQfGbq5AVOnkNHm0xNS2pvhSu89GyJqJgKLpHDQfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+IRwCL9YPu30JVcjBpopf3YjjQrSCUC+UrdiUHaxj8=;
 b=OnrtRbFG35tQ1NH0CH7h4zuVwUpRYsDK8S8coorP22hTFLhYoElFzh7XwbX99Zzy8dzMXVAh0gQbhguUVaf7QYN1JmjWXTW7gippqB/EJQwjWjoOyx9iHfryFTFyEDWiBoA9gpIfZdsJr6uUjlIn6XUq4EDFioO+21hYtRoGtGw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 16:22:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 16:22:24 +0000
Date: Thu, 22 Feb 2024 11:22:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, lstoakes@gmail.com
Subject: Re: [PATCH] mm/mmap: remove the mm parameter in vma_complete()
Message-ID: <20240222162222.d7imwzuqpreilr6u@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	lstoakes@gmail.com
References: <20240129075305.3512138-1-yajun.deng@linux.dev>
 <20240129150417.3m6jyj3ftdh6ka7x@revolver>
 <7229eb6e-bf3e-fa97-6709-6c92bc72443b@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7229eb6e-bf3e-fa97-6709-6c92bc72443b@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a7823e-9d0e-4c28-1311-08dc33c2741a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Sj0nrEDHVCzvZzNbuYmRWE/PG+QgmONZUAOM05/pMsdLpecBh4GFXWAqMg7OBueN4vID2Ay7RJyOlwXQqk7kpHBGW0oNEb1ZMtLYpU/HPbio97ijEPVg8LYHSY4ERoibuX80EmyzSLPcDLBgQnvxLTYWXD6ENXus1WzthgSpJJgL+J8zyg1IJrDvZsWJnh2kiomA2DOOGxjpF+3Z2NYEV5gzReVVC4pltcfn7rp3OsLNB7TFVqI60PRv7zzmTVfNaU1ur4I7oWOFeW9e0DrEme6tqoysohnYaSBL0kUqb53T3hGTYd7zufOt4aXH+B1mOy/+PEaavv5qe2b4yACngf9KLEy6UpVB4wJpHc242FgWE5MKnQskhI1KhCEUXx34PLL9wejCer9zzx232pozXwcfbmLdu1RX8A9nGeHtEM8tMyVRSHI8DGNSpPQ7GAPVXO7ufmA4sGwPGchrcNsuF2bZlAXfOHhYyC8vnuzWzTugPTAStOo2t3/kFek9BmAGKM6qt+udznD5WlGYSv4QbinDBqQEEzOJHEVU5YFuV5E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?5Xrx2Eig+Gts+VGMzUpYfF8HEvvBEsywacz3XYBTJcGRKzDQmR0Q0KuaGX?=
 =?iso-8859-1?Q?kCyUil4EqTGTEJJatt95kao1b14hQAdvARz7MNP4ryTAHlfFY0sEPTCPJw?=
 =?iso-8859-1?Q?KxKgqqxbNMEbU6wwSSuEnbvBmrQCln6aDP7XAP1BhtZ/TsTY7Ja8f2tIUi?=
 =?iso-8859-1?Q?JlK+GjNc3uICMWgkDVhwNn/whn6OPATvm9VnjdyV/GO3YMR+5RiVc9Jy/d?=
 =?iso-8859-1?Q?2RJXLHmiiEp0c6gPUfj7Ss22LoxjS5653AhYTA2pLjRcJSHTBAJpP223CO?=
 =?iso-8859-1?Q?zcOVlAcdVsrmMPHsst0ndj8p3FO5rfiywgd0vSIdEaPIPg6C49muTPSmEK?=
 =?iso-8859-1?Q?NywjsQv7SKdCBx27/HgkUqtbKqGTN3kGjvYJ4zzn7A2CmFkuuQQ6FSSwUu?=
 =?iso-8859-1?Q?c4ImTezi7bkAORYhcZfHtD5Eq0Em6dkmigHvVYS7QHzvYiHDrMhsZ0dYFU?=
 =?iso-8859-1?Q?jC2yCQrXlbJarOgbXqVq+ZXrxu8u8fm2RkHdsY5TE6WAsyZhp3roAAZTmo?=
 =?iso-8859-1?Q?2wP7Skwrq5/AeKY1hkdre/+RZNtt81CIVbKnJjtA731uh9Pt7+JqQ0l8im?=
 =?iso-8859-1?Q?W5w7aRvfSi8g2hdxLcjmqGiAvxD+fnwMFbWftsIyrVuAigCNdaFKRNaHwu?=
 =?iso-8859-1?Q?rsOgNbaALOHI8Kf6F/xy5j7jOadUJIKlpsEqbVluwM3uF+43LdzPnr+gph?=
 =?iso-8859-1?Q?yo1WIkKT5DS0MLCDv21jLEnArwfPWIOEinp8Vkj7xB2dMyZJxH3JRtrurP?=
 =?iso-8859-1?Q?auhEKaU5yu+qPDn8Ejfach0azQ2Vs+FTUR0u+M1/DyUgZNLh+eRPRHENSB?=
 =?iso-8859-1?Q?HcHylXM7dzX2NLT//7oTYVPvPGOE8vJNP8DkUZsvVs6sIGxD68BhFvzVQk?=
 =?iso-8859-1?Q?j3BoBVvwE0wp/Jidjdkm+t2VB9LYU9gWQwdPvGxQm0YVyfmNhlyh/XVJkN?=
 =?iso-8859-1?Q?tW0vRZ1gMkdxQiZvcV5gWwMhA2TE7C7QyyPEa+ymatqPjpHizAnlFsjw4/?=
 =?iso-8859-1?Q?mDj3u8qeBLIwMz3Nxk+itcDerdSHnFnVC5omQ8I3256zeRZH+cJHt9tqc1?=
 =?iso-8859-1?Q?nfD4YWLyoooUg2NG9BXBooq1kIIcWAnil2yFr674vZTHEtkAXXF2FSkIvW?=
 =?iso-8859-1?Q?3xHuEZ0s6o6jo0wnzhfUdb0oncvBHxTo5gudmAvsccBwj1zM1JT51hrV4K?=
 =?iso-8859-1?Q?+jb0bjQIvchQk21PpfSK1OJgjXctpXxyuH29A/8fMucI4bwg9tWPQ40QRC?=
 =?iso-8859-1?Q?UIt9VfeqNI9n6OG52HpXeEnoNlwggTkNVsa17qBJAbYadmVgqVtTC+aeZ+?=
 =?iso-8859-1?Q?vr4/tPIMwf/Yg/E7do0ZLoeSwbhI7nC2qHF+w0KsBpW2fN6z93B3FGd8Qc?=
 =?iso-8859-1?Q?c7Y7tL3Fsypunl4Ff2bk8MzDsJImOVBfnPc9nBIpxIcBBxbcPKkcMOeFr2?=
 =?iso-8859-1?Q?Yulem79dlFo/xoXsmlL7q1xd19mR5NIbne9hPvDpHzJR+vJKfRe9EtK5vq?=
 =?iso-8859-1?Q?TOiGoj6WwBXLDAJ2Xqqbi68TPnNJlYbNOu4nPoo6Nwr7phnfZjVJLUrqQ6?=
 =?iso-8859-1?Q?uzhiBrXaTud7maW+28YSe0HlZk/QboEaytBR1HZPn+EkCYiGv6qNVL370F?=
 =?iso-8859-1?Q?bumiV0Va2FDz/YM06tNSdi6EGalcO2tBzq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Jy/hojBkUUU2pnD48GnmCvIqsKrIiJI4xDAN1bREndIkpJ9B5G6hER/iFwerf/Ifz0cCLQ2H+F4vOMV2aGyMM6yPCeV+70BCtBRI8FF6agJpoefU0gp/tgLdtZRX0y2j2fHjbuTa+uel3L6OuABZM96Kx3KBwvT0UuyhxBM/4VjhOMyS0cw2LRS3oHuviFQ1HMDZMnE0iLvfXkwq6AXWfVGTKyng3bkurlfzWUtp8o2Mw31zJVlYLdSoZP7ZrST4gcyMIjZ4tMaCbMaFnIkQ3dheO7Cr1n83R5HzPjo3gLpWR93ROXNksLNTwgMUF13xURYBvsUIb1ftqWnj4z6L6fDhD73U6o62hwaQo0fezbMBv4lQjHS9UrSsHtLH7gugLVwHZbxJbuNBgsuYzIv6455Eb6ARW4E+ko6KzcE04Ds4EGSbNBXyiXi4s8/DHcdVBQp183eXGTKv1y81FOTe7Ycv2509sfhtOtsg/Ac9roBH6gqwXLro/70+n5idtRb7vvqKf/AU8z1b//hkcWm26oqZxub4VS3xk9j8CzC7NBGMdKfA2ciS8FPPtN7mnlCrF0XXcSO1q8yqhQ2KcJNodnbnPDDm5JIyU2Z0+FynKLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a7823e-9d0e-4c28-1311-08dc33c2741a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:22:24.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faGknZ1PCVCNioFj54ntPwfUc2pNIWvSW3TC6Sq3yDfMInig7aLv5bmQoNRO0NOEjXYJkoKP1+UG73uB9FRsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_12,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=788 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220129
X-Proofpoint-GUID: xzVFQ15E4yj-VbUvWvRONPSFTByWtm0r
X-Proofpoint-ORIG-GUID: xzVFQ15E4yj-VbUvWvRONPSFTByWtm0r

* Yajun Deng <yajun.deng@linux.dev> [240222 05:26]:
> Adding Vlastimil and Lorenzo to discuss this patch.
>=20
>=20
> On 2024/1/29 23:04, Liam R. Howlett wrote:
> > * Yajun Deng <yajun.deng@linux.dev> [240129 02:53]:
> > > There are vma_merge() and do_brk_flags() pass mm to vma_complete(), o=
thers
> > > would pass the vma->vm_mm. The following explains that the mm is the
> > > vma->vm_mm in vma_merge() and do_brk_flags().
> > >=20
> > > All vma will point to the same mm struct if the vma_merge() is succes=
sful.
> > > So the mm and the vma->mm are the same.
> > Absolutely, they must be the same.  I don't think vma_merge() checks
> > this, but it is true.
> >=20
> > > vm_brk_flags() and brk syscall will initialize vmi with current->mm,
> > > so the vma->vm_mm and the current->mm are the same if vma exists in
> > > do_brk_flags().
> > >=20
> > > Remove the mm parameter in vma_complete() and get mm from the vma in =
vp.
> > You have added a dereference to the two paths that don't need it to
> > reduce the argument list from 3 to 2.  It's the same number of lines as
> > well.  vma_shrink() is only used on process creation, but brk is more
> > common.  Note that this function is marked as inline.
> >=20
> > I'm not sure this change is worth making.
>=20
> If we can make sure the mm is=A0 vma->vm_mm, I don't think we need to pas=
s the
> mm.
>=20
> If we can't make sure that, this change is not worth it.

We can be quite confident the mm struct is the same.  The point is that
you are causing more instructions for zero gain.  There isn't a lot of
arguments and this is marked inline.  For most of the cases, we are
already causing 1/2 the dereferences you are moving - except
brk_flags(), which already has the pointer available.  But instead of
using the pointer already in a register, you are adding two new
dereferences inside an inline function.

This is like writing:

struct mm_struct *mm =3D current->mm;
struct vm_area_stuuct *vma =3D find_vma(mm, 0);

..

use_the_mm(vma->vm_mm);

. only it's worse than that because the compiler will replace
use_the_mm() with the actual code in use_the_mm(), so we have
effectively told the compiler to set another register up by
dereferencing twice instead of using the value already available.

It's a change for the sake of changing.

You are not reducing the code size, you are not increasing the
readability.  You are adding two dereferences to brk() and one to all
other callers.  Why do this change?

>=20
> > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > ---
> > >   mm/mmap.c | 16 ++++++++--------
> > >   1 file changed, 8 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index e97b9144c61a..9b968d1edf55 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -509,11 +509,11 @@ static inline void vma_prepare(struct vma_prepa=
re *vp)
> > >    *
> > >    * @vp: The vma_prepare struct
> > >    * @vmi: The vma iterator
> > > - * @mm: The mm_struct
> > >    */
> > > -static inline void vma_complete(struct vma_prepare *vp,
> > > -				struct vma_iterator *vmi, struct mm_struct *mm)
> > > +static inline void vma_complete(struct vma_prepare *vp, struct vma_i=
terator *vmi)
> > >   {
> > > +	struct mm_struct *mm =3D vp->vma->vm_mm;
> > > +
> > >   	if (vp->file) {
> > >   		if (vp->adj_next)
> > >   			vma_interval_tree_insert(vp->adj_next,
> > > @@ -666,7 +666,7 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >   	vma_set_range(vma, start, end, pgoff);
> > >   	vma_iter_store(vmi, vma);
> > > -	vma_complete(&vp, vmi, vma->vm_mm);
> > > +	vma_complete(&vp, vmi);
> > >   	return 0;
> > >   nomem:
> > > @@ -707,7 +707,7 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >   	vma_iter_clear(vmi);
> > >   	vma_set_range(vma, start, end, pgoff);
> > > -	vma_complete(&vp, vmi, vma->vm_mm);
> > > +	vma_complete(&vp, vmi);
> > >   	return 0;
> > >   }
> > > @@ -1030,7 +1030,7 @@ static struct vm_area_struct
> > >   		}
> > >   	}
> > > -	vma_complete(&vp, vmi, mm);
> > > +	vma_complete(&vp, vmi);
> > >   	khugepaged_enter_vma(res, vm_flags);
> > >   	return res;
> > > @@ -2377,7 +2377,7 @@ static int __split_vma(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
> > >   	}
> > >   	/* vma_complete stores the new vma */
> > > -	vma_complete(&vp, vmi, vma->vm_mm);
> > > +	vma_complete(&vp, vmi);
> > >   	/* Success. */
> > >   	if (new_below)
> > > @@ -3145,7 +3145,7 @@ static int do_brk_flags(struct vma_iterator *vm=
i, struct vm_area_struct *vma,
> > >   		vm_flags_set(vma, VM_SOFTDIRTY);
> > >   		vma_iter_store(vmi, vma);
> > > -		vma_complete(&vp, vmi, mm);
> > > +		vma_complete(&vp, vmi);
> > >   		khugepaged_enter_vma(vma, flags);
> > >   		goto out;
> > >   	}
> > > --=20
> > > 2.25.1
> > >=20
> > >=20

