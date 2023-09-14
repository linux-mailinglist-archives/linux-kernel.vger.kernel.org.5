Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2B7A0AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjINQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:30:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B01FCE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:30:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bc02af5dcso17005537b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694708999; x=1695313799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQCQk6YHT4w1SIaBM4T9wkvVdHTFYqU+yaXty3zQMig=;
        b=IiH9liIRKJ97IxiSPDF9vPtG2AX4Abn0cKh/6I5+hxw88P0pOY8r7oq+W+P0ivR1Fu
         ihqlkVQSMb3YIg/z7y29uw8a0b0NOLXS2jNBnXIDjxtjxl3zax5T2cp1kmt5Wh1/DJVk
         KOGEKS4O/kqJqVa9uFSmcgn1KFdLVUSDlQmL/kxVF+SuxBl3gBFbr7tYxkqyH8d1g74N
         weLTPOPvnHFMMDgS9hRwNs9KuduVC7HUXGiALe8y4nromLIyeMlK1smi1KUNZMHk3bde
         HEccdISO0eXpLfibz4q01OWc4d91JEc+ujFh4Cu0qKfJxHCibktz2Fgqw4apgshALO7C
         Wm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708999; x=1695313799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQCQk6YHT4w1SIaBM4T9wkvVdHTFYqU+yaXty3zQMig=;
        b=hysNX+khj4L0sT+XDH+BzMct7OK4tjGMiBmc0Hn7x6FnMhVokyPcU6502enqTY0okG
         wL5dyFk8EDtcR+MZNfDuuJLsJzvDkRaA0Q4A6V3VlIZwOD5YrRTYm/xFPpcdciVWyZJ9
         XnEgVpJwbFmW93YmwlAZ53P8gQh2hWgKKClLJpWqEO8eB/mX0wva7OaN2aITfAi5yrO/
         WlrDwtqkPVcwJsJoYp/y2n79rrm2Q6d6crvH/RkCPwWPmP9v2+/bX8SBemG8Rx/kkNOa
         KNB9my19nfqTWjHktMaECIvGTXN7r0f1m1v3aBzOdfswCJFgvn/GcmuAou6+PIzpLA7n
         MoDg==
X-Gm-Message-State: AOJu0YxE5qB6KF8C31vz5x94cNMg1Mx4TjQtqv1tu+W5sMCiCPN0CKQn
        mVu0PPhdSoaKRblW7YaEkIsa56I=
X-Google-Smtp-Source: AGHT+IGLCdlQ6DhH2Nk720lughqWhXXVD4XHhWXzQhzNhM9o8Wnl99nkGz1gI3OlF0PdydA1el2ozHw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:b56:0:b0:d7f:8e0a:4b3f with SMTP id
 83-20020a250b56000000b00d7f8e0a4b3fmr129121ybl.3.1694708999121; Thu, 14 Sep
 2023 09:29:59 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:29:57 -0700
In-Reply-To: <20230914083716.57443-1-larysa.zaremba@intel.com>
Mime-Version: 1.0
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
Message-ID: <ZQM1BUzcZQtXusA3@google.com>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags together
From:   Stanislav Fomichev <sdf@google.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14, Larysa Zaremba wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags conditions.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  kernel/bpf/offload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index ee35f33a96d1..43aded96c79b 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
>  	    attr->prog_type != BPF_PROG_TYPE_XDP)
>  		return -EINVAL;
>  
> -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> +		return -EINVAL;
> +

[..]

> +	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> +	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
>  		return -EINVAL;

Any reason we have 'attr->prog_flags & BPF_F_XDP_HAS_FRAGS' part here?
Seems like doing '!(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)' should
be enough, right? We only want to bail out here when BPF_F_XDP_DEV_BOUND_ONLY
is not set and we don't really care whether BPF_F_XDP_HAS_FRAGS is set
or not at this point.
