Return-Path: <linux-kernel+bounces-137514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D889E32E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27541F23741
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5A157478;
	Tue,  9 Apr 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="psyXiAU3"
Received: from sonic304-52.consmr.mail.gq1.yahoo.com (sonic304-52.consmr.mail.gq1.yahoo.com [98.137.68.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9A153587
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690470; cv=none; b=btUQjRwdKYc5WTJQhJPYWF1GOoq6xzBeJIQsdbemvef+xmzddEaYc/6ylLdu80M5awiH4IZD9cn7uHp9sTPM+kbbk5Iir1WlinkG8ut07lTX0MkGbdKrYApUYIrqJWH1qmPvXrgO3nkoUDY2vByNc351z0opRWLdT7gPCAt3E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690470; c=relaxed/simple;
	bh=aZ5Cpwss2meUrwX7WIoDa1wROmmOr4qO2DM2OUclIPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5KBWByjo1pis/AHuJ4vYlJ4/gUtuL9qpwvQe+bGq/ME6giTqEPXO6WEzj5z/7rsucPrZCmtkcqoP8/Aw0ksNVVM+CCafyYbAlHXr3Myy1LYtaNMfQqLgcFcvrjzJjnoqO+OWQ7LgoBHqKgSFGpcR0FTfTjqnZNwhJURgSGrlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.co.uk; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=psyXiAU3; arc=none smtp.client-ip=98.137.68.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1712690468; bh=aZ5Cpwss2meUrwX7WIoDa1wROmmOr4qO2DM2OUclIPY=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=psyXiAU3Ji7imvhT7MtwG35akSGhEk+imcSmL45Ayu+7Nr+y8kqVynsXVv5aB/xStYnQUoyjREI7MsYOsz9OUYN+IDQgudmRWLCVxiaY5eEL3Axx9oOskWGiqDTBntGJR8IdflXjn7Qol/Xa/SSBeCk2eBYgqnGt9qTBfa8EPv5IXZOu4JfZQINy7vYd7od78as2xL3u3L4lHe03fpB9nL67EW8XSeYBGzxl6COiZbsG6m86XEVVnjZCDPnqPEmXfWwjGy68MjJr2GO50qel/NeOPkLtGgjaPQxcSynkruGy/weBQU0r0J0tXB6nGejNYcQB30byWfvrXErObEZGWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712690468; bh=/rNsnzRlcGROtAqbOaVVLqtV0FJV1VZ2z/iOUoQFDIO=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=YJza9BeCU3nnqas6m9sNKMxIC8KHCW8keIM/drRhu6lf5GlOhrZXKkCtGbkybUEmmTuIdipotHZ1wUloha0i9NhMx5RUGYPDBjrepsjpfbhhfl/FwSCuwmjj1x7Hr7dvWcivXttuy7OOhfP6IJJ2JlzjLv2hjhGI3Kg2uYj6CTgUDfbweKaBcHsV01yija6LsjPrFwzurV9tAtc6uCkL4CTQwHpCMeaOl03tSLHkCBvdAmGbG3grTo7t01mWV/r1yga3lupKn+RymJo3TfTAXihf/yxqLQkkiCu4kZIiC+air7c8DTHR4NNp+Yy056kGFd5xyk8lDwLwawvamZ5tOw==
X-YMail-OSG: W7_l5k0VM1mmT2hoIM4RcvPt_8VM2DVbHJ8JBUseiOg4YvfC3mPuK8nTKK3Mkr.
 LDXZMvBH99OlUHWBosqAbUSNA7H2zRzOBhiOVWG6aBFnjygpAmBz5eQkZzzK4RF3zxTy3IhK4SY9
 NJv.fIWH1HN6yTi9PhY6m0vSU3ZtXOYnSOV4OyW5MCVYqsRqEx82aPS8QN.etn8Go6INCNi.foq5
 voMg85jglwUX5gnii21M84j55kXY4S.xjQdd12x6IMp3Z8J3QPw0jWRyHhVjlTXaNTPYUtdlKbIo
 JQyCC5hGpnieThgnJjLDIKc9rYS2HXD1AXbL_p4VugdLHp7DJMOUGIl.VEiQBJwLJ9pBrh4cCPae
 KnlHNwwGLEXCX4UlzfsVBDlzY1H6kIASfgC5gr_.cxrXdXKro_Lh5E2jWTavTr9i4fqgLIz8NQDS
 T_gAGXeDL8s_MlXGzpkMSgzh1sz4QYUBOWpAOrxVFpalQIyUY16dOwGUz5SbkuGM5ZVVb1uORlaA
 AWplUZwj8bdK2TWSPuk4V_Za17dJ8Yg3HE4v26vYKKqNClqBXcMRg5LrBFLtDCM6vY7jR.lBjFYi
 RsEnEuW09zEI0MUEzRpg7wJ6whvVJHqneEDm3TUty1Zud7ZltrNCxCOW4GtvcUHkdm5aSBUvmx_v
 RS0EU6riTVZBC3ghu2jikKHHrqZK1fOuL9Ujxtyst3HQBCRmb93udbtIrNp65vMJGc2Skd2gz10t
 4tRNWV3HuK3jYLZ7sN3cum56xCBjA8vAj1eUFb9LqH_5cUJTqfXXiNZX8k7jyMI9CJeiBiX3v8vC
 bap.hFNAjULzfH6GYhH4T4ZxDgkvH_xh8XUQ5cTc1BWlnlmwGBRiyey2iEDrGEBp11fKCnZLiJnf
 20QtsdP4iZhJe7Fjm7jfODtPVfran.SX1LJ5MeHY.q_NIWHZz8P4GorrK5oTHKKiQLstw9OOA09V
 WSLK3PSr88XCTQBiVkt3qw92G0yPcx0SuXDgPN4Rwk.EvQFPxx90KetJ_lTSovgmsOCQI92EO2D9
 QdTB8QJjyLpHm0WlT9LyCmt231YqfzG3SA_ploo8NpfRUa9l8Ku3SCQgbX6hchQ6qQUB5.TpM._H
 FImz5j1cx8Y87IzFDoQ6OCPbtUwbdPldeFuAKFkRrbgOrTZVxpkta8e3EefgXIUzbuB.rJmAG_z7
 KIek6Nx.FSIQ6fjx3E0VAf3LrQC0XpKKwk5YUeBXvqABB773qSW0ySnpunigi4iW8SnipNcb8GeY
 FKLLgI5bGb8slf4Les4n2rrA8cUBT8Xt32m.NhhNKRu93XHn30PoiPYRusvsY0X2vQxeRCCHJ91w
 DDeEsa4LxR5gUrjpZe7ZIiIQT8ZTuYeXu1uJLoYKSqkjmS1Pd1gyAMfjBmjl84IIDTWkYAmPSQOp
 3Q8UzWvyKHLGjcw8eO.ciu1NnLuOViQoPqjgBUNYKi3uyGuwQCKyRGFHyiWXZ.51vE46eVZe_F5S
 bSL387gqLEcDdg.rYqu1jXpIu1I7IqIfRs2foChm9lwhQQFQ6TDQcuDnyl2MRYYYHxb0OKRnoes8
 qwGODYi9oSxg09MiiByAAXWZj2iROyFskjnaziOpY9y3N_nyaLm7Oj5YNiTyG5JOM.mphXlVlA1i
 Q3FbpMv2k8zA7b9CGb0Ng4ij0HS1wpKPzS6eSQlFF4aVmRMsaDAQzPvR.nkMl9mpiIl8hQDuXgpF
 kQvanmPHmhSsYZ4_CJUztc2nEKMQjc0xe9ecnNpJkr1xmadhjKI0YkhV_8CEDn0oqkl0WjKNa5H2
 LqFkbnENChFvfcnwF63OQfKG2Acx6MmqamxO0wfrMiHdsIu8_X6rgimHRJ7ncljTPgXlCAPqY6Sg
 Jp8BN1BSYRVApxm7RxCBS0Z62t5vTV2S189C2iHmdS0NXrhpXePmzYFOJvhIo5hsXkyH6bGBFrsR
 8SZJAMz699lwg5Hp6QAXgfxlmN1RS_97VOxiiF0STqi5XLjB9c3c1u7KsXZmMod9pQ_7paKatUOK
 yaeKftaz0wu733MHparx6.S55C4pM.S45u5as8H.Pen5lbH_6vVvsbVQmiGYuLFVSzuQgP3pl0Mr
 PhyUpv4i6xpng6XnuTqJAkghODJ5JRSN9GlOQHN7jqnK2JsJU3XGsrTcCU7IT9U8Crw.cYjeQBvq
 G3kUWVELa9jaHFZyVgO4s8.31Ykl0.vZ94fBTWCAa2eCJhI87_z1O9mpPETvHF3X8.SGs4duSBCN
 nsI_fePEZHYY8sxGqGPLcXcS93vQ9gnkK_3kFk9s-
X-Sonic-MF: <rubenru09@aol.co.uk>
X-Sonic-ID: f31c2d4c-0320-4c64-9e95-a943a61ff2a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2024 19:21:08 +0000
Received: by hermes--production-bf1-7d6dbd57c9-kfv4r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d390bf4cdcc2662a3988b79bd8a73a50;
          Tue, 09 Apr 2024 19:19:06 +0000 (UTC)
Message-ID: <654c39d7e7c9172d165d8066a74ca81f6e208fe3.camel@aol.com>
Subject: Re: [PATCH] spi: Add documentation for last_cs_index_mask
From: Ruben Wauters <rubenru09@aol.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Tue, 09 Apr 2024 20:18:53 +0100
In-Reply-To: <1ec0fe6c-6af0-4cee-98ba-25fb2c67ef1d@sirena.org.uk>
References: <20240409184106.22715-1-rubenru09.ref@aol.com>
	 <20240409184106.22715-1-rubenru09@aol.com>
	 <1ec0fe6c-6af0-4cee-98ba-25fb2c67ef1d@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Tue, 2024-04-09 at 20:09 +0100, Mark Brown wrote:
> On Tue, Apr 09, 2024 at 07:41:05PM +0100, Ruben Wauters wrote:
>=20
> > This is my first patch, so I hope I did everything right, please
> > let
> > me know if I need to change something, and I shall endevour to do
> > it
> > properly.
>=20
> Everything looks good, only issue I can see is that this question
> (which
> is adminstrative stuff rather than part of the changelog) should have
> gone after the --- below:
>=20
> >=20
> > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > ---
>=20
> so that tooling can automatically remove it when applying.
>=20
> However a patch for this issue has already been applied but not yet
> merged into Linus' tree.

My apologies, I should have checked before submitting the patch, will
do this in the future, and noted on the message, will also keep that in
mind.


