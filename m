Return-Path: <linux-kernel+bounces-72006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E185ADBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF150B2451F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AA5472A;
	Mon, 19 Feb 2024 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="U4xzDhUm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DE537E4;
	Mon, 19 Feb 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378310; cv=none; b=K8X8jE8V1L00otog/H5YhVXPlp3VW5mRX4iZ5u0710iv9+FjKng3lMNB5FFayyA+ffbt6iRHM4psgkmSxfYA8JFNsTBxNi9n216pVomw0B8VHCMYwndnndYn0kLxOofUbMkwsShOBbWoa5wn6h97QE9mXDrpnEA9rzqsOjCKx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378310; c=relaxed/simple;
	bh=ZiReS0b8cq+Jf0YCXBbhwJ2HZaP2tiE7v4S80Tzy2cM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQ5ZqyD5aCUsUPWQIKX5oaRoKxo2deJ0vfM5Kz8+vnkoU2wPks0Xc/qId9JMe2ydyugdn5tJoGFQsMDqqk4QgCtZWhvNL/Ng8F7Umfb0nnw4xv7/CBRgDNDlZuMf3pgP0CL+BDdBZhCuXazIfvbDCfpqz84GERhgQ6tL+FI7gn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=U4xzDhUm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C36547A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708378308; bh=BCT+TLt/dYSux/jbqie64qQ0pVbWC/leuWHn6KQ+h6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U4xzDhUmU7kd5Gru/Le9N5Jc9LLigDliGonkz8V/gfGQglc2rjo6CTphSmeoOnoKI
	 APnnrvAcNvyd0Vnfgragl57DqZlilfrWv/rA7QwphurbGmK6cnRX39VtZBGB7mFTEj
	 jS0e82K1m6e1br0bNNQ8MlzBLuK66rh6l9pQ0MRrWdMKnOuwrn99L73a8a/1On97D5
	 Z/nmSqRH8/Nq5Qs/2p6qS7XHXpqBVZBlV3sYiTTfhEUe1R+uyjApCci9vVo/sNdijX
	 34dsxnAyfg3MkD2Z8hXS7vVhOPIuvQcJc7U5zYEgU3AePZ9UG6rRuPwRJCaaxmLJwC
	 6VXO8Ffr6Rzew==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2C36547A99;
	Mon, 19 Feb 2024 21:31:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Bilbao
 <carlos.bilbao@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 tech-board-discuss@lists.linux.dev, workflows@vger.kernel.org, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: update mailing list addresses
In-Reply-To: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>
References: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>
Date: Mon, 19 Feb 2024 14:31:47 -0700
Message-ID: <878r3gnnss.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> The mailman2 server running on lists.linuxfoundation.org will be shut
> down in very imminent future. Update all instances of obsolete list
> addresses throughout the tree with their new destinations.
>
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Jon, I am sending this primarily to linux-doc, since most of the changes
> are in Documentation/* and only a handful in MAINTAINERS. I think it
> makes most sense to bubble this up via the docs subsystem.
> ---
>  Documentation/ABI/testing/sysfs-bus-vdpa                       | 10 +++++-----
>  Documentation/networking/bridge.rst                            |  2 +-
>  Documentation/process/researcher-guidelines.rst                |  2 +-
>  .../translations/sp_SP/process/researcher-guidelines.rst       |  2 +-
>  MAINTAINERS                                                    |  6 +++---
>  5 files changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

jon

