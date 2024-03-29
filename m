Return-Path: <linux-kernel+bounces-126215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE368933D1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C4B1F24D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF068155738;
	Sun, 31 Mar 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmn7bK5p"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFF153BF0;
	Sun, 31 Mar 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903206; cv=fail; b=dO5ahdtkzf5v6GJg+qoybxUSDoT6h1+YX4xrCBUwZNdM9fOB72v6COdIx3GlUPV/ecnJzzBf0WL9rjWRAJa48WoRMX/7IdwwOjrUJc/G9D/mU9RePFXCbzk3e1gWRjqfvPCUesWt4/MuVoVledmNReiILbfaTIZuGlSm5OsmXFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903206; c=relaxed/simple;
	bh=q6HS111PEBa7tF3V71XZ0vYqzeHxvJu9qsnYiIbRG3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLAmbrRwCF7R7PRrQ2gifLyurRghWSTugEbv/DCzD7nh0B3cB8s9agDdd7bcbupyJAhl111G6q0V84K8eVtsK8NOc2Wt+nsHmXJrff/17mijMW5J/YR8EQzt7+d1z3W8P0CXkQmwOuckB/Vs4G3pS9yxLBgQ9e3jNTzy0tyNlk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmn7bK5p reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BC87D20842;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6LCCy1uUMHV; Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 00A1A20882;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 00A1A20882
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id E71B8800050;
	Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:15 +0000
X-sender: <netdev+bounces-83456-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgA+AAAAy4oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 10813
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83456-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ADACB2087B
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743539; cv=none; b=qkg7bZWXnaWDqWm9OMTUKldCzr+aNi+EkgMvCd0cCOINFWNv90wOE+ERbfY0DBPTauBHBaZ9F5mNf6Oxz3hsUD/Wnqcq1irchTYluVZNbYEQfBfNjMl3RXI06FFyQURD+G7Ueun+7E3NgP0JwLeziiZASuexXNS0dP6vHnpObQI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743539; c=relaxed/simple;
	bh=XtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qqu4zCBTiJqgGnFdGLm/XtOGp4Us/lbdid0E7apFgBNq55apYx3ut6lCEtpoylX8bJ46arI5BqiniTPLcyz6+ZXWHLs3DnCqKNHsi8EkPv89ErnAleQGgT47rA5XApiBVz9a6chCtJtPcLnjFZbwyX4bGxsfvhhj1nWKqcr171M=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmn7bK5p; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711743538;
	bh=XtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmn7bK5praEFKZSEsXD1U0+/BhIiMgbRjlqzURm8mJyxcKdG1u7nFhvjWn6vjh45L
	 4fMwTQz5BgPAhQhwxhdzDjswpLr9tfxyAozEWodJ9d27CxJ4UL4UFY8Hf3KdPpUow8
	 E8A+MEP24fcOZoxGi8rhDy8xtbiVoeUdXbHP4PlO33ntnqxcbRNqN9U47LzjpdNssC
	 YPsQGwM2m4yyhH+9eEUxcjM4Ffzgd6RloWxtSrDibmFc5c1SFjvFY0/UkKocjbZRfB
	 tH6Rp6GsCq/VsJXLXe3LZL+Iv2yl9gsZmI2qe8RWHTL8tXGuYUE5J+9mVzpCC1gcYY
	 0Sa+AbTpHn+oA==
Date: Fri, 29 Mar 2024 13:18:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329131857.730c6528@kernel.org>
In-Reply-To: <20240329170000.3241460-3-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 18:00:00 +0100 Alexander Lobakin wrote:
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: warning: declaration =
shadows a local variable [-Wshadow]
>  1992 |         return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), s=
ize, size);
>       |                ^
> ./include/net/netdev_queues.h:137:11: note: expanded from macro 'netif_tx=
q_maybe_stop'
>   137 |                         _res =3D netif_txq_try_stop(txq, get_desc=
, start_thrs); \
>       |                                ^
> ./include/net/netdev_queues.h:92:7: note: expanded from macro 'netif_txq_=
try_stop'
>    92 |                 int _res;                                        =
       \
