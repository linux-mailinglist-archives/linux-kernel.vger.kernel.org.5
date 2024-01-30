Return-Path: <linux-kernel+bounces-44507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C379F8422F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028241C20ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9328866B34;
	Tue, 30 Jan 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="M8/8T5fh"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D066B29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614025; cv=none; b=GU3MeQnG0FbQHEiIpCRe5WFK7seReJVNm9OHzmvdFpbTmAPeJRPppexfrWWyPNR9aal8Pl7AXaCEc62nv28WmnVjPO8E638sAQrRMBHsk+bLL1dwOGELT5hs9+cqYR9ezXepI5uofTBllYmwfppIq4DXwSQ67cf73CwC8EXCUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614025; c=relaxed/simple;
	bh=muX3YxseE2TzFY8Q79IfU61c+1oWD3bJbHYy41uJG1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTs+VY2zP4F3vk7HTeeXuR0n2vWGPcpmA+9JeQpgltdLjOVbqMlSGZ8ugYgbax8Ci2lp16/Oc3M8oSwi2e3+RnZLoPUnwQ9IvI4owMCjXQZhG73/LAP0fGs2h8JlWo0FLuD7dORfUv5uLDy3rrHXZC86iI7uT2jVXNpNQMySzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=M8/8T5fh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lNRA
	8G85hsULgv0uGmfeJsSV2FBs2FxoeGapM1VIbhA=; b=M8/8T5fhB13dpgX9CeNE
	ghKdyOTkUglY935KQRbHgrBsRzVitW3NhuONwFJN0OhH5fsCFvGeCcQZNRoYhYD/
	s/yx5OtcVXLDoWV7oSiRXmb8u0dzNcrNgabX98mD4d/zYIL+Sa9+zSIfwa6KS4bY
	gAlZ/ZjgmsPuTjgQt5kjxa8N+7IJaiM2ZJMjRpGfB3mtA/u09RL1joAbhLGfY7o4
	1ibW7WpMQnC75CpM00jC1i8yC22ABTZ7ZHw5lEXlSmxOlEusYAExVnPQwGuuKgJ6
	XZqxcnhfVEJ9QVXqQSDPqeVcl6ATxhcL/BqYR9CJomMYABWXGp96SrXRzMYH6dBW
	Lg==
Received: (qmail 2816817 invoked from network); 30 Jan 2024 12:26:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jan 2024 12:26:54 +0100
X-UD-Smtp-Session: l3s3148p1@g1gbCigQqL5ehhtJ
Date: Tue, 30 Jan 2024 12:26:54 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
Message-ID: <Zbjc_p_Pin7TAHw4@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tLJ2stAhg6obWp8F"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>


--tLJ2stAhg6obWp8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What about unifying the individual SIFCTR_?FWM_[0-9]* definitions
> into SIFCTR_xFWM_[0-9]* instead, and using the bitfield helpers in its
> sole user?

But they don't match, so we can't unify them?

#define SIFCTR_TFWM_1           (7UL << 29)     /*  Transfer Request when 1 empty stage */

vs

#define SIFCTR_RFWM_1           (0 << 13)       /*  Transfer Request when 1 valid stages */

Also, the steps don't match (1, 4, 8, 12..) vs (1, 4, 8, 16...).


--tLJ2stAhg6obWp8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW43PoACgkQFA3kzBSg
KbbsJg//UOga82uDR5hhkR6m2/6zD1GsGFvrFCFo1DhS+LdxOSzmsC7oxkP4AVSN
w8VFjl/YnskkaUPsVhyaDpckse89Zm4cX1kp/FthiTYyp0Ne7406Bm0O6yAel3CF
0O73CrW2gKmw3q6NG7v9tnsN8RI2RlSxIN59AMSAMryxod3dDI6dCkuJc1AHEmpn
loiVN99PQTvhU3REby8hSTF44I3uiez0lsYQ8YQefE8Hbo0V43YYFD9SfEI8CyPM
5+QYsscqp9WQQFwo5RpeW/5tk4nssSDpTe4DkQMfXY/JYt+51oWJPlR5xvrmqEEF
jO0occLL+9YzF4S1QBxWA72DsQhNPM0hA0uW51I99RROef6b56GTgJN7BwzCLi7H
zXoSstpBsgn0VdE5eqz+hR8ZZugxIFWRqWNskkMCMkQumXwA6kV+pmsk5XTndfVu
S8emAMcGqMwcIGE4PYiB/IM92kC7r/kh8N4x5COk2PzNnsTD0TEWYzL2Q8/xNUJN
EIe00Qd0ZL/pzvTCCS0jfmU6ByqXEpEAa+KCdDYqpIawJdWwSKcs+Y7a7DjS4SMC
N/ewwerD/pBea7/c1LVMCXxCbYiUC6yi8Buv8Yy6ORV8BRxXKDz7DcRRE0IquCmI
jNvLVYtn5yP/X0Q7oy7w/gaSq4gWg1M0STgq1boTxDn5uidb1JU=
=/+Ku
-----END PGP SIGNATURE-----

--tLJ2stAhg6obWp8F--

