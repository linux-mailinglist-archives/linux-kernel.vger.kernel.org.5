Return-Path: <linux-kernel+bounces-61640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AA8514D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B981C22D10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4154654B;
	Mon, 12 Feb 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERFJ23DD"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144F4597C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743669; cv=none; b=RCk0hHd65ED+/dVce/eR2O9NUa9dmy/khXNYpJwACYSNFB0hUcP/Pk0JWLdG6P0510OM6TMsD593rhUad5YyS6w98ALRNTnRYetIGvGAGiRskgaZ9f2qAQCyD5xrk0OrW/w2wfKAZcEnq4drdVppwRO2ZkR8c+wLiLQmMRP9gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743669; c=relaxed/simple;
	bh=a9pxujH5PHZG0UGOA2G3s/Ee5bI2Qul5wfUj2II7oQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3mI7Qc1A/rMDYvRFoHiJCb3vdlp68t3rTQvVWlvnZsM+6cMQ6H3rMlvXTieVNyXw4fZBee+EDOJZ9v1xcB8n8aqJ/+HhHrts8L3EmMW03B6c8CNtArGzgFndEUGQBQQ+A2YiVn648oUr7p1DlCJJxRmacIiTJFFHWHhqw+eceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERFJ23DD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4864416276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743666; x=1708348466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xYmC6/7GB0cnLvoqQ6/O63HTLhsqtwrPQr/DNWfuhA=;
        b=ERFJ23DD8hfWbfKTs8r5GBhmKa25ypfb55bv5P1euHXG+2Pp4e08H9H73JhmYQtd+5
         CFsRLKXdrMuKi/TUmDYHnWo9gc/vY4aUUyHbQ0akJ3s2ZFimMTIc9w/oadkhcu+0yBIw
         ZD2R2KXu1aORsSc6TkKFWjeQ2W1ggaebYSAjbbH6yOPKyPdW5ndYHxxywA3xHi6gDMD6
         sKCqiAY8I9gW9Nzbya+kUIYRsoxaj+dbW9uGp00OrHxPYL1FGELVQsTiF5HnvYTBiWd7
         eRbqYrZaSzOmETJCUosGLOdKy0eq3SLeM8XGll0yPCoLCvF/AZJHhXW6zJzi8jLT+Jjh
         rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743666; x=1708348466;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xYmC6/7GB0cnLvoqQ6/O63HTLhsqtwrPQr/DNWfuhA=;
        b=ammA61rrvDDh+ndJ+9/iJfsJHkffAEfzy2AoY66sVSsfoPnEvTT4iDt5B48CTFgzNH
         pLs7RfT3WZdfLCeDpU11sNzSd6fA78xcNrT4DBIOfto/lLmRXOoNBrdswApCkJn3Uwfw
         am83CNA1Igu6va7wQza4H4eDnEgGEScqQb/uMKmC9xVNj/MfAWbSxYcTRWhaTayWtl8P
         UqE4yXt8ilx4Asscukn3U4BGtJ1fpEJ4Yqc3ZctxzJLjDtqhytIWDLZW/u9NsSqBJULK
         c7WqwOOXu7UXya8fsmwtA4+bDcy6nXxL1lxGfQ2ZSkRF9fHkH3rJ5+fdf0BVGuVjuUWq
         Z0vg==
X-Forwarded-Encrypted: i=1; AJvYcCUtUOBukieYZ+GstgXHNwT9/DqQQI5kGJu4vKPaprK/Pjms74AiXgCb4PYpute1gbYyaerVeOm0sm+MxBF3vbHr24Y30nH0nwDwHqf9
X-Gm-Message-State: AOJu0YyeK8Fawc90T54rPpD3LLXiKNL1hLrLoHkz9/9eku5P7HH/nSjM
	9FgEEkmxA0l7mmGTDjMkm7tMex/+rhqLQZVwiP9YlW/oE2d/Y+s+QkUnag76/mGpQoC0E4hOBGq
	jErI6e13buw==
X-Google-Smtp-Source: AGHT+IGr/8RYkrogU8h5JqNlm8G2W8mO4LpimxJKVyG5rXvwK9zlBMJNVG0OW3CPbZyD6F94Yb4Gk8OO+lh9AA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:102c:b0:dc7:49a9:6666 with SMTP
 id x12-20020a056902102c00b00dc749a96666mr1825457ybt.3.1707743666187; Mon, 12
 Feb 2024 05:14:26 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:18 +0000
In-Reply-To: <20240212131323.2162161-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-5-panikiel@google.com>
Subject: [PATCH 4/9] lib: Move DisplayPort CRC functions to common lib
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The CRC functions found in drivers/gpu/drm/display/drm_dp_mst_topology.c
may be useful for other non-DRM code that deals with DisplayPort, e.g.
v4l2 drivers for DP receivers. Move these functions to /lib.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/gpu/drm/display/Kconfig               |  1 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 76 ++----------------
 include/linux/crc-dp.h                        | 10 +++
 lib/Kconfig                                   |  8 ++
 lib/Makefile                                  |  1 +
 lib/crc-dp.c                                  | 78 +++++++++++++++++++
 6 files changed, 103 insertions(+), 71 deletions(-)
 create mode 100644 include/linux/crc-dp.h
 create mode 100644 lib/crc-dp.c

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kcon=
fig
index 09712b88a5b8..c615f50152f2 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -14,6 +14,7 @@ config DRM_DISPLAY_HELPER
 config DRM_DISPLAY_DP_HELPER
 	bool
 	depends on DRM_DISPLAY_HELPER
