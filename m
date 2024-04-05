Return-Path: <linux-kernel+bounces-133122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E84899F39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EFD283D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71416EBFD;
	Fri,  5 Apr 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNLLBGen"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF916EBE4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326502; cv=none; b=uke8A4UxIbvYGJmO6qXIKhdQh1b8Q4nwAjTsMi7m10aJdEoVqKixsQwG1aSdtZWS1oYcWBZLocatiZeCzZILOupIOO8LMIvcK8qfqYErnykcJJ2rMXHLtwEHdRRzC0gESQ7K8saO72xGSG77DAWKU1vGKsaZh4cp0qOH2cVPf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326502; c=relaxed/simple;
	bh=pDD6b7NC/ePwYMANhj2exMJdbqx65T7Rs4mP4zOLtYI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OeSkNLg6bRA1abFRAFhq90H+p6DcxEQE+ec7KSNIB5o5iqhhB/0JrTLo6wKZ/xkB337CFIpxPfvvgZgUkXehLqKtIn0sYzC4kvzqFxBCBMSAuFHskVpvJXq9RX82mE47OW8Wzy6h3P4XsKSIaBJtI9ybtLOPbuWeYheeRGYKoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNLLBGen; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6152135cd23so32533517b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326500; x=1712931300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOEKymZayhG/0q1ZDPQf7x3wGYlc09bm+R+u6RPW0M0=;
        b=pNLLBGenwHYgNZVQPYwXXeRNcUNTGzpKdWDd4yCxd9N8/1yctkVToUvAKK7Gc5JGSU
         watWKqOAbPim14bE13Ey31AFgwwhcnhjdDpajyhoFRuWPz+XTQRx9tcdl9sQ+hyElAOC
         /u6LYK2cJpYAtjc8YLDTXzhTPOI9JpJyYVCpAU7wIrQcbOauWERq9h96Va6pAL9DKq7k
         lmdpyl4N+ExOqVA68sEvG/EHfTavavJp/0X8k4OT4x7oK+yDDdNAp82S7HOvDELu8THy
         IiYxWjU0k3GMw7iR6281mujqTN8MnFligJCnf+96zrTN5knmG9jke+9nPPw+zqMDEsFH
         n58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326500; x=1712931300;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOEKymZayhG/0q1ZDPQf7x3wGYlc09bm+R+u6RPW0M0=;
        b=hYySP4D4XPQMRkFTAd6YF8IsaH6nUlcspQscuiAH6L6uBnf6vXwn/zoZatnXS7JgZN
         zUuLpU9Tg9I+DXFarkBtzNmf+flUPfKjcNU8gVC8zwuOqPH7CB5Nrud/flfl0aaDWugo
         KtjvSYg08jTgbVMfyeZrd/RZoBPdSyn8KmwGFOvHMqTbmQvokfFXFBQ1CcrbjwHATv+v
         N9Lexfdd9dPw/U6EErguISQ+ujCqIOZryBv+SGzU3rJxO/MTMNUrzOByO8F8BMFANQbA
         T+1lxCqPXZNZGVCgN9hPZUaLcBh/ilsKX5tfVlKhsYXpAF5CkbJnu4TMK6MrHQJQXNV0
         BrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8W3QzHQ9YM4OuQjIWCnBaFxFXkV6OOe8FxbDPUtmhWiDJHi3foeT/kiUTP5tFOwQISKUWPcLTU1eqCh2vJlG8jEhgevbTb+eQ6ona
X-Gm-Message-State: AOJu0YxveSVTiQbjwahZQsEyDhW/34dujw7oiE7nXUf5bupbQWuGBhOg
	uRquCL2sxkbUzewSch8Wb37aeYZ+eHxn4FxIuJMHtUHgDo1cBRKTeyumErr6LcHH7OXQENEXUew
	T6U9Las8AFw==
