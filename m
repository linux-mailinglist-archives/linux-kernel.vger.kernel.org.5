Return-Path: <linux-kernel+bounces-158060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF8B8B1AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554B11C220A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF824084C;
	Thu, 25 Apr 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CwuXZPem"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29123C466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025958; cv=none; b=LSx6sqNsYaBw/muElDB2y3zqz4P3IxlDrig00dNorKmL6md1U6Wj3/YQ8CQmbTlQ568myUTOi/eSppmDKVzPEY2RRoQiFZF+AeIJA0oNkqkB/kl2AxPQ6jqcRE+5LFUxDloSljSAyeVMyJyLz0n5ozmOJiSeIu49L63CunBQpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025958; c=relaxed/simple;
	bh=//DNsUlBgI0vlLJDyF69vHpBDYm1UWrZbGpkoCdLwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlW7JOrMEUJaaLHgI5kSvPU/pLsM76CKVzxhH0NAOao8Ct65u00uJ6FxllC5FmzjCoejhIP90k8znH7AxakfsvlSkAP58/m/zIf+ZIdj80RxvbzhO9Wfn3az+pdlDJPnVG0pRL+Wo+XAw16Efsf5BzXn0k75Z5QrNUj+svxp7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CwuXZPem; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4AD9D3FE51
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714025949;
	bh=HoVegtVV8p+Gh2AomBAcQ2xl6o91liRpQqxeqe2byac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=CwuXZPemIJqjgsV2TDJ7MM0quiF/bUSR7AlpLSpOV1ldX5Od2QfumOXanazVcyvHl
	 TLZk7HoKbFOlUnVQNCIcIWbtYycGXohlTHpshCF8PJnsjZvHglKOutgnISvtQDhcDE
	 tDxoXST1Bpj7Y9oniPG6hzSIjLy0PAWWHF9kwF9zvxnflOmMfmQqKp0xu4xZgeZ5tA
	 SSWyRYMK/mZF0u2ZiBZ0R9ZC6b2Cd8taE3suM/6Roc0TCahzKB16LtguDf/3a34w1U
	 23u1LDTNEsZly1oDug7tI+VVZIexRPhUwqdMeos2kYHeboApbcOntXxT7fqniETVGt
	 4fRdWBMncGWaw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56e7187af0fso266233a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025949; x=1714630749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoVegtVV8p+Gh2AomBAcQ2xl6o91liRpQqxeqe2byac=;
        b=MrYhjrqRSoQTz8/46mz5XU8kpHK52yW4UpADGOsbTCakpT+TR+NVNRZfeomhy9hY6D
         denbnXJc7HmZkNz+bHH7jMaORtFbp5J/ONrV9oZgcVnjryAX0MjdjZnEctRLO4C+NVBN
         WoyW9JkBIgvrRvIsbGb4qG5+4yU9YdCwQHwuvhI7WQJ3mqwjANqGxCDlGh7zECxO+Jei
         /kugfB2vpvGhX4Tb3gThi10EEjnLDw8mF5amznQbg7lpHaKjqyah6CJfmCb/aIpix4S3
         fwVBbXdEgFuHwpUPL2D+a2jQckQDo4jSNlleRotZ51r9IngOL6XWT8r054GwON7i3d7Z
         sSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyDuAD52kndF+5vigRVcH52cAz36+vp0LFTuEeri/LooSPrEJup/vETMJCUp+tm+fYPR1+6vPT4XfbJk4LyGLre7mUgzb9tHgFZh3z
X-Gm-Message-State: AOJu0YzuDdfxnq2i6qfY+NanQz1y7mEMgtJYB60sdPC4x1AELygJ6LBc
	3FJ/l+bXvRaFKmmO5pjpArDaxuJBDt6eNVwRBnEUzE6Szcta3ohxLgd0dXY98xz8vb3aiQRkq4C
	RsGeChJni326hYQF78Lxqs1RvKoBSE4zJhD0V/5DpMnLovHo0fT0k+hP32SEnd4kEp2k8Ki2fa6
	VY3g==
