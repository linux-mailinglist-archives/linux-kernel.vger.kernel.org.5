Return-Path: <linux-kernel+bounces-75068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2685E284
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD0B21AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C7823B1;
	Wed, 21 Feb 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgLboe9B"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD582D8B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531364; cv=none; b=WdFT9HzVJPTv6rzk9RLQsqH7RWVnzgGo0otimGhvE/5Ht59GTa6KU45c72fdUd8ax0tp+g4GAdvDk64QtiAZug69gdq4bokncuHCcPOa4okUbMGx/wi/kGB9r7MhV0sYSOnbGrsf2oZ/SUBXK7Q3o7q9wiiWh1ZGxrJqkYP0QDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531364; c=relaxed/simple;
	bh=e7qm5eiW5ti8yJrl72MZC/g4CHZO9+imwD4cHOXfYkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JeEQekme3twHdtvlv+a1WNxw8h5RSL2WthFOlMf/Z1qXu+UMfZpfCNLqt5FDY+ezX/o41px2msOXf4Mzpiat7eWKEMypZs/79kHWZehtxSf7wqgSkLH7dBmA/Y7z+Mo3ZFiaC//z8+So+BtcT5GX4nCB/kovO/ks9rKKPcMJd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgLboe9B; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso3965885e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708531361; x=1709136161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnqnjQDU6WxVzzZ+ac7V7PyPPfIa26jAPZrzYY3D8HM=;
        b=cgLboe9BX/f5X5344EogEbINt5fc+NHzcXiiFTuYRq/U46Ulu0ljPZnOGpRmq7VseC
         LBTOq0XQF3c2ics9lNjOhtJJ7YrsAGBay9SHnIjldbQL7xhA0yO15TfEoxISkOZKLU3k
         1Bi8RyAs9EQAROmZEBN996+bumWE8Ggp8W9Dav0QmCaS4kaCZZTzqnOuoKorc8ymYLbN
         p4OZc0jv7YLxN/DDwXF5J+yxJYyb9vFJeK/l+/S6fiLk8RswFZDhUx+Et2Y8r9yeAN2J
         vJTtXsNZskjt8PfENXnO4xiEabMqrkm1NFxn604H/Q3HGvTCC+5A9tcfxwA2Ndf+SQ5r
         sXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531361; x=1709136161;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnqnjQDU6WxVzzZ+ac7V7PyPPfIa26jAPZrzYY3D8HM=;
        b=kOHBuSNiSfoG0EhXxmYAMagvqvE/+9QMiszlBsxkHZsPQxwPkR4PRKIaNoUqYjlA3w
         34JejE9vEmcLVDz5Ib9lFU1WaPSBj332AXQjzvmZ1qNGJDC3RYWKC8yoGllL2JTXlxsv
         zuo2VLcxN5J0mWcLXRD+Xyl/BlLeguvIXaFzvV3Phd+MWVVktMXIjXhw17VomkFbE71Z
         /fHiiTcfBIxMKIVK6E1ey9JzhP0XGbFP1CnuYNnBYhkmUeVO78m5prg3a2leqJI+AhGp
         bdNhTeJOzNZJYXfKat+uq6IWPh+f7FL2oq6sBfk3LpY1jMvpIrRAPDTvp/wr1rpdISlA
         FYvw==
X-Forwarded-Encrypted: i=1; AJvYcCU3v2ILehLD2CwBS4E46u/zuy3sU4yI4qt3ZkF2KGQ+PFRh4R4nLAjIMxesC8SY22KMUk/bPiXPMECPIJ5Yn+KQL8rwI6yjoxtgxA4W
X-Gm-Message-State: AOJu0Yxc5ZaSn6enika7hLqX68qSUFiOMbi4SJEVUPrBtiFiHW6iK7oN
	uYq14Y9RdLjhu2VhPGgpR/MN38BUmPoSTJb7QXhVicAIItIf69t8cNxg0mu3MmqfQrjjpWqy5in
	VuStsk/44zQ==
X-Google-Smtp-Source: AGHT+IGyGabF+LHiG1n4tuK6dy+R8/udpYeRM3SpXuvYBxKMLaSa38Huig22OKd177ctxAO306bDTgPWtaTLDQ==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:a399:b0:411:efec:cf6d with SMTP
 id hn25-20020a05600ca39900b00411efeccf6dmr101907wmb.3.1708531360602; Wed, 21
 Feb 2024 08:02:40 -0800 (PST)
Date: Wed, 21 Feb 2024 16:02:11 +0000
In-Reply-To: <20240221160215.484151-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221160215.484151-6-panikiel@google.com>
Subject: [PATCH v2 5/9] drm/display: Add mask definitions for
 DP_PAYLOAD_ALLOCATE_* registers
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Each of these registers contains a single value, but not the entire
8 bits:

DP_PAYLOAD_ALLOCATE_SET - Bit 7 Reserved
DP_PAYLOAD_ALLOCATE_START_TIME_SLOT - Bits 7:6 Reserved
DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT - Bits 7:6 Reserved

Add definitions to properly mask off values read from these registers.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 include/drm/display/drm_dp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 3731828825bd..9dee30190f14 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -733,8 +733,13 @@
 # define DP_PANEL_REPLAY_SU_ENABLE                      (1 << 6)
=20
 #define DP_PAYLOAD_ALLOCATE_SET		    0x1c0
-#define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT 0x1c1
-#define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT 0x1c2
+# define DP_PAYLOAD_ALLOCATE_SET_MASK	    0x7f
+
+#define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT		0x1c1
+# define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT_MASK	0x3f
+
+#define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT		0x1c2
+# define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT_MASK	0x3f
=20
 /* Link/Sink Device Status */
 #define DP_SINK_COUNT			    0x200
--=20
2.44.0.rc0.258.g7320e95886-goog


