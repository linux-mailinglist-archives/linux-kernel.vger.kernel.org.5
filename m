Return-Path: <linux-kernel+bounces-126263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AF89346D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59991C237C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B715E1F5;
	Sun, 31 Mar 2024 16:43:16 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D21482EA;
	Sun, 31 Mar 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903395; cv=fail; b=Qq6j2lXQ5F1IKqMz4HImf1GXPhCylQBcCCUp3LtZgbiHg/qdnQ5EUOA+O6tqqJqKNKjsib5oC6vVkM4693tiPC7cH0EgXLYeG/TDbhYyEeklEfJVqHm0Pq5PduA2n83dyu/yqc/oUPagyrPtkRjJupEv1VofOgjjDv2or/4Jx1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903395; c=relaxed/simple;
	bh=cJPDlDKrfU9zAHTWXn9k0ShpUt9gSzGdeGLqHSMf5+U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KLuXVJKwaSnC2mz0DWDlCycti62Ylq6gGOR65/oE81yrccfsoAdPECLjJ+N4PJ0YJxcV/4tCOrphslNCTeNPmWScMMvXJeYVdd68xf/HiGtexACJyhE69+JqYW1C/X3aqu43yVE+yWPxExbDM9kE6Fsxc7MAH38KNx0gh23xixk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 45992208C4;
	Sun, 31 Mar 2024 18:43:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nn2VdXehGXXE; Sun, 31 Mar 2024 18:43:09 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 503DA20851;
	Sun, 31 Mar 2024 18:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 503DA20851
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 42973800060;
	Sun, 31 Mar 2024 18:43:09 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:09 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:04 +0000
X-sender: <netdev+bounces-83502-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAFYymlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8108
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83502-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6AA3120322
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800081; cv=none; b=WJbbV270t/ooVwRu27l3kpbpO/LNp3fBVfRjqDSUiCBL1/yhmqeX05AdQ5vC9vo421dyQlYdRNrAG/3dLmqvHvHH3IOXbqbnkcRGS5ljWtW9WpuJVFyUYBq7iefT2u8Y2EsHJMJjqK0UHGQnJZOlWMwRiKLeHwXjs5A0t2k/zBc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800081; c=relaxed/simple;
	bh=fT3FnLwhlqo35Pj+pAK551GXQXi8alEtZAKvfSYeaHU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gysezl9oW2wx2m1NIwuS5aCuwl7HEGn2RtF3oLAyvdICdI9EdoKb99h/KeqXZzq3y49d/36QaSMvGlijVKast3vaki1kT/opXa8XfqWWufE7zSFpHwMOXGVeeMdlmccqp9Eb+dtVlMhV0NpG4fjzqbWHbE5Lf0g0516IE1P/Sc0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Subject: Re: [PATCH RFC 01/10] mm: Move the page fragment allocator from
 page_alloc into its own file
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
 <20240328133839.13620-2-linyunsheng@huawei.com>
 <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9e03b278-aaeb-d11c-d2e0-d45ca5e97346@huawei.com>
Date: Sat, 30 Mar 2024 20:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 2024/3/30 1:19, Christophe Leroy wrote:
>=20
>=20
> Le 28/03/2024 =C3=A0 14:38, Yunsheng Lin a =C3=A9crit :
>> Inspired by [1], but use free_unref_page() to replace free_the_page()
>> instead of __free_pages(), use VM_BUG_ON() to catch that we can use
>> free_unref_page() directly, also add its own header file.
>>
>> As the API is only used by the networking, it may make sense to
>> move it to the networking directory like the page_pool does in the
>> future if we can make the free_unref_page() callable outside of the
>> mm subsystem. And we can utilize that to decouple the 'struct page'
>> in the networking subsystem in the future.
>=20
> I'm wondering if this page fragment allocator could replace the page=20
> fragment allocator used in powerpc to allocate fragment of pages for=20
> page tables.

From a quick glance, it seems possible. If there are potential users
other than the networking for this API, we can keep it in mm subsystem
for now as this patch does and see how thing will evolve.

>=20
> See arch/powerpc/mm/pgtable-frag.c
>=20
> Christophe
>=20

