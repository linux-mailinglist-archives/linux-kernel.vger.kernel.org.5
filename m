Return-Path: <linux-kernel+bounces-91140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2C8709FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A391F21121
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA978B57;
	Mon,  4 Mar 2024 18:59:11 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323561683;
	Mon,  4 Mar 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578750; cv=none; b=hynU4giPi41x3q7dUtOTD04MdBmI/0CbpPCRLAsHzv4wILUsHEKLf+4kKH8lyboU3saVElCe9NoNWE5TV8Qswl52g0TpPKa8pMQl3RX2uptsb+WDBZbbymNtZuPpQJ1lHcTag68gIPEWNhbqiJZwebdHEyjmlbmn2x/HqpLca+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578750; c=relaxed/simple;
	bh=Jp1XZWCbGXd5Su7YdPmd2hYyP7fJ8Ya2gj4sgMC3y34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqI5DKM7TjTZHdcpgHATdwj3xmBvtKzVFlV/5Wy810+oGIqwyUxZQypZhRxWbuRRIYoI/MFMJFFI7a2WcSOQr5PmGEemJIePH5aLPm/PY1jU6e3kwu15LgZxxE4K3NWXtOqc81B4N+0DA7DeaELrwFsYmrbtJTWyG+GIo2QCyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4399337a12.2;
        Mon, 04 Mar 2024 10:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578749; x=1710183549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp1XZWCbGXd5Su7YdPmd2hYyP7fJ8Ya2gj4sgMC3y34=;
        b=tdWFKVMMM2lQ8zCD8ooX0FejKYhqyLTqneC4EbH+EdSzW2Ios/Q94a/SUn4EB+06px
         KPCzuAHK/bxTwwOMej06ZM1FK8CQaDb5jCp54sIJxbDuIA4hbTFfG/gyOC7P7LBOtlvJ
         Xqp3pGgfXajcSJS1/mlCYtYFtDIJkic3FNirZAl4UbU4W59BA5dEVDpTyucvIS9sVDQd
         ft4uS9hM3oLJ6Jj76OL1mmaPq9DrAJKFd1R3ie4oMIVmkFpllGjNiLm+xvSR4bdZgb1M
         ADZXq+RwclthrABXGvSZLqEW4pDgcQIalr2R8ahdy6+/irjiU6UGd//Pcz/CEdC0cJ1/
         WN+g==
X-Forwarded-Encrypted: i=1; AJvYcCWmNjElzJOX+ffuMrQ2SYsP6ftjt+pciaCwGtj5dZ3K8B58LIbb9/8wiE2d7fanh6VOWOfCo0KeXXb54b76BAJIwfHX1f/D8EOJru5aZEVq91cjwXC+JQ11VQuURjlx8gL3x14dkFDyKWPuRB88pQ==
X-Gm-Message-State: AOJu0YwC9OZAgUIBfo3RGjdaIxdXru2f70emrGKEx/8JC6O46k3A328P
	2ZB63aYkmcL29vQUVA823E4g+6/e3e17E65vKF2dcI+rGHDV2BMnqFJExsGuOLi/4vxqs6F1C4e
	/LGe85mZB+RJPQHUmZmKI/9YXJg0=
X-Google-Smtp-Source: AGHT+IEP0d9Rpg9POdnDSrHHBt7yXGpxqbChVpxj/ggsd0V1Y4WWT++DoXA2PkIgvaQwZUmHjci4SRiV2EnES6Movpk=
X-Received: by 2002:a17:90a:8041:b0:299:300c:4c71 with SMTP id
 e1-20020a17090a804100b00299300c4c71mr6453325pjw.28.1709578748766; Mon, 04 Mar
 2024 10:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228170529.4035675-1-irogers@google.com> <36449491-c17b-4d85-a1a0-f5101bdb42e7@linux.intel.com>
In-Reply-To: <36449491-c17b-4d85-a1a0-f5101bdb42e7@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Mar 2024 10:58:56 -0800
Message-ID: <CAM9d7cj4R+f3eV2SkDCpLH-X1M6xVqYhY-oyJAAeSvCzdhUf6A@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events intel: Add umasks/occ_sel to PCU events.
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:46=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-02-28 12:05 p.m., Ian Rogers wrote:
> > UMasks were being dropped leading to all PCU
> > UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
> > drop the umask trying to be consistent with other sources of events
> > like libpfm4 [1]. Older models need to use occ_sel rather than umask,
> > correct these values too. This applies the change from [2].
> >
> > [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/event=
s/intel_skx_unc_pcu_events.h#l30
> > [2] https://github.com/captain5050/perfmon/commit/cbd4aee81023e5bfa0967=
7b1ce170ff69e9c423d
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2 corrects BDW-DE, BDX, HSX and JKT to not use umask but occ_sel.
>
> Thanks Ian for the fix.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Applied to perf-tools-next, thanks!

Namhyung

