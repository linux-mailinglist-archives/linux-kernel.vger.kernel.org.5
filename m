Return-Path: <linux-kernel+bounces-79722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D248625C9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C461C20FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BE4653A;
	Sat, 24 Feb 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="du0Gha4L"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290145033;
	Sat, 24 Feb 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787848; cv=none; b=sey7UNfVmIk/OeRFAiyqa45vuPXe7NdGhpdKsEBgbg7PWJvrLw42/1jBkcYwgBHL6hWMTthc2Q30E1/vvhnPr/S8nYMbTlsjhOGZsp+6tPYUy3v5tQ5uMLCtmaJEKarzg6wzqny0NGdOKBatHDhoRsyMv+524/8RegJI1vrGtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787848; c=relaxed/simple;
	bh=/Ai4/Q7V0MmW3HXmJ0iBatCL69uChHgdEWoGbQ5ItZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNVBnz3RLy4v8a/rbUowr85M/DNW9WdsC7jZYNHt3LVrciDj2PlR6c9Bx1S7NS2kM+hgWi8YIUuHe1R0DciyAUIUnoZ5evu7tisfiHJYgLL701ZG5x7PqFAdfFTITm2UupZuzZMM3dxUmkVYcW0j+wYMzAYZtF7hkzKRE66C9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=du0Gha4L; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708787837; x=1709392637; i=erick.archer@gmx.com;
	bh=/Ai4/Q7V0MmW3HXmJ0iBatCL69uChHgdEWoGbQ5ItZk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=du0Gha4LrGTzIR1VjWKkV4JBqPp0HYcNFkXAKgp+S3lsY8SwP7umMaZ78i9Stqu7
	 qpRWmhdqGKhlG0Ep3tVnIGZ79/1OqGqOCI7q7TTcsbM0L2jO1zBEgkjz+iX73g8gS
	 KI5IM7kAtv6MY1hChDP3fLhNfWUjh+LiBluTRmsfbwIIX8MtVicXKEutSwK5xHIVk
	 flrMqemW8jr/1ZXdmfy4mmPQejNBfPvMImaRNVSy5fTKK+04BwtaOC6rtw+9SEOaB
	 FxE4BUzgqR+zVXD+CsMGwTw6dTatuc5yEQDYA+Nao6BrDDSWk04nP8Y5OcIT2mFlz
	 MPYk2qFTBaDYbYYNhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MA7Ka-1rjyZb2BfW-00Bahh; Sat, 24 Feb 2024 16:17:17 +0100
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
Date: Sat, 24 Feb 2024 16:16:58 +0100
Message-Id: <20240224151658.8272-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZsbmeNaBr0xi5hRenKf+OJZBVs7DEAPKRYS0/rm+w2gCsyic61
 sKzfT0VaJ1bEMsEzPS3S/0HJHtkPltI5lPA6sMy5wVX9Ijd+Q4xe3KPZMGRf3ml8q8jXU/A
 fBM/4SBTCpwMSd0FHnXym5s/sL97mYr+tqflhcsJxu2CwINqeMfx+pQYNNNTFBVW6humkHu
 8+J5Txcy1n2/uiIkPmS8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:14ZWeun70VM=;TIYijmmwBT7pG+DaqiuWItPhcrR
 /jGH1gmGcYxnW87plh7Zp11dc3WxGVEO97WpWyDhrGNq9kxH20NvUNJqDcU68mE+z/hO+hFJP
 +DGt+W0bKJXjqomZtkKW57QQYbyQ4Lr+a/thOD9MR+wC5OB39LpDaD+oQ4xg6CoAf28bvcmda
 CvwGmkTAAy8ebfUOq1TnjaUjGU34gWKOL8+PL0s8l2+dqU+91TEMtwgYcdMLPTWkH5DEM1iC5
 TBIK42NpvSk8za3ioZTjnGsozgnaxD3t4aR2WkpeMX2nBfIuaurJItNCMdr0ABqpbPB0LLzv1
 61BZlCmZzjppZE6oPdv34YyVaB4tgxQGyiu35Nrx8xcXixLtnHrnT/PvARLp1zaRx6gan6jpu
 yaU4/Z1eoRWttKnzMqTfE0XXtdh/cZNqIcngNl/8tH1eOGttpFo5Sd4eyAconTt3R8zR4TsSv
 7dZLyaxNrOVk29f7pqIRm80ruENzAFKZ4iRcJHBE7xAgUvgy35duHfkynyatpqIZRsPJLg4sy
 DuBhJ3EjeouU7DlyHEYB1uXToSeEFt/VAnzXDgs5VJvQ+ajtHmj9W6qH8OclwLW3WvZioPzVI
 7DHr4kXWF4HhB0BAvazwMVdGxFpF2zNp2VIuDnI8Gn5ZYP7m8+oizkqQcpu5vU+nfnkz+ewHi
 9mEjwfjooGigD10VYkUwBuEH61QMQyFj6/tkbVdXoJaDYQva2wiZq6C5tHpVS6F7jVTayzqCS
 1x8iFqGGvuv4jHtq+HoEAKex6c2Sk7zqlIjLA4mzxiCyGm5O2kVh6aBnZ0loMJLKZaXmFWJXu
 MuGIoefpWN7I62/e7nQ8XoM0c1oImJ0Ut9kOrDEiBPXSk=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "t" variable is a pointer to "struct journal_seq_blacklist_table"
and this structure ends in a flexible array:

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
kzalloc() function.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 fs/bcachefs/journal_seq_blacklist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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


