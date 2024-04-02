Return-Path: <linux-kernel+bounces-128739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33F895EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23A21C210C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879F15E5DB;
	Tue,  2 Apr 2024 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fBZOG6WW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6075BAD7;
	Tue,  2 Apr 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094059; cv=none; b=lS9KXB31vH6wEjTBXonVVqVtBrk4aSP1AH6I6X1R8hX9xhIrLFizeyUFmictmpNxR6qbLjRqSWxNzjdxMhZwz6PkAm0pqhuqZe1pZZby8gCDFHl0jSH1wt679gB5CVMDdzHZifMtz9dVS9LIBsnwAqNHFsIJJ5HB4vO++bx1WSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094059; c=relaxed/simple;
	bh=0qQgDB+gPSOBuJuLsKpLBJTfd6sI6XkgWj73Vx3FZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrI48yh1R99n+rLxuDdi9AvDk7V/BW6VRc9bgOJF4DhH9vfzzpCTcNVzyd0Q/cOT3gY5ZpAJ5Cm8yByPuErmxEjCxsF8t4gs7MEWcACtwbCL3YE4tHkhuMjV88wEKHmueu7+v7haD/sS5T9iXZ/8QRIr1jqN5yqRUDd7poxx4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fBZOG6WW reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 797C740E019C;
	Tue,  2 Apr 2024 21:40:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mKaN_O-P-QDS; Tue,  2 Apr 2024 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712094049; bh=U2O4dz/ZcnCM2vaDT6pvqW7zHdaxUiO3tzy2mEhvY4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBZOG6WW157BW5uK7G0JeANp+g4ZNFXiTigp2DS/uJBTgpxL1mud9advwxKGcFbnW
	 8MMF3etTUWpJ28CGHGJTrrXGzi2Gae3cy2PpPud2p0yFOLHorNjQF5UG/WsKAyZD9O
	 3kgk/UMSGjD8ynt2noXDIhGnkQUGmF6s9ginb0N9Hn44R2xybSh9SRXZMVnsGTW6xf
	 M2+ixTsp7wFgYF/Mm/97EpQwNBG29ll7W1cTYGy/YRsST2PrmEtFs8ZJrZy5ip5spx
	 m/K82fnbxZyLLRa0a/TdDJwFBa+ZGXUy8olo42OJr7YJX5JujoR0LCMZBh0+Aodqyi
	 qJqRZLm3HpzKORSNaytnqBgIiVzn01UcEsqFGEgia1QdsfOhrLSu8bI+aQitXx7deH
	 1bfSUl5UMuzE53zDpv0uREqaptggJn51pXA1oMVTy69FEO9nIbVvhEV5iC0Eol9htF
	 /HTYqW1axXB3y/8SjqMBAEs2bqxuqEIQdRDnDiLSaiv5aVqvhVkItN5stZ6rPQn+qg
	 OywHD/zXwUu+ugJFAbGU19QJ3/5SWPhekvvanSYnd5duY61n2/jiws1Cj/I8srClru
	 iCLhn+rfuJRBQDCQ7p7lkM8EV5XDoHIA1AbHNKllDkoKYC+Qcjc0KKxdZOmvF9hQe8
	 jEh6VTkTHd5TSnSbdxrFEyRI=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A23040E0028;
	Tue,  2 Apr 2024 21:40:42 +0000 (UTC)
Date: Tue, 2 Apr 2024 23:40:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Message-ID: <20240402214036.GFZgx7VBVD1qwp7RKT@fat_crate.local>
References: <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
 <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
 <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
 <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>
 <20240402212009.GEZgx2iZC_Plx-ajKW@fat_crate.local>
 <f1802e68-88b2-43f9-8344-d2a513e206a1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1802e68-88b2-43f9-8344-d2a513e206a1@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:31:30PM -0500, Kalra, Ashish wrote:
> The main issue is there is no API interface available to do that, i wil=
l
> need to add new API interfaces to update the e820_table_kexec and
> e820_table_firmware and then will that be acceptable for a use case whi=
ch
> can be handled via a platform specific quirk ?

I can't review a patch without seeing it first, sorry.

> Yes exactly, that's what the above comment means.
>=20
> =C2=A0That's why the above commit message says "may".

Yah, *never* use "may" in commit messages. This is internal speak and
doesn't belong in the kernel. Your commit message need to explain stuff
fully and properly. Otherwise I'll keep asking until it does.

> My point is that we always keep the RMP table memory reserved regardles=
s of
> SNP enablement, so these are simply fixups/adjustments on top of that
> reservation.

Yes.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

