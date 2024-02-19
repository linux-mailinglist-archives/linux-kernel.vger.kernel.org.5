Return-Path: <linux-kernel+bounces-70761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21573859BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C871F2100F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDDC210FF;
	Mon, 19 Feb 2024 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtXgDuyF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F020DF5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323073; cv=none; b=mQlWInRMfnUp0xaVGdUCFaqKCfB7TZ6sxdD8Jq6/Dvr4/f0MG+dBLdMh0K4dyecwSyG7S7K9b7qIJsYYga4Kz3+96QJJu0PIiAuGEX29odcIZnWC3X3zX0Yu3wuz1MYjTAS4mOeCufj6LHfhLmyzBHdx1QugHz4bUoymFsDIZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323073; c=relaxed/simple;
	bh=6dDfDAz5I+hc4k6dr0zdna9LjUyhKmw46b/4NU8Gsds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Av1sXXiy+pTCXxpPCZu8cbXSIhvydct/9MSD6OW+ZuaVevZ3L9TQhYddsm2DO+KMjkXxddWeshe4YYcIZbtdlOAECgRSJUu4KVs6KjYHsX0og7+wynktUjarLo94Iz4nxWkDtT0d7ZOd2PYRZvCEfJrR7CsAV6v4QSTaqkoHxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtXgDuyF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607cd6c11d7so57346977b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708323071; x=1708927871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGZJ8u5lTXI5mGL4r7O/a3CozSV5U8TTkXgiiPZhXeo=;
        b=TtXgDuyF/O0tiHAWvoEN0OrrSKeCowgZmbHQ3sq0ld3lS3+GzsG+iBjox9C7XuHTN5
         DsIbCvg5B/jNSKWUcHarT5vt57lkJoSbE4qyJp7+WtWuvAG5x9g/iRezsCOLNpIWqzjJ
         Z6GNVYWhLwGrgtun7WoZAMmhMpE8CIOoInXMzCgHxG3Nv7nrgHveKwxm0w/k7ZVWOdP7
         DTiLuH6gS16K7aX1PPAsmsOmqheAGVh61Ar2scjQWRH7hKl9+wDxn2JyJ7tbDpsGK7Rr
         NCX3gBykPKK3X8VjRxpjps84bjVi3Jlx56KZxS2oWeAnv1jKaB5bIDq6eM1oC7MP5lMJ
         Bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323071; x=1708927871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGZJ8u5lTXI5mGL4r7O/a3CozSV5U8TTkXgiiPZhXeo=;
        b=ZhNhtBsupA6O5UNF5ZpAQTG0EfLNiRHcu888+ItPwV0C5uSaE/MOFC7aC0dvoHr+WX
         Ke2i3ov91tQmdc2APumTpYOmzrmMo4XK3rknB8RTu/rA8Uk2Sc6AFrJfZadajGp/O7vj
         Fle9xZVuy4LkUEI+n3b5nlC+ytXLko/N3mCxVRNturdTMr9BT6Yt5mTlooJkMlYSBa4T
         quCHNRwzj8ttGNWw5Noe172Y8S/8iH0omXgHJ8FPm3MTjPqYxXOgOipZxX6PJRgzsxAu
         ruv/KDB0FdJHzoxCnlPIVja34nAVwgqccylZ5yUBE0v7SAKKfM323JmfNn/zPFBxvAbN
         feIA==
X-Forwarded-Encrypted: i=1; AJvYcCWhkz1P3E1ahRMoL3Pvkrhfkdn480zYSUe4aiXGbXs4aKO+bXJMw//i5hN10+4ijnDs9fl/Sa2DMp0WKZwxarjawoNcHZUYH9iNsAtM
X-Gm-Message-State: AOJu0YzMV8c99sczH98DsUVqjgxpN80N4VPHD7Al4CsYays97dd8s1FP
	XMELv5ese/DPOXmTQ2oWslNGTBYNqfJjMunmicVnGqjg3YhmQb5LDhAXc44Qz7CS7WlNOqswVS3
	7421mtA==
X-Google-Smtp-Source: AGHT+IHZtagH7BxHLIkh1QcbT/hFogdlNF7ZRCSon/JkCFDlcOCKCwMiiYdHzhHdxmGNAIdKeM29oFOCWbjX
X-Received: from pumahsu-p620linsp01.ntc.corp.google.com ([2401:fa00:fc:202:c8b2:b71:a506:971a])
 (user=pumahsu job=sendgmr) by 2002:a0d:e2d6:0:b0:5f9:abfe:243c with SMTP id
 l205-20020a0de2d6000000b005f9abfe243cmr1937909ywe.3.1708323071233; Sun, 18
 Feb 2024 22:11:11 -0800 (PST)
Date: Mon, 19 Feb 2024 14:10:08 +0800
In-Reply-To: <20240219061008.1761102-1-pumahsu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219061008.1761102-4-pumahsu@google.com>
Subject: [PATCH 3/3] MAINTAINERS: Add maintainer for Google USB XHCI driver
From: Puma Hsu <pumahsu@google.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	Thinh.Nguyen@synopsys.com
Cc: badhri@google.com, royluo@google.com, howardyen@google.com, 
	albertccwang@google.com, raychi@google.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"

Add Google USB XHCI driver and maintainer.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..dc0e32a3c250 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9081,6 +9081,12 @@ F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	include/dt-bindings/clock/google,gs101.h
 
+GOOGLE USB XHCI DRIVER
+M:	Puma Hsu <pumahsu@google.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/host/xhci-goog.c
+
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.44.0.rc0.258.g7320e95886-goog


