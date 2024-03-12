Return-Path: <linux-kernel+bounces-100465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3248797DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8932F1F22AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31807CF04;
	Tue, 12 Mar 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TemBDO3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DBF79B65;
	Tue, 12 Mar 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258186; cv=none; b=GV4Ev5kMvke3HhqQh/j9XpNV+u8ieOO4J3FTjMJzkrMBq43mYJYqyJ3iaxwX1dYlRHPqjFVqQSJdDdOxXSR+AqH8d/yYlgoYmJofe9KvroKpGjVl3azdVxlJqdhwQNJk+ugbypG/vUoyE8ZOp7yRQpCHO4l4P+66b1Q08L8Yu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258186; c=relaxed/simple;
	bh=saSsJLPGKVqRyifWAvITNA+MsAjtts2uqCkZdCGrjgs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ekeFA6reD+erHbw4vaE4wLZnceCBCD1z60Kj492/vfK0FIE8RWWDHqkWNKNA5MB+wgWxvbu1Nd98L8/EA0aG5ygSiM6AUr8TlxJ43kUatsuNqjM18y++1fpBLo+DRxGMpSRIuQWKIhAYsHjz3gVZpiBP6Jn266bfjnbpSzujd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TemBDO3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F2CC433C7;
	Tue, 12 Mar 2024 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258185;
	bh=saSsJLPGKVqRyifWAvITNA+MsAjtts2uqCkZdCGrjgs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TemBDO3nAYXN5PjNextlJQDVn+cFCmHn/AifJjXH6yecbnsdNN8Ous1QY12Ws6cGx
	 2eRXf8mSyuVI3HwcyjjVcIk91kh534i8hyGyDbalN1eZXfkQs8Pu56OJvudVLCWp2N
	 fPdsDzwUn+99Jh8zVJwhktzAUB1IG0habTa2gU7ksuArwToqzBSa4vmVRZNSsKrp1s
	 fjKckEktCEAjODpf8UymIbvTGSTv1tpJyXHGaFaWJSsUinXKYRGwerCLQ2p5D3yzM8
	 QsDbA09IbM0jG5La0Z+u23T/tBCKlpI3Xg4/J7AIfG6p9yk0veQNhXzNbAmvlykzNi
	 iWrLDRvuUxmAw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 17:43:01 +0200
Message-Id: <CZRVXE96ZZA8.33VFES8S07YS9@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] tpm: of: If available use linux,sml-log to
 get the log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>, <devicetree@vger.kernel.org>,
 <jsnitsel@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-4-stefanb@linux.ibm.com>
 <CZR7B45P71XS.53XNZD9FWZSL@kernel.org>
 <916fb19b-daf8-4c1b-bc25-f071d2b3ae33@linux.ibm.com>
In-Reply-To: <916fb19b-daf8-4c1b-bc25-f071d2b3ae33@linux.ibm.com>

On Mon Mar 11, 2024 at 10:33 PM EET, Stefan Berger wrote:
>
>
> On 3/11/24 16:25, Jarkko Sakkinen wrote:
> > On Mon Mar 11, 2024 at 3:20 PM EET, Stefan Berger wrote:
> >> If linux,sml-log is available use it to get the TPM log rather than th=
e
> >> pointer found in linux,sml-base. This resolves an issue on PowerVM and=
 KVM
> >> on Power where after a kexec the memory pointed to by linux,sml-base m=
ay
> >> have become inaccessible or corrupted. Also, linux,sml-log has replace=
d
> >> linux,sml-base and linux,sml-size on these two platforms.
> >>
> >> Keep the handling of linux,sml-base/sml-size for powernv platforms tha=
t
> >> provide the two properties via skiboot.
> >>
> >> Fixes: c5df39262dd5 ("drivers/char/tpm: Add securityfs support for eve=
nt log")
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >=20
> > I'm worried about not being up to date and instead using "cached" value=
s
> > when verifying anything from a security chip. Does this guarantee that
> > TPM log is corrupted and will not get updated somehow?
>
>
> What do you mean 'guarantee that TPM log is corrupted'?

I presume that this is for power architecture but I have no idea what
leads log being corrupted, and is the scope all of that that arch or
some subset of CPUs.

The commit message is not very detailed on kexec scenario. It more like
assumes that reader knows all the detail beforehand. So probably this
will start to make sense once the backing story is improved, that's
all.

> The TPM was handed over from the firmware to Linux and the firmware then=
=20
> freed all memory associated with the log and will then not create a new=
=20
> log or touch the TPM or do anything that would require an update to the=
=20
> handed-over log. Linux also does not append to the firmware log. So=20
> whatever we now find in linux,sml-log would be the latest firmware log=20
> and the state of the 'firmware PCRs' computed from it should correspond=
=20
> to the current state of the 'firmware PCRs'.

So on what CPU this happens and is there any bigger picture for that
design choice in the firmware?

If it is a firmware bug, this should emit FW_BUG log message. If not,
then this commit message should provide the necessary context.

BR, Jarkko

