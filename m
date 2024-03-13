Return-Path: <linux-kernel+bounces-102371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84287B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E9F28F1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37176626A4;
	Wed, 13 Mar 2024 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H5IddwHx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939706215D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355091; cv=none; b=bD9H1v6PuNGpd03dL0W/1u4jdntcr3+5qZFp9Q6QssRGM+HievFBRFo5e0OZ5VqewYwhT/GQ+nRnhJLR4TJxrPMaY1YH2r3y4hCaWX0rgyckt4AyGBfNusxMhgr6fWf36D0zl2QoiRlwYpEwaIW1hMZbSmxpdZKKUGCvd31eDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355091; c=relaxed/simple;
	bh=a4XzuwxgLVEIQQVkSkFv3KrXqBF34rv5jYAcRXbpdEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ejlD6Xo+ZHBLnVJBtN0gLgE2mpU9/O3HHGRRNxFhtBj4nYBup0tqBx4xBzOOT5yBlF24MtRrtp1WLHdJUxNoLFatGH8I+8slgD7RGDC5V8n8J1u9TgL6i6iicYia/aIaciHM2t1FkanS1tVXbe4Sqn5QxSe+uAAWy9MFF54F45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H5IddwHx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso69431f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355088; x=1710959888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtKSuJKdtcLBTd7f2vhOFkshAKDaa9ZF2n14qrkdYbU=;
        b=H5IddwHxN2O4OVFXMwRLWjAmcoZdmhS/rI69CMC9fxOsdM5dqZmIsQ+2TARBZKyC9m
         fGyPY4rIn0n4ZAumrJODDV4CE8X0zeCSZ3D7q+3sNLoDGIusggDbOxEdvgmnDHnsch5o
         nvg7rOXdi1HE1dIT/lITTSPI9qUhCa6i1540jaQjck7nfe2MNj1Aawbn6aPt4A59AdgR
         pOkULSmY55F7+lsM80JZbecr/3DPHlj1uclu8Lz/rKZH0OVb75sPBb60FRY6QgvhXQki
         zDH+U48mzx7TqBSLQJJFbf7iaE92EZuV+A9OrxmgD30KvF4f6+9r6eCVN858/amSxbFN
         Y1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355088; x=1710959888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtKSuJKdtcLBTd7f2vhOFkshAKDaa9ZF2n14qrkdYbU=;
        b=tZOVt+PGB/c0X+0neTTVMwdzktZg7FSb0aQDnxXjhRCY7TfwC2RooXJSS4YXc+p5KW
         N2FXLLQOXS7t9ClxZgaTF+BlGoR1zRVUPsQv/Mv91AC+mvSzZwNCCYYelAkU0nDtm//w
         THSz96sn4O9tYswI1BiFo4nWpkP6vn6tvGJsGSION0kr/xU6K2BLV2J1CB2/Xafx6hFV
         314w97Q5YVFZU4jFITEBMkdmpQ7i/hshJnl6z1PX5SM3AF+m3iM75VY4UBytpRo2cxrv
         T0BWBza6DDYH1VXI4yvz+nS6SghGgs7yl+D37lexSo661UAYIJtPC1sbxiyERMxMtthM
         Leqg==
X-Forwarded-Encrypted: i=1; AJvYcCU+PHYmlPHttmsPagNlU0pr0L9TnJvZdek1VRhSXZgk72duDU4CXm4xC5CAES8ycBJUQxuqfK9IOaMwSl7u4wq+a3u6z1YwYyqjDby1
X-Gm-Message-State: AOJu0Yzo5kJg/+0nOj5hneCz2urdzg7KT3WDizcppFe5R3TkuxD+Sbuw
	Qveh9X1oMG1zF3vIID49I4tzsPqfgRRdg+19rFU94wVU5MJcTTi7LPYy/tVSYVI=
X-Google-Smtp-Source: AGHT+IHpXQRN8UZGnn+SMd0qQ+H2r8qIhQmMblMzIbQa7U8LEVbkjlBmUcCwXaJ71Nvu1ETKCogx9A==
X-Received: by 2002:a05:6000:43:b0:33e:78ca:e039 with SMTP id k3-20020a056000004300b0033e78cae039mr2183049wrx.59.1710355087772;
        Wed, 13 Mar 2024 11:38:07 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.85])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033e9d9f891csm7089876wrb.58.2024.03.13.11.38.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Mar 2024 11:38:07 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v3 0/2] net: veth: ability to toggle GRO and XDP independently
Date: Wed, 13 Mar 2024 19:37:57 +0100
Message-Id: <20240313183759.87923-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is rather confusing that GRO is automatically enabled, when an XDP program
is attached to a veth interface. Moreover, it is not possible to disable GRO
on a veth, if an XDP program is attached (which might be desirable in some use
cases).

Make GRO and XDP independent for a veth interface. udpgro_fwd

Changes in v3:
  * adjust udpgro_fwd selftest to explicitly enable GRO on veth interfaces,
    where it expects GRO to happen

Changes in v2:
  * add Fixes reference to commit description
  * fix commit message spelling

Ignat Korchagin (2):
  net: veth: do not manipulate GRO when using XDP
  selftests: net: veth: test the ability to independently manipulate GRO
    and XDP

 drivers/net/veth.c                        | 18 -----------------
 tools/testing/selftests/net/udpgro_fwd.sh |  4 ++++
 tools/testing/selftests/net/veth.sh       | 24 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 21 deletions(-)

-- 
2.39.2


