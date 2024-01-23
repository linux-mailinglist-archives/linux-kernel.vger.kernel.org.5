Return-Path: <linux-kernel+bounces-34473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1E837D64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5160B25410
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9C15698C;
	Tue, 23 Jan 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRs2Fpzh"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75F155A50
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969726; cv=none; b=JBRh/+kpVbs1tnQmxBPfaahnQy3t92sz/N68JXq3VZl/BPhg8mUZ3LUHfYxKgryxwcGXJS5o9ru20OXg4uNSrI3JMf+D8OMCpuY2K6eLgKwqmjgZyDi62efqfR83zJgATTi4juekeazYqHWiREcTTzt9/kQUDB8pJZ/Y5Mr/63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969726; c=relaxed/simple;
	bh=gNYUL4lkD/q4q2Iw6mvmjCERgWt/Zx4ayDxuFa3qc3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhHWUS4dEZerrtm1zdKnAMBtmFQZ2APWmdw26hOGe9pYgHxwVrjd8RGJ6vTHR0hbMUTu1IyJya0phQVetxeCgtLTpFCWUNdM51uLiPCGdW7DpuuIp5DVjORUUOHJ0G8q1MYc8i4Z9GvpdbL/jutKw6RYa5vEDKe/+kCIw6qNOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aRs2Fpzh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1781870b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969723; x=1706574523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnvzwX4y80p5z83E6IpBrKurnrIIBIFVjaFxfKXwLnU=;
        b=aRs2FpzhVlwpX6B1WZcqtvJnPve6adqUUdPqokmDearzfsvYssSEJIYvCbYUSAeN37
         0Tu6lm0QwtCkMjZvyE6guBPdsh8NHE9CPt1sayLebWOAFOrX5KpPGVZYXmde/2IvP47Y
         6ozI5NtgJjfNtiyyig6NJyZ6KPvfCAyMidGhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969723; x=1706574523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnvzwX4y80p5z83E6IpBrKurnrIIBIFVjaFxfKXwLnU=;
        b=cB9u0kiuY3G1ibkC24C2MJIIchE+sIa6ZFvTTwPDmkY2tRhm38CTmREN2Bo8/ebscC
         wS4LcIh4kHdU1eYc7fbTEoBpPrHptPlzwov3JzRA9IWSKdd8k1gCr6P2lT8xcV0mGTBF
         aIC1O2sSBnv/Hce7dY8EohliScdr0ljunikvvVrSrP8aqyz5iWZhXiHGaHrNmmeyGw2j
         doHWmC7xGseVjPR3M2h8OQVNPXxJTsZ0xXsXMEo00T3r1d03q7/iFKZkftmXlmk9ajYr
         mM3f3i7083qRByVMvcwVL2+QGsn0RHXGXrJfdNotHuZA5Dc8R53hgcLYWpw8ce1osWEb
         67Sw==
X-Gm-Message-State: AOJu0Ywh1492S9lh1Owy9SaBMQK90YbiSx6DOUR0p7j9QoBW0UDoF197
	VlSXYJj+IA3bOZkIH5B8up6yRhDmFqOwW56/2Hqyb2v2u8hY3nM4cWZpkhOvEw==
X-Google-Smtp-Source: AGHT+IHqWbCdbj4COoKXEiHtTaOvD5DiZiG+2we1Qlvg+cDhbkuK7H6vgq1QJRL6IheoOiqRzXhQFA==
X-Received: by 2002:a05:6a00:2e9e:b0:6db:d040:4d05 with SMTP id fd30-20020a056a002e9e00b006dbd0404d05mr2702259pfb.22.1705969722109;
        Mon, 22 Jan 2024 16:28:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00175200b006dbd8dd4d49sm3283190pfc.112.2024.01.22.16.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/82] ipv4: Silence intentional wrapping addition
