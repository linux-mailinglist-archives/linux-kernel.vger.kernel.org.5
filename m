Return-Path: <linux-kernel+bounces-126920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B291A894473
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EF128304B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DA4D5A0;
	Mon,  1 Apr 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1dwGYF9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1021DFE3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993632; cv=none; b=rnzVOWvu+9CjAoQPT24BNig9Qkk6x5A1qSuPvK7/wBBk/imXxLBBYRmqROavA3KTxyZfVAJ2a/Z+yzznJc8YJPuLEaGGEyPxv9d57I5oe8fEEYnYboLrzp0H6Cpzo/lAJHfRu7ScXXKzlKY0M3h8sgF7qoBSc5/JvcVp4c8Xx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993632; c=relaxed/simple;
	bh=HK1u6SkkL43OAT84jN1D+VjNCICU3PY99BO7+1mDvhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTouJ+wmOXzkwwjlSYBdEyfVH4C+yxocp8sc7Joyf+QSa0NSljTHANHGGus7X+6OUcXQedxx9df9IdiBKK/vyS5n0OBqTjT+kfWZatpzUS/rjQGOituC6wfDJxZM8GP6C1I1xBepFZouy3LWeW8OxKDpCFHjDCo22E4/R0gzzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1dwGYF9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4156ae9db55so58785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711993629; x=1712598429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK1u6SkkL43OAT84jN1D+VjNCICU3PY99BO7+1mDvhw=;
        b=f1dwGYF9giyl0dLAX+jkYuSAeDvSNQXtxrFPIFPFxTnXR8aBSgpEZZG4GbmBCvUIh2
         1JA1Gp3RorqXdJJmj8Dq0LQ5O/tSiwtp9y4nC3TQ6DODKeoKfg0FbGiVEuhdOq/ifUln
         tZ67Pp02BfPabrKGGvREmncO/SfbfoVoQKLQXTzxxtAFNLRpJi68jJWxg5OniFKMy9uP
         vbg4L2kN0NgJfj4CulwfpQ+fRhOgXxB71OipD+oNzniMFWMIOmPyCbRe29mc0Pg8aO+p
         Epy0YjKkMkcXz04wAPYdyHWzRG1Lvc8mf3f1MXacA9PVstUWb0vn5cARobTmWnrMUzac
         043g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993629; x=1712598429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK1u6SkkL43OAT84jN1D+VjNCICU3PY99BO7+1mDvhw=;
        b=e1MI/WraKpCdBHu8E1FStjBC31JeX8XCuqxdflsXKk81FSKFcKMMx3DQyd4lqNu+ES
         BMSsYMGLKs5mPajcjW1Qf7rAl6E0qKCTOM7ADl3Wk7AnbVzQKRnsmSWiIsit+QHZLhaV
         ZhS4ML5dupVgmKr9WubjqCOidY8l3kaklBSwnNe7L/wojoig5x/KfRUkNMlCbQWi9vWh
         4NEVHlr0kMhpFQQbnXTCYAjq2DFZA4txIK9ci2zPyb8E96ju0/tm0x7IX4zlrNhsrh0W
         vc4H3MVHEL5GJaSdbvtBqakkgy+hesjpNHW/4H3D9MtvblmMDjvu9Y5IrqAaDW02Hg2x
         ZgiQ==
X-Gm-Message-State: AOJu0YxYVltwp/ifKOQGBqbbL6zNvwYXVDC3hshkldOD4kSAPcwXP5Mi
	Cm5TRI7W79c47M+j+IQnCwtil/oowKBypfEajOKNpyCPYmagq6MYAxaSFYtnkC6yYLolcaXLwgE
	Z2yQWVTn2zGL/+YYi3SHcoJ2VBMVVqzWMti4=
X-Google-Smtp-Source: AGHT+IETBvx5rLs3AuOylausCn3LzZsTjBRKWbX55k2RHRGbj20IYwPZAJdeIgf6n7r/XXVHPqiJzXKLIgXohjfNIgg=
X-Received: by 2002:a05:600c:4f85:b0:415:666e:9431 with SMTP id
 n5-20020a05600c4f8500b00415666e9431mr156180wmq.6.1711993629277; Mon, 01 Apr
 2024 10:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331172652.14086-1-rdunlap@infradead.org> <20240331172652.14086-2-rdunlap@infradead.org>
In-Reply-To: <20240331172652.14086-2-rdunlap@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 10:46:56 -0700
Message-ID: <CANDhNCrvRg_wTPkLQCbbooopfCgtmn_2OCgJfWs3NtKhsgx3sA@mail.gmail.com>
Subject: Re: [PATCH 1/6] time/timecounter: fix inline documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Fix kernel-doc warnings, text punctuation, and a kernel-doc marker
> (change '%' to '&' to indicate a struct).
>
> timecounter.h:72: warning: No description found for return value of 'cycl=
ecounter_cyc2ns'
> timecounter.h:85: warning: Function parameter or member 'tc' not describe=
d in 'timecounter_adjtime'
> timecounter.h:111: warning: No description found for return value of 'tim=
ecounter_read'
> timecounter.h:128: warning: No description found for return value of 'tim=
ecounter_cyc2time'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: John Stultz <jstultz@google.com>

