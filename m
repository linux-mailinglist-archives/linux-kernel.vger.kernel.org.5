Return-Path: <linux-kernel+bounces-64882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFF85443B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A91C24445
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550D79CC;
	Wed, 14 Feb 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFEFahoq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7376FAD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900514; cv=none; b=hkIocTMUG7g1FDGyq/m0ckE87VhzX0D8EuBsEpShvdyFAe2qdZdnEvi+K1TK8hdn3NEe01z3X8+iU5hQUA1oBR8w5TUNvjxRPz0x8dC8ggyJJtH6382y1F9+TF6PFpuH5aP/GADbKT+9ApAKa0wrlL4JMRLgzAA0+Yi5NkvPtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900514; c=relaxed/simple;
	bh=tb/rHH7nD+tvYMzZ/pXuxRJUhft+UD56HAU8GYSKNVA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Me1FLIpZCSfkwGIVkRBqv4Qnms5a4cH4wpB4GcU97xFDkjAg8zid2ZVGGrr4ywwG5aof1cB7btN+wAcqW7C5HQ/tehaWS+9uCZhPznnHiDTKfEmKqqrFfZ4PSf67GP0SRj0Z6CISMGX7JBCazpMCeoL0gMxUdU1L0JjLlvxnO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFEFahoq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso9047641276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707900512; x=1708505312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VnZBAXHHBHi7NJ95r/XBvn9wLkNSo/WMgRYmbP1bpJM=;
        b=tFEFahoqv9sXFSjlZ/8B2OECr83kr9wjocte71kUY4h7pe7u/cYeRCa2kvFHCuOse2
         CZCxU8PXKkVJGwY+30i1C36UUQKiB32D5H5LKJADd5NgFGkq8KEqgiRBE8hyMx+55uj3
         ldWppqcVrlMm1x2x7Ukhz9ykAY6ik+PT3mY1oj73qv4v2wBkjdqNeyXRsmM6laZ1zLnX
         2j2biGtQLOjuPlNn/2MYscIh+8K+0xQrE9GH+4d9JCsKjpK7XeBW2V9kBouOaRzwGA2Y
         cQTZF4PaAL539gZQGGudFguYHzPk6CFk4qlDbYK9gpYJ2CO+E5MEqQcKmLrqGwXdxQwq
         qLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900512; x=1708505312;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnZBAXHHBHi7NJ95r/XBvn9wLkNSo/WMgRYmbP1bpJM=;
        b=NQkiq41EXJtaXuLu6swg2LZFlNX/1jqno2PniE2lcV2a0r+FeU85XQneHEcZZqyf1K
         CCS6oQe4kwXviScvW3PkmiLiSyp1Axwjz3sToqNaMQWPIe2V4whxReakdz5M041wSexh
         rcsirOOkC2acps1fk93eCoQLGrqPLohSrXhrUT9O/B/bP1/8GgtnnE6a41uPfxvGu43v
         3HqHtPQAhoUIAkDqkh4hai7M4HPjAc4PR8llQ8nBvMQi7QwXJjVxjsfvhkx7B/klCCKi
         8xtWUTCulD6qaSKHXToDPCoaVkyuDSZp+5/zNGkxmd3e3V7Z+ATrw6qqboErx4EH6eOk
         v9+Q==
X-Gm-Message-State: AOJu0YxK34DA92raV+IuFJqwvWrDv0wshdXjD+Cd7dxTtOtjYiH/7cyY
	d9otphDMKCIWUSeuOoXociNRdOEv7FS8UJNnq1roxvl7XeJsRgZ7QsljgHYvSBsAA1a6HFQDK+W
	ROnEw9C4isA==
X-Google-Smtp-Source: AGHT+IGqH2Ji1XS8yKB5q7FUw5pXkurHoQqkeSFcC81rXekWCkW6y6p+vwSpG0k9rx+z7LT+GsWhIVuGtnq/nw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1007:b0:dc9:5ef8:2b2d with SMTP
 id w7-20020a056902100700b00dc95ef82b2dmr453013ybt.4.1707900511818; Wed, 14
 Feb 2024 00:48:31 -0800 (PST)
Date: Wed, 14 Feb 2024 08:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214084829.684541-1-edumazet@google.com>
Subject: [PATCH 0/2] kobject: reduce uevent_sock_mutex contention
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series reduces the (small ?) contention over uevent_sock_mutex,
noticed when creating/deleting many network namespaces/devices.

1) uevent_seqnum becomes an atomic64_t

2) Only acquire uevent_sock_mutex whenever using uevent_sock_list

Eric Dumazet (2):
  kobject: make uevent_seqnum atomic
  kobject: reduce uevent_sock_mutex scope

 include/linux/kobject.h |  2 +-
 kernel/ksysfs.c         |  2 +-
 lib/kobject_uevent.c    | 24 +++++++++++-------------
 3 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


