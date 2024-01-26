Return-Path: <linux-kernel+bounces-40573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58383E29D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BD41C21CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276424203;
	Fri, 26 Jan 2024 19:32:16 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638932375C;
	Fri, 26 Jan 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297535; cv=none; b=bj7Zt1ogeAX4LG+vGwhVOovqOYG7v2tAqBDmpGqE7z0GF9fVNqriEAp7h6ecOfZ9HsP1TLBwgVTj9FHI21TSrI50e1RpkjArOhB+WNkxEdz/6kFZjx9X2kpUQRYzApWuV5F1OgxCNB/An1K0kYfKc26gw7kVQ+v6QIsgtdlEnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297535; c=relaxed/simple;
	bh=kBUsdBRGibggPisS6UgH+qECKvgWl3qwx3c5ZrsthAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7cjrlUYqn6WoU7/ayv/hko/KCo7O2KgbwfFkVgBuUlz823keMJKzLsRSG26/AUuXbIlkjUe9tafAVnxG7D86vr/VAHXYcuO5E/btwZndGIacC2+BYNnz6r2VnRKHSK+j/n9SH7UAX1Bc40pER3brIOyZvHf15/wpwH2tF5Ksts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3A0182F2023E; Fri, 26 Jan 2024 19:32:10 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 5C7532F20238;
	Fri, 26 Jan 2024 19:32:05 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: keescook@chromium.org,
	sfrench@samba.org,
	corbet@lwn.net,
	natechancellor@gmail.com,
	ndesaulniers@google.com,
	kovalev@altlinux.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/2] stddef: Introduce DECLARE_FLEX_ARRAY() helper
Date: Fri, 26 Jan 2024 22:31:42 +0300
Message-Id: <20240126193143.245122-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240126193143.245122-1-kovalev@altlinux.org>
References: <20240126193143.245122-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

commit 3080ea5553cc909b000d1f1d964a9041962f2c5b upstream.

There are many places where kernel code wants to have several different
typed trailing flexible arrays. This would normally be done with multiple
flexible arrays in a union, but since GCC and Clang don't (on the surface)
allow this, there have been many open-coded workarounds, usually involving
neighboring 0-element arrays at the end of a structure. For example,
instead of something like this:

struct thing {
	...
	union {
		struct type1 foo[];
		struct type2 bar[];
	};
};

code works around the compiler with:

struct thing {
	...
	struct type1 foo[0];
	struct type2 bar[];
};

Another case is when a flexible array is wanted as the single member
within a struct (which itself is usually in a union). For example, this
would be worked around as:

union many {
	...
	struct {
		struct type3 baz[0];
	};
};

These kinds of work-arounds cause problems with size checks against such
zero-element arrays (for example when building with -Warray-bounds and
-Wzero-length-bounds, and with the coming FORTIFY_SOURCE improvements),
so they must all be converted to "real" flexible arrays, avoiding warnings
like this:

fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
  209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
      |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from fs/hpfs/hpfs_fn.h:26,
                 from fs/hpfs/anode.c:10:
fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
  412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
      |                                ^~~~~~~~

drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
  360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
  231 |   u8 raw_msg[0];
      |      ^~~~~~~

However, it _is_ entirely possible to have one or more flexible arrays
in a struct or union: it just has to be in another struct. And since it
cannot be alone in a struct, such a struct must have at least 1 other
named member -- but that member can be zero sized. Wrap all this nonsense
into the new DECLARE_FLEX_ARRAY() in support of having flexible arrays
in unions (or alone in a struct).

As with struct_group(), since this is needed in UAPI headers as well,
implement the core there, with a non-UAPI wrapper.

Additionally update kernel-doc to understand its existence.

https://github.com/KSPP/linux/issues/137

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 include/linux/stddef.h      | 13 +++++++++++++
 include/uapi/linux/stddef.h | 16 ++++++++++++++++
 scripts/kernel-doc          |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 938216f8ab7e7c..31fdbb784c24e2 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -84,4 +84,17 @@ enum {
 #define struct_group_tagged(TAG, NAME, MEMBERS...) \
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
+/**
+ * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index c3725b49226323..7837ba4fe72890 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -28,4 +28,20 @@
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
 	}
+
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
 #endif
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 19af6dd160e6b7..7a04d4c0532607 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1232,7 +1232,8 @@ sub dump_struct($$) {
 	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
-
+	# replace DECLARE_FLEX_ARRAY
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
-- 
2.33.8


