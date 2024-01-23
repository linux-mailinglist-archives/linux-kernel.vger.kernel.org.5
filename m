Return-Path: <linux-kernel+bounces-36124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B47839BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8797F288570
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FA4F218;
	Tue, 23 Jan 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVi0EGWV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D84E1BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048276; cv=none; b=lmRoco6QSdkZSdTEdPMv8IgdpJoZ6N2WL/Rz33Efg1YuYwbm4BQPb6HRSAS4QENvOx7Zjg7WIp0HvoLQ7An1pm+uKwgk5/jUsduuCyE2gX+fvy2lMnNM9qEFGzczOuAJYynPL7SJafk6Q372tXocOI8bRCUCh5HfS+PxxOfcl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048276; c=relaxed/simple;
	bh=fibjmZmjuKKnvDk9ji89uzWTcVwU0i34NoX/+yPgrZo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Px6N1kpCmPojoHWx6HlaAp89DVysFCgWMhZ2Nxl/5WxIvjFnOlR7qBWvxvPDT81m2zdAZVrqpu+tuqLNylKUPr0peMW/o45Zn1xIX8K+OFR28JTjRixbpKf98vVv+GFeTNf2TOxXft5NGYbiGq2zFV9tYAY6ldEDZ/KyntxT7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVi0EGWV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fffb2798bfso44029877b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706048274; x=1706653074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw4CHX/yPrA/zwMzsyij6NhlGhkx7uxmvUtdcUBOHDo=;
        b=pVi0EGWVKAiMg4QifRSF9wDldXJDvetCa8yjgDZY2JmyHqYpNMv2C48uYFn0QazU1e
         EXExto98Wh9sqFZZvdwLGQHDZjVjLn6JCNtNXiltaJXPjmdp5PPpTg1vwltmWKPZgcjz
         zlrXo2gA6BZCSQexK76mcwZ9jUrmUgjhwJyXOxj/mrkALfXW432J9wZbc8CuCFph/S3N
         nKeCPwbvW87OT8tip47OacWC08C8/U9+zhaYF01ctDUdy1yAVW0KOcqMVYKP+ywFEHAP
         qWpjJWZwaU/Mz8Ed/brk9xd5GQ7JxNuelmwrrBLorYFkn/Fldw3p6G5uFVDDtWgbCdvo
         Wiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706048274; x=1706653074;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw4CHX/yPrA/zwMzsyij6NhlGhkx7uxmvUtdcUBOHDo=;
        b=QNlbFxHWbYHv0JQmbyqwaYXNVYpqCco7EAvjNZCcBrVM/OsxXgy5zt475xStfci23E
         6lPxz+asXdtZq13UJlbhEV4o9cGJY6XxIaEOz96b00YohhRkj5BH0ByMJcQiJNqx3ZnB
         eMzI+EiKbqUR3Yp1FSLFHwuDAF/REcgzyatMaJ9dBV6TKXJAQn/7sDNR8V5fj2tKomuc
         z3qrqf3Z7vwboy71fQehCiTfGk+QZFrlrmUBd7feDlKtke4wojZ+z1Uk7wDmp78dxfFc
         vntD2OV6ZuJcgKx9zP6DQe7PyjuBeRXUY8ksKGJVeMCGmZHpuVWSDWsVv+0mfgqsjM9m
         HoTg==
X-Gm-Message-State: AOJu0YyIfDmc2d+r6xHZMOvXNcKovzpdq8LtsBlme5N5+N4QWvaFqWfz
	HE3GpjrhSfPdsxouBSuUqYJOAuLNfVNB4dJXwo/NbPKuzEZdGue9myc14WHmAx8eVF9nnI8m/uh
	FH6KuZWyvJG1vawDo81LMqV4sL4YyeINtbX9OF1V9eC8M+DE2/oxCM+s1X0dgdxuCZ3Whfd+Oco
	N8iOZI67rKOrWSpPPdlRW8s7qx/scMq3G5kVhN8u+UtpsnKz4CwI3COrW+4AW9XzPlqoU=
X-Google-Smtp-Source: AGHT+IGzQOEeslPfrOE3siORTL3t/RQ7QXEdr7ChXI3GBke/z5IxA/wuJR/uFV3oftguGvZUfhRfx5oFoHb+uespPw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3608:aa16:52d:3594])
 (user=almasrymina job=sendgmr) by 2002:a81:9242:0:b0:5fc:316d:a366 with SMTP
 id j63-20020a819242000000b005fc316da366mr3066711ywg.4.1706048274064; Tue, 23
 Jan 2024 14:17:54 -0800 (PST)
Date: Tue, 23 Jan 2024 14:17:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123221749.793069-1-almasrymina@google.com>
Subject: [PATCH net-next v6 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changes in v6:
- Non-RFC as net-next opened.
- static_assert skb_frag_t compatibility with bio_vec.

-----------

Changes in RFC v5:
- RFC due to merge window
- Changed netmem to __bitwise unsigned long.

-----------

Changes in v4:
- Forked off the trivial fixes to skb_frag_t field access to their own
  patches and changed this to RFC that depends on these fixes:

https://lore.kernel.org/netdev/20240102205905.793738-1-almasrymina@google.c=
om/T/#u
https://lore.kernel.org/netdev/20240102205959.794513-1-almasrymina@google.c=
om/T/#u

- Use an empty struct for netmem instead of void* __bitwise as that's
  not a correct use of __bitwise.

-----------

Changes in v3:

- Replaced the struct netmem union with an opaque netmem_ref type.
- Added func docs to the netmem helpers and type.
- Renamed the skb_frag_t fields since it's no longer a bio_vec

-----------

Changes in v2:
- Reverted changes to the page_pool. The page pool now retains the same
  API, so that we don't have to touch many existing drivers. The devmem
  TCP series will include the changes to the page pool.

- Addressed comments.

This series is a prerequisite to the devmem TCP series. For a full
snapshot of the code which includes these changes, feel free to check:

https://github.com/mina/linux/commits/tcpdevmem-rfcv5/

-----------

Currently these components in the net stack use the struct page
directly:

1. Drivers.
2. Page pool.
3. skb_frag_t.

To add support for new (non struct page) memory types to the net stack, we
must first abstract the current memory type.

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for safe compiler type checking we need to introduce a new type.

struct netmem is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page underneath.
In parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.=
com/

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Mina Almasry (2):
  net: introduce abstraction for network memory
  net: add netmem to skb_frag_t

 include/linux/skbuff.h | 90 +++++++++++++++++++++++++++++-------------
 include/net/netmem.h   | 41 +++++++++++++++++++
 net/core/skbuff.c      | 40 ++++++++++++++++---
 net/kcm/kcmsock.c      |  9 ++++-
 4 files changed, 145 insertions(+), 35 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.429.g432eaa2c6b-goog


