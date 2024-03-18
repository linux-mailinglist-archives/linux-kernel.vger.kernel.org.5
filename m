Return-Path: <linux-kernel+bounces-106385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E087EDC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB81281D91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F87E54BC8;
	Mon, 18 Mar 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2OuYJ57"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A944CE00;
	Mon, 18 Mar 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780307; cv=none; b=nM3yBQVZaaldDSkNmcYUhIuBP1EUmDogUJoP1dhsJ0BhQe59Mb420dr9jMV3jhB1mQ0NNSUGrVQc4gZL5wlKJtDXVtBkjCkikZgrgDhNeogYguGJcR1SivuqixNVLheQb3tyxlV29CQbCFw/NO4kl+Tfgz1ekH3H1LkGkCu2Mls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780307; c=relaxed/simple;
	bh=plzgAUqT7eAW3vGS3lxtB9u8E2al/2uQqCBttbfLjko=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Y3EWZyqO8vRrjNzi1H8MV72rJKIbKSM/5UdCWz/E+Xm6PLCIdEYOMnPuGd35ZAeeQ8RdOtIsUnG39Ttoj58KR+N5nRcL9h5/UJlB0Y5pSl/uRvub5oxTcbIE7pQjGv4vql3vrQfvopUraqClyk/R4HtjCxMSf2vO7IeWn1DQS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2OuYJ57; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4146178270dso1714005e9.1;
        Mon, 18 Mar 2024 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710780303; x=1711385103; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwtdj3Qe42//0Pq+EWWaVdxyC3bpLbgB0QXN4bV84So=;
        b=l2OuYJ575K4vuZI7pj+jww0TtvjAEMhjfrqyKNiL8DsW1Qrx5Slqub9ZUFuwWQKiwY
         4p9bZV2I2iPq7xvKrRCSDFnnjHfDem1eNtsp4VRlHAiopuIGGs5aCdD+/DCq53u38imR
         FuL91zTqpkllPqZwtncQqKuIcGyz1wn/bNjH30Ygv8rPPuzmtytJb4Ll9pTYGrhTmFgh
         va9I3CjQaoGogrnTf9pYdW7wcqinN43EylihMvbwgH4sCOLZRC9PkShr3RBzU+n/UsO7
         w4iPVP23e/3e4aasRPZiT5TS+KTu8JyleKnpODOdtN57AEg8LDraCrCluhKrwtFZjbGi
         Fy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780303; x=1711385103;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwtdj3Qe42//0Pq+EWWaVdxyC3bpLbgB0QXN4bV84So=;
        b=H6FxPQSrYGQBoJzH1gYpoobHqWn4UJFj4+wKKPGi4qGXFsMj2ODsD5/t/Cz/HOjwjn
         aZGxgr/1sribVYFRWf5FkEJp5sFdcrxZ8eIV2BYXL/YWyaRNb/n1eP4Q+e+NHGPKgOH5
         +4f/I6cf6R4r/Hp381MTcKE7usgAgsS2usXO4hLs1IFegIvws6iRdPMUyVZmZIP9Orin
         nvxMauaihoy3jSPLShACRxako6C++/1g9ieUCvaJaUWAXXbk73ptYnxf/sg/UAicsLCT
         m0hqg4zC4K2A5nQcWlmbvKAb91AvefPZmE8AD8211to5FnGeoCgLq+Pyk6Qo6uEmULJi
         BJBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+EOqVVygyIQtm+msFdMiXzJRgRzIdDs8LtlpKJaly2vQpDx+7vcgyNRHIeIMge0o5aYLTbs3ZCKdX8GK4rifjBzsOtuo9W9tgDVFyyQXuVlL9xTMQCiESOYRudJXiSQUHsrQzBaet
X-Gm-Message-State: AOJu0Ywv1HGOaqCT4uvABknktmig9stP2YC2g2SGnwvxG7JYfXVni9Rc
	qFVNgG5wqyO/QAc3ZWE2zzLXCG5IGCRoYVq+xngBim5/QG2x3vxXvGLc+1Bm
X-Google-Smtp-Source: AGHT+IFXhxGmjOSZhXns45Tyfc+M5D405RpzjIABTO/N6+xt4efNHgG2E140V0YoocmejLhApQ8WDA==
X-Received: by 2002:a05:600c:1c27:b0:414:f4:c6c0 with SMTP id j39-20020a05600c1c2700b0041400f4c6c0mr109496wms.20.1710780303234;
        Mon, 18 Mar 2024 09:45:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9e5:841d:7d8:c2e2])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm15210684wmb.46.2024.03.18.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:45:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,  Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Vegard Nossum <vegard.nossum@oracle.com>,  Akira
 Yokosawa <akiyks@gmail.com>,  Jani Nikula <jani.nikula@linux.intel.com>,
  Randy Dunlap <rdunlap@infradead.org>,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and
 dependencies
In-Reply-To: <20240301141800.30218-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
	message of "Fri, 1 Mar 2024 15:18:00 +0100")
