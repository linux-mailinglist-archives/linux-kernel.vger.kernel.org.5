Return-Path: <linux-kernel+bounces-92182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85D871C5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1DD1C22A16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D665A7A1;
	Tue,  5 Mar 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVVj5w5L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D25A782
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635854; cv=none; b=ZvjgDgHC9BG1HiwJ1ZBfl/9BJ8Jdku/vaPwfSKXZ+KwzFYf7LWWZxYAHR1ad77xLbtXp5PoRL5d8ERrcFPfZSRXA7DKPUw8fJ/oSizgw9M9vba6PSuYtKcrq+LwxRh3l1rV3q7CT2WAyduPN+XdvCMoxPmnQakjviyb5iV5bBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635854; c=relaxed/simple;
	bh=6eT3H3lAnt6swyHCnxLZf4EE+q5WLWJb+/XpGxARlRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cV6cLyghZMe3epMakjXVw0OBmvkdudAEIWk/YB0fngJIDfRp3X+D1KNveCnsBS13EJ+Joo3wi9BF6X1E3s0nz57YWaj3Jx8BZVyGXbbebV7gtZbt618Kw9HsU2CCrn6XrEZgD3kED9fW8cObWlh0fsnXzgtVP2k9wu++99X7F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVVj5w5L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzrlPqw1hQpGGOHaQBOYMXIg3eWpMn8xvXO6Gu1jV2c=;
	b=GVVj5w5LZSun/aUCl26k6NKDA8IyatynEFsVAEHVbZwSw7t46R6B7tz++Txz26E4iKMPmG
	5HbJUVxCWVB1MZM/1/h4l9lS+jnfaVBBW4Rb86m3nDAp54HHjvU1I3ZnGmUgZx54J2lWkS
	4OhkV4c5zWm5Enf1QbwxdWVgE7KP/5M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-d8KwGIswMyuzl0G0uO7CQA-1; Tue, 05 Mar 2024 05:50:50 -0500
X-MC-Unique: d8KwGIswMyuzl0G0uO7CQA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7882536af06so227332385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635850; x=1710240650;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzrlPqw1hQpGGOHaQBOYMXIg3eWpMn8xvXO6Gu1jV2c=;
        b=S5yVRO/lGHfTZeaGw3BDwHwsbXgMaGP9oK5yEsrPT9jO4MJh+SPkDhSljVt7YC7kcf
         TrcvqSGis+POlK+E5U5llveV9Bj9kqvPqSUfnltg+QwOjhQvuBsBiyL9/soY07TGasCs
         N1k/AtzorWajHsWb/9rnTqiSIL/SkJv4LYZ76pH/jaavRyD+W/hGAMDX3RQ67Sqoaz/4
         bw4Z8L52OxG8bPTYik35Z6dUkPcbSkqyg9v9inB0pcSnr8WnpjNfCy2rzzCg6uEIbwzR
         Nc0fcFo5RU9Jisvgho5hE5F2zWlKIpKrB1tWjSdBzh2PSMuM0BptpIZoCoQKaPLskgQt
         JV3A==
X-Forwarded-Encrypted: i=1; AJvYcCXQQSaL/bNx3AV2E+MHtAOxJu0oYM+EZViotGW80rcqJac+QwJqPR/lZr9Tm4uBwxuYI82HmKwSkZSAAY+hCkkzNLiLjiQljZa6V7J5
X-Gm-Message-State: AOJu0YxLe8aQBj+qzDzbHDTPJ9jsPt/hd/BFfUg8jHiOo6an2+DpSRNu
	tMRsyntjv0ZUkExwvYsMn1XPGtPF1EUUrf7ocdNnnZp7+tiBiSJfDLg9pncZbqtD3d4pt++6sPV
	i+Ezm9xU7VRiSqZ+XwyMqOOL7WjCC2u8d6s/pboUx/VQRu1CTkcbDspXseqGdlA==
X-Received: by 2002:a05:620a:1097:b0:788:2b1c:1e33 with SMTP id g23-20020a05620a109700b007882b1c1e33mr1862707qkk.5.1709635850408;
        Tue, 05 Mar 2024 02:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE99FgdMWK/jVepankQNO9pvPv1LVtQt+s7nmsaJR8uhZULGFulBYoLiBQ6wvdG4xKd1H3Y3g==
X-Received: by 2002:a05:620a:1097:b0:788:2b1c:1e33 with SMTP id g23-20020a05620a109700b007882b1c1e33mr1862696qkk.5.1709635850105;
        Tue, 05 Mar 2024 02:50:50 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id t25-20020a05620a035900b007883184574esm1031069qkm.98.2024.03.05.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:49 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/9] sched/balancing: Fix comments (trying to) refer to
 NOHZ_BALANCE_KICK
In-Reply-To: <20240304094831.3639338-6-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-6-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:47 +0100
Message-ID: <xhsmhcys9dkag.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> Fix two typos:
>
>  - There's no such thing as 'nohz_balancing_kick', the
>    flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.
>
>  - Likewise there's no such thing as a 'pending nohz_balance_kick'
>    either, the NOHZ_BALANCE_KICK flag is all upper-case.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


