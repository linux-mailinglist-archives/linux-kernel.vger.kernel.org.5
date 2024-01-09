Return-Path: <linux-kernel+bounces-21295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9F828D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7041F23A53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062603D0CA;
	Tue,  9 Jan 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCOehkuf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C33C07B;
	Tue,  9 Jan 2024 19:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C720AC43394;
	Tue,  9 Jan 2024 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704827712;
	bh=Q8C1+ejFECnjGdpfPU+CdyrV1UwUh3RMKZG5x0HTquo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jCOehkufsUMqP14SDeEYEAGs9cU7h8NsJzU+DbuHNTFVkLkswlyw5FwHb+WBhoGmk
	 TzsZTHmy3JIR1brF7ClTRPbMG3dIFvSwHHE+p8W33thlciRbGzXjq9dFOGaxngFwyg
	 RnlSjHkErBSl5TZND7pW5CPG34DgY3T4tuxFTw3FOXODj23wenRL3FWeYACaJ2VYc3
	 Z4D72jKZAqqqHegnViZspAKlIUgnk3u9JBIzH/GKHUWJ5xkiHfIRJxb5weejql6Gdt
	 Uz4oLhuvZeyNZ289N7LBqtgaoL9S3ttfnNC5+VxLRJwetUCqtMzDM20jKqLPbOBARh
	 GxkCksU6ygSBw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e80d40a41so4050283e87.1;
        Tue, 09 Jan 2024 11:15:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzeGIQ/SPDSKVHIst5GgZ1MfYkDv/fWdHZ8a4Xx5BQ7Ns6Q9WDM
	M75MukC3cDq4FvrsXuWtxjin7j2vgsk7s0O2Akg=
X-Google-Smtp-Source: AGHT+IEt/cGf2NTIcuFbXoWT/s+SJgCbO7FZbjgN4gWqH4e4FO60/h379pbjS17wwcCalH8Ke1axpeXDf1kNIk3rxRc=
X-Received: by 2002:a05:6512:787:b0:50e:9fa0:c1ec with SMTP id
 x7-20020a056512078700b0050e9fa0c1ecmr2463663lfr.109.1704827710960; Tue, 09
 Jan 2024 11:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109133957.2975272-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240109133957.2975272-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 Jan 2024 11:14:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6zxf-5NOJHbpBVhXLM+MzKn4upgHqU+=Z+Owp9yocdKQ@mail.gmail.com>
Message-ID: <CAPhsuW6zxf-5NOJHbpBVhXLM+MzKn4upgHqU+=Z+Owp9yocdKQ@mail.gmail.com>
Subject: Re: [PATCH] md: fix md_seq_ops() regressions
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:43=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit cf1b6d4441ff ("md: simplify md_seq_ops") introduce following
> regressions:
>
> 1) If list all_mddevs is emptly, personalities and unused devices won't
>    be showed to user anymore.
> 2) If seq_file buffer overflowed from md_seq_show(), then md_seq_start()
>    will be called again, hence personalities will be showed to user
>    again.
> 3) If seq_file buffer overflowed from md_seq_stop(), seq_read_iter()
>    doesn't handle this, hence unused devices won't be showed to user.
>
> Fix above problems by print personalities and unused devices in
> md_seq_show(), as it used to be.
>
> Fixes: cf1b6d4441ff ("md: simplify md_seq_ops")
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-6.8 branch. (Yes, I am trying to make some changes to the
branches we use. )

Thanks,
Song

