Return-Path: <linux-kernel+bounces-130091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F18973FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300FB28915C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250514A4C0;
	Wed,  3 Apr 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kowoGhCw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB68149E15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158130; cv=none; b=VEpv2f4kHt1r/PPgk79ZSy3YqYo2r9oGfdMwwIjtUAleR7quKAYoB6ii8Wqu0b+89+YAvg0s/HWhTX7uPRZUt1FowCbqNE87Pr0eshY5CC0RKkCVgQld1hhGu71ZgQ61x9WJzTvaf9FSEMGb7P+YeBmEI2h2VFgg9+kL9F13jB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158130; c=relaxed/simple;
	bh=au/n60d5o6R0Kg5LapZUOk8iQLSXKBJCXWfesQIY5TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qdojW7JHGx/vhtLFRCLcJDqtu/DYesG14Q3PtK+uQ12EBSUULn3YB+L0zeq/uwR5FZbx0EJsjmbd51xvvinGsQj88E3v3sPYatrHNDC9BuziihmzxYmzxTUwjBTg9CahXPQZbh1KeR8OJHDDSKT4Wchxb8Cb0TN7FsEcxgny9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kowoGhCw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso2111715276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158128; x=1712762928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17B2Qf1CXAMUr3W4NJMc8Syb3k8HZV8FdHJlTbMts80=;
        b=kowoGhCw+51vtxxrqsiyqKTsxKCElZEtbgCnlvA8bF0brJp3UF2SX7JsjR+6QFc0FP
         sW0ju6NMAUXluiZMfmXajsxIdVG4AdiXaoz7tx4sPWPUEEbaYtJN9qzdQVQgPfLSNcYk
         Xrf31oYkj29CmG0s7/tnUz3StCaGN1ML7VE8jQPRk3EG/qcbYcW9nrlHAMsK692Xokop
         ZWwMgs5DdYAY9TeUHwNAUon7IpkQ4fRj+/hMwl3CjCVjOiqvrZoumrwKbzlli0jSztAX
         ipR4FdDYuDEyYCJw1GCwEz63MbrF2/IwJTKTuwOp10lNrXa7WKRdusAypLmkGgypEAXT
         wk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158128; x=1712762928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17B2Qf1CXAMUr3W4NJMc8Syb3k8HZV8FdHJlTbMts80=;
        b=Jivy9OXQGgP9E+dqxwxj/hQx1c4SETcmClVEX5r8+ZZSUbKZQ2XQWAlFj6DedBu84n
         vMBp+FEHYEinOzU5eOt1DzyQ3Zf8Pl4gUmqpi2lW7nva3MWZ19cOlFML9SdDSC92cqSS
         NxnKESo4j41TfIe+Zf2GNUedXicLKcaFtb/LGhBQrOWPrhPRFcfoUuCFsgPWq3SnztES
         yqrBIMzhwzXoeXrI4ij+Z4DAgK6VdoL7Bk7o7Gkre8bWV75mtF37VwoWO7lfFxy42zKc
         ahAHvSQZLhg7EDvnmbX83Rs29MBzH58Ch006u0h1vTAok6Fca9ahlP1JEl+Ve9a15jUN
         XKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV+fbqdBesWadraZkawt9Lnr4h5UCkVAyMBVXXuphaK4o2+3pF4+AuabrLjF3S2pbSwmEfT6Mio6U6shiLhtAqkB+ELa7hrNbThuAq
X-Gm-Message-State: AOJu0YwF3g/PU8K45U5yuPWQeFtTxuG979lt4tRpqVg1KswbzZmtALh8
	vAyxj2Ohj0iJ7ag0MPatA9Dh3T0VqcA3+aMR+Qx93ButLjcgbKvW5wWRo/AuW9xvai1qm8wvbOq
	02loCl9Pa29drWcJvlm3+1Q==
X-Google-Smtp-Source: AGHT+IES94MYmNH0qRTfB9Viikhf7iKIYv01lI0fxWY4KSu3Qedos7mJwzWleReGCKpLYhaMFtiAz4SRHX9ukUKvbA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2b88:b0:dcc:2267:796e with
 SMTP id fj8-20020a0569022b8800b00dcc2267796emr793904ybb.2.1712158127831; Wed,
 03 Apr 2024 08:28:47 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/3] Minor cleanups to skb frag ref/unref
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
 include/linux/skbuff.h                        | 38 +++++++------
 net/core/skbuff.c                             | 55 ++++++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device_fallback.c                 |  2 +-
 8 files changed, 44 insertions(+), 63 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


