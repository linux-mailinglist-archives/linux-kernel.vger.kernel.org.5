Return-Path: <linux-kernel+bounces-126235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037B893418
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A985D286205
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76907158D8A;
	Sun, 31 Mar 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IpcGOe+G"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EB158A0B;
	Sun, 31 Mar 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903258; cv=pass; b=OYEA05t+YyreXkSykiXB2CCMoKWflFLqF7LrURlahVmH/mF/Czgu/9tHIt8eTAbJyRlD4G2dovQIYusCB6gfMUPiTpnrwB9ysM7UwaqPG13Z9fOjWZNLsTwEyP1CfGa6hPUFPTee7+ZvWVwnrlxeCLoBqC+RHuwkXRz1JiPivJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903258; c=relaxed/simple;
	bh=NUfPh5D3dQMIcCtz1EhdkcsFvsIQ6wVm83hQ6WfxnOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4dW86XbUPnFk3Xc2cD4ZAPifam3R2OSgu6oD7MmEKLXaqY3ijFnTYjiqtYseBiW+/Zlxhz11rwLA7EFX6lqFfZgIErijQdKHG/VZrVq+3IVkU0uJnbFYROdrtUg2eNDR/jAFdT7vRT1WQkoOBW/flKvtqrZAgs/CYO0jeIZZBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=fail smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IpcGOe+G; arc=none smtp.client-ip=150.107.74.76; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=canb.auug.org.au
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9CA8F207D5;
	Sun, 31 Mar 2024 18:40:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrAnfECMQofd; Sun, 31 Mar 2024 18:40:50 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EA971207C6;
	Sun, 31 Mar 2024 18:40:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EA971207C6
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id DD8F180005E;
	Sun, 31 Mar 2024 18:40:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <linux-kernel+bounces-125480-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAVEmmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9943
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125480-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 961F720883
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752574; cv=none; b=lsfeT/09HbSBU7HHeb/VfZm10SqeljgP3Zdfwumy/tsTIkoCn79hnVn/h3MY+QQx4ifs703OWbvS4Y4BFLjTNENZfpjl1RY5qfK48XRqpK1XlurcOFIgw7Ua1CP1jnPBh6uYzfCEJR03FgZupcqPXLJJaZ+BgLljzdWsBFd3cUk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752574; c=relaxed/simple;
	bh=NUfPh5D3dQMIcCtz1EhdkcsFvsIQ6wVm83hQ6WfxnOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUQ9SK26n4OQ2Kt5cTp+sE0PZzVwEgz5keINWrxuybjfFWjkYxjw402Jj+fPE4VTHfzW0pM6/31wuMXbYWjOIXxwbElg0898TMcrkTsScF0wunMLiAdK2Dr/T7keIG5dOjb3IVsKRP+EIgcXjY80cKDmtrdfsrjwh+oHzFUbX5I=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IpcGOe+G; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711752564;
	bh=y7/nbXFQZJjv1BJM3ikZ+A5q8QAGzIbRDpWbIYDsgHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IpcGOe+GKsUbsctsTABGZXj/TkRvnlkwMfabjWCTE+oMxrYOc1CzrHlBgK/CNM65+
	 wLB76ZWrRTCpcKHKDXef5XQTfYXlu4dZwkZU+QjiN2buY7TNbxGGQc3+pCHsNZx82F
	 BGnsu3KOBh2FhylnAMqiKghTzFvuGBx+YBTVON+zzRWIzov3zXobuxBBJts8w2lyT4
	 spF8geDua8Vxt0My4r3TMvLV0ML6ee8gjCR8gqFpweFP+KE7skh3bIHzmlABtGGzah
	 Il9MDLY1SpF2zwe9RuS6KfJZ4hqeNrdKrkCy4NiaTYio7pMczJnc9qVav5yoJqTQXh
	 +w7lOE3MLJ+BA==
Date: Sat, 30 Mar 2024 09:49:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20240330094919.61e7c7b8@canb.auug.org.au>
In-Reply-To: <CAJuCfpHZGkL9urkZaVmO_o0ujpr-moDGYiBES1iRy2dh8g-t8w@mail.gmail.com>
References: <20240325123603.1bdd6588@canb.auug.org.au>
	<CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
	<5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org>
	<CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
	<20240328153947.3871cfdf@canb.auug.org.au>
	<20240328154427.3e926d21@canb.auug.org.au>
	<CAJuCfpHZGkL9urkZaVmO_o0ujpr-moDGYiBES1iRy2dh8g-t8w@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FA9pyRN8FXVoQi2ztbbKi3I";
	protocol="application/pgp-signature"; micalg=pgp-sha256
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Wed, 27 Mar 2024 22:35:56 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> https://lore.kernel.org/all/20240327044649.9199-1-rdunlap@infradead.org/
> which seems to not yet been pulled into mm-unstable should fix the
> following warnings:
>=20
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_n' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_size' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member
> '_flags' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'n'
> description in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'size'
> description in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'flags'
> description in 'kcalloc'
>=20
> And https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead.o=
rg/
> should handle the _noprof warnings. I can see this patch in
> mm-unstable and running "make htmldocs" in mm-unstable does not show
> the _noprof warnings anymore. Please let me know if I should try some
> other command to reproduce these.

Those patches entered the mm tree after I had merge it on Thursday.  It
should all be good on Tuesday.

--=20
Cheers,
Stephen Rothwell

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYHRW8ACgkQAVBC80lX
0Gxgvwf/cbqAEXHY0h2qgDEQcCMgXVslA1NPf257L3zgOuCHyXMcmL3hwwPEURq1
K1XwRlmeeSAkz98+F4yZ8Jmorf1B6XDmYGOW/4LibXX4lN3wMsAiECWJurB1nyZs
AgvztLSdVJTrW+nkydmT8ekFlIyK2xUQkwHNtr5iJ97DH6nPaLUeIqyWVaVkOGpt
atD9CE3J3dC1UYzSvH7ipdEOoxeSc4FQFDGRGvdSJ8witGnAq6HDrMYcZEmMkotp
r504oKZTeFwD0XI9nzSBSHnfzml23a/gUSwHDzxIi9TK88tPBpmS+v7ioH13luyL
n2VZEAicwEyUWC1ASZewuk3BY0fEhA==
=2moH
-----END PGP SIGNATURE-----

--Sig_/FA9pyRN8FXVoQi2ztbbKi3I--

