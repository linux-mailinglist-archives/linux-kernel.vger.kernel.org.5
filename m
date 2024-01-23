Return-Path: <linux-kernel+bounces-35511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1D83922E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AF2294B39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B96604A2;
	Tue, 23 Jan 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9vb4ADN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D95FF14
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022574; cv=none; b=WznrNA8lTHdsSMvNjRWZWQibzyKJkD1HqwdgDRmLzY1Y3V0v8zFZJLswlqxuFE1dXpzIpBFestzENjN19HIF6vXjA2/bL9iVtUQcmnzuoprffMsGVs30US/3WbPPODIYUHceu33VKz2Om/yBWxWUzRmYF8tGnFN3yhVzOw/m0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022574; c=relaxed/simple;
	bh=yFhqjSYMsfQsAfF+2fsdyL48rxFoZ4t0QJ4RfI6DXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL4gbirC2p6ebqw34xvphiHyywx0ddfRiXEZB/p7L7ez1j6iu80Vs+spFoCNw5uwl0I1gYm27pt9akYgYz9ZECLx2NqGJgOfHWsPz8yhXagRpc6aoBxfPB/B9QWMAiSZEBE+zEBomZfeVDnuWYFILYjyXed1wh9VyXY1aJgPTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9vb4ADN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706022571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEbkk1tO4HfhPK2JUx6qrKqs0KZDvkUBuiz6BAIPH5w=;
	b=A9vb4ADNaCSK0SBBxBetnPXxJBdWw6U9IACXdSZzdCu9lmiqVdpChMesmHfb/oyVjihc3Q
	5m65lewlnH7Wnh5JDJ4pOrhjZBqvoxfaxJyFS3+kF+xXa85ijB86Cx4MEnIxdisWJSnWJY
	aHgFk4TBno0sEm1eL67cYQZs/eid+OM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-79EebRTCNnK9c8xzYxIZzw-1; Tue, 23 Jan 2024 10:09:27 -0500
X-MC-Unique: 79EebRTCNnK9c8xzYxIZzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCA1383FC21;
	Tue, 23 Jan 2024 15:09:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F41A2905;
	Tue, 23 Jan 2024 15:09:25 +0000 (UTC)
Date: Tue, 23 Jan 2024 10:09:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mst@redhat.com
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk,
	yi sun <sunyibuaa@gmail.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
	hongyu.jin@unisoc.com
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-ID: <20240123150924.GD484337@fedora>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
 <20240122110722.690223-3-yi.sun@unisoc.com>
 <20240122154255.GA389442@fedora>
 <CALpufv0h-sQ4Qfp-Sxd7wME4onMNAMop_gi-np6Dk2R96sba0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5XZvsWUA6IsHlc+K"
Content-Disposition: inline
In-Reply-To: <CALpufv0h-sQ4Qfp-Sxd7wME4onMNAMop_gi-np6Dk2R96sba0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--5XZvsWUA6IsHlc+K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,
This could potentially affect other VIRTIO drivers too. Please see
below.

