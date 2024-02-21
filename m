Return-Path: <linux-kernel+bounces-75054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9785E23A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18CC1F257E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494C823A9;
	Wed, 21 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lSxBK/6e"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E78174C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531114; cv=none; b=F7GNFW4mP5wOM/ngN8rVb5xDU2s/5znraKNRRkh5AhLPdX6bLHqakv0W1Q5qgeYZrMF7rH8X7ybF4UG1K67rTGZpR0yS1QJXBFI8LY3A/yE44mDTXkZn2vRROLknMCzNnX9Yx+KFbghC0YKRhxo32zE+UnlxO7gMx3xZ4somIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531114; c=relaxed/simple;
	bh=pWhB/9g8CnlBlxQ4Kle145idANlWr2RhmhOKdwGONLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JUdKbmM7T52k+CYFNSt6iDwzpOBkD/KHbFHmLQnX1L1FBdLF2nSMOxZxu25ZCG//zmd3hYioAtAPmgZ/zoGHsewUdDygKlFu5JDS34KIgXmqEOtZLsS72F2WKzCB2SRdV2lTlCD1pvuT7W+uD40eHH0HvSJE4DISekJQPOmfWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lSxBK/6e; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1983482b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708531112; x=1709135912; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak7VbKSDllUoXEGnuzHtfjgftB0cmnm1/VIOdiVmP0s=;
        b=lSxBK/6ezXaqTjYAA57Z6SSYkeQ87fijqJG7wwsrr1hfGQgHwk9j6MfqRaGM0tFDL/
         koVqnO3pXr84FOx8JHuA5xP6pQRPK+YXj44ithDPeQUDiRirNvnW2A+kcX7FY3XQP6Ud
         h8dHtXsdfXJd5BFaQ7z1XA8Y8Faiw8zikLClI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531112; x=1709135912;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak7VbKSDllUoXEGnuzHtfjgftB0cmnm1/VIOdiVmP0s=;
        b=YtHgClJ1vtN02MbGSbMBJwUXHdD/Ns5fMvSy9Bxjdf/kGbyAhv8triAIb7ivAoTvxy
         +SA27FMef/VNAKoQGmLH4lRK9qjoDlRo44CsIkIWSP3PZVq6JbIPnvlWORn+dU/x3m0+
         Dwbq9zMGs0GP4DPrVHAxGGMru3YPJWubxeH7sGH75NW8xBvI6nUR8yaRyBJNCfmYBzoO
         sW2i2jXGMfrdXoP4X/Kvvz+23A8zwX6169XxNhdIsjzV3a8XnVme4EthOu6fjhH51n5t
         Adc9F50dsQ4eaPdu/k/rk9abfLXYJ+bzQsO1/A8Gwh1YA8EWrQjxjUui/OKRfP1oNt4x
         OEhw==
X-Forwarded-Encrypted: i=1; AJvYcCXhEzT9RWANAbVBUbyGwutaHjDgMoDez9m82uneyiv2Uxhz0AESMCKgZCsgyW9GiuZSYMFUZZe4rjJOp7FMYqKIUQvAm9Saii0D5Fqp
X-Gm-Message-State: AOJu0Yy9x7HF5nth/j6VKNMJ1e1nXYp8h5OK8RynblHX7mAR03X9aYjl
	zaqyEfdwTMsjZ2T9Byp5uwM9bUuPL+xgmpcWMp5h/jgORcbojJ1gdv9iVHcsfI0=
X-Google-Smtp-Source: AGHT+IFWspkCZ1P2HbxMSfAYU2V9J1Ht1gvojwI7Vl7x2V0VqK21ZzagaOz9patq3QdJv+5jFG0Xtw==
X-Received: by 2002:aa7:8704:0:b0:6e2:e48b:43f2 with SMTP id b4-20020aa78704000000b006e2e48b43f2mr10940437pfo.20.1708531112482;
        Wed, 21 Feb 2024 07:58:32 -0800 (PST)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm5751327pfb.75.2024.02.21.07.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:58:31 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Date: Wed, 21 Feb 2024 07:57:28 -0800
Message-Id: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Greetings:

The netdev netlink APIs currently provide the ifindex of a device
associated with the NIC queue or NAPI when the netlink API is used. In
order for user applications to map this back to a human readable device
name, user applications must issue a subsequent ioctl (SIOCGIFNAME) in
order to map an ifindex back to a device name.

This patch set adds ifname to the API so that when queue or NAPI
information is retrieved, the human readable string is included. The netdev
netlink YAML spec has been updated to include this field, as well.

This saves the subsequent call to ioctl and makes the netlink information
more user friendly. Applications might use this information in conjunction
with SO_INCOMING_NAPI_ID to map NAPI IDs to specific NICs with application
specific configuration (e.g. NUMA zone and CPU layout information).

An example using the netlink cli tool before this change:

$ ./cli.py --spec netdev.yaml --dump queue-get --json='{"ifindex": 7}'
[{'id': 0, 'ifindex': 7, 'type': 'rx'},
 {'id': 1, 'ifindex': 7, 'type': 'rx'},
 {'id': 2, 'ifindex': 7, 'type': 'rx'},
..

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 7}'
[{'id': 448, 'ifindex': 7},
 {'id': 447, 'ifindex': 7},
 {'id': 446, 'ifindex': 7},
..

An example after this change:

$ ./cli.py --spec netdev.yaml --dump queue-get --json='{"ifindex": 7}'
[{'id': 0, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 {'id': 1, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 {'id': 2, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 ...

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 7}'
[{'id': 448, 'ifindex': 7, 'ifname': 'eth1'},
 {'id': 447, 'ifindex': 7, 'ifname': 'eth1'},
 {'id': 446, 'ifindex': 7, 'ifname': 'eth1'},
 ...

Thanks,
Joe

Joe Damato (2):
  netdev-genl: Add ifname for queue and NAPI APIs
  netdev-genl: spec: Add ifname to netdev nl YAML spec

 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  | 22 +++++++++++++++++-----
 tools/include/uapi/linux/netdev.h       |  2 ++
 4 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.7.4


