Return-Path: <linux-kernel+bounces-131608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13DF8989FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD0A1C29233
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A112CD8F;
	Thu,  4 Apr 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+aU6a7o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443312BF02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240532; cv=none; b=ojMxlCsrGOa/3vkrR3gOlQThbwqEe1LH0jVoWOjhiDiXExby9+K5VXfKZzKBlpfaqbpJlOXISKdWOGo2CAdUZkoRxMcBPsYC8z3wwEId87iMNkin7+vDtPKH2kRcJ4TeLwzdExavGlD+Jgrrddi1t9gcP/y2PqYPOBU1RFBWEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240532; c=relaxed/simple;
	bh=2cWTzX0zgJ2dUrcHjDb5nbu03D7jEnE/87jcgSZkCfQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNvtrDvQAGy7cmjb6WCZPurdcYhj0OCbZVNMW94rSSiTOHItutWc7yAjT5QqayoOhdSwUFwz2ZkF7Kz7sA4L0Y0FcIeyxjvti4He5kS0O4dxnGElcw2uGW79gRtlwjXb7inJnDFMvMHHbWlfppxv2T1vqDbIif2kKHIQvGDrquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+aU6a7o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712240528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcnLrydmfQX8SlteWcvzLWBpNoquMDGK5EArArRbwgg=;
	b=a+aU6a7oJ/m1wLHmrwPf8ituvrgyXTQo9xECRkUzZBNLnua1ykBCjOWcj1zv//9qNa0vHc
	NtVBJFQvI+8kIcsHpjjQ4q00uTBrmC55OqF23/qO9stdWBJ3+g6aTR6GDYDo1m/LNIAOgS
	8NDQQK1XfgjZl7y/uBZAQ7cfvc7e9nc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-8YizbzUrNSeGjimZw0c17Q-1; Thu, 04 Apr 2024 10:22:07 -0400
X-MC-Unique: 8YizbzUrNSeGjimZw0c17Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78a75243bfbso320245385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240527; x=1712845327;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcnLrydmfQX8SlteWcvzLWBpNoquMDGK5EArArRbwgg=;
        b=PJnlc0kn22pPH8EvTw5SPSHlO36rcx1lFAg6o8fx+yK9Cv2SyDKY21kLJPPqczHDf6
         pJjqPEs4d24HubWNcQj0LV+j/2QkJtk4EdUmunSeQGbva/MEDpYTfgAswDYlJfepHL97
         8f7liFKoxzv4uwJQsMIr5Hedq2SAWEL41L+m0bYyrKYGS2P0wlJyGgDn3Pkun+3kfh4f
         /zUsE0UtTSi17WOM+aN45qwxJg3umyR/mpxgLg1/NNyDCnQq1h9DMXxk0XLLZzdkxjTG
         RRBZITGB0wPnmKGsRQrT3683N2c5SJHhImzPRP9gSLRW3toUQ7iLpqxYIwp2NleXC2rj
         UGag==
X-Forwarded-Encrypted: i=1; AJvYcCV1QTxjBHp2pNSSOp1yUBuOC7qC5BqP7VygWox4brnl4+CJ+OwG54zErcIJbckkK/tVBX5cH1sAvxPxTCNa9YvpVyKyhGFm6sPNU5uF
X-Gm-Message-State: AOJu0YwpLaUe2QydHVafPKQDE/i7uTaOBGZoJRpGkX5YYPU4VrgkesF+
	YW8NZuvteUmE+e8xkd1HQ/ocV4AtWkIaAmwJ60y9+U/kLeKB651IZH3t/7Q5BNwdahFjXFLM+++
	G/pqURrgVGs31wfdALiud/8T9yiiUgYeld/8j16FUxk0HJpmTPe32hB5CzFHhzg==
X-Received: by 2002:a05:620a:6124:b0:78d:3b55:21c8 with SMTP id oq36-20020a05620a612400b0078d3b5521c8mr3691965qkn.24.1712240526723;
        Thu, 04 Apr 2024 07:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlFYbfjgK7cm374RDiyUOkiv0HiQERfK/s5Fwc7/Q1SOG4DwUzk04ElPPDlMsmsbNlE9qXtQ==
X-Received: by 2002:a05:620a:6124:b0:78d:3b55:21c8 with SMTP id oq36-20020a05620a612400b0078d3b5521c8mr3691933qkn.24.1712240526433;
        Thu, 04 Apr 2024 07:22:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a056b00b0078a210372fasm5931267qkp.86.2024.04.04.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:22:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, Vitalii
 Bursov <vitaly@bursov.com>
Subject: Re: [PATCH v3 2/3] sched/debug: dump domains' level
In-Reply-To: <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
References: <cover.1712147341.git.vitaly@bursov.com>
 <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
Date: Thu, 04 Apr 2024 16:21:57 +0200
Message-ID: <xhsmh34s1b43e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/04/24 16:28, Vitalii Bursov wrote:
> Knowing domain's level exactly can be useful when setting
> relax_domain_level or cpuset.sched_relax_domain_level
>
> Usage:
> cat /debug/sched/domains/cpu0/domain1/level
> to dump cpu0 domain1's level.
>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> ---
>  kernel/sched/debug.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 8d5d98a5834d..c1eb9a1afd13 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>
>       debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>       debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
> +	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);

How about reusing the SDM macro? ->flags and ->groups_flags get special
treatment for pretty printing, but the others don't need that.
---
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13e..f97902208b34d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -419,13 +419,13 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 	SDM(u32,   0644, busy_factor);
 	SDM(u32,   0644, imbalance_pct);
 	SDM(u32,   0644, cache_nice_tries);
+	SDM(u32,   0444, level);
 	SDM(str,   0444, name);
 
 #undef SDM
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
-	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
 }
 
 void update_sched_domain_debugfs(void)


