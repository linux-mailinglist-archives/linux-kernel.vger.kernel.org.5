Return-Path: <linux-kernel+bounces-17479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC6824E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B86D2862CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131753AC;
	Fri,  5 Jan 2024 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kwRuDrs6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7A538D;
	Fri,  5 Jan 2024 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704431832;
	bh=nHoW9gobpmGg5BUBY8TzEAIrwDE1AD2t9/HhOPtJlj4=;
	h=Date:From:To:Cc:Subject:From;
	b=kwRuDrs6at1fxwuh2IqqTH/memtEe2Mp7N/TXa8Rt4C+8QvzyQgg4lBsgCarwY4Mm
	 y6JHmE5bXeeisr8c12cKlUq5nTfLz4SGVzgU4CdWRQAGBCz0F7MdTUBf/NZH5ST68f
	 k5nFNcg0q4rKW9A3DuWBLepolIcV5hNf6eFUeKr7YArmAamjwUR3wyFAnymBWmw7sX
	 w8wX8Rea3zB22l2Kibk9y/z9yBvNAe+VXrRmw1CLo52v6zwPKBM+m5T7KaAKiOhCIV
	 uSPCd6RoMNeWCfhU1WDjj95xpzA7QHKAqzXCJOPLAhYeTkgGawlC4avcBxX9yBoL84
	 jcMHJOzdYagNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5sCD0DR5z4x1x;
	Fri,  5 Jan 2024 16:17:11 +1100 (AEDT)
Date: Fri, 5 Jan 2024 16:17:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cxl tree
Message-ID: <20240105161709.22d1b027@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gvNwq2VFK1sACazWmpghUWe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gvNwq2VFK1sACazWmpghUWe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cxl tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/cxl/core/cdat.c: In function 'match_cxlrd_hb':
drivers/cxl/core/cdat.c:327:43: error: 'struct cxl_switch_decoder' has no m=
ember named 'target_lock'
  327 |                 seq =3D read_seqbegin(&cxlsd->target_lock);
      |                                           ^~
drivers/cxl/core/cdat.c:332:38: error: 'struct cxl_switch_decoder' has no m=
ember named 'target_lock'
  332 |         } while (read_seqretry(&cxlsd->target_lock, seq));
      |                                      ^~

Caused by commit

  185c1a489f87 ("cxl: Check qos_class validity on memdev probe")

interacting with commit

  5459e186a5c9 ("cxl/port: Fix missing target list lock")

from hte cls-fixes tree.

I have applied the following merge resolution for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Jan 2024 15:44:24 +1100
Subject: [PATCH] fix up for "cxl: Check qos_class validity on memdev probe"

interacting with "cxl/port: Fix missing target list lock"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cxl/core/cdat.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..10ac76bed477 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -8,6 +8,7 @@
 #include "cxlpci.h"
 #include "cxlmem.h"
 #include "cxl.h"
+#include "core.h"
=20
 struct dsmas_entry {
 	struct range dpa_range;
@@ -315,7 +316,6 @@ static int match_cxlrd_hb(struct device *dev, void *dat=
a)
 	struct device *host_bridge =3D data;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_root_decoder *cxlrd;
-	unsigned int seq;
=20
 	if (!is_root_decoder(dev))
 		return 0;
@@ -323,13 +323,11 @@ static int match_cxlrd_hb(struct device *dev, void *d=
ata)
 	cxlrd =3D to_cxl_root_decoder(dev);
 	cxlsd =3D &cxlrd->cxlsd;
=20
-	do {
-		seq =3D read_seqbegin(&cxlsd->target_lock);
-		for (int i =3D 0; i < cxlsd->nr_targets; i++) {
-			if (host_bridge =3D=3D cxlsd->target[i]->dport_dev)
-				return 1;
-		}
-	} while (read_seqretry(&cxlsd->target_lock, seq));
+	guard(rwsem_read)(&cxl_region_rwsem);
+	for (int i =3D 0; i < cxlsd->nr_targets; i++) {
+		if (host_bridge =3D=3D cxlsd->target[i]->dport_dev)
+			return 1;
+	}
=20
 	return 0;
 }
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/gvNwq2VFK1sACazWmpghUWe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXkNUACgkQAVBC80lX
0GwC8wf/fe51lisvUioHJWYNubsayAdREhIgyRKw3s4LBfDnjseGmnrShJx2PQeq
7asAvMVmyOtqoqxVhfD4tgRKIehCs+niQVEdwsCEMhROTdurXvq3ohVKvgdaorUR
SARToAHg7U5qAj4C42MGVGDPSgxQXASHznfB82oeGsoFez8hEF1H+1Krif5KaAaq
AZZv8pICTgwm+V4knauxtjPXw+M8CkRFpUU33gzexwWEkFpZPYPqNoZiE0aq68N2
49FKwevy2Z/Hrl8gIsO3WcweAUJ+fgeuLGsTABYmcSBZW884Un8G/KKgn8c8hwHx
bKPrbHTVJ+xdCLvW9q71LVBkdxW5xw==
=0Juv
-----END PGP SIGNATURE-----

--Sig_/gvNwq2VFK1sACazWmpghUWe--

