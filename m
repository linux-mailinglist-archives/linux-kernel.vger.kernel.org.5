Return-Path: <linux-kernel+bounces-56278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC384C83E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9D1C21065
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF92555F;
	Wed,  7 Feb 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNHzpgng"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D957250F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300386; cv=none; b=dAYz2XMYLja1uNZiHU0+ycRfA+hEOOnV+VvKZoQLjASx92krZ8KM5yqmS1WWwoqEBjElJZj2AJcd8VH+JG/6zu65DAJOUO1vCiSsogUe3uvydXbrd7KT2EOrltSKvnTFjvZ8Xv0fbpZcFYywYnuq8Mk6FSm2ndwDRX+CTL3jm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300386; c=relaxed/simple;
	bh=Jik8leFC0KlwrVebA3uRhtiGLFsrbgU9Zi7josFPrDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X5E7PcppJxljY/+SYaJWjxX8DJ+KguPq6fWQ7WgKlZV/bZkqZDxVJx782q+A1JQCCoXo0nj0xaWMXuXz+Ysordt6ArbvziCe6CrYW8BEaJTblXdmuZNgjDLaZtXjQ8gYBnfPhfJVKGh7rs8n6XmjwaS2waLfJG2n3UGsYkZBskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNHzpgng; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041c45ce1cso7273667b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707300384; x=1707905184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhsgtWrjN5DTrTIswAcbtbIxanspnt64Vbtpc0B5slc=;
        b=lNHzpgngfBWpmu2bevk+ehYkQsRBKv7vyT9gHbs2+YUVY2xLiiTy8G+QKmS85kkHJb
         C/ObbD2SBNfvFdPw9qgYkF8nQjA+Gzny7qcBlQcT6iRWezSffJC4JafbWBnirBoFgxeO
         TMWly3nGsX6yWaCrQ0Cnm7IzWXw5NLCTewrNGBKWC4nXxDLH40a7+sMm9K2/DQy4vM7v
         cxIcGGdgzHyR8MqUtUpITa8qx1ZpGFw/3wfWtRS5WhskHr2yCDcbIK8Jh8HuZzolYAq/
         kN/buGKu6d13G3UDfAkVLkOAaBBrRyVG6j2cVyj8lPDYvd0SHksMW/OGZYvSIqrXZSyW
         n0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707300384; x=1707905184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhsgtWrjN5DTrTIswAcbtbIxanspnt64Vbtpc0B5slc=;
        b=CGMpTJWF6xJLP2lhF2GsdVJGU1phKlDANZAhhfvwLHCUSKMFi4nLqZf0oPuZIv7E4Z
         DTzairdPljIa+tEB+10PTRVmZORTIauluimwpdFPJbao+dGAPg7tPGS9lHCBDMc6C6Ej
         lRbAjTpk7/Yb54mNDx5Xr30gLkJzRf/R0ET6yvbvcDSBaLR9kwJ9ecCGi1Il65meLhAD
         rojFxyxqakSOzx+9eCgI7SyPpJlI6P6VV2j5P4CPvqPZsG/buNDBT/7PjFSmNC25AWM8
         y3a7ayVnwsZpIuU75o+yRzVD1qMO3yvp71WPafA44rPVGskUc13JC2r8WhXIGyq4oo7A
         yO9w==
X-Gm-Message-State: AOJu0Yx+CdvpfvH33NrlY+U+U0Lht2/49PQdQJmVpWgDlKW/s9SNowcw
	LpuZ6lluJQqBz2U4ukEFf82idx1SvofVEoEQNniFAyu0xIKk0BEVjiFwV3S68dFf3wZY790+34o
	sNhzOoS0f4A==
X-Google-Smtp-Source: AGHT+IG826mXiT3l8PKL4Xb/aftHAWd8XOkOxEe6uPtznbtzaVbQXiqSa0qIqDPdRZklmzifdfjGzQ7VaYfAGw==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a81:9a8f:0:b0:602:cb41:99ad with SMTP id
 r137-20020a819a8f000000b00602cb4199admr748759ywg.7.1707300384433; Wed, 07 Feb
 2024 02:06:24 -0800 (PST)
Date: Wed,  7 Feb 2024 10:06:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207100619.3947442-1-pranavpp@google.com>
Subject: [PATCH 0/2] alarmtimer: Rework the suspend flow in alarmtimer
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

During the driver suspend phase of kernel suspend, alarmtimer's suspend
callback is invoked and it identifies the earliest next wakeup alarm and
programs that into the HW real time clock (RTC). However, there is an
exception to this process. If the next alarm is within the next 2 seconds,
the alarmtimer driver fails to suspend. In this case, a non-trivial amount
of power is spent to freeze and unfreeze all userspace processes and to
suspend and resume a number of devices. In the vast majority of cases, the
imminent alarm that caused the failure was likely already scheduled before
suspend even started. This provides an opportunity to reduce power
consumption if the suspend failure decision is made earlier in the suspend
flow before the unnecessary extra work is done. This patch series aims to
achieve a kernel suspend flow in which the check for an imminent alarm is
performed early during the suspend prepare phase.

Pranav Prasad (2):
  alarmtimer: Create alarmtimer sysfs to make duration of kernel suspend
    check configurable
  alarmtimer: Modify alarmtimer suspend callback to check for imminent
    alarm using PM notifier

 kernel/time/alarmtimer.c | 178 +++++++++++++++++++++++++++++++--------
 1 file changed, 144 insertions(+), 34 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


