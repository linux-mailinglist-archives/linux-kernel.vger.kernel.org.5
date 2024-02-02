Return-Path: <linux-kernel+bounces-50188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE0847583
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CB1B2270E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C0148FFA;
	Fri,  2 Feb 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXIXcMAW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599051487E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893291; cv=none; b=mrmbYWaL3evtxJHSTfZBPSdA0HTWG4jqrRfvepAeWj1TxPMN6dC2piMFtDUXy9po7rZhry9mvYXDucyxI9hQp1Jmczl5NjYmB1p55rRfzK3yc+7OaxLruVGBeQQD3MWq/7snKfChZCKTxtW16yVRXO58dCCm5og1dmF/Exwmdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893291; c=relaxed/simple;
	bh=3mB32jUig8gzGN3z4yX7Jr6nWQUHLf/QhJJHR2SPVUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ofCgH3+XfzQPN21ouNpzi5b+OvmJeXABE+0oWAMRWb9j8tFC+5jI4RxABhCzyOtdI6wZlO/w751SW+kKlRo3FPMSigM8AaKgsJ2L8lRbEEVub29wx9VtUJUiM+jvaBl3dKdKI7Bp67ck2AgF7RIkykSbFjEaHtgCz9Xq2npQnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXIXcMAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706893288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mB32jUig8gzGN3z4yX7Jr6nWQUHLf/QhJJHR2SPVUs=;
	b=KXIXcMAWXRWd+Upw96oc2/+rLbxBTfwjnQn2ogqTsMa7eTB0gYnYn/p7jZSVdFP/J8RtvZ
	aA+SmyzBkaOD/zWByix0Z8l+GFWpxKmdDwsXWeu/A2DjpdIFKzeWlpSAMLeWOQkwq76vJB
	GDt54FaS3onDgZLZ6HxTvRiB6Z5SQWY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-yGHWGAg7M2KjtXGtLDsMWQ-1; Fri, 02 Feb 2024 12:01:26 -0500
X-MC-Unique: yGHWGAg7M2KjtXGtLDsMWQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5113bb1c4fdso431991e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893284; x=1707498084;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mB32jUig8gzGN3z4yX7Jr6nWQUHLf/QhJJHR2SPVUs=;
        b=SNBmG4zHeaH0JogguUOkqpEk6Pia8lPw2jTS0RFemMdZv8/Wwyn/krnEEJlNu3c7Ua
         r7OwMEWLccJNWroRZw421U4te+nAqUWo1p/ti4Ngo2U8OQ9C4DRThXuJ4veTo4hxMehr
         wIVMB3oYWlLCq+ar4fi91YV6geXjgVjhCL5Eloe8kS/lxpD3RFF2AUVJ4TcFrO0AP8qP
         ZxW6EMBjE2t7+lJj2VAFmuJujW+UeUAB8+daE+m3ea9Qdws4OUUgqlBsRzGUm3X7iivk
         ncVb50G1XcuA4luwCtILxRqUUUmoS6+y8DfJQRG8ODP+xgir+epHdL4TwYkRTzk/5lGO
         2c5A==
X-Gm-Message-State: AOJu0YwOb+SfWXwMh5U421ZuSxUIXvZmza9tMm5oQAoX7Mze9LYQdfB0
	TYBAarXe1UahQ+g6fVSjzmUzxDKiqQg+E3lRBZURH4O9Ipbtjr4MEjmtg3FF72Ot8MMnfSCzSFR
	vkl1nuAlc52VJWo/wLb1Qlb7o7ywDQK4YAUrAzIZ3uDu54znBXGVGoXgylluKnw==
X-Received: by 2002:a05:6512:3fb:b0:511:2f8e:3175 with SMTP id n27-20020a05651203fb00b005112f8e3175mr1735107lfq.29.1706893284518;
        Fri, 02 Feb 2024 09:01:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfRfOgc9ZVV6pHPQSukEf9hpw53bXLI3I+jZpl6zCGFHjQor804PFgyUTsDOQuO2QwqfzLSw==
X-Received: by 2002:a05:6512:3fb:b0:511:2f8e:3175 with SMTP id n27-20020a05651203fb00b005112f8e3175mr1735087lfq.29.1706893284156;
        Fri, 02 Feb 2024 09:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX6U++30MnFsmrHL71ehEIfGbdxo1+X+t6XrlnKDOWfKXCaOwtWDpclJIeOfBtVzI/LCmVOaK+hNXB3Cxck6Es6pe7HKm5IC+iXE3vtmuH3j7QA2ZABe7FSGcvkQxwy8ZAnJI1pJ9ksSM1VlFysdabKLYb272GnGORcMgtg5dDJD1zJVhnowmLW6XnZ5DZLHxkgU7wpgzM5PojIj0PcVUdIxOyjYnD6fWgRhwLm4hpb7HUM23dMMAsOLtI3ymKcQoBYq8bMQoV1YnhprGJmszUGNTBkLCrOnVK0l/vNhVl1naOCHLews2Iyg/5+3dEBeCNkgDwuN4669rtm2Vo9hSz4qN4HLt25cogAtf9wopxw4QlTRg==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040fc26183e8sm443729wmb.8.2024.02.02.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:01:23 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 kernel-team@meta.com
Subject: Re: [PATCH] sched/fair: Simplify some logic in
 update_sd_pick_busiest()
In-Reply-To: <20240202070216.2238392-1-void@manifault.com>
References: <20240202070216.2238392-1-void@manifault.com>
Date: Fri, 02 Feb 2024 18:01:22 +0100
Message-ID: <xhsmhwmrmhkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/02/24 01:02, David Vernet wrote:
> When comparing the current struct sched_group with the yet-busiest
> domain in update_sd_pick_busiest(), if the two groups have the same
> group type, we're currently doing a bit of unnecessary work for any
> group >= group_misfit_task. We're comparing the two groups, and then
> returning only if false (the group in question is not the busiest).
> Othewise, we break, do an extra unnecessary conditional check that's
> vacuously false for any group type > group_fully_busy, and then always
> return true.
>
> Let's just return directly in the switch statement instead. This doesn't
> change the size of vmlinux with llvm 17 (not surprising given that all
> of this is inlined in load_balance()), but it does shrink load_balance()
> by 88 bytes on x86. Given that it also improves readability, this seems
> worth doing.
>
> As a bonus, remove an unnecessary goto in update_sd_lb_stats().
>

Given that's a different scope than what the rest of the patch touches, I'd
rather see this as a separate patch.

Other than that:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>


