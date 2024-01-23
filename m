Return-Path: <linux-kernel+bounces-34526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DF837DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D565C1F29A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6A5D8F5;
	Tue, 23 Jan 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPh7dFco"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED21161B66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970185; cv=none; b=R3b2ajgUoSxL1d/czXVZJoJV1ACaSfodr0y5tbq9I7ZiIUOuaA4+xIE1ckm3andF3geKJHkjeT8Pf6U69IPs2twuqeCSIuANZY+ilVHY7//EoQwOt4aI//hMKv3U/zyyZ3Z32JY8gZWa+YVwnkRuwb+tENS/Y7n/EtkdG+9hfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970185; c=relaxed/simple;
	bh=TtGEKwfEht79ULnpSVJcOtpH1GzIiQlRdhb7ZdKErag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRie3ijnLmChFojNEXyFwENULSIl8KV5J/r2vT0ex0/LdhM5ElKxf9ArOjerJ4YAaoJkJNEoRahwUjst0kRCVL777NabOZ5NgBvn3q2QBbVyEZvkh3H6VFGnUXxNfAbz0qqMeMmO66Oz/32Y/84zWFgPn6yAzhnw8TqczDbwMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OPh7dFco; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d73066880eso18990505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970183; x=1706574983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuAginudDA34iqBrsX+BzE2nEMittQE6YVsuxv2qKnM=;
        b=OPh7dFcot4hsOkOMu9O6mJSAyTClh286gsa/W+PyfBaIdKcbw+VVCpwJj7yN3euPlO
         Y2LQjVKa/eRV5AtIcJutHCKE2fLswheYhQrP7Z+ebdF02qSWsiU8RC+O++iqa6+3N/or
         k2PPeSA0wE8D0skn2PNUtT0d+W32zUqrFdLl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970183; x=1706574983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuAginudDA34iqBrsX+BzE2nEMittQE6YVsuxv2qKnM=;
        b=X2grrb2a7fbGwV0GjsA3M1eEgSlc2czFRzPUkXTxQX7sC7WGDX5jICZMx0GoRX/6SZ
         7GwaSw8WbT3TZUXCbeQAr43CDAwIKjjeIyy+wKhqMHDmYUJGr7ODB619fTL/p7Lh6Px6
         Qu8GgVJfeLM4EPCHXlQdBD2XDkMEkADPDHj6Joi+HxT8ZOcD3NWzK72zMZciVPWjUXL1
         VdlSMCaNiY8aUDdJLBYklP2S+9ZIZ3QpJHWYfiEJ09Zd93BQ6ZIr6J+KZHPFf+WwaNA1
         gzF9lze8v3+dxLhtJIvJFwUX5T+wjeCFGuKUkjtzoNmbTdjG33AEU8pxkFUL6H780JcU
         XTgA==
X-Gm-Message-State: AOJu0Ywve2Is98o/9NyqfI+2YXFkvJirWFfKF8z6LiIFYXrP9vfT92jK
	FagHVBgvYn04cVMxrOnEixo2hEGrgqvNf+mXMyNPx4gjJte77eq39beQMUkKkQ==
X-Google-Smtp-Source: AGHT+IHmJXE2ED2RuBUmR0soC9ICbU5uc/OdRD47vxh5aPLnNlxEs/5VczOR/qkUIL16NOENMz9+bA==
X-Received: by 2002:a17:902:8216:b0:1d6:c8e3:c3dd with SMTP id x22-20020a170902821600b001d6c8e3c3ddmr4942676pln.54.1705970183007;
        Mon, 22 Jan 2024 16:36:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902e2cc00b001d70af5be17sm7341961plc.229.2024.01.22.16.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 36/82] agp: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:11 -0800
Message-Id: <20240123002814.1396804-36-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=keescook@chromium.org;
 h=from:subject; bh=TtGEKwfEht79ULnpSVJcOtpH1GzIiQlRdhb7ZdKErag=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgH4FFulwi6BUqjbAU5ENVQabX98Dt2rrVoU
 8g3IEj955KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JnjyEACxi6nRzG/TeUzgA19psicAHgLDAObP0xBS4txCdCyuwD6vql4dHmloNCeJb8mV6QVHM+X
 qtG2DBYHCOfOAx2qlY4HvaVOj3PS5bcfXi6Ekv9oHApUiv9VATvsHzJMWgozbnrtd+ct/kzn1a8
 fdEqTsjCD1glzm7trq2UhSUjq7L9mf0ALUL92dfVjQVOuW3SJ9kkPuGgKtP6JPssetdPnVNENjg
 XGHgUvZbr7FjFWIbhVzk+QWvKkDn9x87RdguxM3yRMNuIU1rIPChiFeHt65F/fM9e/r6JWSqDYJ
 28GyQyB9g35uGguB023JwJmsj9WljHMy92O0442XwofQsjSwDoKiP6XK1wSn7N+Ko+xF+yXuo8D
 aGTAXPJpuMFj3tqUwX0bCJ2y/hZb9LGM68ygSkbs93I9XePUe38ehnUMIKTYBoC/PaH9cZiUO6O
 WpdtUG+wfYRGfiUetrFcgMqg7lc0bO2mieV7z8f1+ggx/2d+E2Yn9c//8JCWB6dDf3AOuNluFkl
 TPJTxjpslLZOCOHw60ZZVUW2p1qaNmoLXFmR7hSnVJuahaP/u15jWcSK2aizZflJKuj9uo7I/Jr
 iZ5+yDhNuVtMJrnevFhrq9ZhFajoLgGALCe41lhJERcPe3APaldrX8Abs0cIpjFwV5xN1XNAYND z2z1RVstb0xjjDA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/agp/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..fc2d07654154 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -228,7 +228,7 @@ struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge,
 
 	cur_memory = atomic_read(&bridge->current_memory_agp);
 	if ((cur_memory + page_count > bridge->max_memory_agp) ||
-	    (cur_memory + page_count < page_count))
+	    (add_would_overflow(page_count, cur_memory)))
 		return NULL;
 
 	if (type >= AGP_USER_TYPES) {
-- 
2.34.1


