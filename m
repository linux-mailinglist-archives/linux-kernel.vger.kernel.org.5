Return-Path: <linux-kernel+bounces-126174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE0893323
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EBF1C223EE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B59147C70;
	Sun, 31 Mar 2024 16:28:19 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF047152533;
	Sun, 31 Mar 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902497; cv=fail; b=VFDm+0Ch6jO6ZCTtis2KjPcUxpb6UuXxmEscK0Ab/OEHisl/TrUWlITUn2ZJJDdNBnsKLrM9H8hLpjxmAsag/xq0zTROIt+2P94Wh30DoTGdTNApZuZnTlGllnMPPA3ePeJcAKaQcO3HPaZBEoJ5H/Tie1ja9gJAfXE5f6d+cSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902497; c=relaxed/simple;
	bh=LU3WtJaoL5yui7n84axaXpWXRItq1jQo2lcXYzG4m70=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OUaiw/e+eKOKBWku3UiTNhsCxWb1TNjTxo4dVn9YhDhOwHC2BYsTWnMK9BlVh2pzBnvM6kHsqBgSXeQTD5CChz2zvT7DVTv2FgEg1Wcskzdf+VaFwtZdKwRfFGFOz4gsR7qQlqt+oKgrfIGBBKprDeEk7aKENfFtk175g1EykYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AC550208B8;
	Sun, 31 Mar 2024 18:28:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVZJ5l68sIjV; Sun, 31 Mar 2024 18:28:10 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0C9AD208D0;
	Sun, 31 Mar 2024 18:28:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0C9AD208D0
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id F3C84800057;
	Sun, 31 Mar 2024 18:28:09 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:09 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:49 +0000
X-sender: <netdev+bounces-83502-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAlNTp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAMAAAAmooAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10737
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

X-sender: <netdev+bounces-83502-peter.schumann=3Dsecunet.com@vger.kernel.or=
g>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Drfc822;peter.schumann@secu=
net.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAJ05ab4WgQhHs=
qdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEu=
SXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAI=
AAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIC=
hGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAF=
wC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRt=
aW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3J=
vdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbm=
ZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMA=
AAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQu=
TWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGw=
AAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2Vycy=
xPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3Bvb=
nNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5F=
eGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXh=
wYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAlNTp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgANAAAAmooAAAUABAAUIAEAAAAaAAAAcGV0ZXIu=
c2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgA=
HAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10731
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 13:01:37 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 13:01:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 0DF4420322
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 13:01:37 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -6.184
X-Spam-Level:
X-Spam-Status: No, score=3D-6.184 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, NICE_REPLY_A=3D-3.533,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fI8aGfZ6xju7 for <peter.schumann@secunet.com>;
	Sat, 30 Mar 2024 13:01:26 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83502-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dpeter.sc=
humann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 82AA72025D
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 82AA72025D
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 13:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A801F220B8
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B536AE4;
	Sat, 30 Mar 2024 12:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
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
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
Content-Type: text/plain; charset=3D"utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
Return-Path: netdev+bounces-83502-peter.schumann=3Dsecunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 12:01:37.0819
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 045d8a1b-9b12-4a39-109d-08dc=
50b126d7
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.403|SMR=3D0.348(SMRDE=3D0.034|SMRC=3D0.31=
3(SMRCL=3D0.100|X-SMRCR=3D0.314))|CAT=3D0.053(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.023(CATRESLP2R=3D0.001)|CATORES=3D0.016
 (CATRS=3D0.016(CATRS-Index Routing
 Agent=3D0.015))|CATORT=3D0.001(CATRT=3D0.001(CATRT-Journal Agent=3D0.001
 )));2024-03-30T12:01:37.516Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7554
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.031|SMR=3D0.005(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.003))=
|SMS=3D0.025
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXADAAAPAAADH4sIAAAAAAAEAG1U227j=
NhClZUlW5Hi7nz
 Bv2QVcO5d92M3DAmmBFgG23QJFCxRFYSgSbQmhSJWkYrhf09e+9hf2
 xzoztFR3U4AWSM7MmXPOMPk7+6jh+vL6zfpmfXMJV7dX75bwdW0b50
 1XS/ggrTnA3hovbxf5+7DwFq7fri9v1lQJn/6Eqze3N2+X8EuvXS31
 Dj40Ggr49FdpGw9U+B7utesaKyt4OMCvV78t4aH30DsJWyvlptdWbj
 ddsZOvXoM3YGWnivIY9LU8hhip0c7LogKzhc2GEyjoXr1eMt7P322+
 +unbzcfvA1JZ+LIGXxce9hJPmpIY53njCgmWXh2WUChnoKgqaLwDs9
 dQY0dpYdsouaJqRrhzCCzh7od7aDBNqwOBs0S619LvjX1s9G6JONAW
 B/w9SnBSI09vGKM1T5KiSPW/NUc2xh5ANVhFUeK56YxRUBnp0Am6DW
 J631sE2g4quRPVPJdZFkoVD0qC6b1rKklODjhtC65/cAe0uF3Bna5G
 13yjmj9kcBLJVrI0fadCjwvnbV965ndxHNLnckbYIRYor45v6v6ihb
 3RaDIlN8QIPSVAVFDsWqk9TkUZnKexgL1VNb6SwRrC+Z9kngk27cxe
 2q4k9sfgCTZ6wM8ItsYSDnf2ZJNDiov8G2tafNO/9035CDtV6FLyVJ
 2ULfI0zjWYu4J79hJHUeCvw78b7ZtCEQfrFrmhGHn4zB5sGyTja1oO
 pj9K2VETJH86mEVO2drsoXCDT/TK+VEUODMkBTWGMYbQ+0YpkE9GPU
 mWwn7/KIliWa+Prqzbdt3tWPCXZMqqPCb++9+ALxa5EJGYxhNxhksk
 ExFFEzrGAleai3ki0kS8xJxoInJcuMF8zJxEiRCJmGXibCqwAo/nuI
 8muBcIMOWFhy9EgiCxmGHhTGR4sxAJhcQcj9juXEQx5RBORDSmtBEJ
 5nMhbRgtO0XLRB4zTlipmMXixZAZB5JjbS7Ow4YbpRElU2iIzs8GtJ
 h9OKnNUmY+ln8mCiWTCs7E75mYh+74JbEMwhYlzDA/7Rj2qXiB33AM
 fTEfj4iPCNw0CzcBLbTDG3KbLZqynFTMY54g3qScg5uMYTknZsxZsD
 RwGBQlo7qgdBQyOjlWhRWOqXgZqgKl2UScs+SJyPJ/ACIC+6mMBgAA
 AQ7PAVJldHJpZXZlck9wZXJhdG9yLDEwLDE7UmV0cmlldmVyT3Blcm
 F0b3IsMTEsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0
 RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaW
 Fnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZXJEaWFn
 bm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdW NlciwyMCwxMA=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1102
