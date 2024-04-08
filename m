Return-Path: <linux-kernel+bounces-135604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285B689C849
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D825428594B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A921422B4;
	Mon,  8 Apr 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fflNLI5C"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F231420C6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590212; cv=none; b=Y0MZHKjRL554Finp7cgAHQ1bsQl1X/6UTTuyIqJKxWHWFLIUsYIXJqIerM+HkpB1g+BUe5ETm2sFJC7fS+3lQrykUU4WMuIbDRJn6reftzfL1v3C8dTolDRTH8mAc3leUxVCAF2n+ZoPEJKkjmrj3chUtTTWocw5MiVoZVA6Dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590212; c=relaxed/simple;
	bh=NDYzyHSUEz+bbz7ZtE+Jug/pzyRM5rfU190IW5ZReg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pNiQs0kpE21tw9y7DXU7AG8iZZAJKD7jsgCwBnFD86ghiG4sXvI3KQEbkm5okEMbFAvm+zlay20wd4TabJhBmwXZzBZL44sbrHpg+9EwtIhQ3esHWUo7kgiKIVawT5mFO4XngCn5gQ/oYqXfZATdDkM8vtrJ9BJE74uka1y0aO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fflNLI5C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so5224590276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712590209; x=1713195009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm7z+KL73iPrkFgDvs1nsRXYHlgtAjFxvC1NZB/hNSc=;
        b=fflNLI5CgIlqo6YvU8JEfwzK6EwJNZEfZO0XkdcTGKoxDeRWEXyDbZwMSDxHxiEp6D
         Zalx0Zmx6iFCB07qxft0FHfiglTtKN/MyBVFCLqdBu6/YYDXA/+ObNEzfYp9dybWodyz
         tWxeDEZu9wGH1sAxw0C+DJlUulBnngiQS3ibH5v7vRrEiwz1iHehVilTHh9JsH5jbKv8
         W19NDcuULqCjhXRr7R364Lb1gcYfBx8y4tgB3qDZMg4j2fWjIUe/4gS3WfJNU8fw8zTI
         5shsoFsCbjMHQ5cYtZZdRur7UBVzB/VkUTI5bUdAxXwguha+RGhelHD43BTCe5n7BSex
         j0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590209; x=1713195009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm7z+KL73iPrkFgDvs1nsRXYHlgtAjFxvC1NZB/hNSc=;
        b=dnzLYiZ/7gTm9fZkc1NNdUiUH4t+AOCxas1+Q3hM4sHuJEl4tjERNgLIO5YsRI0a1r
         o4x+NRCuhJakmObKXp0b17QC8vz7E+qSmpYBEv3R6n1XiKyl69WbZWgLMrEuDUAdFPqg
         gVkgi/xPVaG80pOIucl80aVCnmaZW6ocjW0FVW9QQEDGdXRB1djYgE7PIhHx2HMYWtUt
         /rKJ+FuHO9quxPgvIGEj+TbPyU3Bv+l3XInPKtKdFcx93TLIH7pAWHz3K0QD3RuKGW0s
         Dq6Crzwzr5650E9VH42e+K11iNZL/l20jcCNx0hLKsfLk7WzhRAZBORmjFXHHgSBJJC6
         0omw==
X-Forwarded-Encrypted: i=1; AJvYcCXY6HUSWwbIy9dc3DYv5FDsR+DR1lrWUtLmuYQprQwZoCXwJQXKbZ6PqzcQE5A5h7tGde58dPahOaY4HBdyfQiN2yN/lcYTpCsAwgyJ
X-Gm-Message-State: AOJu0Ywzu21yY3FGhFEigGlpqaeSNZ4Rsju6Gv8tCqxkb34dgoCvYPOx
	WCsCQJiPPaIHMDzx1PvwrytNzPWKtJezdDyNCgaKxHUcypjMdcJt5jMUMbgqNdoDTN8iTnSUD/B
	7Bs0P35SDXmV6JtmvoDShag==
X-Google-Smtp-Source: AGHT+IHEL0+TarXvLMGMrfBR4gZxn2J1EmL7QHPTCXuCCsv9uL1aBkHapD0+r2rKvIYCP/4rgQxRmAFLB1Eep03fqg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:ca23:d62d:de32:7c93])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:18c8:b0:dcd:59a5:7545 with
 SMTP id ck8-20020a05690218c800b00dcd59a57545mr683253ybb.10.1712590209659;
 Mon, 08 Apr 2024 08:30:09 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:29:58 -0700
In-Reply-To: <20240408153000.2152844-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408153000.2152844-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408153000.2152844-4-almasrymina@google.com>
Subject: [PATCH net-next v5 3/3] net: remove napi_frag_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

With the changes in the last patches, napi_frag_unref() is now
reduandant. Remove it and use skb_page_unref directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
 include/linux/skbuff.h | 8 +-------
 net/core/skbuff.c      | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2e6a77c398e6..182371f4834d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3567,12 +3567,6 @@ skb_page_unref(struct page *page, bool recycle)
 	put_page(page);
 }
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle)
-{
-	skb_page_unref(skb_frag_page(frag), recycle);
-}
-
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
@@ -3583,7 +3577,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle)
  */
 static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	napi_frag_unref(frag, recycle);
+	skb_page_unref(skb_frag_page(frag), recycle);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 928c615b0fd8..38c20b44cb14 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1065,7 +1065,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason)
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle);
 
 free_head:
 	if (shinfo->frag_list)
-- 
2.44.0.478.gd926399ef9-goog


