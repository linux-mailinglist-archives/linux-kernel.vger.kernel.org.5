Return-Path: <linux-kernel+bounces-157747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2D8B1546
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6DD1F21EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C9C16D9B3;
	Wed, 24 Apr 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTE5uaKS"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8711581F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994873; cv=none; b=TcBnVD5005N3HGx8U3lIrn4tEUHjeWiHCNs/Sh1HfHK9jQ8/BaX61ZZkgsB0T0d21JO5RsgI4jK9khm+CyzZX4vznCsw7EtEUduXbwt2JLeJ/PPxJY5fpK4G/7tyUmtmfeMs8NmBhGMrghJ1IjHcBGoMV3Nja0dAjxmgiNntEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994873; c=relaxed/simple;
	bh=KdH6ME94d/1vtX6KQzOA990YXFPl16sDmJgA9NILnME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWCOvnhGf0sxdTNl6SiI4rTAUOR/a7B3lkepXnSSgZWT694nCRnvGjKtflUY19jBENgjepgij4NnhNl6kXfPKLygO3pO/tvm8S/dhyTw1mB0aoMNrSXDOGN9JBaWZIPcLPgUorRVYPfT9/lD6EGwhwcfTFDm1HurJO+N2zF9RX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eTE5uaKS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c74a75d9adso293177b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994871; x=1714599671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dfA8VHRufYC0/a/WgaXWD6BvTAtlULzh1yIW0W2iCw=;
        b=eTE5uaKS8LT5j5pIRKvyfttIciUVapurJU4czi1dKOIZHXySSmzs9ZJXjdp8Z6x31f
         SJg+rwrlPtc4VZc2Y2YFfr02cq9sSgz+BNHD0o/sh8AsRn/xGBQPIJT/gcxJA7hL2Da3
         WRS8iBDuSs1i23ahPpr50g/cSOg9QoNzz04lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994871; x=1714599671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dfA8VHRufYC0/a/WgaXWD6BvTAtlULzh1yIW0W2iCw=;
        b=e0wDvQRsWn8U45F+w5T/MRsip6vFfyP/FDe8qChWV6MDpLz2hd0OVBHze/SoMSCcDU
         /PpxpqEH+XpdCY/OsVu1OApewf07W21PgtkeWdt1w3wnfpXiaebWL8zFv+ybtM/OrsFQ
         8lTqKEUVF7MP5lf9JGzDNZhzvz54sMIzqOltjXgiQPpfBZjKbbp26bDn6lzlhDgAQo+c
         LGmkH/XRSVtu6sAMIoz67VLm6PPOOXzpBTyWLquPqXjoVUAmZvaRuQAvHl3iYkcAKlxq
         btJLvlJjkZiA3tC78gv9W1G5xYevwpYbRui49xI15L3kxi39PGtZd9QGU2+9fKLCL9W3
         oCXw==
X-Forwarded-Encrypted: i=1; AJvYcCUTkb5ro3R3NSLSdVQw0kPdxLChAgTVpPPrZKOE33Nhc3PYeOs/2YP4AfigljUUnLbU1isNTv/hKCGy+emKpDeFZobAmbgvn4DLgYqK
X-Gm-Message-State: AOJu0YxClp/g1CH7aivT//nH4MkSJQgXdzeeNK+ZKcgqiVKIvFVOY9iP
	R2/i7dpcMdp7klcT5gjzVSuMSm3g1iSN/K5L0Uf/u6yPmZadunU+PIF5duOIig==
X-Google-Smtp-Source: AGHT+IGTuYDjFaVfAgXkNY0pfv1mQjL/tXjniKZW/5Pacc5OQoxVYohiXozhOD8xw9pwqeWMR48vVw==
X-Received: by 2002:aca:2201:0:b0:3c7:3b4b:a0c7 with SMTP id b1-20020aca2201000000b003c73b4ba0c7mr3979160oic.11.1713994870911;
        Wed, 24 Apr 2024 14:41:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a38-20020a631a26000000b005e4fa511505sm11445807pga.69.2024.04.24.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:41:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 5/6] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Wed, 24 Apr 2024 14:41:02 -0700
Message-Id: <20240424214104.3248214-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=keescook@chromium.org;
 h=from:subject; bh=KdH6ME94d/1vtX6KQzOA990YXFPl16sDmJgA9NILnME=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxufNt0iRDMEi0UPkW2GLKPPmjE/aN5Rd00e
 n0cfMEJ/H6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 JkdID/sHJNQORdFCM/cUq/ZcYZpyyvQIcnzDV0Z965jFp87JwowP6i4oI+FBo9uCykMh+11Rrlu
 NQNcUFmJmo6LQpfaqi0B05b1CRJ477vtFjlz2E7iovHNz3HYXXQS/vzGQ/VQH/Sv0F4EzoSOn1l
 UHfroyky4aryqJjcJX6ieL75C9QED2YiAGSVez2BD9J6JQGhA43blUULYTI434b7898CwOpbG46
 patNilg7fBIku4FUOr2K59si/Pzdtj99qzMLg3XRQMJYclitl++HUzWC7Dxg32YdMfqNiX2aQQq
 svnMXyh8tO9LQ+fNnIm3P+frmSHbfPjtC4CDynsNU6cCbfvmxn0HIY1Wk+nYHcEB63BSmjNca+z
 lCmwiBUp8svDj9Xh6LO9/AWzHR8ag+sXmENKUaWLGO3Z41XoSWwFir9WU5GzjDKKl9t82MfijIy
 QevedZy6odm1fVxYoObyDu0WndH3xDKEKIPaz6I0Fun46Z0Itu+gz8v/gwFw5nYTDhFyTfXqucx
 UX0IAG/fElAHOxq2HNfmsTXeBXIFhtGjqJpBtFTojR1EeuQ6rsOhrJZl+x1KJAMztGf7xR/2lRm
 ZQ4a+ovdgDGs998x2Xl084sou5A9U0NffnvW9SXI5UKYquH4wK1z+qtZghjKn8ArTIPCB0gBzx+ fIU7zdwHzbc6QFw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The msg subsystem is a common target for exploiting[1][2][3][4][5][6][7]
use-after-free type confusion flaws in the kernel for both read and
write primitives. Avoid having a user-controlled size cache share the
global kmalloc allocator by using a separate set of kmalloc buckets.

Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
Link: https://zplin.me/papers/ELOISE.pdf [6]
Link: https://syst3mfailure.io/wall-of-perdition/ [7]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
---
 ipc/msgutil.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..f392f30a057a 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -42,6 +42,17 @@ struct msg_msgseg {
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+static kmem_buckets *msg_buckets __ro_after_init;
+
+static int __init init_msg_buckets(void)
+{
+	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT,
+					  sizeof(struct msg_msg),
+					  DATALEN_MSG, NULL);
+
+	return 0;
+}
+subsys_initcall(init_msg_buckets);
 
 static struct msg_msg *alloc_msg(size_t len)
 {
@@ -50,7 +61,7 @@ static struct msg_msg *alloc_msg(size_t len)
 	size_t alen;
 
 	alen = min(len, DATALEN_MSG);
-	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
+	msg = kmem_buckets_alloc(msg_buckets, sizeof(*msg) + alen, GFP_KERNEL);
 	if (msg == NULL)
 		return NULL;
 
-- 
2.34.1


