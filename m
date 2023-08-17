Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5C77FE16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbjHQSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354537AbjHQSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:47:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21230DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:47:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso47951cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692298031; x=1692902831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp0NthnNgNW9pfSHThKLiT0vLETnlkt+ybLcHDOCqv4=;
        b=SkYHGMX7/zEdfpvdwe4xmc9VuoQk/4zI8atVm2UPl4vfiQR3+Q1ZTmmigkJ1hys9R2
         72ylJcXolSwPy1jiNkipeMyj69Cvy4vaocaejOflWSnDdcXnL7qy4RfRbzgxgrSVeYeI
         rzLLb+kAq1NXIyGcSdBgAfL1DycqepB8mj5GinLRziguoRexSfGEFB1HOcFfmo8yioO7
         DbfJCZQ4N/HLAqghZP9t/2R0Wv3Tj7k+vfjp6CtwsBR/B7bhfYsmQCtpyNRjCWao2Cky
         HOo9EnuJ45NfxkrL1nA7aJhK0HI+MSiAcq7N3vXiwJTD5eyOrkjS3XoACvdrjcfpwHCP
         wwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298031; x=1692902831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp0NthnNgNW9pfSHThKLiT0vLETnlkt+ybLcHDOCqv4=;
        b=MAD/lDrHlOGxSkL2G8QoqODqUWyqlbzreIvb0fTdljTMFSmTmHP10TQm9mDmmaFjco
         GTjCBADqzFLELGWAbgk9DNGPoAb49H4rdeA2jnbCZJ6EWXCTjmx0YRCIOerUPjoezDpK
         8EZxPEBrUif+ukxDhMvVVDGwGOqx477gclSkpoPA5NdVuMJSWOeXWSrEQMuA/BsPusaa
         qWRlqznO2CvprxCfd/lPHZm0/IT2TwGWUipHZunO1v4q5FPw1DG9zL76+I8GG0QQJp8s
         0Rqr280Y6WksfQW4TrzyqyEiZQAqK7xNNnaY1R5I+qBlVm3DgoQzcLcxV335a7adfQIT
         wP+A==
X-Gm-Message-State: AOJu0YzL15L5lXhfAVlXv++OEnr1C8sjJ+DGHxcZnPg5wpEjSuBfl+nQ
        a4a5pxlhX34b/84j5k99vS86qr3XNWCv0J1aTVogC+FefR4brzyUvkWxlg==
X-Google-Smtp-Source: AGHT+IFZ/uSZcg1BajBQOyeT8Pl3+X+FIqBWzWKGMibNfodAjD1s9ooWUoNoiPf30jzQjLSDDLXyyP0B37QQAlHaoF0=
X-Received: by 2002:ac8:5844:0:b0:403:a43d:bd7d with SMTP id
 h4-20020ac85844000000b00403a43dbd7dmr62062qth.4.1692298030746; Thu, 17 Aug
 2023 11:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZN5lrdeEdSMCn7hk@kernel.org>
