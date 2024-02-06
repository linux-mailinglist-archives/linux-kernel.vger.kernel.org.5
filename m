Return-Path: <linux-kernel+bounces-54281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75684AD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BE21C230BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1B745F4;
	Tue,  6 Feb 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZfjJpd0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABE745EE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192247; cv=none; b=QbrwthMpXHd+ingxlkwa9xhmjlp04lR+zdg2gv9TG4JbBYGcr8PPLAd30opOfvNMCRXyx7CM1uqPyTTvi1MeMBuHcqaPeMY5S0sJqeTKypbwAQu+ApIpdrz3DwipfV/arTHG6/Ud1yWpAeZ3ptEL4OS77Hak4JXYbISJqcxkyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192247; c=relaxed/simple;
	bh=46WzyXbj7Rm0isZadcw3+pCtPTo44kSLkWucGKrXudw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ9hW0Iv7egrSRe0maYXQKgddvV3RQlz/qL7wjjY7CD3DvKsjgQ+K+LuosXnIHqKVauKHEbRbymQY63yAhY2AOGfx5aMZq6LQ0NSq04s7dUQmPW8KEgkoMbMbDODqcYkaJTmRZJBhd/JeKtQgkwXiI4SYe5ssPvCuYPrzuj0jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZfjJpd0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a99dc9085so105701cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707192243; x=1707797043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZUcKB1MmAKiLxQ+dfYgEUx1Chwig5NhIdP1gbmcUVM=;
        b=TZfjJpd0pstCmEeStWKoi1218t8h3Au17jbNsRoAbTVZE2Po6AOc/t3UCDX0GX6nTW
         iJcNdQt117bSJPGUniEOszFedUyvMvPF9oB+VoMDYEGsGpKVspCHkU2unqZ2MpH7Z59J
         AGZgPBQaUNkDLf0p/aRXEA+ps3NvVETvpKXjcMdQtPckoNgR7QNOMR+g1nbtpoXa7AAJ
         AzXb0bKace0Tr9Uf3qbaZwnrFXof5fbG8gOdnnrzOizp59Rn06N2QacRhgKG+5fuOO5/
         UWEiVlyu8XETc8MF1E6ZVgqku/ag6nH6Vx/sVQ++SnKiFwVeI7K4rdDVnDyg4OqJ5sEl
         Jr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192243; x=1707797043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZUcKB1MmAKiLxQ+dfYgEUx1Chwig5NhIdP1gbmcUVM=;
        b=L2pzgWpt/iy1iJq86Wrq6ZMP5/SbuK57uY96JRlL8c83L7XEBpyv5h+DqqA47yoDK6
         J8w8vXZ6VFJM0UhHPEP+mVUa1Ck02CFpMmZTN+KhTX5QPH8yieAqQ5qnvxCShfe9OJKN
         iOcZShaVSS9Eo+QuIxVXflYfN4FphURzsOTFleuSAWfL4DqiLkSGDfci7HIiXBnXaedJ
         YlSQTZSC2HXXYVMuQimySvPdlOQrTBqddkQ4dpJHI6cA4D6yc7pAaChwTGCYfghIBB2i
         SJtza+OF9GRvDe3oiMDqqdcMGAwRl3Y5gy8GQEjMNmrSH4RlmuPEQpIWbal5t+aGLdcD
         FQaQ==
X-Gm-Message-State: AOJu0Yz0ZcyeVwrjAxDu/u0cBFKWBYVORRxBVgqYmXWKP/kNYB/Fzm42
	eIE0z8IKaChQHMvzfQ7PigWq1eON6512Z5t7/EludcskmixQZSbR+I18nTpKgc5zS5rQiMxAJzz
	QKRXawxQeLQpePqVthDDgaEXps0CJ85bomWGn
X-Google-Smtp-Source: AGHT+IHHvm3bCzGtrEywwBe8Oc9Jqcu5/bnzcw25qfyrcHWaR0+Sp1FyhGjl2pX7vza0xSUMHT9ZXoTBl+i6QiOkhdg=
X-Received: by 2002:a05:622a:1817:b0:42b:f713:ec29 with SMTP id
 t23-20020a05622a181700b0042bf713ec29mr201668qtc.8.1707192243206; Mon, 05 Feb
 2024 20:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126221426.4173112-1-rmoar@google.com> <SA3PR13MB63728D82B285DD69266AADDEFD7C2@SA3PR13MB6372.namprd13.prod.outlook.com>
In-Reply-To: <SA3PR13MB63728D82B285DD69266AADDEFD7C2@SA3PR13MB6372.namprd13.prod.outlook.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 5 Feb 2024 23:03:50 -0500
Message-ID: <CA+GJov70ojVYbBf+ssFRS00nCrTs5rhsTwj3Jv6Kzk+ZqdBspA@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "frowand.list@gmail.com" <frowand.list@gmail.com>, "davidgow@google.com" <davidgow@google.com>, 
	"keescook@chromium.org" <keescook@chromium.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"brendanhiggins@google.com" <brendanhiggins@google.com>, "dlatypov@google.com" <dlatypov@google.com>, 
	"tytso@google.com" <tytso@google.com>, 
	"gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>, 
	"ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>, 
	"guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:22=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Rae Moar <rmoar@google.com>
