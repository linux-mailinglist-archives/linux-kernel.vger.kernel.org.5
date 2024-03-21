Return-Path: <linux-kernel+bounces-110454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68408885F24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E16028180F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4FA13474E;
	Thu, 21 Mar 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMwDauTB"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8B9468;
	Thu, 21 Mar 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040215; cv=none; b=oIkVKuFxQEzphCQR5JhJBCNKU5znbLv47LlEnJVedgGBKdwHWEO9iLqPfemQxpG4P4w8DbEkVKqYavvFwsZCE0bpelS9T/ll6SdEQhBOvrzTBcCMpsa11+Ck1s4Yy0/3uovzpgH2dY4NA42n13gt95lKNy7+KcNEMq8FqIf+Tbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040215; c=relaxed/simple;
	bh=z2V2t8q647P9dxPXGp/85hX3c/BQolF0TILOXB45bBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9++p+tOgWjSweybI8F0W9QCCfMfCN9k+1ZE7tC4eOAEEyYwXvcBHqBvm48xAI1YcV3aiP/a3hp/iTVHjbT79TvWF4epYVRAEY2jsZI3TE94P1jmgCO8AQsBCGdHy2f87hjie/c9LZHVykQ1wQXPoFyFAqSqBy0a5f24DOThAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMwDauTB; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2297d0d6013so730728fac.0;
        Thu, 21 Mar 2024 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711040213; x=1711645013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2V2t8q647P9dxPXGp/85hX3c/BQolF0TILOXB45bBw=;
        b=UMwDauTBkjaoHUHYzpmCpKOq+b1qBIs++JEe7Z3KfHjbIUc+mNj5Fo7YmN+hFJvvNE
         Ns2umE+S9wJ+NA4NZnMzVKoXVo50h5NOpF5UG2imCtemF5yfeqdfwpe23iBenPDkOlww
         CIXv3NObMnvMGLDhQ+WiBmTel4TJxThC4keaMxHf0mtutpA2Hn3viIEu6gzBuW4zejlu
         6b1QxeO5l5whqa2OGyzqss1s5b8TctaU3yly59q67EgKs/QCTmHpz2kOlFEkV26USZhN
         kq15w2QZfshrWvTqx+KoG+RJGhhqwnMZ6ECc4SKcdQME8xLvFx2m3rv+UlFXJq4K6SUO
         etFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040213; x=1711645013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2V2t8q647P9dxPXGp/85hX3c/BQolF0TILOXB45bBw=;
        b=VQmz09DtYJ3JwzAa9HqQVgzcirnPUjACkCVHWiIG8R10vBu2GnpG9yd7LpY0x+s1P/
         ReL8YcxDT54NTFO57yIF/Y5Uza/ktD3Y8/BO/+vXGfXGP2o/RKhbrpcl9prXqh/6G4+q
         TRh+/1oOI09MC58drj6gTSvmGc6hWALfDH/L+Zn9xtklZcaEnFodrMdsoIkg/NoWoZTM
         6rG2VFQCPReTVQmLZlYsveGjMcAURJlbi186Xq7NiRGbfrgZvzsFLsMC5C1fmMzzNfOo
         RCNTDvpqlSlBYNZp6DTh/WBDjM2cPA4FJsVj+Jn0L9kZtn2kZtzjT/AG2eSBLAvEX9c4
         OzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAXxKfn1hQPzxsnMtz25jlT2wj38oxo3kilCCljHzRJZnTNhc+2H7KYIbmDoQeY0z5Jfq+AxLdEhVmd5jXtD/8sIaNIKupaZ14ruwT7x5saM35PVfL/K6aGTbKyYGsinijFPaawwxq
X-Gm-Message-State: AOJu0Yw8DFStYtUocxE5ojfEjMTTnYhD5ucfawUFhEv9Z2RpXejnfXPS
	g5ADBDCSG+qFVm/dp1qg2WRCvLAqN8BwrMP2+Iz+FU2UzAe6NnnNrUaFhvPjqKVLKjGiCXAMkUI
	HHhBj8cCeV2hmAomLMo92GpePxio=
X-Google-Smtp-Source: AGHT+IGSbJzhXDNWFZTUsPKIUy/SE9DYZCFs+yqCiHDD4pOdnqt6luNTNtMfHaAP4paglVkPaKBcWPCEkPlX3aU6v/g=
X-Received: by 2002:a05:6870:160a:b0:221:c8a9:563d with SMTP id
 b10-20020a056870160a00b00221c8a9563dmr6161587oae.3.1711040212964; Thu, 21 Mar
 2024 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
 <m21q8732wo.fsf@gmail.com> <41f28393-0211-4448-8add-ad3c55d02210@oracle.com>
 <CAD4GDZzjc6=-Gzw23tRgCDE7=AxsenXqpD+qnh6gj1+MYYU2fA@mail.gmail.com> <CAD4GDZyABi3wjKY4SUV804OyBDBaC=Ckz5b0GZ34JmCX8S6V_g@mail.gmail.com>
In-Reply-To: <CAD4GDZyABi3wjKY4SUV804OyBDBaC=Ckz5b0GZ34JmCX8S6V_g@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 21 Mar 2024 16:56:41 +0000
Message-ID: <CAD4GDZz32w9MXf1msX0otVwZqtqFWOajG+00jQimAKUp627xcA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and dependencies
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:59, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> > > > I have an experimental fix that uses a dict for lookups. With the fix, I
> > > > consistently get times in the sub 5 minute range:
> > >
> > > Fantastic!
>
> I pushed my performance changes to GitHub if you want to try them out:
>
> https://github.com/donaldh/sphinx/tree/c-domain-speedup

Now a PR: https://github.com/sphinx-doc/sphinx/pull/12162

Following up on the incremental build performance, I have been
experimenting with different batch sizes when building the Linux
kernel docs. My results suggest that the best performance is achieved
by using a minimum batch size of 200 for reads because batches smaller
than that have too high a merge overhead back into the main process. I
also experimented with a minimum threshold of 500 before even
splitting into batches, i.e. if there are less than 500 changed docs
then just process them serially.

With the existing make_chunks behaviour, a small number of changed
docs gives worst case behaviour of 1 doc per chunk. Merging single
docs back into the main process destroys any benefit from the parallel
processing. E.g. running make htmldocs SPHINXOPTS=-j12

Running Sphinx v7.2.6
[...]
building [html]: targets for 3445 source files that are out of date
updating environment: [new config] 3445 added, 0 changed, 0 removed
[...]
real 7m46.198s
user 14m18.597s
sys 0m54.925s

for a full build of 3445 files vs an incremental build of just 114 files:

Running Sphinx v7.2.6
[...]
building [html]: targets for 114 source files that are out of date
updating environment: 0 added, 114 changed, 0 removed
real 5m50.746s
user 6m33.199s
sys 0m13.034s

When I run the incremental build serially with make htmldocs
SPHINXOPTS=-j1 then it is much faster:

building [html]: targets for 114 source files that are out of date
updating environment: 0 added, 114 changed, 0 removed
real 1m5.034s
user 1m3.183s
sys 0m1.616s

