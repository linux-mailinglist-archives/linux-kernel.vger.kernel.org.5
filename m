Return-Path: <linux-kernel+bounces-91685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B801C871517
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2B4B21D69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101F045BE8;
	Tue,  5 Mar 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ts+ff8gv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1D43ACF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615105; cv=none; b=ZmjBwjDFekt1pIC+2xqvGlmgE1lBddkO0EzPusa4mm6pyeKmdx9veE6yb085q3Ot9G2Gg/nUOMzei7kRZtn5sV7M92vj80aPuBY1HLhgLI67fOPidF7mUFxaRHMIjsKFt1GXvAwH7fc58Cp3GxwopSyO/yK0JtfbReGhEvC2RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615105; c=relaxed/simple;
	bh=MAU1kWPqdnXGrNHYK3e1ZUDdxmqyA52aEjVKNf7L97s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=rFzMnDSYyAq098C6+vzqwszkUVQBnje9R3EkLNC8T8woFujE8+9n86aOv44ns0b8GCU2/J2mY/O2cf5saJ1dkcvgXgUCeglCAEacH0NEPEGDNti7fiiiPT/KtzEGl+PA7aDNWuxOi5EI/7MOGpZ1QLZ6lpgDVxBuxE4HJDbeZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ts+ff8gv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6399814276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615103; x=1710219903; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4xpip56iqsz0ZA+qjMQdeYvZuGJ4xYG5vF66MG0lag=;
        b=Ts+ff8gvPAXuRVEUHnF5LhhM2KBRL97o//wcOi+dva5TtUSU/SIm+4HKuCyZtwP42z
         hYYEcCMTb4qwCtlm/8RVWZRsV29Cti9Rid5yB2qeNjqFwURHKTmh/WxztubD0khaJpfh
         qxm5QoHqv6M5ypgvknUeZW8lBbp3fRsjPeb2BakOe63DpCP4CW0mHEtwqXzl5F1rrGc8
         qYF16GIKA3Oh3X5SbjYOO1HTW25/6sRvms9p8UkWs25VfeI+UCTJXVkCFtmASW/lX2ug
         WmTXix8GqYRlH0yBFMEke8Q8p4xsgIzTxZr+3tlcP+7E3HbI5Eb54blp/T/PzB1rKG+F
         5oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615103; x=1710219903;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4xpip56iqsz0ZA+qjMQdeYvZuGJ4xYG5vF66MG0lag=;
        b=hlFTmQbGjnLqG7kb/dYkDeB+yj5YRCC6bO3fg78zO7QyNJSxGgm47LKmFF0Ous3dgC
         I/gKUrmymneSE2ivvEONs4r3Qj4qn4UoxqOfoQI5fKal9nQLOrU8URDOAEO2p4iXwFSw
         X3aZj9UI8O3hOlieG46L8NsOB0M8YLWhLqwx54QZQqY1M8Ibp1kimULGpMDJ8y4u5wF3
         csxIl7bh0C1b9Vo7K2b5iJg4RecZaVd5R3O2fD2y0SwhP2oaevBE5PInP6dL1j55Pj/H
         Z5o7caAmzCiOcUyW5SRyu9INkT5gCYF/HRZmETiAYYATOSeanbkA+vLOqWfXZDj5nnBZ
         8R0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6PnCOTGBcstWXZbwmSoUemGEnmjSG0+Fgbxzs7wWBmZRoRhRXaCMCac2jAOdhZNbUc+UXTtz66qXsroOXwj4w4uS60G2lOle+e12h
X-Gm-Message-State: AOJu0YwkVDeVXbBL5lemtuvI3Y7riJlz1TUzFPgVzm5cW47xOwrFEiN4
	hQhmICb8xCPShE2Yl3sE3DQ/RFiLL7gGFuvNUeixWuXaJWAcJHJWNJYLTU18YR1qE5dD2yDaFzy
	aqHH7V61QeGC/eQ==
X-Google-Smtp-Source: AGHT+IFo+LnxDdPsW+MOrOqUjpVCkgB+n9r+MxXeQAnbHnQl5NgTJGxOR5lY11wswnsYWorkDIHWiDj499TxTto=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d64:6ee3:55a9:46e6])
 (user=saravanak job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr376493ybt.2.1709615102823; Mon, 04
 Mar 2024 21:05:02 -0800 (PST)
Date: Mon,  4 Mar 2024 21:04:53 -0800
Message-Id: <20240305050458.1400667-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v5 0/3] Add post-init-providers binding to improve
 suspend/resume stability
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg,

Can you pull this in as part of your tree please?

Thanks, Saravana

This patch series adds a "post-init-providers" device tree binding that
can be used to break dependency cycles in device tree and enforce a more
determinstic probe/suspend/resume order. This will also improve the
stability of global async probing and async suspend/resume and allow us
to enable them more easily. Yet another step away from playing initcall
chicken with probing and step towards fully async probing and
suspend/resume.

dtschema update for post-init-providers will have a more substantial
documentation of the examples and the need for this property.

v4->v5:
- As suggesed by reviewers, removed line wraps to go > 80 chars.
- Added Reviewed-by and Acked-by
- Dropped the DT schema documentation patch (will submit tha to dtschema)

v3->v4:
- Fixed MAINTAINERS file to go with the file rename.

v2->v3:
- Changes doc/code from "post-init-supplier" to "post-init-providers"
- Fixed some wording that was ambiguous for Conor.
- Fixed indentation, additionalProperies and white space issues in the
  yaml syntax.
- Fixed syntax errors in the example.

v1->v2:
- Addressed Documentation/commit text errors pointed out by Rob
- Reordered MAINTAINERS chunk as pointed out by Krzysztof

Saravana Kannan (3):
  driver core: Adds flags param to fwnode_link_add()
  driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
  of: property: fw_devlink: Add support for "post-init-providers"
    property

 drivers/base/core.c              | 14 +++++++++++---
 drivers/firmware/efi/sysfb_efi.c |  2 +-
 drivers/of/property.c            | 15 ++++++++++++---
 include/linux/fwnode.h           |  5 ++++-
 4 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


