Return-Path: <linux-kernel+bounces-126181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB0893346
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BC1F237D7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFF155A30;
	Sun, 31 Mar 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyxzrm6j"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69B155317;
	Sun, 31 Mar 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902520; cv=pass; b=k5o8qH9Vpw8j+L9spHTS7NMw+pKHSafks7snb9UhYmhCUjKJ12rCi+GZIO8S6y67WdSYRlFVoxmI+2sZr3KMQT7N7XQT+RNKwAsGOZZ1fIN31It80x4oR8AKrRHqXdvXwinHnnoFUzZ2WtaywLuIblJk/nhFA6ZxUrxYZHslXb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902520; c=relaxed/simple;
	bh=R2WU90g1cLuEDJZk3E6aleef6JXzOr4Axg53ZSaOO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVBqdAFlwT+HxaT0Tm/pbK8Ax2JszUUCQH/pc5oD9KsK+CLIUXUJTxY/6oviXKYfrrKE3/CayV+vrM4sC5fg+zFqdrJ/rPbiA43nVwS9SSzsleeK0Y1cvqQO9tDG/IzRiDN1aMnxqXSh7mcKYp9AMJ1taYpWtmW8EMRoZn49A4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyxzrm6j; arc=none smtp.client-ip=209.85.218.42; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5C159208D6;
	Sun, 31 Mar 2024 18:28:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgkUR1gbp8mW; Sun, 31 Mar 2024 18:28:35 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 275F2208DC;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 275F2208DC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 19E50800058;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:24:07 +0000
X-sender: <linux-kernel+bounces-125475-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAMAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAPADYAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0Lk1haWxSZWNpcGllbnQuRGlzcGxheU5hbWUPABEAAABLbGFzc2VydCwgU3RlZmZlbgUAPAACAAAFAB0ADwAMAAAAbWJ4LWVzc2VuLTAyBQAOABEABiAS9uuMOkqzwmEZDvWNNQUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQASAA8AYgAAAC9vPXNlY3VuZXQvb3U9RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCkvY249UmVjaXBpZW50cy9jbj1TdGVmZmVuIEtsYXNzZXJ0NjhjBQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAVABYAAgAAAA8ANQAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5Jc1Jlc291cmNlAgAABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoACJPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgA5AAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEPACoAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LlJlc3VibWl0Q291bnQHAAMAAAAPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExvdw==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 20008
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125475-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A828A200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyxzrm6j"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750788; cv=none; b=hc8co0G9xIMT/oVcfsq1nqbLbgIRByceqOx1miKuDcLR/lA+TlkGLDdDsSVEWvsp2Z1ML2msFnjxDtbXVWYeoWZxi+a5uJjH3TsGCKopNYXjqqDc/2rMnm+A8GSdmnnkZ0mtnZXZsm3UnDVtcdpcCn2ay0NpOx9yYXr5+uTLj7s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750788; c=relaxed/simple;
	bh=R2WU90g1cLuEDJZk3E6aleef6JXzOr4Axg53ZSaOO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPMCPJDyE8dC+KXdL/TjL60lA2tVzRuIZCXEMPj2MYNYQuTs6scNVk7dwti9FuLeUkRVdCGKiJMhKrrZSwHKe7KmXJ2RPReIUgkB7+7zJrFWHR8uh1D+hsBh95bg+JQjBy6lGwFCc48GhKreQwHI58r3TtyDYzJhu77ANq3eM+A=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyxzrm6j; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711750785; x=1712355585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMnaIYbqA7d/kZC+ybw/xWIqwL2oTfIft72gidYLOFE=;
        b=Oyxzrm6j0lAuhDsmlgxUzUJVkkyWxS8lEh5kqUJjdyKvQcgfBRvk35LnoPx92OeSuL
         07KHoAt/lk/f4ldM+mYs1FzoT3mCSGqPV0GvKeRtElkZHRf/4TWdgLsM+gO/pug9VlQi
         WGWMo7mHN6OXwqGXKmQY2lpeAR3RTH65du0AE2NjN0czZ70kUbPLkl+0sWr+/KlPTZgw
         LKUAs3Nj6bIOD72BDo53yHJHLNtTj2HgHc+tclEhApMovAOoaN8YOfjsGmN5GINbcI6G
         cpJYY3shr3xb2Ph4ve46zw4dL2G/uNDxCdayvxPg51UVW7mfeXEcVIlH8y3nHtVnhAtW
         KbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711750785; x=1712355585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMnaIYbqA7d/kZC+ybw/xWIqwL2oTfIft72gidYLOFE=;
        b=K5j3ZozFu9FbIqWNtnvQz9TGTJgMCZBpkTKNJrafGFWlYsaa1Dwd3PbBcTzXZCtVSm
         8uzlRbuqVhF3NRKmLf4uJenwjJW4h53UCL3FMLKB+E5unRDugZhjr6q0HzmJ/510qOJb
         LZ+g5D6YESsd/Ped9BYL32cGR3lD1PjinYoX9KkGGAFcTJugiY02IzJ1sepFsucBt2d1
         qYq1SqDWMFUtGtbv+FDe5YJp43mrb7wEG+qtlJ8y9RL+SMC/tfPQ4in4ywXHcbYc3YRM
         GAfzmW3brpEao1UQCR1/6RLLJ0j9s6U6A2vMMiT6Xc383EvexPgkuW0aqKzlUkqHnw34
         lZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRVyhTewPQv2FstE1TD2Tj4+EccjDTQ0xB+AzYmC6LV9IEgJ7cnV5PyWOwo/HrQEJGbT7ffnaItOczXteokfAAaSHUr8rYMD5rdjKql+kx23yQjpwElyXPj/r8XD7rr8IX