X-MS-Exchange-Forest-EmailMessageHash: 1B46C7A0
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

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
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAlNTp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAOAAAAmooAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 10678
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 13:01:40 +0100
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
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.415|SMR=3D0.344(SMRDE=3D0.034|SMRC=3D0.30=
9(SMRCL=3D0.102|X-SMRCR=3D0.310))|CAT=3D0.069(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.040(CATRESLP2R=3D0.020)|CATORES=3D0.016
 (CATRS=3D0.016(CATRS-Index Routing Agent=3D0.015)));2024-03-30T12:01:41.38=
8Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7561
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.034|SMR=3D0.010(SMRPI=3D0.007(SMRPI-FrontendProxyAgent=3D0.007))=
|SMS=3D0.025
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXADAAAPAAADH4sIAAAAAAAEAG1U227j=
NhClZUlW5Hi7nz
 Bv2QVcO5d92M3DAmmBFgG23QJFCxRFYSgSbQmhSJWkYrhf09e+9hf2
 xzoztFR3U4AWSM7MmXPOMPk7+6jh+vL6zfpmfXMJV7dX75bwdW0b50
 1XS/ggrTnA3hovbxf5+7DwFq7fri9v1lQJn/6Eqze3N2+X8EuvXS31
 Dj40Ggr49FdpGw9U+B7utesaKyt4OMCvV78t4aH30DsJWyvlptdWbj
 ddsZOvXoM3YGWnivIY9LU8hhip0c7LogKzhc2GEyjoXr1eMt7P322+
 +unbzcfvA1JZ+LIGXxce9hJPmpIY53njCgmWXh2WUChnoKgqaLwDs9
 dQY0dpYdsouaJqRrhzCCzh7od7aDBNqwOBs0S619LvjX1s9G6JONAW
 B/w9SnBSI09vGKM1T5KiSPW/NUc2xh5ANVhFUeK56YxRUBnp0Am6DW
 J631sE2g4quRPVPJdZFkoVD0qC6b1rKklODjhtC65/cAe0uF3Bna5G
 13yjmj9kcBLJVrI0fadCjwvnbV965ndxHNLnckbYIRYor45v6v6ihb
 3RaDIlN8QIPSVAVFDsWqk9TkUZnKexgL1VNb6SwRrC+Z9kngk27cxe
 2q4k9sfgCTZ6wM8ItsYSDnf2ZJNDiov8G2tafNO/9035CDtV6FLyVJ
 2ULfI0zjWYu4J79hJHUeCvw78b7ZtCEQfrFrmhGHn4zB5sGyTja1oO
 pj9K2VETJH86mEVO2drsoXCDT/TK+VEUODMkBTWGMYbQ+0YpkE9GPU
 mWwn7/KIliWa+Prqzbdt3tWPCXZMqqPCb++9+ALxa5EJGYxhNxhksk
 ExFFEzrGAleai3ki0kS8xJxoInJcuMF8zJxEiRCJmGXibCqwAo/nuI
 8muBcIMOWFhy9EgiCxmGHhTGR4sxAJhcQcj9juXEQx5RBORDSmtBEJ
 5nMhbRgtO0XLRB4zTlipmMXixZAZB5JjbS7Ow4YbpRElU2iIzs8GtJ
 h9OKnNUmY+ln8mCiWTCs7E75mYh+74JbEMwhYlzDA/7Rj2qXiB33AM
 fTEfj4iPCNw0CzcBLbTDG3KbLZqynFTMY54g3qScg5uMYTknZsxZsD
 RwGBQlo7qgdBQyOjlWhRWOqXgZqgKl2UScs+SJyPJ/ACIC+6mMBgAA
 AQ7PAVJldHJpZXZlck9wZXJhdG9yLDEwLDE7UmV0cmlldmVyT3Blcm
 F0b3IsMTEsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0
 RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaW
 Fnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZXJEaWFn
 bm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdW NlciwyMCwxMA=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1102
X-MS-Exchange-Forest-EmailMessageHash: 1B46C7A0
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

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


