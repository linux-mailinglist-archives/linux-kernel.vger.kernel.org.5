Return-Path: <linux-kernel+bounces-28489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B010582FF28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D41C23E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC44B524F;
	Wed, 17 Jan 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpIIhHUN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30D4687
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461142; cv=none; b=uJp6QVTc5e3NX05Zu1RMMrIGSFWuu/JCmKq0Oc4WYRB7h95Y6jyqR1X2KhYGHoRgwP6aFAQHMzGnen00af5PswFKxB03EORs4b3kWyLXR86ishLyqaGG/brwe6pgFJ8RnJJrUHtvYiyv2+iQTAmReHEgwYZRX4AIwe1AcsyPTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461142; c=relaxed/simple;
	bh=DGkXgSA75PEV5OWswBNpwSrk2OMbmNdsBeXCUf4RcDg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=UW+NNI9CRbmHAucHuQd3gLgV5bzoIoB55rxeGJjxoy5GF8b20iGDZdufeob8YWWI5obBaYVwMyEVfZsoqCx5puBmKWswrUcTuioykjdfPhp7P64zWcVhOkZ6k6BX/Dwy0HY4w0FW+VQsCBjNTmBTWdfWsAgFRnECJrcs2lm6SA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpIIhHUN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559bc4b063cso1148048a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461139; x=1706065939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgJly174tiM7wU2wdf3QPw2xjcF1it+Gf9c5BM/HUdU=;
        b=MpIIhHUNcNioyPjXbNpwuc2Nn0v+LgrZdtLJmW5ugM/srnMJrjlkTsGXZDb0iPpeCp
         ntWVEGDAORMPQVPG8yHes+3vyPra5jTOaRAw5zsI5gMypQQcymMJggWiKB0gBWa1eAly
         RR98bdHL80IdZbuJ7gpTrzajD25/UKxbtM3M0cnRBArTxneRYD2r7Ua+1m42E7dYRgO1
         ED5+swFy8qqk3umPwHzYkrP4EE/bPhOeYXUzrtN6HJnboJEbuV9denuozbGuyAWj9dFL
         TWhel8D19FkAeS59uHmUjkPG8qZSX+AbyPEbHxcZNgqyQ0SLjxtgfLxzWL6gClVnI/Uj
         uG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461139; x=1706065939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgJly174tiM7wU2wdf3QPw2xjcF1it+Gf9c5BM/HUdU=;
        b=i0V7dQXafyedXpHV7e6uOo97VGeypk9SuF8vYfwYNin4Xl94iOCwNxjF6a33TpWThG
         HvmVSJC6phKSAlMW5Q3O9DmtC2018BVdnHUFmP7BsfiIFLmOFebbLgUFS6FsXUvq1xe9
         vDYrd09LEkdiJs09Vk33DFCeHyeUxg5SDJJiTNol2AoXKmee5KYyqVa41ZuoHN0Vvlzx
         aMg8bRE4wHH6Iq4h6ge62G62SfxqOTPHW8sZtvjwAfucrcYztg4I0FGtoMEXgVYWh75G
         3DIZ+7CO3+bLXa2IJ2wuPtRj4UP2Es+X6Fq8SV5MYyG3qO6qSeSMaeQiHrlZAPokvlzk
         4qpA==
X-Gm-Message-State: AOJu0YzZYDM4tVO4VHiv/Gi4HcC1UPY6uJm/uwaIlfp6PH7c3Euyq/rM
	xPkxY8fStc4+99ShilvNdTs=
X-Google-Smtp-Source: AGHT+IF3Mtz0neSHZglpJaChYFRyU3wCE0V0Yh2hb5IoExwBm0o8NlPDjsDyqDHpOvHo1u492LlMTg==
X-Received: by 2002:a05:6402:5214:b0:558:c366:f010 with SMTP id s20-20020a056402521400b00558c366f010mr4914667edd.24.1705461138849;
        Tue, 16 Jan 2024 19:12:18 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:18 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 0/6] drm/lima: fixes and improvements to error recovery
Date: Wed, 17 Jan 2024 04:12:06 +0100
Message-ID: <20240117031212.1104034-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been reports from users for a long time about applications
hitting random "*ERROR* lima job timeout" and the application or GPU
becoming unresponsive.

This series addresses a number of related bugs, especially in the pp
timeout recovery path.

Patch 1 fixes a stack trace initially featured in a user report here:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/8415

Patch 2 fixes a "pp reset time out" message which was fairly confusing
at first. Debugging with an application which just submits one single
job at a time made it clear that the timeout actually was reported in
the application that runs next, even if that is a good application.

Patch 3 is one of the most important fixes and stops random "mmu command
2 timeout" ppmmu timeouts that I hit while running my tests. Initially I
thought it came from some race condition on running/resetting jobs, but
it was actually due to hard resetting live tasks.
After setting this there was never a mmu timeout anymore (even after
dropping the guilty flag in the upcoming patch, which by itself was
actually the easiest reproducer of the ppmmu timeouts).

Patch 4 might be debatable, but hopefully we can agree to go with it
since it was already discussed in Panfrost here:
https://patchwork.freedesktop.org/series/120820/
It is actually not that hard to reproduce both "spurious timeout" and
"unexpectedly high interrupt latency" by creating an irq which takes a
longer than usual to execute, and paired with the issues in timeout
recovery this could cause an unrelated application to hang.

Patch 5 removes the guilty drm_sched from context handling in lima.
Often users report issues with a user-visible effect of "application
flipping the last 2 rendered frames":
https://gitlab.freedesktop.org/mesa/mesa/-/issues/8410
This was ultimately caused because lima sets the guilty flag to a
context which causes all further rendering jobs from that context to be
dropped.
Without the fixes from patches 1-4 it was not possible to just drop the
guilty flag as that could trigger the mentioned issues and still hang
the GPU by attempting a recovery.
After the fixes above it seems to be reliable and survives some fairly
torturing tests mentioned below.
Other similar GPU drivers like panfrost, v3d don't make use of the
guilty context flag. So I think we can drop it for lima too.

Patch 6 is just some debug message cleanup.


Some of the tests which I ran with this patchset:

- Application which renders normal frames, then frames which /barely/
timeout, then frames which legitimely timeout, then frames which timeout
enough to trigger the hardware watchdog irq, then goes back to render
normal frames. This used to hang the application at first but now
survives the entire process repeated indefinitely.

- High irq latency from an unrelated source while rendering. I put a
mdelay() in the touchscreen driver irq and could cause all "spurious
timeout", "unexpectedly high interrupt latency" and actual timeouts.
Those are now all reported to dmesg for information and I am no longer
able to cause an unrelated application to hang.

- Game running with lower configured drm_sched timeout (locally set to
200ms) with other applications triggering timeouts in the background.
Different applications trigger resets independently but none of them
cause the GPU to hang or the game to stop working.


Erico Nunes (6):
  drm/lima: fix devfreq refcount imbalance for job timeouts
  drm/lima: reset async_reset on pp hard reset
  drm/lima: set bus_stop bit before hard reset
  drm/lima: handle spurious timeouts due to high irq latency
  drm/lima: remove guilty drm_sched context handling
  drm/lima: improve some pp debug messages

 drivers/gpu/drm/lima/lima_ctx.c   |  2 +-
 drivers/gpu/drm/lima/lima_ctx.h   |  1 -
 drivers/gpu/drm/lima/lima_pp.c    | 26 +++++++++++++++++---
 drivers/gpu/drm/lima/lima_sched.c | 40 ++++++++++++++++++++++++-------
 drivers/gpu/drm/lima/lima_sched.h |  5 ++--
 5 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.43.0