Date: Mon, 22 Jan 2024 16:26:47 -0800
Message-Id: <20240123002814.1396804-12-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=keescook@chromium.org;
 h=from:subject; bh=gNYUL4lkD/q4q2Iw6mvmjCERgWt/Zx4ayDxuFa3qc3A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFvlBO2la5fghnKIu98p+FkONV/wNVLTQSX
 IKk33CsfLWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 JrmBD/9kKc8XzjSQWEXd+h2tu5y1xWCQNfVqCF8dPAmWo/5I58GZuuA5f0M1dCs8yLp/C8K+gn2
 VK1GNKHkGaTKkIuLqGdzPCV6K0KdIFC1RD9GWJCaPAKIH1ECgMvXF1pdJPgU3nVMvA5aEWn7S+l
 Yjz26ICJMWCYFnODX3nnptzdaOXv/giXZfGfPsfy8GpjWspiOnSLvKAzppic92dnlscOIYhAdzB
 qqh+Mxo7z04JwgzJT1sPoc/t0TRsmfabuJshG6qjUM6EfsCHUR/hBZP1TByMomhhjKZ6P8/pTxI
 bNZF2LT8ST8/uyEx4XzId+YeMdS66RVCa5tVAuWRQBXXzqAaDWExi+yjj1jbgBReLolsbbuOSc4
 yV+wC/7eXE0+vH6mVN2Vnae+iO0BS/UN7WUy3GJ7VJK/p+fNcuwOXVW22rI0hu5++1l09g1KUdJ
 WNNuP6lgZITL1NcGzIePLIoHjlXg2Ojobu//ovxGxWtoOoYX95DwVrnDQpO2sC0OVjAIuDgdOY4
 GOflLXPfmQWqRL53HgQNsFra7YLRm7D8mncQQRH+32SCoDsTrX+MFpKEkWwLraLheDi+0D+NjvT
 BV5/C9ql6p4WXJsvsGJB9Cu8v2eZ2Z/mv0OAWOuD0cNL8umP0Ps9I8ak+NZ7xOs+drWeBXjzu1k 0xgg6au/qio0hFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The overflow sanitizer quickly noticed what appears to have been an old
sore spot involving intended wrap around:

[   22.192362] ------------[ cut here ]------------
[   22.193329] UBSAN: signed-integer-overflow in ../arch/x86/include/asm/atomic.h:85:11
[   22.194844] 1469769800 + 1671667352 cannot be represented in type 'int'
[   22.195975] CPU: 2 PID: 2260 Comm: nmbd Not tainted 6.7.0 #1
[   22.196927] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   22.198231] Call Trace:
[   22.198641]  <TASK>
[   22.198641]  dump_stack_lvl+0x64/0x80
[   22.199533]  handle_overflow+0x152/0x1a0
[   22.200382]  __ip_select_ident+0xe3/0x100

Explicitly perform a wrapping addition to solve for the needed
-fno-strict-overflow behavior but still allow the sanitizers to operate
correctly.

To see the (unchanged) assembly results more clearly, see:
https://godbolt.org/z/EhYhz6zTT

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ipv4/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..c52e85b06fe7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -473,11 +473,11 @@ static u32 ip_idents_reserve(u32 hash, int segs)
 	if (old != now && cmpxchg(p_tstamp, old, now) == old)
 		delta = get_random_u32_below(now - old);
 
-	/* If UBSAN reports an error there, please make sure your compiler
-	 * supports -fno-strict-overflow before reporting it that was a bug
-	 * in UBSAN, and it has been fixed in GCC-8.
+	/* If UBSAN reports an error there, please make sure your arch's
+	 * atomic_add_return() implementation has been annotated with
+	 * __signed_wrap.
 	 */
-	return atomic_add_return(segs + delta, p_id) - segs;
+	return atomic_add_return(add_wrap(segs, delta), p_id) - segs;
 }
 
 void __ip_select_ident(struct net *net, struct iphdr *iph, int segs)
-- 
2.34.1


