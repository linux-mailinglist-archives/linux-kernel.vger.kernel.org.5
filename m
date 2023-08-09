Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9091277646E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjHIPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjHIPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:53:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16801FF9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:53:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565331f1c9eso15519a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691596414; x=1692201214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIwKDuY4Cird/U1Q4TEwDWgypIViAxxEznjv74enuWE=;
        b=YK0mzmoUhg1/WVZtS6i8IvR/ir3WbY3Rml52xGJOadNilW86RJYMM2B1S9qtS+mNV8
         02EqKkCgXbRPt5+IpTJAr2MJn/YLBb3P2HkVGUczy/s7EtkXYOCUyVH57NhCvoeG9/Ck
         +xY9zswP8Z/VRCt3kljF3dnGZyZi8QXKvdLrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596414; x=1692201214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIwKDuY4Cird/U1Q4TEwDWgypIViAxxEznjv74enuWE=;
        b=iSFIRKXU1vRQe76Z56133FyG4jhXDZwL1UgKReURPozthbCx8zhS7Ta5HRqBwID1w+
         H36doWL5WSOBcJ3fmVdP8GfGCRPgskAHlvh5pA/+PK8oDRa/+Ap0GfrvGdUw5usbq1qG
         kuJwHTxWrEDtIRyeIjEHaTm08P6VwCywois30BzXZ6swoMwIRUz1ltygXRFMmN0+3IMK
         5AgEY3sKBZ4AQbGuFrtpQHdxfFa3YiequhZUNHBqSot5eWu4Re9C1pjivHYJQ7nniN1t
         LPV98OdW9SKDnx1dJbE32pA0yzb1zmOPAh8e0/aMig01luxLK1k57XuvbhMYHE6p5taH
         ICgw==
X-Gm-Message-State: AOJu0YyIKWysc+FWImpmQ68f8ZhVVp2/cSUGKp9XII2i298e1I/ZtzZP
        9LcVP+2qw/wlwvq0yXiy28xYkNXw8QY6feD7Inl5sg==
X-Google-Smtp-Source: AGHT+IEt0SjbBNE/0A3+xFiamsHpiZ+DozfqOsjQmlYXrs6lu/425svIyeL6FcV0FsKSoHWBUid1vMOwONcyHbRTk8I=
X-Received: by 2002:a17:90b:2281:b0:269:621e:a673 with SMTP id
 kx1-20020a17090b228100b00269621ea673mr2333395pjb.1.1691596414341; Wed, 09 Aug
 2023 08:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139092722.324433.16681957760325391475.stgit@devnote2> <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
 <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
In-Reply-To: <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:53:23 +0200
Message-ID: <CABRcYmJGPLAA+HKFA0CZkEZJ0j5GvXBDDAVA7i8Wv5PDMvYQrA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:16=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 9 Aug 2023 12:29:13 +0200
> Florent Revest <revest@chromium.org> wrote:
> > > + * tracer, define the default(pt_regs compatible) ftrace_regs.
> > > + */
> > > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFI=
G_FUNCTION_TRACER)
> >
> > I wonder if we should make things simpler with:
> >
> > #if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTIO=
N_TRACER)
> >
> > And remove the ftrace_regs definitions that are copy-pastes of this
> > block in arch specific headers. Then we can enforce in a single point
> > that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.
>
> Here, the "HAVE_PT_REGS_COMPAT_FTRACE_REGS" does not mean that the
> ftrace_regs is completely compatible with pt_regs, but on the memory
> it wraps struct pt_regs (thus we can just cast the type).

But in practice I think that all architectures that chose to wrap a
pt_regs in their ftrace_regs also do:

+#define ftrace_regs_get_instruction_pointer(fregs) \
+       instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+       regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+       kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+       regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+       regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+       override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+       regs_query_register_offset(name)

And are just careful to populate the fields that let these macros
work. So maybe these could be factorized... But anyway, I'm not
particularly a super fan of the idea and I don't think it should
necessarily fit in that series. It's just something that crossed my
mind, if you're not a fan then we should probably not do it ;)
