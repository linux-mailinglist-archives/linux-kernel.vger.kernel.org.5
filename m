Return-Path: <linux-kernel+bounces-54286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B184AD50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F53B23D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C374E09;
	Tue,  6 Feb 2024 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+FMcmKA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC19745F4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192831; cv=none; b=D2jzwjfT3npZf7FwPWNB2yUl1QOHk4IkxTazpzZz8dZ/a2fChQBLwtMhWhzdQxvy5iFtQxWWYtLmBApm4rtZkt8APyeZN5yRlqKFysOuvjbV1lCBUiR20KquQlKPjOEgOmu++qwC701kN+JkQeftON6WAWYy1aZTunc6PzQCuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192831; c=relaxed/simple;
	bh=EYpWYhMOaFrNlOzVvjkYESVcffXmMcKcNtjN3dNEo0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNviggr+gjHnmHPXssT5PnW6BdWZ2yq6w+O2qMSwYAXi9MFolYadywTTKiJOSirIC+GTIaSgBpxg7NB/OUTOpSaGktMI6yAY2LtQHOvehiGCl8KqhHEQDioVzei+wGorgMaIqcQXndrleUnY7YzbsfimzJxjvPFSu7dG66+NbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+FMcmKA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a88ad0813so171461cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707192829; x=1707797629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWjlypBtyTUxplHTk3D9RBXwXO2gt9OAC5LJGVHbulw=;
        b=Z+FMcmKAZez4UGqd+3LWG/oc5h8SXRagDchpyQTILn7EWat1ErsNZPHp2wB95PSxFH
         hvc1KjXUGhgsX1F+tZqh2TMhKYJQWeajWTVurjApCgkFR3WxFwXp58HuLOVlMdvMbesA
         SKvMyD0qBj2OpZ+IxXzA/ZR2YX9ALZK8JIWtFsNHK0DAfsorSlYge0fziTJIhY00W/cX
         0WdafjJcSoc86BfCWNMJpmCMGv6mQ/6WylI+t/RGGyl9OwbKJ6ecKaeGTewDxfhOzOPI
         zhnR6i7Tn7HcNtKhHA0ompZMoKLuiSGz7pFvaEEjj/t0OF03oxq5i+J/ZMovLk3JfxH7
         sCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192829; x=1707797629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWjlypBtyTUxplHTk3D9RBXwXO2gt9OAC5LJGVHbulw=;
        b=YDSNjGUmhvxVCVWRw4cGh5B1Abat9SWnQTx0h+Xuw25hG/o2rJLWLH/THyOvGDLcOg
         /FxBGXiwnWNHpg14m9SiGrPQl4M5CW3gE1nYgd9/zp4xn4hOrzb0RqcrXTtx+UXTncCs
         to2i+lSgtfs8scrHgsNvT3kS8kQJhH1K01zd3QQIlT+RP5M17bHRlJl2yBYk63i2xd81
         MRnVtHg0LeJiNggYbooNcE2qGawyDFj7O7rAMcU60K5wntWyXQcQhvI7UwDL484iqnr9
         09WjVpeyUHGadbFcha7+k2UxrbrntHXElZDhZlTq3Yh7Lyq4M/iw5UV5hOat76xtjM7P
         1VGg==
X-Gm-Message-State: AOJu0Yw3XCLuFf+Xe2bv+MCExZYhS+ejpLehsAEj+5VnOfBl+2QNcElr
	mqg4A+RH+ga9cLok5WY4g+WshkVmrPxzvuh7umJ+eznQqy6xF7JcqQ6jRACeRvII7Joz6LBnDmP
	40D0nt1rfrI73nXSCstSBpYktQEomRZ5+iDNO
X-Google-Smtp-Source: AGHT+IF+zwncKIMpfuhRX8d3KjdNcOIMUCb5EKpDL39rd4uTlyenwEJDN39KRailL3Phrr64u3gyORCgl9FVKUVUGt4=
X-Received: by 2002:ac8:5ac8:0:b0:42c:2d41:5f7d with SMTP id
 d8-20020ac85ac8000000b0042c2d415f7dmr132013qtd.17.1707192828650; Mon, 05 Feb
 2024 20:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126221426.4173112-1-rmoar@google.com> <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
In-Reply-To: <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Mon, 5 Feb 2024 23:13:36 -0500
Message-ID: <CA+GJov5nCLjD1iTUGxQOPMCXjBCci8-VbUje46Qd66szJgGtxQ@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
To: Kees Cook <kees@kernel.org>
Cc: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	Tim.Bird@sony.com, shuah@kernel.org, brendanhiggins@google.com, 
	dlatypov@google.com, tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com, corbet@lwn.net, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:03=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On January 26, 2024 11:14:26 PM GMT+01:00, Rae Moar <rmoar@google.com> wr=
ote:
> > KTAP version 2
> > # ktap_test: main
> > # ktap_arch: uml
> > 1..1
> >     KTAP version 2
> >     # ktap_test: suite_1
> >     # ktap_subsystem: example
> >     # ktap_test_file: lib/test.c
>
> I think it's a mistake to mix "diagnostics" lines with semantic lines. Si=
nce the diagnostic prefix is [# ] (hash space) how about make the test meta=
data lines be [#:] (hash colon). For example:
>
>
>      1..2
>      ok 1 test_1
>      #:ktap_test: test_2
>      #:ktap_speed: very_slow
>      #:custom_is_flaky: true
>      # format-free stuff goes here
>      ok 2 test_2
> ...

Hello!

I really like this idea. The reason I chose the diagnostic line format
was to make it easier for existing parsers to parse the KTAP Metadata
lines. However, if it won't be too much of an issue for current
parsers, I think this idea would be better. So I am happy to change
this in the next version if there are no complaints.

>
> > ok 1 test_suite
> >
> >The changes to the KTAP specification outline the format, location, and
> >different types of metadata.
> >
> >Here is a link to a version of the KUnit parser that is able to parse te=
st
> >metadata lines for KTAP version 2. Note this includes test metadata
> >lines for the main level of KTAP.
> >
> >Link: https://kunit-review.googlesource.com/c/linux/+/5889
> >
> >Signed-off-by: Rae Moar <rmoar@google.com>
> >---
> > Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
> > 1 file changed, 159 insertions(+), 4 deletions(-)
> >
> >diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/=
ktap.rst
> >index ff77f4aaa6ef..4480eaf5bbc3 100644
> >--- a/Documentation/dev-tools/ktap.rst
> >+++ b/Documentation/dev-tools/ktap.rst
> >@@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which =
may be nested: i.e., test
> > can have subtests), each of which can contain both diagnostic data -- e=
g., log
> > lines -- and a final result. The test structure and results are
> > machine-readable, whereas the diagnostic data is unstructured and is th=
ere to
>
> We even say it's unstructured... :)
>
>
> >+prefix must not include spaces or the characters ":" or "_".
>
> Why not _?

My thought here was that the first "_" character in the KTAP Metadata
line would indicate the separation between the prefix and metadata
type. So the prefix could not contain "_". This makes it easier to
parse. I'm inclined to keep this but also willing to change it if
there is a proposed prefix that contains "_".

Thanks!
-Rae

>
> --
> Kees Cook