X-sender: <linux-kernel+bounces-125719-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAF4ymlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8107
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 13:01:41 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 13:01:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DED912053D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 13:01:40 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -6.184
X-Spam-Level:
X-Spam-Status: No, score=3D-6.184 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, NICE_REPLY_A=3D-3.533,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccdTO5_3iJlc for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 13:01:38 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125719-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9BA4A20518
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9BA4A20518
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA01F22422
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0F38FA5;
	Sat, 30 Mar 2024 12:01:23 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FB1E896;
	Sat, 30 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D45.249.212.190
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711800081; cv=3Dnone; b=3DWJbbV270t/ooVwRu27l3kpbpO/LNp3fBVfRjqDSUiCB=
L1/yhmqeX05AdQ5vC9vo421dyQlYdRNrAG/3dLmqvHvHH3IOXbqbnkcRGS5ljWtW9WpuJVFyUYB=
q7iefT2u8Y2EsHJMJjqK0UHGQnJZOlWMwRiKLeHwXjs5A0t2k/zBc=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711800081; c=3Drelaxed/simple;
	bh=3DfT3FnLwhlqo35Pj+pAK551GXQXi8alEtZAKvfSYeaHU=3D;
	h=3DSubject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=3DGysezl9oW2wx2m1NIwuS5aCuwl7HEGn2RtF3oLAyvdI=
CdI9EdoKb99h/KeqXZzq3y49d/36QaSMvGlijVKast3vaki1kT/opXa8XfqWWufE7zSFpHwMOXG=
VeeMdlmccqp9Eb+dtVlMhV0NpG4fjzqbWHbE5Lf0g0516IE1P/Sc0=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dquarantine dis=3Dnone) header.from=3Dhuawei.com; spf=3Dpass smtp.mailfr=
om=3Dhuawei.com; arc=3Dnone smtp.client-ip=3D45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dquarant=
ine dis=3Dnone) header.from=3Dhuawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dhuawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V6G542s8Wz29lQT;
	Sat, 30 Mar 2024 19:58:32 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A15F21A0172;
	Sat, 30 Mar 2024 20:01:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.=
com
 (7.185.36.74) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 30 M=
ar
 2024 20:01:14 +0800
Subject: Re: [PATCH RFC 01/10] mm: Move the page fragment allocator from
 page_alloc into its own file
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howel=
ls
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
 <20240328133839.13620-2-linyunsheng@huawei.com>
 <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9e03b278-aaeb-d11c-d2e0-d45ca5e97346@huawei.com>
Date: Sat, 30 Mar 2024 20:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
Content-Type: text/plain; charset=3D"utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
Return-Path: linux-kernel+bounces-125719-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 12:01:40.9382
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 6ede3bfb-a1cd-47dd-a20c-08dc=
50b12923
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dcas-es=
sen-01.secunet.de:TOTAL-FE=3D0.009|SMR=3D0.010(SMRPI=3D0.007(SMRPI-Frontend=
ProxyAgent=3D0.007));2024-03-30T12:01:40.948Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 7561
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On 2024/3/30 1:19, Christophe Leroy wrote:
>=20
>=20
> Le 28/03/2024 =C3=A0 14:38, Yunsheng Lin a =C3=A9crit :
>> Inspired by [1], but use free_unref_page() to replace free_the_page()
>> instead of __free_pages(), use VM_BUG_ON() to catch that we can use
>> free_unref_page() directly, also add its own header file.
>>
>> As the API is only used by the networking, it may make sense to
>> move it to the networking directory like the page_pool does in the
>> future if we can make the free_unref_page() callable outside of the
>> mm subsystem. And we can utilize that to decouple the 'struct page'
>> in the networking subsystem in the future.
>=20
> I'm wondering if this page fragment allocator could replace the page=20
> fragment allocator used in powerpc to allocate fragment of pages for=20
> page tables.

From a quick glance, it seems possible. If there are potential users
other than the networking for this API, we can keep it in mm subsystem
for now as this patch does and see how thing will evolve.

>=20
> See arch/powerpc/mm/pgtable-frag.c
>=20
> Christophe
>=20


