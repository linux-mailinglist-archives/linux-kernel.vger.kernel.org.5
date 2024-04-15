Return-Path: <linux-kernel+bounces-145007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E118A4E11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283A9B21EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4564CEF;
	Mon, 15 Apr 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKOafp8Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C705DF05
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181811; cv=none; b=Aw813nUU8RLuNRjYtb3gxeSpSoB9U9SGoD/1KOzh3D0xswUJD/xLyRHDz0Jtgaok/l4MvCcEiCG4GCKuQjCXOuLROakvuOa43eV9Y0CfC7GQ5MniakGH2RiumUF4YLGuZwY+QAfDjygYYSrOS+4It4YThYls/tivW5Z6mOu03OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181811; c=relaxed/simple;
	bh=prV9nxnS3R6i6443IUBNHL0DARIdtsZd5Aupy++qJc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtH9dHYdYIojsPD4vhd81mv2IEUwF4IpYsfsriuEa71X8qdtpvyx5Rkf4v+queuuX83MblZQpFhdEhmMxRGKXbcwwHjK1SC/1nzjWPsoAZ2mY8S7iEbGaUgkeOvVUZhHAN+24zrt2RMqbvy5ggVPVzqAiI0IMoP5n266n3At4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKOafp8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713181808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prV9nxnS3R6i6443IUBNHL0DARIdtsZd5Aupy++qJc8=;
	b=KKOafp8Y/fQwWemZ9PDWvdUuK8ZYYscihufA+pElOi6ATGcDp2dDD9ZiYxvcmpUyPyXjp7
	ccS6yVJvaYcGoN3KD3E/pB5I3xvtN5gDrMIH6RMau8RScWYTzjiwAImTYwuZw8eNV60U69
	aJiaJH9gbKKl33ek1jXvposw0vravaA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-tv-39asWM92laTG-3s48TA-1; Mon, 15 Apr 2024 07:50:07 -0400
X-MC-Unique: tv-39asWM92laTG-3s48TA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso5646156276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713181807; x=1713786607;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prV9nxnS3R6i6443IUBNHL0DARIdtsZd5Aupy++qJc8=;
        b=wgdrAafZLoOTWMq0zwP2oz/hbMacD+qEPxb+FzsG36qEaGAu7rG4NJ8p9GAVeRmN/Y
         SeoDuFNx+ly0Gy/Jb6GWKsjPL0Oxbd4tmJoym1cyrf1yuEkhGrPNChCUFrFbj8Et0umC
         LKS7+sN7H05Hbts9E5yM8e/N4d1MoDChwHwbpmMira7jwTEwxdlOBzhdHSK4XE4RYHOm
         lHw3wImWzxcwK4DasGHqgC4VGTFVkKxPto+bm6DiU9/EKkW0mnM8swSjdf2jcqkPFJxu
         ToAc7stXUR8Y25DLUKhQdvOs7qcJJDJ775s2S7WQzg/F6Z4AxEpamUp77fHjuf2b15Bp
         7orw==
X-Forwarded-Encrypted: i=1; AJvYcCU89u0Q5p0rjOF5RryMAYAOgvulkVtbFe32CCCJ6ztLkqaksJ7RSx/GRQsc/qdkhOWdHLwpNF6XSfuRnz9gBD75GE/Emt4cd1dZdj25
X-Gm-Message-State: AOJu0Ywdd/NjVIeHoLz8oFLciJVCUTuSu8Y+Uo5g05S6syiuDw88/4RM
	3mepcT81pyoeJqNycDYrPTls8KGoVpQI4rNPugH4XfIMXPqrPx0VS5/miY6Hbfh/9aEjhQfp6gE
	QHWQ/jQdYRSHNXS2aBP9+87VNkup5NgkoRRa0t49XsLEqJpIAUgwsvWI+yCUVSw==
X-Received: by 2002:a25:ea52:0:b0:dcd:128:ff3b with SMTP id o18-20020a25ea52000000b00dcd0128ff3bmr9325163ybe.38.1713181806941;
        Mon, 15 Apr 2024 04:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc8DAUXqr4v9jdSHsdvquE8Nb0gdhinACZCc+K+REKq3pdM+9wJB1BMZe4XTRCTmBbAHOz7w==
X-Received: by 2002:a25:ea52:0:b0:dcd:128:ff3b with SMTP id o18-20020a25ea52000000b00dcd0128ff3bmr9325145ybe.38.1713181806597;
        Mon, 15 Apr 2024 04:50:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y16-20020a0cd990000000b006990499de91sm6101846qvj.51.2024.04.15.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:50:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Kyle Meyer <kyle.meyer@hpe.com>, linux-kernel@vger.kernel.org,
 yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
 Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v2 1/2] cpumask: Add for_each_cpu_from()
In-Reply-To: <20240410213311.511470-2-kyle.meyer@hpe.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-2-kyle.meyer@hpe.com>
Date: Mon, 15 Apr 2024 13:50:01 +0200
Message-ID: <xhsmhsezm976e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/04/24 16:33, Kyle Meyer wrote:
> Add for_each_cpu_from() as a generic cpumask macro.
>
> for_each_cpu_from() is the same as for_each_cpu(), except it starts at
> @cpu instead of zero.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