X-Google-Smtp-Source: AGHT+IEy32K42DHtHKAWgOXRCxiaIoDo8DItc0jViwUXtneklvtCH/RAT5HPrH/6Vl/aXYkxfcJka5AVf6TyCA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:20c5:b0:dbe:387d:a8ef with SMTP
 id dj5-20020a05690220c500b00dbe387da8efmr69983ybb.1.1712326500108; Fri, 05
 Apr 2024 07:15:00 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:13:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-1-panikiel@google.com>
Subject: [PATCH 00/16] Switch subdev dv timing callbacks to pad ops
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, tharvey@gateworks.com, 
	niklas.soderlund@ragnatech.se, prabhakar.csengg@gmail.com, 
	charles-antoine.couret@nexvision.fr, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, skomatineni@nvidia.com, luca.ceresoli@bootlin.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, subdev dv timing calls (i.e. g/s/query_dv_timings) are video
ops without a pad argument. This is a problem if the subdevice can have
different dv timings for each pad (e.g. a DisplayPort receiver with
multiple virtual channels).

This patchset changes subdev dv timing callbacks to include a pad
argument, and moves them from video to pad ops. All the affected
drivers are updated to use the new pad ops version.

The affected drivers were updated in a way that mathes how they deal
with the pad argument in other callbacks (mainly enum_dv_timings,
dv_timings_cap, get/set_edid).

This was originally a part of a larger patchset:
https://lore.kernel.org/lkml/20240221160215.484151-2-panikiel@google.com/

Pawe=C5=82 Anikiel (16):
  media: v4l2-subdev: Add pad versions of dv timing subdev calls
  media: i2c: adv748x: Switch dv timing callbacks to pad ops
  media: i2c: adv7511: Switch dv timing callbacks to pad ops
  media: i2c: adv7604: Switch dv timing callbacks to pad ops
  media: i2c: adv7842: Switch dv timing callbacks to pad ops
  media: i2c: tc358743: Switch dv timing callbacks to pad ops
  media: i2c: tda1997x: Switch dv timing callbacks to pad ops
  media: i2c: ths7303: Switch dv timing callbacks to pad ops
  media: i2c: ths8200: Switch dv timing callbacks to pad ops
  media: i2c: tvp7002: Switch dv timing callbacks to pad ops
  media: spi: gs1662: Switch dv timing callbacks to pad ops
  media: cobalt: Use pad variant of dv timing subdev calls
  media: rcar-vin: Use pad variant of dv timing subdev calls
  media: vpif_capture: Use pad variant of dv timing subdev calls
  media: tegra-video: Use pad variant of dv timing subdev calls
  media: v4l2-subdev: Remove non-pad dv timing callbacks

 drivers/media/i2c/adv748x/adv748x-hdmi.c      | 16 ++++----
 drivers/media/i2c/adv7511-v4l2.c              | 14 +++++--
 drivers/media/i2c/adv7604.c                   | 14 +++----
 drivers/media/i2c/adv7842.c                   | 25 ++++++++----
 drivers/media/i2c/tc358743.c                  | 23 +++++++----
 drivers/media/i2c/tda1997x.c                  | 12 +++---
 drivers/media/i2c/ths7303.c                   |  8 +++-
 drivers/media/i2c/ths8200.c                   | 14 +++++--
 drivers/media/i2c/tvp7002.c                   | 26 +++++++++----
 drivers/media/pci/cobalt/cobalt-v4l2.c        | 12 +++---
 .../platform/renesas/rcar-vin/rcar-v4l2.c     |  9 +++--
 .../media/platform/ti/davinci/vpif_capture.c  |  4 +-
 drivers/media/spi/gs1662.c                    | 21 +++++++---
 drivers/media/v4l2-core/v4l2-subdev.c         | 39 +++++++++++++++++--
 drivers/staging/media/tegra-video/vi.c        | 12 +++---
 include/media/v4l2-subdev.h                   | 28 ++++++-------
 16 files changed, 183 insertions(+), 94 deletions(-)

--=20
2.44.0.478.gd926399ef9-goog


