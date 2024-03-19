Return-Path: <linux-kernel+bounces-108047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2F880533
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E70A283E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B239FDA;
	Tue, 19 Mar 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6G3voTm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293D2B9D7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874798; cv=none; b=A95/lEwhqHohuuDoEo63jhrTczeG5PKeHAa0i9qjgVl0inmNEeFzex2/tQhP78a5DE8o6dAa84oRlkLoAWIxRZA9u7qr/iCBUZRlqLoC2lefMsamsoACkpHC+QqEROOldhLNqgkzTwKWWwF5/9wCgDp9A9HmPxF6IEPRLoOGd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874798; c=relaxed/simple;
	bh=SoQAjBBgsyMmx7FZyCs2CojnY/io37fmcb8h+s7f7Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHis2cOlonSTz+DWyWJHzmZkQz8oHYsXwzn5bFJEKDPUAA/KDjFKGJX1fLXlq9XDO8H76Iry3C3mLVoDa9O0STB3M13W/6ELTI/0Ej1Vo3PZ+snuQJqui5xcx1CffY1dqrnL04Km3R1hD1VeM+DM5MHLz4sBebs/4Rn0tbhwLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6G3voTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710874795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoQAjBBgsyMmx7FZyCs2CojnY/io37fmcb8h+s7f7Cc=;
	b=H6G3voTmXKRJlcVwn/IFXTf3yV/q6ZQDyKnQBcxZcJ0dZ6VTnLV0nqDv+XnZ1ks7mrvQVO
	PH4B6DAcVR74tJWFAEnwacpil6tw5rG9lO+9YAKIBlY+WqjP0RVHj+ESRnnS4t9nsebWG0
	wAjrgdFFXtEViL4BC4gqWgvgau120B8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-y1HlCi9QNn-YADG6YxDA4g-1; Tue,
 19 Mar 2024 14:59:53 -0400
X-MC-Unique: y1HlCi9QNn-YADG6YxDA4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6D8038009E7;
	Tue, 19 Mar 2024 18:59:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB83017A90;
	Tue, 19 Mar 2024 18:59:51 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:59:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240319185946.GA1134281@fedora>
References: <000000000000cfd4800613fe79b1@google.com>
 <20240319033941-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1qhB/swQVRYSNmxw"
Content-Disposition: inline
In-Reply-To: <20240319033941-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--1qhB/swQVRYSNmxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 52998cdd8d3438df9a77c858a827b8932da1bb28

This is the last time virtio_scsi.c was touched. If the test passes then
the issue is probably in another subsystem and we can bisect more recent
commits. If it fails, then older virtio_scsi.c commits need to be
bisected.

Stefan

--1qhB/swQVRYSNmxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX54KIACgkQnKSrs4Gr
c8hI8gf9FyLEhUZ2CxIbtdgn26qHFikmHCqcXBqAx0am78njMRBof6rhTipL4nWk
QA96+1gUvZrzC/PEb1927MJmNFLUnYgCkc/DLhaCGpuOvwuIBD++thTH1/YpSvPY
q8KVxTrv+/HNzACIBlfz9sIO7/JkatQugxHpJzRysIaylhm8PuzzPEjmTjZauve+
IOGfB06zMJZqmFZuGET+M58+t9p9hOdteoEVtDVkzGa+FXOEp4g11fspqh/h55nQ
7AM8XR66MxpKL9uUKv/H8mbfumEkBwhHmdTQXUftjaXOHSwgBQxJONg1jQVcIj6O
zP98QczOTd5mIPKWs/xKQ1IBvf0RfA==
=Rx+T
-----END PGP SIGNATURE-----

--1qhB/swQVRYSNmxw--


