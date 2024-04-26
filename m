Return-Path: <linux-kernel+bounces-159476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A698B2F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17281281DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2B78274;
	Fri, 26 Apr 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EfLIRM4h"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD522092
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102650; cv=fail; b=BHAJx9MZCRTTH/YLl1OBKHOdd5EO1Nom1+/AHHyH/fUNUPW7B1Nb2aIzAavsx/T5L8NP2LaclxLBlM6ZSiqfjBo4WjCRodbC6uOUbKT0+Cx8XwfC0SNdQHGTMD4nrbDRFDTRuJDrHPJyWd6cf4qp3SQmVgwtKaXfKlYt9a4ArbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102650; c=relaxed/simple;
	bh=SYbwQBDskPFXzqzjur2l4Uu/43E/8kc5LC6Ft0t4bhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6ywD246FA41S+fVXV0xFdRqnL+rrA1ABr8cVdsPcR2NcBKG1BmDfrA5g8l+vfzKBmJAujaKimLVnFXu78AYn8zNhyGSRTaHr9BNkCtMHDtx/uhs+qc6+aMhmW4FDOicDvlSkBYFwbpae6vIEKaB/sS+72P7/lxwrhZhur6B+yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EfLIRM4h; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQsU0IptGphJFNgAG5TwdwT6nIK1BXQEvByvJelSCN1Y/oVhqgv6x2F+cx37o69scsQg/72DlBpNeo9r/AhfreiLIa6TY9hQt3a3Tf5wIZcYVFa2xm6gCD+d3+U0EL1yzFWFMkxu1oHYWRCnydlV4tuGSh5JJVsgGzKq4w/C8LV846BvH9ff2P6tKoolYc9LJ2vp5fqWmPXjdihCgAwkctChQesW/MoRMdtXKUl4lTM9Zr3pf0GLVT/o7cPKRAkaopxu56FKSgkhzM+8ocbwfyfv8ZvZNLFlQkXGR/oWuOWlEksbKMWW7MWKqVI2obSyRhlIXrGlZR0Aj1OaI+y0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3It5Za4f/BNWLahYC3h0Q90Js/qNsq7N9daOvgKodU=;
 b=LjZ+Xq4U9BmuJI6Fc5bsCgRntFWv/ofcFWB9plq+sBCXk8WmM2EbrSu7u4znsjmIGp/cZYHIb/rCr1ei0B1JM5UmlGq4CcLDeIzM6Vp1zvNBNhITvfp8cScDfffxDq3ipn/O64E7oFuQsNX9Y0z2zvGrKLPUlACz86pch1YmSfv3eI24YbzUruw6nAZxmd++arPawDl82Tp58gyM7zqe1LMwkGNyoRGz4mRSaZXrwm3D0EYaj4cagXhPdkkPcsNWbh8izF5eiGF/wvTiG2zbioAby/5qwpZaN4kM1eYGTJXFl9SJwgFU5Hzk1sTr7FgKhUoK72CBHFx16okzIrJD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3It5Za4f/BNWLahYC3h0Q90Js/qNsq7N9daOvgKodU=;
 b=EfLIRM4hZ3OX7umriJkOKlykddQYu+9piFE+T36DLTf3LW7aAO4qhitN3KskYmzKd17Yw5s6GpOe6kZZCBAA0B7MW77qleYkdwnbFYC5QcEw1zOu6vuXIeeJTvejpDvfGftakYs4LsztfWCXyI72wXytRj6lkRzZ4zeYocMFEsJZ/7pDiqecK+nfahdWXLfJfa7pZceWi2E6jO2WKYExgBsX4frJkG0aXnn9hajts86MNVhZY0r4ccc+myDZs+F/k01DwmmuVmfL6RojuShbWuqRTBHPmxqQizR/l9MXcIzstuzC1QpbJSc9nin9m74r83wHcQvMulU/FSSt1UC3ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.46; Fri, 26 Apr 2024 03:37:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:37:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 23:37:23 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <FAE058F4-7D2A-4760-9D24-A7D931062200@nvidia.com>