In-Reply-To: <ZN5lrdeEdSMCn7hk@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Aug 2023 11:46:59 -0700
Message-ID: <CAP-5=fX8ipwPj_M6r3K=rZnYyVnW6VUYWARJhamFbphzLFxx+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf trace: Use heuristic when deciding if a syscall
 tracepoint "const char *" field is really a string
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> 'perf trace' tries to find BPF progs associated with a syscall that have
> a signature that is similar to syscalls without one to try and reuse,
> so, for instance, the 'open' signature can be reused with many other
> syscalls that have as its first arg a string.
>
> It uses the tracefs events format file for finding a signature that can
> be reused, but then comes the "write" syscall with its second argument
> as a "const char *":
>
>   # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_write/format
>   name: sys_enter_write
>   ID: 746
>   format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:int __syscall_nr; offset:8;       size:4; signed:1;
>         field:unsigned int fd;  offset:16;      size:8; signed:0;
>         field:const char * buf; offset:24;      size:8; signed:0;
>         field:size_t count;     offset:32;      size:8; signed:0;
>
>   print fmt: "fd: 0x%08lx, buf: 0x%08lx, count: 0x%08lx", ((unsigned long=
)(REC->fd)), ((unsigned long)(REC->buf)), ((unsigned long)(REC->count))
>   #
>
> Which isn't a string (the man page for glibc has buf as "void *"), so we
> have to use the name of the argument as an heuristic, to consider a
> string just args that are "const char *" and that have in its name  the
> "path", "file", etc substrings.
>
> With that now it reuses:
>
>   [root@quaco ~]# perf trace -v --max-events=3D1 |& grep Reus
>   Reusing "open" BPF sys_enter augmenter for "stat"
>   Reusing "open" BPF sys_enter augmenter for "lstat"
>   Reusing "open" BPF sys_enter augmenter for "access"
>   Reusing "connect" BPF sys_enter augmenter for "accept"
>   Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
>   Reusing "connect" BPF sys_enter augmenter for "bind"
>   Reusing "connect" BPF sys_enter augmenter for "getsockname"
>   Reusing "connect" BPF sys_enter augmenter for "getpeername"
>   Reusing "open" BPF sys_enter augmenter for "execve"
>   Reusing "open" BPF sys_enter augmenter for "truncate"
>   Reusing "open" BPF sys_enter augmenter for "chdir"
>   Reusing "open" BPF sys_enter augmenter for "mkdir"
>   Reusing "open" BPF sys_enter augmenter for "rmdir"
>   Reusing "open" BPF sys_enter augmenter for "creat"
>   Reusing "open" BPF sys_enter augmenter for "link"
>   Reusing "open" BPF sys_enter augmenter for "unlink"
>   Reusing "open" BPF sys_enter augmenter for "symlink"
>   Reusing "open" BPF sys_enter augmenter for "readlink"
>   Reusing "open" BPF sys_enter augmenter for "chmod"
>   Reusing "open" BPF sys_enter augmenter for "chown"
>   Reusing "open" BPF sys_enter augmenter for "lchown"
>   Reusing "open" BPF sys_enter augmenter for "mknod"
>   Reusing "open" BPF sys_enter augmenter for "statfs"
>   Reusing "open" BPF sys_enter augmenter for "pivot_root"
>   Reusing "open" BPF sys_enter augmenter for "chroot"
>   Reusing "open" BPF sys_enter augmenter for "acct"
>   Reusing "open" BPF sys_enter augmenter for "swapon"
>   Reusing "open" BPF sys_enter augmenter for "swapoff"
>   Reusing "open" BPF sys_enter augmenter for "delete_module"
>   Reusing "open" BPF sys_enter augmenter for "setxattr"
>   Reusing "open" BPF sys_enter augmenter for "lsetxattr"
>   Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
>   Reusing "open" BPF sys_enter augmenter for "getxattr"
>   Reusing "open" BPF sys_enter augmenter for "lgetxattr"
>   Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
>   Reusing "open" BPF sys_enter augmenter for "listxattr"
>   Reusing "open" BPF sys_enter augmenter for "llistxattr"
>   Reusing "open" BPF sys_enter augmenter for "removexattr"
>   Reusing "open" BPF sys_enter augmenter for "lremovexattr"
>   Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
>   Reusing "open" BPF sys_enter augmenter for "mq_open"
>   Reusing "open" BPF sys_enter augmenter for "mq_unlink"
>   Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
>   Reusing "open" BPF sys_enter augmenter for "symlinkat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
>   Reusing "connect" BPF sys_enter augmenter for "accept4"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
>   Reusing "open" BPF sys_enter augmenter for "memfd_create"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
>   Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
>   [root@quaco ~]#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3964cf44cdbcb3e8..e541d0e2777ab935 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3398,6 +3398,19 @@ static struct bpf_program *trace__find_usable_bpf_=
prog_entry(struct trace *trace
>                         if (strcmp(field->type, candidate_field->type))
>                                 goto next_candidate;
>
> +                       /*
> +                        * This is limited in the BPF program but sys_wri=
te
> +                        * uses "const char *" for its "buf" arg so we ne=
ed to
> +                        * use some heuristic that is kinda future proof.=
..
> +                        */
> +                       if (strcmp(field->type, "const char *") =3D=3D 0 =
&&
> +                           !(strstr(field->name, "name") ||
> +                             strstr(field->name, "path") ||
> +                             strstr(field->name, "file") ||
> +                             strstr(field->name, "root") ||
> +                             strstr(field->name, "description")))
> +                               goto next_candidate;
> +
>                         is_candidate =3D true;
>                 }
>
> --
> 2.41.0
>
