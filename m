Return-Path: <linux-kernel+bounces-46059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCA68439E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7995BB29EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829FE6D1A1;
	Wed, 31 Jan 2024 08:50:11 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F7627E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691011; cv=none; b=VCLVws33ZeTEbZX+GqWjoVXvhR4fafbRN5r9xbknTn20opVXQr1GSuJHL/aUAC3KCCPpucn0C7ryJWJn/E4JA77b/Pp+pVByP9uOMKqk6aAPuWQQ3hu+DYS9IIZ/bn6RizEeExm1vHZDu/mNyeTdHgkCJtYTaDjV1KFBogrCUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691011; c=relaxed/simple;
	bh=hgYrlyum9ghldRfi71BPoPkiLs5SofiKpFQx9coRK/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpqoD5mIQ3i2FoFrEoIkd5ZSvcX7pYFs/GVBGkmyZQMRiuDSv4zgFW/BpZtAPJXjXAGix2Fd28Ldln8RIXo2NVcC31OcgyuWUwkiyEq4yoSlEPru+JkSNiw2qSGduFdG2E+X28p+oRvvbEgE3Lf3sZ9VTtr1w3XNUzFGN/BRAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40V8nuvk032172;
	Wed, 31 Jan 2024 16:49:56 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TPwWv18wkz2SB7BY;
	Wed, 31 Jan 2024 16:42:19 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 31 Jan
 2024 16:49:53 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Fangzheng Zhang
	<fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
Date: Wed, 31 Jan 2024 16:49:49 +0800
Message-ID: <20240131084949.449740-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40V8nuvk032172

From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>

In order to enhance slab debugging, we add slabreclaim flag to
slabinfo. Slab type is also an important analysis point in slabinfo
for per slab, when various problems such as memory leaks or memory
statistics occur.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 mm/slab_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..aeeb2bfe6dda 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_file *m)
        seq_puts(m, "slabinfo - version: 2.1\n");
        seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <=
objperslab> <pagesperslab>");
        seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-       seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>")=
;
+       seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <=
slabreclaim>");
        seq_putc(m, '\n');
 }

@@ -1071,8 +1071,9 @@ static void cache_show(struct kmem_cache *s, struct s=
eq_file *m)

        seq_printf(m, " : tunables %4u %4u %4u",
                   sinfo.limit, sinfo.batchcount, sinfo.shared);
-       seq_printf(m, " : slabdata %6lu %6lu %6lu",
-                  sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail)=
;
+       seq_printf(m, " : slabdata %6lu %6lu %6lu %6u",
+                  sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail,
+                  !!(s->flags & SLAB_RECLAIM_ACCOUNT));
        slabinfo_show_stats(m, s);
        seq_putc(m, '\n');
 }
--
2.43.0

________________________________
 This email (including its attachments) is intended only for the person or =
entity to which it is addressed and may contain information that is privile=
ged, confidential or otherwise protected from disclosure. Unauthorized use,=
 dissemination, distribution or copying of this email or the information he=
rein or taking any action in reliance on the contents of this email or the =
information herein, by anyone other than the intended recipient, or an empl=
oyee or agent responsible for delivering the message to the intended recipi=
ent, is strictly prohibited. If you are not the intended recipient, please =
do not read, copy, use or disclose any part of this e-mail to others. Pleas=
e notify the sender immediately and permanently delete this e-mail and any =
attachments if you received it in error. Internet communications cannot be =
guaranteed to be timely, secure, error-free or virus-free. The sender does =
not accept liability for any errors or omissions.
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=E6=
=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=BE=
=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=85=
=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=
=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=9D=
=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=A0=
=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=
=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=
=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=A8=
=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=E4=
=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=B8=
=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E6=
=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=A4=
=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=8A=
=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=E8=
=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=80=
=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=92=
=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=E6=
=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82

