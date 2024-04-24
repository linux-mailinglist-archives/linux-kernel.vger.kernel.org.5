Return-Path: <linux-kernel+bounces-156818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FA8B08A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E3D285CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C715AAAE;
	Wed, 24 Apr 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="p+8hKg66"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40015A4A1;
	Wed, 24 Apr 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959474; cv=none; b=i3vtW9Vr2VeP2TfQZTuCEiH43/K9Nke72wa1+YbIq7hREJxILOHU4Je+cDENDbDTFQIBQici9EmpbaHZVfHvUTHIJyqvSF09chxT9TailzC7RmkcvUtEfeGJeCzgvLvGyvgqgiPBKW0jbqYh2YpWDEqgjOBWqNidhicuxL1UwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959474; c=relaxed/simple;
	bh=0ASRLrYLM+eWKri3S7N5mLSo2FArHC34RbVnFY+i0/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GxAAQZvNhxvc9pMC0jxxtzgV1R/vkg0N1tgK0/sYTQ4kf7701Kij9x7OkeExPuVjbfj7y41JCFQfOc5ZOhUOpimGJhByRiAnmD6K9/mQ95w2bY6VKOw86VuS+oMs7BA/WaqZQxlcnDy2u+9lNJ2rmQOz2qRsSqzO+dAGc82AlYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=p+8hKg66; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713959461; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=ozLjALREGz/5ADpN3UYpLtAQzZ6fw/RdnvorAJ09Wvs=;
	b=p+8hKg662XSAiXfqhEmzDCY2U7PhfXxYzfW60nkIBPk8RBXQa8T2/lqT83A4nGF/hUUB4cSumO5Xim0YCFUTh8fIRKaTeSda7pr+Aer8kJJy9f4xpIghsO1Lh/27C2VYvkOahrM9tkcr86qaR7hvMS3DctJZR1W3Vcy8GpGV0WU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.XKLmvlB_1713959460;
Received: from smtpclient.apple(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XKLmvlB_1713959460)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 19:51:00 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
From: "Bojun Zhu" <zhubojun.zbj@antgroup.com>
In-Reply-To: <D0SAGP6DPKXF.2EHTXI9UH0HQ9@kernel.org>
Date: Wed, 24 Apr 2024 19:50:49 +0800
Cc: "=?UTF-8?B?SHVhbmcsIEthaQ==?=" <kai.huang@intel.com>,
  "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
  "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>,
  "=?UTF-8?B?Q2hhdHJlLCBSZWluZXR0ZQ==?=" <reinette.chatre@intel.com>,
  "Bojun Zhu" <zhubojun.zbj@antgroup.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D428BE51-20DA-42C5-A2B0-B264D7564700@antgroup.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
 <85dfbebc-a2d5-4828-b3b9-f929cd6e30cf@antgroup.com>
 <D0S5S2NL1N5P.3Q0SM01VIZBJX@kernel.org>
 <D0SAGP6DPKXF.2EHTXI9UH0HQ9@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Jarkko,

> On Apr 24, 2024, at 18:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed Apr 24, 2024 at 10:02 AM EEST, Jarkko Sakkinen wrote:
>> On Wed Apr 24, 2024 at 9:46 AM EEST, Bojun Zhu wrote:
>>> Based on the the discussion among you, Jarkko and Reinette,
>>> I will keep the need_resched() and wrap the logic in using =
sgx_resched(),
>>> as suggested by Jarkko.
>>=20
>> Sounds like a plan :-)
>=20
> In sgx_ioc_enclave_add_pages() "if (!c)" check might cause possibly
> some  confusion.
>=20
> Reason for it is that in "transaction sense" the operation can
> be only meaningfully restarted when no pages have not been added
> as MRENCLAVE checksum cannot be reset.
>=20
> BR, Jarkko
>=20


Thanks for your reminder.

According to the SGX hardware specification, similar to "ADD PAGES=E2=80=9D=
,
the operations in  "MODT PAGEs=E2=80=9D and  "REMOVE PAGEs(at =
runtime)=E2=80=9D =20
can be only meaningfully restarted when no page has been handled.

For the following code in sgx_ioc_enclave_add_pages():

```c
if (signal_pending(current)) {
	if (!c)
		ret =3D -ERESTARTSYS;

	break;
}
```
I still have some questions:

It seems that the variable "ret" is set to 0 if there is **some** EPC =
pages have been=20
added when interrupted by signal(Supposed that sgx_encl_add_page()=20
always returns successfully).

Shall we set the return value as "-EINTR" if the context is interrupted =
by=20
signal when some EPC pages have been added?
(BTW, return values contain -EINTR as shown in
=
https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/cpu/sgx/ioc=
tl.c#L402)

Please correct me if misunderstood it.

Regards,
Bojun=

