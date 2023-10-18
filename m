Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797B7CE2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJRQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:29:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F659FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:29:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-419b53acc11so299391cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697646541; x=1698251341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP8epScHrNgHZ84MxLEjBdBvtFkaSpGQFw1IMN4MPNo=;
        b=EwJsb7Mj9rMz7vi3ocLoJpYksd2wJNBPiYfTs5tTcoBvo6bRv9mg3Sdj1cDlXsPjTE
         Ic5LsgN19EvEThygVh2DRBgKgY4TTcJsFxeyAB0C5XP2JSsO5EH3R327EWLddCaJGVwu
         /v0yaw3ub/VJ9N5qf6ed1ZlAiPvgG9+7Rb/H4enMvJhkAR059tDdPoZenOJcpC2avBlP
         1/NK80j3ySdsGtUneqBRM9gr6cERg3q0P2Zq4YRXhFgpKBUdFBJPZdxdnli0/C6WvqHs
         WPtXa4GEP2IdiWLRPuYHMaLFLyrJf3fauw95Jofzt/CNG7MFbXmxa0cO4lImO6KITLUb
         XmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646541; x=1698251341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP8epScHrNgHZ84MxLEjBdBvtFkaSpGQFw1IMN4MPNo=;
        b=fwZpFRAKTzl5T4GpybUVq53lqVcqAzdn0p9413d4ouol7Fi3bGdvi9yrcTQiFlaKWr
         05iQQ4hAOuotrtCOCMVeOUNkV0cRO9u0u0fhsSibNcXim5leSzdq2W/5Rb7GQFwt2hTq
         WqW/HRiVQqLxQZxl1zaMRCmq0cDXy3KBrF8zviobycgp4I7UpAhTXVhGdgv7+hsGU39+
         Uu8vzDS0SBt17pnTxfE6B5e7lWTvcWX6rHVGGeKv3R0gk6tFLx39FOfYp3EA7C2R8VZc
         LZxgMmNCtBtP4s7LiXwGmBZA6sDnNW9zC4SaewONMJJa5GWfSbq8QhEop3gyYlOxM8mp
         FGPA==
X-Gm-Message-State: AOJu0YzlnsV+OM+NpgLVih7+oys7Rg0hh4BA1g0buWSEwaVoJ12V7uz7
        BmaR1TkOSoi0gMzkcE8R2Db3J0wH/K0ENeBIX31/ZA==
X-Google-Smtp-Source: AGHT+IEjZdE64AlO/kPu6yekVca1LeSJ4143bYX+rUPzxbvwQZgKxFi7LC3iGp1nmFLzzNVPtiFHfVLV7D6UhUO4iQY=
X-Received: by 2002:a05:622a:4713:b0:404:8218:83da with SMTP id
 dn19-20020a05622a471300b00404821883damr251529qtb.1.1697646541251; Wed, 18 Oct
 2023 09:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231018082104.3918770-1-link@vivo.com> <20231018082104.3918770-2-link@vivo.com>
In-Reply-To: <20231018082104.3918770-2-link@vivo.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 18 Oct 2023 10:28:25 -0600
Message-ID: <CAOUHufbc9j-6yfcm_4h_qD5L1oq6KRVXxA1u+mx0dXBqtghjYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: mm: multigen-lru: fix mglru trace
To:     Huan Yang <link@vivo.com>, Jaewon Kim <jaewon31.kim@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, opensource.kernel@vivo.com
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

On Wed, Oct 18, 2023 at 2:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
> This patch add two reclaim stat:
> nr_promote: nr_pages shrink before promote by folio_update_gen.
> nr_demote: nr_pages NUMA demotion passed.

The above isn't specific to MLGRU, so they should be in a separate patchset=
.

> And then, use correct nr_scanned which evict_folios passed into
> trace_mm_vmscan_lru_shrink_inactive.
>
> Mistake info like this:
> ```
> kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
> nid=3D0 nr_scanned=3D64 nr_reclaimed=3D0 nr_dirty=3D0 nr_writeback=3D0
> nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activate_file=
=3D0
> nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D4
> flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> ```
> Correct info like this:
> ```
>  <...>-9041  [006]    43.738481: mm_vmscan_lru_shrink_inactive:
>  nid=3D0 nr_scanned=3D13 nr_reclaimed=3D0 nr_dirty=3D0 nr_writeback=3D0
>  nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D9 nr_activate_file=
=3D0
>  nr_ref_keep=3D0 nr_unmap_fail=3D0 nr_promote=3D4 nr_demote=3D0 priority=
=3D12
>  flags=3DRECLAIM_WB_ANON|RECLAIM_WB_ASYNC
> ```

Adding Jaewon & Kalesh to take a look.
