Return-Path: <linux-kernel+bounces-11887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0481ECF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76211F22E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34085691;
	Wed, 27 Dec 2023 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1rlpsnB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0053A2;
	Wed, 27 Dec 2023 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2335d81693so857181666b.0;
        Tue, 26 Dec 2023 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703662526; x=1704267326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UYQSwvKxxRuI6wQnIJeD5vxy+cXOX0sulkh4qGv7iM=;
        b=k1rlpsnByx+/yk8UblQ17Ypwr81rqCu9/NTLoIuDDqph20DADPCsTKldPSKhPDTegM
         GHSzYVkVDjL1nkxfKz+h7LLMKK6YR6bl0B+oYgleLONLBDb8vBSyxOgTCBPpA8PHDpxb
         AUuFvkdRzu38nAD65n02sHvghOMe3fuccA+9uOI4Eg6bveMedpfW8ZAywlrcfjNXjEf/
         qTEYGKUwuPBKFNlzfHChsU7hYVkxC+Np49elu3tLOGtUXP82WQXzHfPrjosX/ZlWfMgv
         c0sobX/kE5ZeZnoVMcUrIgffuylcbEayLHqK1EhkMm6NRePtyTGuK1O2mW7vbTQJay/y
         X1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703662526; x=1704267326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UYQSwvKxxRuI6wQnIJeD5vxy+cXOX0sulkh4qGv7iM=;
        b=Dowh+sqGuoMPrEpaibKFaskFI97GWQZnQ94RBzkrr0W1qpJzY5X52dJHzLVNrT+BNY
         SRxtor5nWK5qnbsQ7Q0N4bTnj6GSVlEnaxcskdErwhheCrARYHVYUhxgKErjSEFopkb1
         E6v8NRu2lEeL3+m6oqBru36aSOl73evodmISpjBEfPWYElVuF2z9fDT+qoQ4Zgwdb4PR
         iA/CX2ohi6AaUfHgBOPi3QeSGLWti5f0FyLTFHUHQezhzkZ9J+rO0Ty5Y/HFU9i+Zfxv
         4g64LYpuci429ZmLaCmno7QuWjydDxHddcuqlKHumedIQyyS2ocMw2ARt8Z39DvKvciN
         IMWQ==
X-Gm-Message-State: AOJu0YwPab8Gnpt4KPhTK2EObhLNgrV1Fh3l+WwtR8+jTm5yT7jZgq3I
	ahW+LBG6KrrY/yIXkEaxhNI=
X-Google-Smtp-Source: AGHT+IEeObw8r7L0iOJ3qTIsb/nxDzbk6z9WgafKZ4nqQ8EIiOZAVsxilu3myX32DCk8MBpn/7UMfw==
X-Received: by 2002:a17:906:115b:b0:a1b:7700:2c0b with SMTP id i27-20020a170906115b00b00a1b77002c0bmr7885891eja.19.1703662525510;
        Tue, 26 Dec 2023 23:35:25 -0800 (PST)
Received: from krava (37-188-147-249.red.o2.cz. [37.188.147.249])
        by smtp.gmail.com with ESMTPSA id vl21-20020a17090730d500b00a235a62516asm6285729ejb.57.2023.12.26.23.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 23:35:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Dec 2023 08:34:57 +0100
To: Edward Adam Davis <eadavis@qq.com>, Mark Rutland <mark.rutland@arm.com>
Cc: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [PATCH] perf: fix WARNING in perf_event_open
Message-ID: <ZYvTC90lyZdwJ8bB@krava>
References: <0000000000005b23dc060d58ee7a@google.com>
 <tencent_7FC26D7C2FA56EF89584E89EEE52CD20790A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7FC26D7C2FA56EF89584E89EEE52CD20790A@qq.com>

On Tue, Dec 26, 2023 at 03:25:15PM +0800, Edward Adam Davis wrote:
> The new version of __perf_event_read_size() only has a read action and does not
> require a mutex, so the mutex assertion in the original loop is removed.
> 
> Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")
> Reported-and-tested-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

hi,
Mark suggested another fix earlier [1], but I haven't seen the formal patch yet

jirka


[1] https://lore.kernel.org/linux-perf-users/ZXwubNIxKH9s7DWt@FVFF77S0Q05N/

> ---
>  kernel/events/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9efd0d7775e7..e71e61b46416 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1924,6 +1924,10 @@ static void perf_event__id_header_size(struct perf_event *event)
>  	event->id_header_size = size;
>  }
>  
> +#define read_for_each_sibling_event(sibling, event)		\
> +	if ((event)->group_leader == (event))			\
> +		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
> +
>  /*
>   * Check that adding an event to the group does not result in anybody
>   * overflowing the 64k event limit imposed by the output buffer.
> @@ -1957,7 +1961,7 @@ static bool perf_event_validate_size(struct perf_event *event)
>  	if (event == group_leader)
>  		return true;
>  
> -	for_each_sibling_event(sibling, group_leader) {
> +	read_for_each_sibling_event(sibling, group_leader) {
>  		if (__perf_event_read_size(sibling->attr.read_format,
>  					   group_leader->nr_siblings + 1) > 16*1024)
>  			return false;
> -- 
> 2.43.0
> 

