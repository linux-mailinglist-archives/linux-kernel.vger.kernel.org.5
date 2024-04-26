Return-Path: <linux-kernel+bounces-160663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C788B40C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25B02838DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF82263E;
	Fri, 26 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j1cZvoO4"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02081DFED
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162967; cv=fail; b=mNrpmnBVD9mvweMtdiOXoasnJZJqDGpc1mZoQUkgJl+T2p2H/umwkh87DzXl3rpY/6wX1+AhHGhDvC8hp+RNlH/KrW8JOWYI9WVyajRDKXx44YMqOFsQ4R3msQbN/+kuwfOSxvnn5MPhnBByDy3in89TOBlXRYm0bKlr4S/LADY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162967; c=relaxed/simple;
	bh=J0crdw7hQpVNQ7Oxsus7jt8u+caMTt5MJhERQu90AmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFgB5SYY8KzwciqZ6szB3lY9J04hdztBL4C8nI97EwcEzhFXW/AaPJf2h+k6k5T1O5SGnzi8hcS0tfyVhRJj8h88139MvavkeqvbJ1P7WYPSmJS3cZG8NDg1ffUry9afXQO3+CYcV/ZqFeoWQ2NvxvrcnW/LS5T88Sgw3I9iMdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j1cZvoO4; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F19m2RCBlk+240N/z7bek1XiN4iKK3KV0iSPuzKwrr+ncDmfc2QGhWzJ2Rx8aHgDASgSdCSkTbOOwUJmJnC2bcn9DTDvZPLaAC+TmJVcM2Vw5Os5sX8vIUlOn4blHcOfyIjBS8qh1RkL5WlJZSCMRKvxzPVFnDYYYrT1tRgsH/pjN7AlePlt4VTLaJ138lbyFJ2hZCQYaHyTAWU0j7sw4apXwIBf8coldIpXL+27CgfAIjBjQBhDGgMS5PYS2j0xT30Gs5BmeIrLnfN2VrWQE6WpaipG05N2bwhdqrOBIx4bTD/Xp7hHwC4GlKg97qpvmX6oiT1N/EY/AwwalrsiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUQQDZewH1tjKSl2fGSR8+vD1Q8Ja2B3NPMapkI5JT4=;
 b=ZjHbv15kzfFxEq/cdju2QEpowTxPw13lh6VZboyOu1Wwdd/1nqBgO/T6OdqGw1bvBqG6ZPv9LU/r1MGOea/8HGWjGc0Ub4qZ0JJO7rZpZpyjLi7Zwc6/kg1+bV0O7oHk8cM0sjRh4A2XKIMjGmGO9M7eJrFKjH9pqBj7bzgw/obGJCVtaNnrz5VPySL74ooWsUIcYrve79VbJppzdxZDzcjgbqSj6nDJnVXMFKknu3qOEEWD2kkKnJkIbw6TTjnMNZaITqLGjrMJTGME8q9kUcKGqd46jxHwPwYdFE3OifrECdGcUnK0V0K9lPrht5q9sB4/lFUnLj2qYjAS9N6egA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUQQDZewH1tjKSl2fGSR8+vD1Q8Ja2B3NPMapkI5JT4=;
 b=j1cZvoO4HRyHtH56vl80Z0q3ipMxmAZ3aKKehWAdShTxrpL6u4FGLWIX2l3r+koAsgItdZxlu8z1ZqF6zkAl5fyTL1ltXCW8rf/T3gQG6QQvaRhgWFvoNOHjTfTmltxGPHDHKzcYbqG6rPnW1vhyxlrSmMz6Znoiwgo2sApA9QQnIbMs8N+JSN7vmHAXRt3xES3vMpslajCS8Tawhpyp9wmHa9m91OTK87c+/QtM/v4Fv3oYCqpRe1oumyzark9g2ynwfPQnYpUVSkiY821GEL4fM7pM+O0MZRzj6jMIv9VAIB75Tj3jQ0RpyTkDpTYs/UX807A+U8zAJypIYC5A7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 20:22:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 20:22:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 26 Apr 2024 16:22:38 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <AFA6A945-21AC-4665-A410-E906C7EB3EBF@nvidia.com>
