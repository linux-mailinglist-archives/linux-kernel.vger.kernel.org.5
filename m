Return-Path: <linux-kernel+bounces-16491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A389823F48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6D286D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0720B16;
	Thu,  4 Jan 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="hWfltW6+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71020B02;
	Thu,  4 Jan 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9758F28B53B;
	Thu,  4 Jan 2024 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704363188;
	bh=j+qznhwVfcrCXO97E0Jld5V71MZIo0m6mSOS1YPgQZY=;
	h=From:To:Cc:Subject:Date;
	b=hWfltW6+nBoLPlzOFWVPtgMG0gPu8GhbhV1vBgU8mzf+hQqhE3xn8SRdPIp31I3DJ
	 cwYoV39J6/fLpULvNP2QJQ2qSRj4M63xCjm0gOaGRaAf0AkvOGfbElQIOd8ldQ8KaA
	 oYkTuVvB46Fqvh8u+OxKh1od7uUKl2X+/07M9CJs=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/1] tools: iio: fix iio_generic_buffer
Date: Thu,  4 Jan 2024 12:12:44 +0200
Message-ID: <20240104101253.25896-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While executing tools/iio_generic_buffer i was getting this fault:

beagle /usr/src/linux/tools/iio # ./iio_generic_buffer -a -c 10 -N 0 -T 0
iio device number being used is 0
iio trigger number being used is 0
Auto-channels selected but some channels are already activated in sysfs
Proceeding without activating any channels
/sys/bus/iio/devices/iio:device0 mytmr
Floating point exception

The FPE was generated due to a modulo zero in size_from_channelarray()
(all channels[].bytes were zero because channels[] were never populated).

The root of the cause is the seekdir() function within
build_channel_array().

On my system I can observe a clear difference between these two functions:

    seekdir(dp, 0);
    printf("location = %lu\n", telldir(dp)); // location == 4294967295

    rewinddir(dp);
    printf("location = %lu\n", telldir(dp)); // location == 1

The attached patch fixed the bug for me.

I'm using a BeagleBone Black devboard with an up-to-date stable branch
Gentoo Linux OS on top of it.

CHOST:  armv7a-unknown-linux-gnueabihf
kernel: mainline 6.7.0-rc6
glibc:  2.37-r7:2.2::gentoo  USE="caps gd multiarch ssp static-libs -audit
    -cet -compile-locales -crypt -custom-cflags -doc -hash-sysv-compat
    -headers-only -multilib -multilib-bootstrap -nscd -perl -profile
    (-selinux) -stack-realign -suid -systemd -systemtap -test -vanilla"
    (+ contains Gentoo specific patches)

Fixes: <e58537ccce733> ("staging: iio: update example application.")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Petre Rodan (1):
  tools: iio: fix iio_generic_buffer

 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.41.0


