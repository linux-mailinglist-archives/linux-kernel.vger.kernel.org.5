Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB01788D04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbjHYQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbjHYQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675F1A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5694ee2d0edso520999a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=Wv+Aikc5fWzgctUffCSl5SpZmaqfLaajo7F4H7Gbi9R5PdH0Wk34EM+4qVUjXVkrYm
         0r2jn0Znwix7CHuX5Wko9ocul/EzipKwQHlqG0OtdTkNTsZcDWRjS8WH3K554sASZWpH
         7bxBNQz2cJIvLHM5BvsIf8m6athGePEeOqE7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=eazoRfJMBQtShdFM1y4uD6rl3FdM/Wq+VKvwmbRHVWBUOU4WT9bGUfq6VU2PY4mSI8
         a051aInUD2N/eJKS0ZjjhhH/1gD8DUtkJRBmmPtsn6J2ViBcCmSoQqkLiHfTAjgDG48E
         +9fALQgvvH00YLQoghogjDSElCDXciKAzpxrinGLFAP6hyh8BuiTfdEefQkD/ze3lwzr
         u9rOveyMR9HhcnjG5eKpZo/TRMOnJmI9YrwW8OtcQnsbn0U7qYeVpSqbGAatpuduUdvX
         VT3+HXTLt0+GtehZPU1Uap4PEwNxdoi46ZmxP8P0Mdp/V9ohLyUA4Hk//i9q/+o+wvbq
         2GXg==
X-Gm-Message-State: AOJu0YwKaQm6bF7U2Ex79u3QXkzKwUD2v3gSW+Jb/MPWW3qxPi8qjuPW
        pIA/uoLgW+Ht3clxYysdpL1d7osHSOGgwvDJZChKYA==
X-Google-Smtp-Source: AGHT+IEBHrqFG6LWnHGYuq/piq4gWrUiBxMwJVIvmD6hHxN9kT9eSyLoZ0oEcz6Qd/pumOLSwMISfSv3U10PbgFxNME=
X-Received: by 2002:a17:90a:bc92:b0:267:ee56:4c59 with SMTP id
 x18-20020a17090abc9200b00267ee564c59mr14047892pjr.35.1692979929795; Fri, 25
 Aug 2023 09:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280375109.282662.4109179404470188137.stgit@devnote2>
In-Reply-To: <169280375109.282662.4109179404470188137.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:11:58 +0200
Message-ID: <CABRcYmKjv7rvhHQCbXHhUQm+W4coWJAHM+0epA58cnGHerx=yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] fprobe: Use fprobe_regs in fprobe entry handler
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 5:15=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