In-Reply-To: <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
 <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
 <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
 <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_33548C9A-C040-4AF4-94DC-F7A4FE8A5C87_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 897da066-3f31-494a-a6b8-08dc662e9f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tIDGxzYdMqlZddSWQfwdFq+iuAwxidVplsBXp7U1nsIH2mJemDBCJLsYSx+?=
 =?us-ascii?Q?SHK2fYJP2iSzfuGg8jt+SDUFkBWJ+QDQ9DnDtrwPRRwQOjBJuFYo7sLhTV9C?=
 =?us-ascii?Q?SM85DDPMdaSGpVxQ7hKgPSH77bwjGn0Aac/afyIRbQu7C8O9PRpGsza/kMh6?=
 =?us-ascii?Q?5yUYrzmmXGVcf9c90B6cJil4ufLtxcNcPrQ48N0IyelFARfv2DtqYcSjlQXt?=
 =?us-ascii?Q?NGVK4OBpxnQzjFDbexgETQsm0fA10RSCOJO/w9qkIltUpa0hyjG8uWSgGqRK?=
 =?us-ascii?Q?gej7/oXBMAapiSUOdaqaHFWra75aM1sBPj3LbMGyiqdAtu3y+2JOb6mqg7iN?=
 =?us-ascii?Q?JBJ8Wy1yGzQgyIUq5aOer0Vubiy9/SqQEf8FgjRI1B6OjrU7OaQkJ7ZKcseD?=
 =?us-ascii?Q?oQp+I2I7jwLIGu1XY1L0J7svMXXTLp+Syhi3CqlTn6xvIwD3CGusMFzT9qNa?=
 =?us-ascii?Q?P+QCTl8xUsZyC8Z2BWkIMnOtI34mIJkbJLPfIjtylnVUUbb3AXh0YcT+Y5JI?=
 =?us-ascii?Q?2HrZLV0THEZ/KxgVlBps1mQ1BjKDJTx3rlGhHYXMbIeZURVO/XxoVebrJp8K?=
 =?us-ascii?Q?Qsb1ELT+dFxN4GgjJ7lTu8ktWEH6jvJa/cMqd3qnt1Bn2RzKGIIjxjCoqkAY?=
 =?us-ascii?Q?8C0D3nM9gZIaJO60UbF5jd0YjyLeMRdEok/UQ5z0cVybCw5oiF62a1x2a1mS?=
 =?us-ascii?Q?c+V4O0C94VbVcY+Lt2vTZMHzKKkDvkHU6NJuegH/3YbyqbNjPMMKiHNJASAO?=
 =?us-ascii?Q?7zBcX85E4sYR8/fsl5rPeRwcnEByRde8Xk7Vt0oaQfIUfcZYB+KeHxCLN2I/?=
 =?us-ascii?Q?J8nuZ5qnMGfsZ+MdFhyfIZ4pN9jn6wjdH7QRXb7Y4XciRP5Z/u/WQ9v4PL8r?=
 =?us-ascii?Q?hmGrFVCntvnWucNS+JRRDWojWN8YhqwioUGoAqkJOz8Ek0mTr7Be3RWom6LB?=
 =?us-ascii?Q?kzscxMivOnKZpz3luJajg7zhoxHaz2ehSgl8N2eWfktVSu8hzOs6VchKbUsT?=
 =?us-ascii?Q?3Nvasyq0O7kd2uMp1qHxpAwYUVIxXl1u8diz6YRpY6KDVbbRfudZxfL8a4ug?=
 =?us-ascii?Q?N485O3OVApZZ4AkSGKMIkdnrQS0VyxdAlU/JlURj/CwD7h2diE99+C4Fa/ag?=
 =?us-ascii?Q?EVwW0ffbqXDZVD+jBh8u9Z7J18NLVmVce525u0kqxMVDQGiUTkTYOZQDkXBM?=
 =?us-ascii?Q?rqeIBNeB9h2UtIYPZNaB4m6uOvuGSIRUELrK5kDJfi/64tc7hn3BGH+y2oIQ?=
 =?us-ascii?Q?zXZaI9LmjcU320+DRon4oHeoczRkVZ1m5MmIFuDo1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqFylFbxxaUu1PIxg0xHr7D5tSBYpgPK+/YhJ1htU/kRlV1JF79Cay+sUsCj?=
 =?us-ascii?Q?80rW79ql8F92G1tFlmPLmME1yj3UJn86Rwg2fznKzQLegibEO1LhsFESvje8?=
 =?us-ascii?Q?pir2HPYltwH2iFipcudXYURjEwh2ySJEAl9hSaIL3jnUxJnnkhOTmsJh6vN4?=
 =?us-ascii?Q?uH8By2BRJgm/ov62b10d8AfYl1+qtpor4YqyrZZW7gnZAkB9J5sxcHbcF9BE?=
 =?us-ascii?Q?i7mziCqqQq/V8Ra4uRq5vE3a2/c+OP8x0xq/FSB6e5IkOAor3rzO22qsx9uX?=
 =?us-ascii?Q?ZuFYKlYQxX6oKFjpj6GWaQw+LUcnnamAWpqT4397nBnL+L1qeVzRPSME9QF+?=
 =?us-ascii?Q?gW82J+0DgtlZvrgPCVfXO8KC6FRdYd/gih2LWhR8G20jBHxaXh7DV/WC6ble?=
 =?us-ascii?Q?DnSjHGgZkzgImxFvZCQlvX7mBiMnjpoIBW+/FEbgj7sYSatOJ6+1031Yt0QO?=
 =?us-ascii?Q?tR9kJn+2qEijq8Abvziqhu3EH/c1lIIznoblKJlTF+a2j27RuDTfCw1WN//i?=
 =?us-ascii?Q?TiAWMhigWVC+ODdBmP6wrkn3+Lyi2bgzuOK5+lk7Lvzq0YSLac9zmvPaegAP?=
 =?us-ascii?Q?ytIlta878MGq/XWyIDk2dhuy2CtUtYIOpa5BR2DXSDgWbACVNrhlWeddzyg5?=
 =?us-ascii?Q?oz62I0UDyf+/E1KGlbH7ijpu/007rSuF400y9yFXox40HHmoFyUTowsM3Z5R?=
 =?us-ascii?Q?YFkmHpiCVjTx6eVuCSkKI2QJxLA+veT4X+OcyB1VY9zGkBzp1Qqr/5ypER1M?=
 =?us-ascii?Q?qxs4Q+x/oIqegai24S3OhWAmZFDbd0kRyx8R1C7TR/XmZnM3oi1Y04OImN0o?=
 =?us-ascii?Q?qt3gTglYUW+IhTKTl6zJkeuTTzTJ5na6E21MMbvH+u7Aynuruu2tKiLbhyOx?=
 =?us-ascii?Q?9TLP+QIzXwIthmIL+G5IudLMnLXLrIv+zi7jm1XTyvYCOgTSIllMVFl0Vt9L?=
 =?us-ascii?Q?2Qd/Ly3baafs0sDlr+oywM5OKblJ2vKTdyWgEYal8IYfu32mumsbXNu9FoTo?=
 =?us-ascii?Q?IwijexJTsqvvjNlcEw1edqxR4hGwUZIAUnvbKJ7hrd+UsikBDfhxDTOjD4D8?=
 =?us-ascii?Q?WFC8h73shR0WZ5TKKwQvCrYoyu0kxuwO2oosTjATFaW3XMft5/4ovflNX3HX?=
 =?us-ascii?Q?yViN33jE1mI8jKb9F5FAJexSgNGfG8TR6rOH0TKKzdaK6KZsV21RsJSmPTBY?=
 =?us-ascii?Q?Q9KRAgJID53QD+UBbW0XTGKI/dduraMp+iS4/bB4yEVDkmHHHCbpmBaVLEC8?=
 =?us-ascii?Q?aLwiHhy0XBJv7bpWAxusa/hQ8dMQMSPQHbiZywzH8DZVifd116Pv2h1Dasbn?=
 =?us-ascii?Q?TzalfQRL+AA44MMMPXtOBb56iRg4WvFzuG0op39WJS0NEqu9M5dBfHu8qnzb?=
 =?us-ascii?Q?TFRxHfvggQVRd1qNfel71sexPLK0+IQTMdQ0p5apmj/+k62UCcZLGiQnm6iT?=
 =?us-ascii?Q?aLCZuCYkrEgbb+ZLEG03V9diURxjMA3c/oGs/C/nMwEP29HX1MSmBLv96Me5?=
 =?us-ascii?Q?bNoiQHZKY+U5/utmPry4TeQ5/TltiEs+DwxPuaxwBaDi+YZXtDsg3UJ/mXpH?=
 =?us-ascii?Q?HOHGHNYn6mHnRmBSjjM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897da066-3f31-494a-a6b8-08dc662e9f5f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 20:22:40.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJyA3I4D++lvBN4Z259XQ7B3w9sDlz5cCtp6THsuLQUuZXg0GeqLFxbgt/7tLopT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

