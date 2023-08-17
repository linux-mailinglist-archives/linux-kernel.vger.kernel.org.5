Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381C77F29E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbjHQI6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349210AbjHQI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1210C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdf4752c3cso22618355ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=DksOOuTp1UVrleiR8CEK0iz/auSb6d/LPavN/30BDmNJ0cdz7LS99xeIxjET/PJ41X
         h81Ebion1q7krwAQiA51IC+KPYAqix6+FMf3GyFu87M3wpXcLnJ/nLO4LuaIACrnECZC
         CQtdKis22ego1txUw9OgYHzv9B7tY+JdrfxRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=gwamYYq1MjBGN/6zm63PbnPrd34k7T12EKu3xdT2/MFjI1AuPtMIhRJNVul6nXVMYO
         jnt1ob7Oru5LyoljlIsKxu26Uwomd/nZBfkBaKzoqktB8Sv9KrZGvs6jzCRIIiLA2gzx
         Jl4wzV+8L1EBGPiQ7fo6tYJs0eCa8P0QJsjz4XTo+w5KeUDPpSZcy2NwFIXR9XQ/JFFq
         J5c645umFEayeDktR9qon01W/3MRip33pXpf0Leq2o7bTVBP7s1tmryNJUTyX2/LHIlr
         8oA1e+g2VWiF7K2mHNnPD1m0ZIzJkjQdJYZK8BmGxObORBHOaKnpGk9CB1GUvJSFAFIh
         fpAA==
X-Gm-Message-State: AOJu0YyZQiU0GabVexUFq/KBwHZDrJK589fqk3ASbw3mpd7hLmwXUrR5
        Qc/7bX+LJsZ9oAoM7kT+HVLRuNdLY3fh+yPuNPZ2Pg==
X-Google-Smtp-Source: AGHT+IHPdZNMxsM5+V5vX1EyN/E9ZUkGEZfEzPzHjovvpTHCp44OCZVb5aKpzX0DMTkIEr47E1RrBt56OImd/BKdS3c=
X-Received: by 2002:a17:90b:4391:b0:268:c7fc:b771 with SMTP id
 in17-20020a17090b439100b00268c7fcb771mr3404103pjb.14.1692262688334; Thu, 17
 Aug 2023 01:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181867839.505132.10717747708330472036.stgit@devnote2>
In-Reply-To: <169181867839.505132.10717747708330472036.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:57 +0200
Message-ID: <CABRcYmLxL=F3xuNKV12oPt_aHoLM8gDLeAxMeVQsk-iuXi2mSw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] bpf: Enable kprobe_multi feature if CONFIG_FPROBE
 is enabled
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:38=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> may always returns 0. But it should be enough for function entry (access
> arguments) and exit (access return value).
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