>       |                     ^
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: note: previous declar=
ation is here
> ./include/net/netdev_queues.h:133:7: note: expanded from macro 'netif_txq=
_maybe_stop'
>   133 |                 int _res;                                        =
       \
>       |                     ^
>=20
> Sparse:
>=20
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_re=
s' shadows an earlier one
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared =
here

I don't see these building with LLVM=3D1 W=3D12 C=3D1
and I really don't like complicating the code because the compiler
is stupid. Can't you solve this with some renames? Add another
underscore or something?

X-sender: <netdev+bounces-83456-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAdEWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAD8AAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10852
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:19:11 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:19:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 231DC202E4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:19:11 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -3.099
X-Spam-Level:
X-Spam-Status: No, score=3D-3.099 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aF1NBVBoN0ru for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:19:10 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83456-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 82B0520270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"mmn7bK5p"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 82B0520270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E431F22E43
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3C13BC31;
	Fri, 29 Mar 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"mmn7bK5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C532C89;
	Fri, 29 Mar 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711743539; cv=3Dnone; b=3Dqkg7bZWXnaWDqWm9OMTUKldCzr+aNi+EkgMvCd0cCOI=
NFWNv90wOE+ERbfY0DBPTauBHBaZ9F5mNf6Oxz3hsUD/Wnqcq1irchTYluVZNbYEQfBfNjMl3RX=
I06FFyQURD+G7Ueun+7E3NgP0JwLeziiZASuexXNS0dP6vHnpObQI=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711743539; c=3Drelaxed/simple;
	bh=3DXtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3DQqu4zCBTiJqgGnFdGLm/XtOGp4Us/lbdid0E7apFgB=
Nq55apYx3ut6lCEtpoylX8bJ46arI5BqiniTPLcyz6+ZXWHLs3DnCqKNHsi8EkPv89ErnAleQGg=
T47rA5XApiBVz9a6chCtJtPcLnjFZbwyX4bGxsfvhhj1nWKqcr171M=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3Dmmn7bK=
5p; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D45C433C7;
	Fri, 29 Mar 2024 20:18:58 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711743538;
	bh=3DXtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3Dmmn7bK5praEFKZSEsXD1U0+/BhIiMgbRjlqzURm8mJyxcKdG1u7nFhvjWn6vjh45L
	 4fMwTQz5BgPAhQhwxhdzDjswpLr9tfxyAozEWodJ9d27CxJ4UL4UFY8Hf3KdPpUow8
	 E8A+MEP24fcOZoxGi8rhDy8xtbiVoeUdXbHP4PlO33ntnqxcbRNqN9U47LzjpdNssC
	 YPsQGwM2m4yyhH+9eEUxcjM4Ffzgd6RloWxtSrDibmFc5c1SFjvFY0/UkKocjbZRfB
	 tH6Rp6GsCq/VsJXLXe3LZL+Iv2yl9gsZmI2qe8RWHTL8tXGuYUE5J+9mVzpCC1gcYY
	 0Sa+AbTpHn+oA=3D=3D