+	select CRC_DP
 	help
 	  DRM display helpers for DisplayPort.
=20
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/dr=
m/display/drm_dp_mst_topology.c
index f7c6b60629c2..ada1f90fa808 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -22,6 +22,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/crc-dp.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -195,73 +196,6 @@ drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *o=
ut, size_t len)
 }
=20
 /* sideband msg handling */
-static u8 drm_dp_msg_header_crc4(const uint8_t *data, size_t num_nibbles)
-{
-	u8 bitmask =3D 0x80;
-	u8 bitshift =3D 7;
-	u8 array_index =3D 0;
-	int number_of_bits =3D num_nibbles * 4;
-	u8 remainder =3D 0;
-
-	while (number_of_bits !=3D 0) {
-		number_of_bits--;
-		remainder <<=3D 1;
-		remainder |=3D (data[array_index] & bitmask) >> bitshift;
-		bitmask >>=3D 1;
-		bitshift--;
-		if (bitmask =3D=3D 0) {
-			bitmask =3D 0x80;
-			bitshift =3D 7;
-			array_index++;
-		}
-		if ((remainder & 0x10) =3D=3D 0x10)
-			remainder ^=3D 0x13;
-	}
-
-	number_of_bits =3D 4;
-	while (number_of_bits !=3D 0) {
-		number_of_bits--;
-		remainder <<=3D 1;
-		if ((remainder & 0x10) !=3D 0)
-			remainder ^=3D 0x13;
-	}
-
-	return remainder;
-}
-
-static u8 drm_dp_msg_data_crc4(const uint8_t *data, u8 number_of_bytes)
-{
-	u8 bitmask =3D 0x80;
-	u8 bitshift =3D 7;
-	u8 array_index =3D 0;
-	int number_of_bits =3D number_of_bytes * 8;
-	u16 remainder =3D 0;
-
-	while (number_of_bits !=3D 0) {
-		number_of_bits--;
-		remainder <<=3D 1;
-		remainder |=3D (data[array_index] & bitmask) >> bitshift;
-		bitmask >>=3D 1;
-		bitshift--;
-		if (bitmask =3D=3D 0) {
-			bitmask =3D 0x80;
-			bitshift =3D 7;
-			array_index++;
-		}
-		if ((remainder & 0x100) =3D=3D 0x100)
-			remainder ^=3D 0xd5;
-	}
-
-	number_of_bits =3D 8;
-	while (number_of_bits !=3D 0) {
-		number_of_bits--;
-		remainder <<=3D 1;
-		if ((remainder & 0x100) !=3D 0)
-			remainder ^=3D 0xd5;
-	}
-
-	return remainder & 0xff;
-}
 static inline u8 drm_dp_calc_sb_hdr_size(struct drm_dp_sideband_msg_hdr *h=
dr)
 {
 	u8 size =3D 3;
@@ -284,7 +218,7 @@ static void drm_dp_encode_sideband_msg_hdr(struct drm_d=
p_sideband_msg_hdr *hdr,
 		(hdr->msg_len & 0x3f);
 	buf[idx++] =3D (hdr->somt << 7) | (hdr->eomt << 6) | (hdr->seqno << 4);
=20
-	crc4 =3D drm_dp_msg_header_crc4(buf, (idx * 2) - 1);
+	crc4 =3D crc_dp_msg_header(buf, (idx * 2) - 1);
 	buf[idx - 1] |=3D (crc4 & 0xf);
=20
 	*len =3D idx;
@@ -305,7 +239,7 @@ static bool drm_dp_decode_sideband_msg_hdr(const struct=
 drm_dp_mst_topology_mgr
 	len +=3D ((buf[0] & 0xf0) >> 4) / 2;
 	if (len > buflen)
 		return false;
-	crc4 =3D drm_dp_msg_header_crc4(buf, (len * 2) - 1);
+	crc4 =3D crc_dp_msg_header(buf, (len * 2) - 1);
=20
 	if ((crc4 & 0xf) !=3D (buf[len - 1] & 0xf)) {
 		drm_dbg_kms(mgr->dev, "crc4 mismatch 0x%x 0x%x\n", crc4, buf[len - 1]);
@@ -725,7 +659,7 @@ static void drm_dp_crc_sideband_chunk_req(u8 *msg, u8 l=
en)
 {
 	u8 crc4;
=20
-	crc4 =3D drm_dp_msg_data_crc4(msg, len);
+	crc4 =3D crc_dp_msg_data(msg, len);
 	msg[len] =3D crc4;
 }
=20
@@ -782,7 +716,7 @@ static bool drm_dp_sideband_append_payload(struct drm_d=
p_sideband_msg_rx *msg,
=20
 	if (msg->curchunk_idx >=3D msg->curchunk_len) {
 		/* do CRC */
-		crc4 =3D drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len - 1);
+		crc4 =3D crc_dp_msg_data(msg->chunk, msg->curchunk_len - 1);
 		if (crc4 !=3D msg->chunk[msg->curchunk_len - 1])
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
diff --git a/include/linux/crc-dp.h b/include/linux/crc-dp.h
new file mode 100644
index 000000000000..b63435c82b96
--- /dev/null
+++ b/include/linux/crc-dp.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CRC_DP_H
+#define _LINUX_CRC_DP_H
+
+#include <linux/types.h>
+
+u8 crc_dp_msg_header(const uint8_t *data, size_t num_nibbles);
+u8 crc_dp_msg_data(const uint8_t *data, u8 number_of_bytes);
+
+#endif /* _LINUX_CRC_DP_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 5ddda7c2ed9b..28f9f6cfec9f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -171,6 +171,14 @@ config CRC_ITU_T
 	  the kernel tree does. Such modules that use library CRC ITU-T V.41
 	  functions require M here.
=20
+config CRC_DP
+	tristate "CRC DisplayPort MST functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC DisplayPort MST functions, but a module built outsi=
de
+	  the kernel tree does. Such modules that use library CRC DisplayPort MST
+	  functions require M here.
+
 config CRC32
 	tristate "CRC32/CRC32c functions"
 	default y
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..e4d7ffa260b3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -188,6 +188,7 @@ obj-$(CONFIG_CRC7)	+=3D crc7.o
 obj-$(CONFIG_LIBCRC32C)	+=3D libcrc32c.o
 obj-$(CONFIG_CRC8)	+=3D crc8.o
 obj-$(CONFIG_CRC64_ROCKSOFT) +=3D crc64-rocksoft.o
+obj-$(CONFIG_CRC_DP)	+=3D crc-dp.o
 obj-$(CONFIG_XXHASH)	+=3D xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) +=3D genalloc.o
=20
diff --git a/lib/crc-dp.c b/lib/crc-dp.c
new file mode 100644
index 000000000000..95b58bc436d4
--- /dev/null
+++ b/lib/crc-dp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/crc-dp.h>
+
+/*
+ * Sideband MSG Header CRC
+ * Defined in DisplayPort 1.2 spec, section 2.11.3.1.9
+ */
+u8 crc_dp_msg_header(const uint8_t *data, size_t num_nibbles)
+{
+	u8 bitmask =3D 0x80;
+	u8 bitshift =3D 7;
+	u8 array_index =3D 0;
+	int number_of_bits =3D num_nibbles * 4;
+	u8 remainder =3D 0;
+
+	while (number_of_bits !=3D 0) {
+		number_of_bits--;
+		remainder <<=3D 1;
+		remainder |=3D (data[array_index] & bitmask) >> bitshift;
+		bitmask >>=3D 1;
+		bitshift--;
+		if (bitmask =3D=3D 0) {
+			bitmask =3D 0x80;
+			bitshift =3D 7;
+			array_index++;
+		}
+		if ((remainder & 0x10) =3D=3D 0x10)
+			remainder ^=3D 0x13;
+	}
+
+	number_of_bits =3D 4;
+	while (number_of_bits !=3D 0) {
+		number_of_bits--;
+		remainder <<=3D 1;
+		if ((remainder & 0x10) !=3D 0)
+			remainder ^=3D 0x13;
+	}
+
+	return remainder;
+}
+
+/*
+ * Sideband MSG Data CRC
+ * Defined in DisplayPort 1.2 spec, section 2.11.3.2.2
+ */
+u8 crc_dp_msg_data(const uint8_t *data, u8 number_of_bytes)
+{
+	u8 bitmask =3D 0x80;
+	u8 bitshift =3D 7;
+	u8 array_index =3D 0;
+	int number_of_bits =3D number_of_bytes * 8;
+	u16 remainder =3D 0;
+
+	while (number_of_bits !=3D 0) {
+		number_of_bits--;
+		remainder <<=3D 1;
+		remainder |=3D (data[array_index] & bitmask) >> bitshift;
+		bitmask >>=3D 1;
+		bitshift--;
+		if (bitmask =3D=3D 0) {
+			bitmask =3D 0x80;
+			bitshift =3D 7;
+			array_index++;
+		}
+		if ((remainder & 0x100) =3D=3D 0x100)
+			remainder ^=3D 0xd5;
+	}
+
+	number_of_bits =3D 8;
+	while (number_of_bits !=3D 0) {
+		number_of_bits--;
+		remainder <<=3D 1;
+		if ((remainder & 0x100) !=3D 0)
+			remainder ^=3D 0xd5;
+	}
+
+	return remainder & 0xff;
+}
--=20
2.43.0.687.g38aa6559b0-goog


