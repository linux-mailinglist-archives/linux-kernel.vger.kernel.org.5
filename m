Return-Path: <linux-kernel+bounces-50251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89D847662
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB15E1F2A6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF714D447;
	Fri,  2 Feb 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfXshpme"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5A14E2D4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895628; cv=none; b=Q25nPc0YxVC3WYX2mQAvZwZ+z3a2KcnPLPkfVPlBQrKlg4fIF0fpXXZMc1W+92CkuQ3aTZTOxkUsIb1l3kJw3hGyfMQa8Ag7Ehj859ppiANTf+zFjLvQduhjsuszr4vSMXef0y+pTEQGfZHhLrAJxB4xEuGz3vgJpH/uguEJc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895628; c=relaxed/simple;
	bh=BOiRCiODsdZC7Mu+DfUwlCyXYubllseXBa2Nka04gEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMkx0JGbK6ozNO/1Ai8uOZ1o0U6VZhKfJVVMJFElwBr9nqxvF1LMJ/UsTcZUzUrO8IsYRI8hH19u0RsLgWI12PlK+ZwosbNE+/H52WBS6XWAGIPUTylqFh4olHSj3ChVkzFZBzofbm8brCMY/vm19oCoWz0VeBA5yUdGUWHu46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfXshpme; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706895625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uK//x0luqoWMvS8Z09aeMcer4hSE71ZysmanTsbvBo=;
	b=DfXshpmeRwxTYBv5DcZyEd6n7L74fOxCZ16fI03H7+TdmVgddlyoAqwPaKYHm0fF0Mhna8
	WtHcqZgF0WO7ZtD5pjeJa2F5I2AQ+60y18NGBen35AKRzUsaDhFzY1O0yq/ZrAvcymzkH/
	/G2/cJfK81T8k4V9zrcVj1+Ie283O2M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-0K6aCIxsNFuFTHC-RadW8g-1; Fri, 02 Feb 2024 12:40:23 -0500
X-MC-Unique: 0K6aCIxsNFuFTHC-RadW8g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ae2cfa4c0so923612f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895622; x=1707500422;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uK//x0luqoWMvS8Z09aeMcer4hSE71ZysmanTsbvBo=;
        b=FxXESRazZLEjAuSqOIc5eUewbDQCY5Rc8fjRefVdsM7QGYTHRTngVTjHZMognHqNkY
         U5RrzwnavyFxTQ5xi5iw42MKO8AzuTP2zerYS1x8xVDZxmG5htSqvAvfVAcJLKy9nako
         5/zStluDCvpmVmP0FgouKkhY5Lzfi2NtoJ/IqFwgsK55m+MRMsnlojvELyq1AP++Mpnx
         ISvSVxvlOdt9UB+5SsHb6NVUk9tlXKegOEkJSId0pMDWclfmcrF3YUNu8KJ9pCNj8uum
         g8A8fYD1K4VIcdgWC+qQSzLTnKBzX6PplXYzgXSwp/7qeE27XOtlN1CwBUz1oiEsIUjX
         5kgA==
X-Gm-Message-State: AOJu0YzTafQjbGtjoHkhmvYAcaYksBPV/FWU3I0uCdofgFwv7lnHZsPa
	pDw7VTr2RjElXp6PcY6KmZgZdXYacHY6QggrR0ISaVnyZ27dobAYeVEqdYxjIBTaalLmOsFXj4j
	Sl4QQs/0g8/MJs7NZz63kP9lo6uLJjXHh4GQDJZBqIYQVsqlD6+t0nUR0Co/0wA==
X-Received: by 2002:a5d:4390:0:b0:337:c454:81a8 with SMTP id i16-20020a5d4390000000b00337c45481a8mr1754233wrq.55.1706895622621;
        Fri, 02 Feb 2024 09:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmdXc+jNyJXy3O9tNfrg+i+QMmkbhZq/CcDwIvvm7pW40AlB3qIPHUMZU/JM7QJm1W/ikngw==
X-Received: by 2002:a5d:4390:0:b0:337:c454:81a8 with SMTP id i16-20020a5d4390000000b00337c45481a8mr1754220wrq.55.1706895622229;
        Fri, 02 Feb 2024 09:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAy6ie/I8NdAC0FEJNUwQw7Mgkds5YZnZirQ81+wr/v6i/+/6OrFVch2DRDVyVqzAKUHk0gzXpU9xqUIHPgnDvSK7wTB3Mbl4NvM3QgIWOwhRfAELlHDpPTOzzoCWE7cMAtXffh0DaTB8XY0Rw0kLFOecel//4Avk5gIvH1npeIJAAkUlKg6M/ALR79zDI0Bhp4HfkrUhXcn8TVtOCE4nFpV3LIzgQ2qI5rBTajVqHdLEK7pO7VPD0d0nZtfQPR2zFO+TyXZ+tVEdE/FV63KRnxcoZR1+jTPd8doRUQK6OpDcjAlLtcfo6An1WdDfGBXkHKB3GKq4lNwkXAEMu1LUGBkkKE3vMVw==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y18-20020adfe6d2000000b0033af81d6dc8sm2386439wrm.87.2024.02.02.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:40:21 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH] sched/fair: Simplify some logic in
 update_sd_pick_busiest()
In-Reply-To: <20240202170712.GC2238525@maniforge>
References: <20240202070216.2238392-1-void@manifault.com>
 <xhsmhwmrmhkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240202170712.GC2238525@maniforge>
Date: Fri, 02 Feb 2024 18:40:21 +0100
Message-ID: <xhsmhplxehiii.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/02/24 11:07, David Vernet wrote:
> On Fri, Feb 02, 2024 at 06:01:22PM +0100, Valentin Schneider wrote:
>> On 02/02/24 01:02, David Vernet wrote:
>> > When comparing the current struct sched_group with the yet-busiest
>> > domain in update_sd_pick_busiest(), if the two groups have the same
>> > group type, we're currently doing a bit of unnecessary work for any
>> > group >= group_misfit_task. We're comparing the two groups, and then
>> > returning only if false (the group in question is not the busiest).
>> > Othewise, we break, do an extra unnecessary conditional check that's
>> > vacuously false for any group type > group_fully_busy, and then always
>> > return true.
>> >
>> > Let's just return directly in the switch statement instead. This doesn't
>> > change the size of vmlinux with llvm 17 (not surprising given that all
>> > of this is inlined in load_balance()), but it does shrink load_balance()
>> > by 88 bytes on x86. Given that it also improves readability, this seems
>> > worth doing.
>> >
>> > As a bonus, remove an unnecessary goto in update_sd_lb_stats().
>> >
>>
>> Given that's a different scope than what the rest of the patch touches, I'd
>> rather see this as a separate patch.
>>
>> Other than that:
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>
> Thanks, would you like me to send a follow-on series split into two with
> your tag on both? Or were you just letting me know for next time?
>

Well, I'm not picking up any patches, just reviewing them :) So yes I'd say
re-send with the split and feel free to apply the tag on both.

> We could also update this check to only do a strict greater than to
> avoid unnecessary writes, but I figured it was preferable to have no
> logical changes for this iteration:
>
> return sgs->group_misfit_task_load >= busiest->group_misfit_task_load;

That's a good point, I don't think there was a specific reason for going
with a lower-than rather than a lower-or-equal back then:
  cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")


