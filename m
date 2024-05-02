Return-Path: <linux-kernel+bounces-166676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8D8B9E00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E932849DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158BD15D5A0;
	Thu,  2 May 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAhZEWjE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079815B96E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665672; cv=none; b=h0K6o2cfBqqA3h+G3m6LtvUyVl96lr9jxOdgTkS8IBRRphjcIe4PMqku/U79w/S+CygEMGKTJgd+XS4AXDqIeh+CtEwu8f0W2VQmWUMfaWMoTlpE3Rd1//bTvE+dcMY77r0bxCjn9d0RQIMINMl6iuFK2dQinjUCYjd6IPlL4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665672; c=relaxed/simple;
	bh=hZ9WgVxz4LHuZQRg6XFiyFuyNDv7J6W0kpPGWPAkj9M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ljLtdIo1HqsWZel2ZeyvOdBp0lf634SV4e/uaF5ZnV622IC0hlH0v4IqguW0VIK/BFojrNERyECaYhEf6ljp54WIULgE52M4n7bXP3wUxVmSARwlCBSB8yXJ+GJ5dQilQOZf7FEBcDUGsOAkrmKhwMUQ+bgFas7+EkrGEDGGlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAhZEWjE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714665669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ9WgVxz4LHuZQRg6XFiyFuyNDv7J6W0kpPGWPAkj9M=;
	b=NAhZEWjEBNg090j+agJndMk9Kx3fGbqlMdK3P1qwVknoMU8Hf0V/ns1GD1R7w4XkF5DcQy
	hHNLTD/cHfseKrwPQqbmB7QAtM2JaezWlmTERTMZxUJcbPbG1PSgV2YCirgxXeCwUx9Utt
	iqs+O513KVZD5IbEg39WF5S14yymmqs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-c0Ca2Y2bOu2jNHS96bSn0g-1; Thu, 02 May 2024 12:01:08 -0400
X-MC-Unique: c0Ca2Y2bOu2jNHS96bSn0g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0dc98dc24so35604196d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665667; x=1715270467;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ9WgVxz4LHuZQRg6XFiyFuyNDv7J6W0kpPGWPAkj9M=;
        b=iEqXhSHncsfMJoicX1/Imthgdbmp2rMRlog0MGtz5JvVqXjBdpYk/TscS+vEkhRBBX
         HukDWFxZQ2VULhi3rn6Sl5KPu8RJV41Vwje63rQPxUtjeIVQVqRN7isjswm7pcgkZVkt
         U4t6HT/14xDGsYk6x4MZYBZIMzU02cahqJ6kh2ll7TSIqk5S/Jj4BboXuI8rt6CX91DT
         VFcCe9WBexPrTaBB2Ko6yl3RcGdxIKlksMrGRicRltp8LKDOjXNs5mWBeo4WlpwO09PF
         UR7HDqBuuc9Do/wPpn3+TMhD01WAq4OkeGA8AxHnay1QMWySF28aSY7cLbuS1d6O74ko
         W9rA==
X-Forwarded-Encrypted: i=1; AJvYcCVm2TflhsCs7btpF1sFpjI5DU0AhEpIHNdp7J5h5UssXkVKL0QMZRviqlorvHu9YS3NhtR7rWhj25SLmcbZDslkhk71AY90Ddqc0rDj
X-Gm-Message-State: AOJu0YwvEbM6vPHsWqimoUHGahtSTUuxyCcq+flr3PARSeGcgeiqHwaK
	VL3RU7jX15XsPm5G47xeFlIE5FAenMPU4C1xLtk6Mnkb+pg+njIvkSubBlUNu6mru6BuIrEhbWb
	FXEAP8nKNi9i9wWMwTTZqS2LXYIa9hy0V5UzsP7NFjdZTlSNkd7Ch97kUNbOzmw==
X-Received: by 2002:a05:6214:260d:b0:6a0:c9e5:a15c with SMTP id gu13-20020a056214260d00b006a0c9e5a15cmr2946436qvb.63.1714665667099;
        Thu, 02 May 2024 09:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0rXNo6Ar94GBTPIfpn+crqC4LsIRJL4g/7BOPGe/ZYWAdAV9lMZd8eBR8U6b8YnnamCZsdQ==
X-Received: by 2002:a05:6214:260d:b0:6a0:c9e5:a15c with SMTP id gu13-20020a056214260d00b006a0c9e5a15cmr2946369qvb.63.1714665666105;
        Thu, 02 May 2024 09:01:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id k9-20020a056214102900b006a0e6ffd710sm449692qvr.97.2024.05.02.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:01:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, Vitalii
 Bursov <vitaly@bursov.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] sched/debug: dump domains' level
In-Reply-To: <9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com>
References: <cover.1714488502.git.vitaly@bursov.com>
 <9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com>
Date: Thu, 02 May 2024 18:01:02 +0200
Message-ID: <xhsmhv83w6w5d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 30/04/24 18:05, Vitalii Bursov wrote:
> Knowing domain's level exactly can be useful when setting
> relax_domain_level or cpuset.sched_relax_domain_level
>
> Usage:
> cat /debug/sched/domains/cpu0/domain1/level
> to dump cpu0 domain1's level.
>
> SDM macro is not used because sd->level is int and
> it would hide the type mismatch between int and u32.
>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


