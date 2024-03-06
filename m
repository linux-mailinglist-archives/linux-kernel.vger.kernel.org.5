Return-Path: <linux-kernel+bounces-94755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0B8744D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E301C2211D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A401D52B;
	Wed,  6 Mar 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJ6Lqnat"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABD1CAA0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769570; cv=none; b=JIAE9zNfzDrKz7gwnGmR+3Ze65u0xca/QvtJsJH82o+233WUgOzFsgE7gm1hKDn+oN/FEtDBJlWo5b7rUcRTh4L+TM7mVRPniLLSA4yk3rVE4v260m7fOthqy7RHhphOyfclSmKdTOiGDzDNgEwq7wsg+sUOauqckhZNPdnWFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769570; c=relaxed/simple;
	bh=uwk2ahz3j3nCNSoiWAgNLzF3crn2cMJrLrVycgFVLC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=byItdWhvAg4cbCXeItad+bSGZPFMvK+uXreDeZYgt17U0FYmMuAwDdp2dCmO7ZTIdTy4EUUms8260VXTg/MnFHT7m6sJXvSjo7G0m0iI5KSY+VF1Z9Ou7WnpEJdLrl/YKtimxfQsmSxvOIbTPHhZYzBNeg+KTSXr/yXnImax3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJ6Lqnat; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e88ca078so4640847b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709769566; x=1710374366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NkZW2ptiTvn4uJjuK6pXF9K7rZKuDbfhR4CUsK2zUgQ=;
        b=HJ6LqnatrgTNx8gURMkSnZ+z+6b37qOPLz2XH+Mw8E9WJRwuD0197pOt1tVA/k7W4n
         +FgZYri4qMrxiOSQSLiza9Hn50ow2HiWzv6Myd4gfOMCmY0QzKe3aMhPWXzd+pEmJOHD
         cVhLZ10J5praDKgc278HiXlOpzfTHevrSWX0SdwiMW7xJF65sM8++qTciJSNT8ynGS+8
         syQ7DM87Vmmb2r98XgtYo11/2M/4pEMk63ikYG/sUIrei4HHiAhCbwNuxN/0phoifEuz
         TodGSioYzwxceAhVKjQxdYfB4k7/50gTb84nvvizxHPOfr3kk/eipxmv/tpCgfQoWtaW
         sMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769566; x=1710374366;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkZW2ptiTvn4uJjuK6pXF9K7rZKuDbfhR4CUsK2zUgQ=;
        b=LksQS9x/iOulvjB0eGFmQYZpqFjRLFpsjqr0eWjhSXQk+uw6LpQF13fbfprLWiRtRR
         Ozo1FS38JTvC8AbV7t053qKEr6UZmhjeL/oRy2m8/kcoOXrwR/c0RKhNsmp1csOpH80U
         R/+RMBIR7aEoasv3xZYdwYC0SGVDzn6lfQR6mV67VhiAwGCRmJfhFzLou+QDNta/T0po
         B3XYq2YiQpZ/Ex8tyTa7O2Bf+aPcq77yPfvDNe5nzFzx9snlQrqtyA7O4j4fO9D76QKm
         S480hI9xqeLa7Av8Doj1eJxmnhRvJDJFgeHR9G3e7PnTyivkVoc2irj8ppUe1cZ0Pepp
         SpEw==
X-Forwarded-Encrypted: i=1; AJvYcCV3gWlfjg6oNJT+76Ti4RJYczH7wVWQUL6wta18HMG3g/I7wHpphyEFwm3J8IP2Kq8shrCh7j8fK9E33IyC7NKUd4BVkEXez1kfdD87
X-Gm-Message-State: AOJu0YyEUFUaZr8NX0sJn5MOgMdSa9wRapX9iIOlj/+u1LIhPcfGGcSR
	VgzelWvFnyyxjb1qUkTBX9NajW3NgnMgy9hEHpTklGmAIX4hhVer66aQpnnQYV+RqVWa1xJa8Va
	fbzLp/LTDXJvUdp5fdtFY2A==
X-Google-Smtp-Source: AGHT+IHUihCzETvNdLP/gwG1C1yCXXXKV4Mr+NDAUX//1QucYmnF2QH48UYNrIxzNiW4HUIl9tfQ6FznsThujGuW1w==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:daeb:5bc6:353c:6d72])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:c17:b0:608:8773:85da with
 SMTP id cl23-20020a05690c0c1700b00608877385damr4107511ywb.0.1709769566467;
 Wed, 06 Mar 2024 15:59:26 -0800 (PST)
Date: Wed,  6 Mar 2024 15:59:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306235922.282781-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 0/2] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Mirko Lindner <mlindner@marvell.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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

Mina Almasry (2):
  net: mirror skb frag ref/unref helpers
  net: remove napi_frag_[un]ref

 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 45 +++++++++-------
 net/core/skbuff.c                          | 60 ++++++++--------------
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 51 insertions(+), 62 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


