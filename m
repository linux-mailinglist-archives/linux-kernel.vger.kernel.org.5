Return-Path: <linux-kernel+bounces-162362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955748B59CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5184B288FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722B6EB62;
	Mon, 29 Apr 2024 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBTHOBa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAA56B69;
	Mon, 29 Apr 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397049; cv=none; b=IDnYx7SR2PvUf79v+p2OyJe5LIoYIBLz0rDvIZHa5aw5pa/5LCtcGy9oLHdeVzZniSRV1iKQzy7O/GC7WQkpfBnd4uewzGgJMKTuluo6Lr4yAasnaQvWxv5jdpegupVTxUI6VqfF7ZMZwWpk2ZJEaNUlkrGIo9xbR++7kFqwCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397049; c=relaxed/simple;
	bh=0iGZhh+y6263lgeqrhY9RIljh9ZAAzgpP8vZKYNQA80=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pBp/ADzf8FZqLp4vMNz7Zv3tHAqLSBxrDb5JodOV2xfsTIKB8gWFwWA2m25ZPa2Q3nGC2RLV4gHek2rZdj/u7sA08bcirjJwCKqbMUIYueBvZXMpJdm6lD4Q3IM+Jl9ThYU9GF+abTDfb/XpOjs6ZXCTZopsOkAJ1rfym0bruj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBTHOBa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD472C113CD;
	Mon, 29 Apr 2024 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397049;
	bh=0iGZhh+y6263lgeqrhY9RIljh9ZAAzgpP8vZKYNQA80=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UBTHOBa4pSCJq07jjcpv1aF418HzWkPXOnDyYDs1wEILs6ixgimOhxxBRwzq9Y3KZ
	 lplpqQCoPc7BDJ3gO98UeNtrcwZWSqJuGKaETlxeZRVBNbGombo0Oiomdlz0kvL+Uw
	 /7vkNF7Wxru6yZx9MOKTPKkCfiYmLN6oou6tnerxsO5JkKFOtOvHDmSTnwDwCUiSKl
	 Wm61RPVlFMcXUmo5NP8yGqX2cQJ5+JnQoJHZo3iIArxbLXA+bq2nGTiCBKfc0h6asZ
	 sZFafLXCQiQqZIaFw38BVMH83KWEbjvWzEpWYV/uoi1NkBgVZXKh1FjYBOFqiyB5yQ
	 ijCvrG4BRYGdA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:24:04 +0300
Message-Id: <D0WN15R16S1S.PRG8LSXA8470@kernel.org>
Cc: <mona.vij@intel.com>, <kailun.qin@intel.com>, <stable@vger.kernel.org>,
 =?utf-8?q?Marcelina_Ko=C5=9Bcielnicka?= <mwk@invisiblethingslab.com>
Subject: Re: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread
 returns SIGBUS
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Dmitrii Kuvaiskii"
 <dmitrii.kuvaiskii@intel.com>, <dave.hansen@linux.intel.com>,
 <kai.huang@intel.com>, <haitao.huang@linux.intel.com>,
 <reinette.chatre@intel.com>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
 <20240429104330.3636113-2-dmitrii.kuvaiskii@intel.com>
 <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>
 <D0WN0B2JL7N4.V0GPQWA79SJ5@kernel.org>
In-Reply-To: <D0WN0B2JL7N4.V0GPQWA79SJ5@kernel.org>

On Mon Apr 29, 2024 at 4:22 PM EEST, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 4:04 PM EEST, Jarkko Sakkinen wrote:
> > > Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Li=
nux
> > > fault handler so that no signal is sent to userspace, and (2) by
> > > replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that n=
o
> > > EREMOVE is performed.
> >
> > What is the collateral damage caused by ENCLS[EREMOVE]?
>
> Have you measured cost of eremove on an empty page?
>
> I tried to lookup for a thread from lore because I have a faint memory
> that it was concluded that its cost irrelevant. Please correct if I'm
> wrong.

Also pseudocode for EREMOVE supports this as it just returns without
actually doing anything.

BR, Jarkko

