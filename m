Return-Path: <linux-kernel+bounces-126919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B5894472
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E91282D48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849D4D9E7;
	Mon,  1 Apr 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFsMa7TR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5064AEE4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993551; cv=none; b=NXTzZzKFzggpaEOODu7G7FpdwCgT4AvHDWW6+nTXhBeSkkmfX8jWqinpk0/dEx2jha/PDoEklqEwWYucIQiHN8g6kGzi+ioFJBEu0NuwckrhpiNOsxAsIRg1tzVPEJYsD8OvwW8z2Tt7Wq2O6H6chu+Na4M5lg0GdtAkpW6fh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993551; c=relaxed/simple;
	bh=LuSQ7x/5E/c4TEmXcwy0rxrtxa6YaB9Kf+fRxPgOOg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmoWbyxBH6mTQHFY5ZFz+HuEq/G/wwUW0iB756YLGAJRk3zhwOKDoPt/IcN3cxUDAl/6cYZo4Nlv5LstBcAiFc0eFIL7ErstZAJLTT82SXG2dg967c7lG8HEcXqW0LZ6lavmC9TkIuTi0rU8VjEw+zbd32ocEKclBbZeEF1sIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFsMa7TR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41549a13fabso212865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711993548; x=1712598348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuSQ7x/5E/c4TEmXcwy0rxrtxa6YaB9Kf+fRxPgOOg0=;
        b=yFsMa7TRkYZg4PBJwwIP3NxdDGndR3UruEWNYNO+S3I0jfgSSUOIqEd+ZJbmA1QOZW
         w6nDS9wHWjdrbv5msbM9temAOtrdGydXCRpFv1S7ykSHFpbHA5e85U79tbx11D78dzBm
         Vp77KxwybePqYb2HkK2c1rzCt3gpX9JAjOhPnPVTFQn+QXfxydu7EaYlspp2ti27Q+J5
         4IksVHCzJFaedW6mwZTeSgLC7pNeVAfmbGli1sm+VyR3GpNzzL4Xw+agX+4PZhW2oW46
         9HZCmy1UwpfEWsyPk9pEMjrnEs5byygyuEMWcpZzMJ8qYDdmV7c2bRYvTZvHLeczXfBA
         E+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993548; x=1712598348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuSQ7x/5E/c4TEmXcwy0rxrtxa6YaB9Kf+fRxPgOOg0=;
        b=fzRqLi3jIpKyZAgs+acvjTmWsEo+P7z/U73AEx9FzXbyliakcZ4U9UoD4qPcHAT5o7
         lULaKyV5K20g6UfMbzJelFvEeTeG443Qpf/QidB5r11kz5fCL5tztrMU7gOe26AQk5vH
         Th210Vbb4/Pc4sIe3EgA1IUwkdnZJqJ6iX+h98Vbmn1e0beV21neR2XiMObxRBf5ryns
         uggFyBwUGJOLCMKIOOZChtiDyfzF7h11eyIqQ11Tx3wqkFCA7su3inKhGkDbBaG+PBw2
         +JDoCMGPC8dTNUNW9FieMDNjDAdRMjvfQZnNEt3QFS4h7Ht2sTCD7vdU87iDtWNlALMe
         ybZw==
X-Gm-Message-State: AOJu0Yy5Dv/V436Tl2s7lFKPk7P+dU7rYB+CL21ahdahnpsRePsYoocK
	Oy5PBY9/X6RWHlAyoKJ6bztdzxXm30Pmgu3sWq802V4fijvUb6WgZ7jvTKWTx/KjglyJM0llWyc
	SO8Szz5tRYcls5vfvRpPkFKB0QaQ2M8o5+oI=
X-Google-Smtp-Source: AGHT+IFEYWXfshklpf7Lx6CSDcTpuQSr+WfJRHTGfb46JVcyJ7Dm7iNdoMT3GnxJuaxpLSpPKO9McdYubL69VsyOMMg=
X-Received: by 2002:a05:600c:44c7:b0:414:1df:d107 with SMTP id
 f7-20020a05600c44c700b0041401dfd107mr549989wmo.7.1711993548474; Mon, 01 Apr
 2024 10:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331172652.14086-1-rdunlap@infradead.org> <20240331172652.14086-5-rdunlap@infradead.org>
In-Reply-To: <20240331172652.14086-5-rdunlap@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 10:45:36 -0700
Message-ID: <CANDhNCppHJVPLhMyDE3mRAKBtp7=56bodLAnbwH=g15=sbWxbQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tick/sched: fix various kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:26=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Fix a slew of kernel-doc warnings in tick-sched.c:
>
> tick-sched.c:650: warning: Function parameter or struct member 'now' not =
described in 'tick_nohz_update_jiffies'
> tick-sched.c:741: warning: No description found for return value of 'get_=
cpu_idle_time_us'
> tick-sched.c:767: warning: No description found for return value of 'get_=
cpu_iowait_time_us'
> tick-sched.c:1210: warning: No description found for return value of 'tic=
k_nohz_idle_got_tick'
> tick-sched.c:1228: warning: No description found for return value of 'tic=
k_nohz_get_next_hrtimer'
> tick-sched.c:1243: warning: No description found for return value of 'tic=
k_nohz_get_sleep_length'
> tick-sched.c:1282: warning: Function parameter or struct member 'cpu' not=
 described in 'tick_nohz_get_idle_calls_cpu'
> tick-sched.c:1282: warning: No description found for return value of 'tic=
k_nohz_get_idle_calls_cpu'
> tick-sched.c:1294: warning: No description found for return value of 'tic=
k_nohz_get_idle_calls'
> tick-sched.c:1577: warning: Function parameter or struct member 'hrtimer'=
 not described in 'tick_setup_sched_timer'
> tick-sched.c:1577: warning: Excess function parameter 'mode' description =
in 'tick_setup_sched_timer'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: John Stultz <jstultz@google.com>

