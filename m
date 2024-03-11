Return-Path: <linux-kernel+bounces-99315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F2878667
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A431F23507
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E143AD6;
	Mon, 11 Mar 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RLmMYXul"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59061DFEF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178817; cv=none; b=LAMjxcbImuBL2Y9Dd2iTxvRXfby/r7z7ubaEHGRWrhKpoNdqqvjoMaTizjBz/9NWe5Ux4COP8cF+vrp/XaNWW6uTcsWrRAaKH/LB2T5YrmRiKMVTyAIOkZX0ZMSrNLF8aOBOHu7tCoGpMfwOQ3/aadxKK24RTFFGu0zoTfgrXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178817; c=relaxed/simple;
	bh=hd5gikp0vc2N6bZJgrq9wVj+rRiZAjXng1Xqa7TV6CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx+EGMvrCtH2dIqLmrzkGWnBxmqKp+GXX0mBMA1c8spThhNAQ1CQtrK9qCw9GWUTPGFqr6fD4dnDE4rJuNwQbeADwIAULvFjCLKMhkqJVnnnGHngzhnh7dyWZ3aJ1cQzLfCgDtb8CawmqsPtCy7yKMrruXdjup6zGfIQogdGoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLmMYXul; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so14641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710178815; x=1710783615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvZZjW8V4QSv3wSrX51FU3CWzJnSisLpykPAhfx62oc=;
        b=RLmMYXul5Lb55mekU56XpfSUrEerlLqefGzfBq8sjyBlxJuGcxm9KGuH2XABt2OMnJ
         GplLqeuy3s6gkK87tOXWd90yypN3feEJc+KNoe/vViK49uWlObUdWGtw0t9KLmrWgtie
         JRLjfjfn1fuVISXrq5drV+z+kdFTJXGHZLbMmZl0mzRfy/4tsAumoCqHtavFdRzdu1m0
         qyOLyAgGX4cTGZ+x1bdxInDZ3lbL/mt2aSuN5hgWYXQEUnsIHcs90KvczTbGwhO961iR
         KeAYHNX9csb/qXOnnaUCON3LrRFneBdIV1H0QC7UW/ldU3pRh27JY9314nWlvBloDQKv
         Kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178815; x=1710783615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvZZjW8V4QSv3wSrX51FU3CWzJnSisLpykPAhfx62oc=;
        b=IP2ntocIr9RrW9v7NTkZgc+rMx7ZiSR4Z3PiZW3N0lurwRjaJt0ZyW8rlBr7+f7cL9
         mOnbo5KHjuN6IswUUlIpmbk6I2hTO0xSEZrloQTu60vxB0PFm63YM5LSTxJ01ABxUG/3
         TJohUg/FTKJwLOiysu8SCtvil/9fiGRJP2lYbYSkUqiDMGc/yeGNaUSUzx4G7CX2cNY0
         ultAM3IZFrvgrvdpRv/7dxI9dw/NGJ96WqtS3/pUrUowp1jTltMgNRyS9iLWSqj3OBq2
         TqjHYKr/KrRGW5urdPJV7MsVthNmrOohogUM+1Em2vClhS999jylRWD5ZmFinpobILqL
         GAjg==
X-Forwarded-Encrypted: i=1; AJvYcCV3RMMUm1YxYGECunn59fX9ZT8e3BZumK3hV1yCHAFBgf68uArZpK+PJyOm81Q+DRVibqVxHTQK02nwskz3qtJ0JfVAlsHCNVAaRkgm
X-Gm-Message-State: AOJu0YwP8wHPV843lEnqmCWT9auuEz9JKSGpxo29d/3r0PxX0q5FkwEH
	3dSm85jo2yXozyFTe52a39LjZR8+Swu8ZstAZD29WOE+IJvQudji854h6Zpca0VoEYyhoND9zBv
	Y2eweu/qMKF6pqP7oISeO3U0u6d1xgj2yGrov
X-Google-Smtp-Source: AGHT+IF6099lhAbQyfyLMhuxPuQThWGNDNo27yji/hbKmnIRQDm5vZwakil94YZV5a6pABPWkLV86cxbd7Q9c0l+Pr8=
X-Received: by 2002:a05:622a:13cf:b0:42f:a3c:2d54 with SMTP id
 p15-20020a05622a13cf00b0042f0a3c2d54mr1221194qtk.21.1710178814682; Mon, 11
 Mar 2024 10:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710133771.git.sandipan.das@amd.com> <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
In-Reply-To: <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 10:40:03 -0700
Message-ID: <CAP-5=fUV=6my-+z0Qc+TS2+CbKT1DqsLbpHZrZLitqpAnDd2-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events amd: Add Zen 5 core events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:23=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add core events taken from Section 1.4 "Core Performance Monitor
> Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
> 00h-0Fh Processors document available at the link below. This
> constitutes events which capture information on op dispatch, execution
> and retirement, branch prediction, L1 and L2 cache activity,
> TLB activity, etc.
>
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D305974
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../pmu-events/arch/x86/amdzen5/branch.json   |  82 ++
>  .../pmu-events/arch/x86/amdzen5/cache.json    | 605 +++++++++++++
>  .../pmu-events/arch/x86/amdzen5/core.json     | 122 +++
>  .../arch/x86/amdzen5/floating-point.json      | 830 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen5/memory.json   | 180 ++++
>  .../pmu-events/arch/x86/amdzen5/other.json    | 168 ++++
>  6 files changed, 1987 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point=
json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/other.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/branch.json b/tools/p=
erf/pmu-events/arch/x86/amdzen5/branch.json
> new file mode 100644
> index 000000000000..208c646c59ca
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
> @@ -0,0 +1,82 @@
> +[
> +  {
> +    "EventName": "bp_l2_btb_correct",
> +    "EventCode": "0x8b",
> +    "BriefDescription": "L2 branch prediction overrides existing predict=
ion (speculative)."
> +  },
> +  {
> +    "EventName": "bp_dyn_ind_pred",
> +    "EventCode": "0x8e",
> +    "BriefDescription": "Dynamic indirect predictions (branch used the i=
ndirect predictor to make a prediction)."
> +  },
> +  {
> +    "EventName": "bp_de_redirect",
> +    "EventCode": "0x91",
> +    "BriefDescription": "Instruction decoder corrects the predicted targ=
et and resteers the branch predictor."
> +  },
> +  {
> +    "EventName": "ex_ret_brn",
> +    "EventCode": "0xc2",
> +    "BriefDescription": "Retired branch instructions (all types of archi=
tectural control flow changes, including exceptions and interrupts)."
> +  },

So the "bp_" prefix means branch predictor, but here this is an "ex_"
prefix. You've put them both in the topic "branch".

[ ... snip ... ]

> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/other.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen5/other.json
> new file mode 100644
> index 000000000000..9d49a23622e9
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
> @@ -0,0 +1,168 @@
> +[
> +  {
> +    "EventName": "bp_redirects.resync",
> +    "EventCode": "0x9f",
> +    "BriefDescription": "Redirects of the branch predictor caused by res=
yncs.",
> +    "UMask": "0x01"
> +  },

Here is a branch predictor "bp_" event but the topic is "other", why
isn't it a topic of branch?

Given the number of events categorized as topic "other" wouldn't it be
better to regenerate the events just using the prefix to set the
topic?

Thanks,
Ian

[ ... snip ... ]

