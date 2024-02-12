Return-Path: <linux-kernel+bounces-62392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AE851F94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE13284CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB094CE06;
	Mon, 12 Feb 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR1S9b0x"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E074D584
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773513; cv=none; b=uMZEVw0xQr/jayri5mpttmjap5GCpXLbiVsHaw1YN/xgYoSKWAqrSUoqN5Ri7eqDY8/HRlFwi1m3piu458BO7BkyCB2MM2W5D1sU+5gLKWEpPeYGL3apxZTE/gnzATIp3cJsAtEVnNjv+1Uq/EhZ2f5KAlwN4GwQ2vOm8XIhCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773513; c=relaxed/simple;
	bh=uChUnQc4QHp+qfT44V695j8Bfi5csO+b4Ks0xqs3YHM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=BtEOnaGJA2v4uDlVMwb4tMvgikYEkZg/nB2FMM/JaYdYA5GMlDci7SVNMKNUtci9q/lXj7qio5n7vrJAd8L7rGq3WuDO6mZivw453YPP8gah/rMPRPfPBxyuJnm/iPv0gc8lkK434EFOalAQfOBNRBzXrZw7Z4E6MxwpkNB5xAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR1S9b0x; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso5878736276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773510; x=1708378310; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNLzwhDxpGsG0xXWUreD5zieU26PkV4O6rqgtZMT05I=;
        b=kR1S9b0xVghuNhih0RY6ckd6sl5vht9SMKx6ct0THm60HK2tkJVIGvEH6TnneCNSLt
         Czif0nlWvlBsRhZTLpEM4OOe7nuqaNUyDZYbkyoGELFW5NLVJQ06xWonL2leZYu5B4TW
         G1lkoLz4d0v7uISQcwcWBrF6zpivbdioQMLoemrkmzoU0H8Rm/T6RWE9+TsRs/6xyHlO
         hbXdflQE+sVHkJkIRdtawSj1qg0Dx2y2BMMFGG0DiebuzBMIeb43hka31Gcmcpqs3RdQ
         BI8Z4g/c1n/AT4Cv0/N6DrahdvARZIytcItQVJ5fR8fWuxYACr8ee8BVcT0jKC3xPJXg
         kEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773510; x=1708378310;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNLzwhDxpGsG0xXWUreD5zieU26PkV4O6rqgtZMT05I=;
        b=KCbBdnGqvEEQ6GXmS5RKYRyHWunUogVsC7xWJtgLJQq1Auv70qoTWuydT3XeVWjZUq
         OraFXvbapTbDkN8orLMfDzY2bypqqiLtRT2LvJcWxQvl92jk6nXjeowCVFLX3p95UB9w
         5fdL2NCEyncndlx0m5DZxJ9ZulGYHnByatZVSHhLfz/XLamzX2zBUO14tQS3G4cBJ6ri
         Ot/0CmwT+uMSurU1GUCZmTZ8Mk/ezoIkUi54tJhwrgpn+N/ODOIFVhrNAETp+DtYGr+S
         +J3I8ClgQ2uyhbUJF4K1iw1ac245jaZWWGgx5Vn1NRP7hYxYywFbRfMMAxTFjwnIDEpk
         gTmg==
X-Forwarded-Encrypted: i=1; AJvYcCWKUClbDUR8gnxPtT43QMuBYD6lrpaWKORf9mdJgTyOS7y7uwQ+JWCfmYWzy5yaeTECUvkA5blXE/fmbXfeKu+kY0SAEyMiBGr+y40I
X-Gm-Message-State: AOJu0YxWB5pnyNicrmNnSp7pTiKPPGwu/S1FRTlzH3VH5v4lnGNj0V7o
	+lRgmWgtRxMkY9xUwYXrFX0pnUL8EaO6R5Q+RctL58L8KJ/SSRoaNAAnX1G9t2XJ344bbcT0kC2
	QJzZjT7bgU5V8IQ==
X-Google-Smtp-Source: AGHT+IF9alaAHgJwNReX0hvs4exxyVhwm4cmM3z4eyrywKx2dW6rYYZY38FjIw40qMMnsR4IjK0GJApBbjhUT1k=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:496d:5de1:a404:8bee])
 (user=saravanak job=sendgmr) by 2002:a25:c402:0:b0:dcb:fb69:eadc with SMTP id
 u2-20020a25c402000000b00dcbfb69eadcmr65722ybf.6.1707773510116; Mon, 12 Feb
 2024 13:31:50 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:41 -0800
Message-Id: <20240212213147.489377-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v2 0/4] Add post-init-supplier binding to improve
 suspend/resume stability
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series adds a "post-init-supplier" device tree binding that
can be used to break dependency cycles in device tree and enforce a more
determinstic probe/suspend/resume order. This will also improve the
stability of global async probing and async suspend/resume and allow us
to enable them more easily. Yet another step away from playing initcall
chicken with probing and step towards fully async probing and
suspend/resume.

Patch 3 (the binding docunentation) provide a lot more details and examples.

v1->v2:
- Addressed Documentation/commit text errors pointed out by Rob
- Reordered MAINTAINERS chunk as pointed out by Krzysztof

Saravana Kannan (4):
  driver core: Adds flags param to fwnode_link_add()
  driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
  dt-bindings: Add post-init-supplier property
  of: property: fw_devlink: Add support for "post-init-supplier"
    property

 .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++++
 MAINTAINERS                                   |  13 +--
 drivers/base/core.c                           |  14 ++-
 drivers/firmware/efi/sysfb_efi.c              |   2 +-
 drivers/of/property.c                         |  17 ++-
 include/linux/fwnode.h                        |   5 +-
 6 files changed, 138 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-supplier.yaml

-- 
2.43.0.687.g38aa6559b0-goog