Date: Fri, 29 Mar 2024 13:18:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329131857.730c6528@kernel.org>
In-Reply-To: <20240329170000.3241460-3-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83456-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:19:11.1805
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: ac983536-0487-46b2-3f43-08dc=
502d7edb
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.188|SMR=3D0.134(SMRDE=3D0.005|SMRC=3D0.129(=
SMRCL=3D0.102|X-SMRCR=3D0.128))|CAT=3D0.053(CATRESL=3D0.022
 (CATRESLP2R=3D0.001)|CATORES=3D0.028(CATRS=3D0.027(CATRS-Index Routing
 Agent=3D0.025)));2024-03-29T20:19:11.388Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7867
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.020|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))=
|SMS=3D0.012
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAWYDAAAPAAADH4sIAAAAAAAEAL1UUW/b=
RgymZEu25Xgtin
 av45sTLEsip2gbBVlRJC0QIG0HBF0xrK1wltj4UFnn3EmOPexX7BeP
 J9lLm2SLkYcd5IN8JL+PH8nTX923Ob7SchMHe/haaBzsDB5j+Cza2e
 EHf9wJeX+R0UzkKWk8UUPxReZ4oVVBUS/4GVMtp6TNdk7FNhUj0vZF
 5gVl2zKdfK62uJjp2VYShXt7g2gvwguhc5mfRZhSkgktCqlyNCORqg
 uDAjOViAynQksxzAh//+l9bfto+dCC4J+4XJqKUufIrNLynMdjMR9S
 bAo1Wc/PN/H46JdX8dHL08P43Zt3py+P1otZfL6xiUb+QfW+sV/hVu
 sSd7E+WdsWC0qyMqVKJf9SmsbnJZVktkZRuPs0CsMIc1sSpNnElirF
 z1qNcSwSrbB/U3b9mpWjr7P+s2JNBg++Ulfoea2N/2ziGRVxSiZhIY
 XQRVyMtNnYxw//IegOArlpT1eUt0xvIQ6/adVy8XRUwvZvy+3KulXW
 p7sOZK1tomkqVWm+GUtpkDFolTHYXblMN0zB7v9dKOtzOhHaVPf4Tp
 ULn3x1l818PFQZ9m3C/cvbnCMJnUn+dqic7syitDyTuciy+aI5XNq6
 Lb3gGFOV9ws0RMh4hnBYyizlpPBCFiM8Ofn19UGI7w/CAR4ehL2AO4
 PH/OGo4arYTH4hTNR4ksmE+86hjMQHKYNRIkpDi4PxRGakewGPhSnK
 iUy38FBYhLkq0ahsah3ZWDEbNSbmycWYzHN8kaZcDmUl94LSfk5Noj
 SxtsqRw/Kz51YQgAuNBniuA11+7Huz6XhtgLbT8QA88DsQtKDtVTtb
 28DnfhO8pgMd3sFzHLcJwFEOgAONFnS6sMbODrjs2YZuy+lZB7jnQ4
 udHoLPODWIa+ngfoXDVk6jCQ3emta6XjP6DvSgxVYmagCbm65N2/pw
 MhzoXYF1utYNfmiAz+cPqnOrCzxWyujtKpZNgWWJrrNYfKdRy7nCco
 nmrFVpPLKY8NuKxanRuD6ufQ/+TeCN1NcEfl9Rf/Dhu1vZ64pxa3zo
 cBT7u7ZTHNVaMTaAbpXMoq11JnV6S3XuonSswHFrCezG57bvFfga9O
 pGLEkDdvbtdF2ORP20bJ42YeZln87fEYsguz0IAAABDs8BUmV0cmll
 dmVyT3BlcmF0b3IsMTAsMDtSZXRyaWV2ZXJPcGVyYXRvciwxMSwxO1
 Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJzZXJP
 cGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcG
 VyYXRvciwxMCwxO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVy
 YXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDE1
X-MS-Exchange-Forest-IndexAgent: 1 1092
X-MS-Exchange-Forest-EmailMessageHash: 7E5A4F6D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 18:00:00 +0100 Alexander Lobakin wrote:
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: warning: declaration =
shadows a local variable [-Wshadow]
>  1992 |         return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), s=
ize, size);
>       |                ^
> ./include/net/netdev_queues.h:137:11: note: expanded from macro 'netif_tx=
q_maybe_stop'
>   137 |                         _res =3D netif_txq_try_stop(txq, get_desc=
, start_thrs); \
>       |                                ^
> ./include/net/netdev_queues.h:92:7: note: expanded from macro 'netif_txq_=
try_stop'
>    92 |                 int _res;                                        =
       \
>       |                     ^
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: note: previous declar=
ation is here
> ./include/net/netdev_queues.h:133:7: note: expanded from macro 'netif_txq=
_maybe_stop'
>   133 |                 int _res;                                        =
       \
