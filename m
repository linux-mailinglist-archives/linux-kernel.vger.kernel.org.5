Return-Path: <linux-kernel+bounces-100489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C8879886
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8251C21DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7967D406;
	Tue, 12 Mar 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="D+cHjqy6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435297CF1B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259577; cv=none; b=irD/+/lJtfbw3hku33A7rIThzuW76fwBV+9OZEXGLMNaTFKqDu8V3WHJ645GXrJj7YeO5ykBzyaoDnNSQStaqNFLFko2WNevRy8SbiNL8y/IwXzJxRJkuyoSvGYCjSoWPt8E5CWaytVJiSKGv6U+RPnuyDJQX4+HNJO7JGhT/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259577; c=relaxed/simple;
	bh=ffxPWdRj4cwEa02QJ/6eA7MLrxqYDm6XBwpjom5fPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ol29aieAdFJ+oODW+ITsu/QlEDGwiuBKtjaKd2qCkogc/Dbyym2KRn+n0EKcefNgrLNNC9dppe9uZ5snWpUJ/bz6MbJE7+AZyi6AK1ob7U6U/RBRWgkpUFQsmGlRoJ4lDA/nWQMZzRESPySJ5QDKNmx2EbW4+tohLjbCOQuWPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=D+cHjqy6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51380c106d9so4806124e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710259574; x=1710864374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oo5V7KMbjzB0VE7JVYY25Mw2tIhasEA32KtjALRCr8=;
        b=D+cHjqy66G+zZi7LL13uY4DN8izTM1dtLMSx6Bn7Rpatn0WOU1Tjh7Q51BtI5KvIoz
         5aurAlUDZl7xPy7bI2m0NIES2nhtPnQ/tA1q9b+rAQtHqYff0vRIiV/0Dpw9l5C5/+zp
         VgP2GAvH01fRtHgtaSO6RWhpVfiEW6KSA3S1bPwCkMzVz5dDFI4h8R6twUFSSXMIqr6Y
         vve5Qg9lkGPcRelAiHnKFzVXnqXm7zFrZ9FNFXnreOpOoxwnVNTsgBuU/BE9dSFYJvED
         4L1Nb5717VXfTngsHXdd/IN/LQEvpxCm5zOydmT9rF4L0owUMyZC/i8lNAreaoRwFLwJ
         LUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259574; x=1710864374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oo5V7KMbjzB0VE7JVYY25Mw2tIhasEA32KtjALRCr8=;
        b=rO+ZWlqw9pXngnCE9DBPzUTfCo6hqRcC3blpApMEz21geUAkJGKxTyGThtqJxWTTDB
         OILY3Y5/lgykMiFytKk/bTPpCyxv5Gf3xN4Cpd6Kc5lyiPaZGRV1NYoU9e5fZBYdv//q
         Wjd5Ip0KjsAWViqOW0Z3njGDs7HGj3WfXbE+8gi0zuZhtgpJNouxpM4bpuZQ3gLeaNTt
         +ld6XZIm2QBhsu9U9vD5AdKuIvnhmyCAZaQaXcSpOIKIBlyZYxqPGunR8mHad9Bz/QHt
         iuL48I1DkqRV/daPLDawKSwHrFhpDlACN/1Lg7139lOL68x04+ZHDOQGSccns4pTw2bl
         9fXw==
X-Forwarded-Encrypted: i=1; AJvYcCVSWctUdiPNpmLI1Ig9senj81V/px2Tt7O690p5P1v1IiXtBdTpW5e2/fc0AaC4Xe4MLGeaSqQqNcW+GujgW20nfMvSyIxrxJI7jOQ7
X-Gm-Message-State: AOJu0YycTj3MM7ZQLsG2GL3jELuIdvUd3Kf186JbYaXcNmYHuvQnnUKs
	uBhJBYUijAE34tCMn4HojWfvVX7fQuOs/IjK24MnJlCkvNdn+eLtRKF/c+N6Vkc=
X-Google-Smtp-Source: AGHT+IGG/4pdRTFr/CMG4iunQGGONt/Uljten+wu5aH/Nw8HevuiCQrjhw0Drtz4MkQQkXN/X/yM6g==
X-Received: by 2002:a19:9112:0:b0:513:2c86:3498 with SMTP id t18-20020a199112000000b005132c863498mr428344lfd.48.1710259574342;
        Tue, 12 Mar 2024 09:06:14 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.7])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm474253wmb.43.2024.03.12.09.06.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 09:06:13 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v2 0/2] net: veth: ability to toggle GRO and XDP independently
Date: Tue, 12 Mar 2024 16:05:49 +0000
Message-Id: <20240312160551.73184-1-ignat@cloudflare.com>
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

Make GRO and XDP independent for a veth interface.

Ignat Korchagin (2):
  net: veth: do not manipulate GRO when using XDP
  selftests: net: veth: test the ability to independently manipulate GRO
    and XDP

 drivers/net/veth.c                  | 18 ------------------
 tools/testing/selftests/net/veth.sh | 24 +++++++++++++++++++++---
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.39.2


