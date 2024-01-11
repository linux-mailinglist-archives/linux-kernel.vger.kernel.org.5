Return-Path: <linux-kernel+bounces-23921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DE82B3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B191F231A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0551C52;
	Thu, 11 Jan 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jJoSfkIB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="exfP2brX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A24F8B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BHItMc002377;
	Thu, 11 Jan 2024 17:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ONZ5GPSLssck1vsP+nkK9bXrG8W0pXJoXdp569HMPZo=;
 b=jJoSfkIBYsiCvRy4aQcAisbVluSMFt4q+yKFOUs9rBuzLN+jb724BeI9AlWs5y1p6Sij
 TXPO9PV1ruqaahdjba8e/VXfM5xaphPiGNSGPQangFwEdRNUvTIxNvrgHsUFqVmo0eLB
 GMZI7hDWMzY1n8KaMLulVoM5N7ZSesS4xTFNToZVGAsyypfsQQMLH4msVASjMl+wXFKU
 cQuDDV5MF3b+F4zkJBgkZupL4qUREHfg8P1sHxOOilvtupx83XIwXEX/yo7V+jtjOmq4
 09pXn+Jg5jolX86XY3qC0k9mnTxZQIQmFlWuz+SNKWdmLmSmFpB2C7EzJpkTgN94pkGN 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj5k9srna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:20:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGneJn035052;
	Thu, 11 Jan 2024 17:20:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu7yqsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCBkMkg4/hwRBjI6U9K3kx7Zs96Q4rHwVoQohwlkEoBSt2uSSn42pA89PmwM+B63TBiZAlQRNv1lUDlMGeJxhXcjoRPJl5vBV9cWDn3gnqrQFhO2e3eJWOuc7N1XzGs/7vevVeR905bpOA4n9UoiNdfxEeEteYemCREojkONyKDTJnqkehBHE926WPtgOxJpV963FXeY0Tr/8kI3qAhPHGMZFaEu0i1E4a4ibOcx+3+yLsPgpJQfp/WBdjkrtBljJsdNpsr41BkbHe2rno1X4qjp2vvDfQsCO5mA1NhN3xceW5i+OM2fi4rUOHkvUjG7SuLkJwG2iQhr/ErXf80sBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONZ5GPSLssck1vsP+nkK9bXrG8W0pXJoXdp569HMPZo=;
 b=K8NT/WPARxASIPTjdz/qtOoiAaacR8BdPafKaUOCFxom+s5gjVv6Ulio61haaNu8HUvk0L05FbgeFN5TGLSiWuFvyJCQ+0C4sELmmYLYcElM99iy8IicxfhzuSVaLsmhk+dgN55RRwbvZeyDWiBavMufB6Vml+FGYxkso/b+cxGx9H54J3yYxennrs7EIGjhOYQq4Tz0+yHfFU9Yz7sQom1xzpNPRJVBhAW37LLDgt6WpQDCrTqG3KDUsucJtPef9/DSEUmRuDuleu7kt0lWthQc8djaeL16UtK26kw5WwNJRd44kDxRhOmOgqNggrYgNsr3gNmxfU0FUJZwxcXaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONZ5GPSLssck1vsP+nkK9bXrG8W0pXJoXdp569HMPZo=;
 b=exfP2brXtWXbT9jjhiaQVHndooBZUWbyG8Xm2B4LPjlS9KcWJ9DXbow0WCSbgvHwLHv6uqmngvMN5izgD6HiPhJw8BG4OsGWAxVJsLVMZ1P0fH2rCiwAEamf6Ure+qZ0HkaV78dvQn+VX7ZgjI99qFa4vvG5CWKkZCP3a1iqgnA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 17:20:03 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 17:20:03 +0000
