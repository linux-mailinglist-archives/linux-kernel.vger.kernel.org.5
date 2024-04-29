Return-Path: <linux-kernel+bounces-161682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101368B4F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C26B1F21856
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345117FD;
	Mon, 29 Apr 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="i0VpV/Ky"
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCED7F;
	Mon, 29 Apr 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714357735; cv=none; b=MwgczTHvdh+ZLlNb5wFA5u6Ned2/tFomZQDN3UjzZjirOfBYNFOZlUqkGf+NCYy7op/nJMGUYfR5rHAehaEUoyAkMgpooxRExgjyKbWPh0hbDzyiiClTBuB1Od+tIJjKf1Lmpf1ULXS0nBSdDDuvLOdqU5mnPBxxTijL3SHR36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714357735; c=relaxed/simple;
	bh=rgmPIBtv04xS/NJZfML1GPnR64jTHK95wha30aKgRC4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aSGm0At9IskOcQstmx1ZV1AGxdeIQCnKHNkhzxlErXgQJyZLFWMYswbeVZLVbdHaAOfY3v8kCvpSqwQme/J13MKAZaJLhOT4uJELY3OeHCxBsTEG8mDR3FWfbEqlU0+nHScPrG1k/B3kbw7w0XrBKFSJ+GcfJBg+FANygltFGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=i0VpV/Ky; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714357723; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=jT7mAVU8gcg5YtFTPn+gZh0CF87ozRgd/5PRarkdmMI=;
	b=i0VpV/KyTRQi8K95bjKOx/1QLAyxIicE2syfgPkD5XOEvDPUcLg7J7cwP8RaexXxHUQCfExiECdSy7/Qp044us0jD5ThWHSAurp760LQW6uUFQNM6MyInLcqf4+a9yWj2+JtA8oXynxs9nUh9K197Egn6gV0rZH2S/tS5eZQSJs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XNqNRHq_1714357403;
Received: from smtpclient.apple(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XNqNRHq_1714357403)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 10:23:24 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [RFC PATCH v2 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
From: "Bojun Zhu" <zhubojun.zbj@antgroup.com>
In-Reply-To: <30415ed3-a05a-454d-9077-c8674617f291@intel.com>
Date: Mon, 29 Apr 2024 10:23:12 +0800
Cc:  <linux-kernel@vger.kernel.org>,
   <linux-sgx@vger.kernel.org>,
  "Jarkko Sakkinen" <jarkko@kernel.org>,
   <dave.hansen@linux.intel.com>,
  "=?UTF-8?B?Q2hhdHJlLCBSZWluZXR0ZQ==?=" <reinette.chatre@intel.com>,
  "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7EBCAA4-6412-42AE-9A56-36914E22B4A1@antgroup.com>
References: <20240426141823.112366-1-zhubojun.zbj@antgroup.com>
 <20240426141823.112366-2-zhubojun.zbj@antgroup.com>
 <30415ed3-a05a-454d-9077-c8674617f291@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Dave,

Appreciate for your review!

> On Apr 27, 2024, at 01:06, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 4/26/24 07:18, Bojun Zhu wrote:
>> 	for (c =3D 0 ; c < modp->length; c +=3D PAGE_SIZE) {
>> +		if (sgx_check_signal_and_resched()) {
>> +			if (!c)
>> +				ret =3D -ERESTARTSYS;
>> +
>> +			goto out;
>> +		}
>=20
> This construct is rather fugly.  Let's not perpetuate it, please.  Why
> not do:
>=20
> 	int ret =3D -ERESTARTSYS;
>=20
> 	...
> 	for (c =3D 0 ; c < modp->length; c +=3D PAGE_SIZE) {
> 		if (sgx_check_signal_and_resched())
> 			goto out;
>=20
> Then, voila, when c=3D=3D0 on the first run through the loop, you'll =
get a
> ret=3D-ERESTARTSYS.
>=20

Okay, I will refine it later.

> But honestly, it seems kinda silly to annotate all these loops with
> explicit cond_resched()s.  I'd much rather do this once and, for
> instance, just wrap the enclave locks:
>=20
> -	  mutex_lock(&encl->lock);
> +	  sgx_lock_enclave(encl);
>=20
> and then have the lock function do the rescheds.  I assume that
> mutex_lock() isn't doing this generically for performance reasons.  =
But
> we don't care in SGX land and can just resched to our heart's content.


`mutex_lock(&encl->lock)` appears in everywhere in SGX in-tree driver.
But it seems that we only need to additionally invoke `cond_resched()` =
for
the sgx_enclave_{restrict_permissions | modify_types | remove_pages }=20
and sgx_ioc_add_pages()=E2=80=99s ioctl()s.=20

Shall we replace all the `mutex_lock(&encl->lock) with =
`sgx_lock_enclave(encl)`=20
in SGX in-tree driver and then wrap reschedule operation in
`sgx_lock_enclave()` ?=20

Regards,
Bojun=

