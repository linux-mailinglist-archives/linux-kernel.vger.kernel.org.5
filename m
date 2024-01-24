Return-Path: <linux-kernel+bounces-36667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9650883A4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005B0B2A1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8617BD6;
	Wed, 24 Jan 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV4sq3ou"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0317BA2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086717; cv=none; b=sBLF/wGI0DuvZbp22Zjc3tNAn+SCims0irTPsTADiK+UnKDP8wLWnpDmQmHzLKw+QLtp0f0jFnAlHIcjpnTC90n0Rt23Hy6xYHuA/C335VRSEZ2JxaxTauTxliduN0+0hQoZB3oQinU7X9wExuMnMvZIWpheP67OQzTIWgwRHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086717; c=relaxed/simple;
	bh=jdwIaRyZVHawgxFCTMPT6W5hewQswlcHCPCVXYR0TrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VeHpW18/p0xFtr4gdbtcRtHbq7+nisLlLJUE+HuS+xpUIKh65tB2wHIidURfEqwg6AQE/0lNwWb5QISTMkCxyGLTzKCEFqWaFDpJJ6EkHz31wxvpcA8twZfkHpapYr1LfOJ3xLh2SsHg4D8kGSLA0Gy4QhkqWWNKwbUA8pwA2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV4sq3ou; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d748d43186so21058615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086715; x=1706691515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V18ahqDfUiTzj8CjlF4Nthz8ScQc5lT8Pof7p8dY6zs=;
        b=FV4sq3ou4ooiKT5bwXWpxqw7VaeC7R7MFGImsR/XwsducCU0ArY0huL4919Vv8fjQ7
         YDLpAhtG74q3XYPKIja8owmOX8g3eglIMmEaeetRmxcIyBMqUSLdI9WUOgqjbulL1pLj
         w0nSTINEH7pI1W6BXs4FBg7gP1TBnYLY9hoLc6C7LaHNJtQIOi0/DeiJ2b8AXLiFzkoA
         RiLsPlHDpgk27fDrUpUgWTti3SxJNXUTC+DckiZkPStmw8OQ1zp+Blg6yPxkJ/c7l2nt
         gYnWcl54hT7aVMs71VQ9xp6MPOL+53pzJl+dAzxDj2UFg2TDbaubSmEelcRUfDd4uIOh
         Bi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086715; x=1706691515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V18ahqDfUiTzj8CjlF4Nthz8ScQc5lT8Pof7p8dY6zs=;
        b=aqA0ezduV85BNufxXhEvpGD4fSYzqWDloXKgk6H3wvJSmMhut8wctv5i5sGPfRfygz
         xGhXCLiPMrt3VOVWinFC7KX0IopHb2BrmuMwUkXCEgynobcMRnYmVOawNiy+r475VbLZ
         MBRhwDoGPfO44jPaxXf+Fql2G0U8oAabK1r6ES4fSZBpQqUgX9w3mOBzv2AteRJLz+oK
         yICYY4A6kRxckS0eABFgbp/CGAQEDcQ+9bUz9oCkxbIisgl9LfTxW1gG+qdGYEeP+zV5
         f00xqE+oymDWsh5PuNz/EFrGZ/8fRLCPtDR9YaTAbJod13fqHdYkqaOIcHmim8v57YsB
         77Xg==
X-Gm-Message-State: AOJu0Yw+d0sEOuHDKCBBp1ThdK6Ijnkm8qEcuvifK4DT4BQmNQmb5J7/
	GdSzM+DTQbkVC8JACyc+Skg4zRUK3+KfsQKl5H/9kTJd+K9sGtgo
X-Google-Smtp-Source: AGHT+IFZ9JMGmH1Dag84QO2WjpeT/Tb5T0tareAvTBTF3VGyKmBnI9dbGMIzAd/2ZzNw9YeZz5O6HA==
X-Received: by 2002:a17:90a:1217:b0:290:8d35:f467 with SMTP id f23-20020a17090a121700b002908d35f467mr2948933pja.32.1706086714960;
        Wed, 24 Jan 2024 00:58:34 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:33 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 0/3] virtio_net: Support the RX hash XDP hint
Date: Wed, 24 Jan 2024 16:57:18 +0800
Message-Id: <20240124085721.54442-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu and vdpa (mlx5) support it(potentially
vhost). While the capability to obtain the RSS hash has been enabled in the
normal path, it's currently missing in the XDP path. 

Changes from v1:
- introduce a wrapper structure to preserve virtio header

Liang Chen (3):
  virtio_net: Preserve virtio header before XDP program execution
  virtio_net: Add missing virtio header in skb for XDP_PASS
  virtio_net: Support RX hash XDP hint

 drivers/net/virtio_net.c | 102 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 12 deletions(-)

-- 
2.40.1


