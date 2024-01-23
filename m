Return-Path: <linux-kernel+bounces-34489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7A837DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0FB29F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87B15B114;
	Tue, 23 Jan 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LXDP5Rb/"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0F15AADA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969752; cv=none; b=L3uoUBzFI9iGYAU2Tc8PGx5IZKWV++zmXxE0lmSCn4eiNGcPlu4kZw8rxbMx0MkDJ2vKYOwSf4WT4kSFvgv9N0rT2+aCVu61sG2BZc6hMsVdgB919zIEXz75mC0BU4z442nDCdv7HR7QKfsCB7+0OXrZL73q+m0aXC1edQ3h16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969752; c=relaxed/simple;
	bh=sfFm968ER0g+7mpUBiy9zsTjSD8V36BGzdg8Ckdsgr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2Qwt8VOlDv0BktF5aFvSdEK8+vMEsmMqr7QnrTtnKb7us+WXaAkT0B4H8IzbV0WwzBgC1+dVPWyyHtcE2lzCGoXbpSRMcqfGgnQZR7KKvRw8JVLmme0oQ4fr5ePCxb1CMOozWc/PInPmdTzHoNBiVdfKsbt1Wg9qOESJ/C8vCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LXDP5Rb/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso1718952a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969750; x=1706574550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mLSKitlZEHkOhHFi0dPXu2bMCmR94CcgGqjj67vCaY=;
        b=LXDP5Rb/nU/4aB5TMuWOFdFA2o4C64ikbJw3TuTi7RptJKH4zfl3RJ/OR31Vgy6uKv
         ny7OrYLKlFNheIZqyEHQcj5u4uE36ChnU1gK1WdxNj6Q0mnvgw2y9oM62WGuEP/o3ZdX
         NpzMGzV7/O9BRvleucSJywBcIDGPxUjhW21SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969750; x=1706574550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mLSKitlZEHkOhHFi0dPXu2bMCmR94CcgGqjj67vCaY=;
        b=wjutT3GBQppx49m5Dn8NpBoabugRKe5z0GtuLDLu++NTesxan/zj3QCrIitRsegEI+
         hoxOZE3kionIWaz1zI4TZ8bk0ByPQZe9f7vxY02BehcTcHWkaA16WrX4ktgHnIZ41rEI
         u/yceoP8EF/CX9cuB+k3ZYY7S2KVwnA1AIRskqbPnVACKIoHnooadd2wcukQMaSBDiL+
         BIBbwjoPMtNSCr32TNpJFjQFYp+xX/IA9U2DMEEJ2mPIUhU6OvMfwy40VPXXyxvMm2DG
         gQ12nb+Nubjms0GWpsSh0oPSwqgcirERQDFe2XfO8otvPhsXDTFqlyBbGJpiJj4cmOtl
         5ABA==
X-Gm-Message-State: AOJu0YwMjGbMEXmkXLV/lGZtp7pEh9PcO2ZrSRmOUGy+VdiCpXCTpxKX
	txgot6uIlxXHf1v/MLoBuM2EFYMOLQJsnvoIL/mMsSlD6NRRRN2EgRkHEiWrqg==
X-Google-Smtp-Source: AGHT+IGrY9MQG0ft34pGrqx+WgVWJ0LldxehDkYnLe9iXGm0anLbICr1j+vq5RPEd47+Q6ZueeEblA==
X-Received: by 2002:a17:902:b112:b0:1d7:56c3:75f1 with SMTP id q18-20020a170902b11200b001d756c375f1mr1421910plr.122.1705969750268;
        Mon, 22 Jan 2024 16:29:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001d7313140b1sm4196654plc.202.2024.01.22.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 64/82] netfilter: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:39 -0800
Message-Id: <20240123002814.1396804-64-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=keescook@chromium.org;
 h=from:subject; bh=sfFm968ER0g+7mpUBiy9zsTjSD8V36BGzdg8Ckdsgr4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKYkU8DxU6eHYCBe6vz1zpyDMyVzXW4j2c/
 6DTcxcBaQmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 Jp+AD/46wcCh8Srst3UxH7Lyw5MG3LkRtUVrmbc4rNc6HLYVkN5hxDPTfR5v6ZnbYvrcY3DfFpt
 9WMJVlg/jp44Mqk4QAkWuEYAizZjTv5lwBrLJOeC0uq3FiRv7sFMT0ulGhCS+VYVkHlA7XB7vR1
 MmG7M2/24UnH0N9fZ+7JPMVUY+pYnS9hlrpgB4se6e1XatYdKRe2/iEGCIksdXmXkaoRwEhS4OD
 7E6W9aO9/1ZcsdkripFuDU6Y3ZnXOZs6n6L5M3IJPMlx9UyB8ALK41BlHPkbDbifHKGXVNmhOwb
 HmzFCqfvx56BB+0Wh3YImRj5SPxxhVIOXJLg2SL9AnxsfGlenBYt4PsP/nINeqRoK4SriXQ1ZVx
 A8F9g7q/0fYbNlWOGnAaB+L070tVt1AO03SkXcHssyCHMj67illZ5F11k6WXyTTH/TBv56WLUbL
 sqDjoJJaIFkU07SIQBRNMf/0pn2aDjru0143ldKfWm6UgeWUDGzBPLBuB7yCSzZTpYK7QjmIOux
 jZNgE79r+yrBg6Cn7T5tXCBAkoRDVLME8tHidPdZGNKe0EAfi4WXXvVEwHeYboA8DPbIal0fKFl
 48oFeI2TLeS8cWHi576qMGc07tAXDixqU5ocHqyWj62iBwljid0v9hV7SpV2DTd13zjC96ftjzq sT9zNmIYvbNtyUg==
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
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/netfilter/xt_u32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
index 117d4615d668..8623fe2d97e9 100644
--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -58,11 +58,11 @@ static bool u32_match_it(const struct xt_u32 *data,
 				val >>= number;
 				break;
 			case XT_U32_AT:
-				if (at + val < at)
+				if (add_would_overflow(at, val))
 					return false;
 				at += val;
 				pos = number;
-				if (at + 4 < at || skb->len < at + 4 ||
+				if (add_would_overflow(at, 4) || skb->len < at + 4 ||
 				    pos > skb->len - at - 4)
 					return false;
 
-- 
2.34.1


