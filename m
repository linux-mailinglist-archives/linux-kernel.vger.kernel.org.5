Return-Path: <linux-kernel+bounces-5901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BF819146
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F181C23E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B139AC8;
	Tue, 19 Dec 2023 20:22:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91639AC2;
	Tue, 19 Dec 2023 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5908b15f43eso683637eaf.1;
        Tue, 19 Dec 2023 12:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017367; x=1703622167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXlywzJaPAESGuJk2xO4+LBMlhtKKW+VkLv3NiQaeHk=;
        b=VFNxPu9a4q19/4gKDy7PPOaYjaG66yPl0jIMQB5CMmmhQT1jYDa6SGD+NAln+kAcs5
         pXyg4ivTe2P4RpAPPWtGUWZQ0YbpnOndrFkh/KTFqvryasLWMPilevHA8+ZfR8gN7kUp
         6rS/fERl74+fM0xk7KZ9JgFV6TL3gZC/AhCVwBfOICtmxe4l2FSjYv42aHM0fHhEym2o
         D/dycTB83nB93DkLuytJHEXUoRctdXB4CcFcYBPkLV9seyVuUnSgOwUXMs3lzu5Mv18q
         cS0N2w7TABMXb7hZ3EyMRvvRi1i/Lq+wzpzLne10DxLbMRVCzxUDhauiFFUlnrmiHOt/
         4xrw==
X-Gm-Message-State: AOJu0YzkJR9GJt0bIEWeXHt7d3mdvIg1/8yS4g3audV0wnRWBEMYqyvw
	04YG3FF8mVWOo05KQ1R6GclTSbzLCuxrRklzKoY=
X-Google-Smtp-Source: AGHT+IEVpzq3/27qDU++90GkptwsrxjMBHkYrh2zLbxXG+y+Dk0KoljAZgjZXHsuQyGhfMpP4NIhP9nRQEGnkK0UkxI=
X-Received: by 2002:a4a:b141:0:b0:591:c8cd:a13a with SMTP id
 e1-20020a4ab141000000b00591c8cda13amr9317821ooo.0.1703017367009; Tue, 19 Dec
 2023 12:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213102808.94695-1-yaozhenguo1@gmail.com>
In-Reply-To: <20231213102808.94695-1-yaozhenguo1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 21:22:35 +0100
Message-ID: <CAJZ5v0i4DAtzoJUyN0H-4rL=HR=cNntqrrJaDj12suF=7JiyeQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Emerald Rapids support in
 no-HWP mode
To: Zhenguo Yao <yaozhenguo1@gmail.com>, srinivas.pandruvada@linux.intel.com
Cc: lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:28=E2=80=AFAM Zhenguo Yao <yaozhenguo1@gmail.com=
> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't lo=
ad
> unless the CPU model is explicitly supported.
>
> See also the following past commits:
>
> commit df51f287b5de ("cpufreq: intel_pstate: Add Sapphire Rapids support
> in no-HWP mode")
> commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers support"=
)
> commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support in
> no-HWP mode")
> commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support =
in
> no-HWP mode")
> commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support in
> no-HWP mode")
>
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>

Srinivas, any objections?

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index a534a1f7f1ee..39e0a2cf7236 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2406,6 +2406,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids=
[] =3D {
>         X86_MATCH(ICELAKE_X,            core_funcs),
>         X86_MATCH(TIGERLAKE,            core_funcs),
>         X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
> +       X86_MATCH(EMERALDRAPIDS_X,      core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --
> 2.39.3
>

