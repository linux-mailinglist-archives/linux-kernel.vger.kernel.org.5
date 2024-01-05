Return-Path: <linux-kernel+bounces-17458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCD824D86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126B11F2315C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5546B8;
	Fri,  5 Jan 2024 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/jmwzOZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HPf7bbIL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD774403;
	Fri,  5 Jan 2024 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4053Z3jj018513;
	Fri, 5 Jan 2024 03:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Gvsz0PHyU7Idj9iNMoH04ItWBpc/MmOvfpL7mVt1ow4=;
 b=X/jmwzOZ/s60iSZliPP8wJu7OnyTRxtFHyikWcPQwQA29fohxtu81fhlHStr3qT2cVRL
 +ZAl+gsthYUw8Ff7Tj+q52+P0E4Gzhi7/RH/mU+Tt1UkhPcxEzVYSDkdu9OJW5bw616k
 qzhZZ0TH+id/yPuWEsckDHikYVXZAv5E3fo3rx33mVkd1Ba/lW+TBL12TMhQCbR+kCNg
 zNOW01sUmHCsZWR0QBaltysETrpYlFULs0cwbbZagsraROzBmMRTKw9GNkETcBkESlYX
 K6wNT0/MB2YzfhoHDucLosPhOyexYP/FB314VnciW1/PH1qZZVYI7T6yfZgofu722yLU Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ve9yur0n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 03:51:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4052dxKp037347;
	Fri, 5 Jan 2024 03:51:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ve27y3uhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 03:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/UEsaFBy9Yi0fzhbGc0kCpPorTC/BPDZWJOwAcGbmSFK6XTPvPW+e8gNhZd8lx1fkXUQqHNxnyVVTjX9xLTdya5l3bvYWEciHOFXSJ8+WiqxmYd/utwoJR2V0Z9uemLCASDTecjBf2CG/7AcKmdXI1ldQwN4nQAcHmFKd1FNQhtSolJqvjlvkwsYCT3pq6uK4LJyS9jT+ULHcZsTr0euk/b+QM4zVtvOzXxP74oNgaJuyovPZbQwN/YGxzDKq5/H08XkRdCI62WUoKs4aSMCRSMuBxZvOYasHzO67aVXgofGxU9xoJj00XpnxV7ndltjGqkYRrYwxJ2AcxLJ0kVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvsz0PHyU7Idj9iNMoH04ItWBpc/MmOvfpL7mVt1ow4=;
 b=H1bBaN0taAGYD4RdrtLfO6Iv4PY5aAZ2qXs1NJYMYXK5hPuxC3Pga7P6lA3ZuO+5wL/w5BBAy7gVp2GPxBMlfMWywlntycc8w6K0c5lFNHC/CjEmF8L8JLQIioJqFHLRqlyNrPc2IXK77sxHESyvxJbRK15OSmsSzsAgStXKOjVBNpZ2WfIWTqG7oQGhuF0zeXEBW4ardR7XSx0sC4Nd8Jrm8a6oN2VhD8uS/rjro6A1559wB2gflbRP1pBzgMVHTj6U2hqPhbHAm17p+xsrpWJ4P6jkVnf0nGkXFkSPCE3ujSQ8NFFTI+Bem7Lr75W2RaSYBwvhvNlLehiWmGUnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvsz0PHyU7Idj9iNMoH04ItWBpc/MmOvfpL7mVt1ow4=;
 b=HPf7bbILH7KweDKsP/lFjhaZNr74AoSONNPf0/rbR31YDcVhIaEHJuDFbfubM5FqyjfNMp0ny2q+fvleV2273rCU6TLExCAaWk4S0EKAUSOpuuDebAu2g7zu7jd4Q0FuCeeuDdhUP8NJE9PBqBprfWpVSNqN5LznNVR6FR5+y00=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 03:51:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 03:51:10 +0000
