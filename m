Return-Path: <linux-kernel+bounces-143394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B078A380E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB93F2833DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C0152184;
	Fri, 12 Apr 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BbfEDy28"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103068827
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958417; cv=none; b=jLUitFI5mlGE3SPdL/QDKAMi1MeJDv8/lgX4kPHI6gI6UFAwRFZ7kkbF5sxQe93GpakVjcCiTufyjiPZOEjd4skgvyu1wO8PwwwpxxTwtu/P9YwCOJvjOVscaAmi7e/toJi9KaPWrow8MYj/neAaACqbYCI+woDEC7C383hP1ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958417; c=relaxed/simple;
	bh=nzqS7GGCxQZXalmHH6+8jc98yFwVtPxzeFmkyj5haes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHCD2pTh/bV1YOAmYdcdhy84NR+0FKAC1dYEtGJrFmoliAlzne/6z2z1YohVPJgwmjVHPZDI2c5pH0TttFEKquIJTiw4vouRDYlpAdVKygIvENhUCx+4m2W3phGa5WdXHsC3+1hPQyfB/iUxIotkjRosd1PYvY+sHDyNIaWoy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BbfEDy28; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098a20ab22so12739487b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712958415; x=1713563215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBGlDfojlyW43NwTHsH9VR/FdiAvmp9PwQVdJj0RHjA=;
        b=BbfEDy28IOhf5v2+jxkh+vFuEkrFW8cgChHh2wN9oFt0mCmJ/W5x9byJWClo4I1iKQ
         Fi/nvCTOmTadPiLxvYjJu1v2rQN+dRdYhMLXGV4NhgjmUjARE1dRkfTX++kIwpsNpiK8
         w2GuCtCLUflNG1P6lDR1E9vecUR0ZXcAbbiuwbwT4xAqkkKrcbRyZ6cScVFnHzNO2IBj
         s+7W7KaONY+TZdJw6hnJxa26Tmbc0g8X4wTt1n9CnxWS8Xf+MGBfOE8AtNbPN0mx/gkk
         0fv3Nu8F4AktREc67TZiPCgoiXJDcp04DJa/NrkhNUBazOVjrocQ/82BKtKEgmQ10hgw
         FvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712958415; x=1713563215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBGlDfojlyW43NwTHsH9VR/FdiAvmp9PwQVdJj0RHjA=;
        b=QdWz5WWMc2lDmdRRXj6z0mK5NzZaFQyKLw02fzV2vVzt9PXXMXeHZqhfGCGpijC+gQ
         dPq5Bi4x5Ha3SwpTQOgR5AQMUVpLW1XDUO71r9kFzCxbVEr8z5dej+19iehyKIJQgH80
         3bVC7yxCCjRFPKRS7/JbcyF0G14w2Mn8RrdkmhgaDTM7Ao2lnD4lHCXD0TsUSEG7U/9x
         FNbOs6VkHEmDGSKBgwfHhktyU3AXOPKg9qSJZKqTtsG0tijY9TMJS7VSqUYCdmIO6gJY
         WWNPMuhlranVRnEkAIs+tJIa8JThk+XA31WscvyoiP4MIu4nkj/DQuMIzlr0PUNsMLxY
         0i3g==
X-Forwarded-Encrypted: i=1; AJvYcCUCWMH9aJ7mpdsjFNqTKWAjqR/XXWnLveUHQn182m+R6FFd6uysOApSa3Ob6MnLO788Erhv4aPn0Wi+3i/7M6SWiSoqzWD4Ukf1f02V
X-Gm-Message-State: AOJu0YxbaIHqsZHSOXg4NIR0TG5bFBoEcajDroUtAkF6C5f6PXHQqho6
	d+F/qSYTMWeqS3YxN+Nk8+nYnqPHILx8tpsIIbD2TPiA/sZwWZP8leHaSei3qqdgpmm/Kgp/D26
	4BFyaiPXi7qFh/U1ABTrWKy/XMPrsoSU4xAJzCA==
X-Google-Smtp-Source: AGHT+IHJfYItkCw/4Uk6RY2JMasDKCLJSNFdvHcSuK3dZIvyPvP4FzEmTGnOee24wcLenUN/pg2Q/I6ELqcjeXKiP5w=
X-Received: by 2002:a25:ae1d:0:b0:dc6:c367:f0e4 with SMTP id
 a29-20020a25ae1d000000b00dc6c367f0e4mr3806397ybj.52.1712958415030; Fri, 12
 Apr 2024 14:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
 <25703ec0-f985-4d5f-8bfa-0c070da5b570@huaweicloud.com>
