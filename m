Return-Path: <linux-kernel+bounces-69864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C2858F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4B1F22BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11457A734;
	Sat, 17 Feb 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6RdCY2V"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD065BCA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175577; cv=none; b=DtN+hx5vIObrvaBzlqL90S0+mC7hICp+enIWlZPNySzJfr39zl1rMvtzOfsztqA03xIGUESc7mbo1nttTjthXUrLTfsIijVKTBLPkabXVlCHMCGYDXuLt/DyK5oPQqzaA6Wd5XtMfNqNhFNo6h4rCrrjAqj3Ikcf59Wq3r6ZIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175577; c=relaxed/simple;
	bh=uv+QbrLzP37a7CrHeV4opIJ/TUep0+OrZ4+uXd27OKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kWlS7n8cFFWzv4T022p3lgXo13DeMJYIo2e94JjrY07XWNDSxq01sEFEwBM+F+W9I4NKAO7lKuFPVK6AxsAYuyejjxTh39u5jjRIHC4fUZa7zsY0XRN4OxuFLKPYLUzXoncocShPRfmjvKBezcQSStcQziLZWiISyduYLzojQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6RdCY2V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso4669952276.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175575; x=1708780375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Nhq6jELtlORL5ogz3lCatqW4aS8TpTjuA/JogYOAbE=;
        b=u6RdCY2VGAjdzmYmP/X3s9leetSQlI+AgfSx963NLsWc8wiBSQ8IZcE+YXl9G2nHa3
         Z5KEMVAq57SP9+8VmdzRYSh37lndwpoyQH4qnYslqJ+4ZvSNfsrSJ2FvJHElWFKy5FlE
         o9yVROrBvQlxOv/8OWTDTT+gja/C1mb3VvSQS2ofAqWgHfTAybvHQjeeLv2z9KupJbeV
         t5EYy+9inp+V2V/a94zq35JyzB4scW/so2tn/12+5ipDWLcm7uKHb0IWsY//2pqRzVIW
         ZbPtAHjanzMopU5Iy+nR99dURoqC3klb3wuPammo8WOpdl9/IpfAVxCevLzM5VgEop6f
         +0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175575; x=1708780375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Nhq6jELtlORL5ogz3lCatqW4aS8TpTjuA/JogYOAbE=;
        b=hKPA+UrG9YnjbfLitf/9B81v26oSSknAiGmWCM8yXOKzOmXrVpAgSExtfMzjLlomfN
         qaBHQHP8twk0DyvV/QGY2VQiMgO7brnM0rcHxN6f6xwaub6BZomOfqfFbKfWF15oohc3
         fE85TpFZNp4F80I72CUGirmNvxXCCXOYB9Lu2K3KrMo+D1RLEos7jyBpOD4ONhxFgBgF
         G9a3TPQ9EYCrbwBR6A5IG/3TkZWoPSbGKLIuB6mUPNcODLcHqWnptJU35iZjSAfR4eAc
         MG4sdi4h2Dzmwn0BC1LZtGn6Ql16G3PH9dqvfEa8Li8d40EpBW3jo57Rxd5PHCLmy4X+
         Yb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd/pjl3DRP2WlHCgaAWW4ItbK4JOs28b/CDz/gktVbZrmvODgcCkF8FbBUgIHyT68dTCEqZRAUw82hcfoV6CQ5Poz96IYweQQbW7Is
X-Gm-Message-State: AOJu0Yyc84wqbfCi/+MGOPn/q/MKtX+STegHv+Xq89LX09mns9CsXOM5
	HyTvhBYKlZdMsYUo+M+6ebrozu1WOTV7exQvhdRpVtaqDcZJSfTBoNjX8h9Yq8EMhCamnQScMyv
	ZRQUU2ccz8Z77r4lzAQ==
X-Google-Smtp-Source: AGHT+IELhbiToXabxhoUii8w461MsVDnMXHO661y+j2h5Y0RY6bmJ1OQ3jt3aXw7K1MJbxPyaQkNPeYOrWzAEoyD
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:2284:b0:dc8:5e26:f4d7 with
 SMTP id dn4-20020a056902228400b00dc85e26f4d7mr1779458ybb.13.1708175574920;
 Sat, 17 Feb 2024 05:12:54 -0800 (PST)
Date: Sat, 17 Feb 2024 13:12:49 +0000
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217131206.3667544-1-ericchancf@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217131249.3668103-1-ericchancf@google.com>
Subject: [PATCH v6 1/4] riscv/barrier: Define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com, conor.dooley@microchip.com, parri.andrea@gmail.com, 
	emil.renner.berthing@canonical.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"

Introduce __{mb,rmb,wmb}, and rely on the generic definitions for
{mb,rmb,wmb}. Although KCSAN is not supported yet, the definitions can
be made more consistent with generic instrumentation. Also add a space
to make the changes pass check by checkpatch.pl.
Without the space, the error message is as below:
ERROR: space required after that ',' (ctx:VxV)
26: FILE: arch/riscv/include/asm/barrier.h:23:
+#define __mb()         RISCV_FENCE(iorw,iorw)
                                        ^

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v5 -> v6: let this change to pass review by checkpatch.pl instead
of overwriting again in [PATCH 4/4]

v3 -> v4: fix commit message weird line breaks

 arch/riscv/include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228..173b44a989f8 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -20,9 +20,9 @@
 	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")

 /* These barriers need to enforce ordering on both devices or memory. */
-#define mb()		RISCV_FENCE(iorw,iorw)
-#define rmb()		RISCV_FENCE(ir,ir)
-#define wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw, iorw)
+#define __rmb()		RISCV_FENCE(ir, ir)
+#define __wmb()		RISCV_FENCE(ow, ow)

 /* These barriers do not need to enforce ordering on devices, just memory. */
 #define __smp_mb()	RISCV_FENCE(rw,rw)
--
2.44.0.rc0.258.g7320e95886-goog

