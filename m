Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405679895D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbjIHO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjIHO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:57:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA47D1BFA;
        Fri,  8 Sep 2023 07:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZqDCFJprmbF+E2VTnaZT3ajaztv5F5BYHWjWHEzxR24CjTuz909L+Y9knpCJUefkWYKNLouY+X4bFSNOmFUVc9sY0u72C6Cj4MyNBJ9S1wVxj3fDb9kdjJQjsKE7naXgh0N7DTTtt9/nOaFujaWhoH9Qi0NZAyxqSDp7vM08DyvhqSQ+8P+XRJL5fcucHLN4JafWdZdRnMZkrXWQHqoQ9oni6HqH455Vv3CtVdvVobkQ6Iyz2zIbY4zEnd/+w2AdVS7morYO2VEWvEvXx3gQTdt7x9mwaF/WqxrTzW9Q3KSPhf7cZjnxBlSwctx0X72nLgQmyDs2GXGKnhlyUtc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqweeBZyqCwgVl/oWc939OaQsYq5TVbGNQEcFelS6cs=;
 b=PkRCksouGP44r1EJMoSDq7gvxtVEYnyzMiXr34jEQl2jJcxQoos4D/N9mgBHF42ndAOqvLT/1XgktoenI9D/C0X9BRTqJssy3/Juxf0d+kI1ayLlcORQ4Z9YKmmNAnaaMcqmTVSzKHKmz6OsasrJI6BCxEh2Zhd34vbY6xDAU5j4gCbs6Cxgu9HXXTHgF83OkQQBTesqTOENHFheelQLP03u5/4GwLdO1EGugZqFeL61VLS6+27YtdJOpk1/SH/wi/QB7hWMMTEHsMDWL8nmGMHbB3tFVlfrZPUOffk7+FOnc8TGoPrHysV7C6/MrOt4c5wtSui4EXIAaUcrht4QzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqweeBZyqCwgVl/oWc939OaQsYq5TVbGNQEcFelS6cs=;
 b=mdWEFr90BUbv83hK+0S8QunhZGBqPd4c7z+raSUvCf8fINeaanzwSxJjD8/OCj8PvECx+tVB+2UjNycWChez3W2noqCFTXRzJuaEbaD9vpN5W5aD3fw+eMgbhl/rkX4lI5n0NhIscKSfZtG6JahbIDVR0ujGWN0fCvX+VjILxA5m8xfMdMbaZchufcnNLlG/2Swx3H9froPVcHONKLH9W/heSroT+RJ3vXSjpi7ts37EBOqSYKAxD973AYgxqwpRIKguBw59Uk/Q/6zlvp+P/9z1bgUV6DyiG0NIg8PeLnLva2d8T4Q9OhWN0DVH05Ck/46bxkw7Hn+cqLdDW8+2/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 14:56:49 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%6]) with mapi id 15.20.6745.020; Fri, 8 Sep 2023
 14:56:49 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     =?utf-8?q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>
Subject: Re: [PATCH v2 0/5] Use nth_page() in place of direct struct page
 manipulation
