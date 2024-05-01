Return-Path: <linux-kernel+bounces-165830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A954C8B9228
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E23E282127
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47DF168AEE;
	Wed,  1 May 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PABHzP0a"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05617C6B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605537; cv=none; b=UvyxQxAZruPlCo6HBorqEmwNoMBHCJIy/6WJ+eIbx+GMa5W784I0sesqGoGXCWTDva63Lh+pgoxLTIcNdNILos0uNKoFS4pmI9h1CIBWY39Qic7KMquk3D7yE8vt4H/Bt7lRboiBe/hGpMVbS70/hisn3xi17bNmW0NWEKIoZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605537; c=relaxed/simple;
	bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgUofAw7dnwC3voBulbg/gFozHY4DiL7fMucp//tQYKIQUKQbx6852CZNpgaf2shaiFiEhU6XpW6DEzmG2XJ6vHkrx8l3GpSFDWs1b2v1B/O21s7WUk9l3w70IPQJYUTCAH6QLJpU8tv6Cj+C9su98yWIinMGBeFzYpb5Bn+nOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PABHzP0a; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47a0bebeacaso2039500137.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605534; x=1715210334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
        b=PABHzP0aN1R0tz3YGI0Ot82xvogNHaT1Ev9Ouo+3uCM8EPMHrcpOUss16VYQNxWvsi
         8OOQ79i2+4qIjVIpnHnRr5OVyKqRimILYjJJQnG0LMZWp29BzQrbK8DMtG+bZV5AKQD7
         3AbDhHzu50wbRJWt5UDt6jXSVkN9wOC8Gbz05/307y+U1AgZVowEAch9cnt3gZ5B5+6s
         xCOZYmeUfXgg4GMGQLZzxUD5uW7jVr9xzVkekqYHZnWE/bR16vv5P+tC1+By1QTNbhMo
         RSxoFmBleOLngKt0W/Pd3qfL9tJa0KNS04H7LFfm1zgrzm5deFpL8PMNQazJ/VC6Udmp
         /agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605534; x=1715210334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FXkbiF78yO95Ik6NVI4Nm2pb09Aq3YrAbf9O/PxWvg=;
        b=a8Km4VMc7Zyr2zg1yJZE3UOMf9nqdf6eYtUcQbLQ4l5nTnA/sTo3EVntM0RlooDzZf
         xqaf39G0eIaBzjqwRdUOG39o7ywl+ajH7lNEx+fXGNoI5H+zwn2A7DSdd+vN/J/ZX5pQ
         vu8rbwVUa3QE0idsv79GoMTVuup6k7ZQB0JEQ6ss6IMLK12dL1zqdclrPiVbDdiEV/5A
         FHOKlcP0ytWrZbkJca1pJgKXcUzf0fL7ZbZt7Wltr5jRUShqWnVneFWqQ1x+y7fNsX7p
         89h7QhD+QdeIiE+mDZ6b17jSgQT5O3TouOhHBOz0f1VAjkhTqLIL6cIhf8hVW5xrcfHg
         LP9A==
X-Forwarded-Encrypted: i=1; AJvYcCWsf5QcX0R5dChp8l70hZez0jDILxyKJwDxefYstjNWGJF3AevJnBMx7ztMhMgOw6Petu0fa4XFJCY9B1Kh6APMpagdrJceGXyA9ZW2
X-Gm-Message-State: AOJu0YzPWO6xnBnM4Kx+0WHH8Hqzx0TgIphf9xB/MeTzJVjFDSZiesVj
	pvdTxofVveuzsFVzfHp0Kgj4/W5tb9DyIUlz3M5rXOge8viZWx4VJG0cqDaF92DAfyQdkPOKmaA
	hkkKH/wJNyQZcZKf2X6/brVvcHbIhBhr4DfjD
X-Google-Smtp-Source: AGHT+IFCNhW7Sr4LWQ18lqVtEBE5i75ngQX0dGbAlyauUArqJLvaZn/QyY35oTF3T1kZyxDYj2izJDA/UYjotSrmUC4=
X-Received: by 2002:a67:ee88:0:b0:47c:24fa:b627 with SMTP id
 n8-20020a67ee88000000b0047c24fab627mr4315116vsp.13.1714605534362; Wed, 01 May
 2024 16:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
 <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
In-Reply-To: <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 1 May 2024 16:18:42 -0700
Message-ID: <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 2:39=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Hi,
>
> Nit: The { } around each branch can now also be removed.

There was one line before and there's one line now.

I'll remove the brackets but I will briefly wait to see if any other
concerns come in.

Thanks

>
> CJ
>

