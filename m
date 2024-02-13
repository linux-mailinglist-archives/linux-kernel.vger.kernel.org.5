Return-Path: <linux-kernel+bounces-63139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990A852B89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4643628191F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B521340;
	Tue, 13 Feb 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4wFIL1h"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD85210E4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813926; cv=none; b=EhYtAc2uD3M9BGRjARbTT3WcFk6LhilC0zEGVkjGVZ8z/HVLX3fKlS+7hrVVoFsR7XQn20VrCQ0UiJsXtgQ7EWs8mOp4wR3a0toi0vGUPufr2E3JAB8P2mx/DALWLW7ogqNlOzDKDjjnPhqi91jC6/xr9VNEDKVvNYz+W79w/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813926; c=relaxed/simple;
	bh=KFSUYnTjoK8elYUEi/M0L4hG4XetQ6moF8roQFN4HLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azIjIeCxPfXdLtaZdpPdgxD+J+tXOeADgMmNRAJxzmQqKfKq+D/Ri+ynjRwVtIi8Jc56OXNTuWML3H+XXUN4kb6N6IIH1OOgN4qBYSXm16rbmKy4Y/0iiCT/z5RQYFkVIGNIoxAHptTs/Pv/IytgwlkR/jUYdqts/LKjAbmi99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4wFIL1h; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so1723300241.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707813924; x=1708418724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wGR9OBfIIG2a8T/GmrMex7SON3QGw3gSmsFfveRlgeI=;
        b=G4wFIL1hBOTItIzmfEqu8NlVSaLJROJRfEJZ6mt2BmUqLZNREvhu3PI0nSDB1myMhi
         didqPKLnU8Qh06CWoi+7HKYK2EE3ejCiZE3zlzwRX5RrcxP1o+qI+e8HIsWIji/1tRTM
         nEpv4K0Zuv90/frB13xwSUA1cWvuG3F1koUvMXleEbPus+VQor49Y5emOylqbVs2AR9Y
         UuLX+pXScWvVVNp78n21yWvhdYVFDiB/lGmO8oQ7amaFR/Jm/ryXCms3zwsE2C15BzU3
         GkrlTkL1uZDEmyb/1u+7KlXKj3zzRihYYD+C3+N1/ztlnbKYGdzvIcwF7c7pzDClqfqy
         bfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813924; x=1708418724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGR9OBfIIG2a8T/GmrMex7SON3QGw3gSmsFfveRlgeI=;
        b=jJV0W8bVSeCG1sXSeVfRJzAwIdQVz8ZZQNiN2lnGz3rLtq/7hyou4NfCWfht76nFn9
         EOV2TCvd4f/cYO8/fVu295M9DLWb0LoAxGbg2KrUf0Fc17wXqPlqBxZEitSpajDaqXTz
         Gw/qy9IohRXa3TdF6z8Om/jzkZDNnBXBcsKMETEe9026oQFN+JUBIOZr7jYNtV17Jyd8
         y9xrmW4NwzTtBQR4SKkZxRPG+d79qnOrG55onNU49I1y8QWimy6goIi6r0KkJx/QbSsW
         htymWQVMsxJdfHg+I2tRx/HrZyrqD85z/dO6CWdT+Lm1Ps8l7GCxvSiFp3Ut+7AHTnxm
         y5uw==
X-Gm-Message-State: AOJu0YwhZJd0DmmDHyzRW35uTNcYAih5yW9syGHepwm7cLBbDaihDNk6
	Y8zldTMLZjFdduUrupoYC4qNY7n4VhVKjJ7icdcCxthINJjWsokUMsKlbTBhC96hhqTP4wSJw0f
	A0Jqw7hK7yhJfWF/XMzx4OreJtF1ZkAVMTqmD
X-Google-Smtp-Source: AGHT+IEl5yTIowUWT5iJgjYofd4P5Cqk9B+eF8LLlTMxGGeh/sNYGRU0dxumWxivjACwgNftZZwLQpR/s8FK7RDQYng=
X-Received: by 2002:a05:6102:2856:b0:46d:6dec:16d4 with SMTP id
 az22-20020a056102285600b0046d6dec16d4mr4107850vsb.32.1707813923585; Tue, 13
 Feb 2024 00:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-5-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-5-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:44:47 +0100
Message-ID: <CANpmjNNWv1eDL5MQXtdXnsV=sCp_8MC11xBAgsNt_1K-V30H8Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] mm,page_owner: Filter out stacks by a threshold
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
>
> We want to be able to filter out the stacks based on a threshold we can
> can tune.
> By writing to 'set_threshold' file, we can adjust the threshold value.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_owner.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 3e4b7cd7c8f8..c4f9e5506e93 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -832,15 +832,18 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
>         return stack;
>  }
>
> +static unsigned long page_owner_stack_threshold;
> +
>  static int stack_print(struct seq_file *m, void *v)
>  {
>         char *buf;
>         int ret = 0;
>         struct stack *stack = v;
>         struct stack_record *stack_record = stack->stack_record;
> +       int stack_count = refcount_read(&stack_record->count);
>
>         if (!stack_record->size || stack_record->size < 0 ||
> -           refcount_read(&stack_record->count) < 2)
> +           stack_count < 2 || stack_count < page_owner_stack_threshold)
>                 return 0;
>
>         buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> @@ -851,7 +854,7 @@ static int stack_print(struct seq_file *m, void *v)
>                 goto out;
>
>         scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
> -                 refcount_read(&stack_record->count));
> +                 stack_count);
>
>         seq_printf(m, buf);
>         seq_puts(m, "\n\n");
> @@ -884,6 +887,21 @@ static const struct file_operations page_owner_stack_operations = {
>         .release        = seq_release,
>  };
>
> +static int page_owner_threshold_get(void *data, u64 *val)
> +{
> +       *val = page_owner_stack_threshold;
> +       return 0;
> +}
> +
> +static int page_owner_threshold_set(void *data, u64 val)
> +{
> +       page_owner_stack_threshold = val;
> +       return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
> +                       &page_owner_threshold_set, "%llu");
> +
>  static int __init pageowner_init(void)
>  {
>         struct dentry *dir;
> @@ -898,6 +916,8 @@ static int __init pageowner_init(void)
>         dir = debugfs_create_dir("page_owner_stacks", NULL);
>         debugfs_create_file("show_stacks", 0400, dir, NULL,
>                             &page_owner_stack_operations);
> +       debugfs_create_file("set_threshold", 0600, dir, NULL,
> +                           &proc_page_owner_threshold);

Can't you also read from "set_threshold", so the name "set_threshold"
is misleading. Why not just "threshold"?

