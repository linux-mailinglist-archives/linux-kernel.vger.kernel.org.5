Return-Path: <linux-kernel+bounces-69482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB40858A27
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028B71F22E52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365714900A;
	Fri, 16 Feb 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2bFIjdJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2411487D6;
	Fri, 16 Feb 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126210; cv=none; b=KubILkXCcJrBr3eC0lZKrnE33k/7FJdWAgvNVk01G3JNbEAy/L0dUXSYBa3GotFgnKYygUCdL951iZIAE2NKltUrp3uBJhrGYBqy2bVFhdGgKiil3qhmv31fD2VdO34Z685deDM6wDMsZsrMALazcvCoOhTzemDECpoctPXW1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126210; c=relaxed/simple;
	bh=FMVWaPEG1nX3jE+CDbdrHVeNP4wVjb/A2lK/tKqysmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q3be95nbKAz2Nw+CjaQtTUgYADQRkThEg4GwOq4xwPEaYJdQ0YqZVE8BV3crADPnRjg9TSngVm9mOLAvh98V6BrQKrt0k1ozQYi4rS6mRgLzrnZGApRIQEgNdhM3pr+MkcoP2bdCa8s+Ew8vhS4Rcfq1v48MZAMpjU5gLu82l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2bFIjdJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7232dcb3eso9868805ad.2;
        Fri, 16 Feb 2024 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708126208; x=1708731008; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E0rm8oJW/XJYG6K14YhQ3ephozjzMlAvikt0W/eKgk8=;
        b=V2bFIjdJXTa82sy5ct7qxx7308kt/RBCmvKSccHePrVK3wUjn4OSMoDSctQlz6snHD
         gtncmo/z6AtdSucc3+EdDMq3fWJ3lXkO33HJbzH8KBP0KwTvLWvj4kgdZ1e2dCQQJDdH
         6rKvduHIQS+hzTOFCfD37y7DbBKb24s3K06/gdLwKrp5n2dCmSmJjJS/lUGSN9loAKmX
         MTvQyf9I9hO8rsOvefu3mMyN7Pc2P+jqcJ6xaOM60Yf3brvURdNFQDVxxdQ9YGAhn0j6
         iDu6aewjTaULiwxJSLdIChROpsq7cVyuc/jmjz8z6AuPOCFP3KfCwaDKd18louUq6rAi
         R1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126208; x=1708731008;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0rm8oJW/XJYG6K14YhQ3ephozjzMlAvikt0W/eKgk8=;
        b=ALek6IdXzS5ngz3PgRTJ5LsUFyF3qEZEHlnMNc5QYHr9zk2aCTk/Dl40Fu6Urh2s/x
         W3z8ztM3yAhX9qFQox026hClj/kmDU95BWKePsBoFxCrz7AzQdACPedcseNoKDqHBeBy
         kBBW7h7zqCc2qlKpJSgWbHmksqBo0xW+A7RvM0Vr5RRimJTD6xWEV/WZXkwut96P/ylf
         2B2Ulsyw5KYNyvKnYRyxNJQfn24NldYUpWpxyE7lN4tJJvwgH3JIJZyFBs0kLojAouKS
         F0fOAYpVEfynsW0lJ3YEK0Vb8o2/7gXiXs7tssGBsfWdKOra7ouBHilS8PHHuiRX9t7K
         C2gw==
X-Forwarded-Encrypted: i=1; AJvYcCVoqmSwqguPSNoNoH/x1vwrcjR4ji3LGkZnFi2bedmEZBq0wB2SrQu9ygrWqtKItuWvrh8NeybnQlRGBRLfJMgRYr7cvzcu4Nv1jDI+
X-Gm-Message-State: AOJu0YzoPClki+EGYJ3aC4hBkMQAritJpsX3b29DNHzM87Y5OKnMh54Q
	A2ZeIgvBKTRj2xCErR34Gd8SsfRz3Z571CCDfooX0L3QBwnv+yx7pjYCTJN9a6hOUUfqoc4indo
	JdZufU9+yeZ5/gcgtL4DvY+Qicj5g4CVATqU=
X-Google-Smtp-Source: AGHT+IG8NGWNkQaKqUI/eMg10+AC0G35IgZ/oydeFaacpUBCAryssRpS62z0cOhEkKKKzCRnv4hh3ESYt2AbMmLkZIc=
X-Received: by 2002:a17:90a:ce8c:b0:299:56ee:6946 with SMTP id
 g12-20020a17090ace8c00b0029956ee6946mr165826pju.32.1708126208110; Fri, 16 Feb
 2024 15:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: noman pouigt <variksla@gmail.com>
Date: Fri, 16 Feb 2024 15:29:56 -0800
Message-ID: <CAES_P+_0tWVtn+tyUi1TvkWi4rA-ZBj8e7_pnJd1h_J3S3Cn8Q@mail.gmail.com>
Subject: Audio dsp recovery using remoteproc
To: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"

mailbox to dsp_1 is currently modeling platform pcm driver.
mailbox to dsp_2 is also doing the same.

Platform driver callbacks cause IPC to be sent to dsp's.
Lifecycle of two dsp's are managed by separate remoteproc
drivers. Single sound card is exposed.

Separate watchdog interrupts from the corresponding dsp's
are connected to remoteproc to manage crashing of the
individual dsp's. How can I restart both the dsp when either
of them crashes using the kernel device model? Remoteproc
driver currently only restarts the crashed dsp instead of restarting
both the dsp. It is needed to bring up the hardware in a consistent
state as both the dsp's are connected to a common hardware.

I thought of making a virtual parent remoteproc device
and then managing individual dsp as a subdevice of that parent device
but remoteproc device node is associated with the individual elf file i.e.
it can manage only a single dsp.

How can I model remoteproc drivers using linux device model so that when either
of them crashes both the dsp's get reloaded by the remoteproc framework.

           MailBox ---- DSP_1 ---
         |                                    |
Linux                                      ------ common_hw -> speaker/mic
          |                                    |
            MailBox ---- DSP_2 ---

