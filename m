Return-Path: <linux-kernel+bounces-138478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B649989F1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA92825AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47615B13B;
	Wed, 10 Apr 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK+hBT71"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50B13D607
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751615; cv=none; b=ARYy2flZwSvZeFdLVisjze69RXazC5nVJdbwE/FVpzmQGaivRwHtjg962gBSomlA9/cgqT96T4QzU6nViDSWmjOnr/ZmrA7iYaBe9PapoCH0N8aDtB3MTHGfyioJvLbP2wdeb/4d/JlaCOOHsNqDqjs7JPMLWTpA4tNOtIuBFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751615; c=relaxed/simple;
	bh=WSpt8xkQ7FZzxGK2ztd6X59nvbk86bjDxsC7WRIdaw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLzg/1HOqlg5OieQ3XV2AeVHtLuDYvwrHmYWjt5S9GXYogRiKUCZjKJp9Q9aAJNYCRwlJDp3lMlBt/eNXbfboAJiCsSmjG7ku736yOeVlvwkW0yQjbiM0cOm8xWs+RmDIneiI5Ilp9KLbxo7kJQuhSKQDyWo0T4B/d5EL2XRuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK+hBT71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712751612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cJwZCdGn/12kQ3EbOPpSAbOJTYEctOWbdv/HkZkwxS0=;
	b=RK+hBT71G2gr1qQ3mjumZIGVvesheQHA38/uV9DQHNwh5sOp00rUlz9LzmKfg1DG4YgrLC
	oMmch/RKyNDQV26V1Kk7mQeDWXubUqrVIoqBZce6UHINqjFPgVPRV4aMRJJ1dqGmvs4C4H
	Vl/i3Z6W4NZ8wNXLygI75e8rcmzFsFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ucDAiadNOb6VkYoZwMs24A-1; Wed, 10 Apr 2024 08:20:10 -0400
X-MC-Unique: ucDAiadNOb6VkYoZwMs24A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343f1064acaso2350846f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751609; x=1713356409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJwZCdGn/12kQ3EbOPpSAbOJTYEctOWbdv/HkZkwxS0=;
        b=T346J0mhQpG38KdntW5ycZLTp7bekbGh3Nh3j644B4JXIQSr8PXeuFw73VFmzGYu0C
         vQIRLhkMQD7N5YmppUMujiBL1dGao2Zn+MlMAvbGNvWHBu4f3hAOla1KR8T56LVA5QJp
         2VPI2i/8bbAViRa3XGZe/NZTLLU79jIPpsKc0AKDUKWfdellMUUWyPN5h0kdCRNHHYRa
         rNYlunvSzoGSYcjFx5Sutgz0oqZiScg7z7wtstlXaPvvwqsrhUZf35Dn2okMPO07fuNq
         dyLlWMMdHjbzzguiPWJZ9JbvHdfxRqNta2Fcr5O6oK3zDiqz9EVzH68J4L74POYykdKN
         tuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKbV2CmBE/QN+N7pekrb/O95bdViUJSbEti0ivSFNYw3HdRH8JQuGDiECxmfwZR0AmlG3kQwQRCP+lTpcJw8HsSC3kftzlYvOesgp
X-Gm-Message-State: AOJu0Yzxq+0ztH5sf04zB7k7dLqRuazUYGXuA2P+UIX2ESiPYtnAMjA/
	tkxcL25VRo0RwKfdTi5u1LZefAYnL2XJmxE0Ma0X3SuUa2VGA+gTM0PYQcXXRH4Uo6G0e/HtCdH
	ZKc1ZH7VoQcpAzb/1cchjlvrMRhm3UJ2dp2yu10aIbCHg1QeVxh+4/PDN/1bOhA==
X-Received: by 2002:adf:e7c6:0:b0:343:96b2:c121 with SMTP id e6-20020adfe7c6000000b0034396b2c121mr1792552wrn.63.1712751609495;
        Wed, 10 Apr 2024 05:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaEsfMBRsLWsO8CaeP+0eZlxRSkArpY8F3KRxzPp8gsPyxbWZ3n+PeTBB4gyznMOHXT2ieZQ==
X-Received: by 2002:adf:e7c6:0:b0:343:96b2:c121 with SMTP id e6-20020adfe7c6000000b0034396b2c121mr1792531wrn.63.1712751609137;
        Wed, 10 Apr 2024 05:20:09 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:89a5:e800:aa3c:ae70:b589:bfe8])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000180c00b00341de3abb0esm13678098wrh.20.2024.04.10.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:20:08 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2] drm: Document requirements for driver-specific KMS props in new drivers
Date: Wed, 10 Apr 2024 14:20:06 +0200
Message-ID: <20240410122008.38207-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


When extending support for a driver-specific KMS property to additional
drivers, we should apply all the requirements for new properties and
make sure the semantics are the same and documented.

v2: devs of the driver which introduced property shall help and ack

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 Documentation/gpu/drm-kms.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 13d3627d8bc0..b98b98359c90 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -496,6 +496,13 @@ addition to the one mentioned above:
 
 * An IGT test must be submitted where reasonable.
 
+For historical reasons, non-standard, driver-specific properties exist. If a KMS
+driver wants to add support for one of those properties, the requirements for
+new properties apply where possible. Additionally, the documented behavior must
+match the de facto semantics of the existing property to ensure compatibility.
+Developers of the driver that first added the property should help with those
+tasks and must ACK the documented behavior if possible.
+
 Property Types and Blob Property Support
 ----------------------------------------
 
-- 
2.44.0


