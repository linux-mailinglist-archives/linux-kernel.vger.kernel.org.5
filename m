Return-Path: <linux-kernel+bounces-130093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF0897405
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E691C23B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574C14B073;
	Wed,  3 Apr 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUi0UOSE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1614A610
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158134; cv=none; b=th3NRjKbJBjTcoU6dvS6nnsK2yQXz120nHwcPT+sNhYDmjI575mTNYXN0aOiUGIHs9K0lfOhzDClkcn6waiGzj5AmGYMJZsOoyrZ1XGeEtH8nMYc9paSZ3txrVWo7QiwZ946Rd+yfRMr/7Lvzp79qIWq48xuwUTucSchhRuQuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158134; c=relaxed/simple;
	bh=A5ukh2+Z6U51aMWh/tYkaiLlibm3zpXx/Ey8HxhPlgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7HYj4nrhJTViFjmMssZgzjUcIiGi+znUTCdWfc1gF326fivUYP3Chd+zAqyGWphEKEbpVHQKhunsGE2wjbgTX6ReO/aE6BeCz4MnynMvKUwVOnZuHA00UZu1zTTEOgHy7nyfqweLe6BxcM79w44cn+wrp1oud6mqU9/okOPYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUi0UOSE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610c23abd1fso118191267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158131; x=1712762931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTl4cUJQN6C9/W2w+L747h7ZZyFRYDUY2SPGpa8Ikk=;
        b=VUi0UOSEuiX4xjB2QAC4vwoRZ/Sm/uuKCbSyD28H5uKgB6ZNpHvoPQ3TKmb6CfxjyE
         eeNzlVPvSiZwHjAtuymJwa80XPqA6EN8Yu1Hgcgr0ISfO7ePYgovRB9xLmI+QgdgLz7t
         6SvfC1aLSlofL1a3PGAzaLqRFzbd35fIAYdYLW9p2W0fWEyof194SwPWCVnYFrGBK5hV
         k1SPlfA4nf1P58TkePniv9H5uw/0fHPiPFtWto3s0lSt8TtNG8RokRRaIe7Jm6WFaN4v
         sHpEpRloXLppm5xHmQl53EJhVqGs4MZ6fl7m+OMh9NU34SKAhmOTgtb39XxSxRqQR0Rc
         qKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158131; x=1712762931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTl4cUJQN6C9/W2w+L747h7ZZyFRYDUY2SPGpa8Ikk=;
        b=OQ11PFK4foovfwX0zV58p+JBQjzVj1NXNVkF3Dj6STSYsSLgvWfslHKFtapGJR92KP
         gKS78+/k1I/TCHSgNiAXho2yge/3gfAlRYMyIqs6EkbRAC/y/SdakPwCUm2o+C44ECj5
         cqnmKYtOFQ2X+NfZPd1goJhb2BQiERiep4L9C2mDK3DW5fEan8T45FrV9nOgyFSxw8MA
         nQ5I/Jult9W6Xdy5V11UWCvf6phqX4daLHAOx1iZq47MHgXKCwFygaj2PZtA5KVHE+J8
         24pYz5WwToZNfd71PvBSZkeN2SGIxHPXv0NPstJ9gJsbgrCcGESGwGm7fjxeqjxG1WK7
         dWEA==
X-Forwarded-Encrypted: i=1; AJvYcCVozzJHlISTwqIL7aV11vaWq/Bw7bpxkM8natN4f8Utj0J6dJYZSvDoQmwM6uwPjqt4hnVTA4EiFqtNTeA8DImv7oyVLx4SF1HseQO5
X-Gm-Message-State: AOJu0YwAVFgWbAtM7CORfsGUmUiKzqie+iWvno6WdJjlRX5PjRMfbyYw
	cKhAqHsbNfYREDHBoK9rmYk4/WGRt6yAET6ot7oo6y6z2F8eFeX2buSXBhfKPbMMNoU5EEWEtOh
	AsmkfIII6OtaQwnEZG1qwSQ==
X-Google-Smtp-Source: AGHT+IHfo3ddyozuc0W0+di2k7ZccaYseC/onrdI7PFh4x6XJehwveb6aZqNnjGJakNkSAoy8PGWCFCDNgvwcVRraA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:b8b:b0:614:ff0d:2c7b with
 SMTP id ck11-20020a05690c0b8b00b00614ff0d2c7bmr1620431ywb.10.1712158131601;
 Wed, 03 Apr 2024 08:28:51 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:41 -0700
