Return-Path: <linux-kernel+bounces-33881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D936836FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4328C5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF335BAE0;
	Mon, 22 Jan 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLhjsgkp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8E3FE4C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946298; cv=none; b=E/Du9XmAGznJHkNxqX1r7iSwVCMUboExxHIx7WG43NpMHaAa1Qh6WVl1v5x5wwva1SMbsbr83rCl52vlLTpsbekBmUDrxIYR2jEJVgvwqdhd0O6bNURzz1KFDSCQqxcW90gbXhGmzNGJwNhU9K/HH45SGecT9dpZ0ALlNa5KQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946298; c=relaxed/simple;
	bh=CkuGyzR0lrM5lkSkD/Qzrv2Ae6T6p+1m5NcVdimvwYQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mMP0hdOJqzma4OmjYUH4SgDyOMtHrApvyxn9AXyhCCulrYl4SligJ7STllyvqZKqDxlJNNX+u3HC6/01/+0IXk9Xqs2UkSsURo1X0vTfUkTuw6YF6DqJLjoDraH1ZjpW9cPPYs+Vfm0UvKk5XgY9yIMbSOwj5ilzJMV5b8WntzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLhjsgkp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f0fd486b9aso40280687b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946296; x=1706551096; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S42orU1ihCUS+k0y1H/3lg3nrFnf+J6Z4OBgyaukGS4=;
        b=MLhjsgkpBA3mfeeLcMWzUytC2w+h0DqJh59yP0yQkl6GqsMGezbzGbpunN+/ufm//d
         C6rrbRe4UeOdJoMcYJX4RCo+ptrxyMeQqO7bJyXBlw3PCXXrJBxP/q9fSW2PIiJKHkLS
         /D/yTq3axMQqCDJcYqUOnI+CGzdg+jQGXrJfICFJ0uXwzpT+TRlRr15lXQzv4kCeWMia
         jJYEyVYTKtut9nqGBP4q+V4O0B2kmv08Cm3uCHL2vuMLs/h8NzpYWUkFu34/vyZyLOCj
         YeEpS+NCUGc9iEUfrvGgx+xQc8nRdt+gTYpSutWsK+dqTVYs4wHDpLJvj7fQgNVslP3t
         NNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946296; x=1706551096;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S42orU1ihCUS+k0y1H/3lg3nrFnf+J6Z4OBgyaukGS4=;
        b=hojpiY9U3fS0aRljjr450Tdu/o41o4UH4IyhdluaWpWUxnhLdHUHFt2rBKpHRft8Lm
         zG9xwnlHfWzPW9Jh+BYVNO+dxgsYwDMrpPcKaWBWdKV75WgIXPLzHhuGtTWA6l3+koiR
         0fmBfY2pXMLquyy+LNTiJd74NwO/juuui5zyVmrRTnCcwS8lrojHNnHtvdepWyNfz5aU
         qKtg2q6y0Yf/z9AplIFwkm2NOI+Q+jwd0nNGliKBD67q710JsBLNS1AojDBXXlXOPGEO
         wS7Ixrc8wzmC62unFF2dTfiPV6FBH8S4oSuTu+1MCi9s1es3vTK5nY5j+eDKr5bUCfuS
         SxRA==
X-Gm-Message-State: AOJu0Ywtklf5QqvVy+dmDccznN72nPhuE7S20aH5kP5H+RormbM/qMGq
	a8QRAydPBRjOuLjllY193kAd6KAuNz+EoV2jf91G37uyY4tmtoMzXUYA3ZjAsYvfnL3ZE/Rk462
	sZg==
X-Google-Smtp-Source: AGHT+IHohGoie9Nz44OT9czzy1k8AqHO/wQu3+j1Oepb2XbnCPG1gVCpJ84TT/z0goGRgpLg6Wh8BREQ4w4=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a25:8b88:0:b0:dc2:3a02:4fc8 with SMTP id
 j8-20020a258b88000000b00dc23a024fc8mr280667ybl.6.1705946296094; Mon, 22 Jan
 2024 09:58:16 -0800 (PST)
Date: Mon, 22 Jan 2024 17:58:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122175810.1942504-1-aahila@google.com>
Subject: [PATCH net-next v3 1/2] bonding: Add independent control state machine
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for the independent control state machine per IEEE
802.1AX-2008 5.4.15 in addition to the existing implementation of the
coupled control state machine.

Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
the LACP MUX state machine for separated handling of an initial
Collecting state before the Collecting and Distributing state. This
enables a port to be in a state where it can receive incoming packets
while not still distributing. This is useful for reducing packet loss when
a port begins distributing before its partner is able to collect.

Added new functions such as bond_set_slave_tx_disabled_flags and
bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
and distributing states. Previously, there was no dedicated method to
disable TX while keeping RX enabled, which this patch addresses.

Note that the regular flow process in the kernel's bonding driver remains
unaffected by this patch. The extension requires explicit opt-in by the
user (in order to ensure no disruptions for existing setups) via netlink
support using the new bonding parameter coupled_control. The default value
for coupled_control is set to 1 so as to preserve existing behaviour.

Signed-off-by: Aahil Awatramani <aahila@google.com>
---
 Documentation/networking/bonding.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f7a73421eb76..e774b48de9f5 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -444,6 +444,18 @@ arp_missed_max
 
 	The default value is 2, and the allowable range is 1 - 255.
 
+coupled_control
+
+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
+    should have separate Collecting and Distributing states.
+
+    This is by implementing the independent control state machine per
+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled control
+    state machine.
+
+    The default value is 1. This setting does not separate the Collecting
+    and Distributing states, maintaining the bond in coupled control.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
-- 
2.43.0.275.g3460e3d667-goog


