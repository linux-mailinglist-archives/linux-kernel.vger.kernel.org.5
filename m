Return-Path: <linux-kernel+bounces-5930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6BB8191A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739121C218F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994F39ADF;
	Tue, 19 Dec 2023 20:39:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369373B781;
	Tue, 19 Dec 2023 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-203aa9c19ceso379521fac.0;
        Tue, 19 Dec 2023 12:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018376; x=1703623176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DziJ3fXpCSH0YjUbI03bbXMEuMGLYmct7c4S80aLAE=;
        b=OndTq5WRlzMWY02UkB5odCjAjMFy9QdRf0CUGGEr8iQ1vzduu24U1eCJ1eqyiLnf6y
         7F/tn189EIFahZUZI7nhMJFJKL0Wx9p5yeiDKgp21FkEATTAHbTXC4RfE7vhrg3rcHxu
         K0T5jzXmE7ck31XwEEoP7NsEsdrqY1hJlkHftyGDMinmZxWRFExB58RjvtpTLkD1G0aP
         kgY8AASboubuhlDk0/Hok0t3i2wKZh46iXK9gii0XyrmVm/sfLKViyLsKvfPROOc/PCj
         J4mkjmUKeCAr1NUYzJmLQ/pW9Q+7PefAWvpRaDAHf/8I7qx7WsbbF+KE2oeNnZV4F2JB
         yzqg==
X-Gm-Message-State: AOJu0YzTrDrZi3AfsVLb8faQo+3oqiVt064KdYMFtFrEddxzGR+fzQqO
	Qi0CmJhpf+V6kCC+P+zA93GNbI1BRZAPYWaMf8jQ+HfO
X-Google-Smtp-Source: AGHT+IGgzXWzuvzaB3dYH5OY42sOHe01Du+gCgqovbDyT6GvFO2cJ6bnyXded158X3RY1nvsSFsINqUuHOn4fg38bxs=
X-Received: by 2002:a05:6870:7014:b0:203:d0d0:5707 with SMTP id
 u20-20020a056870701400b00203d0d05707mr6439646oae.4.1703018376268; Tue, 19 Dec
 2023 12:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213102808.94695-1-yaozhenguo1@gmail.com> <CAJZ5v0i4DAtzoJUyN0H-4rL=HR=cNntqrrJaDj12suF=7JiyeQ@mail.gmail.com>
 <9adc18c94f160cad550e762571a952baa7f8df36.camel@linux.intel.com>
In-Reply-To: <9adc18c94f160cad550e762571a952baa7f8df36.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 21:39:25 +0100
Message-ID: <CAJZ5v0i19-o9qecaT4y6U8NhEEyR9aKCzyGccdrWXDW5RVHhag@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Emerald Rapids support in
 no-HWP mode
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Zhenguo Yao <yaozhenguo1@gmail.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:33=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-12-19 at 21:22 +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 11:28=E2=80=AFAM Zhenguo Yao <yaozhenguo1@gmail=
.com>
> > wrote:
> > >
> > > Users may disable HWP in firmware, in which case intel_pstate
> > > wouldn't load
> > > unless the CPU model is explicitly supported.
> > >
> > > See also the following past commits:
> > >
> > > commit df51f287b5de ("cpufreq: intel_pstate: Add Sapphire Rapids
> > > support
> > > in no-HWP mode")
> > > commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
> > > support")
> > > commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support
> > > in
> > > no-HWP mode")
> > > commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers
> > > support in
> > > no-HWP mode")
> > > commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support
> > > in
> > > no-HWP mode")
> > >
> > > Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> >
> > Srinivas, any objections?
> No.
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 6.8 material (with some minor edits in the changelog), thanks!