In-Reply-To: <20240403152844.4061814-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-3-almasrymina@google.com>
Subject: [PATCH net-next v4 2/3] net: mirror skb frag ref/unref helpers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor some of the skb frag ref/unref helpers for improved clarity.

Implement napi_pp_get_page() to be the mirror counterpart of
napi_pp_put_page().

Implement skb_page_ref() to be the mirror of skb_page_unref().

Improve __skb_frag_ref() to become a mirror counterpart of
__skb_frag_unref(). Previously unref could handle pp & non-pp pages,
while the ref could only handle non-pp pages. Now both the ref & unref
helpers can correctly handle both pp & non-pp pages.

Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
remove pp specific handling from skb_try_coalesce.

Additionally, since __skb_frag_ref() can now handle both pp & non-pp
pages, a latent issue in skb_shift() should now be fixed. Previously
this function would do a non-pp ref & pp unref on potential pp frags
(fragfrom). After this patch, skb_shift() should correctly do a pp
ref/unref on pp frags.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---

v4:
- pass skb->pp_recycle instead of 'false' in __skb_frag_ref in
  chcr_ktls.c & cassini.c.
- Add some details on the changes to skb_shift() in this commit in the
  commit message.

v3:
- Fix build errors reported by patchwork.
- Fix drivers/net/veth.c & tls_device_fallback.c callsite I missed to update.
- Fix page_pool_ref_page(head_page) -> page_pool_ref_page(page)

---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 22 ++++++--
 net/core/skbuff.c                             | 53 ++++++-------------
 net/tls/tls_device_fallback.c                 |  2 +-
 6 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 6482728794dd..d7e8deafddf1 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1658,7 +1658,7 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	for (i = 0; i < record->num_frags; i++) {
 		skb_shinfo(nskb)->frags[i] = record->frags[i];
 		/* increase the frag ref count */
-		__skb_frag_ref(&skb_shinfo(nskb)->frags[i]);
+		__skb_frag_ref(&skb_shinfo(nskb)->frags[i], nskb->pp_recycle);
 	}
 
 	skb_shinfo(nskb)->nr_frags = record->num_frags;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index bfb903506367..31878256feee 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1999,7 +1999,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 		skb->len      += hlen - swivel;
 
 		skb_frag_fill_page_desc(frag, page->buffer, off, hlen - swivel);
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, skb->pp_recycle);
 
 		/* any more data? */
 		if ((words[0] & RX_COMP1_SPLIT_PKT) && ((dlen -= hlen) > 0)) {
@@ -2023,7 +2023,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 			frag++;
 
 			skb_frag_fill_page_desc(frag, page->buffer, 0, hlen);
-			__skb_frag_ref(frag);
+			__skb_frag_ref(frag, skb->pp_recycle);
 			RX_USED_ADD(page, hlen + cp->crc_size);
 		}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index bcdfbf61eb66..6160a3e8d341 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -716,7 +716,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;
 
 	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
+		__skb_frag_ref(&sinfo->frags[i], false);
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7dcbd27e1497..71caeee061ca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3483,15 +3483,29 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 	return netmem_to_page(frag->netmem);
 }
 
+bool napi_pp_get_page(struct page *page);
+
+static inline void skb_page_ref(struct page *page, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: skb->pp_recycle param of the parent skb. False if no parent skb.
  *
- * Takes an additional reference on the paged fragment @frag.
+ * Takes an additional reference on the paged fragment @frag. Obtains the
+ * correct reference count depending on whether skb->pp_recycle is set and
+ * whether the frag is a page pool frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag)
+static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
 {
-	get_page(skb_frag_page(frag));
+	skb_page_ref(skb_frag_page(frag), recycle);
 }
 
 /**
@@ -3503,7 +3517,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb..ff7e450ec5ea 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1004,6 +1004,18 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
+bool napi_pp_get_page(struct page *page)
+{
+	page = compound_head(page);
+
+	if (!is_pp_page(page))
+		return false;
+
+	page_pool_ref_page(page);
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_get_page);
+
 bool napi_pp_put_page(struct page *page)
 {
 	page = compound_head(page);
@@ -1032,37 +1044,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(virt_to_page(data));
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	struct page *head_page;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
-		else
-			page_ref_inc(head_page);
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -4169,7 +4150,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4819,7 +4800,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5950,10 +5931,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			__skb_frag_ref(&from_shinfo->frags[i]);
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
 
 	to->truesize += delta;
 	to->len += len;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 4e7228f275fa..d4000b4a1f7d 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -277,7 +277,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];
 
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, false);
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));
 
-- 
2.44.0.478.gd926399ef9-goog


