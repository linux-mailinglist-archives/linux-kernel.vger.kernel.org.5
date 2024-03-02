Return-Path: <linux-kernel+bounces-89523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6586F18A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C1BB2328E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1829CEC;
	Sat,  2 Mar 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="KplvVdEy"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370522EF2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398914; cv=none; b=KNEjcCMyoKQZbl6phou4Ne2c+l5qYt7IS++GN1Iy7r6L2FBs/B7OcpYDDarl3oB5sJD/TG/FIjm5WtR9BsMRxPr8iAsOaxO1Qbsulyf0Sht9wtqg7KICszFWj7MTUVmdPODdPEZU0WoS5R1sr8uuA7+aX3St79wx6w9WTKcb6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398914; c=relaxed/simple;
	bh=mgtNdTqzkaN8N4V1/T55LN0NAswMFpKEgTXlVE+QKcw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cSEUByYnRAAuhV+yG5z+snXP/uBrccrKWAxZqJFuBJypcX8v0zYn9ktQn5qEgtoMN3O+hHwZcw65VHNExtXj4ZnUhOpwgBkUuWxEM4vNhntfwFOufsHfjdPhfMy5eeAU9IYxV8abLWvJYn1lL2gFp0qlC0m0hO5U2WZjBZinKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=KplvVdEy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-787990149edso159158285a.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1709398911; x=1710003711; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M/d53LufZMh7nY9lLclzf68ULaBUxwU4N1OOUPIPtk=;
        b=KplvVdEyJA4SilYY7t64Nsb9cLpFJ2QiI1IlIxQP2lWLaGKeXI8OnaTGc7oNv3i6f5
         QRDetY8PRIjwtjlZeUq+Co7v+hBkDsFfUJ/JMoUygIDju533j7Rdfcm2iEmMdC+T+cvr
         jbkevcPi19ngRAyg9z/duIBF48R1f3Uh+LwXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398911; x=1710003711;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M/d53LufZMh7nY9lLclzf68ULaBUxwU4N1OOUPIPtk=;
        b=REHcEiX7KeoKj+lml1SveT896kPijGgRZJxBK//+pYHMOChod4TRruty/cuhzvF2TE
         ksJqoHjB1MonlMswr6yn4zbb6tPHlwsIeHkpu4OOKoEaS2R9NEx+Yb+aYz0Pq/I32Gd0
         hoeFbTowT9rztK9AC/Dr+YA3yABfIqVD7MJa170aSNBZfp8b+Se9kAb1BGl7NBunbTSN
         XsGZXdv8dZWWyGSBbuZMpcERyj8D3V3uuyT9DL/JW8bt53JE44IQuvw1B6GIxe+M516l
         NPLtj0ardIE7c4X7HQuMXK5PddXr4WxjzDF11PtF7uvEvMZVCBueOK/dHcn3EJajHI8O
         KbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzwjSvBGcqiJWDbfutWkpRSsy4vvx4UyGVHH3esFTM3lU60QSNk7QuFDytdWFuW5kSPkaAuHMKQiIQJ3iEqcLNyvby8hTqYdZpAHJ
X-Gm-Message-State: AOJu0YxelX+hKIc8cVaeCyadEjUCndK1qUzDp+9mO9IVuajA+/BFzMju
	gaMMmH3eLwQ8pCiISsOLDhX5erjSRMvDyCFGEkebe9lkGwDzo+tO8bafDkSVb42SBEXY3evbR0V
	T
X-Google-Smtp-Source: AGHT+IH7vngvYZmQZRUy7lTviPrFi4edHwk1G1lnR0on/W8OBU5z7N3PNSLpsQkk8LB3/I70w+FnRw==
X-Received: by 2002:a05:620a:1a1b:b0:787:f097:45f1 with SMTP id bk27-20020a05620a1a1b00b00787f09745f1mr6236196qkb.33.1709398911366;
        Sat, 02 Mar 2024 09:01:51 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm2684871qkl.91.2024.03.02.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 09:01:50 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivor Wanders <ivor@iwanders.net>
Subject: [PATCH 0/1] platform/surface: platform_profile: add fan profile switching
Date: Sat,  2 Mar 2024 12:01:46 -0500
Message-Id: <20240302170147.13026-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch adds functionality that switches the fan profile when the 
platform profile is switched on the Microsoft Surface Pro 9.

Previously, the fan profile was not changed and that results in poor
thermal performance. This makes the behaviour and functionality identical
to what the Windows drivers do. 

A plot of the different responses to system load, as well as recordings
from the SSAM bus can be found at [1]. Based on discussions with
Maximilian Luz there this patch proposes the following changes:

In surface_aggregator_registry:
- Rename ssam_node_tmp_pprof to ssam_node_tmp_perf_profile for clarity.
- Introduce ssam_node_tmp_perf_profile_with_fan that has the has_fan
  boolean property set.
- Use the new ssam_node_tmp_perf_profile_with_fan for the Surface Pro 9.

In the platform profile module:
- Rename ssam_tmp_profile_device to ssam_platform_profile_device to make it
  clear it handles more than just the TMP subsystem.
- Rename the enum conversion method to make distinction between TMP and FAN
  clear.
- Add enum and set function & request for the fan profile.
- Ensure that if the module's has_fan boolean is true, the fan profile is
  switched whenever the platform profile changes.


[1]: https://github.com/linux-surface/kernel/pull/145

Ivor Wanders (1):
  platform/surface: platform_profile: add fan profile switching

 .../surface/surface_aggregator_registry.c     | 36 +++++---
 .../surface/surface_platform_profile.c        | 86 ++++++++++++++++---
 2 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.17.1


