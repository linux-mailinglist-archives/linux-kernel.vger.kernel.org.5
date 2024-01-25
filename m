Return-Path: <linux-kernel+bounces-37957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E108883B8CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FCF1C23BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76C79F1;
	Thu, 25 Jan 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYBslUBh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435979C6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158466; cv=none; b=b58Fozk1XlHzgJGQTEW50k8x2VUz+w3lLfFWp8yJ92cHw+Tv/yDBDTcBM35wzA1oSgH6IjhCyv1C6ldHqtBPWRHmDkOBhrSw+JWFw/8Wz37wmJcciFnolxqF42rRsxnh9wZ8eFQBbRgB1EbrBaPGGU1FQduELCvKOZEvsBG2+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158466; c=relaxed/simple;
	bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbWyLqNhH4uIf5xlPTUL1W3eqZMi4qZ0cPLTCxshJKkwwzokb421DLBQO2okq07Hw1zUu9se740a2u20CDdR7GcaVaI4k/vd29SNP5ON367lMGEkt1YvQTlYPmGSRodXt5ikJB3UJLt/5f9P0sT2i2wOlCCn5yV9afA7w93rnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYBslUBh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76f1e3e85so90155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706158465; x=1706763265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
        b=KYBslUBhHYnRbtEOssPRg1sIKHjI8Lo0tAolcbPFTk7Zz1yslplDzC1rXa2wBilOhm
         zxPgKBBm3R/ZuM872QgdRU1RFvMN8AC0BH21pnHLDRn8oKpzTwlXu11WzJNNw9GqZBCn
         eObwDyj14Va/2mzeQSBxazZBdQZgafH8Yw77xqr+Re/D6HKTvl4z8hvwqJNlb+c1Ucm6
         Ip4//zYBB9FEXFvO1tWKYyTZyKd5jkzrKm1KxJdKoozrHoH6iXFKQazF2VPu4S3eit1C
         XGe+H1zWts/U7p8MSSq3+TesHQvyOsEaeQGabkGicLmlCrRIIWPiM+3nUEZKbR9a+Bh3
         3D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158465; x=1706763265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
        b=XElG1oJrSDgiEpKj2/uQGUwATatCzhep9CxoOgy21T4cCcdOqYoDu7aLTIhtQSFWk2
         3NDa/V6L57J79HWIEYSEBM7CqLRYGNQM3ufmC8AZt8HNUYGrOn9KOw/eBIowtaDBd38G
         lle1DGRwelXrV3TRPhxdfIPY41T+18ApKiC9MrpADXjacExKsGY98AlhGKHlRfWhU43Y
         S0tSU5d0lP8+vv/XIH5zMCXb2ejePLjDyHquQIQag2fNHcQFr/H7lXNTIVFkjeEx7En1
         KQS0wHgoUfI9yvkqcsPnrLqJtW1j818jx6uK6uWZC6hR+tbv3MA3Z/NsdJfIjBBn092c
         Actg==
X-Gm-Message-State: AOJu0Yz8Ytv8zhG2uIHA6AACRiLG9yo6bqIiD7eUHNBQnVe31t6o3pl0
	ICny5d1uturI6aiYxLHoQixdU6StOl9VDqQQ9ywQFDIBZ7FSoTSj2z0/H4WKpyTdGgzZa2cbHjg
	cSvtouYUBSwVZc1foGPHnxYVYmM0yKdFi4VS9
X-Google-Smtp-Source: AGHT+IGmwUyV7ad6tGGpwYKy06i1bLqX3aP6rnMCqtrP6eCDM/dw9PI9hnQa4rcswaKttl2+4JOZaCJ4y/v8gXKio/0=
X-Received: by 2002:a17:903:22c8:b0:1d7:37f5:5619 with SMTP id
 y8-20020a17090322c800b001d737f55619mr104642plg.25.1706158464470; Wed, 24 Jan
 2024 20:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-8-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-8-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 20:54:12 -0800
Message-ID: <CAP-5=fXDWbp90cQ62tjEahy68DF+YGiWWhXxjMLNfLq_Ce98-A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/18] perf pmu-events: Add event counter data for Icelakex
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:03=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> The added new fields are required in this new grouping method. Currently,
> the format of added fields are temporary for experiments.

It'd be nice in the commit message to state which fields are added.
I'm somewhat confused about the meaning of TakenAlone on an event.

Thanks,
Ian

