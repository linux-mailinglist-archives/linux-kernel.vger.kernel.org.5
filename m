Return-Path: <linux-kernel+bounces-157325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F548B0FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16499B27BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64316C445;
	Wed, 24 Apr 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLTkhWDl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F06224E8;
	Wed, 24 Apr 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976272; cv=none; b=Cvo8tc27eTqLylUT3uZBjziQBVxX5DxFiZuNO+QIoNxhjWj24iQIaKHvDDwG7yInTTg8b9sr/AdYoYujY+AnMna2d/uGaRR2Yw/iPMAZZSv08R5AujeEr5FlBJjcDoh93IvsEurxaP+YOiPm+rCxd3a13rZFxC9QAMDxRjb2wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976272; c=relaxed/simple;
	bh=O9Sp/wFnbky1LKEpDprDFhwKbnIFcM6CkDDPKXLGBpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaUUqmzBvJ20jhuetX9GJozdEMIU+7nytS6Q5yBqb39Aktwlima7cfepa8m6AzlCSlq0aE25uIlaZHMo2WhhCjdKM9EIHtCfIH8R3fBAgX6SPwStzCPZiUGjQXkNZpN9jEta3tJ44WSx58JJZV9YGO64KfkZMzqzYVZE7JX+cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLTkhWDl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso170695e9.2;
        Wed, 24 Apr 2024 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976269; x=1714581069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSdkyyn5U3/SJXyABTnjAWYL8FjE4mzJB7GBhNldr4g=;
        b=dLTkhWDlRZWV+CTu9j59r3iJTNmAqdPmGad0L/L3rOx27XNo3aHKbHx11w/7Hl+qnA
         yvrBXgmV6JsnQ0CtC7cGNXjuyfOPLRaeGHLJFHdprn/o3uQrAo6KcIonjfwH/YuX/xHL
         5LTZQxVCLe5J7bNotwk3C/BhZXxc6TqDimmsPDc5HvnyfIgl27/sNOLJbzD7ox32oulO
         8ZLSyi5TlhRlIEY95K4KiCVeHk8mRcmONwQv6CK+eyST5BG1oSaD4w2vmI4hXa4dr8Ys
         ptw0Y+x9EkmRYTUd8sjpY6muaPn9STKxyaxD9p9A3OtQubJqSsx6Cj1/7iQTAr052UB2
         QfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976269; x=1714581069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSdkyyn5U3/SJXyABTnjAWYL8FjE4mzJB7GBhNldr4g=;
        b=Z1/5jSW20MhH8hu9zrH/cHuq+2zxmC++Qn/bbNdq/GvPth5HHkUIg+Z17ZMJPJ2UwO
         n7KGTmO/NNfylu3z46V9yNzCAwpGGicyNLKB570woUL2XY3X5NTrfAoIA+T6Mkoz1m2Q
         kCFngrk2tAlxXf3O/e8u6Y+0DR+Ceu5q69NWgPEE77M6TrpqoNQf4ZdpZjfzdXU8Hi9l
         lOGEPdNT/l/K1DWvlzBl6UA7g2vS81Z5ITPK1YsTktTQRv7ITHtUvk/eDNResuZtsJci
         4MWFtSvrupJtAqZp0GHA8UyOuFtwa0OONeEiEikiBm7atbdjATfBZ8CMEJv7XNknUWKv
         8hcA==
X-Forwarded-Encrypted: i=1; AJvYcCUMKgLbndJwrfOc7WEYNpYlVzAARhgHW06hswNT1F6pFQBhohl7Kjpz1Q3tleXamiKIt5B7No5G4AqseYclVt3qdmS1GHFxX3sCrrOK5vYr2h4x3w2v0SN12CHXw2xWP+hhrNIj
X-Gm-Message-State: AOJu0YzOoVUTBshV+DIcU3cSK1SCdZCzpMA2bPZojHmL8HAKvZS7qPBn
	PfV2bqTo5NFzpS0ec0QJjQc0wu7gvotVun4x3iEEQu9IHKJwRhEB
X-Google-Smtp-Source: AGHT+IEd0SKAwnU1BHEHCMyexmTZr4H1gUscqRC5x0JQ2gVFzWEKReNaC3G3CcfWT2CGQLJFg4oNVw==
X-Received: by 2002:a05:600c:5107:b0:418:d077:2cbd with SMTP id o7-20020a05600c510700b00418d0772cbdmr2073058wms.40.1713976268538;
        Wed, 24 Apr 2024 09:31:08 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm28216318wmo.21.2024.04.24.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:31:08 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v3 0/2] net: gro: add flush/flush_id checks and fix wrong offset in udp
Date: Wed, 24 Apr 2024 18:30:43 +0200
Message-Id: <20240424163045.123528-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to add network_offset and inner_network_offset to
napi_gro_cb and use these offsets for socket lookup.

In addition, p->flush/flush_id should be checked in all UDP flows. The 
same logic from tcp_gro_receive is applied for all flows in
udp_gro_receive_segment. This prevents packets with mismatching network
headers (flush/flush_id turned on) from merging in UDP GRO.

The original series includes a change to vxlan test which adds the local
parameter to prevent similar future bugs. I plan to submit it separately to
net-next.

This series is part of a previously submitted series to net-next:
https://lore.kernel.org/all/20240408141720.98832-1-richardbgobert@gmail.com/

v2 -> v3:
 - Add network_offsets and fix udp bug in a single commit to make backporting easier
 - Write to inner_network_offset in {inet,ipv6}_gro_receive
 - Use network_offsets union in tcp[46]_gro_complete as well
 - v2:
 https://lore.kernel.org/netdev/20240419153542.121087-1-richardbgobert@gmail.com/

v1 -> v2:
 - Use network_offsets instead of p_poff param as suggested by Willem
 - Check flush before postpull, and for all UDP GRO flows
 - v1:
 https://lore.kernel.org/netdev/20240412152120.115067-1-richardbgobert@gmail.com/

Richard Gobert (2):
  net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
  net: gro: add flush check in udp_gro_receive_segment

 include/net/gro.h        | 18 ++++++++++++++++--
 net/8021q/vlan_core.c    |  2 ++
 net/core/gro.c           |  1 +
 net/ipv4/af_inet.c       |  5 +----
 net/ipv4/tcp_offload.c   |  3 ++-
 net/ipv4/udp.c           |  3 ++-
 net/ipv4/udp_offload.c   | 15 +++++++++++++--
 net/ipv6/ip6_offload.c   |  6 +++---
 net/ipv6/tcpv6_offload.c |  3 ++-
 net/ipv6/udp.c           |  3 ++-
 net/ipv6/udp_offload.c   |  3 ++-
 11 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.36.1


