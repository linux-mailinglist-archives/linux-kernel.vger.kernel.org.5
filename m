Return-Path: <linux-kernel+bounces-34525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807C837DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EE1F29A34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44A8162765;
	Tue, 23 Jan 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U5w+TCj3"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BD15FB2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970185; cv=none; b=F4L3OjMLUDCblprnKjcvEHNtvzoQSR9hylaCDgNUqOmkssnPb2HJU7gsAT+E+Ri941TCMjskRu1LxO17pHD/QPC+1yLyIH88XJBVWRXkzuMhGgZ5PFLXePoHz1n8V4n2fxme59xcTndi2tzlGVerk8tlfGlgeiQ6wXHmTO4+gno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970185; c=relaxed/simple;
	bh=GiWhP3MrtF/n6FOjCeTrtngKdYU/XXg3g36941RXt68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlujD3eDvkSYTo5hMXlsXl+AygAHh6MSyOGLTOrgjCFJnZsqVdamHxtB1Ux0gre5jMPRmYhEFiL+pSO4qleMK7a+/64LGH6OrBLyc+yH5Cr9p8FtbEmWlqf8CvlF7KREaOBbCXgd/v7tPV1K7zR+CdGEiXxBpZuF+AvnJyhPVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U5w+TCj3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e0e08c70f7so1619636a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970182; x=1706574982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfUPSLWLFR2aaFBB7T6PJOGyzs3EsvCpQit0VhIc77o=;
        b=U5w+TCj3OYdJ3nUk8pG+3r3BOkuYEfZpnYKA1Uejeu/YHAIFIcQ8bYLtI08jD8If63
         Vb70yGwIs8rkcQGNU6lMVrr4DGaPiRVtqcd5ZNExuaKhqOGX5eI/mJSseo+3fSQp4L4W
         4bO8IH9mJJUWix5a+5biqdITiQcQcgDGyN8ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970182; x=1706574982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfUPSLWLFR2aaFBB7T6PJOGyzs3EsvCpQit0VhIc77o=;
        b=bPGSKva1mZfsTZJdMKeueLmvEs69JKcne2Rn23axMNfcpe3SEVk1vVfBwDHgyObyXR
         M6b2UrTM1oieHVc0njVe0OwsVojC8Zlf07mslzkXdwqCnRraeKECPP4H20Rw98aQtUhM
         gGxxIEXA8wevkbAeEvsklKaWzmovMX9MsMlBpMRpZJbrRuZ9jOnwMmsBl+5VfvaDWAhu
         gx1JilubBax6EetJGxOK2YQkrle9orCgNOqogJ9zp+aP6FzdSy+9IkaG/7dJEGcFKfiX
         wEQGZfwMYGVsKObVnc4oJnYVw5DjHM6Offksh2KkVT0r592UkbRUAVAFkuLnHbD6+wFv
         Kprg==
X-Gm-Message-State: AOJu0YxzARXCgU0dtCJ7NtWbf+52FiH9nJDXW7/jIuAdlXo4ZCh10u2w
	zhFQruCuAEvjUlBG0RacsBLiT9V6kby0f7Ntl9MHJoavUybas01EvFqT/dkW3Q==
X-Google-Smtp-Source: AGHT+IFWer+CHPYFKz4aogRg2rh9FM/Qdoj3c5YAE1QWiQ2/ARGjmNAbYrJIVCmUtb1J4VGTkYl8bA==
X-Received: by 2002:a05:6358:4b4c:b0:176:5381:7508 with SMTP id ks12-20020a0563584b4c00b0017653817508mr1802125rwc.29.1705970182669;
        Mon, 22 Jan 2024 16:36:22 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006da24e7c16dsm10181497pfi.186.2024.01.22.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Martyn Welch <martyn@welchs.me.uk>,
	Manohar Vanga <manohar.vanga@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Alexon Oliveira <alexondunkan@gmail.com>,
	linux-staging@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 79/82] staging: vme_user: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:54 -0800
Message-Id: <20240123002814.1396804-79-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=keescook@chromium.org;
 h=from:subject; bh=GiWhP3MrtF/n6FOjCeTrtngKdYU/XXg3g36941RXt68=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMOyPanh0a8qKmM4y2TAR3HGUyEXSwoxVEk
 MEgKnhG10iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JlyEEACa0F1lV4dIXFWgeCdkJHhSC7mnxnguEgyncSJiop+k0Bd7fCoJ6xCBI/VsrDDiOV5JO7h
 YlfkKkorKeHSwQ4eF7kA5ad0WAs43pP9aHx+fgnexAdyAv8q6kB4EV+m12jZXMkqpa1a2arGVBX
 vU/kVtSPYhonhrHCjR8yD/RJzZQCOq0Mv9L/oNW0TClnra68UXFMsMrx8r02ANI98S3Kkm/fePG
 YWRN7tYvnoXzmS1Mv+bd4pACK3H9sNQQa4gC3fsjOQTevRfKf/goaHyRRd6b7JoulGhmmzXXtZr
 OFWkOtLXFLah6ZOtxrTfcxSwwBuPTZeJrkLQlwBkjxPZoZU7IR5rhIfBgONwxTkOAmv0aR/cRis
 kfuHPvu7SaQ6xuRNFXVsgmqxwWDG19eC/B0UrD0D1lhkRNPRS2OqC813G9hba/iMw+CpRd/0P81
 hMVIoIAdLBsZO0VwmPrpH/1YTRMjHholnWqUb5fHwnaWIpK2vWGNWf/CrSgsmdKWdxFqGMHHWPL
 1ZqTf5JCBXXb+6xfg4LQdl07I2loTL6jVB6DMwFSRDXhu0ntLycT8xi4Q0NZlqBMJ9TBC+FJcPZ
 zHKyXn2zD48i8oZMzFdhMU19Crj+Kb4D8Ea+yCfWCOxvs/YIxPgxMOz0MPl54rpj/jcm60Kua5P WbhzXjTYboExRrw==
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
Cc: Martyn Welch <martyn@welchs.me.uk>
Cc: Manohar Vanga <manohar.vanga@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Soumya Negi <soumya.negi97@gmail.com>
Cc: Alexon Oliveira <alexondunkan@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index e9461a7a7ab8..a0acf2a295cd 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -165,7 +165,7 @@ int vme_check_window(struct vme_bridge *bridge, u32 aspace,
 {
 	int retval = 0;
 
-	if (vme_base + size < size)
+	if (add_would_overflow(size, vme_base))
 		return -EINVAL;
 
 	switch (aspace) {
-- 
2.34.1


