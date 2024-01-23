Return-Path: <linux-kernel+bounces-34478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E6837CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AB1F2938E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E71586D5;
	Tue, 23 Jan 2024 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BRNBDGZB"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDB157E7E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969734; cv=none; b=auw2V7BKmmZ2QQDpTfUxsTV+EkxOjkHLesZmyK81CJ3ZzwJOW3VtvbCXVP4RkLi3jsiFYX3QFyyR4v25n8uD9O3qCFXhA2L3fze4I3Ins54WeqIp+FO5A6zgg/ARlqpsPQnk7UPF5FEuAxQNw2/QyBMVJMyh9QFwyklXE1ua81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969734; c=relaxed/simple;
	bh=0vuR7p4ixw0RrC8ylPzI4bPxnFYZtvJs/dMTgGJ5vZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzBilS+xw4zoSbXBWmDWeoBrlw09wOjvSXavv+1JhrHaXtlCkfNysYQ4N9q8wcVeOB8Zi81Gabkztu6q5jd3yaQlnw49F8d8lmXUY+9BhmO95dgH+MI2SZ6+6m25NtpuzNPZFlBYfgYtQFxhU2wqVjgIpT1LbptganuoK6Nw69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BRNBDGZB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598bcccca79so2068945eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969732; x=1706574532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mzYhNEk22l7ZoNe1NF04GNMHFMRe0cWF2yVmwT+ra0=;
        b=BRNBDGZBMSAU9aDoATTUHu12p7MdSaKxA5X0EYOjPiDMomzyErl5tyrfoZkAvHTAFK
         k2tVSRquwV4dwqcx+G1nYmapU4n2kMr0FBoG3+1tEFeM9Zm8wNE4TMWOHGKqKxsuyWEF
         cYpDs0aBE87MIqfRD/EvQJ/eboax76PWm7Epc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969732; x=1706574532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mzYhNEk22l7ZoNe1NF04GNMHFMRe0cWF2yVmwT+ra0=;
        b=GOdbW1/OGZK5LB6W3SAzA6V4AZ9sdV2WvJ83qo185+aP4Jvkcf6O35FfaBzo46O/kl
         N+P2Gc3Ee0Ys0uiO1WgXcidqHZJj1fo3MJuTYhBize+e8/JzejJATpvgsy74Xos59uqM
         4vdB1E1282R6resXTjQ/qNyyGDdKtvln5rIqiTtymz35aIl5rwlYlEZvIcdscsJIaIAK
         342gtNy79E1SrfA1LP6hLZWH4TqXj+WjQx3MbCApN78Gl76zltG00/1wpAa1n6VYIIYE
         P4xS4NCg7Ga2ep0HMH8ZmFisKD3UGUYGbIXjoIy/7q24QajI1FgiN4wgN+8w1N3duZA1
         FSXg==
X-Gm-Message-State: AOJu0YxA9hbROGO5nHyEb6zR2OkvDzKqR/T7QvKPFT3+zyQhFE6I6C1R
	xoH0M8AY4RvAN96+N70uL6DipxlV9PtGIV2X3uHFgnGetmyVcZlppuLHfBSj2w==
X-Google-Smtp-Source: AGHT+IEFFCjcvvjDs5VhZZKQMfxmfaEe58OGTZO8rYGeZSl+4Oabsb2rR0IG6UNlABUS+Hoo2bYUkQ==
X-Received: by 2002:a05:6358:89c:b0:176:302b:addf with SMTP id m28-20020a056358089c00b00176302baddfmr2445145rwj.11.1705969731980;
        Mon, 22 Jan 2024 16:28:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a628103000000b006d842c1eb6fsm10623083pfd.210.2024.01.22.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/82] fpga: dfl: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:55 -0800
Message-Id: <20240123002814.1396804-20-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=keescook@chromium.org;
 h=from:subject; bh=0vuR7p4ixw0RrC8ylPzI4bPxnFYZtvJs/dMTgGJ5vZw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGHtjsSSN/FMeEK+eLhH3Rf2IQ7QXdGbQOh
 GLaFivRK7SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JjwFEACq/xltKSW9/AcV8nURH4w+OhwZyCA5rN6lx9nRT19Yrrpsyh46ZacM7qLIRfXPyb9Wd+q
 W/ZaxHD6dec3ZWn2vr6dNx/S+6JulWL69SBFoD/Nui8MMG67egljBLYBcYz0NnTxdUaEovsRTjs
 00TCrQdq8uFVTCZ6uIY4TiHMPbUNMZSIsloMUE3cCSpElU7skC9RHl61eYgW3OZmEsMsFvxzNhS
 tSy6oEkp4ETYdA1qEZq5V7aiH2rIziK7CNNrYg5GM1xUrqRTAikI8yponLWEPC0Dm5IDWnB6ong
 LiLqB0xMeQYRH8YCAJLBZB5KVyHCESLS6n26/HQaNYaMcbMYmOCTuboxWSCxaJiz3OkSuxqErlH
 gpN5tMaUpGQzYwm39f2CsadQgOfSyR7i+g9+pFDdfY5st1jylp+v8o+Xc+b9M8gasnUpNSMyBKC
 i/KFVGgFOBzwf/a/iMqg81pPkTDiic9cMAzjQAni6b2u5Itiad2QmvNntQb8BMkqbhPwTMPJ8HB
 AMTt1Ok+GwJ+55EPC7JPQC73k/jEvTR3KlvYL98PqXom6c/pD+V9a1jSgu8JGydxhunOYziZ8Fm
 nCglfYM7BRv+8zjUyvboX5/hptVcbwqXJuzoAzMJd4vXJpZFuQ+bjhaph5jUnAq3ffbU6UEpTRw /dzTrO4kzPwetig==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Wu Hao <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/fpga/dfl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e6d12fbab653..7d10780e3a98 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1939,15 +1939,16 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
 int dfl_fpga_set_irq_triggers(struct dfl_feature *feature, unsigned int start,
 			      unsigned int count, int32_t *fds)
 {
+	unsigned int sum;
 	unsigned int i;
 	int ret = 0;
 
 	/* overflow */
-	if (unlikely(start + count < start))
+	if (unlikely(check_add_overflow(start, count, &sum)))
 		return -EINVAL;
 
 	/* exceeds nr_irqs */
-	if (start + count > feature->nr_irqs)
+	if (sum > feature->nr_irqs)
 		return -EINVAL;
 
 	for (i = 0; i < count; i++) {
-- 
2.34.1


