Return-Path: <linux-kernel+bounces-32671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB46835EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447A91C22D40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C13A8DA;
	Mon, 22 Jan 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yk8ugVUB"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B863A8C5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917071; cv=none; b=Gra8oWs/da1XAOBVjBb0Rj5UKrfeqhHE0S3qDmLRNzR29iTF7DJGJAHakWUJczuAmCPnhtev/wnBN3ZdNkV8V98ldGcDw4aoXSnR+a4RM4h9S/2xFTyPzrpRKfbL/jis0iqVUDoejfJHoWVL6uky41GGVH8wGpiKerCsOBzZni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917071; c=relaxed/simple;
	bh=w8DEEbROLnC6K+V6qLygCGRyL7ECn+rsYZ/7tXTMPbM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KRankZRP9ZVSxXOF7zijzUf7s2cn/4agFysHPSf7BHkZ/K9KOPuCekVIWuNx1qXbJBw3ogaOY/XS50m9TazJBFtRm5coFPwAdTKbK702in2iq+UvFnsVtKU1vvHL7XzpivP9AtfNXNYgfX/SLMMfVohAI4xutgBIi+9zLHycL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yk8ugVUB; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705917065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuYC06RX3OtM9f7oUAxUdtkdP4RrZ1CoNtn1dGQVcuw=;
	b=Yk8ugVUBfKEAMZ0SoNd9vUrDnjdTkUXZ3EdpoOmDf9zJcVu76WkfDSXoDfd9p2C1620yZh
	QkHajUAFf5P8I7HJ5vuvu6uqRpvePsmntng+NB8tRw8R9pE78BDgFFbsyMH80uBQj0Qm2j
	bWZG3e2tiWPC814YXlaDIS9AjbU8TOA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b71d1750-87b9-4f2d-af4a-3555eeffaafd@linux.dev>
Date: Mon, 22 Jan 2024 17:50:26 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <84380389-0922-4073-B4C7-DBF9F865E162@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-5-gang.li@linux.dev>
 <f7e072c0-4b41-40d3-bf2e-19d4fdf7bc0d@linux.dev>
 <b71d1750-87b9-4f2d-af4a-3555eeffaafd@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 22, 2024, at 17:14, Gang Li <gang.li@linux.dev> wrote:
>=20
> On 2024/1/22 14:16, Muchun Song wrote:
>> On 2024/1/18 20:39, Gang Li wrote:
>>>   static struct folio *alloc_pool_huge_folio(struct hstate *h,
>>>                       nodemask_t *nodes_allowed,
>>> -                    nodemask_t *node_alloc_noretry)
>>> +                    nodemask_t *node_alloc_noretry,
>>> +                    int *next_node)
>>>   {
>>>       gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THISNODE;
>>>       int nr_nodes, node;
>>> -    for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
>>> +    for_each_node_mask_to_alloc(next_node, nr_nodes, node, =
nodes_allowed) {
>> A small question here, why not pass h->next_nid_to_alloc to
>> for_each_node_mask_to_alloc()? What's the purpose of the third
>> parameter of alloc_pool_huge_folio()?
>> Thanks.
>=20
> In hugetlb_alloc_node->alloc_pool_huge_folio, hugetlb is initialized =
in
> parallel at boot time, then it needs each thread to have its own
> next_nid, and can't use the global h->next_nid_to_alloc. so an extra =
parameter is added.

Yes. When I read your patch 6, I realized this.

>=20
> And h->next_nid_to_alloc in set_max_huge_pages->alloc_pool_huge_folio
> can not be removed. Because if the user calls set_max_huge_pages
> frequently and only adds 1 page at a time, that would result in each
> request being made on the same node if local variables are used.


