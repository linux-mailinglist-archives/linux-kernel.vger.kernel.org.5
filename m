Return-Path: <linux-kernel+bounces-122051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7ED88F138
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C231C303F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A322154BE8;
	Wed, 27 Mar 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XVbZsSD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC95154422
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575937; cv=none; b=RITx24B/wMZbbj4f70upXXU59Ho6tprlqFqce1W2cOdAiBsdYqFuzF5K55w4TtuF5ExBG3W3xoxaPLjiXsrTzMLENZQ7Owlh9pEtndJn2FaddmaOemNkClQlw8o9rcv9DlCmY7aT8VezYmYCDjMqgezZLPggMk/sVVViMmhdLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575937; c=relaxed/simple;
	bh=HcoNxlvdGhGfyulBOvat+dNXCCSpR7y/F/Sfr6c14to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0x9RHAgbKKx2ri9RurPGf+fSo7yhoRWtiDmjDEyNjb+Rh4ApqFb2aSFRAeoBFNqMB9xZF554KjbbhA8SuVAXiBLepaxmxNyEPIktbqSn1/CUznMPjBA+t4D0nHct4e09yj9VAvdVkABduPJMoMKHXslcJS8GREWMmigMmehaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XVbZsSD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso424457276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575934; x=1712180734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fas+uh+IATqHO1ThFI61gBVEvoGJvlSG5a3mDRu0bA=;
        b=0XVbZsSD/EY7uJzjdM0oltuqcR63ul7SIEC7onTbbcgVIuCwdq7GDDDQ21AtBfeUyk
         cs+Scu5GqJ9NAPd+HY9k+8msD7NSzwA/g4+SXQHpMVBvJffadO//HDSWSOF3KhUq/C/u
         Lx59/TdBmkST50ZNDmySR5a9G2XbLBCphPNthvBVtR/WxmI8U64PfV6tCfJgCONDzJMq
         jAcziPMivArgkZzgNSar4Tmw5bjbfc4SMsc5H1IFhs1gsMfYwSVWlGpTGb/5Q+zJbRgF
         TbXUJ7yzYW5XfMXtWdAo36YpcuWpTanmWI8uB5e9eMPcWweRHgs+Sd3xGZqnadJs+8yk
         P9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575934; x=1712180734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fas+uh+IATqHO1ThFI61gBVEvoGJvlSG5a3mDRu0bA=;
        b=vekJlgiUJ0pUDFnqahlOSCUp28ZJQEyTbrQQT+iOERG+frYvPcpqBmcidLABcfpopc
         TwMnWtuBp0EAfPCl8KRrXl8B7B6LEqXQo8jcP5sNXkXkRkHxx4gUXmmQlhPUYxbYPUoK
         wXo9fF83RgP639Dio1yO56LrQuRIm/DyT57zTRCpkAg1tnJECY0w9fxMmmpG+0Za4JUw
         +CW9VE9adQhPONrfOJqp+wtc+4OBeOD0ZZHLgo8aa1onQlrBMTJBWx50fKwGwZdvij4w
         9U85bfEZAVWwZPvUZt/w715Hd085+JNVij01r6lFZbJwd+LZE/vRNsAFJ4Cx1uOAKa0P
         3igA==
X-Forwarded-Encrypted: i=1; AJvYcCXhmb6PJd7cHHcjxCm5FsEHNki0Cl7P3ahbQ9lv61yQsWnN07DkBe3SXZuaOfI7Xhi/WezGAaCCVFXLEQaNSLy816KysnVuklmbEQ6A
X-Gm-Message-State: AOJu0YztVxK8rPyDE0cDY4siheghe5seRFo33/Puyil1Kkv6Qgk3T/AC
	ikGSBeCIhCfwsF9Z1FyMLDkEQRMRY/f6FcQBLBgAyX1ZnZv26y/DuSQJOF4i7dm+hOj9PrsSAgE
	kvmNTzDkyoBmU/kaBXo46hw==
X-Google-Smtp-Source: AGHT+IEbxk1R4CRvllhl4uFMMmoABCiOd+KYKwhp/rGbIhNQO57O71um9bj7xu9u0AunMaECDk0/6mpFbNSCoQSHdw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2413:b0:dc6:dfd9:d423 with
 SMTP id dr19-20020a056902241300b00dc6dfd9d423mr119003ybb.3.1711575933748;
 Wed, 27 Mar 2024 14:45:33 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:21 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/3] net: remove napi_frag_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

With the changes in the last patches, napi_frag_unref() is now
reduandant. Remove it and use skb_page_unref directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 14 +++++---------
 net/core/skbuff.c                          |  4 ++--
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 07720841a8d7..8e00a5856856 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
 
 		if (length == 0) {
 			/* don't need this page */
-			__skb_frag_unref(frag, false);
+			__skb_frag_unref(frag, false, false);
 			--skb_shinfo(skb)->nr_frags;
 		} else {
 			size = min(length, (unsigned) PAGE_SIZE);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index eac49657bd07..4dbf29b46979 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -526,7 +526,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 fail:
 	while (nr > 0) {
 		nr--;
-		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
+		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false, false);
 	}
 	return 0;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 058d72a2a250..c3edb4a3450a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3547,23 +3547,19 @@ skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 	put_page(page);
 }
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
-{
-	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
-}
-
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
  * @recycle: recycle the page if allocated via page_pool
+ * @napi_safe: set to true if running in the same napi context as where the
+ * consumer would run.
  *
  * Releases a reference on the paged fragment @frag
  * or recycles the page via the page_pool API.
  */
-static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
+static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	napi_frag_unref(frag, recycle, false);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
@@ -3578,7 +3574,7 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	if (!skb_zcopy_managed(skb))
-		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle, false);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c86ecaceb6c..a6dbba56e047 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1109,7 +1109,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
 
 free_head:
 	if (shinfo->frag_list)
@@ -4200,7 +4200,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		fragto = &skb_shinfo(tgt)->frags[merge];
 
 		skb_frag_size_add(fragto, skb_frag_size(fragfrom));
-		__skb_frag_unref(fragfrom, skb->pp_recycle);
+		__skb_frag_unref(fragfrom, skb->pp_recycle, false);
 	}
 
 	/* Reposition in the original skb */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..5dc6381f34fb 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -140,7 +140,7 @@ static void destroy_record(struct tls_record_info *record)
 	int i;
 
 	for (i = 0; i < record->num_frags; i++)
-		__skb_frag_unref(&record->frags[i], false);
+		__skb_frag_unref(&record->frags[i], false, false);
 	kfree(record);
 }
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..85b41f226978 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -196,7 +196,7 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
 	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		__skb_frag_unref(&shinfo->frags[i], false);
+		__skb_frag_unref(&shinfo->frags[i], false, false);
 	shinfo->nr_frags = 0;
 	if (strp->copy_mode) {
 		kfree_skb_list(shinfo->frag_list);
-- 
2.44.0.396.g6e790dbe36-goog


