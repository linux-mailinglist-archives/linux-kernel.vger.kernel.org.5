Return-Path: <linux-kernel+bounces-63135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E7852B61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EAD2828DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC11AADE;
	Tue, 13 Feb 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cD8RkokM"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F818AEA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813701; cv=none; b=itWLlFKtZgp7/nvBpnjvfVeJ68rbAq9heWkm67ZQq8Dno9SFaMQ3qOlshH3UR+5y1RLcWiuB738GXT2uDFcVpCvjIiEFiBZVK1VWiL4rtS5AbVfGcf/0dQQ4SMyURdaI/ZuuoS6q6KsdznT/5mkG0kHwyoVzNrMLWQgG7mRn/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813701; c=relaxed/simple;
	bh=x0G5S0TCLDELwGPALy+S/ZE3pe45bC/NFvjLIiD7eLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA16M81lEfsi9JpI08IKDRulMDi5pwQ7EZKg2I3Fr/LP2NcjEaBX87eu0F5njSe9Bf6mOT55MyCtLdmZm1hDphuxl/lywM8Nbw5Hy7WC4cEqq3eCpP1gBxxzVxi2O+/ygrD2/5Ae3AVq726VPuL08gUjGWfE2Hedmbt7QsUW2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cD8RkokM; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso1432513241.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707813698; x=1708418498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mbXy4N3HeK13vhMMBdXFJntR7rVjjQU3Uf2gMWB6LA=;
        b=cD8RkokM1PjE1AImM9WJUsRXsUCb5GV+DhzNQVXcQsW+wiaBaYmPuuJozmHzbiHOuz
         Jv+yI7ARIgHLaOYWwT1wRnM61HTRlOurDNARQU5Cn2ksPIjXkspRg+VB5YLDm021IVDN
         oDiQVEl07GAnHQEvnB+p2S4GYiTNKOo6r+QbcvjaFbs5g1Stq/81MW7k+ToEpgpRnJAH
         hBNudq90OhaIsIGuUfqBRk1LN4x0m233/YDEe/AE3gNSZnuP2dg88Hc43BAk01xvZxML
         KuPRTWXE7q6EGrcfailK8bXMZunCBe3GUxFl1P7rfPH52kpmXwduxtJFKfyUXQ4bPYHA
         LXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813698; x=1708418498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mbXy4N3HeK13vhMMBdXFJntR7rVjjQU3Uf2gMWB6LA=;
        b=iTDfKTlHkKu+SKJ3FI4JTsHuM1/DvKs84RnfE6/m7QEchGmi+wTZf0MIW0N1tD8cYm
         UFDzc6TO0c/hGEUg8fAHLXp0f5As/KELfKjQ4e20lKrPYKajFBMEJz20Jqewyyrl8DQ7
         nc15d9CnSioguI7A7BosizqZCCGoTPMdnRvBm0q/8YxcRVF3AXqlTX/Ya1LTuLbnypXR
         3iDRV9VHM4pCN1hk1HVQKnn+yNpIGJRLV2L5MhzBobn8ADjGnEixA8Is3wIILhedQQc9
         7Y4/P1agFgdG2tm9IR0NVi/tICYIgvyy5rWA7QNEyYLDQqwSCD3R9fN4mFDWG/fjqWcf
         qE7g==
X-Gm-Message-State: AOJu0YxeCZ6EapJNKUEm3WVzNh5Im834ivhFfbI9BsheehhOdAtf6NDT
	FNq0QD9gBL6YGIXFG04mJZGXVLTlYR2g8kOJ3j7M5Jy8y1YLznBypJqxxqu3mXqNvt+Jjn0MHWg
	MBQhdABkGNvY9kbtGyWc7h0Q7iVQwklWaGxMI
X-Google-Smtp-Source: AGHT+IGYN+GY+XVnj0Fu47fVRpb1MvtnGgbFxUjfMDXlJ9xY5lfjN8jQZq6RjYZnTS5e5xgmxP8X11U27CJ/ewdslBA=
X-Received: by 2002:a67:f88f:0:b0:46d:606e:6323 with SMTP id
 h15-20020a67f88f000000b0046d606e6323mr6029730vso.2.1707813698162; Tue, 13 Feb
 2024 00:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-5-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-5-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:41:02 +0100
Message-ID: <CANpmjNPHkcjTwKOXca=evmXyAk_HzVc4zgYvPb7+Lu_SS4vjbA@mail.gmail.com>
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

This could be written concurrently, so to avoid data races, you can
use WRITE_ONCE(page_owner_stack_threshold, val) and use
READ_ONCE(page_owner_stack_threshold) where it's read.

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
>
>         return 0;
>  }
> --
> 2.43.0
>

