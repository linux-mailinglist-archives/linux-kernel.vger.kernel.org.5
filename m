Return-Path: <linux-kernel+bounces-67772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FC857070
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97C21F291EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC83145340;
	Thu, 15 Feb 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P4o2+uCT"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D313AA23
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035585; cv=none; b=ONjJLQtsEEoS6aJgvtOd/SIAj4wKnJzOHHxKB1zxC5GQp8pSTvFdYjvrckVkAUkqlOJIv3mm+lA7dV5d6K8tbwIH+BPyTZ0scPST0GraUHRPfjLeuAkLoNkiB8lBPKW0FgEgFnZY5E+2baDhgjQO88SDIAA0VkGL8zppi+6mOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035585; c=relaxed/simple;
	bh=t5lzTA0nIItmopI9Umsmp0Fv7pl2DXGoHCaMJc+PE60=;
	h=Date:Message-ID:From:To:Cc:Subject; b=D7x8cObor7WXXem60JDSJuoJFGiHUntANKpGmM6L4FTsDVbY1qVb3Ist/f5X4ZiLBwNGeg+6f7ut0514xsqUSvHcNIeDl2BmiT4qfyeg2hFLTWwqbbYOocMjKiIRuWumvkgW/bTi8KaplAQuvxUjk+pL+YuwTqOhsi0Szyjlu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P4o2+uCT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42c705e8e4bso8192031cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708035581; x=1708640381; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6kwSQjWLSvkCQdCfgG1xvDgzx+947B7zGFnqfTvyPk=;
        b=P4o2+uCT7A7qsxALg3e+CTOh73/v6zuCRZRj+QIInUx7Y9Nd9U0dy7xl+fZdsqmObs
         MPwDcM6a4LRVQXvoyT2cXshdh2EyQ7I7R8mabQdyzXOn41LjcPPOFTdz6Ga7wK2J7ayI
         E7Cz4jF97QdIiL0h5iBPIysUJkC661WWtqBChxoJzi7iLc4+tI18FhJPuxijgblRQZBy
         M6KJAHso7wJ8/qwwmeXk+OCpWsDOIL9uC9LoPGaZ9yajFFnrrvO/gLJKDVORaRJa9eES
         5mcaaHVk3q0Rtt3Rkx3U1W4EuXak4IRUvhJgJR0f5QOyJlgA4Q9R+hIevUV4XN66WyAZ
         RgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035581; x=1708640381;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6kwSQjWLSvkCQdCfgG1xvDgzx+947B7zGFnqfTvyPk=;
        b=xUkrwBqAxBl9/2MWkL7TIrij5zfCv5WX+fsvVn/yckhCXCLD5iuSMZ/7LyDDxYd+7M
         y239OSO/6A24kH/NSZEPlla4OZ6DvlDeFiLkXBTaz0Tg8CzqdTdVNxdvcLTvd8f1hBox
         zEz2H7xRK0obzp936GAy260zZoXCmaCdddERS8sokPX2cRdyNkRsHg5XRFPxOE0pHn/R
         JndUoXB0KyP08VZMBD89Im1/T4uRfcTOGeQ+qHuBRegcIN7+L7gly1H7yNgwd8t7NLsi
         T9i3+hyTlIGzhIP01I1Xgn/ZuU5cL3iK7CqgBQTaLIid01UKEFBtmAVy7h6XuAa87PZX
         HNmg==
X-Forwarded-Encrypted: i=1; AJvYcCUv237NHau/5KP9LcQhUyUEO7AlXlyZ2U6TYDSyblGILnBLxIEZPYtXVoD57NPBj2IIWeFDTF3OnLx2ijDxznBiGZuAmmAmTSGAY65m
X-Gm-Message-State: AOJu0YwvMXrGJIAtBUpioYl+Awi/re1HkS1fZYLcWvmZZhwxDM75sKl7
	wn/TRUxpCSbdE8skIbqw9oVlUH7/iZ+cUO4Y4KGCAmDWgNDhdv58Z0cL80wdunMrdRp2zkQGZ1E
	=
X-Google-Smtp-Source: AGHT+IEL5fVRQ5OTvPJwk93Gadl7MJ2rvpIOBR+XfkVlQDRRNw1Rlb0K/iyrEbEf7AXLbBC8i3l+Ew==
X-Received: by 2002:a0c:ca82:0:b0:68f:801:d8d5 with SMTP id a2-20020a0cca82000000b0068f0801d8d5mr3403043qvk.8.1708035581390;
        Thu, 15 Feb 2024 14:19:41 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id mu15-20020a056214328f00b0068c9d0561d1sm1087563qvb.83.2024.02.15.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:19:41 -0800 (PST)
Date: Thu, 15 Feb 2024 17:19:40 -0500
Message-ID: <6fcbf9b8e83e76678a0f520bfbbd6bcf@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240215
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

One small LSM patch to fix a potential integer overflow in the newly
added lsm_set_self_attr() syscall.  Please merge.

Thanks,
-Paul

--
The following changes since commit 5a287d3d2b9de2b3e747132c615599907ba5c3c1:

  lsm: fix default return value of the socket_getpeersec_*() hooks
    (2024-01-30 17:01:54 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240215

for you to fetch changes up to d8bdd795d383a23e38ac48a40d3d223caf47b290:

  lsm: fix integer overflow in lsm_set_self_attr() syscall
    (2024-02-14 13:53:15 -0500)

----------------------------------------------------------------
lsm/stable-6.8 PR 20240215

----------------------------------------------------------------
Jann Horn (1):
      lsm: fix integer overflow in lsm_set_self_attr() syscall

 security/security.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--
paul-moore.com