In-Reply-To: <25703ec0-f985-4d5f-8bfa-0c070da5b570@huaweicloud.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 12 Apr 2024 14:46:43 -0700
Message-ID: <CABWYdi0BQHB1_COkcSnr_JxDMJipHPbv3=FKOKqD5qED-j37Pg@mail.gmail.com>
Subject: Re: Incorrect BPF stats accounting for fentry on arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:30=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 4/12/2024 2:09 AM, Ivan Babrou wrote:
> > Hello,
> >
> > We're seeing incorrect data for bpf runtime stats on arm64. Here's an e=
xample:
> >
> > $ sudo bpftool prog show id 693110
> > 693110: tracing  name __tcp_retransmit_skb  tag e37be2fbe8be4726  gpl
> > run_time_ns 2493581964213176 run_cnt 1133532 recursion_misses 1
> >      loaded_at 2024-04-10T22:33:09+0000  uid 62727
> >      xlated 312B  jited 344B  memlock 4096B  map_ids 8550445,8550441
> >      btf_id 8726522
> >      pids prometheus-ebpf(2224907)
> >
> > According to bpftool, this program reported 66555800ns of runtime at
> > one point and then it jumped to 2493581675247416ns just 53s later when
> > we looked at it again. This is happening only on arm64 nodes in our
> > fleet on both v6.1.82 and v6.6.25.
> >
> > We have two services that are involved:
> >
> > * ebpf_exporter attaches bpf programs to the kernel and exports
> > prometheus metrics and opentelementry traces driven by its probes
> > * bpf_stats_exporter runs bpftool every 53s to capture bpf runtime metr=
ics
> >
> > The problematic fentry is attached to __tcp_retransmit_skb, but an
> > identical one is also attached to tcp_send_loss_probe, which does not
> > exhibit the same issue:
> >
> > SEC("fentry/__tcp_retransmit_skb")
> > int BPF_PROG(__tcp_retransmit_skb, struct sock *sk)
> > {
> >    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_retransmit_=
skb);
> > }
> >
> > SEC("fentry/tcp_send_loss_probe")
> > int BPF_PROG(tcp_send_loss_probe, struct sock *sk)
> > {
> >    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_send_loss_p=
robe);
> > }
> >
> > In handle_sk we do a map lookup and an optional ringbuf push. There is
> > no sleeping (I don't think it's even allowed on v6.1). It's
> > interesting that it only happens for the retransmit, but not for the
> > loss probe.
> >
> > The issue manifests some time after we restart ebpf_exporter and
> > reattach the probes. It doesn't happen immediately, as we need to
> > capture metrics 53s apart to produce a visible spike in metrics.
> >
> > There is no corresponding spike in execution count, only in execution t=
ime.
> >
> > It doesn't happen deterministically. Some ebpf_exporter restarts show
> > it, some don't.
> >
> > It doesn't keep happening after ebpf_exporter restart. It happens once
> > and that's it.
> >
> > Maybe recursion_misses plays a role here? We see none for
> > tcp_send_loss_probe. We do see some for inet_sk_error_report
> > tracepoint, but it doesn't spike like __tcp_retransmit_skb does.
> >
> > The biggest smoking gun is that it only happens on arm64.
> >
> > I'm happy to try out patches to figure this one out.
> >
>
> I guess the issue is caused by the not setting of x20 register
> when __bpf_prog_enter(prog) returns zero.

Yes, I think this is it. Your patch makes it match x86_64 and it seems logi=
cal.

I'm building a kernel with it to put it into production to make sure.

> The following patch may help:
>
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1905,15 +1905,15 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, =
struct bpf_tramp_link *l,
>
>          emit_call(enter_prog, ctx);
>
> +       /* save return value to callee saved register x20 */
> +       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
> +
>          /* if (__bpf_prog_enter(prog) =3D=3D 0)
>           *         goto skip_exec_of_prog;
>           */
>          branch =3D ctx->image + ctx->idx;
>          emit(A64_NOP, ctx);
>
> -       /* save return value to callee saved register x20 */
> -       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
> -
>          emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
>          if (!p->jited)
>                  emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
>

