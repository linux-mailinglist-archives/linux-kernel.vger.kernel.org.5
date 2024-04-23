Return-Path: <linux-kernel+bounces-155921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB38AF8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF881C23065
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D533143889;
	Tue, 23 Apr 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WorFhiHq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182313CFA4;
	Tue, 23 Apr 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907641; cv=none; b=p1uF2JS+4bjYuKGH3E3DqWZF6L0cquMW6jNTy9bdllCtDPUbViW2+C+JxnUzw+J8UioFaLxQIe1mgJFzAGgJILsgP9y2lfBISuoqj8vxZ/jggooTYtLVwV1k9+q3Lvxfk1j0VLxxjIkkfZhHPDzMVDE33WY5S0rUUA0ZQjR5o9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907641; c=relaxed/simple;
	bh=6tyOviKiBGRE0qFEG4rgVtjiOf1N2SmnrIhbrSSblFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e/wnaZP5iyWvx03bjFUImTACAoD5+84JCRzHmtk1L0SSjHwsoGhu9rQcBCH/KuGXnpm/zkcdnhbO847+kl53+14kjMg7V3FpXx0eENx3WsjqItbEAaos/3xOyk69f68aPz5bc3AEGau/RsR0YgaVILS6hZZA3Em+WhJeGsUnDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WorFhiHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF370C116B1;
	Tue, 23 Apr 2024 21:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713907641;
	bh=6tyOviKiBGRE0qFEG4rgVtjiOf1N2SmnrIhbrSSblFM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WorFhiHqcbeV3/CwVjWejS3bkBiOqKie8srE3Rr5L+dbRjfSHk4b5W1txDeLGyKGe
	 icYTJc5wtl27xguinwLwZq/Ma8VerE313J/eFen1ZscxaU8OIt3RTiGiQCYIeWftTK
	 abslo5e/o8QMDU9l3jPz09NSGV5S0RxaQqShk8XqVmhPCm9vwsv2BAd75QPO3YjGSK
	 g6+Goq9f7MOto6mjYCN3hFXyI2SfCKzHB1TAyfdHuXLDXHgFYoLuk7p0BMpYPTGzm7
	 NLAbqAynui7rRAQqF3nkGG1PrAXtosRnAJrCWHlHT1GmghPSWGZ9Nwqyp6xv5tYIhC
	 rHn6PagUBB98A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 00:27:18 +0300
Message-Id: <D0RTJVEHLLZ8.3967ZI3I5UO28@kernel.org>
Cc: "Liu, Shuang" <ls123674@antgroup.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Reinette Chatre" <reinette.chatre@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "zhubojun.zbj@antgroup.com"
 <zhubojun.zbj@antgroup.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
 <bfdb5787-65db-4c64-bce1-d39f37ad09fa@intel.com>
In-Reply-To: <bfdb5787-65db-4c64-bce1-d39f37ad09fa@intel.com>

On Tue Apr 23, 2024 at 8:08 PM EEST, Reinette Chatre wrote:
> Hi Kai,
>
> On 4/23/2024 4:50 AM, Huang, Kai wrote:
> >> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx=
/ioctl.c
> >> index b65ab214bdf5..2340a82fa796 100644
> >> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> >> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> >> @@ -806,6 +806,9 @@ sgx_enclave_restrict_permissions(struct sgx_encl *=
encl,
> >>  		}
> >> =20
> >>  		mutex_unlock(&encl->lock);
> >> +
> >> +		if (need_resched())
> >> +			cond_resched();
> >>  	}
> >> =20
> >>  	ret =3D 0;
> >> @@ -1010,6 +1013,9 @@ static long sgx_enclave_modify_types(struct sgx_=
encl *encl,
> >>  		entry->type =3D page_type;
> >> =20
> >>  		mutex_unlock(&encl->lock);
> >> +
> >> +		if (need_resched())
> >> +			cond_resched();
> >>  	}
> >> =20
> >>  	ret =3D 0;
> >> @@ -1156,6 +1162,9 @@ static long sgx_encl_remove_pages(struct sgx_enc=
l *encl,
> >>  		kfree(entry);
> >> =20
> >>  		mutex_unlock(&encl->lock);
> >> +
> >> +		if (need_resched())
> >> +			cond_resched();
> >>  	}
> >>
> >=20
> > You can remove the need_reshced() in all 3 places above but just call
> > cond_resched() directly.
> >=20
>
> This change will call cond_resched() after dealing with each page in a
> potentially large page range (cover mentions 30GB but we have also had to
> make optimizations for enclaves larger than this). Adding a cond_resched(=
)
> here will surely placate the soft lockup detector, but we need to take ca=
re
> how changes like this impact the performance of the system and having act=
ions
> on these page ranges take much longer than necessary.
> For reference, please see 7b72c823ddf8 ("x86/sgx: Reduce delay and interf=
erence
> of enclave release") that turned frequent cond_resched() into batches
> to address performance issues.
>
> It looks to me like the need_resched() may be a quick check that can be u=
sed
> to improve performance? I am not familiar with all use cases that need to=
 be
> considered to determine if a batching solution may be needed.

Ya, well no matter it is the reasoning will need to be documented
because this should have symmetry with sgx_ioc_enclave_add_pages()
(see my response to Kai).

I because this makes dealing with need_resched() a change in code
even if it is left out as a side-effect, I'd support of not removing
which means adding need_resched() as a side-effect.

From this follows that *if* need_resched() needs to be removed then
that is not really part of the bug fix, so in all cases the bug fix
itself must include need_resched() :-)

phew, hope you got my logic here, i think it reasonable...

BR, Jarkko

