Return-Path: <linux-kernel+bounces-48584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D637A845E73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7530A1F24E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0A5E3A8;
	Thu,  1 Feb 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UmpFDUEY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DE63098
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808181; cv=none; b=t9h7/hNXHpPj+wbL4mCBz61HVBXKzwi8+DRT5/kv5zw9P8G5sh58lCKBD9JSXb97AvnXE5S3RugPpgxEXMHbYtuEWVQ8ooznUFi6fn9MYjmK79a5HgNQtuFYZlw5tuWcA7DqV1BKkcvgR504t0NzC8EExSv1alf+rb6cLdo0ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808181; c=relaxed/simple;
	bh=SjzQZTD+sIbiu6w9HzyUneWmrJHrZfAbUcEvaaBl5Rc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L0QVz1lqPQuGDDewfui5Tdgh/MrdooVTj5uyWGiS8WOQzjYMq5g5cUjQXgzklLGra/43tHuuaF6wWKH6weaMML9DMwZr82LVrOmrSTbQtJ6AEOqx2xu0MrSWFHbbEv0ArlDnATHz8fGhNqteFVWUikA81YJ3HLXRAi2A6uuIJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UmpFDUEY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 411HMB4D4123592
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 1 Feb 2024 09:22:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 411HMB4D4123592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706808133;
	bh=qDm9VDWqRsWDkKkO2YQaFYPv/FOs5ua9dgqvY62NzlE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UmpFDUEYl3+HEiif9hUV7hvuzkJSK+BxPCg7Gs83v/h0mQE0ZnDfrxX4o0TH31ugc
	 GaUC+SVRQ6GZobJAiC+hGRTM5+WFD1HkRPmxrs1qFXt6PpKIRGaGyIcCBarCJuWR9N
	 o6YDDKkpIvXeD0ZmlyTMy8xEuDH8hRUCav5Dfq1kVkIpHBywZgdT7778ZEPBTW6Vwi
	 IypLNKbOfcXmn5SjfwePABKBBzLrFyt0jhKAoJyjWP/8Ewa+vyQLQfW1YmbuDQNh9r
	 yGxbBY0ENg41LzYDG803Ail7CggJQBwNg1V3E3JgljPhqXQWGEclIimQIiPdpAifeQ
	 2V9cq242161sg==
Date: Thu, 01 Feb 2024 09:22:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?UTF-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?= <junichi.nomura@nec.com>,
        Borislav Petkov <bp@alien8.de>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "nikunj@amd.com" <nikunj@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "debarbos@redhat.com" <debarbos@redhat.com>,
        "jlelli@redhat.com" <jlelli@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "dzickus@redhat.com" <dzickus@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/boot: Add a message about ignored early NMIs
User-Agent: K-9 Mail for Android
In-Reply-To: <TYCPR01MB83890E6AAACF90C3A45A8E0F83792@TYCPR01MB8389.jpnprd01.prod.outlook.com>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp> <20240112120616.5zjojjmjeqg5egb7@box> <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp> <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local> <TYCPR01MB8389C46BF755C31EACE8DB37837B2@TYCPR01MB8389.jpnprd01.prod.outlook.com> <c0527ca3-22c3-4b92-a34f-adf0cae78146@zytor.com> <TYCPR01MB83890E6AAACF90C3A45A8E0F83792@TYCPR01MB8389.jpnprd01.prod.outlook.com>
Message-ID: <411D32E2-4D7F-457A-B61A-731E1264CAA8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 25, 2024 6:15:15 PM PST, "NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=
=80=80=E6=B7=B3=E4=B8=80)" <junichi=2Enomura@nec=2Ecom> wrote:
>> From: H=2E Peter Anvin <hpa@zytor=2Ecom>
>> On 1/24/24 03:44, NOMURA JUNICHI(=E9=87=8E=E6=9D=91 =E6=B7=B3=E4=B8=80)=
 wrote:
>> >> From: Borislav Petkov <bp@alien8=2Ede>
>> >> On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA JUNICHI(=E9=87=8E=
=E6=9D=91 =E6=B7=B3=E4=B8=80) wrote:
>> >>> +	if (spurious_nmi_count) {
>> >>> +		error_putstr("Spurious early NMI ignored=2E Number of NMIs: 0x")=
;
>> >>> +		error_puthex(spurious_nmi_count);
>> >>> +		error_putstr("\n");
>> >>
>> >> Uff, that's just silly:
>> >>
>> >> Spurious early NMIs ignored: 0x0000000000000017
>> >>
>> >> Would you like to add a error_putnum() or so in a prepatch which wou=
ld
>> >> make this output
>> >>
>> >> Spurious early NMIs ignored: 23=2E
>> >>
>> >> ?
>> >>
>> >> So that it is human readable and doesn't make me wonder what that he=
x
>> >> value is supposed to mean?
>> >
>> > Yes, it would be nicer to print that way=2E  I used the existing erro=
r_puthex() just
>> > to keep the patch minimal=2E  I will try to add error_putnum()=2E
>> >
>> >> Btw, please use this version when sending next time:
>>=20
>> Here is a *completely* untested patch for you=2E=2E=2E
>
>Ah, I was preparing decimal only version but yours is much better=2E
>I tested and it just works=2E
>
>I would like to use yours as a prepatch=2E  May I have your signed-off-by=
?
>
>--
>Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd=2E

Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

