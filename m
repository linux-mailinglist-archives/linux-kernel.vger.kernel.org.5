Return-Path: <linux-kernel+bounces-99162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FC878455
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A0282F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7574779E;
	Mon, 11 Mar 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPlFA3HQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2C4503F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172751; cv=none; b=HaDI/fkSLjoC7MJhNLG1uPw2ivEFihZQXRE56qqV9Qy+DswLIEsNXxn/A44C/Xma7U4SSF5viAxipqCCgTx5yo+a6vbC5c98wXS8NBeRH8Aoth1gBjspbI3kiMxnNMo+T9De/cErBqGVindCD6kWGjF+B1Nw3iS2OCzzn10uDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172751; c=relaxed/simple;
	bh=18xX4OvWa+leBjLCZv7ewn4yGUE9xohPXWWIi7DpOLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAWgI4JiKYqk/Jk5hdOOL8TsGGqwhWBwjtSKxp7Qi/fmNUU7d1BOO/QVAbTSQ4sYm9mHhsiPcbmRzMwqGoqQlPTmZeBOlvm7/ApuCliTf8sUYCVD/F3xtk++2Q6CcRoPAn9oYyucS9X2ftEj+f8FmWzHfLA/ai9fvBja5dfmgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPlFA3HQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710172748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DaVe9UI/74uhr3vyv9Mr2EI8STk16ojBYtV0kWhR6s=;
	b=UPlFA3HQ7cIxVDsQJcOWlRZHKlrn+pKQDD7fIp8nIO+B6qwe98VtnIAL6unfrBQeS3WIs8
	4cRvT29+gqS/2jisjpu37gNxkpa/AKr4+M0qKJt/szm4uFCX7EFC83ugU9fEBxcom/EP9Q
	qgwamYn94P9+idAY3dmDKS7ns/M3iZs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-LNBdpNHDOdCF8MgVYOe9Cw-1; Mon, 11 Mar 2024 11:59:07 -0400
X-MC-Unique: LNBdpNHDOdCF8MgVYOe9Cw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d8d208be9so1976055f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172746; x=1710777546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DaVe9UI/74uhr3vyv9Mr2EI8STk16ojBYtV0kWhR6s=;
        b=Vou6NE0q6u3GiUl59jUJ3sQwtnh5J3KL0BbO+0BJ++C8l8kHLqBcyhkJKelxir2sBb
         8asqupqQPdZ2q+g54L1JOOVTYHOxCxx5qEFSIQGEBCiEHvNWE287ds0bCb74T6paWeiq
         lzzAZg4cpWiicEBSUA3AO8upMqKCLBLByk6fr+HPP1bxJXZXvFPekoYPSDi8W3x3zTgR
         uDHsX5pZfyYuDKNo/FpGNjeN7/MLOR3ObF2Xe/ayaaxRimT6JnwvyyBxWZ5biYPTvwyG
         GyxjAcNPShUm7rtNiTEkfXtjxDXItCS67LjdVlGUODEfJrHRFQZrCkrRwG1I1PsYb2e8
         qVSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6wJGG+AuYICQRivIdAvzLj+gUK7ImxbvU/m7N3XUe9dClIfjNnqmgzN7GSFVq+kmg4V8bKOsLT5XJgT9gbNm1stue2lrpbPKmIAFU
X-Gm-Message-State: AOJu0YyfuoZNsHKGNzcRh5o4tg4kQtIXf4TfMt7fhs+eVxAwwzzTJ2PN
	1udDtBhSyfWWMBEFqGMFoEuPloP5g0CW63azXIel6qKbsvJxp5gLaxbACjtMqMZfItoNJDQ9GNj
	T+OkPCum/8GkpvLStzR7163nXagfwNaOpa26LCnOeY9GiiXZwNeG/nh05PxuHTGh8+RSbqw==
X-Received: by 2002:a5d:5266:0:b0:33e:7bef:8ac9 with SMTP id l6-20020a5d5266000000b0033e7bef8ac9mr4426684wrc.42.1710172745899;
        Mon, 11 Mar 2024 08:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAohlcaa5hCeO6/rNdnXeWXIrJX3SzsKOW0z/TCgQ3k78FXEykJ0N240bYuJJMlujXGYrRJg==
X-Received: by 2002:a5d:5266:0:b0:33e:7bef:8ac9 with SMTP id l6-20020a5d5266000000b0033e7bef8ac9mr4426674wrc.42.1710172745566;
        Mon, 11 Mar 2024 08:59:05 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:89a8:bc00:4f1a:435e:d5a8:5d5a])
        by smtp.gmail.com with ESMTPSA id p12-20020adf9d8c000000b0033cf60e268fsm6774274wre.116.2024.03.11.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:59:05 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: 
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: Document requirements for driver-specific KMS props in new drivers
Date: Mon, 11 Mar 2024 16:58:58 +0100
Message-ID: <20240311155904.323488-1-sebastian.wick@redhat.com>
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


