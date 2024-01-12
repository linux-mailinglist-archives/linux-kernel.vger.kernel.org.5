Return-Path: <linux-kernel+bounces-24197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EB82B8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC061C23D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A23EC5;
	Fri, 12 Jan 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru6YBIHM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425FA3F;
	Fri, 12 Jan 2024 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4a2526a7eso36039675ad.3;
        Thu, 11 Jan 2024 17:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705021394; x=1705626194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3XdDa+qFVErTyo59RgwEE3EAEc/YkpJSsj4wu519lQ=;
        b=Ru6YBIHMoDsVVICzEcoGXLAbRh7sg8/c+cP0l4Cv+9MJOWe5d/gBv+FVkcYWWCAzz+
         xyMDfKVE8hIaXGx8tjsC6Jw1zxZrd82ryzj4VaFp8pDvjozR8SSry3y8xhZspVG+GAaz
         5cPJzjbLS+KH3vBNRqn66c9cj11jXnNINxbsOav1Ov6sST5A+xE+4uOgIBY+F/PN9kUW
         r1xvsDusyCJmgfngnHhhFXidkvMjp32Z3jNiE+EVYcIC6dWNjrL2ITPICRtr4j3EoShC
         jtl3G0U4DEyZrLGcB4ElJyRym+swDkurBNzxY1UGHGk64CQW84UgMQzQosiI5SSNJHGk
         ZERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705021394; x=1705626194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XdDa+qFVErTyo59RgwEE3EAEc/YkpJSsj4wu519lQ=;
        b=HlsjwD7p9J9aXNX5+voR4F2eJQgJmrVoUDKrcpomUuG8yMvDEs70yXR1k3P6ES+C2T
         AiDO2fk2JhPYPWvLJvPdcrCYwGYAs2l8qwm26RQTIaxD8LOSlja78mOcjyQbKb0JYizg
         M3EvVuoWeR6qqX9MJbxhb87GsD3ZAxkkeu3NCJGw6W7tugSVjB+rPcj4SM1Q9XG7X6wR
         sh9faE1KjkUfiYmR4Ahm+PLZuGHTCXRofnmMyfNodqXllQTJM+WWz9czZnoeV8i/B3uJ
         t94CmgFQMnVn8yAn4V/lzvOeIbNM6T8f7CHKUTMWUhmgoHKBkh4VOCuMqZ6nkGXF6MnI
         Qypg==
X-Gm-Message-State: AOJu0YxmSHQSTvJYhVCcuuFeY9/8NGIlGIVkwbYBk9A5ZSNOCAMdKe+i
	HiqRoIcqddCBKYupfgLM56w=
X-Google-Smtp-Source: AGHT+IEVufCYK4XkGA+x0XxKaYdgBgJ1EHmTgS+OCBtj5Sb48/s3juO/VS4mnC9bLigBvtWJ5O3uEw==
X-Received: by 2002:a17:902:f814:b0:1d4:35ad:41cd with SMTP id ix20-20020a170902f81400b001d435ad41cdmr137992plb.108.1705021393591;
        Thu, 11 Jan 2024 17:03:13 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id kz15-20020a170902f9cf00b001d4bcf6cc43sm1825060plb.81.2024.01.11.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:03:13 -0800 (PST)
Date: Fri, 12 Jan 2024 09:03:07 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
Message-ID: <20240112010307.GA9794@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>
 <20240109234518.GA7839@rigel>
 <9e33f7dc-deee-4165-bc10-ad77f38b270a@oracle.com>
 <CAHp75Vc8UN2kyxGtV0tCF+xcRLAxg0qijTvHWXXtdTA9nY-h3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc8UN2kyxGtV0tCF+xcRLAxg0qijTvHWXXtdTA9nY-h3w@mail.gmail.com>

On Wed, Jan 10, 2024 at 01:10:51PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 10, 2024 at 10:16 AM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> > On 10/01/2024 00:45, Kent Gibson wrote:
> > > On Tue, Jan 09, 2024 at 10:00:26PM +0200, Andy Shevchenko wrote:
> > >> On Tue, Jan 9, 2024 at 4:00 PM Kent Gibson <warthog618@gmail.com> wrote:
> > >>
> > >> May we actually state in the documentation that sysfs is subject to
> > >> remove at some point?
> > >
> > > So formally define what "deprecated" means?
> > > Is that covered in the higher level documentation somewhere?
> > > If so I'm more than happy to provide a reference.
> >
> > We have a few files that may be relevant here, that I'm aware of:
> >
> > 1) https://docs.kernel.org/admin-guide/sysfs-rules.html
> >
> > documents some general assumptions that userspace can make about the
> > stability of sysfs and its files
> >
> > 2) https://docs.kernel.org/admin-guide/abi.html
> >
> > This is the public-facing, somewhat machine-readable repository of what
> > is supposed to be the kernel's ABI/API, including "obsolete" and
> > "removed" interfaces.
> >
> > 3) Documentation/ABI/README
> >
> > describes the process of deprecating an interface
>
> Yes and GPIO currently is under obsolete section with also this:
>
> "This ABI is deprecated and will be removed after 2020. It is replaced
> with the GPIO character device."
>
> https://docs.kernel.org/admin-guide/abi-obsolete.html#symbols-under-sys-class
>
> So, proposed cleanup series should probably rely on this documentation
> among other existing descriptions of sysfs GPIO.
>

The sysfs doc already references the doc (sysfs-gpio) that generates the
HTML that link points to, so not sure what to change.
I can't include a direct reference to the HTML, AFAICT, as that HTML is
generated using kernel-abi makefile magic so the usual doc path
cross-references don't work - you just get the path as plain text.

If there is some way to provide a cross-reference that generates to that
link then I'll change it, but I don't know how.

>>> +    -  -  ``EFAULT``

> Wondering if these constants can be referenced via % and if it makes sense.

That would be great and I do want to do that, particularly for the
uAPI v1 docs that use a lot of consts rather than enums, but, AFAICT, you
can't create cross-references for consts, you can only add formatting[1].
And the % formatting only works in kernel-doc, in rst you have to add it
explicitly yourself, hence the ``EFAULT`` .

Cheers,
Kent.
[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#highlights-and-cross-references

