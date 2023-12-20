Return-Path: <linux-kernel+bounces-6504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A48199B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB83B250D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05720B19;
	Wed, 20 Dec 2023 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5xI8sLy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0D208D6;
	Wed, 20 Dec 2023 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD808C433C8;
	Wed, 20 Dec 2023 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703057941;
	bh=ZB1Fpehfxz1OYRnlaoOsVM8LmfGkRvS/BbeYZcRWryA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5xI8sLyoEomG1i907Zb/EZTQKW2N10h2n7VfSK283UUP4iEWXnzXDe/5fF0RdAnm
	 +yYeAk3x4ARMHbhtjBq2bklKs/lerpAhOAJ35LI77OkC3JkWtdhEBGvz72w64MDS8Y
	 YaS/8hfMJamOWAOd4nlEtulA1Ms1I3EpZy4O/jr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 3/3] HID: bpf: make bus_type const in struct hid_bpf_ops
Date: Wed, 20 Dec 2023 08:38:48 +0100
Message-ID: <2023122048-dormitory-headboard-e248@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122045-pellet-eggbeater-8d2f@gregkh>
References: <2023122045-pellet-eggbeater-8d2f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ZB1Fpehfxz1OYRnlaoOsVM8LmfGkRvS/BbeYZcRWryA=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlNszj7DiSeDZdW1jI+pHBLNLKFkf9+w6+t958JM1p3R cRmK3zqiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgInYrGRYMPXCammvJfOO/23s SpjFdFBLa/+6MIYFm5+UXH+45pB7Q5t1newpycf3C3XjAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The struct bus_type pointer in hid_bpf_ops just passes the pointer to
the driver core, and the driver core can handle, and expects, a constant
pointer, so also make the pointer constant in hid_bpf_ops.

Part of the process of moving all usages of struct bus_type to be
constant to move them all to read-only memory.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hid_bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index e9afb61e6ee0..840cd254172d 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -115,7 +115,7 @@ struct hid_bpf_ops {
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype);
 	struct module *owner;
-	struct bus_type *bus_type;
+	const struct bus_type *bus_type;
 };
 
 extern struct hid_bpf_ops *hid_bpf_ops;
-- 
2.43.0


