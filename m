Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23CF7CB504
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjJPVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:04:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43855A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:04:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405459d9a96so8105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697490282; x=1698095082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2HoL3h5D1fsP53Du9yOoTclZQj1sU4/TX9UV/0uiM=;
        b=EBjzy5K9zEVybireG+puBsS0HVjlviTV8Uo7gpSwlFKT6VMQZKmMHlroae8P4y0EEP
         n2agOrOiz2KH5Iain92YxG9TxmqmLEo5Lt9jmeBB26lwIGtIPfBDk07vInZ81py/zDX5
         6CynVNafVBfZt32SE8WsXavsP2ldzALWxOJnvmePk3uriARGCeXZj4q9VXuT7MyMshS3
         dVcNS1bVL3cMO/0nj1+9xs4f87/ORO+ErQs6plZKMgyKQ+I3DtdOFbUr8eOxWbL9xR55
         Z0k4RltY7GvtpqS+ItR3sSVMRSDO0H0YA6ZL57OM1QCTtIFBT7L50wLxLia1Pd8cbKiS
         cDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490282; x=1698095082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ2HoL3h5D1fsP53Du9yOoTclZQj1sU4/TX9UV/0uiM=;
        b=BkqE/RxqUlhjKU6WzvIHs42zHx3yYETisTfC64uiJLHgkOEzzhpmGMHXKtH3oD0vBM
         8OgdNk0jIk+xvn1yW6fkjWdmpEogoShimmMGIJCHDETWeCmd/SOCIsAdFrW6K+j5wdZ+
         1Tb///l1L6wOJovKz1IKcmBMCQKRecq4YDRjAKl0SiLdU8O35i3tzkg7Vsa1vRrxYelM
         M62hZ9+SBjcXL8lsI7oH+Eb4f50IKxoAcNNwFpd7eckCW0eNXd7NEDK/dudF05hYMDZH
         ITRzRA4xHEqBgdQDmhcMidRwFCnFfmvT4C6R7OTd5pP6ZSVOZILENKMR+VFZPBE28SXI
         xFpw==
X-Gm-Message-State: AOJu0Yw8BhOUBjBmfUAZxzic2bCFzO6ygMpCSRLakGi/7Uv7Eja19zSE
        v6OK3554WUz+7uq25coIAGzLxa4WAHEaQ/8l1FL+wg==
X-Google-Smtp-Source: AGHT+IEBxQ/b6PbtK2nIbjqx4pGQocOWRqq0DEFmL/qxeQmkxd35BDeJvXUnlduXXhQtlBJccIr9+Xd3OAiFo+k5lzE=
X-Received: by 2002:a05:600c:35c9:b0:400:46db:1bf2 with SMTP id
 r9-20020a05600c35c900b0040046db1bf2mr40379wmq.2.1697490282514; Mon, 16 Oct
 2023 14:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231016093309.726436-1-yangjihong1@huawei.com>
In-Reply-To: <20231016093309.726436-1-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 Oct 2023 14:04:30 -0700
Message-ID: <CAP-5=fXwAbaqqYVE_9y6JbkQ8rkU-f38ZB0gbpZdg10HLtyYzQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Filter out search events table of software pmu
 in perf_pmu__lookup()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 2:35=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> For software pmu, the events_table is empty, reducing unnecessary search.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

I'd rather that all PMUs behaved in the same manner without ifs that
will catch people/me out later on. perf_pmu__is_software tells whether
the kernel context is software and therefore whether events can be
grouped with a hardware event. As a test for whether json exists or
not I'd rather stick to values derived from the json.

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6428e2648289..59c8394a4efa 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1033,7 +1033,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head =
*pmus, int dirfd, const char
>                 pmu->id =3D pmu_id(name);
>         pmu->max_precise =3D pmu_max_precise(dirfd, pmu);
>         pmu->alias_name =3D pmu_find_alias_name(pmu, dirfd);
> -       pmu->events_table =3D perf_pmu__find_events_table(pmu);
> +       if (!perf_pmu__is_software(pmu))
> +               pmu->events_table =3D perf_pmu__find_events_table(pmu);
>         pmu_add_sys_aliases(pmu);
>         list_add_tail(&pmu->list, pmus);
>
> --
> 2.34.1
>