X-Received: by 2002:a05:6402:2033:b0:572:325a:851a with SMTP id ay19-20020a056402203300b00572325a851amr2448517edb.10.1714025948829;
        Wed, 24 Apr 2024 23:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmz2xFXYeIc9DsevrrNqsLxot9gX+ty/nFrxSqWAYAoTEBo9LkdsRfBz18/zGUn4b5HLfSjA==
X-Received: by 2002:a05:6402:2033:b0:572:325a:851a with SMTP id ay19-20020a056402203300b00572325a851amr2448483edb.10.1714025948178;
        Wed, 24 Apr 2024 23:19:08 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id c7-20020a0564021f8700b0057000ecadb0sm8680895edc.8.2024.04.24.23.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:19:07 -0700 (PDT)
Date: Thu, 25 Apr 2024 08:19:04 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <Zin12J-emVljvVrJ@gpd>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
 <ZiVy9bYrX-w24huD@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiVy9bYrX-w24huD@krava>

On Sun, Apr 21, 2024 at 10:11:33PM +0200, Jiri Olsa wrote:
..
> >  static struct test_ringbuf_map_key_lskel *skel_map_key;
> > +static struct test_ringbuf_n_lskel *skel_n;
> 
> seems like there's no need for this to be static variable

Can you elaborate more? I think we want these pointers to be static to
limit the scope to this file, no?

> 
> >  static struct test_ringbuf_lskel *skel;
> >  static struct ring_buffer *ringbuf;
> >  
> > @@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
> >  	test_ringbuf_lskel__destroy(skel);
> >  }
> >  
> > +/*
> > + * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
> > + * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
> > + */
> > +#define N_TOT_SAMPLES	32
> > +#define N_SAMPLES	4
> > +
> > +/* Sample value to verify the callback validity */
> > +#define SAMPLE_VALUE	42L
> > +
> > +static int process_n_sample(void *ctx, void *data, size_t len)
> > +{
> > +	struct sample *s = data;
> > +
> > +	CHECK(s->value != SAMPLE_VALUE,
> > +	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
> 
> I think we should use ASSERT macros instead in the new code

Good catch, I'll change this to an ASSERT_EQ().

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void ringbuf_n_subtest(void)
> > +{
> > +	int err, i;
> > +
> > +	skel_n = test_ringbuf_n_lskel__open();
> > +	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
> > +		return;
> > +
> > +	skel_n->maps.ringbuf.max_entries = getpagesize();
> > +	skel_n->bss->pid = getpid();
> > +
> > +	err = test_ringbuf_n_lskel__load(skel_n);
> > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
> > +		goto cleanup;
> > +
> > +	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> > +				   process_n_sample, NULL, NULL);
> > +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> > +		goto cleanup;
> > +
> > +	err = test_ringbuf_n_lskel__attach(skel_n);
> > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
> > +		goto cleanup_ringbuf;
> > +
> > +	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
> > +	skel->bss->value = SAMPLE_VALUE;
> 
> skel_n ?

Absolutely... I'm suprised that it works actually, I guess pure luck
(unluck) to reuse the old pointer and have value mapped to the same
location. Anyway, I'll fix this.

> 
> > +	for (i = 0; i < N_TOT_SAMPLES; i++)
> > +		syscall(__NR_getpgid);
> > +
> > +	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
> > +	for (i = 0; i < N_TOT_SAMPLES; i += err) {
> > +		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> > +		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> > +	}
> > +
> 
> SNIP
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > new file mode 100644
> > index 000000000000..b98b5bb20699
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
> > +
> > +#include <linux/bpf.h>
> > +#include <sched.h>
> > +#include <unistd.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +#define TASK_COMM_LEN 16
> > +
> > +struct sample {
> > +	int pid;
> > +	int seq;
> 
> seq does not seem to be checked, is it needed?

seq is not used at all, I can definitely drop it.

Thanks for the review! I'll send a v2.

-Andrea

