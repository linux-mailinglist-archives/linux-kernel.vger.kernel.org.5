Return-Path: <linux-kernel+bounces-47827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D37845367
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F92289577
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3866159571;
	Thu,  1 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YaYeCcPA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F4158D8E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778379; cv=none; b=AJdcyYjIpS3evUUaEj/jqiE0Aua/a4e2v/vuyyWqlMLqdkzDTM3Pnk04DQdXYOedfWW1GCg1ZLxlACNEWEiR65zuRuhKjRTzI/8CHMu8L0+kzBIuiVNL4Zc8LLtUXRxW3YaeRi7SGzSP05YFpqRGvOgfhSeT8xTqtfxgQIAP+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778379; c=relaxed/simple;
	bh=BRIzbWWN4qRwdJsCPOqQTbDAV3TiwA8Kww9EHf4ujwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhrk7Hr+uybBV+z41SEar+edwTC5lZm23VZcsIyNSkxBxQR1w5e++/YxpPw+9ftiNLLx7eOOg4uFyLOYIRo+vp+6EP/cWxZ1yRGJN9sEtr/E7q4uEZ/2u1bJwfc9SMf2K+shyB1rlBWFiCvw4yG4w/RV3K1jwg/Pd8pjNcMPKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YaYeCcPA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4118ORJd008043;
	Thu, 1 Feb 2024 09:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=rdrKscTz6Z7e6eqDuxnq4hhn6ZBfuuxOKbspA/oNIqo=;
 b=YaYeCcPAYyxLPnEaCFuwv8M+gQHjU1cgOPDdUZ2D78sDYCod73xLzLkOX+ugCYgL8bri
 Wd1El3GNYB3lUEoOUC4A6lndB2DLGU+yS4pj9dbAfmyD1+elFGfQfbZyEfi5R093yTMd
 my34RK9sBqMW/C1QMD5Ukc8TPs+S0XXdwO9AXZAXBsxe/ccTCSDyZjIMJIDitGIJTeYR
 PI2xlCGmnuJYwZF6xLQE7ZN4eN9KSo16nOMnk2+EE24rQcVzSrQclSc7JEx643Nwgunv
 nvE5Hemg+e1d/FLJqRZkmoP8L/T+HxWeaCakvbhsKxxPa073Bj9Tpyjvz9EQ7ZYHpdti fA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w05pdcae2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 09:05:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41163ZKb017772;
	Thu, 1 Feb 2024 09:00:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwcj038kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 09:00:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41190ivJ23790306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 09:00:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA50920040;
	Thu,  1 Feb 2024 09:00:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660BC20043;
	Thu,  1 Feb 2024 09:00:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.28.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Feb 2024 09:00:43 +0000 (GMT)
Date: Thu, 1 Feb 2024 11:00:41 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, yanaijie@huawei.com,
        zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, arnd@arndb.de, m.szyprowski@samsung.com,
        willy@infradead.org
Subject: Re: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is
 in RAM
Message-ID: <Zbtdue57RO0QScJM@linux.ibm.com>
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
 <0da50102-3e87-49f7-b8f7-45cfcb4232d6@arm.com>
 <ZbqY12U/CXwAAu7A@shell.armlinux.org.uk>
 <edc4e8fa-af0a-46c2-bf07-20a0c4e20af5@arm.com>
 <8b50ca93-c164-ddfc-cd79-8f8525198a96@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b50ca93-c164-ddfc-cd79-8f8525198a96@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S47JddwGa1Kge7YCgDxFNbzSsG5FhyUD
X-Proofpoint-GUID: S47JddwGa1Kge7YCgDxFNbzSsG5FhyUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010073

Hi,

Please don't top-post to Linux mailing lists.

On Thu, Feb 01, 2024 at 04:00:04PM +0800, Yongqiang Liu wrote:
> Very appreciate it for extra explanation. Notice that commit 024591f9a6e0
> 
> ("arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM") use
> 
> memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in
> 
> RAM or not, so I wrote the patch to solve this case.  Otherwise, when we
> 
> use pageblock align(4M) address of memory or uio, like :
> 
>      node   0: [mem 0x00000000c0c00000-0x00000000cc8fffff]
>      node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
> 
> or uio address set like:
> 
>    0xc0400000, 0x100000
> 
> the pfn_valid will return false as memblock_is_map_memory.

pfn_valid() should return false if and only if there is no struct page for
that pfn.

My understanding is that struct pages exist for the range of UIO addresses,
and hopefully they have PG_reserved bit set, so a better fix IMO would be
to check if the folio is !reserved.
 
> 在 2024/2/1 5:20, Robin Murphy 写道:
> > On 2024-01-31 7:00 pm, Russell King (Oracle) wrote:
> > > On Wed, Jan 31, 2024 at 06:39:31PM +0000, Robin Murphy wrote:
> > > > On 31/01/2024 12:59 pm, Yongqiang Liu wrote:
> > > > > @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
> > > > >            /* only flush non-aliasing VIPT caches for exec mappings */
> > > > >            return;
> > > > >        pfn = pte_pfn(pteval);
> > > > > -    if (!pfn_valid(pfn))
> > > > > +    if (!memblock_is_map_memory(PFN_PHYS(pfn)))
> > > > >            return;
> > > > >        folio = page_folio(pfn_to_page(pfn));
> > > > 
> > > > Hmm, it's a bit odd in context, since pfn_valid() obviously
> > > > pairs with this
> > > > pfn_to_page(), whereas it's not necessarily clear that
> > > > memblock_is_map_memory() implies pfn_valid().
> > > > 
> > > > However, in this case we're starting from a PTE - rather than
> > > > going off to
> > > > do a slow scan of memblock to determine whether a round-trip through
> > > > page_address() is going to give back a mapped VA, can we not trivially
> > > > identify that from whether the PTE itself is valid?
> > > 
> > > Depends what you mean by "valid". If you're referring to pte_valid()
> > > and L_PTE_VALID then no.
> > > 
> > > On 32-bit non-LPAE, the valid bit is the same as the present bit, and
> > > needs to be set for the PTE to not fault. Any PTE that is mapping
> > > something will be "valid" whether it is memory or not, whether it is
> > > backed by a page or not.
> > > 
> > > pfn_valid() should be telling us whether the PFN is suitable to be
> > > passed to pfn_to_page(), and if we have a situation where pfn_valid()
> > > returns true, but pfn_to_page() returns an invalid page, then that in
> > > itself is a bug that needs to be fixed and probably has far reaching
> > > implications for the stability of the kernel.
> > 
> > Right, the problem here seems to be the opposite one, wherein we *do*
> > often have a valid struct page for an address which is reserved and thus
> > not mapped by the kernel, but seemingly we then take it down a path
> > which assumes anything !PageHighmem() is lowmem and dereferences
> > page_address() without looking.
> > 
> > However I realise I should have looked closer at the caller, and my idea
> > is futile since the PTE here is for a userspace mapping, not a kernel
> > VA, and is already pte_valid_user() && !pte_special(). Plus the fact
> > that the stack trace indicates an mmap() path suggests it most likely is
> > a legitimate mapping of some no-map carveout or MMIO region. Oh well. My
> > first point still stands, though - I think at least a comment to clarify
> > that assumption would be warranted.
> > 
> > Thanks,
> > Robin.
> > .

-- 
Sincerely yours,
Mike.