In-Reply-To: <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
References: <20240425211136.486184-1-zi.yan@sent.com>
 <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com>
 <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
 <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com>
 <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_ECB5E141-0F73-4D0B-9FB3-41CA116DFACD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 724915f4-3535-4990-2186-08dc65a23073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmMvSXVQN1N3a2EvcVduRmRtUDJPWFlUcktZNlAxUFpXYVk0WS8wR1RjWkJX?=
 =?utf-8?B?OTVHVFREU0NLS2FuWVdGUGhFRE5NWUtHOGtZak84dkE1NzNJdHFmdW9nTVdy?=
 =?utf-8?B?VTVjKzJoNTI0YVhwdnlYUGlleXFhaml1UXBnbytnamh5RHFRS0RPVmlaVWtS?=
 =?utf-8?B?anFvMkVMZW5BeUJWMG5Hd0tKQTdSNHFjaThzY3pkWk1DWVNQNHV0MlBCVlpY?=
 =?utf-8?B?VGVpK3VObDhrZVd2Nzd6am9lTXZqVTBwa3NMNXNFajFlNW9pUG1QRStsejFo?=
 =?utf-8?B?OXRRV2dyVm5BSDM0SDZIVFhHUzFxbVZpdWZaRTllbEQ5UkZIRkVsNU1sK01L?=
 =?utf-8?B?Nk0yOGM5SjZlY1JGMGxud1c1ZEFHaFJUT3YvNXVRN2N4WEk3UW1YZXNxVjY0?=
 =?utf-8?B?N09PWnF3LzZpSEYrVm1iYlBvam5ZeFpITER0RTk2d3lVYk5oR0M0K1pPNUV5?=
 =?utf-8?B?dlF1S3NyMkRPRlVJZ1pLVjRuK3N2dlVCbTRwNDZSaW9JMUVUeFFTV3Z4ZHNG?=
 =?utf-8?B?dUVLZU5Hci9VcVUwZTJpMzdmQlpFb0sweW85RXBnc082bEVqVEJwU2o0bVJy?=
 =?utf-8?B?RFBYTzluTDNDc3M4ZWJ2R0JoWDJScm1pK3dGS2pybzFpdlRCZHBGNjQzWEVL?=
 =?utf-8?B?bDlZRnRSd2UzWkZpaEJSMDlYbkV0Q3RKOGhZT1RLNm1JYklxZDUvSTBpY1g1?=
 =?utf-8?B?SEh2ZVRNaDNZOVNwMm1KbkkzQ2tPS3ZnTXBtLytHY3haeEhJK0o2Qm9BQnA0?=
 =?utf-8?B?YWZURXBUUFd1MHZqaDJnbXVKMG4xd1FwYlVuUGJESUlJWkdOUTdKTjhSNFhG?=
 =?utf-8?B?c3FtM3p3R1Z0VjRTVFZ1STQxU0orRWtLaWlnQy95NjNBTjBncFh4MzZCem5O?=
 =?utf-8?B?TTlKNlQ3V0xMcUdMaVhjWkpoa2NIdm9oZU9mQmJES00vamtCbnAxeXJkR1hq?=
 =?utf-8?B?U3UzQ0U0Qjc3dUhYbjE5dysyU1FEVVpSS3J5RmpGb0dtbnpNMEZRM3RaS0VH?=
 =?utf-8?B?ZU5LbzhOcS9udi94TlZOZEY5UXRJZWVROHdtWTc4czBFVW1EcWk5MUhaZUJS?=
 =?utf-8?B?MlNyQVhxdEh5ckNybjc1M1QrVXk5d3dwQ3JQby9pTjk2YzNkNzlibkRqaE5a?=
 =?utf-8?B?UVUwRTBmZnh1d1k1amlDSDJ6VW1Jdkw0UWRlSXAxRnFkKzZUUTJlOFFZazE4?=
 =?utf-8?B?V2JySEFyZkRFMEdUb1BHUktBZkRGSitOLzhxczFJNFZ2VnJockRXZms2WHFs?=
 =?utf-8?B?eFNiOFY5dklWM0xhQzJTaGxCSlpZWGJDNVFFR0RNOER6S0xja2oxNnZaQUIz?=
 =?utf-8?B?ZkxuaTRnQitvUmNQWlg2MllBMk1KNWdyQmpIdW1OMnZBUW9Yc3Irbjc2aVNm?=
 =?utf-8?B?Z0l0UjZCcUR1M2pqbkVmV2hWVHpDWlFuZWJVNVFjK25mTHdQVlpnNy8xMDJZ?=
 =?utf-8?B?cGh1ZXZEK0hxVzNDS2hJNmFMRWl2RVo3cHpPcnA2Z09vbW80N0NXWndaelEw?=
 =?utf-8?B?WmhTa3BDUVBVL2doNFRtUGVFSEZzTTl1SmJxT3JGL0JGZ2R4clhNckpIa3Va?=
 =?utf-8?B?cEVJNzAyTGZhZ3dZQ1YvT3ZGdnpZK0FBOVNOalhoQnBWaHNiM2RGOHBaMHFp?=
 =?utf-8?B?eXZTdkRjWW90V08xWUNwWTQ5NTZzaW5yNDY5WFJRNEQvbGpFQklac0Z0Z1JV?=
 =?utf-8?B?akpjQ05Rb2FSNlFPUlc0dGZqeUx0SVN5UlpNelV3dUZyS0JMTHJVa1B3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDBvNmdxa2N0OWxFTExUT3QzbVJGWTZWWHl6bGlsMHc0bWN0WFlEUXYzVElE?=
 =?utf-8?B?emV2NGs0UVdBTlcvM3UwQ1ZGREVBcGF3bE12cUsvK0xWMDZ3dVNDVG5VLzV3?=
 =?utf-8?B?TzB0MUowSzFlWnkySWhORTV6aXIvbkdMVkY3U3lLK2ZwZUdWb2d5RFg2d05T?=
 =?utf-8?B?OWcxRjZoazNyd2xpNlN5dGFGVVFkSTMrdlQrcHdlOWptQUM3ang4WWNJMFVS?=
 =?utf-8?B?Um9LQmJwT3cvMmozMHg0Y3VsaFltRXZDTmwwN1pVd1ZnRkFZbUFmN3QybDNi?=
 =?utf-8?B?MG1Bd0lKeVBoM2lXeEpNVWdEcG5DR1lNSVVNYnRRMlRmcVNkelVhcGdyRUdT?=
 =?utf-8?B?UUFHM1p5cml1b3RXYUhldlhzY3BwUWRXSExldXlQbWdrZEIwc1FpTm42Z3ZF?=
 =?utf-8?B?QUxuKzlyWHVlK2VuOE9aRkdzdzBWdk4rMThBUjdXNGk3eG9ad1VTZVdyQk9r?=
 =?utf-8?B?dVZTTkNTUG8zdWRtTmhqYlE3K0dwRzR4RWdGMXhsVVdGU21zb3B6VjZ4N2R6?=
 =?utf-8?B?V05KQ3ZSQjRmZk5JbXlWV0hxV0h2S0EwQUtPajdteW5kY2xNa2ZQckNuV3E5?=
 =?utf-8?B?QXkvMUxsVSs1QTlQbFZCa2RielBscE9RRlVDUHZBR2I5cGVXR1pQUTBOclhk?=
 =?utf-8?B?SWtGWTExVWdiV0FXUjVvT2lGclArTHkrcnRWRFVnSlphNUZmWm5QVE0vZ2Mv?=
 =?utf-8?B?NXhTRVExaTRTNEFtN3g4WFFqakMxdXh4OVhRQXlSVS9mZTZXM1Z0Q2RDaDZr?=
 =?utf-8?B?UENXNzA3cktTbURSQWlDY3hDNFMwM0h5MjZQVG9VdFY0MG9adUtSem1KbXpZ?=
 =?utf-8?B?RE5LMEMwZnhlcXo3Qk16cTJlLzI3dEg0aWczcldBeUJtbHNUVktHRHF5VXQ1?=
 =?utf-8?B?WHFaNC9DLzNWcXZOa2xaRUNFd3dGajY0TjlBSWQvRDZGYXRkV0lQOEdPS0Qx?=
 =?utf-8?B?ZW9OZ3prcG52alhlZU1ISnZldTNGNEpPdXFTcDVMYnN2cTVscGNNcm9GQVo5?=
 =?utf-8?B?ZzdFQkFXeHladUtEV0VpbElKSktpcUJibkVhR3VUWllTMndhellMbmZWR2tF?=
 =?utf-8?B?aG5CdjFaQTFSK0dUNWdkc3JDVlZVaU1jUVpTVFNlTmpXc1JmOFF2cDNvUTNn?=
 =?utf-8?B?YzF2WHVyeTZiYmNoL1Ewem1ZWnlveHhtSlg3VFRyT0JndWNISUFWdEdNclZQ?=
 =?utf-8?B?N3JOVEpqZkVOQ1J2TWNzVVpZOFlMREVNSFFRTVBYZmkvVzBGZFVHR1lDMEtt?=
 =?utf-8?B?R2pYUHhqaDFwNDBNbG1McjVwU0JnbSt2MkRmQ2NlL0JpdE1VOE1RU1psbU95?=
 =?utf-8?B?MTU4N2ZnYmtVcys3UE5penFkd0tTSUFSbm5VZzBWOXZTS25GVXJCd3VGZ2JS?=
 =?utf-8?B?ZkZsK3oxcW9WRGxWZzdINEx5SDNIN2doZjJVODdoZjJHcVIyM0Qwa1Q2NEQ5?=
 =?utf-8?B?SjR3UEJySTdOZlFRZHppa1JuT2NqR1RKWlNUdDJ2YVZxTzl5cXZ3UzkyTXFO?=
 =?utf-8?B?M2E5alNLaWM5Tk1kWlpUVmNrWTVpNE5UQXB1L05yZGxVcEhUQ2piRnEwZlFk?=
 =?utf-8?B?N1lwQkVBa3U1aFFHUnlnYTZhR0xROTNITXRFVGg0U25UQ2hQU28zdW1yMFpW?=
 =?utf-8?B?dWFTeWVjRk1pV25RRC9nRVRSZ2pUQXRIS1ZGSE9TbGphVy95aEVwcnpWaU5B?=
 =?utf-8?B?OFNhZXhMbzJEL1Z2Q09yY3B3K0NGVDR5ei84ZFJDa3RRM0dVTDlYWUpMTHVh?=
 =?utf-8?B?N0NPa3RxWWthNFMyS2JpU2p6elpvN0VuVW5kelBHMGo5dHVac1lYK2FkQXpB?=
 =?utf-8?B?Wjg5cDI2YWVncWVudHBxYzArTUZBU2JJbTJQYldZcUpaakNoYzQ5ZGJTbFRZ?=
 =?utf-8?B?OEYyeEpOUSt6azd3RWJwdUUzRVJub00zZ1hxN3RrWWFsRjFhelFJNXpsdXZa?=
 =?utf-8?B?ajZDMzk5TjVQQ3lwZExBZlBHRHYwa3NoSHJ6ODcyUjhaK3ppTkhOQTBRTk01?=
 =?utf-8?B?VUpITHVWWktVa0tmNGxRWjV6VlI5NGJsb1dvWGRIVW82TWU3QVJqcmFObmZB?=
 =?utf-8?B?UC9IVmYrM0NPUHlqR0duVFkxWXRBeTRER1dscWVONStmbWtBdEhWTmpHK2lo?=
 =?utf-8?Q?hbh4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724915f4-3535-4990-2186-08dc65a23073
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:37:25.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHc1xT2uPClCYy4ES+bbR1uBNDcYukqd2K3rwnx28/+dhP4n7B+ewh9SlRgIWZhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