>       |                     ^
>=20
> Sparse:
>=20
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_re=
s' shadows an earlier one
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared =
here

I don't see these building with LLVM=3D1 W=3D12 C=3D1
and I really don't like complicating the code because the compiler
is stupid. Can't you solve this with some renames? Add another
underscore or something?

X-sender: <linux-kernel+bounces-125384-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAdEWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAEAAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10906
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:19:25 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:19:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id D198D20315
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:19:25 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=3D-5.399 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04wgTj6sZHGR for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:19:25 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125384-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 0140A202E4
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"mmn7bK5p"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 0140A202E4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11885287903
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657D13BAFC;
	Fri, 29 Mar 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"mmn7bK5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C532C89;
	Fri, 29 Mar 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711743539; cv=3Dnone; b=3Dqkg7bZWXnaWDqWm9OMTUKldCzr+aNi+EkgMvCd0cCOI=
NFWNv90wOE+ERbfY0DBPTauBHBaZ9F5mNf6Oxz3hsUD/Wnqcq1irchTYluVZNbYEQfBfNjMl3RX=
I06FFyQURD+G7Ueun+7E3NgP0JwLeziiZASuexXNS0dP6vHnpObQI=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711743539; c=3Drelaxed/simple;
	bh=3DXtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3DQqu4zCBTiJqgGnFdGLm/XtOGp4Us/lbdid0E7apFgB=
Nq55apYx3ut6lCEtpoylX8bJ46arI5BqiniTPLcyz6+ZXWHLs3DnCqKNHsi8EkPv89ErnAleQGg=
T47rA5XApiBVz9a6chCtJtPcLnjFZbwyX4bGxsfvhhj1nWKqcr171M=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3Dmmn7bK=
5p; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D45C433C7;
	Fri, 29 Mar 2024 20:18:58 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711743538;
	bh=3DXtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3Dmmn7bK5praEFKZSEsXD1U0+/BhIiMgbRjlqzURm8mJyxcKdG1u7nFhvjWn6vjh45L
	 4fMwTQz5BgPAhQhwxhdzDjswpLr9tfxyAozEWodJ9d27CxJ4UL4UFY8Hf3KdPpUow8
	 E8A+MEP24fcOZoxGi8rhDy8xtbiVoeUdXbHP4PlO33ntnqxcbRNqN9U47LzjpdNssC
	 YPsQGwM2m4yyhH+9eEUxcjM4Ffzgd6RloWxtSrDibmFc5c1SFjvFY0/UkKocjbZRfB
	 tH6Rp6GsCq/VsJXLXe3LZL+Iv2yl9gsZmI2qe8RWHTL8tXGuYUE5J+9mVzpCC1gcYY
	 0Sa+AbTpHn+oA=3D=3D
Date: Fri, 29 Mar 2024 13:18:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329131857.730c6528@kernel.org>
In-Reply-To: <20240329170000.3241460-3-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125384-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:19:25.8902
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d20bea01-e9bc-4d2c-c411-08dc=
502d879f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.393|SMR=3D0.326(SMRDE=3D0.004|SMRC=3D0.321(=
SMRCL=3D0.102|X-SMRCR=3D0.321))|CAT=3D0.065(CATOS=3D0.001
 (CATSM=3D0.001)|CATRESL=3D0.026(CATRESLP2R=3D0.017)|CATORES=3D0.033(CATRS=
=3D0.033(CATRS-Index
 Routing Agent=3D0.031 ))|CATORT=3D0.001(CATRT=3D0.001));2024-03-29T20:19:2=
