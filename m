Return-Path: <linux-kernel+bounces-20742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 203FA828481
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB101C23ED9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353336AFD;
	Tue,  9 Jan 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OU6LGNvO"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621D37143;
	Tue,  9 Jan 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id EE39540737C4;
	Tue,  9 Jan 2024 11:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EE39540737C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704798544;
	bh=dZSYFuprTqfspA6v9+rP8mVuX6czoir5pAkVaXwFN5M=;
	h=From:To:Cc:Subject:Date:From;
	b=OU6LGNvOv/bPvRC0J1P8GLE/fLpU47BIoftyNVi4GmcnI9K1URhtFoff4lVqj0Hhh
	 SKbo0piEcmU7EXCN22qQSqrj8cJQdaUcN/UgXpq5UUfTQw2ZAibhGibFNDnlBLBSiy
	 zji+42Z33Eeo8UppEXj+OETCbcZCJBX2CqUId60k=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Wander Lairson Costa <wander@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/1] drm/qxl: fix UAF on handle creation
Date: Tue,  9 Jan 2024 14:08:24 +0300
Message-ID: <20240109110827.9458-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug `KASAN: slab-use-after-free in qxl_mode_dumb_create` is reproduced
on 5.10 stable branch.

The problem has been fixed by the following patch which can be cleanly
applied to 5.10. The fix is already included in all stable branches
starting from 5.15.

Link to the "failed to apply to 5.10" report [1].

[1]: https://lore.kernel.org/stable/2023082121-mumps-residency-9108@gregkh/

