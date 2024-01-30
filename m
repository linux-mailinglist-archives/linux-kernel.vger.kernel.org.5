Return-Path: <linux-kernel+bounces-44878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC584286D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774341C24C03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382A82D99;
	Tue, 30 Jan 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dQY24rUg"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769B8121A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629923; cv=none; b=JpF7e0vungRR0UGzR36eP0gqZZvzFNXkz9ZIIgpSL7U+/PFEl2urrpjugtj/KicuPUVQDeYJDjIaDoLxiU0bi2ghl4r1yN6aJD/OAcGYgx55uumor3dI112sq2f6OmSVKbk353dSCxdDKbJj4JQ7SZu57l3RaLfGOIsuhrK8g7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629923; c=relaxed/simple;
	bh=7O1tmLg5OKzYWxFeisSuEd7Gff8XrdV9UOQO8wXaAg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSB2dmx5j73vfLtSXy1OAeNuH/YDPZrgEXQbCh1Lsj78FVj4r8Zp1meTelGYpmWj5QVYWZmubH/AEAywIJgLl/qLHh/3qC0cFJRmR7kp5vpEo5IDs6ziX7Qq3K8crj2uQKtAh8jp1qri8IxVmwglvDOGOUASEwLL8PGCsUPrADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dQY24rUg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7O1tmLg5OKzYWxFeisSuEd7Gff8XrdV9UOQO8wXaAg4=;
	t=1706629921; x=1707839521; b=dQY24rUg5oYILxgdI+FsgInKS1XdCd7PUxqjV2rIHKNs8b1
	snljNEyPSqLu2Cvep9DrQUCbGYLU2oh2exwyKmFqmCbbsKjy4Q3IuWAKl38xchD5WEluuFHvG/hbk
	xCE/b0QmErXTJK9BxHz3eyxxWti9hjI0IeAP4+PoUKvENGWlAx6XRIaa82x2Zpzsu2aOplnBZuiPe
	a66quATX5jBQVg0s0ZHwW0SNpQUlmUP4Az8g5x3CbVkUvbORC0xtbSLX842bA1Y9cRM0qMMJR2xC6
	907NAqKp4j83PmG3NAiC0FHw9vs7YQK47fVCDNMh8COGJAsIrJNHUOlB92DnsXEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUqP0-000000068Ls-0mwi;
	Tue, 30 Jan 2024 16:51:58 +0100
Message-ID: <d1ae193e9728583da3fbfac62ce1b20b0a34b60e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
From: Johannes Berg <johannes@sipsolutions.net>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-kernel@vger.kernel.org, Jose Souza <jose.souza@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jan 2024 16:51:57 +0100
In-Reply-To: <ZbkakWFtV5iQrfLP@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
	 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
	 <ZbgYyra1Ypa0nf6u@intel.com>
	 <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
	 <ZbkSvcEtRgTXuzgJ@intel.com>
	 <8681168464fa85061db4a7234f89cead65cb0261.camel@sipsolutions.net>
	 <ZbkakWFtV5iQrfLP@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:49 -0500, Rodrigo Vivi wrote:
>=20
> I will make changes to our driver to make the 'data' a standalone memory
> that devcoredump will free. this ensures no uaf and no null deref.
> data could be read even after unbinding the driver.
>=20
> What I meant to userspace 'writing to 'data'' was to ensure that
> on our CI we run something like
>=20
> if /sys/.../device/devcd<n> exists, then
> echo 1 > /sys/.../device/devcd<n>/data
> before attempting the rmmod <driver>
>=20
> our rmmod cannot get stuck or our CI is blocked, but then ensuring
> the devcd is gone with module_put happening is the only current way
> of not blocking the rmmod.
>=20

Ah, you were just concerned about the module removal, sure, that makes
sense.

Though depending on how you make that data pointer: if you just use
*sg() or *v() then you don't have this problem in the first place. OTOH,
it's probably good to have a udev rule to automatically capture the data
in CI anyway (and fail the test if it happened?)

johannes