Date:   Fri, 08 Sep 2023 10:56:46 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <7122A099-A01A-4B49-8391-E070E661E4B7@nvidia.com>
In-Reply-To: <59cc930c-3efd-d31e-49c3-2778914ea9ae@linaro.org>
References: <20230906150309.114360-1-zi.yan@sent.com>
 <59cc930c-3efd-d31e-49c3-2778914ea9ae@linaro.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_AA0523F5-C1AD-42FD-B9CE-3340016FBD29_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:d4::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c22d56f-e591-482f-66e9-08dbb07bd460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy+Q5sZ+6fwm/wCkGNpDdvW+5U4Cn7kLyXUymbsW9mZEoLr2r0TovgWevugeRHLJHb1QMWzAYArujgRLK9Czm355M5G/cTBmS3RTtk6ta6ZTCdWcOqPsN9bzc55xPRXfXcZJamQC/JX/st9TZQckHAc70bAqqi1AJwxVokA9a0EYOmd9nN6eatmrzVFMsNfu5kvIFP3FA3+f94ncsEKlgR5szdBEZUFSd5pkUyAO61HrlkmfTtFznSA+A3XZ75hCrJ7Je/h3EoSiE8i4DgQlNh7ztPn5JJcXdyFKWxo6P6/MwnlSPO+1o1dsyY9WwmHPogYDGzwtunfrfPhH1Pyk18/oC68b7Ams4CEhT/R1XI5Ve+yI+xprncMmbX+4six+eBs0f5aUPPDNKsdNx3WbMXZBpKlFDyxZ4chJSRDOtH3+8DfOo8H2O2hqCnGpmFH+wzf12rCNimDVlqZDNMz1uFjY+GUu2LAcYT7puukrdtgojCFDBLtI54LF+v2CwR4gN1hl4qT86IYzhv04KzudFOlhJ0umr/tQLuLmyghTMVeE6i/1FqcNIlZRgjlVMh/ndSAWCQgwhoy5PA4AMI1vt10SUPw3KlBE8WFCJAHlkJOseOovsARUTItxDjvnP0dn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199024)(186009)(1800799009)(8936002)(4326008)(8676002)(478600001)(5660300002)(66476007)(66556008)(66946007)(83380400001)(7416002)(235185007)(2906002)(41300700001)(33656002)(54906003)(6916009)(316002)(86362001)(6666004)(6486002)(53546011)(33964004)(6506007)(6512007)(26005)(2616005)(38100700002)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXV1blhkWng3bkJUUndqZ2M2VnZ0cDYvTk5tL1hCTnoycm5USitxM0N1QkJi?=
 =?utf-8?B?YjkrditDRzhCYUdUbUthdk05R3dzTFpLQXRtakQ2a01ja0dJZGhoU000cjYy?=
 =?utf-8?B?K1hObFNFakhQL3EzSWpVbHNsWGhzbnJ2YVZaZDM0VjVqeHVFU29POVQ4M0sz?=
 =?utf-8?B?bTA3QitYbTNsSVBpMHNXUTAvS3BTOEV1eFBFREF5VEVVbnMwdjdFK24wWEc2?=
 =?utf-8?B?U2Y5TjFSRWFDV2xCVW5rb2JGSzBFbWNleDRXeUlxSmR2NE80S1dsZ0ZkdUJh?=
 =?utf-8?B?eEcrK2lLbGpLeElsbHBoRjdkMkJiRkZsdFg2NnlqS1ZlQmxtUnpYOEQweWd3?=
 =?utf-8?B?c3pMbWtaKytZZDI0TkdMVjZmRllLd05EK0N0WUhDam10YkZSL3IxckdyL1Rj?=
 =?utf-8?B?YW1LbVBTVkZUUVdJeE1lZHpvNzBzeFNwc29Tb05CZWFlelc5alFiL1N3bW1O?=
 =?utf-8?B?RVhGT1pUbm8xK25kVTRTd1Nhc1dRcFJudzhVR2VjVmZkbXBxNXdxcE9PaG5Q?=
 =?utf-8?B?MDJRZXhIQ3R0ZnRNTndXczhQMjdWV1ZXR0toejdwZXVKajVDejRTbnpwbkZB?=
 =?utf-8?B?Z1hramE1cDVhREZwSEZxdDRnZlVOUDdUK0VYNTNIZWxsVW56bGpXVXRpRmZ0?=
 =?utf-8?B?cmRSL0JnQktDTkdPZ1lONGJRaGl0ckxWQ1BWQmU0VzVGSnk4dGNUazEwVU5m?=
 =?utf-8?B?RjZMR1VNTTZFcDBEaWtKRDVJTWRENjZucVdmeTMvZ3FPQkRzblNxQ20zT1c3?=
 =?utf-8?B?K0NybnZBRWlMWDhKbUVRTUVUbDAxRFhYOTAyemdScGFlb0JoajFvWjRScDB2?=
 =?utf-8?B?UmM3NG1pSk5odUhaWDFqSmw1NmgvM2lyb3lhY1BLdkJpeHhwb2UzLzVUMlpV?=
 =?utf-8?B?dkc4c2pISTZxcDJIRTFuMUozZFdHWkRTVWtWeVN2a0NnWE14eGk1NXZOVm1r?=
 =?utf-8?B?aDlxRzBvZmNJS1htbmhTVEJ2aHR0Q2VNRHJQd0JJT3BMcDNsL3lQMkdZWVdF?=
 =?utf-8?B?bUhWUHpPblZPeHNJT3RhNTliRjVLUEl6dWtLVEVUSm1tUjUzd0YrYm02VFNF?=
 =?utf-8?B?cFFsT2NBZThtZlZoTmdpa1JZbFNNa3QwbzF1dndEdDF0cUtsaGVtMWd5bVFB?=
 =?utf-8?B?QUhZNjU5YWxFWkt3WkI1Z2dHRjFRc3Rxc2kzNnJDaU05aGtTbm9lSlM0M0hU?=
 =?utf-8?B?dTViSWJBUkdUUlozTGVNZXYvK0dKLzZuVzVyRVdLRjRqSlJTekozeGIwaTFP?=
 =?utf-8?B?STBzZHZKYklBOW91T0t5dmZ2R2x0Qk5rOFZvdHZLY1p2WUU0L1NoVU9qTy9p?=
 =?utf-8?B?TVJyK0l2ZHhWTmNGcG1aRGg1Nm5ZQlUvZXNCbWMydThRZkthUmoxdmdMZVVL?=
 =?utf-8?B?enJJSDdHZXpOQkxnN2E1MWpWNTFaUXE2V0JKWU15YW8wYzMzZmR3WFp0U3Vl?=
 =?utf-8?B?a3JzczRFNVZ0SWhVTHdxd1pleUxBcXhYbm16QjkxMDhaNk1qdmRmS1o3MUdP?=
 =?utf-8?B?cHFZM2c1a0FZQUNBRFQ3eDdCU0MvcFZYUVJkaTlyUFQ5UE5NU29nbGwxeVBx?=
 =?utf-8?B?bXBmQkZSdDZVUWVUNmRpS2lsei9QRWV5WGxEUXlBR2RiWXB2c2JwTElRYTJo?=
 =?utf-8?B?cVdVWm5GUTJXNDZheHJPRE5JNGVsNlNrZktwaWFYUFRYbW9teDRxRERONmhy?=
 =?utf-8?B?alBCcjdMMFNJL01FUmRYOE1PTzgyVzhONExicnNkUmFBSFdnUUlVdlhLNXZM?=
 =?utf-8?B?VDh3SGttbFplUy80NFdYK0FUS09BMUVGM0NQQmhOSVJxV2UzVWl6Ny81blA0?=
 =?utf-8?B?SWNTVnQ0Tk1OclhYbDVGOVd6aFpkajR0ZTI1dCsxaWRjRHNTQ214bjhuR2U5?=
 =?utf-8?B?SDE4M2liNUd0SlZodGtlbFEyRjc3ZG41MUo2TzlxYUVpL2pDWjM4QU5SUnZi?=
 =?utf-8?B?WWZUSnlKeTlOWnJkeVAvRFFWZHJlRVAvQ1ArY1kzRFJLSFcwcFhhSUhTbHBT?=
 =?utf-8?B?bHRZaFUvYnZqeCtPcmtLYkxmbnBJeUk3YksvdjNBMElGUENJMjNSc2tuQncv?=
 =?utf-8?B?c0MwRWNvMGd6TmhYMFlQSHYrL2oyb0VzWDh4UVpvUi9OdVBsa0IvZXkySGxo?=
 =?utf-8?Q?7lfE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c22d56f-e591-482f-66e9-08dbb07bd460
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 14:56:49.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHAOwEuoJ0UVmQfFH0r5mSLqzofIFRXe2nYeum/ZgbVIhxGAOVBkf65G7V9fDHgD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AA0523F5-C1AD-42FD-B9CE-3340016FBD29_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 Sep 2023, at 10:46, Philippe Mathieu-Daud=C3=A9 wrote:

> Hi,
>
> On 6/9/23 17:03, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> On SPARSEMEM without VMEMMAP, struct page is not guaranteed to be
>> contiguous, since each memory section's memmap might be allocated
>> independently. hugetlb pages can go beyond a memory section size, thus=

>> direct struct page manipulation on hugetlb pages/subpages might give
>> wrong struct page. Kernel provides nth_page() to do the manipulation
>> properly. Use that whenever code can see hugetlb pages.
>
> How can we notice "whenever code can see hugetlb pages"?
> From your series it seems you did a manual code audit, is that correct?=

> (I ask because I'm wondering about code scalability and catching other
> cases).

Anything allocated from buddy allocator should be free of this problem,
because MAX_ORDER is always smaller than a memory section size. This mean=
s
majority of kernel code should be fine. What is left is core mm code that=

can have a chance to touch hugetlb, like migration, memory compaction,
and of course hugetlb code. Yes, I did a manual code audit. And hopefully=

I caught all cases.

An alternative is to use nth_page() everywhere, but that is a very invasi=
ve
change for an uncommon config (SPARSEMEM + !VMEMMAP).


--
Best Regards,
Yan, Zi

--=_MailMate_AA0523F5-C1AD-42FD-B9CE-3340016FBD29_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT7Ni4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUou8P/i/mkxAu1soujT0vCSSZldBRsf2ABgcE0USs
QJWBxynHgvf2Pf49bvXJfC6DgFwNeM+iuOtQKzF2t9ayFya7rYzx24OmZyU7XIN6
QlfmkJur71vSEp+5fu72Zg7qfWQnpKIgf0+4LxnBMzf7TkUtnuqlmMuEOdYA2tPX
UyHblNFPt6WsyhwKnY4k6hZFDVNwWPm+DfZ0CHlYfPqTW3lLGgYPzPkMgtjIZ9k0
fxSkcTbngd4hVuhKthLrOno0qsKMt0sRqRqFhTXL48r3S2gSQl6+Ao9TP1bjxTnY
tUMsD+jojEszww1HfcVpZzZGZBbdE4hRMF4W7DVlxV+gXj9DlyzVL35NercZXaiG
jZN6BfRwPaANiIhCXmtPCWnm0HWmI8Q/xexbINPnxja2neut8qj79eA11Plls2yy
Xo4/Eh8SSBp3h9viLRXxcj/ROhfza7jB4rAt3OpudyEM4HLoqe4HdTsmaqPlquJ2
R20zTslNoY98WAIoWd1wS5VrTfprIbmed8Pug93l98lsZnfVm625aAiliyhmSiuD
M+uY9NInWVUQIwGKi6z3mNm1ei80dcOGKpVVRXd1XDJyKfqQYwJ48QkfpxRVJRcd
x9vzrsJv6MoUDfej34VXhM9JcEoEjPcdSJD5igue2AtSrCUvMv/l6Zt5mzFDDfal
ObQKhtkA
=yPBh
-----END PGP SIGNATURE-----

--=_MailMate_AA0523F5-C1AD-42FD-B9CE-3340016FBD29_=--