--=_MailMate_33548C9A-C040-4AF4-94DC-F7A4FE8A5C87_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2024, at 16:15, David Hildenbrand wrote:

> On 26.04.24 21:20, Zi Yan wrote:
>> On 26 Apr 2024, at 15:08, David Hildenbrand wrote:
>>
>>> On 26.04.24 21:02, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
>>>> if any page in a folio loses its final mapping. But it is possible t=
hat
>>>> the folio is fully unmapped and adding it to deferred split list is
>>>> unnecessary.
>>>>
>>>> For PMD-mapped THPs, that was not really an issue, because removing =
the
>>>> last PMD mapping in the absence of PTE mappings would not have added=
 the
>>>> folio to the deferred split queue.
>>>>
>>>> However, for PTE-mapped THPs, which are now more prominent due to mT=
HP,
>>>> they are always added to the deferred split queue. One side effect
>>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can =
be
>>>> unintentionally increased, making it look like there are many partia=
lly
>>>> mapped folios -- although the whole folio is fully unmapped stepwise=
=2E
>>>>
>>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THP=
s
>>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduc=
e
>>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-m=
apped
>>>> folio is unmapped in one go and can avoid being added to deferred sp=
lit
>>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will sti=
ll be
>>>> noise when we cannot batch-unmap a complete PTE-mapped folio in one =
go
>>>> -- or where this type of batching is not implemented yet, e.g., migr=
ation.
>>>>
>>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checke=
d
>>>> to tell if the whole folio is unmapped. If the folio is already on
>>>> deferred split list, it will be skipped, too.
>>>>
>>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
>>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was sti=
ll
>>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,=

