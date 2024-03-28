Return-Path: <linux-kernel+bounces-123681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB5890C99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B98C1F24222
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375EA13AD2D;
	Thu, 28 Mar 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcM7dHWi"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE13AD21
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662016; cv=none; b=aDVYpoY844W9KqbSvtp4Yk6V83KD+tTAqYgpbnNYHVD2qBZXCpSuGlWMH+10vSwUc7hbBtCf+/XPSF5N/SNjkKiMR7CiVB9M1qpFHztrE4GuOwUpRNlDRNPA8CFE4Bbh/TWGvG4X9jMd0BjXDs6nmOdrQWx76bSkuuaMQ0Onnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662016; c=relaxed/simple;
	bh=Kp1+y90noEoG+dr+07Ld6RM/y1TkryNzEol5VSanxbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJEUjgWmRqsNoeb5eEAuM/OReDYiEHWUuJcnipgUdnEwS0aKXV9+/L62b8xMyn+Y+PlyPHHhoQa/zOR9g5TLBBWbWgXBwkEUaQtVgkENaIn1JgDGQH9tcqRAqrHR9lc5aZ+adSK67356nI5el6G6sVHa+ECSdZ7bU7CF1USULnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcM7dHWi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so7791a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711662013; x=1712266813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp1+y90noEoG+dr+07Ld6RM/y1TkryNzEol5VSanxbQ=;
        b=qcM7dHWioOFbBKOZKFiQdqYFDxslcx3ty47jd33ovDo9cs/3P651UqBv7aXjGFHCLZ
         AYcFLTd8ZWCXguO8n9mi0O5ri7x/p54Oq5QHFd5OydroSpW+PyMAOyollnbLta9K+TlZ
         0AxJrUb2qnXDqGNm3Kj17U/VcBTGr+/2BaePC11WF5yMQOVgHgP7NfcYDcIYafBKufcu
         egj+7O0hG1DFQtxRj5mZAyJnR0us/hN0Qti6I2Byo9ypYMLQ7jG4g1TpMAT7F8irU8Kl
         jCJ8rPsUoS2nmsAcPyjLzMlQTOE6VWkpSKH8FNjSXyNfy4PyA8ApddwISt+exzj+0UQH
         c4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662013; x=1712266813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp1+y90noEoG+dr+07Ld6RM/y1TkryNzEol5VSanxbQ=;
        b=nRVB8UegHBeDaBO3d3fJgKjhL9r9oIO0ZDgvHsXnm4QxX5ncQDLtF31loIG7l8dPrX
         ZEfsaMhusUjckr4IlnoFWheUprKMUIdJBOfmloT+tZQfybiQxg0xn0Cud2nv8etAfUK4
         XprOahzaKM8gGxcite2mNqFSePBHiB4f0DHJ2BKqvG0SY6Ni7HDYEs7D5eTQPhk3m5hc
         st90FptcIM74V+im8PRiLUHPXSmcNxn/kMXy1yEKPS/WuoIrzMIwwrDR6JUw+o4J7Kn8
         3ojgvcJZjbYvD62183/sFE2TIskBjvxbcbJ6QdoQnmnod6HFsu9VPBx0D6ZnuBBDz202
         frcQ==
X-Gm-Message-State: AOJu0YxWTB870IDr3yRArkfTf/3wWvf4p6TiWLIitn5FUvGlmiM2JJTb
	O4JmwCd2/yZB2/Aww/Wo47yoonLsJAHM3mG8NiJkF1cQPOlZa+/O2VpHCNwCL88y7bv/paHUl9F
	ouU4th+Onk1maj5O9Oa14OKdYCsuBLJlB9DQ=
X-Google-Smtp-Source: AGHT+IG2w8CE2s7adoSlzmscCVPD6oi/Du9Xupvo38pYgO2C4lDyzCpN1SwvZPsUxXXCA8cD9EIWcyohcl9vqic/rDo=
X-Received: by 2002:aa7:d1d4:0:b0:56c:597a:d4c6 with SMTP id
 g20-20020aa7d1d4000000b0056c597ad4c6mr10785edp.3.1711662013071; Thu, 28 Mar
 2024 14:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172048.548199937@linutronix.de>
In-Reply-To: <20240325172048.548199937@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 28 Mar 2024 14:40:00 -0700
Message-ID: <CANDhNCqwdVDEk5+rTpqX8EmPm=UkwSoeySbGV_h-cg9oTKq+Ag@mail.gmail.com>
Subject: Re: [patch 1/1] MAINTAINERS: Add co-maintainers for time[rs]
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Anna-Maria and Frederic are working in this area for years. Volunteer the=
m
> into co-maintainer roles.
>
> While at it bring the file lists up to date.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Sounds great!

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