On Tue, Jan 23, 2024 at 11:27:40AM +0800, yi sun wrote:
> On Mon, Jan 22, 2024 at 11:43=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> >
> > On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> > > Ensure no remaining requests in virtqueues before resetting vdev and
> > > deleting virtqueues. Otherwise these requests will never be completed.
> > > It may cause the system to become unresponsive. So it is better to pl=
ace
> > > blk_mq_quiesce_queue() in front of virtio_reset_device().
> >
> > QEMU's virtio-blk device implementation completes all requests during
> > device reset. Most device implementations have to do the same to avoid
> > leaving dangling requests in flight across device reset.
> >
> > Which device implementation are you using and why is it safe for the
> > device is simply drop requests across device reset?
> >
> > Stefan
>=20
> Virtio-blk device implementation completes all requests during device res=
et, but
> this can only ensure that the device has finished using virtqueue. We sho=
uld
> also consider the driver's use of virtqueue.
>=20
> I caught such an example. Before del_vqs, the request had been processed =
by
> the device, but it had not been processed by the driver. Although I am
> using kernel5.4,
> I think this problem may also occur with the latest version of kernel.
>=20
> The debug code I added is as follows:
> virtblk_freeze()
> {
>         vdev reset();
>         quiesce queue();
>         if (virtqueue->num_free !=3D 1024) //1024 is the init value.
>                 BUG_ON(1);
>         vdev del_vqs();
> }
>=20
> BUG_ON triggered the dump, the analysis is as follows:
>=20
> There is one request left in request_queue.
> crash_arm64> struct request ffffff81f0560000 | grep -e state -e __data_len
>   __data_len =3D 20480,
>   state =3D MQ_RQ_IN_FLIGHT,
>=20
> crash_arm64> vring_virtqueue.packed,last_used_idx,broken,vq 0xffffff8086f=
92900 |
> grep -e num -e used_wrap_counter -e last_used_idx -e broken -e
> num_free -e desc_state -e "desc =3D"
>         num =3D 1024,
>         desc =3D 0xffffff8085ff8000,
>       used_wrap_counter =3D false,
>       desc_state =3D 0xffffff8085610000,
>   last_used_idx =3D 487,
>   broken =3D false,
>     num_free =3D 1017,
>=20
> Find desc based on last_used_idx. Through flags, we can know that the req=
uest
> has been processed by the device, but it is still in flight state
> because it has not
> had time to run virtblk_done().
> crash_arm> vring_packed_desc ffffff8085ff9e70
> struct vring_packed_desc {
>   addr =3D 10474619192,
>   len =3D 20481,
>   id =3D 667,
>   flags =3D 2
> }
>=20
> I'm using a closed source virtual machine, so I can't see the source
> code for it,
> but I'm guessing it's similar to qemu.
>=20
> After the device completes the request, we must also ensure that the driv=
er can
> complete the request in virtblk_done().
>=20

Okay, I think your approach of waiting for requests before
virtio_device_reset() makes sense. blk_mq_complete_request() is async
(might be deferred to an IPI or softirq) so it's not enough for
virtblk_done() to run before virtio_device_reset() returns. There is no
guarantee that virtblk_request_done() runs before virtio_device_reset()
returns.

A separate issue about virtio_device_reset():

Are you using virtio-mmio? virtio-mmio's vm_reset() doesn't offer the
same guarantees as virtio-pci's reset functions. virtio-pci guarantees
that irqs sent by the device during the reset operation complete and the
irq handlers run before virtio_device_reset() returns. virtio-mmio does
not.

(On top of this, virtio_device_reset() now has
CONFIG_VIRTIO_HARDEN_NOTIFICATION which changes the semantics. Drivers
cannot expect to complete any in-flight requests in
virtio_device_reset() when complied with this config option.)

Other drivers may be affected by these inconsistent
virtio_device_reset() semantics. I haven't audited the code.

Stefan

--5XZvsWUA6IsHlc+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWv1qQACgkQnKSrs4Gr
c8jpgAf+NXHJgW/fRiaSNygOJ4hNh3a2hy8o6bZssqK9v3TAl8S3iIWCBF+IWuCA
apnBdRbOu6nWpp9DtMjEwKzt3JAzdwRGkEpK/PbGP53Y07KihDTeJU6FhssuUxLn
idP+j15guyV/m4+wVQJgNR6c3k9rFc+P4pH97CcxkLH7SX0uUA5dMQEBUgBN3sVb
V+nx/vm0jTUe3BJ3mJaUzB5G4iECMAeaKTLQQj3fOoKMJ1vt8+HQGTLeHaHL9pOW
3qeHUov5iMlp2CZpMtn0DDjqs3mX9uj3uhXGHW95BfkU1QRVHVWQypHGHE5xzAmq
PgAw13jcz8svFhI7lztiQBHmJ5N9ug==
=cz+B
-----END PGP SIGNATURE-----

--5XZvsWUA6IsHlc+K--


