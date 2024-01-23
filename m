Return-Path: <linux-kernel+bounces-34512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8609837DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D3628F3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5F13A242;
	Tue, 23 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsFGLxaT"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB86137C50
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970171; cv=none; b=fF0bJCZlbe54YP8ZNbZuEHo2o4h6mNM2zjVNnrwXgAzBp+zFca3PDG9qGWDWKmoI/Jp6jSOzkfHhgiXYRAeHvkMrCAYc4scdDPrpmxwWU9C6rjOOJu9kK5DC41IFjryNlEM+87eoovF16kDL1pIwsnzFK9bCJz/e+2KC6RPSdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970171; c=relaxed/simple;
	bh=j3gjFFi89fE5hWuOH0xzr9hUX4P6fWiq/YFrtYI1j0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6Bd3GELIlyOSibLNrU6l/MYE8V2UzB9DbYc4pkwVS8ZFjd3NBNpyg4RSgNYL109AgUkOQn1pmYA99FN6F7yjCO5r31H2uKk1HOHARGPHcXNZu0NuHaKiBrYKqm+9tS+BZ4GpABr+ZSDhQZ/wLYpMiL1ujxLLmd3X4O1BVRcFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DsFGLxaT; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5955a4a9b23so2240587eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970168; x=1706574968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkbiiH3/fFBjXvcbT3aPuNGXGqy/rkl4yqgLah2PkQ=;
        b=DsFGLxaTrkEC18juVhDlERfHhwExSuj7q6WnJDWX+RXKC+nsuo2F7BzakjL8d3jQuK
         b2gzSlgoocgnPgGztGxMYrud13lL8R09bk3oSVPwuSEMIUrQplba3UjdSkL3Uk/Ec2Tw
         J/zJoMzsXW3Z9ditfU4i3/UrF1WqtOHzSDo6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970168; x=1706574968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkbiiH3/fFBjXvcbT3aPuNGXGqy/rkl4yqgLah2PkQ=;
        b=gNYDU9UCUEUiEn0kXJAJOGBgLklyePAdigiWU7HlsX1K5RZTh3O9aFL/ZwaJFYJ0EN
         j7BrHKsRfjy80MdCIwkBY2lvXlhbsEaH/RofClT/QM49yJaa3UsTri/836+Mawieyq1Y
         nzYLFfJo8w8JIVFXBmQDq6dFchu5uPqLGjzj2TRIdLfAf3pq7/9cfHqbqE+nd6YHHbDE
         nVjk2YvcTvR/gS01Dwj6082CuRa+vVKjTKlrGCm8e0HrxBuJny0WF6MRwoFyuA0yQf0j
         NlwfqldPkmaOBrUXem+R8XNaTogxVGRazjQY4e7cFb2rq8Cd6WWOFJ0TY0BRUKegnTP2
         gMlA==
X-Gm-Message-State: AOJu0Yz5EeNDN/GDUnZODo6UfwdSpLRDtKdR17pKB5dwpFxvMatOfF1l
	jYwO8vcT8dp2qJ0hg5tqAi3SV4o2dHAO5GykMRtpqsm7Tw2OWDSGpJMPvqr4CQ==
X-Google-Smtp-Source: AGHT+IGCE6wKB0vFo5DQU4i3rippgddBtp79PTYZ3m2V82MozDWJLYPquNrFjcuiK2uXFRm90PZo9Q==
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id s23-20020a0563586f9700b001762c3dfb35mr3682344rwn.20.1705970168652;
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e33-20020a631e21000000b005d0796e779bsm443952pge.12.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 75/82] timekeeping: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:50 -0800
Message-Id: <20240123002814.1396804-75-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=keescook@chromium.org;
 h=from:subject; bh=j3gjFFi89fE5hWuOH0xzr9hUX4P6fWiq/YFrtYI1j0Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMYckjD86gf/4cfDfniKeSqD0L0XmJ51qsC
 Om3IcpSCEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JhBOD/9e96QfLEjRR2+qhyB61fGhN/WxCMNySyJQM8sIeDxAo5K/ULqUmvt+L1RbQj6LFEsxhM4
 UJedG+p4JcnhH+R53J7/OuNQPRgCIS+tzlF/8uGd3mRLdB145zOQ9ukNMQCzfFQEZqtdfkpf/n4
 VdhGXTw/fOWZ57e+MMGyyWYDMm/ER8H0IWMflMlG1f4L7wAAzSuLgaZXr6h8I4jBY9knySyVuWh
 fDVPZod66S5Vyp3vqUrRnatGxHW/SbYv6odYSz21titb2F/Xzzr+yICMeW2pGzkMtrpohySkGBh
 FdJoQ/LY+nEMfaGLIQibr+dLnkqa3B0Qg7/Vi/XKbuTr395lI2LnCx1A4HpSwgKlktNV/2Ih2Ey
 JhZhiZhJeIhGtTmuqlLXyFpmzkVuvTUVwKLFQlfY5HekV7kZY0Zzgu4ZqR/4HtRCm+jqmaw5tX1
 MovwgIpbaHHXZiFPQyX0X5RZg8/xral+SZXA3NBwFOI8nutl0Nbghz7xEFHaluKv+1kIVBg3WSp
 9vM0UEXQ2adsZPgp2g71YeWak3Fac8p6QgFlGRZNextT3T0ZLYWoleTfjj74Ij3mj0DI6Tedbmi
 gikhr35jTk3wjvNCX+vdwRxeEJoKDbe2uO1Kj1JlhmkXnVS5cQUUOT+tgAaewBUK6bw48xlhXwm 57RPQajdkj16fbw==
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
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..2fc7cf16584c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1984,7 +1984,7 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 * Which simplifies to:
 	 *	xtime_nsec -= offset
 	 */
-	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
+	if ((mult_adj > 0) && (add_would_overflow(mult_adj, tk->tkr_mono.mult))) {
 		/* NTP adjustment caused clocksource mult overflow */
 		WARN_ON_ONCE(1);
 		return;
-- 
2.34.1