Date: Mon, 18 Mar 2024 16:44:55 +0000
Message-ID: <m21q8732wo.fsf@gmail.com>
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> As discussed (see Links), there is some inertia to move to the recent
> Sphinx versions for the doc build environment.
>
> [...]
>
> Link: https://lore.kernel.org/linux-doc/874jf4m384.fsf@meer.lwn.net/
> Link: https://lore.kernel.org/linux-doc/20240226093854.47830-1-lukas.bulwahn@gmail.com/
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> v1 -> v2:
>   drop jinja2 as suggested by Vegard.
>   add tags from v1 review
>
>  Documentation/doc-guide/sphinx.rst    | 11 ++++++-----
>  Documentation/sphinx/requirements.txt |  7 ++-----
>  scripts/sphinx-pre-install            | 19 +++----------------
>  3 files changed, 11 insertions(+), 26 deletions(-)

Apologies if I am a little late to the party here - I am just catching
up with the changes on docs-next.

I went to install Sphinx 2.4.4 using requirements.txt for some doc work
and hit the upstream Sphinx dependency breakage. So I pulled docs-next
with the intention of sending a patch to requirements.txt with pinned
dependences. When I noticed that things have already moved on in
docs-next, I decided to spend some time investigating the performance
regression that has been present in Sphinx from 3.0.0 until now.

With Sphinx 2.4.4 I always get timings in this ballpark:

% time make htmldocs
..
real	4m5.417s
user	17m0.379s
sys	1m11.889s

With Sphinx 7.2.6 it's typically over 9 minutes:

% time make htmldocs
..
real	9m0.533s
user	15m38.397s
sys	1m0.907s

I collected profiling data using cProfile:

export srctree=`pwd`
export BUILDDIR=`pwd`/Documentation/output
python3 -m cProfile -o profile.dat ./sphinx_latest/bin/sphinx-build \
    -b html \
    -c ./Documentation \
    -d ./Documentation/output/.doctrees \
    -D version=6.8.0 -D release= \
    -D kerneldoc_srctree=. -D kerneldoc_bin=./scripts/kernel-doc \
    ./Documentation \
    ./Documentation/output

Here's some of the profiling output:

$ python3 -m pstats profile.dat
Welcome to the profile statistics browser.
profile.dat% sort tottime
profile.dat% stats 10
Fri Mar 15 17:09:39 2024    profile.dat

         3960680702 function calls (3696376639 primitive calls) in 1394.384 seconds

   Ordered by: internal time
   List reduced from 6733 to 10 due to restriction <10>

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
770364892  165.102    0.000  165.102    0.000 sphinx/domains/c.py:153(__eq__)
   104124  163.968    0.002  544.788    0.005 sphinx/domains/c.py:1731(_find_named_symbols)
543888397  123.767    0.000  176.685    0.000 sphinx/domains/c.py:1679(children_recurse_anon)
     4292   74.081    0.017   74.081    0.017 {method 'poll' of 'select.poll' objects}
631233096   69.389    0.000  246.017    0.000 sphinx/domains/c.py:1746(candidates)
121406721/3359598   65.689    0.000   76.762    0.000 docutils/nodes.py:202(_fast_findall)
  3477076   64.387    0.000   65.758    0.000 sphinx/util/nodes.py:633(_copy_except__document)
544032973   52.950    0.000   52.950    0.000 sphinx/domains/c.py:156(is_anon)
79012597/3430   36.395    0.000   36.395    0.011 sphinx/domains/c.py:1656(clear_doc)
286882978   31.271    0.000   31.279    0.000 {built-in method builtins.isinstance}

profile.dat% callers c.py:153
   Ordered by: internal time
   List reduced from 6733 to 4 due to restriction <'c.py:153'>

Function                            was called by...
                                       ncalls  tottime  cumtime
sphinx/domains/c.py:153(__eq__)  <- 631153346  134.803  134.803  sphinx/domains/c.py:1731(_find_named_symbols)
                                       154878    0.041    0.041  sphinx/domains/c.py:2085(find_identifier)
                                    139056533   30.259   30.259  sphinx/domains/c.py:2116(direct_lookup)
                                          135    0.000    0.000  sphinx/util/cfamily.py:89(__eq__)

From that you can see there is a significant call amplification from
_find_named_symbols (100k calls) to __eq__ (630 million calls), plus
several other expensive functions. Looking at the code [1], you can see
why. It's doing a list walk to find matching symbols. When adding new
symbols it does an exhaustive walk to check for duplicates, so you get
worst-case performance, with ~13k symbols in a list during the doc
build.

I have an experimental fix that uses a dict for lookups. With the fix, I
consistently get times in the sub 5 minute range:

% time make htmldocs
..
real	4m27.085s
user	10m56.985s
sys	0m56.385s

I expect there are other speedups to be found. I will clean up my Sphinx
changes and share them on a GitHub branch (as well as push them
upstream) so that others can try them out.

For some reason, if I run sphinx-build manually with -j 12 (I have a 12
core machine) I get better performance than make htmldocs:

% sphinx-build -j 12 ...
..
real	3m56.074s
user	9m52.775s
sys	0m52.905s

I haven't had a chance to look at what makes the difference here, but
will investigate when I have time.

Cheers,
Donald.

[1] https://github.com/sphinx-doc/sphinx/blob/ff252861a7b295e8dd8085ea9f6ed85e085273fc/sphinx/domains/c/_symbol.py#L235-L283

> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 5d47ed443949..5017f307c8a4 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,6 +1,3 @@
> -# jinja2>=3.1 is not compatible with Sphinx<4.0
> -jinja2<3.1
> -# alabaster>=0.7.14 is not compatible with Sphinx<=3.3
> -alabaster<0.7.14
> -Sphinx==2.4.4
> +alabaster
> +Sphinx
>  pyyaml

