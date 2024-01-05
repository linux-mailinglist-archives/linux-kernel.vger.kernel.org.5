Return-Path: <linux-kernel+bounces-18410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E84825D11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544921F2463A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24170360B5;
	Fri,  5 Jan 2024 23:12:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D37360A3;
	Fri,  5 Jan 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28c075ad8e7so94806a91.2;
        Fri, 05 Jan 2024 15:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496351; x=1705101151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUAhNqUpdKmg+sUIUDMYqgFuBhU5t8vIbGzf07x8V/w=;
        b=XZHvOfwQfZ3I4/5wHv1X2j/Po6Z50wGyIEVN0kxPmjoDVpd0phlcHehr2+q4fPrr2r
         aot5S2EBSl03w0GvN6z3oDn23X2/rF71J4n8qqdW8zrYU0JpjCReBZMxiNHG6PitU3CM
         b+7erP9wsuduVi/zL/DpVOYWjbOmQUSsnt/+2jj77pkyFVeI+hwQHiidk+6cDMny8zjH
         yk4cXGArHolG1I1bqXLebmkLdd3N+4FGEYS2xhGumcUc7XxMkk6xatQrE5VXZhfmF363
         6WpXeUXYJXjlstWL4UVjczL3TihNdphdv2iVDGWfSgiSByOOGKBm4gZ41IuEgfs+6E7k
         Twsg==
X-Gm-Message-State: AOJu0YxSfZkBCiZDhiHFuWKSp2vtVW7kTDEtQ7KAh1MTtknC5JLuf2Oe
	rjgOYP2phsZAI+kDbWaURwit2NkZE/YmZAvsw0tLGoBF
X-Google-Smtp-Source: AGHT+IGGIGElvesePWzf2AKJd00KSRLZdRgA9eddzlMLNrxojV3lc2haH3+m3r9GCnfVb/oyQA4w7HwES29gQ29TXts=
X-Received: by 2002:a17:90b:4b81:b0:28c:c667:450c with SMTP id
 lr1-20020a17090b4b8100b0028cc667450cmr170349pjb.66.1704496351484; Fri, 05 Jan
 2024 15:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102085001.228815-1-leo.yan@linaro.org>
In-Reply-To: <20240102085001.228815-1-leo.yan@linaro.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 5 Jan 2024 15:12:20 -0800
Message-ID: <CAM9d7cg3Qkx240RBGKYegeX-kxgUiQ4-G4R3sJBc=w=o-Msk=Q@mail.gmail.com>
Subject: Re: [PATCH v8] Documentation: userspace-api: Document perf ring
 buffer mechanism
To: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,

On Tue, Jan 2, 2024 at 12:50=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote:
>
> In the Linux perf tool, the ring buffer serves not only as a medium for
> transferring PMU event data but also as a vital mechanism for hardware
> tracing using technologies like Intel PT and Arm CoreSight, etc.
>
> Consequently, the ring buffer mechanism plays a crucial role by ensuring
> high throughput for data transfer between the kernel and user space
> while avoiding excessive overhead caused by the ring buffer itself.
>
> This commit documents the ring buffer mechanism in detail.  It explains
> the implementation of both the regular ring buffer and the AUX ring
> buffer.  Additionally, it covers how these ring buffers support various
> tracing modes and explains the synchronization with memory barriers.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks a lot for working on this!

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

