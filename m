Return-Path: <linux-kernel+bounces-79708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA068625AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFFE1F22974
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C645BF1;
	Sat, 24 Feb 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="ZtoPfK2K"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5145028;
	Sat, 24 Feb 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708786791; cv=none; b=L7UoN+YTR1F/X1YbRDaQRib4/8GWaGYME6esbgGl8OQ8IT0YaEuqP+caE7XKhcxWfqOZtNmqhErKwX+ZLgHXzp1E+VaMK4WF9RLDCWLTU6hwYjIP8UTdAYBPswsO5nSG64Cn2/czg1cfZja6SQfijjTmxH1w1ljsVI8tLEalfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708786791; c=relaxed/simple;
	bh=GXwJdQKczfCri7kuRFyPAfWFwpv9CLz1xjPSkkrGDBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+1uYnxo3vtmbikTMNvj6PmRoowD6sOrqc0n1+paCRpZiklkudkuZJ2zyICkuCNwyo+fSRXb9DLKFgRlZ00JZkVK9Xidrd0J9Gb7WcfMQK5USDjAtrWsLPVIUiLyOr7mXIbOF9bovz4WgEPGU9XtoRD17ruH2v/Jmyc2oXLgi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=ZtoPfK2K; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708786779; x=1709391579; i=erick.archer@gmx.com;
	bh=GXwJdQKczfCri7kuRFyPAfWFwpv9CLz1xjPSkkrGDBE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=ZtoPfK2KUcgeUx7BrZozE9lFn3/vLA49E1ChYV/y6jnopnfYH+tOI8iazTwx//Td
	 wM0/HJLVUjXkGN/+C+o+ov2121Pe30hfUWJLsMOo1bgJMcKsb1danFAni1PZUn0ZS
	 8JqKFjYQ5bd3v6J2YYVVCd62ZWNUg35zEtJGFPdXnKJC8P5sl/GTmI1J83umU7wVd
	 bGxzy/EFjvdkIgL71nmgiw2rOWjxfhAskzyRAO974PnZ6q7lHD5OOtfSsur29MSC1
	 qYFbxRW7jFxhNDCdMVWObC85tHESs+z/6leKvf9JNrxO3kRIb7151W6minzbWZxAF
	 YNkpgm6TTlk2dyxwNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N7i8Y-1qrCvp1g1K-014ieB; Sat, 24 Feb 2024 15:59:39 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] bcachefs: Prefer struct_size over open coded arithmetic
Date: Sat, 24 Feb 2024 15:59:24 +0100
Message-Id: <20240224145924.7468-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JUoiwKLF8APLvcFjy9rt3Tj1Yh62YBlzwLpZ/tX95GiVy7Ykwsz
 YwEEQ6AfKP+TnH3k4Rp7Qi6vq3AZ1859s1mPKceixyerZ41+mVf0FRhXy5DqKPTcMPR0Pkw
 e2qb9Hks9yUrs3pnRzHu3VbBfwC0u9B64K4xvsZJbSsJJD2NFmYNBD+ONjdkIWaQ1c4eMZP
 jhDTGAGZ5VbB2pNVHUXiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u5njqjBC44s=;+Up8iJIUClOpGuh2fvPIJnlxf1q
 y/NJQQvQ8X6Meif7skAMa8oZOjB1bjBc76N5VMaZDyNUMU0ZiMvXxkLtEvmLWq6O8Thzp38zp
 hfuCcdDsOrbN5Y3E+Rsefo9JfeihJ9zuMmOC7UKABoSAKqVdqPamv0PiyoNGwaisAPc7iQVeL
 vqTBOptLQoFYOljJpF3m+vnybexTdNCSB5H+Yr3GuRtA6CE623dUcgQW/TjoZ7fVb7pa+mRtC
 aQBfI5V19rj63Gs/h48Mn0yrfdYHk7feTt5gpGH8Gv3KRC+JuVmHBAmNx42dFniqkpaCofH89
 GBpApAtghWNtjlhGKXlurYu4UM9p2DrqLpmmu8LXoIFOXkbG1dUWSUdRamuoCUA6Yb0YXPsnN
 SgWtUFj7wRpLaXo3rpNF3cw+dnIrwc/oNiXAvGSZ8S8boNCj2uS4ir4aiChmRYF53+vzO44YU
 Q6qdcOLRMj7U5zDUGw6H0/14v3MnL3GL43ZSoE7AZU4y0jlJSs9k1O0r7/0bQiOuXlHnIm3m+
 IKrF1KvVjfhaAt/4XY6tbDiPq4RXJH708HT3JLvp5IsnisDcwPv/TQH+FMYUvPzEx8iQZ1PmH
 ff5xQLe2nkZVcEG8iz7CbBqrwTHPyaqrEdWq7L6/fYxzx0iEEbKiZXUtMJkRRdFam3g8pTCzw
 NaYH8Zm5vpBGI1/o6p7eLrunrQFIvUmKAuTOkIoTC8kkuOIlc2Zo7auKb+bl6H7Mx06VZMdMz
 UPIJI8Hv1WtFvtVxHMFC0V245dcgCZXOOJttmsUjo5WGvl5d88wadNZEIq9TP/SvyDWef6D39
 mJ2YtKlTKBeyxtZ7yQWhSpkVYIgq/UfGR5pxF6lDH/AVs=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "op" variable is a pointer to "struct promote_op" and this
structure ends in a flexible array:

struct promote_op {
	[...]
	struct bio_vec bi_inline_vecs[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + size * count" in the
kzalloc() function.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 fs/bcachefs/io_read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
=2D-
2.25.1