6.301Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7871
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.017|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))=
|SMS=3D0.010
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAWYDAAAPAAADH4sIAAAAAAAEAL1UUW/b=
RgymZEu25Xgtin
 av45sTLEsip2gbBVlRJC0QIG0HBF0xrK1wltj4UFnn3EmOPexX7BeP
 J9lLm2SLkYcd5IN8JL+PH8nTX923Ob7SchMHe/haaBzsDB5j+Cza2e
 EHf9wJeX+R0UzkKWk8UUPxReZ4oVVBUS/4GVMtp6TNdk7FNhUj0vZF
 5gVl2zKdfK62uJjp2VYShXt7g2gvwguhc5mfRZhSkgktCqlyNCORqg
 uDAjOViAynQksxzAh//+l9bfto+dCC4J+4XJqKUufIrNLynMdjMR9S
 bAo1Wc/PN/H46JdX8dHL08P43Zt3py+P1otZfL6xiUb+QfW+sV/hVu
 sSd7E+WdsWC0qyMqVKJf9SmsbnJZVktkZRuPs0CsMIc1sSpNnElirF
 z1qNcSwSrbB/U3b9mpWjr7P+s2JNBg++Ulfoea2N/2ziGRVxSiZhIY
 XQRVyMtNnYxw//IegOArlpT1eUt0xvIQ6/adVy8XRUwvZvy+3KulXW
 p7sOZK1tomkqVWm+GUtpkDFolTHYXblMN0zB7v9dKOtzOhHaVPf4Tp
 ULn3x1l818PFQZ9m3C/cvbnCMJnUn+dqic7syitDyTuciy+aI5XNq6
 Lb3gGFOV9ws0RMh4hnBYyizlpPBCFiM8Ofn19UGI7w/CAR4ehL2AO4
 PH/OGo4arYTH4hTNR4ksmE+86hjMQHKYNRIkpDi4PxRGakewGPhSnK
 iUy38FBYhLkq0ahsah3ZWDEbNSbmycWYzHN8kaZcDmUl94LSfk5Noj
 SxtsqRw/Kz51YQgAuNBniuA11+7Huz6XhtgLbT8QA88DsQtKDtVTtb
 28DnfhO8pgMd3sFzHLcJwFEOgAONFnS6sMbODrjs2YZuy+lZB7jnQ4
 udHoLPODWIa+ngfoXDVk6jCQ3emta6XjP6DvSgxVYmagCbm65N2/pw
 MhzoXYF1utYNfmiAz+cPqnOrCzxWyujtKpZNgWWJrrNYfKdRy7nCco
 nmrFVpPLKY8NuKxanRuD6ufQ/+TeCN1NcEfl9Rf/Dhu1vZ64pxa3zo
 cBT7u7ZTHNVaMTaAbpXMoq11JnV6S3XuonSswHFrCezG57bvFfga9O
 pGLEkDdvbtdF2ORP20bJ42YeZln87fEYsguz0IAAABDs8BUmV0cmll
 dmVyT3BlcmF0b3IsMTAsMTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwyO1
 Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwyO1Bvc3REb2NQYXJzZXJP
 cGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcG
 VyYXRvciwxMCwyO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVy
 YXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDE3
X-MS-Exchange-Forest-IndexAgent: 1 1092
X-MS-Exchange-Forest-EmailMessageHash: 7E5A4F6D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 18:00:00 +0100 Alexander Lobakin wrote:
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: warning: declaration =
shadows a local variable [-Wshadow]
>  1992 |         return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), s=
ize, size);
>       |                ^
> ./include/net/netdev_queues.h:137:11: note: expanded from macro 'netif_tx=
q_maybe_stop'
>   137 |                         _res =3D netif_txq_try_stop(txq, get_desc=
, start_thrs); \
>       |                                ^
> ./include/net/netdev_queues.h:92:7: note: expanded from macro 'netif_txq_=
try_stop'
>    92 |                 int _res;                                        =
       \
>       |                     ^
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: note: previous declar=
ation is here
> ./include/net/netdev_queues.h:133:7: note: expanded from macro 'netif_txq=
_maybe_stop'
>   133 |                 int _res;                                        =
       \
>       |                     ^
>=20
> Sparse:
>=20
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_re=
s' shadows an earlier one
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared =
here

I don't see these building with LLVM=3D1 W=3D12 C=3D1
and I really don't like complicating the code because the compiler
is stupid. Can't you solve this with some renames? Add another
underscore or something?