--=_MailMate_ECB5E141-0F73-4D0B-9FB3-41CA116DFACD_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 23:28, Barry Song wrote:

> On Fri, Apr 26, 2024 at 10:50=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:=

>>
>> On 25 Apr 2024, at 22:23, Barry Song wrote:
>>
>>> On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote=
:
>>>>
>>>> On 25 Apr 2024, at 21:45, Barry Song wrote:
>>>>
>>>>> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wr=
ote:
>>>>>>
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
>>>>>> if any page in a folio loses its final mapping. But it is possible=
 that
>>>>>> the folio is fully unmapped and adding it to deferred split list i=
s
>>>>>> unnecessary.
>>>>>>
>>>>>> For PMD-mapped THPs, that was not really an issue, because removin=
g the
>>>>>> last PMD mapping in the absence of PTE mappings would not have add=
ed the
>>>>>> folio to the deferred split queue.
>>>>>>
>>>>>> However, for PTE-mapped THPs, which are now more prominent due to =
mTHP,
>>>>>> they are always added to the deferred split queue. One side effect=

>>>>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio ca=
n be
>>>>>> unintentionally increased, making it look like there are many part=
ially
>>>>>> mapped folios -- although the whole folio is fully unmapped stepwi=
se.
>>>>>>
>>>>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped T=
HPs
>>>>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introd=
uce
>>>>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE=
-mapped
>>>>>> folio is unmapped in one go and can avoid being added to deferred =
split
>>>>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will s=
till be
>>>>>> noise when we cannot batch-unmap a complete PTE-mapped folio in on=
e go
>>>>>> -- or where this type of batching is not implemented yet, e.g., mi=
gration.
>>>>>>
>>>>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is chec=
ked
>>>>>> to tell if the whole folio is unmapped. If the folio is already on=

