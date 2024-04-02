Return-Path: <linux-kernel+bounces-128671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634D895DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0270F283D20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769815B556;
	Tue,  2 Apr 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NlR0z7oH"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27015ADB1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090481; cv=none; b=QPCxaEykN1iSeHyvPGuPx2dxcZjKr9c0vUO2YPBmvE5jRTA8VRADQMVxEqZYn7P8t4AiGg02Luarlx23pDVhondWouAtKn2auHz3lUtwK3hFkCzgMaQLlph2ptgowYwtM3GhMZL0o5SEIt8M/FMvOMxCbRb6ITNZpND1/Udasfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090481; c=relaxed/simple;
	bh=HWzEiqBuHaYZ2Kx2tIo/D4Y6kZ6jM/wJf3n0FgK2h7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS5OUtdtAEV+uibXCqhD9IqUpd4zyHmK4q2jSEUulAMpAeYffH9XULOvq26ETsOBBjMqo3LDj6ZEnMvpLVm5TnHjRsfA25mT6ogqsBy/BUghdemYa5KexgvVk+5BXQ0TxyUUUn60k7jwBy+YiON0NOCnZ2TFMOkBoWA5JTRZL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NlR0z7oH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0CAAB3F682
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712090472;
	bh=CGkMB7imTwkGu5/eCOYqKNUHQM5FWRQ0y2vNVXy+Bfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=NlR0z7oHcDPSPCV7lM6Pt53mr4A3FIBAgE+25FR/D4/13e/oo6fa4EpyE6JM9Vq5Y
	 eLOPcOJfR6Fxtjpl4CjQ1KvwoWzD4NJHxfqro3vcoBrTRJwxuIfWvzKRzf46mbZz2R
	 OSVOIwuy2dnrkVk6YCsi7t8EKONN2q04rRgW9QtvNd4KBkWg5NlFIWEyp0Hyqugsfr
	 yOyfMkdgV9CZakaxpcq9Dunq6VAUlkDIZTYV+WtxwFdVpSfheVGsODA6sVSeP/WnkX
	 STLyf1jfBBh/kVcvti4VeFM2MOLF0qda7EPkX+4bW5GcXy9OeBh4eXfpXZCeBWabSk
	 NwD3sW5FSJQ9A==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4751d1e7a2so209369166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090471; x=1712695271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGkMB7imTwkGu5/eCOYqKNUHQM5FWRQ0y2vNVXy+Bfc=;
        b=P7ougk5dCBLPjOxDStEQRP9OGvnCCU3EqlBzu92zDa4yvLYoywu9gBQVNobYA9Fa/3
         TZuTd/bWmMHdY2oXwzSor92W5PjH3hfK7uOIww2IKhCs2UC8lQ9p3j4mtnremwzQraU3
         zZ5M2hmiDvngVl59N9kFwiWzxReyJuhp7SlgQzrGzmvNomEPtElktcseIcgZ1haGS97q
         UQMm5UWQYvYh/GFSADXSA+IL3Y382I02CkVi3Xo8RctcqWxUL1B8GDrmg6WiuOnC95mG
         uJ8TX0EexoU7iX+pmGEOEL+OM8ItfCG0Ouk3avnZLKcCm1gsi+tgTd8Zo09v9qp6lUKz
         9Lnw==
X-Forwarded-Encrypted: i=1; AJvYcCU/sGlnSaPkQyzsW7BXaRRmM0pveKMuOULqIxKje0rz8PnyyD6PRtsAEQSVUwLCtIo47Qyd0MGLQOeeDmDiMvdXSZCYev+X0RMpGjaa
X-Gm-Message-State: AOJu0Yx3TU8TGTi0qkXlCuj5AHMZUbLOEDWkSJVCj5F356NKhO7k0aoP
	meGK2LSjPzKvIlTQ7wAL/z/RFPAzRNAo+HUZiCUwLHSGUODLCxbzbcQim+n4YAXU/P4ddJQYG4m
	bDEfQSvD4E5xiWeBBZfb4gOHnWPOFcaYwtsjjIQTQihIlX1EsxFsbWWTyI1ImiQvJT8mseKtYGd
	C03g==
X-Received: by 2002:a17:906:e203:b0:a46:22a3:479f with SMTP id gf3-20020a170906e20300b00a4622a3479fmr10516950ejb.21.1712090471603;
        Tue, 02 Apr 2024 13:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwazTnWb26fCC8OgOWgbFx8/0qWiEQkvDFj7yoQDRDAlOAX8koYzmXeu5UnVOTOyeF5Y39g==
X-Received: by 2002:a17:906:e203:b0:a46:22a3:479f with SMTP id gf3-20020a170906e20300b00a4622a3479fmr10516925ejb.21.1712090470909;
        Tue, 02 Apr 2024 13:41:10 -0700 (PDT)
Received: from localhost (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id wt9-20020a170906ee8900b00a4e76e922a3sm2145674ejb.218.2024.04.02.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:41:10 -0700 (PDT)
Date: Tue, 2 Apr 2024 22:41:09 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] libbpf: Add ring__consume_max /
 ring_buffer__consume_max
Message-ID: <ZgxtZSFKddlMz3s6@gpd>
References: <20240401073159.16668-1-andrea.righi@canonical.com>
 <20240401073159.16668-3-andrea.righi@canonical.com>
 <CAEf4BzYuMxF6JDi4gG+cfikXqrOsBqiZRw8Ur4K5=YwQKAqKXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYuMxF6JDi4gG+cfikXqrOsBqiZRw8Ur4K5=YwQKAqKXg@mail.gmail.com>

On Tue, Apr 02, 2024 at 11:04:39AM -0700, Andrii Nakryiko wrote:
..
> > + * negative number if any of the callbacks return an error.
> > + */
> > +LIBBPF_API int ring__consume_max(struct ring *r, size_t max_items);
> 
> I'm bikeshedding here, of course, but I prefer `ring__consume_n` and
> max_items -> n.

I actually like "_n" more than "_max" (same with max_items -> n).

I'll change this (with all the other suggestions) and will send a new
version.

Thanks for the review!
-Andrea

