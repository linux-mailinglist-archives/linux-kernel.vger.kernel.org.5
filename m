Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7D7DDBB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKADzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKADzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:55:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BAC1;
        Tue, 31 Oct 2023 20:55:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so253735f8f.1;
        Tue, 31 Oct 2023 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698810908; x=1699415708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=fZm8vkKKqOSIcofsxbkKBs6gKtm0G3nysJnpwn+UOhJoKHGqj0j+PCQZRxiMR6gkT/
         xJVoAJbND+xKOLjbbWybqNcq74dHq95jUBogQxHSipU7h7/CKegi01QvjPbXXC5p0ZmJ
         etoPn/014get5N9KDSG/NV0TVh8ayU2FXN4hfTP+yumVx6vXmL0Lfadw5BFDlrwk8JDg
         LVt5lu1VHgaia9z9LqL10vpskqJ8cqKXOECXw2wDnrmjGfL9/mR+L7XAI4ZKW1Ipcy5O
         FDLybJxxT/KmYjvS6jzTlh4a9Lg1LEyfHOypXq3gk64LaTaNvwKVjO85L/u9ZC1DNGzf
         rwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698810908; x=1699415708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=v6E2BrViqzedMnnCZJv4QrvUzuTsIVRZsblundj+4lDsNNOvSA/7OFjz0MKMqH/9/C
         OieSFTfIiGoNj2iPo/cXw5vcu/qOIwz+XpDMkYA2iDN/CyQ4DgbHElFbxLUZ/44yKaTQ
         RPLQ6hA20wELqwCY+is8Wnz9j1DDdAif97BpoTXiytQakZz1JBSePpzbDRtF8pMtAKjy
         kfO7oq6+IZM60Wj1/eBMEsSi1KrViYCXJT7p1GmRsxrOg36zl4F9H1tVKAHs73Ek3+Yu
         qetIs79f7efqsu7TgEn4vL0eemczDZ55cOFrJxxcnjNO5xSJ2IFYp543B6dpOu14EQBi
         SwzA==
X-Gm-Message-State: AOJu0YxGFm+y2w7QzUBLzVTEV3VYrgkZPbfWh+8ms1/XHgVKQx5jt/6c
        +Vi8M6LLy06eYQomjudcIo9TEj/eS2AK9DnuDu4=
X-Google-Smtp-Source: AGHT+IEr7KyXAJEpInft+c9ZhQlYvVmFJWyLpzhcsVLEkhcHWsrXKsLbILhZlE1rMBSUuUxgrsGXTN9cMIGNRYTrhyM=
X-Received: by 2002:a05:6000:154b:b0:32f:811c:dfc4 with SMTP id
 11-20020a056000154b00b0032f811cdfc4mr5397720wry.4.1698810907910; Tue, 31 Oct
 2023 20:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org> <ZUEzzc/Sod8OR28B@krava>
In-Reply-To: <ZUEzzc/Sod8OR28B@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 Oct 2023 20:54:56 -0700
Message-ID: <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Matthieu Baerts <matttbe@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> > Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> > possible to build the kernel without CONFIG_CGROUPS:
> >
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> >   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclare=
d (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |              ^~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is re=
ported only once for each function it appears in
> >   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undecl=
ared (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |                                    ^~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof'=
 to incomplete type 'struct css_task_iter'
> >     927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(=
struct css_task_iter));
> >         |                                                            ^~=
~~~~
> >   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function=
 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=3Dimplicit-=
function-declaration]
> >     930 |         css_task_iter_start(css, flags, kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~~~
> >         |         task_seq_start
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> >   kernel/bpf/task_iter.c:940:16: error: implicit declaration of functio=
n 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=3Dimpl=
icit-function-declaration]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~
> >         |                class_dev_iter_next
> >   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function=
 with return type 'struct task_struct *' makes pointer from integer without=
 a cast [-Werror=3Dint-conversion]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> >   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function=
 'css_task_iter_end' [-Werror=3Dimplicit-function-declaration]
> >     949 |         css_task_iter_end(kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~
> >
> > This patch simply surrounds with a #ifdef the new code requiring CGroup=
s
> > support. It seems enough for the compiler and this is similar to
> > bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> > been added in kernel/bpf/helpers.c and in the selftests.
> >
> > Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfunc=
s")
> > Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665=
206927
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp=
@intel.com/
> > Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
>
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

I believe this patch has the same issue as Arnd's patch:
https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpo=
R1RQ@mail.gmail.com/

I'd like to merge the fix asap. Please make it a complete fix.
