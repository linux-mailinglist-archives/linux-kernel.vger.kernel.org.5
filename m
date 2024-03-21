Return-Path: <linux-kernel+bounces-110552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B114788607B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36878B21365
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A601133413;
	Thu, 21 Mar 2024 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omyzrrfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC479C3;
	Thu, 21 Mar 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045526; cv=none; b=Mks2a4aLmgLr/ZEDSOn8S08d2GBGjdrwTJbr8eRPPzg3QmZikiz69G8pUeCJlC3vteW7WzVP0tG4Ruf/cMMD6meNiHze4OF8miQ5LIC7v/06W0IUM9Zdhz34boOyMgAruDfO2GBXK/ATALujdQb+6wxIgi6foE2Mhp1cVRw0fAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045526; c=relaxed/simple;
	bh=GSm30TNvJb3WRtML6WpgbGZ659hB6xOjASeoFE5AicI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GG3cW6PXjvyTwXbYypLc4KVuaurnhEmnia34JOna9WxzOEA/EK1yc7ReF8bC1U5xDm/G1tEvzGX+pYuC/n7+31F0zkmoZIv7gxVwwvtjYqDYG1E2lQLZZJGbiNvuRcaFX6FgL06zAYmLnIk5Hf8xQNngnj6+kI0qTwfrpZdBuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omyzrrfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83A2C433C7;
	Thu, 21 Mar 2024 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711045525;
	bh=GSm30TNvJb3WRtML6WpgbGZ659hB6xOjASeoFE5AicI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OmyzrrfrgBYAsSaQSWU4pA/fRi563CAGY/aoIPyzl78XLfH3G1Sq+Te0Xl7IpO07b
	 4i0Kf9hPbDbpO05M2Y/daA7DOy3bR+/7TXlkSyATk7XVSfW2b1nbiicGD605uS1Gxs
	 rwK2jSgRL4st1o5V12W+0k07kPWbQ9uDkuPkoPUFzDXztr1YwbFrFBICZ+9cxQCl1Q
	 cO/kXYk+FxpmUP8L7vEiVK9Dv6nVEOY2/5BHZWWHAmUdqn82FbAsn6eBzcnXHNsJIQ
	 L4wGjGJuuFeCap0xUdoH/XZNaSa4wIDMvV7HjkHKpucMCeSwO9SvSxs6+GBL4c5kFH
	 /OiYAwEOMxQVA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 20:25:22 +0200
Message-Id: <CZZN0LEJ6DA6.1CGFPODVM7RCH@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "David Howells"
 <dhowells@redhat.com>
Subject: Re: [PATCH v7 13/13] crypto: x509 - Add OID for NIST P521 and
 extend parser for it
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-14-stefanb@linux.ibm.com>
 <CZZLN3B7TMG5.1A0518I6Z3MEA@kernel.org>
 <0216c143-445b-472d-a62a-57cbe8b19c24@linux.ibm.com>
In-Reply-To: <0216c143-445b-472d-a62a-57cbe8b19c24@linux.ibm.com>

On Thu Mar 21, 2024 at 7:42 PM EET, Stefan Berger wrote:
>
>
> On 3/21/24 13:20, Jarkko Sakkinen wrote:
> > On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> >> Enable the x509 parser to accept NIST P521 certificates and add the
> >> OID for ansip521r1, which is the identifier for NIST P521.
> >>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Tested-by: Lukas Wunner <lukas@wunner.de>
> >> ---
> >>   crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
> >>   include/linux/oid_registry.h              | 1 +
> >>   2 files changed, 4 insertions(+)
> >>
> >> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymme=
tric_keys/x509_cert_parser.c
> >> index 487204d39426..99f809b7910b 100644
> >> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> >> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> >> @@ -538,6 +538,9 @@ int x509_extract_key_data(void *context, size_t hd=
rlen,
> >>   		case OID_id_ansip384r1:
> >>   			ctx->cert->pub->pkey_algo =3D "ecdsa-nist-p384";
> >>   			break;
> >> +		case OID_id_ansip521r1:
> >> +			ctx->cert->pub->pkey_algo =3D "ecdsa-nist-p521";
> >> +			break;
> >>   		default:
> >>   			return -ENOPKG;
> >>   		}
> >> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry=
h
> >> index 3921fbed0b28..af16d96fbbf2 100644
> >> --- a/include/linux/oid_registry.h
> >> +++ b/include/linux/oid_registry.h
> >> @@ -65,6 +65,7 @@ enum OID {
> >>   	OID_Scram,			/* 1.3.6.1.5.5.14 */
> >>   	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
> >>   	OID_id_ansip384r1,		/* 1.3.132.0.34 */
> >> +	OID_id_ansip521r1,		/* 1.3.132.0.35 */
> >>   	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
> >>   	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
> >>   	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > BR, Jarkko
>
>
> Thanks for the tags.

Sure, at least the noise I've made is the sign that someone actually did
read through all the code changes, right? :-)

BR, Jarkko