>>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable(=
).
>>>>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    mm/rmap.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 2608c40dffad..a9bd64ebdd9a 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
>>>>    {
>>>>    	atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>>>    	int last, nr =3D 0, nr_pmdmapped =3D 0;
>>>> +	bool partially_mapped =3D false;
>>>>    	enum node_stat_item idx;
>>>>     	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
>>>>    					nr++;
>>>>    			}
>>>>    		} while (page++, --nr_pages > 0);
>>>> +
>>>> +		partially_mapped =3D !!nr && !!atomic_read(mapped);
>>>
>>> Nit: The && should remove the need for both !!.
>>
>> My impression was that !! is needed to convert from int to bool and I =
do
>> find "!!int && !!int" use in the kernel.
>
> I might be wrong about this, but if you wouldn't write
>
> 	if (!!nr && !!atomic_read(mapped))
>
> then
>
> bool partially_mapped =3D nr && atomic_read(mapped);
>
> is sufficient.
>
> && would make sure that the result is either 0 or 1, which
> you can store safely in a bool, no matter which underlying type
> is used to store that value.
>
> But I *think* nowdays, the compiler will always handle that
> correctly, even without the "&&" (ever since C99 added _Bool).
>
> Likely, also
>
> 	bool partially_mapped =3D nr & atomic_read(mapped);
>
> Would nowadays work, but looks stupid.
>
>
> Related: https://lkml.org/lkml/2013/8/31/138
>
> ---
> #include <stdio.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <inttypes.h>
>
> volatile uint64_t a =3D 0x8000000000000000ull;
>
> void main (void) {
>         printf("uint64_t a =3D a: 0x%" PRIx64 "\n", a);
>
>         int i1 =3D a;
>         printf("int i1 =3D a: %d\n", i1);
>
>         int i2 =3D !!a;
>         printf("int i2 =3D !!a: %d\n", i2);
>
>         bool b1 =3D a;
>         printf("bool b1 =3D a: %d\n", b1);
>
>         bool b2 =3D !!a;
>         printf("bool b2 =3D !!a: %d\n", b2);
> }
> ---
> $ ./test
> uint64_t a =3D a: 0x8000000000000000
> int i1 =3D a: 0
> int i2 =3D !!a: 1
> bool b1 =3D a: 1
> bool b2 =3D !!a: 1
> ---
>
> Note that if bool would be defined as "int", you would need the !!, oth=
erwise you
> would lose information.

