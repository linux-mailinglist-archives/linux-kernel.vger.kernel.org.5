Return-Path: <linux-kernel+bounces-77433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B6860550
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2191C2524A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C112D1F8;
	Thu, 22 Feb 2024 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQlrXfAN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CC12D211
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639258; cv=none; b=JFhQDEbk+3djfDjgz1OE5YUsnKS7/pXWpcXOfkJQJoIauEcaIuhnhRAUpR6esvW7VgLcq3re1/kgV5OvBEMnJywsEKINHbUCYpxiFWT60u/hn8uQRRPS+vRZ8rTqZJZ1Jzla9fqIscuRsjUmKqiD3vNZPRMoRT8YdNmIzSnB+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639258; c=relaxed/simple;
	bh=/0jZgqFV3QHFwXdwQjyOlzwZPiSes7vDjViaGzmwhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHbtuTniiE4v+Lxd7jKghpLdRM+AdpyRWU5XWGUuM9TXPzeocRWJy69KDoy+pUjCit3/covmT1aKhbvG77FvuJNGUB5PA/mqDoOPpPN6M9+pI8BeBY1Cu85xx5/X5+euJxAGvRIUQ1G9GfSs2e+H65KkOekAkzSQuXCNdOMLrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQlrXfAN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbd32cff0bso2801675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639255; x=1709244055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7U2tjc40/BAOXSRwNIhZS6QrofSS9z/mAZ0ltWiA80=;
        b=XQlrXfANKAFX/0R+ZH81Am2eORBegGANg5R5hlUcFpf02tdb51GlueMksGS7WQ/0au
         yZGLlxYczA/be0Ly0T0hiO/uRUzhaty0KEeXTwxwf820+EMccDPev4ZuDYBoFKiwOmS5
         ntdwRZ8AxjsYoz2HpNdGzEkFseseMQ/ZpKuq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639255; x=1709244055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7U2tjc40/BAOXSRwNIhZS6QrofSS9z/mAZ0ltWiA80=;
        b=qV+O9DMJQ4bJ83vLWg5N6hFMUJcN+Z1XXOcsVkDXP9by5SHVuVc2cVjMMwX1k3PYZa
         cjaGccL7YTG6n0jgv7gbmtxmiVDLBfZejaHi01fKMiZgelDOPZK2MWNaoIX2eRtOf4hq
         Za+BJE1uMN6+m5WadY42tBwjyy5f94XtYP0OqWEHsI/PwUCmRxpOad0O3+K53dlkueYq
         OzvILYB0AX0tvYYcChJtOZmamHXIT8esN7JdaIKEm3iWXU7YxM7gtInkiOcJzhSVpA0r
         dJAHxFat6tcW1zaIOZSRgFzffq5O7iJL8Kmhs0TyEyuCrsN+U5QJFZXVmIKFAxuSE8Ue
         WP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIlqh/tLSeCaEuwblop9oM+HUAyKzvAPjy/2EqxFZaeK1ERGStqTHju+R3aR9A4wxQUpiJ/dN+E+62wFjcsacgmBf3tK7OsA/Lp5oO
X-Gm-Message-State: AOJu0YyS/bTFRMHrsmnk4vmp+B6eA3swvnYrvjrNzjolqXWW2+F/6u+h
	TxBN/SC3ZYwO+bdGdE2+qa36nGl5N6/4n/wekeOTDG0S5Rl4dKRZf+02NuIrrw==
X-Google-Smtp-Source: AGHT+IFthqR+g2dBw/UAHrs4z25heuFjZDGEvpiSvMlZdt+AxyMd9KMXGew95W1Id88zqK02C5oX0g==
X-Received: by 2002:a17:903:2291:b0:1db:fd4e:329f with SMTP id b17-20020a170903229100b001dbfd4e329fmr158789plh.15.1708639254752;
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001d717e644e2sm10357386plc.247.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C . Harding" <me@tobin.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/4] MAINTAINERS: Update LEAKING_ADDRESSES details
Date: Thu, 22 Feb 2024 14:00:48 -0800
Message-Id: <20240222220053.1475824-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222215755.it.764-kees@kernel.org>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=keescook@chromium.org; h=from:subject; bh=/0jZgqFV3QHFwXdwQjyOlzwZPiSes7vDjViaGzmwhVo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QSYDlmaz4o8wEpSBDere7LZ8YHox0i+LD6P fFT/CbFwrGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEgAKCRCJcvTf3G3A Ju6MEACz0ztHen9/0jUIZ4S7P1C/KaEPNBQFSTxxU4ebUBIeSf9lR+aMLQgkRqYPHkNhKUwMyAe 0kfKRj+c2d3kl6WLlwolO6hDU8L2KJgSTIH9YUvw6C4dZm9qjGPBbP+nS+KNwjmZaP7mbr5olEz OeZlrWDukYeZGGfH0Z8HnfKZy90SSYZFpr/NN4278Hf23OnzxJcQhdIhzHkpOhyNzvB/NwSTf2w FeufXgd72gxmzIL9Ezf3sxn5HL0FbSNqrgoJ20bXnawW/jKSSZGQTCtOkm/raGNNycdBYLxG5eb 03FGXYdPXmw6KgOkEnilYPbjPRlKODOP5kSfmcHZycfRGD5sXzauQ1leB5cVRfzZINZdBMixOVz G2XO5A1+2WUxc3lP4vr/WynIHOpXwAww7lWeRQMQ7iBuxCLp3A1QDoOoR6j0bB1OHQw+VEUJ3fX QFXW5jWdlTX8hxYc/gs7munqdYDOguFquGU/Xn05okUzK4XheQ4CjO8LbMD8np9L54W7LPOEI45 o0EkGDwQwdazQn8HJPJ6rsGhnV/rY2TRIykGjLSA30uVhsEFRhXaF6vD5TDGBTMWZT57Cm7F2kl eH3d0gUmCcTu99DiFdfztZH1+hODUAEbwhtmk7EZsV/sKv8N+suvdM1C6vwnkLq6xAuJcclwBJ4 Sb5oeiSWhU8Z5sg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Tobin hasn't been involved lately, and I can step up to be a reviewer
with Tycho. I'll carry changes via the hardening tree.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Tobin C. Harding <me@tobin.cc>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 216d02a3fed5..cd651c4df019 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12154,11 +12154,11 @@ F:	Documentation/scsi/53c700.rst
 F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
-M:	Tobin C. Harding <me@tobin.cc>
 M:	Tycho Andersen <tycho@tycho.pizza>
+R:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	scripts/leaking_addresses.pl
 
 LED SUBSYSTEM
-- 
2.34.1


