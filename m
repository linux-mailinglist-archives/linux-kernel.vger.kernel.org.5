Return-Path: <linux-kernel+bounces-39068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C256583CA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022E41C25558
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749DC1339A3;
	Thu, 25 Jan 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rrPGGLr4"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F0130E52;
	Thu, 25 Jan 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205830; cv=none; b=eQ4r5VJjecS0JuH9qRtff60T0hOQ//6JwpmoOVHKsLZktJGl3WFj8VRWWMyQiedYLJjcDAfZ+cVEWCSwd8fligBb0VbkYmXXthcih9JsMIDzwlp+8gNPA5KZK1H9EQ0/TAc3fICLBTNk/EdLpDdmC44zqR4v92PAFv3eG2t6/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205830; c=relaxed/simple;
	bh=f0VirH3aoOMfVFq19AkhrwdHXxAYRf5CyVpkEEI0bCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzIX0Rt+tsVUWKrwPsqkFcd7ZVWq+lKVJbUSjiEuJKOQ633hHRubxDqtBNf7ksEgfwJOVxso1tWFwpYjqduX/kAKnIlbj9DwbODAz0Ilz/AaOFU+3DDWHVjKAZ+gfV2cR1mAIDMLSF4C+kg8SJohMbdQa04lVdaOuvaclKesStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rrPGGLr4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706205822;
	bh=f0VirH3aoOMfVFq19AkhrwdHXxAYRf5CyVpkEEI0bCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rrPGGLr4NzgbTLCvykTOggvEt7AnRyruooAhV1XtwsJAHgsX6bgpGqsUs4ycj4YmT
	 t9LI8IW8jd/O9NqeVPqoqAq1HqRNmDjQIlcuWuaA+rYO1OER3llN73gUFYeYCP3UBM
	 bBUg77utUaw7igSDSnhmqHsgQE/7k/Aaj6kRK4IhvcYi+CmtQA1xHaywHlWHH+DPPA
	 o9JGkesH79Rqp9b5stnLDykP89RQl7/fMEWCevvHJfyxai6PjvZWujBD+hcAqSgDao
	 5q/kkYZTT6allIs4IoLAm52OBjGCu/n+4se2Qqay8De4A4O97SuLWPKxF5seMwfACK
	 BRjge497JUL+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLTGP6gdRz4x7q;
	Fri, 26 Jan 2024 05:03:41 +1100 (AEDT)
Date: Fri, 26 Jan 2024 05:03:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20240126050339.58b9131e@canb.auug.org.au>
In-Reply-To: <ZbJwMyCpz4HDySoo@MiWiFi-R3L-srv>
References: <20240125142907.33015c9f@canb.auug.org.au>
	<ZbJwMyCpz4HDySoo@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iR0Z=g9BdJGL7_56aZmEqQk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iR0Z=g9BdJGL7_56aZmEqQk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Baoquan,

On Thu, 25 Jan 2024 22:29:07 +0800 Baoquan He <bhe@redhat.com> wrote:
>
> I reproduced the failure with allnoconfig on ppc, and found below change
> can fix it too. And the change makes ARCH_SELECTS_KEXEC consistent with
> ARCH_SELECTS_KEXEC_FILE on the dependency. What do you think?

Makes sense to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/iR0Z=g9BdJGL7_56aZmEqQk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWyonsACgkQAVBC80lX
0GwqDQf8Co2Rwr1bjHmMJDNCKFi+I7JzMls5lcBh4eLGzGeoPB4ZaCJ9Va4YJSMq
v9EZkk6JuYnTaZ1Kl0Nlz+8g9wdTt77+bTRJiCkxwDmTihaknn636s0HXePxQvSJ
luyRLJxJGRgB9Ln5H+pAjj1JQq4yKD9xBW0RKwZHlBHy8s8r/ubZu6xqvI3+hECD
LoOWxgDxL6LLe+fbweaAOCxWas2qjTyS4f5oSGdhPtZC7fBaw0FY29tXkem+3r6C
7gp6hHaqzoIQ5ZskPLknQ+AI2RzsLSbcf7Tt1kF45ghPOtnavdHuyUqI6KZAZgmU
Rfl1nnYq+wOubfl0mDceIG50q1FuDA==
=+oJq
-----END PGP SIGNATURE-----

--Sig_/iR0Z=g9BdJGL7_56aZmEqQk--