Thank you for all above. Really appreciate it! And you are right about &&=
 and !!.
My memory on !! must be from the old days and now is refreshed. :)

>
> But even for b1, the gcc generates now:
>
>  40118c:       48 8b 05 7d 2e 00 00    mov    0x2e7d(%rip),%rax        =
# 404010 <a>
>  401193:       48 85 c0                test   %rax,%rax
>  401196:       0f 95 c0                setne  %al
>
>
> My stdbool.h contains
>
> #define bool	_Bool
>
> And I think C99 added _Bool that makes that work.
>
> But I didn't read the standard, and it's time for the weekend :)

Have a good weekend!

--
Best Regards,
Yan, Zi

--=_MailMate_33548C9A-C040-4AF4-94DC-F7A4FE8A5C87_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYsDQ4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSmEP/2zoabK+8131tgiI6/EDTerkfKQBBQxLia+0
jz8ysKr87rT6KOoY/DDTM4AKCXrfCvTCXamUmqsJYpF4nWSza2q/TECBgwKVLnRf
b1DNNMCfwrk9sEdFOsi5mNaX0NmnKcGF8Z+sQW0p/X+suXQnswCwSpRwnN8XQBxC
asrZ27tB5wrNwmgltMcgkcgJ3nysA5OlyCCQ/JUqkyo4vJHsLisuoHM5VNmHDVmc
pmRI16ETW0IivEdGU62e+actUhiRQ8tCf1KTPs1plPGsrHSvAnxgaOLXUm2y2b7i
Dk8ZuJvCeQxqxVY9gad6JQNQDKx3EP9rQrIeW/oAmtI3PRiXtN9r5ATvOMynpysn
PiAi1zCNF5t//GHUjRPIXUMJFXb8mE504yGMcJqXSxvckwfko4PsOaNVfZKJpR9J
7jU2KN/6modAc3Ngjd5TeAWbn9abnODT8Q5gKkyKPvSzc7R5xDiVlNWs+UY2Scmz
FXta16bRZL1d/rolFjnbTr/inA3dNKQ819oLB6McmYJefP6LS4kS1gygeXdCXSYi
wVkn9GWXix9HCxJSNM6fGg8mfc9m/GjHTP5PNP6VMXJqDvDeQqZWiV9I88hfBa0a
rYcFTMN8vx4WQKLLa4W7dKOqu4GFS3ICd18ebasLReUoXz8Z4JYPv54BrckXpVw6
c8l9k1lH
=tQFj
-----END PGP SIGNATURE-----

--=_MailMate_33548C9A-C040-4AF4-94DC-F7A4FE8A5C87_=--

