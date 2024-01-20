Return-Path: <linux-kernel+bounces-31747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CE833351
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E2282B17
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B848F55;
	Sat, 20 Jan 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Vly5evUB"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F755381;
	Sat, 20 Jan 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705741283; cv=none; b=YdsrMpCN7zTr/2jozwZgR1V+e6W97rr4rq2VRc+Qzer96OkvBakKVmhinLi0EBwj0Rs35FnQonAlYzxjKhkAHaN6Lcov48gvWc0T9dAkqAGnnZyjrWzWwBhVol3yxzgX538xbdojrbQMlQk6A/n1/VdkKRgv3IA60D5fj7R99Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705741283; c=relaxed/simple;
	bh=lPXJNVUz1/fxRSsS978CphntnmhX4z/aYDogC1GW6zw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VsJqyr1FHVwQzaJjig2GVZBqBWknbLMHBynYn6QaTH0FiIDjlGmmfTnqLD2p3fVbt/cJMni3gnDNad5bYWuJ8YyIIZkcNI30ssdL9hFDAoFPh0Vc95V5275lqwC7RwFE67+a/l1pol9o0qcz7wW/lKJz4KGwEDmMzadNmPkUQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Vly5evUB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40K8N2VF1422225
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 20 Jan 2024 00:23:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40K8N2VF1422225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705738988;
	bh=aZJr2zzOCbDOkGwxtzRA09fk3E/DAYeJRrK4E21Gt3c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vly5evUBwlByZI3SYmfdzkHI4CXMNuCX8pyZvJeZzeu7xZt3fYyNMWnX+UAepeZLF
	 TNecSnOrFb6g/VzC7UpOMHQJ4cNaC0KPjibXjvLi+yTwu2BpxUWmWNlDZhmBgf2SoW
	 MNgrOtThybINUZ1uFmT3O04FS0vre6trudKUndRuaqSstBzMA0JJpshRaC/SXamuhr
	 bBo67i6WfCXwqixEvyMbelIhFGSfCS67zQV93NxRsQzAMy2sELFdY4KipUo3Y2/aZt
	 0vGOP1lkjBHdcEY0+SIgYiU+zhLlyfldE4fhYPXyGxgOyCgL+ENDPmOFh5zVsnTzRD
	 94gHU8qNWzpsg==
Date: Sat, 20 Jan 2024 00:22:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>
CC: x86@kernel.org, rostedt@goodmis.org, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
User-Agent: K-9 Mail for Android
In-Reply-To: <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org> <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
Message-ID: <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 19, 2024 10:58:56 PM PST, Thorsten Glaser <tg@debian=2Eorg> wrot=
e:
>Peter Zijlstra dixit:
>
>>-/* generic versions from gas
>[=E2=80=A6]
>>-   3: leal 0x00(%esi),%esi
>>-   4: leal 0x00(,%esi,1),%esi
>>-   6: leal 0x00000000(%esi),%esi
>>-   7: leal 0x00000000(,%esi,1),%esi
>
>vs=2E
>
>>+ * Generic 32bit nops from GAS:
>[=E2=80=A6]
>>+ * 3: leal 0x0(%esi),%esi
>>+ * 4: leal 0x0(%esi,%eiz,1),%esi
>>+ * 5: leal %ds:0x0(%esi,%eiz,1),%esi
>>+ * 6: leal 0x0(%esi),%esi
>>+ * 7: leal 0x0(%esi,%eiz,1),%esi
>>+ * 8: leal %ds:0x0(%esi,%eiz,1),%esi
>
>I think there=E2=80=99s some mistake introduced=2E The BYTES_* are
>identical for e=2Eg=2E #7, but %eiz must be wrong, it=E2=80=99s not
>a register=2E Indeed, gas (on Debian bullseye) does not
>assemble that either=2E
>
>(Awful AT&T syntax aside=E2=80=A6)
>
>bye,
>//mirabilos

%eiz was something that binutils used to put in when disassembling certain=
 redundant encodings with SIB at some point=2E

