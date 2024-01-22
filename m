Return-Path: <linux-kernel+bounces-33616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D01836C54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892EF1F24359
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345248785;
	Mon, 22 Jan 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGDyP7Z0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105E3D981
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938185; cv=none; b=ZN2awl9cf8Fct1Xf8yKZpVG1aurf2AZDltToygurJSB1LJ3jHiF0iCMnNlx8dAh+bGoQMhRmTcQl5wS5PYV0zmcKHttiJ/v9MFcB+eoJa3hhvseSl6NRE2Q/O5DJdd1k5QrguyVK9zaDGwmsJgXqA3iD4prpGwDRuUwKtqwE2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938185; c=relaxed/simple;
	bh=UEj4gAERIGEoPdtDn8jn8QnfibDGp7ffc61lkNbKZ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEJNS+zJpCK0TytZg66zQTHbNv1gdOEW3mJM+OcOQb19yDEHB5eD53Ii07o8onYwv0C0CQ10HztUE8HL0+zVgireaAXUHfZeOfJ1j1uRW74YaM1U4DSpw5NrhEMD6qgEC0vnMLWwRLC5FbHvEeyaeZKuQU3IzKml5KIFOtU/xQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGDyP7Z0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705938183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEj4gAERIGEoPdtDn8jn8QnfibDGp7ffc61lkNbKZ9Q=;
	b=aGDyP7Z0uFAIXf4IzTk8DnrAkYD7bZflBLMgwmsP369mfVVqgojq2UABYn8pHCCz5OPV0h
	77VDTkIQcazdcLu8PDtPNFviqtOSjIN3e2GFD+aJgt56bcoN+L+2tfuLRjozrdjNo7qxqx
	6/qfCiW53rmk6O+FdmYLq4F58RpwUDo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-t6nMjAPcMqGP7iNVD1tHag-1; Mon,
 22 Jan 2024 10:42:58 -0500
X-MC-Unique: t6nMjAPcMqGP7iNVD1tHag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2895B3C025B1;
	Mon, 22 Jan 2024 15:42:58 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61FCFC259DD;
	Mon, 22 Jan 2024 15:42:56 +0000 (UTC)
Date: Mon, 22 Jan 2024 10:42:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yi Sun <yi.sun@unisoc.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
	hongyu.jin@unisoc.com, sunyibuaa@gmail.com
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-ID: <20240122154255.GA389442@fedora>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
 <20240122110722.690223-3-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eXv2gE92Usb5fs07"
Content-Disposition: inline
In-Reply-To: <20240122110722.690223-3-yi.sun@unisoc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--eXv2gE92Usb5fs07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive. So it is better to place
> blk_mq_quiesce_queue() in front of virtio_reset_device().

QEMU's virtio-blk device implementation completes all requests during
device reset. Most device implementations have to do the same to avoid
leaving dangling requests in flight across device reset.

Which device implementation are you using and why is it safe for the
device is simply drop requests across device reset?

Stefan

--eXv2gE92Usb5fs07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWujP8ACgkQnKSrs4Gr
c8j4JQf/dPyJyYzS3Bby2PGbjhtqMfkxWPLzThhLRlbyvKX27qbZx0RGZoWtmUBM
vDn2i3qmIoXs6vvj6N/y67VNoMAellkdO4HFstAF2BW8AehglGRbQMW0Bxhp/4er
xIPRGRNhs77ybcO0DJB6qnB99e3VWRpAnALJXNgzAYkQrghnMCkQKFK6UsPP+GXc
XQ+Tlzm8RngA6L46s42zyJ9Do6ZEykuif5BLKpar7vzXz1mCKAgGlWG9HKmXFwta
FBqmnl8fB1GAmRsKqnqj6hQHnSXvdtBfbM4813qfCNUaaWGwaoCAQYTw9PDDWL8J
cmGCudXGHAQ4MNItXS65SUzHkpmlZg==
=OduK
-----END PGP SIGNATURE-----

--eXv2gE92Usb5fs07--


