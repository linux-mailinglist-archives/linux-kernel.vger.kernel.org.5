Return-Path: <linux-kernel+bounces-88088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADEE86DD37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6806C289B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF869DFC;
	Fri,  1 Mar 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uXYrv/7Z"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56B6997D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282331; cv=none; b=MjLcTkEzMF0VQ8/jKCopQ5Jn0nBZtIGybYOLoXY7V39Tth7Smszecag1yuql7yF5up0mdZJMLmC4bSwVjk2bhbmVoa4c2Ce5wPghSv92nYbL8Kqx+E9jVylojROk0X4JInv7tZSrCo4DHfQJrICO+gWaRpeAXXUDHgO1TDx/HfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282331; c=relaxed/simple;
	bh=vuG8csCkwvbPWQAQ1iQPW5EjQIodYKZO0NB6u/TNuN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LE/7NmzFyzE7w8JIGDAap0IbX2NxHD0p62LzQuIu8mBTAo3Zn7X30zEMTi3EmJe4eZofE4l7A+g13UgAozagDBF8TJc0IlnWeizqzT1b10EfH3xsT9V5V0d10XnCvjfEn5N+ab6XS3URM1P9gWeKeVz7yyH3mPUhrK+OPywxq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uXYrv/7Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vuG8csCkwvbPWQAQ1iQPW5EjQIodYKZO0NB6u/TNuN8=;
	t=1709282325; x=1710491925; b=uXYrv/7ZiAiw/TLc8KaMycRFgrsO/fj3X6JqATETgsU8hex
	TXK27O+AtvAlc6prdsObtGxGfmErbwSxb+thDQGMP4yp9WjuvL0dxHOlqCML1DpHjhnOPiCfs/g1u
	QmRwyg7kIoE9wQ11v8x3lTj3XjyRfNjO0167wCrrA93iSHx0/8As2BWZeXJHM1SBWJbwPk5xBoPHw
	p+7yTDNn5uXObgT2u8J9oS339HD4AG6LGDltFofsEzf1L+QOP9JauDcOk0E3Kj23TlyDDCMwF/RT6
	3Jmve4svC0dgxkCtzlRk1IzgoNvGzU7kqaxhrqbIgnwyPDqWzo+tEdy7Il8VjXTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfyPh-0000000EqAR-03E2;
	Fri, 01 Mar 2024 09:38:41 +0100
Message-ID: <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Souza, Jose" <jose.souza@intel.com>, "intel-xe@lists.freedesktop.org"
	 <intel-xe@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	 <quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Date: Fri, 01 Mar 2024 09:38:39 +0100
In-Reply-To: <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
	 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
	 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-02-28 at 17:56 +0000, Souza, Jose wrote:
>=20
> In my opinion, the timeout should depend on the type of device driver.
>=20
> In the case of server-class Ethernet cards, where corporate users automat=
e most tasks, five minutes might even be considered excessive.
>=20
> For our case, GPUs, users might experience minor glitches and only search=
 for what happened after finishing their current task (writing an email,
> ending a gaming match, watching a YouTube video, etc.).
> If they land on https://drm.pages.freedesktop.org/intel-docs/how-to-file-=
i915-bugs.html or the future Xe version of that page, following the
> instructions alone may take inexperienced Linux users more than five minu=
tes.

That's all not wrong, but I don't see why you wouldn't automate this
even on end user machines? I feel you're boxing the problem in by
wanting to solve it entirely in the kernel?

> I have set the timeout to one hour in the Xe driver, but this could incre=
ase if we start receiving user complaints.

At an hour now, people will probably start arguing that "indefinitely"
is about right? But at that point you're probably back to persisting
them on disk anyway? Or maybe glitches happen during logout/shutdown ...

Anyway, I don't want to block this because I just don't care enough
about how you do things, but I think the kernel is the wrong place to
solve this problem... The intent here was to give some userspace time to
grab it (and yes for that 5 minutes is already way too long), not the
users. That's also part of the reason we only hold on to a single
instance, since I didn't want it to keep consuming more and more memory
for it if happens repeatedly.

johannes

