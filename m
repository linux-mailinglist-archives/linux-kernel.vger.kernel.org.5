Return-Path: <linux-kernel+bounces-59504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B984F81D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1132D282C48
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9A96DCEB;
	Fri,  9 Feb 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsUZrFYs"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267736B17;
	Fri,  9 Feb 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491067; cv=none; b=h7Ki8t956V0hk0WBks3exkahRDEdEW6MsXvUx2oGgC9VfYjCOVN0Ybo0wB0fnd1GgWkZ2fijqGH2vtbw5h+1CwZwduYMtMnqiFyhZf8b4bi5SYBCRSQTB2TTp5gGb1yjN8A8eSA5yukMKemWD4UH4hLiddgcPLBckkChHXDx4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491067; c=relaxed/simple;
	bh=ZRSisilKJc76i9g2Gk5VSIp9IkLwfEK0p1NI0di/5FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ISzQHr5UVdyKYy1Hjc8MCuog+imZPE75tUSE9wQYBfjKj7nDAkFzqfCpNG5GS/weTgk4YxeBdpj+uPa0KVG/FxZTLTBThLhxDkrTFILZy+UlAiamIef7bo95mTzW4Fm3YtsJxJ6YFounScpryS0YxrEw8vBcVqtlZMOKWZAvloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsUZrFYs; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59a58ef4a04so372832eaf.2;
        Fri, 09 Feb 2024 07:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707491064; x=1708095864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oEEKiyCy3uksk7VJQy89Cmz4Lyoddeyzzlh6/wRqFSk=;
        b=QsUZrFYsywdckeQjAV9sLT0y6VY3ahayABd1yCVZKiL71aO3fWwfUy+Q76fDDqDvaN
         1wq3JqElFIYJzB3fBw1x0H3bQxK09ZKZGlCJjy85YdAN4tOWKjFfRQotHn20aQgk0hHP
         2J3WP/3+x1W07vOZy2UFWTp9ZLTCeu1JYfWXShrS7lYXcGzewUhp5kJsq2rj0qaeiZX2
         ObAB07bQEvyWuOI/EB+tyCYkmbFfZgGG+C2OcWkwylcPe7dzIbhyyL9glTPWdeCzbJXq
         Bb4WWe5DJQq6ayQGASyNqKZLlyb27QzBrHxrzQqI6BFs3g/19vxvgESBj9WI6czsyRZy
         ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707491064; x=1708095864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEEKiyCy3uksk7VJQy89Cmz4Lyoddeyzzlh6/wRqFSk=;
        b=RweZkNR+E2duDspESX+8/hrXygzGerjQiG9TTDuFItWl/V8dZSnXRnVKSTLPHSXdLG
         8/AM9Wjexs/fKTCaoVOVVK7tff0qQ7KKPFg/kbtcoOdHDszdFtfOjqWFAI36BEgmNAui
         q3+WATFdDy3A58jOH15N5NjBYcjYyciuG76GimqowJMQ8fTT50wPFLpDwnaIeK6YOOEK
         fpPQme7jQ/IyTHFM7esQxmJRVc/ankr4a14WYmVsENBJgeOGFQKTO52/BYiKhAcVmZOy
         njGlbbjg8r9Bhko/Fgz8U+axpkajgEBdyI4SVgBfzOOPsAjcS4++KxjjJ5q4+4oO3A1S
         GSoA==
X-Gm-Message-State: AOJu0YwKze/7/NGCgyAtYi6wCtQMWXx1evC+gm5CjwD2YhyVoTeLVb/B
	51JWSFyqGsWyfD6gB4ysts2RLS0BH+u5TiaR7ksultx/fxNOD/04DcB7s7wL
X-Google-Smtp-Source: AGHT+IGzCxP5fmYlns2HciQeCc2tm9zi+LPxyPoweh3ez2FzylL6+vFnQDZWwgORltCMjdQzjprv5Q==
X-Received: by 2002:a05:6359:100b:b0:176:7f72:36af with SMTP id ib11-20020a056359100b00b001767f7236afmr2284406rwb.23.1707491064543;
        Fri, 09 Feb 2024 07:04:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUee3PEp0CsiUAvk4mmRwQmE92SnZt/BbnBKOmciFzc1NoSg5yMCHKKk4yj1SXTkMRVQD+nGjsvYHgagMn44ua1+67P3V2+jevwTMcw
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5-20020a632505000000b005b458aa0541sm1839622pgl.15.2024.02.09.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:04:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.8-rc4
Date: Fri,  9 Feb 2024 07:04:23 -0800
Message-Id: <20240209150423.1339290-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.8-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc4

Thanks,
Guenter
------

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.8-rc4

for you to fetch changes up to 34cf8c657cf0365791cdc658ddbca9cc907726ce:

  hwmon: (coretemp) Enlarge per package core count limit (2024-02-04 06:43:45 -0800)

----------------------------------------------------------------
hwmon fixes for v6.8-rc4

- coretemp: Various fixes, and increase number of supported CPU cores

- aspeed-pwm-tacho: Add missing mutex protection

----------------------------------------------------------------
Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Zhang Rui (3):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping
      hwmon: (coretemp) Enlarge per package core count limit

 drivers/hwmon/aspeed-pwm-tacho.c |  7 +++++++
 drivers/hwmon/coretemp.c         | 42 +++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 20 deletions(-)

