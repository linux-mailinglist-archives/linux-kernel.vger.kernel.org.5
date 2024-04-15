Return-Path: <linux-kernel+bounces-145008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42568A4E12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA4282953
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0C633FE;
	Mon, 15 Apr 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMUdVDOf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC21679F3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181819; cv=none; b=fDv2xpE+RRCYw6iqrIoY5uoZ7AYrOigeRPahpFyfa0KXTveP78c43KYjYHZGPK0ZqGOplNlYYyMKivFVE8fbFR/HFVoSkJJBM+6d4dzaJllKUgJSatBieYHciZt9DgDZgZmqNVG+YpxpP0eziZ/SL5IeVIs7ruVT2ynTAAbC9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181819; c=relaxed/simple;
	bh=osIuru2dQlM/5ftUURwTCYIi4ZO5xs/lOgpgf0yu2E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxXtfT1ayATjd8AkFnMUP8oRP67rHOjqP1dGGIS6mKIAzwyzv92/Uq6JZYPaPB2+GbZfkKtVLKxbGkalJ5QGpFyLwxwriJASKRPq2/8bYTRCtqtqthygWqdgGzp6rzWHjgA0OuIJi0Xi4KqkHrWduJLs33++UEhTTu1m/pMY+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMUdVDOf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713181815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osIuru2dQlM/5ftUURwTCYIi4ZO5xs/lOgpgf0yu2E0=;
	b=QMUdVDOfHqetLGNdCAPcMoTomMC/3SbJt7AoMyXRre4wZg1uFee9rc7u+oqmN2gCFeM00H
	ZjXu9qhMb8T5uecatnlcojveixfeKs0GCrhk5i3eSNzXQrWuTOYKbreTsTDkVgi5wky3Rq
	R8v435nx1eyI973mrHJiD5hjX39f5QY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-ZezZJmkOPlqwktbIlin0Tw-1; Mon, 15 Apr 2024 07:50:13 -0400
X-MC-Unique: ZezZJmkOPlqwktbIlin0Tw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78ed22211c4so357477985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713181813; x=1713786613;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osIuru2dQlM/5ftUURwTCYIi4ZO5xs/lOgpgf0yu2E0=;
        b=uE6QUNQ75ZsxZEBdh/Q4aLJWCNHqelNKTkaz9QfQp08T5sA0tbBPo79zrt6BrXrV0h
         LLFfsWQwwlVlf+sOcpMWoCd3dFURwoc0uYp3a0++jRZ8PTwACvbSdHoDrjR3Ye6SUPqG
         bCz+qfiMF8QOsyFfBsb2iT457zK3qNgBrPv73L0sQgHAFecFqCmlFSqfNMFoF5I1dkmn
         Y65Sn3ThvkhTCGAf8Mal9SyYQ+gRjSxD7OSueR2umCNKZA7JT5KZzruBh/ZnvcQw4dAf
         Xhotc7Hq1eDeTQT+9TkygpuM1XpTfeROMZNxZHB32R2zr7G5mSoBXHBsUENi1jJ9fxKq
         53mA==
X-Forwarded-Encrypted: i=1; AJvYcCUgIMqkMCF47bRAOH8Xe4iScysJoZ96PNkIiW3RYsyjoxLH4Rqzp1N3WsOl6dUezcUj5qzo9cnPyvOHKgud/iw0+vtLujyxnCD+dDEj
X-Gm-Message-State: AOJu0YylmcXbPUI5f0jMsYHC3NDukd5wOLpEKBk5EpXqo9AFNjODD/uk
	B3te2vrZsTTXLTvF+ji8F+NIt0IoGeKdYoh2HmsURZ0fjSugJ67lUzKTKE0kZFxdJkrkvRhBgJL
	WBXqKsTMvDBH37Up8rIPQ1Re3r4+K0+rjAmJi3vHqWDttYXy9XXKpj3HKu59RTg==
X-Received: by 2002:a37:ef18:0:b0:78d:751f:64c1 with SMTP id j24-20020a37ef18000000b0078d751f64c1mr10591136qkk.10.1713181813250;
        Mon, 15 Apr 2024 04:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7yK4XX2ZB+EwdeP/psUVE/QqwuKvXArIsjty0YhNRCR35MpLenystRwftGw3nnZcZQvthOQ==
X-Received: by 2002:a37:ef18:0:b0:78d:751f:64c1 with SMTP id j24-20020a37ef18000000b0078d751f64c1mr10591117qkk.10.1713181812992;
        Mon, 15 Apr 2024 04:50:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id q18-20020a05620a0c9200b0078ee7bad7a2sm1297863qki.3.2024.04.15.04.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:50:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Kyle Meyer <kyle.meyer@hpe.com>, linux-kernel@vger.kernel.org,
 yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
 Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
In-Reply-To: <20240410213311.511470-3-kyle.meyer@hpe.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-3-kyle.meyer@hpe.com>
Date: Mon, 15 Apr 2024 13:50:08 +0200
Message-ID: <xhsmhr0f69767.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/04/24 16:33, Kyle Meyer wrote:
> Optimize topology_span_sane() by removing duplicate comparisons.
>
> Since topology_span_sane() is called inside of for_each_cpu(), each
> pervious CPU has already been compared against every other CPU. The
> current CPU only needs to be compared against higher-numbered CPUs.
>
> The total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 on each non-NUMA scheduling domain level.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