X-Gm-Message-State: AOJu0Yz452HOKmkNJLD/JxNhNgAYRvjDufiPTccoYVdOgiKaFLRbLKwb
	cpNUhUp4oM2XjfpMaX1eSQzG8RQWUU3m8knV0rTQfe13KRIBLNVdAO7M59j3rAUuQgLB6rBujZL
	HeNqTIv1np4UPE2DA2MzPZtTFN88=
X-Google-Smtp-Source: AGHT+IFXIbeetyUUcfpsB1mfhgd0tjV6olzfU9ERH0JD+fDwz7cIJECdgZPPgfSgLSc7dChwPedJk9jE2Xa6DamkmsA=
X-Received: by 2002:a17:906:1716:b0:a4e:292e:7e8d with SMTP id
 c22-20020a170906171600b00a4e292e7e8dmr1980553eje.19.1711750785361; Fri, 29
 Mar 2024 15:19:45 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
In-Reply-To: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:19:30 -0700
Message-ID: <CAEf4BzZOxqPTPYAm7VFjqaUsSNVJBdZx-z6dgQdZWFoGNAnJgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, sn624@cs.rutgers.edu, 
	sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Mar 28, 2024 at 8:02=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@gmail.com> wrote:
>
> The scalar(32)_min_max_and/or/xor functions can exhibit unsound behavior
> when setting signed bounds. The following example illustrates the issue f=
or
> scalar_min_max_and(), but it applies to the other functions.
>
> In scalar_min_max_and() the following clause is executed when ANDing
> positive numbers:
>
>                 /* ANDing two positives gives a positive, so safe to
>                  * cast result into s64.
>                  */
>                 dst_reg->smin_value =3D dst_reg->umin_value;
>                 dst_reg->smax_value =3D dst_reg->umax_value;
>
> However, if umin_value and umax_value of dst_reg cross the sign boundary
> (i.e., if (s64)dst_reg->umin_value > (s64)dst_reg->umax_value), then we
> will end up with smin_value > smax_value, which is unsound.
>
> Previous works [1, 2] have discovered and reported this issue. Our tool
> Agni [3] consideres it a false positive. This is because, during the
> verification of the abstract operator scalar_min_max_and(), Agni restrict=
s
> its inputs to those passing through reg_bounds_sync(). This mimics
> real-world verifier behavior, as reg_bounds_sync() is invariably executed
> at the tail of every abstract operator. Therefore, such behavior is
> unlikely in an actual verifier execution.
>
> However, it is still unsound for an abstract operator to exhibit behavior
> where smin_value > smax_value. This patch fixes it, making the abstract
> operator sound for all (well-formed) inputs.
>
> It's worth noting that this patch only modifies the output signed bounds
> (smin/smax_value) in cases where it was previously unsound. As such, ther=
e
> is no change in precision. When the unsigned bounds (umin/umax_value) cro=
ss
> the sign boundary, they shouldn't be used to update  the signed bounds
> (smin/max_value). In only such cases, we set the output signed bounds to
> unbounded [S64_MIN, S64_MAX]. We confirmed through SMT verification that
> the problem occurs if and only if the unsigned bounds cross the sign
> boundary.
>
> [1] https://sanjit-bhat.github.io/assets/pdf/ebpf-verifier-range-analysis=
22.pdf
> [2] https://github.com/bpfverif/agni
> [3] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
>
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> ---
>  kernel/bpf/verifier.c | 76 +++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca6cacf7b42f..9bc4c2b1ca2e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13318,18 +13318,19 @@ static void scalar32_min_max_and(struct bpf_reg=
_state *dst_reg,
>          */
>         dst_reg->u32_min_value =3D var32_off.value;
>         dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, umax_val);
> -       if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> +       if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0 &&
> +               (s32)dst_reg->u32_min_value < (s32)dst_reg->u32_max_value=
) {
> +               /* ANDing two positives gives a positive, so safe to cast
> +                * u32 result into s32 when u32 doesn't cross sign bounda=
ry.
> +                */
> +               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> +               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> +       } else {
>                 /* Lose signed bounds when ANDing negative numbers,
>                  * ain't nobody got time for that.
>                  */
>                 dst_reg->s32_min_value =3D S32_MIN;
>                 dst_reg->s32_max_value =3D S32_MAX;
> -       } else {
> -               /* ANDing two positives gives a positive, so safe to
> -                * cast result into s64.
> -                */
> -               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> -               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
>         }

have you tried just unconditionally setting s32_{min,max}_value to
S32_{MIN,MAX} and letting reg_bounds_sync perform u32/s32 bounds
derivation?

>  }
>

[...]


