Return-Path: <linux-kernel+bounces-127993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F789542C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1173A1F23E84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF480631;
	Tue,  2 Apr 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyEtQoag"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38397F7D9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063101; cv=none; b=GFR7CyET5RvKDiG8kE/qc7iiZDCFxhqz6INsH1CNy5jpkLh+5ruwqjNkh7a7/L84cj+iS4DpzTA8U09Mjd5U7gQ6GCmQpUoYahXb2ki6u57k86rpyCIah3MUKr56HRPKyieCUbsV3YjmUH+uPjly1w7w1m8MUZ6CQgo7B0Of+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063101; c=relaxed/simple;
	bh=7ah2VuBYWEmWHWPyFP68b6yoTO91npOyV7LilgwLJqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzcdEtVCIG6KB+jhsVWM5UkTouKscbZSR9uaYCi4YsFyBVAtbDmaJbuHbd8919YaT3GPHPUEixmSrOmxiZSw4zfmSazX+GcCfZUzNeTBx3lJDcBxUtlNWItCEHf4FV5UiZf9BOvmnABbaK3k40QiTD7XcmOhrpedXPnpsESxFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyEtQoag; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712063099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvSWXFalEF6OU22DUvBZWFYn2B7uDOAlKG6m5QBQYIk=;
	b=OyEtQoagPD+Aa6qqMsnaUEvqFJkXtHGgW6YIBGtAPBhZJfx23fBBAmP+REZ3QMrv7bY8e/
	QoPDZ6pjq9lxLlG6DfzEQsCE5mALlkrWHFO92+0jPptq1tivgKDCi20NOpjhlZLgNhlEO6
	BRXctDsSSu42sdEa5TwAjO2YV3HP3RI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-NI3dA4XqNgaoiilj5Na5TA-1; Tue, 02 Apr 2024 09:04:54 -0400
X-MC-Unique: NI3dA4XqNgaoiilj5Na5TA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 141C3101A520;
	Tue,  2 Apr 2024 13:04:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2134E492BCD;
	Tue,  2 Apr 2024 13:04:52 +0000 (UTC)
Date: Tue, 2 Apr 2024 09:04:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	eblake@redhat.com, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240402130446.GA2496428@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240402122617.GA30720@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RDsvgnmIpxDRfcPA"
Content-Disposition: inline
In-Reply-To: <20240402122617.GA30720@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--RDsvgnmIpxDRfcPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 02:26:17PM +0200, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> > In the block device world there are similar concepts to holes:
> > - SCSI has Logical Block Provisioning where the "mapped" state would be
> >   considered data and other states would be considered holes.
>=20
> But for SCSI (and ATA and NVMe) unmapped/delallocated/etc blocks do
> not have to return zeroes.  They could also return some other
> initialization pattern pattern.  So they are (unfortunately) not a 1:1
> mapping to holes in sparse files.

Hi Christoph,
There is a 1:1 mapping when when the Logical Block Provisioning Read
Zeroes (LBPRZ) field is set to xx1b in the Logical Block Provisioning
VPD page.

Otherwise SEEK_HOLE/SEEK_DATA has to treat the device as filled with
data because it doesn't know where the holes are.

Stefan

--RDsvgnmIpxDRfcPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYMAm4ACgkQnKSrs4Gr
c8hVxQf6Ai3HCf81vk9Zfg0wnaREk8TJeBtQghYd36C8nr5bX1BpwXAQog0wnYbZ
VK0zB5aL/xDtzp+Vs69+Dn7ouGRxk48H5h1Xk8o9UD2XWSoS4f+bb7b5nSKeF45y
gQd/tdgI+ch4AqbpByYz6Cgc3ZqJ03Tcm+zm9Vj4xUiXw1Hhj1V/09vVzif9X5tw
3/80Yd4JLU1W/7cznhTTAIrpz8L+NAclZkQFVtfbvV0aXQfAXGvV8Kl82ddmKBmL
+ovnir/EbVpxUcg4veYJCme1B8D6ALU4znM2krhnz6g5jBynLN+av88weJErNfox
34X6JufpJpSZUzfyTIA6PB7z5eS3Lg==
=cwzD
-----END PGP SIGNATURE-----

--RDsvgnmIpxDRfcPA--