>>>>>> deferred split list, it will be skipped, too.
>>>>>>
>>>>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>>>>>> folio_test_pmd_mappable() for THP split statistics") tried to excl=
ude
>>>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it doe=
s not
>>>>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was s=
till
>>>>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAG=
E,
>>>>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>>>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappabl=
e().
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>>>>>> ---
>>>>>>  mm/rmap.c | 8 +++++---
>>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index a7913a454028..220ad8a83589 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_=
rmap(struct folio *folio,
>>>>>>                  * page of the folio is unmapped and at least one =
page
>>>>>>                  * is still mapped.
>>>>>>                  */
>>>>>> -               if (folio_test_large(folio) && folio_test_anon(fol=
io))
>>>>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr=
_pmdmapped)
>>>>>> -                               deferred_split_folio(folio);
>>>>>> +               if (folio_test_large(folio) && folio_test_anon(fol=
io) &&
>>>>>> +                   list_empty(&folio->_deferred_list) &&
>>>>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(m=
apped)) ||
>>>>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdma=
pped)))
>>>>>> +                       deferred_split_folio(folio);
>>>>>
>>>>> Hi Zi Yan,
>>>>> in case a mTHP is mapped by two processed (forked but not CoW yet),=
 if we
>>>>> unmap the whole folio by pte level in one process only, are we stil=
l adding this
>>>>> folio into deferred list?
>>>>
>>>> No. Because the mTHP is still fully mapped by the other process. In =
terms of code,
>>>> nr will be 0 in that case and this if condition is skipped. nr is on=
ly increased
>>>> from 0 when one of the subpages in the mTHP has no mapping, namely p=
age->_mapcount
>>>> becomes negative and last is true in the case RMAP_LEVEL_PTE.
>>>
>>> Ok. i see, so "last" won't be true?
>>>
>>> case RMAP_LEVEL_PTE:
>>> do {
>>> last =3D atomic_add_negative(-1, &page->_mapcount);
>>>    if (last && folio_test_large(folio)) {
>>>        last =3D atomic_dec_return_relaxed(mapped);
>>>        last =3D (last < ENTIRELY_MAPPED);
>>> }
>>>
>>> if (last)
>>>      nr++;
>>> } while (page++, --nr_pages > 0);
>>> break;
>>
>> Right, because for every subpage its corresponding
>> last =3D atomic_add_negative(-1, &page->_mapcount); is not true after =
the unmapping.2
>
> if a mTHP is mapped only by one process, and we unmap it entirely, we w=
ill
> get nr > 0, then we are executing adding it into deferred_list? so it s=
eems
> atomic_read(mapped) is preventing this case from adding deferred_list?

