Return-Path: <linux-kernel+bounces-59122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9284F18F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332BB1C22385
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37886664A7;
	Fri,  9 Feb 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdSc8g32"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27172EB14;
	Fri,  9 Feb 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468348; cv=none; b=eUCjyup6U+8GGkPmr7XPbfVTEnwX6CM81w7aWMUco6OCjXh4ksaa0eah6OJ/zmjxdBY8GR8CSI+GEMu1yN+WEU8k2KsvDWTTuMf8pBbpIdz9Norhl1HHnt1ZvhDxVVRh/prCY645naK9UQDTkoqRJ8xIN5KZlZRZ0Gk1ZG6DXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468348; c=relaxed/simple;
	bh=QvJ8K/QuguClbarhkPaicZTa9WR+0GbLRmBuHE33HBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3vCLLUmqDEuusAimak5GhcIdhYwtjAWLSUyKLQBNk7yVdqU2hoabfHkTJ3ND9IBpz93rNUtOr3EtCvWr8Y9DHbwic+vtHAbNe8L6fKuyKywCNnpp1kf7tVwK1we1PFQnc3eg/n7FvhqGAt5oB/tCg+RTqAkLOOCI19MbEp5yO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdSc8g32; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so5901275e9.0;
        Fri, 09 Feb 2024 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468345; x=1708073145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hRIU+85gP4cVkUoawCy1lqfH+fhaaCqPKNQ9eBaY3s=;
        b=kdSc8g32qt0oSkZL2aq+u9ZDz8oZWMVXQUfHgGrV0kx+ISvyK54F/mVYWqqm2XJoMj
         UDTgC3RBFkxY1A6z7/nP5KTpN5IiYJ3g2IUVZH3nVnqkzNdHK6MJP+0zVQcmePt70yzQ
         wlEfBfKItbx0HGji0VNJhsfzXWq82HKUZ1lXkQlkakOjXKw+/FvC6+EUU4UmvbGk8UlW
         r9US8JrdIFqsFYqliaObyWcgpwQ8uOe7ZgOvHbtDkm80l6T2f/ch7CVYJ2UVKjhaCbwv
         CnD86P2Y9DOQKjDy09hsMa5NCF66wFDnbtwBCRdZABbncT0/S0sgCW6FwgN5na1x7ZQL
         MEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468345; x=1708073145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hRIU+85gP4cVkUoawCy1lqfH+fhaaCqPKNQ9eBaY3s=;
        b=jRiVgFJZdegSF2x6y/jW2dIZsZroDrgivVkKgVzveUn8ATDoFEuge8QItd8P427cyF
         jkXJ4AFOlcDX0CyIfeE+3KW0So7uR+F2Epg22o/Oq1VjudBZFpGtKUiPIOgnKwvEG/O8
         x8M/crfApaaEcpni0pxYBcgtUc6rnwC5Laf3wwi5Fb6rD6PWsdddpDop/Zx7wnMEge2M
         FhDWVfwIPSSe1YCEpFnJZu/NP2D6k346LRTERy1g7KdvC8X8v9yTH65wTE/FdWsk6KB5
         Lx7SX5HooF6H4GYg2rtOf6QHf2y1yr94H+SCY9on23Cn7n3ODrtP1y7R63WDA7lcmo33
         Npyw==
X-Gm-Message-State: AOJu0Ywg+a/hq3R+BkfHkidzf9PSz1Va2A9EpgU9M9SK9YN5jFiVP9j7
	NYz6yrFluFEYm2mFfJPf2i+8cCJAVAPUUnoY/xk3ro4QkeY0TSWR
X-Google-Smtp-Source: AGHT+IGjAoTCace9M2xfUFRKDENlez707RCvfNNhkCplEVi9nb/vpkY2hMs3t2o6h0ftxnt5Bf+Gow==
X-Received: by 2002:a05:600c:5026:b0:40e:ac4f:7156 with SMTP id n38-20020a05600c502600b0040eac4f7156mr774790wmr.5.1707468345071;
        Fri, 09 Feb 2024 00:45:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQZpDUFLN6ZON+d1wtj1vX0nLILDZmIEMfMaohn45K0NNNXFq3yepTYA+Oz2OUuDe7vaUy0YvD9FQzsxNLHuohswNxjwPaLOKGhasroZPi4zPwBa9B73fBxTCJlpBhblUuGosa6oBCkulOyP+S9N/RA3J47GPgiXzpI5w56Eq1Y4fYRtK/iRbB9q9X6jPWoDVpHcrqGMQF1nG4MgEekrGoKhzm6OlMHFwjSeFb9+rJcc+hjnoxhQCknYpjNwgKcP7zYopifUqxwpLkF7tDmFZNhfT6+tP/VksC8LaZV7KerQF7kvTrWB5iGI1o+u0WMsvcyo2WVHSjFiEqidShrx4J64xluFqj1gwd4B4w/MeQLDYXL1pK9yNEDuRspkAH5eZSaambqbnOyafL13IixZqyQ4n4pLXfYfOvzAnhB46Kh5toXCye17HsTbObK9tolysOepdWeDzxmSqXzD2jdKU0iTQ+Q5+I4UhYwqx+7WaX5f1+OG5ZZTv79k195+yCZej1WIzU
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0033b3cf1ff09sm1236689wrn.29.2024.02.09.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:45:44 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com
Subject: [PATCH v3 0/2] Add a property to turn off the max touch controller in suspend mode
Date: Fri,  9 Feb 2024 09:45:41 +0100
Message-Id: <20240209084543.14726-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our hardware has a shared regulator that powers various peripherals such
as the display, touch, USB hub, etc. Since the Maxtouch controller
doesn't currently allow it to be turned off, this regulator has to stay
on in suspend mode. This increases the overall power consumption. In
order to turn off the controller when the system goes into suspend mode,
this series adds a device tree property to the maxtouch driver that
allows the controller to be turned off completely and ensurs that it can
resume from the power off state.

Changes since v2:
- Add Reviewed-by tags from Linus and Krzysztof to the dt-bindings patch

Changes since v1:
- Rename the property and change the description (Krzysztof, Linus,
Dmitry, Conor)

Stefan Eichenberger (2):
  dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
  Input: atmel_mxt_ts - support poweroff in suspend

 .../bindings/input/atmel,maxtouch.yaml        |  6 ++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 72 ++++++++++++++-----
 2 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.40.1


