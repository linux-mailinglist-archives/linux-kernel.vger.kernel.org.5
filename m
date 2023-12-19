Return-Path: <linux-kernel+bounces-4519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B77817EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E79B23F44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C823CC;
	Tue, 19 Dec 2023 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6LPmx9k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814A1872;
	Tue, 19 Dec 2023 00:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6469DC433C8;
	Tue, 19 Dec 2023 00:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702945496;
	bh=nA9/a7919dPKMYYw5KWRsWrqeemlp+0/WOnVbITGovA=;
	h=Date:From:To:Cc:Subject:From;
	b=L6LPmx9kTw0B4hbMomnqLSv4v1LiFIl5o7dvjeP7kX4xsrxOf5Z8fCNAz9mSQrGjs
	 kxJdkvtTxNX3Jo3NgBv8olBjMLd85TbAO2dbqLgub4aihd/CPj8k7K45Oy8YW7hCFk
	 +oHSaN8GJlS0getphbAFGOanV3rG3cPw9Jk2Nk+5Xu45CDAM623ORXlHB/x0B7P08K
	 cShjKpfA8h9oPZVY3Xzq5JQ108iVu2S9oiUj0bxb/W2y0BfLogUx+cg36UAdHMtyEn
	 VKhXZTLM7diAFpNBDzsAjJRpumC0b8JZuqDjdBj0d0RSEv4lAmch7hH7kDg52dK0VZ
	 1pSPn3KZ4IbpA==
Date: Mon, 18 Dec 2023 18:24:53 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] bcachefs: Replace zero-length array with flex-array
 member and use __counted_by
Message-ID: <ZYDi1bWIKRSs2NpH@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fake flexible arrays (zero-length and one-element arrays) are
deprecated, and should be replaced by flexible-array members.
So, replace zero-length array with a flexible-array member in
`struct bch_ioctl_fsck_offline`.

Also annotate array `devs` with `__counted_by()` to prepare for the
coming implementation by GCC and Clang of the `__counted_by` attribute.
Flexible array members annotated with `__counted_by` can have their
accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for
array indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family
functions).

This fixes the following -Warray-bounds warnings:
fs/bcachefs/chardev.c: In function 'bch2_ioctl_fsck_offline':
fs/bcachefs/chardev.c:363:34: warning: array subscript 0 is outside array bounds of '__u64[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
  363 |         if (copy_from_user(devs, &user_arg->devs[0], sizeof(user_arg->devs[0]) * arg.nr_devs)) {
      |                                  ^~~~~~~~~~~~~~~~~~
In file included from fs/bcachefs/chardev.c:5:
fs/bcachefs/bcachefs_ioctl.h:400:33: note: while referencing 'devs'
  400 |         __u64                   devs[0];

This results in no differences in binary output.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/bcachefs/bcachefs_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/bcachefs_ioctl.h b/fs/bcachefs/bcachefs_ioctl.h
index 21f81b16f24e..4b8fba754b1c 100644
--- a/fs/bcachefs/bcachefs_ioctl.h
+++ b/fs/bcachefs/bcachefs_ioctl.h
@@ -397,7 +397,7 @@ struct bch_ioctl_fsck_offline {
 	__u64			flags;
 	__u64			opts;		/* string */
 	__u64			nr_devs;
-	__u64			devs[0];
+	__u64			devs[] __counted_by(nr_devs);
 };
 
 /*
-- 
2.34.1


