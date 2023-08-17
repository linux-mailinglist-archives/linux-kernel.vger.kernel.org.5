Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1377F294
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbjHQI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349155AbjHQI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F52724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso47634615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=Vv30KtUNN9X3DCyhblLuDc+5QN4WH17sIufZ4s2NysSZxDPAObOK+RQyUycSz2de/P
         +5sbf5cr3N9siROdEc+KFYHwsvRTeWt/wpORXfGzN3xt6SAxiaiMDS1az3ZVhLt3Ccii
         eHYiAasnpVcYWg5gJFYzO1+AjlDV8bzyQ2Vu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=Lp7jgurU8JFaIBhRSqV0w2YpQOcEz2j/c7To7zcbaDkhXC+8fwVTr0fg1Uu95mPrrv
         tQD75nQ+Up6lctLUqfAxRt4NYZ0r1uSH55A+NMOkGEf4vWIXXCnFMZbPmpdo1wrqsx55
         6Oj5pEAR4tZbWZMORidfjVhyR/8g2sCBjw/S1KHTX6eJa0E9TbtZVJlL8GcKlIh/MtIy
         Oxpn3jvVcoq48EG5tdSLeRHF4lvsCxtueySG9awwibNl9P2UOSfrKmY4LUUjl3sWegKj
         h3CheTefclcp6+AeoDN+z5sb2Lo7VgC7/vPHTOrx4uUR0Io/jNagnkMg2o4i8QJb2a9Z
         bcGQ==
X-Gm-Message-State: AOJu0YxF7pFVReivkmLj0ONCMlxTkWjxeK8ZvjHXTh9BxvubpZsU0iNJ
        Tf2Ca/Bs/nrEb2uG0Q4ZIPhSx0KzhBuu/f0nl51C0g==
X-Google-Smtp-Source: AGHT+IH6xIW34cUhfbm6uS4lGucin/ng4/m/ryyfJico4mCTUTYGDYajeDn/M+ly4sI6E4iuomTaVqg6vaPiGhO2ztA=
X-Received: by 2002:a17:90a:d34a:b0:269:3498:3bad with SMTP id
 i10-20020a17090ad34a00b0026934983badmr3496202pjx.14.1692262644742; Thu, 17
 Aug 2023 01:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:13 +0200
Message-ID: <CABRcYmJLbb0_fs2beiNA2QE468JkxB9nHnmQcQW4dt63pPBoFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
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

On Sat, Aug 12, 2023 at 7:36=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 3rd version of RFC series to use ftrace_regs instead of pt_re=
gs.
> The previous version is here;
>
> https://lore.kernel.org/all/169139090386.324433.6412259486776991296.stgit=
@devnote2/
>
> This also includes the generic part and minimum modifications of arch
> dependent code. (e.g. not including rethook for arm64.)

I think that one aspect that's missing from the discussion (and maybe
the series) so far is plans to actually save partial registers in the
existing rethook trampolines.

For now the series makes everything called by the rethook trampolines
handle the possibility of having a sparse ftrace_regs but the rethook
trampolines still save full ftrace_regs. I think that to rip the full
benefits of this series, we should have the rethook trampolines save
the equivalent ftrace_regs as the light "args" version of the ftrace
trampoline.