Message-ID: <ffc2e727-8fa7-4ead-aa3f-c0a9f01a1c7c@oracle.com>
Date: Thu, 11 Jan 2024 11:20:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        luto@kernel.org, mst@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <000000000000a41b82060e875721@google.com>
 <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
 <87frz5184q.fsf@email.froward.int.ebiederm.org>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87frz5184q.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DS7PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:8:2f::22) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b47895-df70-4f88-2e63-08dc12c98c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kpO/ZymZVyQ0eCLoKxmORpcOl5mzlp7C7c6ey9XrzHiqs5buxIq9JgBALLXr28rvmoBugq5gkafyZr3O2C2LNIKVVkzWMpeDUhkwZCXQCBvlqItd0KWaYcB2vFhsDwbGxsveb2JiF5BGCmA1G2q2acWWdiqkSWGTQZPeJX5KRtLcYJZmaIy4BE/Fve33r8D+6Zd3jDvC2GEuQFU6PpsYcS4ILqOR7UfALM0TKZiY4SmoujSqYWpEfou5i9qDc7dEkCa5Y5VaGq39vY2fBioRXJajlCyGEwc1Q/JZc7ICx7DDIv8vcN+GG0AZtQXvtFfr6QbNxgRP+RX5uMm/kfZrKjUdRML13NM4/2PtCascuaiY8wJjKDWvI6cLT0mHSNqHMDJoWOpmyk4/CUA46HmAgZZT7YIyHpcYTj+mpuE4lBpRKlCtn8O5e+c8zECs5C80nbQ66pf5lGJ/OEfgNtw34yfErnOlu3Q1LT85XLpkWWip/pI0j/ZQu0vi7m2Hby3DwvXnWrdjSAsAVaNlfeq1gvuOyMDTp6kxXvG09wApbqlmwEzzrf0RwGu3jzah5cxtwiGmiyIhWLiTUYMQO83ywwy7CQOgpo2jljM2FHU+m8ltGbOFDWPMIlmV+aZqYg2GXJgFNKqibiW1qGMcFVsZNzuSxjLhRS3D/QrnQzeifoOkjVf+YjdUi9fC2C3vpRo28PXja8QnWppY2c4i7rae7LmyzylSh8uwbB4s8TUs4frh0ee1O2JfVXO7RqBzJLyD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(36756003)(86362001)(31696002)(41300700001)(38100700002)(6486002)(7416002)(2616005)(26005)(4326008)(6512007)(66556008)(966005)(66476007)(478600001)(2906002)(316002)(66946007)(8936002)(6506007)(54906003)(110136005)(53546011)(8676002)(5660300002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NnJjQjFTK0NrY0h6bExyRUkyMjZDUFRhRnc3M0xBbkVNdjZTQld3N0JUOFJP?=
 =?utf-8?B?NE9waURGKzJoVk1vdS9oQks5WUVkOFVXM0loZGcyVXVsZkJBUDdXdjZkZ1pt?=
 =?utf-8?B?M2ovOTFEU3ZINjlPSmU4cEdKeWFpR1NLMG5PWFloTEppT0xSa1FldnVWYWtG?=
 =?utf-8?B?cmdhYmpiVmpEUzQxTzBVUFRjQXkrQTZsR0pFMFF1TEIzL1ZiZUk2MG9ndEI0?=
 =?utf-8?B?WHRpZmx2NXpmUTBrRHVGbDNiMUJ4Vjk4dHZvRVdKcHp5UUZGNVZGZ3lsT3Fv?=
 =?utf-8?B?YlNSSGN0dHJsMjFKcEZnSXlsaWhRNFBhWVJncktCZWVETWdTY0Y0dkRyQ1c3?=
 =?utf-8?B?am1seU9aUHl4Tm1qM2ZkQkRJNGZ4dDRMbi9zanFldk90VEVhV2R6T1VHUXIy?=
 =?utf-8?B?UjdmNi9NcStRNHk3RjVVbjJuTjdQdDBBOXVlcmRGNGpDUEh4VzFVeXZDU05w?=
 =?utf-8?B?NkNtSG54UjkyUzFiME1yNXp2Rnp5ME9aMzdaelMrNXBXUkRPeklUQThGdWxV?=
 =?utf-8?B?OFlpaHRGUkh1Yjh3R29OeXc1bHFQMTFaa0Fpb1dBQk9UYjI4Tk13UXFtRkM2?=
 =?utf-8?B?QkZoMDg0d0R1UCsrZ3FLZVRlUDRDTHMrNDZXcjNFa2k2WGtRMnVDYU5MaVBL?=
 =?utf-8?B?eWdhcVBMWXZrbkNVMVgzQ3gyejM0enJTUk5xVVdEQXhYMnd0dmRyQ1RsL0Zs?=
 =?utf-8?B?Z1dCaHBHOEU4Y3luZW1CdnYyMjFSbVN4NW8yU0Nra3JTb0ZnT0J6NGRxZ3pk?=
 =?utf-8?B?TkpkTXpLaGNQZk5zM2QrcGhCc0hvbStwN21ONVl2SjFiQ1hteW5GQ0NDTkpM?=
 =?utf-8?B?dlZBRlIzM3MxYlR5ZVZzR0dLdkhrZkxkeXRDaGhtWDRkcHI4Z05QSVpkcGdX?=
 =?utf-8?B?QjNUdklMdVg5ZjI1dkF1ZC84RmhWK09Ma2FWR0FuNk9RL2pxTWdEYXRRQ05T?=
 =?utf-8?B?YndNUThjZkk0Y3VvWXRhSCs2OHp3SG5nYU5PemoveVpJcmgyTXJnVDlxMFBq?=
 =?utf-8?B?SEVsUXdSK3RZSUZrWTlqcDRnckVheGpFUGZMOVh1czVvTFM2QlVSSlREUXh1?=
 =?utf-8?B?SFlyYU80aitTajF5ay9ESHZWTUlvU2JqRUdzYjk4eXRjSnEzMUdtTlgrS3NS?=
 =?utf-8?B?Qk52V2o4S2hNU2MrVjUyY2hEdTY2cG9NWGVZRnZIUlJaeUhwdmc3TGRMa1lp?=
 =?utf-8?B?dHBnUkswVFo0dlFxVVZrMUY5elpLd1Nyb2l0Q1pISTlJc09iMnlkVVZnQy9J?=
 =?utf-8?B?RmhGRm81clZXWEVUV0FsQ3hXakhhKytmUkk2VW5xVzBobW9DNnJwSFlzZE5s?=
 =?utf-8?B?bjFTa1lWMU1Zb20rWHZLL01BcEd2YVUxakp2WWVsb2x6WVBlVnljNm5BOGZr?=
 =?utf-8?B?M3owMThGWEQzRjNTWW96UVVnTXZLUTdwdDdkSTNSZDNvMCtISm14V0R0RTNo?=
 =?utf-8?B?ZC9IVkg3YVZBU0tDY0JrZUlKZ05KT2VWc0F1a21TeUxzaGg1N3J0aEE5K2Jo?=
 =?utf-8?B?aGlUaGxYMm9mSk1qdUZTQWlWN3dqKzdoaVR4TnJIVktrUUpKeHBGbWxEdXhD?=
 =?utf-8?B?ZVFyTm9kRkdQcW9XTGYzb1JCVWlUVlBoZm9YYVd6NTJqZDJBVmFRdXRZTFdw?=
 =?utf-8?B?VWdhZzc4SjJ2NnFjTXg5bTFtMERVNWhSeG1pd3Mzc0F2L1VNVXR6NHhRdTRH?=
 =?utf-8?B?aENYbnlraU5nSzRyc244d3E4a0RxYWk0TzJzVnlkYlBaaFpHZ2dIWTJ6VnUx?=
 =?utf-8?B?VTlIMmxoblFESWJoZkxGTWtXOWNzOGNKejdZMG1JVzBQVXBqcTVnQmUzU3pU?=
 =?utf-8?B?c2VxL0pYK1EraWh1Vng2c0Y4S2paenVaMGhCQWtMSUNBbTUxd1YvczExaFc1?=
 =?utf-8?B?T2J0UjNvT05JeVJYdjYxbHdCQldQb1paRVZTWS9GM1lncGk2R1FvTkQ5aldj?=
 =?utf-8?B?cGg2WXU2WldrNGFhRmgxcUlKUUE0S0RjY1kxMUYrWEd0UTZRSUxEaEFFbmRK?=
 =?utf-8?B?NTJvWU5jeCszSHZzUFg3LzF2aE1pRDJwQlRKRjRWNmppaFRjYUUwUm9pTmdL?=
 =?utf-8?B?QUMxT0RRUUhUQi9XOTJGQTNxcnlEWExvbzUyY1Y4enVhcDZsUW5jK3JCaWNn?=
 =?utf-8?B?bC9FRjY0TGwwMlFRWXloMlIremJVaWdYSWFhRUNibmlqRnMxamJ6dWNIbWla?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mR0TVzwnOjaYlFxEbO7+UGR4KjbcsAadMQl8he1SNuy9qOTCcFGQnH1VEy53Z196r24FCz88BiJstV6sIx34X6ud1Cxd7SWODWiS3t+3I3M+wJquDIlHSj7G8Tp+2O8gs3bLEAMlSLbMEB3nTEaYChNcSBzgdGRQfb4eDQrR/6gOeJ8vNq193tdqjYTLfLWrSRAHpjD7HjIph30qnEnMEeaoxslX+1XxLoEkZ7ulCl0YG8ZL/sMvMEIxIVwT4NGzFzPuO6RhMxTf6hvi5RjDyxkhwA7QPfo9Jkf9prBSGh2y++PZ0ZMBq8O/yb5ydmqAV4a3WVnkVQKNY6U4LTI+gFawhXZaYmpzS54RjX4C7J/I2YDRV/2E9oSE3kFBUyT5a124XAaWZE2+F4XugtzW3o2IHal9otrXkNY6nmzmhX6dsc+56WaTklEjN8GxT2HNXiaYlwNBklww1ZX23sCOZ1s9SNBoQxFenpKhiwjtunfcfpDZCbuMaatg1c7SXZerLkvrQZplJg/oKWF8nFkYzZ+9K6TammqOPob7l0VSSDkIEYjKd5/MiJFkn3rWXKPXEF0nMBHBdOuI2q1AsSjQLkBQcQKZFsEWK/O/FMX8Zso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b47895-df70-4f88-2e63-08dc12c98c23
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:20:03.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdHApzKsPMY1tcWQAaFgMfSfQy0b0I0m0tCdUld9SbI2mFpvtVeQ5hXSFtidcMi1ZE0zF3ner5yOb5ASOlM/9uUubGBCN+RBz5VVksHZEk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110136
X-Proofpoint-GUID: dM5qnxoXtjNJNUEBv7BwsjVvA3WVnlmq
X-Proofpoint-ORIG-GUID: dM5qnxoXtjNJNUEBv7BwsjVvA3WVnlmq

On 1/10/24 10:11 AM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
>> Oleg/Eric, can you make any sense of this?
>>
>> On Tue, 9 Jan 2024 at 10:18, syzbot
>> <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com> wrote:
>>>
>>> The issue was bisected to:
>>>
>>> commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
>>
>> Hmm. This smells more like a "that triggers the problem" than a cause.
>>
>> Because the warning itself is
>>
>>> WARNING: CPU: 1 PID: 5069 at kernel/signal.c:771 signal_wake_up_state+0=
xfa/0x120 kernel/signal.c:771
>>
>> That's
>>
>>         lockdep_assert_held(&t->sighand->siglock);
>>
>> at the top of the function, with the call trace being
>>
>>>  signal_wake_up include/linux/sched/signal.h:448 [inline]
>>
>> just a wrapper setting 'state'.
>>
>>>  zap_process fs/coredump.c:373 [inline]
>>
>> That's zap_process() that does a
>>
>>         for_each_thread(start, t) {
>>
>> and then does a
>>
>>                         signal_wake_up(t, 1);
>>
>> on each thread.
>>
>>>  zap_threads fs/coredump.c:392 [inline]
>>
>> And this is zap_threads(), which does
>>
>>         spin_lock_irq(&tsk->sighand->siglock);
>>         ...
>>                 nr =3D zap_process(tsk, exit_code);
>>
>> Strange. The sighand->siglock is definitely taken.
>>
>> The for_each_thread() must be hitting a thread with a different
>> sighand, but it's basically a
>>
>>         list_for_each_entry_rcu(..)
>>
>> walking over the tsk->signal->thread_head list.
>>
>> But if CLONE_THREAD is set (so that we share that 'tsk->signal', then
>> we always require that CLONE_SIGHAND is also set:
>>
>>         if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAN=
D))
>>                 return ERR_PTR(-EINVAL);
>>
>> so we most definitely should have the same ->sighand if we have the
>> same ->signal. And that's true very much for that vhost_task_create()
>> case too.
>>
>> So as far as I can see, that bisected commit does add a new case of
>> threaded signal handling, but in no way explains the problem.
>>
>> Is there some odd exit race? The thread is removed with
>>
>>         list_del_rcu(&p->thread_node);
>>
>> in __exit_signal -> __unhash_process(), and despite the RCU
>> annotations, all these parts seem to hold the right locks too (ie
>> sighand->siglock is held by __exit_signal too), so I don't even see
>> any delayed de-allocation issue or anything like that.
>>
>> Thus bringing in Eric/Oleg to see if they see something I miss.
>=20
> I expect this would take going through the rest of the reproducer
> to see what is going on.
> Hmm.  The reproducer is in something other than C:
>=20
>> # https://syzkaller.appspot.com/bug?id=3Db7640dae2467568f05425b289a1f004=
faa2dc292
>> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
>> #{"repeat":true,"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"clo=
se_fds":false}
>> r0 =3D openat$vnet(0xffffffffffffff9c, &(0x7f0000000040), 0x2, 0x0)
>> ioctl$int_in(r0, 0x40000000af01, 0x0)
>> r1 =3D memfd_create(&(0x7f0000000400)=3D'\xa3\x9fn\xb4dR\x04i5\x02\xac\x=
ce\xe1\x88\x9d[@8\xd7\xce\x1f 9I\x7f\x15\x1d\x93=3D\xb5\xe7\\\'L\xe6\xd2\x8=
e\xbc)JtTDq\x81\xcf\x81\xba\xe51\xf5 \xc8\x10>\xc9\\\x85\x17L\xbf\xcf\x91\x=
dfM\xf3\x02^T*\x00\x02\xb9~B\x9f\xacl\x1d3\x06o\xf8\x16H\xaa*\x02\xf7\xfb\x=
06\xf1\x83\x92\xa8\xc2\xcb\xae\xb0\xb4\x93\xb8\x04\xf1\x99\xc2yY+\xd9y\x8a\=
xd5b\xe8\"q\x1b0)\xccm\xacz\xc1\xadd\x9b6a\xf3\xdds\xbb\x88\xff\b\x85\xb3s\=
x00\x0e\xbcfvi\x85\xfc.|\xd4h\xec\x82o\x8e\x93\x11\xc1\xd4\xae\x05\x17=3D\x=
d9R\xd0\xd4\x90\xcf\x9b\xdc\xaeV\x88\x94\x9f\xe3\xefqi\xed\xa8w\xbe\xd0\xd0=
-tBl\x9e+\xd3\xed\xce\x9f\x83\x86\xf9\x12\x16Ts\x80\x13]C\xfb`\xc2`\xf7\x1a=
\x00\x00\x00\x00\x00\x00\x00k\xae\xcb\x1a.\xc2\x8f\xd1x4]PZ\x9e\xd5Y\xf0L\x=
a4\xbc\x84\xf6\x04L\xff0\x8b\\*\xf9,\xb6\r\x97\xedy\xe0\x8a\xe2\x8ck\xc6S\x=
c3g\xb9\x1a\xf8\x8f \x9d\x00u7\xd8\'\xf1E\xa4(Q\x80Fy\xb5\xe4q\xc9\xff \xd8=
\x9d\xad\x11\xf8m\xd3\xbc\x9e\x10D\x7f!\xca\x0ev\x15h$\x01\xdd\xe5\xce\xf8*=
\xb3\x01\x85\a\xe4qv&\x9c\xac\x9aN~o\xe5\x89\xd5\a\x9f\f\x1f\xc2e/\x8d\x1e\=
n\xd0_\xbd!^\xa46\xb8j\xc0x\n\xdb\xe1\xa3\xd6\xae;\r\x92@\xa5I\x88Z1F\xf0\x=
1at\t\xd0\x8a\x04m\x06\xf3BL\xffS\x9eY\xf4\xb0U \xf8\xd00\x88y\xebX\x92\xd5=
\xbb\xa1h7\xf3\xe0\x0f\xbd\x02\xe4%\xf9\xb1\x87\x8aM\xfeG\xb2L\xbd\x92-\xcd=
\x1f\xf4\xe1,\xb7G|\xec\"\xa2\xab\xf6\x84\xe0\xcf1\x9a', 0x0)
>> write$binfmt_elf32(r1, &(0x7f0000000140)=3DANY=3D[@ANYBLOB=3D"7f454c4660=
00002ed8e4f97765ce27b90300060000000000000000b738000000000035f4c38422a3bc822=
0000500000004020300b300000000002a002400b3d7c52ebf31a8d5c8c3c6cb00000009e500=
d5ffffff05ffffff03004f9ef4"], 0xd8)
>> execveat(r1, &(0x7f0000000000)=3D'\x00', 0x0, 0x0, 0x1000)
>=20
> If I read that correctly it is intending to put an elf32 executable into
> a memfd and then execute it.
>=20
> Exec will possibly unshare SIGHAND struct if there is still a reference
> to it from somewhere else to ensure the new process has a clean one.
>=20
> But all of the other threads should get shutdown by de_thread before any
> of that happens.  And de_thread should take care of the weird non-leader
> execve case as well.  So after that point the process really should
> be single threaded.  Which is why de_thread is the point of no return.
>=20
> That whole interrupt comes in, and a fatal signal is processed
> scenario is confusing.
>=20
> Hmm.  That weird vnet ioctl at the beginning must be what is starting
> the vhost logic.  So I guess it makes sense if the signal is received
> by the magic vhost thread.
>=20
> Perhaps there is some weird vhost logic where the thread lingers.
>=20
> Ugh.  I seem to remember a whole conversation about the vhost logic
> (immediately after it was merged) and how it had a bug where it exited
> differently from everything else.  I remember people figuring it was

The vhost code just wanted to wait for running IO from the vhost thread
context before exiting instead of working like io_uring which would wait
from a secondary thread.

> immediately ok, after the code was merged, and because everything had to
> be performed as root, and no one actually uses the vhost logic like
> that.  It has been long enough I thought that would have been sorted
> out by now.
>=20
> Looking back to refresh my memory at the original conversation:
> https://lore.kernel.org/all/20230601183232.8384-1-michael.christie@oracle=
com/
>=20
> The bisect is 100% correct, and this was a known issue with that code at
> the time it was merged.
>=20

I have patches for this that I've been testing. Will post to the virt list
for the next feature window.