Date: Thu, 4 Jan 2024 22:51:07 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeff Layton <jlayton@kernel.org>, Jeffrey Layton <jlayton@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Message-ID: <ZZd8q4RSTTN/5wSq@tissot.1015granger.net>
References: <20240105110007.3f932561@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105110007.3f932561@canb.auug.org.au>
X-ClientProxiedBy: CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acc7595-e8b5-40e2-469b-08dc0da18de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5ns8JBTg3Z8qV0YY0SSf9FnogUbXpn2rO3rFluN0/kPwbeg1+xlO0ezuoIRqaiTKEAbjPXr/ApdWb+FiWBAQ+gTWShQhs/XxslV6SquvQ+KKuqg5O/CalDmpQGmdu8ds+j3dIKSUebXpUerUYXVwoqyL8VF7j/AT6f048gcOaB8C33Rmf9m1yK7w3+8BSh+XJLvMiAvLkjeks5DpNKq2ij/zOpVu6R9UeoRtuZdKM6LbWeHzs6z4m2fgtnMImHm+29FrfORVRSLk4sEg2FVyWPLC5aMK/WMy82vPFxFuyBk5JKKpwUD8wA4SRTJbCRxPNdeVjrvPgZO9E+LaRONDcJRKPQtTpnTXTysR23aqcxFJWUqdHvOjFhj35kO1nAFZsJ8ZNuB3Zu8EV7y3ZgkP8wpnvAVWz3zMSNjjrjTPC+q2XnPHdLqTfCSkVi9j2gpTvRdjplFJgL6phyeERjWlQUnjN+DUYv0a731x7r1LaSzVwG76X1hqFPOAh6Uq2zqdgu/eXrvZI8X+26t1DgT5enlUFRB5gOnyUa5AtRLgPBBPAtMB2u7bkpQo4dXM6Ini
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(6666004)(66556008)(316002)(66946007)(6916009)(86362001)(54906003)(478600001)(66476007)(6486002)(6506007)(6512007)(9686003)(38100700002)(8936002)(44832011)(5660300002)(8676002)(4326008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WAiiBcsff695FtE+QwZe3tblYGVkErFtoGOu2Oc6xDUkEUou8VDYGV0Ot3nQ?=
 =?us-ascii?Q?ctZCtSYUQ4djOqH1uBmUEF1bORloYluLQl6Z0thyNBD/r0k62zqUYUWbCCAb?=
 =?us-ascii?Q?7nMzWTUH5NcEH56hAqQKo/4PrEw2d2fRFUD0j1KP7/G9ATmRuDUPdnt4tHyb?=
 =?us-ascii?Q?3yOSQWBi3BRm9/ylsL00NOOUBDebr8JZXdhlhB0RCjCNqtPct5bFaMu55IlA?=
 =?us-ascii?Q?Do2ltVO5I8A4teVVbf5eSjS8Xhyok90SGIQboo43vVrPfIDw9Zn9Gqlibj8O?=
 =?us-ascii?Q?aDO97TTjYev+mmbMSbNqcRuR+WFeEzvm4pn0Q58POKeXBWokOustXSQcn3ls?=
 =?us-ascii?Q?ARjSWhf7X6UQtzIvCco0Jo9MlBXzSVrGRKzhb3sDTj/mjW+mCxywiVONlmbn?=
 =?us-ascii?Q?ZvWYymH5vX+urSs6OnfMNPa86HHrge/XwH9S4uHFsxoJ+hKYl1JF4ZELlzlp?=
 =?us-ascii?Q?2QhELiDlGCkwGUDlooq9S1K1sNAekxp0B3u2AcpFgnDNq54q5Z7w3VOu5vpW?=
 =?us-ascii?Q?zDgQcPTn5oo89VVFfxwQaG9NjD/PT3ZVjItT+Naea0Rt0gF1a6spMR9/qCvt?=
 =?us-ascii?Q?qnpKYY3lCrupwVTC5RyJuwnRVBYPXi1O8J1O01Y88f0b5TPi1e+d+CAwVZ5d?=
 =?us-ascii?Q?hOn9R9WksviejzvHHKBrYBT4w1xxvUnmMtX36DcZyjSQvEYBpmV9Hhci32Q4?=
 =?us-ascii?Q?jHnNHRtoLdwnrCnGsZj9c58/MbK6OkpjGZsCXyYelYii2v8PPOuyAmFEhHrI?=
 =?us-ascii?Q?CSt+kcc7zebR6N8BnYEUjQJBddTMaEq/mNASKBi+hvTQwWZF0uwiJtqCjXcJ?=
 =?us-ascii?Q?4D18/pUwoTo1R0ONsfAZ2EmkhOpbDyxvNWJeJ3UB84N3muQd9Gn99q//Eyyy?=
 =?us-ascii?Q?4pu1DFu4hUqdNtih/vRQiaIyziz2oK83ptST3b2FmVwRnOt5HABNGZ9MwzzG?=
 =?us-ascii?Q?oHpFZh0VaCRrQ4MZlgsyPMF2pe/oD5mPTln3lSeL2VTqqEueC1VmQrjj/CG1?=
 =?us-ascii?Q?W2bSZTLkeyGcDq4NhE+06XDfJJOlLZogRH+3VVWlMjcAiDMR8UnKKlsvEVNv?=
 =?us-ascii?Q?adufSQ98ZO7bTdW3juqcciwzeS3zrLdp/DjAb/adCyTog6kGqxfBe3orJJEd?=
 =?us-ascii?Q?AVfEy9SF75Ose1wmmstMGoW5ARDC59phXgigTeWlG6JFj7Bee1zqrIHdeIj9?=
 =?us-ascii?Q?LPAKXfuC/lT7ASBUXacbfmCJtkFmRQhBbt6N/EM85eeJEKqDlGVvhN4Waqhm?=
 =?us-ascii?Q?aaQgkA+2lDTbWA9vQ9eQiBAIC170X9h4pRkoX+IvNHbtJ2rBOzueAFpFyGoY?=
 =?us-ascii?Q?iacxSIAY1zG7JXhWOrJ0du64vYEFKgDTj3LpHGpZpTy1CQ81p1Ku74VQ3uIZ?=
 =?us-ascii?Q?jtsFollwJxczEuLThKlOjz31AtNpfz5SH/fzy80ag44C26pczqE2I9TjYMob?=
 =?us-ascii?Q?8bwYorjMf3mV4pksLrRuK2sdGMXssRcERvs6iCOI/kDHo+N8Ga3OTtc9iQ9f?=
 =?us-ascii?Q?uPJEvRt7lLX6wUrZ5dfUVOlB3OpArZ10xxWAseCLA+gUgxLOvvFPaZ4+l2Rw?=
 =?us-ascii?Q?0OpttxERnCdi3ErVgT7fOj/59D2F4ISpXKZdcDwmPE/AExTF4PlzAsVETcPa?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MczSasPFJrZyOLbmh41bCPBW5nDrzajCevS/kMs8/so1Sjz5vYD6aQQKYqwjO+KAr/hK6Ebj5JtoSTkCBUYeKMdFjGDyUG1fSS6PqXQjtzf+PtAsLycdnRsenPXvTeXNRjmVyk6Q3eU/eODMSRXXGCW4Fo/hzZrGITqLFBAgEhf09q+lqcOAeqAdZW/E87xDB0eCeuDQiCSYYOEG7iCFausn1KuPiVLUKVCJKg3QPjhuia/rjG9lNzRvJ54xbW1b4ab+UQUPX8PU+SqPxVAgEn7ZyI1yoKI+scI8mjC/NsTlr425/6FaLVhk0gNBmxRFUXOTLxwEXpv/7o0V00ScsWOXNXUBLDSNj5qIqiYj+gPPkICsFJNitX2tyrs7vPN9XUrHObQy2qdf/46OGUAkZT+Ldw3SJHk+P5AJAWuRZnQeWUalYZtLj2Qaxj3XH5Uef0fE9oZJyHDZyHfEZs4btQ8appMLbMvDHdHZd0/QMOSA5B2DyI6GevIt0TeVD05eSVyXVgk4JOiuPBqW8MVSZn6wOCdai2lKpN9leDo74frbD1nGNjQaRuSbICyIB7TepUb3bTdaz2MVfwx5uiU7S06lqzf3b1pGTEejjSmDDZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acc7595-e8b5-40e2-469b-08dc0da18de4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 03:51:10.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7y2koSCK7cJb2om9HZZd93vNKpwGhYmaeQfoYB/7SM/vpJZLV5ilDCBpdicKUyL5ldr/PWmtK6s/AV0rJ0IRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_15,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401050031
X-Proofpoint-ORIG-GUID: fGlyokNd9NbqZuXmn2fzUXk-YkpvqlUj
X-Proofpoint-GUID: fGlyokNd9NbqZuXmn2fzUXk-YkpvqlUj

On Fri, Jan 05, 2024 at 11:00:07AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the nfsd tree got a conflict in:
> 
>   fs/nfsd/nfsctl.c
> 
> between commit:
> 
>   76d296a82657 ("nfsd: drop the nfsd_put helper")
> 
> from the nfsd-fixes tree and commits:
> 
>   3a0b966ab40f ("SUNRPC: discard sv_refcnt, and svc_get/svc_put")
>   9bf4b41b79a3 ("nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()")
> 
> from the nfsd tree.

Ugh.

I plan to rebase nfsd-next as soon as 76d296a82657 ("nfsd: drop the
nfsd_put helper") is merged. I'll have a closer look at this
conflict tomorrow (my time).


> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/nfsd/nfsctl.c
> index 87fed75808ff,cca1dd7b8c55..000000000000
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@@ -704,15 -707,12 +708,12 @@@ static ssize_t __write_ports_addfd(cha
>   	if (err != 0)
>   		return err;
>   
>  -	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
>  +	serv = nn->nfsd_serv;
>  +	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
>   
> - 	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
> - 		nfsd_last_thread(net);
> - 	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> - 		svc_get(serv);
>  -	if (!nn->nfsd_serv->sv_nrthreads &&
>  -	    list_empty(&nn->nfsd_serv->sv_permsocks))
> ++	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
> + 		nfsd_destroy_serv(net);
>   
> - 	svc_put(serv);
>   	return err;
>   }
>   
> @@@ -750,22 -748,18 +751,17 @@@ static ssize_t __write_ports_addxprt(ch
>   	if (err < 0 && err != -EAFNOSUPPORT)
>   		goto out_close;
>   
> - 	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> - 		svc_get(serv);
> - 
> - 	svc_put(serv);
>   	return 0;
>   out_close:
>  -	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
>  +	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
>   	if (xprt != NULL) {
>   		svc_xprt_close(xprt);
>   		svc_xprt_put(xprt);
>   	}
>   out_err:
> - 	if (!serv->sv_nrthreads && !nn->keep_active)
> - 		nfsd_last_thread(net);
>  -	if (!nn->nfsd_serv->sv_nrthreads &&
>  -	    list_empty(&nn->nfsd_serv->sv_permsocks))
> ++	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
> + 		nfsd_destroy_serv(net);
>   
> - 	svc_put(serv);
>   	return err;
>   }
>   



-- 
Chuck Lever

