Return-Path: <linux-kernel+bounces-56602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0B84CC6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237501C230C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C67C6C3;
	Wed,  7 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AEM1TaGG"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D57A73C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315227; cv=none; b=ZSI0+jutlImPmFuQjAK/hDO5LJwA3/07WwknaRopZxwzcBe6gBvePnRj0PTeN8+3d4Hl+lglotxbAZdsPdfGJfDx38kvG9nS+BZghdOLjgXES2+9r/zZHe5qQDn2eWrkD3DylajU4yGBZOitTR1iaXaFP9jV1xIMc7Gp7DXL7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315227; c=relaxed/simple;
	bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5EG5TvReagfpKbZ2nIT8RBz7Gyq4SkC8HY89cTipjGcTFL0I4Clg9Hwf2YfZVlh56M0/jhEopxOViMZYAt6dVGY82zCifPWZ1RTQrzgxNe7C/s9NaYPIKRR3v6hMDZ7ypwZ0UdNmsMapmYz+a+4I8hUtELu12Wn15w7EplCi9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AEM1TaGG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so2785341fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707315223; x=1707920023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=AEM1TaGGJL4wfEqm+2q9peXuocQIkjrQDjqZWUgmrqbKh2c6echwGBVUOkHYGtL1Jp
         02AhZevn+De6PN7zGsB819FgrNnk/pvSqHSCA7PPW//BH4iRu3GtCxMeDnF34BH9WieF
         R1hLL0ZneyOMPuS0eERh9ZDVSUIzkN/ZJ2rKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315223; x=1707920023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=gf8kxdF8CuD6tHrKD71MfCLr0j0fYKzNGz++3vTS1ZZIba6QUlyE7gQW5qgYcKB+Nn
         Vg79n15WbNhZ4+bPQMHZ+eTz73r3QzXx47L0DcSTrHWzP7Jq/cJs7ZXXUcepgs48aYo5
         maRxafNczOZ0hc8O95edo/zXHHdmck3LhHVuv1cs21TIntfJVRnv6J9iawO8SgrUdOYk
         dhTew0uaGZBWITnly11XH0a9czgyYdAS9zlo9i9IaIbGCqS3qMDbxiOnQ94eXa5hpRQ0
         fM4AtSYgWREXJ1QBtlbccAUjhhJKSELESXC0Foj2m0wiaqQYRtsBOHf5jLTM0iB00pX8
         tH+w==
X-Gm-Message-State: AOJu0Yyn+FNcVunprkICqU+MeleObu0GHT2ZdRZ2SZiebBP5rJXDrFoG
	SuALdoJ3uKxXW0zls7iwp9YGqh5PMgeRMs0286qAlIEZ/bVU9OPo5W4493cOV++oDt2guXRwWom
	f9QPnr/JBtXjLqlUXSMZHijEPQtGlQ3iGUwcJ9A==
X-Google-Smtp-Source: AGHT+IED9YAP6IjuLO7QGzwihwwoadtsQqIErozgRiEhzKfXYz5J89hbN3mS6Tn00zxP0ae3LMxLBAw1f4m1Z4XB0YY=
X-Received: by 2002:a2e:2206:0:b0:2d0:5f90:2b29 with SMTP id
 i6-20020a2e2206000000b002d05f902b29mr4579555lji.12.1707315222978; Wed, 07 Feb
 2024 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
 <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org> <20240207061429.3e29afc8@rorschach.local.home>
In-Reply-To: <20240207061429.3e29afc8@rorschach.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 7 Feb 2024 09:13:30 -0500
Message-ID: <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by ftrace_dump_on_oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>, mhiramat@kernel.org, mark.rutland@arm.com, 
	mcgrof@kernel.org, keescook@chromium.org, j.granados@samsung.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, 
	quic_satyap@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com, 
	Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 7 Feb 2024 05:24:58 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Btw, hopefully the "trace off on warning" and related boot parameters a=
lso apply
> > to instances, I haven't personally checked but I often couple those wit=
h the
> > dump-on-oops ones.
>
> Currently they do not. It would require an updated interface to do so,
> as sometimes instances can be used to continue tracing after a warning,
> so I don't want to make it for all instances.

Thanks for clarifying.

> Perhaps we need an option for these too, and have all options be
> updated via the command line. That way we don't need to make special
> boot line parameters for this. If we move these to options (keeping the
> proc interface for backward compatibility) it would make most features
> available to all with one change.

Agreed, that would be nice!!

 - Joel

