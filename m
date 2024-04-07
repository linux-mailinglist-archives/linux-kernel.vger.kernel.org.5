Return-Path: <linux-kernel+bounces-134246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0F89AF72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AE52828F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CC111A1;
	Sun,  7 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b9p9hNm0"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46400107A8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477410; cv=none; b=QX0S3Xa1qSXJ0D5SlIC3GOCgvyCa/oehhN9FSHEChJtqVjDKc7qn5+Izu2Fr8NC+V7G5+F12zxRPcC7zo2IG05JbqZoElkXbTsSFk7X7YMSv5wIZ2GGM04nNBDV7H14PFZwsTAZpwWIRYJkGq9m0ISjbFKuwLCFSBfFmUGnP2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477410; c=relaxed/simple;
	bh=VBnMmaY/jSdSTkC4TB/mxJq/6u5SVhMScG2xHkwOpHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU4dNV+9t3vAxnnR/b5F1PSpE9zqf4WaNbeTaXAJeh5LO6DSLiPeHAX72eTYP/K01b18totEMvf6FwcjESYD+uHMo/DQDucm31jT09/eU33CDIsu1cmK3Id7S7qe0+utJ3tZLIpgkFVWATWMsiYWVMnHwFF551IT6o5pp1PpQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b9p9hNm0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4D7E3FE51
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712477400;
	bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=b9p9hNm0mjZX6AOvcv6/CZTiNMgZ68/IlpQlXKJraDA4sV2vZnbuKpZAr4Jxy3nXU
	 qwfPk4IREfZk/yQmCi2dpTWhZ2FGPhLlnMN8GqeqxkJcEcId052qJUN5IGwk6jXXRp
	 sO/x78hgUw6aSNs4bcLEQSc9KKo/xc6L6BL3M3JNTKOvBAC075NQM2Q99Dpa87eb2H
	 DeJl9Fz+D1pBZO3IljJ1UAwdc1v7YLLH/iT0CSjb4J9NvBWojIaIGmGO++xfFSleW7
	 Cdct/kBvB0yqxEJF1kQtwxoG+BqN914Bf/OfFlSNvC7+onGa1VrypNU9b532WnMFnv
	 E8rWtdfjMzdjQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343da0a889dso1826763f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477399; x=1713082199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
        b=OFMg9lJG1dwVY4gLOyr4nnJFKVwmR5AxJFksZZFhfprIdiDqkwcVTlXMSqpOVip4kY
         LJEXOb5J8J2ap1b9pob/FDK22m1E15ntsF0AgcxevmwnbXPmqUJxLZ3KbXU368lLDWaG
         m1ceAU4JfnCZ8JXkuuHwSpGyV+a45YiEtm6ekSgilHU/QKVHmNN27D2wB53r+q5AHXrf
         GMPevF9xQQZYFcNPW4EEUBOrtCC9mqDjY6kbIWohrXfrf6vYECVqh/z8c0ck6I9AJovI
         dH8b0613h1KAe0qiETU08IbfjGAu4lnHCS1eDXo9T14GLr5O3irDjGe2X6EiiEqv08xN
         s6kA==
X-Forwarded-Encrypted: i=1; AJvYcCXpMjCFASoPHZNtK+Gq3vW65BgHYCPPhDgtNfAXInfWxVskmb23GoRmdjCFfTxThRT0geNkBDad3Yvqwf49FxKFfIAQo6YpPz1xM5CV
X-Gm-Message-State: AOJu0Yzls3XhXZFBM5fa3Y4XXVIoQAUMxDqa+SoNsR5+J1B+bKKTWaHx
	6kk9EJbEpxwTuuYgLh6J4xlr3h3VBKGHIdY5yoPjNTvM7xC7mBjfAwZEEc7OxMjOj1gno8RnJgP
	+Eez9pe6xh/d1/PixSLonYqxX7GwlT99mbvNbs/dGNWD775+gETZB0t3F3CzOg8x42LAaXQcder
	QnHg==
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431409wrs.52.1712477394381;
        Sun, 07 Apr 2024 01:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7O+B0XCMESRc4pHeuqRzfZFND+/CmarJwhrJTwar81zScxLL0MtBoOtKhKPuUzsu2gsRPkA==
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431370wrs.52.1712477393487;
        Sun, 07 Apr 2024 01:09:53 -0700 (PDT)
Received: from localhost (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00343e3023fbasm5866411wrz.34.2024.04.07.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:09:52 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:09:47 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and
 ring_buffer__consume_n
Message-ID: <ZhJUy6nWFOFi8oT_@gpd>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
 <20240406092005.92399-5-andrea.righi@canonical.com>
 <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
 <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>

On Sat, Apr 06, 2024 at 10:52:10AM -0700, Andrii Nakryiko wrote:
> On Sat, Apr 6, 2024 at 10:39 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Apr 6, 2024 at 2:20 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > Add tests for new API ring__consume_n() and ring_buffer__consume_n().
> > >
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > index 48c5695b7abf..33aba7684ab9 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > @@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
> > >         err = ring_buffer__consume(ringbuf);
> > >         CHECK(err < 0, "rb_consume", "failed: %d\b", err);
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring_buffer__consume_n(ringbuf, 1);
> > > +       CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
> > > +
> > >         /* also consume using ring__consume to make sure it works the same */
> > >         err = ring__consume(ring);
> > >         ASSERT_GE(err, 0, "ring_consume");
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring__consume_n(ring, 1);
> > > +       CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
> > > +
> >
> > Did you actually run this test? There is ring_buffer__consume() and
> > ring__consume() calls right before your added calls, so consume_n will
> > return zero.
> >
> > I dropped this broken patch. Please send a proper test as a follow up.
> 
> Sorry, technically, it's not broken, it just doesn't test much (CHECK
> conditions confused me, I didn't realize you allow zero initially). We
> will never consume anything and the result will be zero, which isn't
> very meaningful.
> 
> "Interesting" test would set up things so that we have >1 item in
> ringbuf and we consume exactly one at a time, because that's the new
> logic you added.
> 
> I think it will be simpler to add a dedicated and simpler ringbuf test
> for this, where you can specify how many items to submit, and then do
> a bunch of consume/consume_n invocations, checking exact results.
> 
> Plus, please don't add new CHECK() uses, use ASSERT_XXX() ones instead.
> 
> I've applied first three patches because they look correct and it's
> good to setup libbpf 1.5 dev cycle, but please do follow up with a
> better test. Thanks.

Yeah, sorry, I tried to add a minimal test to the existing one, but I
agree that it not very meaningful.

I already have a better dedicated test case for this
(https://github.com/arighi/ebpf-maps/blob/libbpf-consume-n/src/main.c#L118),
I just need to integrate it in the kselftest properly (and maybe
pre-generate more than N records in the ring buffer, so that we can
better test if the limit works as expected).

I'll send another patch to add a proper test case.

Thanks for applying the other patches!
-Andrea

> 
> >
> > >         /* 3 rounds, 2 samples each */
> > >         cnt = atomic_xchg(&sample_cnt, 0);
> > >         CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
> > > --
> > > 2.43.0
> > >

