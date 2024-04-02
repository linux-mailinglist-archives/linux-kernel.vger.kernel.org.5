Return-Path: <linux-kernel+bounces-128658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BC895D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0EF2819B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB815E1EC;
	Tue,  2 Apr 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P91AGT1U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0081E4AE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090017; cv=none; b=Xty1PmOTPK6bKr8qCdqs7NY6fs3qieZSwkQKsenEJzDcP21jn3aOFETFHhBKR11NvwQ+sZBuLCBYDgf6coPnmFftV2+llJIhZrLTpq3f3hW75zNNQml9XI7vZBbxitt/EcL3naDyvBFdKNxQ6RiHYWV+m0K48Qu1OhhfYihvbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090017; c=relaxed/simple;
	bh=ROySLNzi2sYnSa/JtIXRjIYuaaAEqJzMqCJdYS2UTqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0EvlNAigY8Ws/fAKS6PT/gyyeYOddOZ3FAeI+yzdaPrck6Clm2Z2jUPYM0WhxdklEIyf7mOOQ5K/joM0kEQjsVpCuK+jva5JLjUhezDoSG8HWOHpk+VkN7KS0bo9IuCmNg2lNSVg7zZdyti9BX4wgXn6Y9NQ3LV1HtefdXFztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P91AGT1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712090014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XkVVzn7sUlZgXUm5P4BgsrM9gYYoxT1YIoFUz7D2uhU=;
	b=P91AGT1Uo+jscwA6g+lVjqZRd4sXYyTUOt1oZXKFsIm3iKzyb6G6ZN1n8kITZotFEoEfri
	JQkyO8lRl8khCs7Etc8jWwXGUR+BP5Qegf+fTtTHtd9OHrDamyFIftWsWm+TAN0TBHHHFr
	nF8hx/UgsoLC0tu2HTviWDGZqn/YaJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ywO5jcPyNGiEQomcpy8Y7w-1; Tue, 02 Apr 2024 16:33:32 -0400
X-MC-Unique: ywO5jcPyNGiEQomcpy8Y7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16C6F946322;
	Tue,  2 Apr 2024 20:33:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF28B17AA0;
	Tue,  2 Apr 2024 20:33:26 +0000 (UTC)
Date: Tue, 2 Apr 2024 16:33:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Graf <graf@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 06/25] virtio_blk: drop owner assignment
Message-ID: <20240402203321.GD2507314@fedora>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <20240331-module-owner-virtio-v2-6-98f04bfaf46a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n4/kSvCMF0M05hCx"
Content-Disposition: inline
In-Reply-To: <20240331-module-owner-virtio-v2-6-98f04bfaf46a@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--n4/kSvCMF0M05hCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:43:53AM +0200, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Depends on the first patch.
> ---
>  drivers/block/virtio_blk.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n4/kSvCMF0M05hCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYMa5EACgkQnKSrs4Gr
c8j8dggAqO8KJXvt+0JqXmgxsfDAxN196OA9Q6Rm7VF0fuMhGpVUUh/iuOtkH59k
ho0oB9szUvz/1tXZEJPtShx/omt2iENmq22unjzWE7ZmNimALVjtXPaZNTCkYxJn
Z9//Ks9v/lHCNFzLjSiKC94ktRVJLDXSmG7uEpbeutDrzN9TWRJ8DNnylKmm+qWR
VDiL3/2+03gC5B/LovTli4ozZuS4JlG37Tnh2Z8ACNrcFC74nv45KtNuQLR+hNy8
12jEUGkhADWps+fQH7bZebswT9ePfwTfA1xh0pXeeWKCkaiKcgFhZH+JcNQLkwkx
fC80yZK4qnvU1SmzK2tpfzAk7jUMtQ==
=5tJl
-----END PGP SIGNATURE-----

--n4/kSvCMF0M05hCx--


