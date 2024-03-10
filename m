Return-Path: <linux-kernel+bounces-98185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30087762F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510F11F219E1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EC1EB46;
	Sun, 10 Mar 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="LOmqMada"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD92F5B;
	Sun, 10 Mar 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068576; cv=none; b=IelaEKlGwTxcdS99PvWBfp0xZ6JHko9H7RYwENYyBWcTm4sgaltAI2oFQLj5T+LAWjGlnZWT103gSTrGHD0E9YtdeLdkIzkTab+jYWn/Wg9KVXXvrWGkw/8Ox0gj//tzfhGR515xzG8TkIZ7k59wORUy8yuH3GTj0qSmWQyG2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068576; c=relaxed/simple;
	bh=+5rMfr/k6XDk+OyUhtil8qcaQkwr2DZZRPRtYFIAiHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHWA2toy1DUtHY4aB6Gq+VQVX4OeYL+kENXNZgi5h2Fhu2o5uIgyiQtIygAf3pAp0HBc86RFzrYXcq8Nbp3NrDHx1YK/D8l7+LowZX6KxBvzSFa+0du9bEArmSNN5os5CQEOoa++unixuN9/Ylp4/aDEkRaUjx1EYB0kUmFtUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=LOmqMada; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1710068564; x=1710673364; i=erick.archer@gmx.com;
	bh=+5rMfr/k6XDk+OyUhtil8qcaQkwr2DZZRPRtYFIAiHY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=LOmqMadaANh0URyyeDwqOx+00f3MsVnMzVsLE0uhcG1byIOMPmo+kfs0Wfghmu3d
	 b81IoXhUPcYQvX2JTuAp1kCn8W16x6pc5S49oLcapmlF/gYD9DQ5jeSKdmmqvIhyH
	 tI3tOhQ7OLh05Pj7dKVChPQSIyZo8Fs54gwg0kvZHGueBqVG/hi4zwT7r7232W/61
	 VXNy2mxtQBkR4ZHHKfdBOp6+RJGg45xino/mMBGspproZ7pYEhNZWtMfBEXdSJdUa
	 hb53+oz8YFRhMJ0+a/2RUQBvKWsglJpV7r4JUMYQZpGTjQ8o4JVw7FXmasjVVGlVt
	 lwvnfCHBv3UylzyCKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mr9Fs-1r50WT4634-00oDvT; Sun, 10 Mar 2024 12:02:44 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] bcachefs: Prefer struct_size over open coded arithmetic
Date: Sun, 10 Mar 2024 12:02:26 +0100
Message-Id: <20240310110226.6366-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1gqFpsuchBie185tu/ilDuLd/4EkL2N0Cl0n4oU0HUDgj5jkASv
 2JxRgVRDvB8/EaPtFAioHFHJxAagCpY7mL9CkPmiABF7tOIFXdkaR5hgluwClEh9Axg1ewJ
 VjI8Uuu+nMLCFBMl7xEdIjXh5OZZePiASH2hkNdNoxJz+nPUNCMHD2psMmGIAgkKj/u7GGW
 yNX9qp9L1pPm+UBI3PbYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JwKYqJuPPMo=;3Zx3bGf7tDqDsQJzmUIOrUtp13Y
 B9nVzkrtiSCLALgkQ1ZfCdfjxLUfC+asnVqjIUfXJ3KyJyFb3Gn+jIBE0FPmmRUMiNIVSk5hz
 DJLHQanyaYeAIsTnHtsF0iHaBwkiP54+1MTGSLXqyQ4g42Z846mMoTJe+1Uv2Aj3a6pAre5Q1
 EHHE+rEJKel2GMu4rPEqOu8tjNJTe045/irw8dVa8BSm2R6/Y2iqAmVoslZp3Xt93LCUHUI1Q
 /IqhcUH1bSn1hExcymfnvakqIZ9bosSUeWta619trRu03yW5OAtclZBtUZuWyHoHqMrPrmUc3
 zaLrS/sdZGdAskS9tuq1cTM0TWVAsksrrC2qTysaWxIVKfEa5O2wAvZH0ORitGO32XYyYzdHO
 chfvcEsarJf4RGWJ0bGDxvew0JuHhStzBw+hijEDJCQaCOHaI50AkJf343fRo4vLFIDL1h+9F
 TFir0JsSDd+EoTW69S8/++/sLcQqaXQFUpaJxjoYn1TC3C9Polq+1C+fbYc6/dv8Y+496Z/+9
 tK10XstzvtMIEMh0UUBRCcV1Pu47dHM0jUrNQf/dNrgYVs8va25VwfQRsUZ7AqlvLwzm7d3ny
 XUIhpsqTPyqsiDxmWmCy+slZS6PrTYGcQIWsBA63w11na/ks+NtrapebyFlI6XBpBSaLM9xor
 Nih5932npaGl22GI+pLcOXV7P7+Q5JVUXYFPa8CLK9zJh8LxnJRBgnR3c8Quszrv8kdFE2ITd
 ebFl6K8ulN+mxJKMAKwkSMTaTeiHWvcqYxkT4pj/E4CxgukTiYHnWt5YzWtpcTQ/GJaxIgCam
 YuFeb0cowD7n0ZJaI1IxmcKALQ6oDr9AxToilGTuz8ZF0=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "op" variable is a pointer to "struct promote_op" and this
structure ends in a flexible array:

struct promote_op {
	[...]
	struct bio_vec bi_inline_vecs[];
};

and the "t" variable is a pointer to "struct journal_seq_blacklist_table"
and this structure also ends in a flexible array:

struct journal_seq_blacklist_table {
	[...]
	struct journal_seq_blacklist_table_entry {
		u64		start;
		u64		end;
		bool		dirty;
	}			entries[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + size * count" in the
kzalloc() functions.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Merge the two patches in one single patch (Kent Overstreet).

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/20240224145924.7468-1-erick.=
archer@gmx.com/
v1 -> https://lore.kernel.org/linux-hardening/20240224151658.8272-1-erick.=
archer@gmx.com/
=2D--
 fs/bcachefs/io_read.c               | 2 +-
 fs/bcachefs/journal_seq_blacklist.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index dce136cd2271..01beab55c6b3 100644
=2D-- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -174,7 +174,7 @@ static struct promote_op *__promote_alloc(struct btree=
_trans *trans,
 	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_promote))
 		return ERR_PTR(-BCH_ERR_nopromote_no_writes);

-	op =3D kzalloc(sizeof(*op) + sizeof(struct bio_vec) * pages, GFP_KERNEL)=
;
+	op =3D kzalloc(struct_size(op, bi_inline_vecs, pages), GFP_KERNEL);
 	if (!op) {
 		ret =3D -BCH_ERR_nopromote_enomem;
 		goto err;
diff --git a/fs/bcachefs/journal_seq_blacklist.c b/fs/bcachefs/journal_seq=
_blacklist.c
index 024c9b1b323f..2c2490aa15fe 100644
=2D-- a/fs/bcachefs/journal_seq_blacklist.c
+++ b/fs/bcachefs/journal_seq_blacklist.c
@@ -165,8 +165,7 @@ int bch2_blacklist_table_initialize(struct bch_fs *c)
 	if (!bl)
 		return 0;

-	t =3D kzalloc(sizeof(*t) + sizeof(t->entries[0]) * nr,
-		    GFP_KERNEL);
+	t =3D kzalloc(struct_size(t, entries, nr), GFP_KERNEL);
 	if (!t)
 		return -BCH_ERR_ENOMEM_blacklist_table_init;

=2D-
2.25.1


