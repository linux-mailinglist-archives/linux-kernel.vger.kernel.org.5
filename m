Return-Path: <linux-kernel+bounces-158977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D58B27A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144FD1C2103D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36D14EC51;
	Thu, 25 Apr 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJ9PStDT"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F914EC43
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066656; cv=none; b=R4v+mrYMcUKpVxM2wTfAqHFxiBxKbUduu5TSVqxaTakdBeOcRP52yf35hXzGFcHIGdeOeSzur4/jtryuBvZUwp4Y37t8rIBykH83Bp0l+0pFd7BgwpdkEnrnPyFZ81e1W8OwThSDRTixY53gYb+wEAJrF3U8ccbSGT5s46X4k+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066656; c=relaxed/simple;
	bh=B3VQQbOwXZfXUmtHrc/wDZo3lxxcsHSUDqcA5obudZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LE5MGVWGqGStRm4bK4zhqQzCuKhwJ4o2boyC+85gclpvJnCETemF9u25Hn5ZLJVe4NAG1Kbp+ULjcxXZuri6HPq0c7u20ckJk3p0T6uT/WjNd2flYqhUYer9045HZ3aFgAV+IwdwYpTZlw+UYkoVURBSYz6mPct4mv9Q1i+EA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJ9PStDT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so1057a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714066653; x=1714671453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3VQQbOwXZfXUmtHrc/wDZo3lxxcsHSUDqcA5obudZE=;
        b=XJ9PStDT7Y8jirOyfZyIFA//mDF01QzJ/i1+l2MS4UIu7EfvC/h/s0R5QWRDrzx6LX
         aKKNDx4WYv+O8Lo+AZYp9CNX6ZL3gxV3Css62Sp8S7+8S5IDLODsuWPTgChhHmNE2ViT
         Ca48NN1SbWyc7WEPMrn8WHgnklcjeGi3NIMTesqDGcTp6rjvvKdcNb+9A8hSJYm+CPoV
         HTgnZvJlXSv6bTCSXTIXKqecDgOsmf/eZFeE5ZtYO5ZILA5LlO4rCjejf3lkueObwC6g
         Qi8c87B8DLqXcvmRyf+mENC7jGA2OK9LFd+u0N1DNCIKmj5Sk8hk+507CDaHkuRwv2zE
         Cf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714066653; x=1714671453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3VQQbOwXZfXUmtHrc/wDZo3lxxcsHSUDqcA5obudZE=;
        b=l9NML13BCPXfMRF3SWS1utKkKinhPBMb36Hl3GlY2LdACZ/Pq96RUbzqzIIH5sS1ze
         V3Cqra+rdGj3ixnVl9afHWfwQEroq8ePwenQLLBGISrC9lYIuqZ5k8EnpjFl/Te2S8fN
         u+8dMAjDWa6SFU2HsjcYFeSwqZCBxW7fnlHiPxA3Tsf2QJESxkIdbvbaZdCV7d6X6LK1
         rPrsdQ9Vx4pXFlOXgHqIT06QyIRfCQMdJUbAWffrjiAxx26BKTBir21fTlPf2AeAW0Zy
         CKA8i9hBMomsR+dI2i/NlVjfo9pYupS6hxNX3HiDnOAb/JgFW/FWsZf+Y/bN2Pdi6nG+
         Quxg==
X-Forwarded-Encrypted: i=1; AJvYcCVbzkRXXE7PdttFKGVZ9/qXJVKDVJKnscUJRIuTaIMvS5n8RcuEBuOY+o1jzgt3GL7t0X764z++aR2l6ZyOahoQe0g4HogJoRuwtPgv
X-Gm-Message-State: AOJu0YyY0Tooi896S/sJbaTdL+afWvFvqBNdQ19N8tAMI2GYObBC66Vd
	SIOvwZ+oRf2rfJjdxFG27cbsda9bZ8EdPB4NU/vRGE9N5KisNlDm5bbS69C1NEjgPTec4aXWiTP
	DXwu66anSFyZPdhLlepe82R/6fLS9t6Kjjzh6
X-Google-Smtp-Source: AGHT+IFKlAa7j1Xz4j+lOypC9P67WdmU7m5EBPVuI2N+LZ83FdSHLfjKJjWvf5ZCaKEst8Ct8pg/Q8TRbIRqvXn85RA=
X-Received: by 2002:a05:6402:30a1:b0:572:3fb6:3d0c with SMTP id
 df1-20020a05640230a100b005723fb63d0cmr2428edb.4.1714066653043; Thu, 25 Apr
 2024 10:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423202356.3372314-2-rdbabiera@google.com> <ZionHYcUvvc865z4@kuha.fi.intel.com>
In-Reply-To: <ZionHYcUvvc865z4@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Thu, 25 Apr 2024 10:37:21 -0700
Message-ID: <CALzBnUHL4kWTQEncWfzNyze25_Ss_Pf8pyR2FOauyoLwNRrrMA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: enforce ready state when queueing
 alt mode vdm
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:49=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> I'm probable missing something, but wouldn't it be safer to check
> port->state after grabbing the lock?

I could have been more explicit in describing the deadlock, my bad.
But there are two
threads here:

Thread A starts in the TCPM. It is the port state machine that
transitions to DR_SWAP
and holds port->lock. When it unregisters DisplayPort Alt Mode, it goes int=
o the
DP Alt Mode driver and hangs until any DP Alt Mode work is finished.

Thread B starts in the DP Alt Mode driver. It attempts to call tcpm_enter_m=
ode
and the call to mutex_lock in tcpm_queue_vdm_unlock hangs because Thread A
holds the lock. Thread A will never drop the lock because it waits for Thre=
ad B
to finish.

So, the check is done before grabbing the lock because the thread needs to =
avoid
grabbing the lock in the first place. If port->state changes between
queueing and
sending the message, the VDM state machine will drop the message anyways
because port->state isn't in the ready state as well.

best,
rd