Yes, that is what this patch is doing. When a mTHP is mapped by one proce=
ss
and later unmapped fully, there is no need to add it to deferred_list.
The mTHP will be freed right afterwards.

>
> I wonder if  it is possible to fixup nr to 0 from the first place?
> for example
> /* we are doing an entire unmapping */
> if (page=3D=3D&folio->page && nr_pages =3D=3D  folio_nr_pages(folio))
> ...
>
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_ECB5E141-0F73-4D0B-9FB3-41CA116DFACD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrIXMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUws0QAKTk0U7kUCHz8q4ENBDkJyIM5YqxAVqHw67S
0G7CxpEp19f42CfsRahD36hKpD2FB1OazSfDzzng+dC0C0pcU23fV+FNhcFMRFhy
+DclrmKv4Q5HFY+fVl6+IHmAMDuhgaIa6lz6NMnFzhzyqRDS4Rji7M+3ZBO/4G1Q
jQ7fWoBGJXMxafHnKXjunZTdVEj3efcYgERdnoM/h+BJXPj6/1h5DO2NdAxHiA5u
92BPzf5sMKBvG+0SaQV8WPRAGhW+CjMKRXTKGHuYqC7WHHgtefmKkjw2Gk5XToBz
JVWB+3JXkuaS7qGtIr2lGq+c61WswA6XPtROuFVOyxrRUQv3+WdfLH4mnMIkVBVS
BWHSyuaNjZyV6FRZVbBztHdtjZ0vsPhpv8p973wnQSl26xZLVgnIMiuX0pc9kta6
6Mrj1wmaMVTrmBC9vCgUgThEFJX6qhhLF+kdtgFN/wCqiqtUlnKoCbZqv4gV34HP
fHiqMDcUcXfEJsLwj2nv49OkjfryTh7dqhFSmnCZgDdabvPosilectjFYG2VNHKt
vUnyBSFMwBnAkLxHT0HqCW7eOfy669ioU+pI77Lyom3HUXREqmXyc5GlEkkjKPlg
+rR04dhN9cLexaV3+3AAgxga/GA0guh/iU96rmNH6JhK8QSqz0rrSnUQGTsJAXmD
0fyvdx3n
=2Dzz
-----END PGP SIGNATURE-----

--=_MailMate_ECB5E141-0F73-4D0B-9FB3-41CA116DFACD_=--

