Return-Path: <linux-kernel+bounces-135601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46489C843
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECA9284F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97B140E38;
	Mon,  8 Apr 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cm6BhEZN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70392140396
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590206; cv=none; b=YhFR8j/R8hWmAnDU+QVV/tu/TXu7BAQcbtgKqS3htR7TnkZUr4Qq7Jdr9dVnZI5j2n5gCppknPF5SY2yu/y09YJmjp96hixDngv7qbU6eRmMBGytW90Vq00ubCSDnz6Vc/8CWXA/C/ZR5utkiTr8IkrFSlsnqTqPdNLrOu1crxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590206; c=relaxed/simple;
	bh=6L0lKI5+1hOR7QHLw/0Q/vUSD9qNXRR1VfCBE+a/MS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YbcBFbiXvzJEq922GjYk1CZHPm2HnOiMLnGGz+7W2IHFa1OIV8o6UjLeYH6DJW89yjemX6W2xvTBAn2N+nsBZlMR1wSzj696mArTZjOZbne29AY5U+siq6aA9zAK3QZXDeSxdUicLVDM1d/1oxBK7tjp+c1LY0mQk5rjwvXlLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cm6BhEZN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so7689473276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712590203; x=1713195003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lRVgpIf9CTXoaaWbx3Q2b02belw9uoH1ZpMonmX2m4M=;
        b=Cm6BhEZNkP9eUEjT34QZExfVIX/cYnDIM6sqyD3hmRNk+LO3Reyo2gosUWi52y6U6e
         I7uJ6bTqGaXvH0Z5somRF2wJlL3w22+HaQigz7pGjzEYCIsSdjjd0Olz+Ee0osyhjBsO
         91dAY2drU8UWieH45PCvBSKhIWs3fwhMVY22Pt2X0t58tvzCj8ye8R90gxzh8H0lF5/p
         TrYLDUeZoS3RODorw+pNz2Q9jupJvn1owkv4ht4TFULyHsv9Cp2jGklGIhJYi1Rj8JTm
         80vm3WnE9VTbiKeIVLNuAZ/KfimPed3IhZ+eKONcGA1MrPaZlk+beiFoUPLbDehBxsz+
         ipgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590203; x=1713195003;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRVgpIf9CTXoaaWbx3Q2b02belw9uoH1ZpMonmX2m4M=;
        b=FWlWY3bYKaAaF0BN2v5NMj+9c8fH+/fBYhd+H2NeJcyCFgQvyCX4C21gD72Hnb/QgU
         n/HDraXX5vri1LaekatMGWpfS0L0Q+NersQ322z6qobYnhgpihPK8riKMEvlNVSiBA+U
         6lJ2X06BKzWB/NzdRfxA4G7JXwRmicfIeAzA7wbpxkeqdYZV9zEmq9P+dNMdW1NaZmO9
         N2gg8GRFAD5Q85v2wxnSKztNbnI75ZE0A3w6GnQ/ZAO1r7Z6ewG9An5JKLtUkxTEcHao
         z7PiU6/jiL20wBvHGNDVv20cn1ca97sJfK8s9xcgjLiDujZLjl4c0yvPJnDANIbVwLXi
         pyCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXRFY9IC9s/IclsiiYOHDNX2WvqZ03LwylfKdAr7ws+Juc6nrgnq1OlcxtA0V64vbhr4Dv6DSJYLAvB/PpMCMoADfgQp4MtH8/Va6
X-Gm-Message-State: AOJu0YzQ6hS9KQqynOga5haodvt3On+c6HRYTUR9i0ewHYi/MYF9i0kS
	hB5J9KmTaXc2wZZqQcGbqFMwQ5Co1WkfR8W6e0rMSpzXOhaAOkU+UtMj1DBmGxydDzgyjvlRRmM
	4O37NdMIYSThrfo26HPfT7A==
X-Google-Smtp-Source: AGHT+IHBrk6zGrLRvEbSMcEpcnHmnJbnra6pQeNSyJZbQ9BgSgKRUmJEvGFmH9pxKHXNYSwBYt1Rhd64annoMJhMGA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:ca23:d62d:de32:7c93])
 (user=almasrymina job=sendgmr) by 2002:a25:8712:0:b0:dca:33b8:38d7 with SMTP
 id a18-20020a258712000000b00dca33b838d7mr2596614ybl.11.1712590203429; Mon, 08
 Apr 2024 08:30:03 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:29:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408153000.2152844-1-almasrymina@google.com>
Subject: [PATCH net-next v5 0/3] Minor cleanups to skb frag ref/unref
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

v5:
- Applied feedback from Eric to inline napi_pp_get_page().
- Applied Reviewed-By's.

v4:
- Rebased to net-next.
- Clarified skb_shift() code change in commit message.
- Use skb->pp_recycle in a couple of places where I previously hardcoded
  'false'.

v3:
- Fixed patchwork build errors/warnings from patch-by-patch modallconfig
  build

v2:
- Removed RFC tag.
- Rebased on net-next after the merge window opening.
- Added 1 patch at the beginning, "net: make napi_frag_unref reuse
  skb_page_unref" because a recent patch introduced some code
  duplication that can also be improved.
- Addressed feedback from Dragos & Yunsheng.
- Added Dragos's Reviewed-by.

This series is largely motivated by a recent discussion where there was
some confusion on how to properly ref/unref pp pages vs non pp pages:

https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t

There is some subtely there because pp uses page->pp_ref_count for
refcounting, while non-pp uses get_page()/put_page() for ref counting.
Getting the refcounting pairs wrong can lead to kernel crash.

Additionally currently it may not be obvious to skb users unaware of
page pool internals how to properly acquire a ref on a pp frag. It
requires checking of skb->pp_recycle & is_pp_page() to make the correct
calls and may require some handling at the call site aware of arguable pp
internals.

This series is a minor refactor with a couple of goals:

1. skb users should be able to ref/unref a frag using
   [__]skb_frag_[un]ref() functions without needing to understand pp
   concepts and pp_ref_count vs get/put_page() differences.

2. reference counting functions should have a mirror opposite. I.e. there
   should be a foo_unref() to every foo_ref() with a mirror opposite
   implementation (as much as possible).

This is RFC to collect feedback if this change is desirable, but also so
that I don't race with the fix for the issue Dragos is seeing for his
crash.

https://lore.kernel.org/lkml/CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com/T/

Cc: Dragos Tatulea <dtatulea@nvidia.com>


Mina Almasry (3):
  net: make napi_frag_unref reuse skb_page_unref
  net: mirror skb frag ref/unref helpers
  net: remove napi_frag_unref

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 60 +++++++++++++------
 include/net/page_pool/helpers.h               |  5 --
 net/core/skbuff.c                             | 48 ++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device_fallback.c                 |  2 +-
 9 files changed, 54 insertions(+), 73 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