> > Add specification for test metadata to the KTAP v2 spec.
> >
> > KTAP v1 only specifies the output format of very basic test information=
:
> > test result and test name. Any additional test information either gets
> > added to general diagnostic data or is not included in the output at al=
l.
> >
> > The purpose of KTAP metadata is to create a framework to include and
> > easily identify additional important test information in KTAP.
> >
> > KTAP metadata could include any test information that is pertinent for
> > user interaction before or after the running of the test. For example,
> > the test file path or the test speed.
> >
> > Since this includes a large variety of information, this specification
> > will recognize notable types of KTAP metadata to ensure consistent form=
at
> > across test frameworks. See the full list of types in the specification=
.
> >
> > Example of KTAP Metadata:
> >
> >  KTAP version 2
> >  # ktap_test: main
> >  # ktap_arch: uml
> >  1..1
> >      KTAP version 2
> >      # ktap_test: suite_1
> >      # ktap_subsystem: example
> >      # ktap_test_file: lib/test.c
> >      1..2
> >      ok 1 test_1
> >      # ktap_test: test_2
> >      # ktap_speed: very_slow
> >      # custom_is_flaky: true
> >      ok 2 test_2
> >  ok 1 test_suite
> >
> > The changes to the KTAP specification outline the format, location, and
> > different types of metadata.
> >
> > Here is a link to a version of the KUnit parser that is able to parse t=
est
> > metadata lines for KTAP version 2. Note this includes test metadata
> > lines for the main level of KTAP.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5889
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >  Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
> >  1 file changed, 159 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..4480eaf5bbc3 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
> > @@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which=
 may be nested: i.e., test
> >  can have subtests), each of which can contain both diagnostic data -- =
e.g., log
> >  lines -- and a final result. The test structure and results are
> >  machine-readable, whereas the diagnostic data is unstructured and is t=
here to
> > -aid human debugging.
> > +aid human debugging. One exception to this is test metadata lines - a =
type
> > +of diagnostic lines. Test metadata is used to identify important suppl=
emental
> > +test information and can be machine-readable.
> >
> >  KTAP output is built from four different types of lines:
> >  - Version lines
> >  - Plan lines
> >  - Test case result lines
> > -- Diagnostic lines
> > +- Diagnostic lines (including test metadata)
> >
> >  In general, valid KTAP output should also form valid TAP output, but s=
ome
> >  information, in particular nested test results, may be lost. Also note=
 that
> >  there is a stagnant draft specification for TAP14, KTAP diverges from =
this in
> > -a couple of places (notably the "Subtest" header), which are described=
 where
> > -relevant later in this document.
> > +a couple of places, which are described where relevant later in this d=
ocument.
> >
> >  Version lines
> >  -------------
> > @@ -166,6 +167,154 @@ even if they do not start with a "#": this is to =
capture any other useful
> >  kernel output which may help debug the test. It is nevertheless recomm=
ended
> >  that tests always prefix any diagnostic output they have with a "#" ch=
aracter.
> >
> > +KTAP metadata lines
> > +-------------------
> > +
> > +KTAP metadata lines are a subset of diagnostic lines that are used to =
include
> > +and easily identify important supplemental test information in KTAP.
> > +
> > +.. code-block:: none
> > +
> > +     # <prefix>_<metadata type>: <metadata value>
> > +
> > +The <prefix> indicates where to find the specification for the type of
> > +metadata. The metadata types listed below use the prefix "ktap" (See T=
ypes of
> > +KTAP Metadata).
> > +
> > +Types that are instead specified by an individual test framework use t=
he
> > +framework name as the prefix. For example, a metadata type documented =
by the
> > +kselftest specification would use the prefix "kselftest". Any metadata=
 type
> > +that is not listed in a specification must use the prefix "custom". No=
te the
> > +prefix must not include spaces or the characters ":" or "_".
> > +
> > +The format of <metadata type> and <value> varies based on the type. Se=
e the
> > +individual specification. For "custom" types the <metadata type> can b=
e any
> > +string excluding ":", spaces, or newline characters and the <value> ca=
n be any
> > +string.
> > +
> > +**Location:**
> > +
> > +The first KTAP metadata entry for a test must be "# ktap_test: <test n=
ame>",
> > +which acts as a header to associate metadata with the correct test.
> > +
> > +For test cases, the location of the metadata is between the prior test=
 result
> > +line and the current test result line. For test suites, the location o=
f the
> > +metadata is between the suite's version line and test plan line. See t=
he
> > +example below.
> > +
> > +KTAP metadata for a test does not need to be contiguous. For example, =
a kernel
> > +warning or other diagnostic output could interrupt metadata lines. How=
ever, it
> > +is recommended to keep a test's metadata lines together when possible,=
 as this
> > +improves readability.
> > +
> > +**Here is an example of using KTAP metadata:**
> > +
> > +::
> > +
> > +        KTAP version 2
> > +        # ktap_test: main
> > +        # ktap_arch: uml
> > +        1..1
> > +          KTAP version 2
> > +          # ktap_test: suite_1
> > +          # ktap_subsystem: example
> > +          # ktap_test_file: lib/test.c
> > +          1..2
> > +          ok 1 test_1
> > +          # ktap_test: test_2
> > +          # ktap_speed: very_slow
> > +          # custom_is_flaky: true
> > +          ok 2 test_2
> > +        # suite_1 passed
> > +        ok 1 suite_1
> > +
> > +In this example, the tests are running on UML. The test suite "suite_1=
" is part
> > +of the subsystem "example" and belongs to the file "lib/example_test.c=
". It has
> Unless I'm missing something, the file is specified in the example above =
as
> list/test.c, not "lib/example_test.c".
>
> Other than that, the documentation looks fine to me.
>  -- Tim
>

Hello!

Thanks for looking over the documentation. And sorry about that typo
in the explanation. It should say "belongs to the file "lib/test.c"".
I will change that for the next version.

Thanks!
-Rae

>

