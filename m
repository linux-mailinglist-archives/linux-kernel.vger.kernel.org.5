Return-Path: <linux-kernel+bounces-126178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFF89333C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7451F22C52
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E815539B;
	Sun, 31 Mar 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h02OONrK"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7851482E7;
	Sun, 31 Mar 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902516; cv=fail; b=jzFqbVqFlLIF2d29i7+YfCa914J4t7i95JWhtfdDvxhHt/yl2p8PTnFOAR6IUhUnodTPAbP6DnEVFAVP1XCt6ioJ+tQt+lYyiVOrLlIcTj/OLcOxuYQhuCPCbV48MHK9d2fMrF8yxBCP6H/ig6pIZPno8Luh8xQ6zgi7NjBdZGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902516; c=relaxed/simple;
	bh=8nfNkzh2/Qk/0WJb9WTzyiOj7a5Z5k2XIv/M2Qs+IV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=navydjdWF8ZFkZU/QONDvqTSnStPAHzqbAYxljhgKWi4ewOww1kgDGdHMKuQCy5iiUADrTKPHWhMQCfFCcj3MxtPNo2SbCaLi9U1uq2OQqmIArmUGutYEyGGkGVLToaLegEkUV6ecX+6U2jd9Abg9DTSYoVnjx7FdbrSNzb7wXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h02OONrK reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.54; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CB161208E1;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIAd1lYUSM4l; Sun, 31 Mar 2024 18:28:29 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D433B208D0;
	Sun, 31 Mar 2024 18:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D433B208D0
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id C5299800057;
	Sun, 31 Mar 2024 18:28:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:31 +0000
X-sender: <netdev+bounces-83464-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAtpHp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBpAAAAi4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 15790
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83464-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 216ED20897
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747613; cv=none; b=o3hT6rBlhYRPp3nILeYSgLH5jgw3/ahNcI+sDsQW7a6Oq02j3c5prNzS0n5vJx9TVbZQcqIgvdV9HTstLuoPtW/jT0vcYIvofBPyJUl7qtv3N1ZcCALaUGLdrgZBAPv1JUH+kyrmT9ybQHjLzeMASpgNwI0hFSXpPucdmpDSanw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747613; c=relaxed/simple;
	bh=GY2kYFst4z/jzDluAZKuRs3VnNLG/lJw8nm0VcFYikM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvWQ2A0CseIsL9FgYjN6zPufVIpQqiRzxpxfWWir2S2bRrkalHeIYKni2SW9MnB9+iKThkvwKO+Zn5Zssl7qqHveQk51ff9EJpUn5NhPHVmY4QJ0TF4i9BP87FJsd1aA9g47SAdGsUrEEJEsLIDX4ANMZG8S1Gjnd1qw8tZdsRM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h02OONrK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711747610; x=1712352410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=;
        b=h02OONrKn+4k88m3UEDllV8o8JUuB2NguuTGHZzCXHNiOAa9yBQIiaGmfQsGVV86q3
         vwTm5pN9qCEJWhO3/1dihonK9iCD1MV6zVd13EikzldfB4dxhYg+3Wg6vO0czEsr1HAc
         Xnut8+4zSVKD/nOdEua3WuEO6t2FYuiIILMfvrA145eDAhyL+bLHHiztPM0IEukc3eMT
         QwkIybVK8O22yg5D4IKFhCt9QnTfLrqtSCdTICpGqqxHghVj4Ift5u/IfjSrR2EkEVNe
         CwHVBQEan1clULUfxVR4imy+rZpP4IILFDkrBGL8rfHg7ZbgGF/FY9ZH05/vNFFyN9i4
         L+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747610; x=1712352410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=;
        b=AZml1tLtFlyP9+6qzsr/Y/Kp5igFrK2oUC/WIz//Zmu/5fSRzhVpw37aRWeKK6hdX/
         FxsJBUEiOwP7rnH9cVh0eWtHbz2qaashwfXDE6sVeXzEDIGZGpGu23nNdVQXdmSsPoym
         +exTdbi8fY0pCW6bB8Bl9QHeCnAfsqlPKJyaAjnrOHw5Qw9qdI1S9gC2eq0WbnVy6iHQ
         7tLKPnU50UXa4ii7btWPm2rqB3S45MtzAeOOLaaKgubovEhMNhC+usRZ5ijfKdVYpIhu
         bTcuciA022kGsoViz3poqnsJ0p8W9ojwHusnFV0FwDvrqrw9MTAV+LH+DM//g3kcbyjr
         T4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUms6Y8mQXobn6Doc4LggzSXZfoQDIm/IKPAkO+/bgLih/BXEZjjKJJx2V38SsUeCaJy1R/1BisLsDktGAF092Q8+cQmdOHd3i65roTYjtnFDPo2/M4ZlO8bb6wJr5fOR5UJWeLxlciGCxFLtE/mIj3WRxJMuCKajUX
X-Gm-Message-State: AOJu0YwDLEfVDuSKNNImIfCehbMu01XecTBUg/BxEe3Dr2BLV02Sld8L
	HnQdjTLXkZXA3IHu11Z7n/x+G0xL6V5UIl2p3WAyQ6nodkCzPQbShE13cVc4xK07Mw0KAcUpPfT
	hd4UbQzqEaNrmK52fddVQ5NxZI1I=
X-Google-Smtp-Source: AGHT+IEhPG1B/8mDvGNpkDj4PWCUpLjQ708pGc8G6bha6o2gM1Lwf8UNLZI5EJ57kTgt1wZPIajCKtTg1SeDSsMj41A=
X-Received: by 2002:a05:6000:24a:b0:33e:4238:8615 with SMTP id
 m10-20020a056000024a00b0033e42388615mr1774070wrz.40.1711747609718; Fri, 29
 Mar 2024 14:26:49 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-2-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-2-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:26:38 -0700
Message-ID: <CAADnVQLZnkm8psPvmUOS1FDacXdJPxQ79rQJ33F00dkS9czw1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 1/2] x86/bpf: Fix IP after emitting call depth accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> Adjust the IP passed to `emit_patch` so it calculates the correct offset
> for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
> Otherwise we will skip some instructions and most likely crash.
>
> Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
> Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@=
gmail.com/
> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a7ba8e178645..09f7dc9d4d65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *i=
p)
>
>  static int emit_rsb_call(u8 **pprog, void *func, void *ip)
>  {
> +       void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       x86_call_depth_emit_accounting(pprog, func);
> -       return emit_patch(pprog, func, ip, 0xE8);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);

Why not just
ip +=3D x86_call_depth_emit_accounting(pprog, func);

?

> +       return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
>  static int emit_jump(u8 **pprog, void *func, void *ip)
> --
> 2.44.0
>

X-sender: <netdev+bounces-83464-steffen.klassert=3Dcunet.com@vger.kernel.or=
g>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAi5Hp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBqAAAAi4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 15806
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:27:05 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:27:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D2D3020897
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:27:05 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id loUNJzs71Z7j for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:27:04 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
75.199.223; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83464=
-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klassert@se=
cunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8242220892
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8242220892
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB5A1C20AE8
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EE13BC09;
	Fri, 29 Mar 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3D02OONrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221=
54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E138FAD;
	Fri, 29 Mar 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
85.221.54
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711747613; cv=3Dne; b=3DhT6rBlhYRPp3nILeYSgLH5jgw3/ahNcI+sDsQW7a6Oq02j3=
c5prNzS0n5vJx9TVbZQcqIgvdV9HTstLuoPtW/jT0vcYIvofBPyJUl7qtv3N1ZcCALaUGLdrgZB=
APv1JUH+kyrmT9ybQHjLzeMASpgNwI0hFSXpPucdmpDSanwARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711747613; c=3Dlaxed/simple;
	bh=3D2kYFst4z/jzDluAZKuRs3VnNLG/lJw8nm0VcFYikM=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DWQ2A0CseIsL9FgYjN6zPufVIpQqiRzxpxfWWir2S2bRrkalHe=
IYKni2SW9MnB9+iKThkvwKO+Zn5Zssl7qqHveQk51ff9EJpUn5NhPHVmY4QJ0TF4i9BP87FJsd1=
aA9g47SAdGsUrEEJEsLIDX4ANMZG8S1Gjnd1qw8tZdsRMARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D2OONrK; arc=3Dne smtp.client-ip 9=
85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341c9926f98=
so1441462f8f.1;
        Fri, 29 Mar 2024 14:26:51 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711747610; x=1712352410; darn=3Der.kernel=
org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=3D=0A=
        b=3D2OONrKn+4k88m3UEDllV8o8JUuB2NguuTGHZzCXHNiOAa9yBQIiaGmfQsGVV86q=
3
         vwTm5pN9qCEJWhO3/1dihonK9iCD1MV6zVd13EikzldfB4dxhYg+3Wg6vO0czEsr1H=
Ac
         Xnut8+4zSVKD/nOdEua3WuEO6t2FYuiIILMfvrA145eDAhyL+bLHHiztPM0IEukc3e=
MT
         QwkIybVK8O22yg5D4IKFhCt9QnTfLrqtSCdTICpGqqxHghVj4Ift5u/IfjSrR2EkEV=
Ne
         CwHVBQEan1clULUfxVR4imy+rZpP4IILFDkrBGL8rfHg7ZbgGF/FY9ZH05/vNFFyN9=
i4
         L+ZQ=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711747610; x=1712352410;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=3D=0A=
        b=3Dml1tLtFlyP9+6qzsr/Y/Kp5igFrK2oUC/WIz//Zmu/5fSRzhVpw37aRWeKK6hdX=
/
         FxsJBUEiOwP7rnH9cVh0eWtHbz2qaashwfXDE6sVeXzEDIGZGpGu23nNdVQXdmSsPo=
ym
         +exTdbi8fY0pCW6bB8Bl9QHeCnAfsqlPKJyaAjnrOHw5Qw9qdI1S9gC2eq0WbnVy6i=
HQ
         7tLKPnU50UXa4ii7btWPm2rqB3S45MtzAeOOLaaKgubovEhMNhC+usRZ5ijfKdVYpI=
hu
         bTcuciA022kGsoViz3poqnsJ0p8W9ojwHusnFV0FwDvrqrw9MTAV+LH+DM//g3kcby=
jr
         T4ig=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCUms6Y8mQXobn6Doc4LggzSXZfoQDIm/IKPAkO+/bg=
Lih/BXEZjjKJJx2V38SsUeCaJy1R/1BisLsDktGAF092Q8+cQmdOHd3i65roTYjtnFDPo2/M4Zl=
O8bb6wJr5fOR5UJWeLxlciGCxFLtE/mIj3WRxJMuCKajUX
X-Gm-Message-State: AOJu0YwDLEfVDuSKNNImIfCehbMu01XecTBUg/BxEe3Dr2BLV02Sld8=
L
	HnQdjTLXkZXA3IHu11Z7n/x+G0xL6V5UIl2p3WAyQ6nodkCzPQbShE13cVc4xK07Mw0KAcUpPf=
T
	hd4UbQzqEaNrmK52fddVQ5NxZI1IX-Google-Smtp-Source: AGHT+IEhPG1B/8mDvGNpkDj4=
PWCUpLjQ708pGc8G6bha6o2gM1Lwf8UNLZI5EJ57kTgt1wZPIajCKtTg1SeDSsMj41AX-Receiv=
ed: by 2002:a05:6000:24a:b0:33e:4238:8615 with SMTP id
 m10-20020a056000024a00b0033e42388615mr1774070wrz.40.1711747609718; Fri, 29
 Mar 2024 14:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.1814=
7-2-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-2-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:26:38 -0700
Message-ID: <CAADnVQLZnkm8psPvmUOS1FDacXdJPxQ79rQJ33F00dkS9czw1Q@mail.gmail=
com>
Subject: Re: [PATCH RESEND bpf 1/2] x86/bpf: Fix IP after emitting call dep=
th accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kern=
el.org>,=20
	=3DTF-8?Q?Joan_Bruguera_Mic=C3=B3?=3Doanbrugueram@gmail.com>,=20
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net=
>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83464-steffen.klassert=3Dcunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:27:05.8796
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 6a725642-594b-4e0f-2297-08dc=
5036fb91
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D406|SMR=3D353(SMRDE=3D050|SMRC=3D302(SMRCL=3D=
102|X-SMRCR=3D303))|CAT=3D052(CATOS=3D011
 (CATSM=3D011(CATSM-Malware
 Agent=3D011))|CATRESL=3D020(CATRESLP2R=3D001)|CATORES=3D018
 (CATRS=3D018(CATRS-Index Routing Agent=3D017)));2024-03-29T21:27:06.276Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9939
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D009|SMR=3D008(SMRPI=3D006(SMRPI-FrontendProxyAgent=3D006))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAWoEAAAPAAADH4sIAAAAAAAEAJVU227b=
RhAd6i5Zkls3Rd
 GXYpAnX3Q3fZHqpLYTF3Vhw0GStkBf5BW5ktaiSHa5iu1egP5RH/rY
 x/5Jv6SzS8o24MhOhAU1mjlz5szMUv+Uz3z8VooanjKJnW4NO62OjU
 xhp2d3//vzr4NT/EEGER6KXy/YBPdmA2Psj6ZMeA0nmD7HSxko3quU
 ntMhrmDaw+8D5uOhnI1mXDI8Fc6/f+PeBTkHiW96hyDJPHAvZpFCNe
 Z4/ApDFkXcRRXgOZ8K1Q+ZcsbnGAUoFDrMc2YeUzwycCeQkjsKg+Ew
 4kpzDQNpIi8OTk5Q+JGSM0eJwEcxxPOr3e0+MXh9l4dq3Df0zHGCma
 +EPzpH7YiI1OUNzXVGRPJSRBwv6QjPw2giQlIy5XepI2S+i9OAWvDE
 hHvX6EgWjRvzuYgrHvVw0OFdd8i37AG3cfUpSWkOwmEPj6ZxWx4aUX
 irR0uW/JeZkNx9uqapToQ/6eFYqTDqNZteIHljwqXPvUYgR01vMvWa
 tMTNVru11Wnb3U6n0dlq2Tub9XZ9wQqamvaNGPncrdMQ64Prj18hvn
 B6eODxKy7wjWIyeBcIFbzDPRap/Vt9N9CXzBfcw8NATqbM93HPNY59
 EYw4k4PgquFzZdD1el1/IZPOuKknRgE9tf4FLY6qhw0Hf8ct3NjYSJ
 BtHAqP7sWY+SPu1nBTL4pLs6bVjTW65DRmj8e/62vJilwxHFKxEW2C
 NR8qNngoqpmE7/IrZDsDtsvbO7vb9laj0eoOd1yn69ru9ha2W61t20
 6ae7iaBlFnjxfd38e6vdOtdXFDf7Vb2hMppoRDgpS51uber852cX09
 DGUwqiFtycX14cx35rYI5wO5ly2jwYczIP5mtGP8iUPMvOTc7Yvwa4
 NJPmev3h6fHv989Lr/3fHLo/6PB69XNeOaAdUT0MMv7mqi536e5Gom
 fbz9H7kLraEIa9i6OtqNk+Z67yjFZ4ShwMfVr5R+Gl+jHyjURJWSpn
 j20Rzf6MetqkdauSP6bk/4x6KNXsym4YdtM361Og3bbrQMW6UEkIJ0
 GrJpC8p0IJOCTAayKSudB8hDgewcFPIWfAqFLOQImYVKBnLkL0CRjI
 oFX0DVhJZykE9rhjQZmseCksaTnaZTgiWKEmcOSmSkTaElKBOSqn9l
 fmYNcwnKxigWoUSJ5IlPGSpxFvGTDGIuw7KhSgCURVUopQBV0pa14D
 RpIR8nVmGZbAtSlURzIWdBJZGdeV9TBfJTyhKVtqBq7BtnAUqU/gTy
 Rd3RJ5Qe95U2k4wrWhaNASyrrJ+QIk/eKsZ2yVqOjSJ8ljEaYsB7SC
 C1OKS7LkO1bFVyADmoLkYWF4YsmhKVzxqpqdhO6buRS0ZHyWbCKbNQ
 cwH0Sc2XntFjzMZs9zCf07NgwRIUU7BMIlaglEnAK/dWv2RyV4h2fn
 9yMZtZ0MqcR1dZkHtzuygltwDz5X3+OTOBnzzStVWJB6VHZKW1/T+V
 3ePHhQkAAAEKnwQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPS
 J1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4w
 LjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YX
 J0SW5kZXg9IjQ1Ij4NCiAgICAgIDxFbWFpbFN0cmluZz51Yml6amFr
 QGdtYWlsLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCi
 AgICA8RW1haWwgU3RhcnRJbmRleD0iMTAzIj4NCiAgICAgIDxFbWFp
 bFN0cmluZz5qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNvbTwvRW1haWxTdH
 Jpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRl
 eD0iNjA1IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3
 RyaW5nPmFzdEBrZXJuZWwub3JnPC9FbWFpbFN0cmluZz4NCiAgICA8
 L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI2NDUiIFBvc2
 l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+ZGFuaWVs
 QGlvZ2VhcmJveC5uZXQ8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haW
 w+DQogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BC6ACPD94bWwgdmVy
 c2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8VXJsU2V0Pg
 0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPFVybHM+
 DQogICAgPFVybCBTdGFydEluZGV4PSI0MzciIFBvc2l0aW9uPSJPdG
 hlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdHJpbmc+aHR0cHM6
 Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDEwNTIxNDkyMi4yNT
 A0NzMtMS1qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNvbS88L1VybFN0cmlu
 Zz4NCiAgICA8L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQzjBj
 w/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0K
 PENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW
 9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRl
 eD0iMzIiPg0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIzMiI+DQ
 ogICAgICAgIDxQZXJzb25TdHJpbmc+VXJvcyBCaXpqYWs8L1BlcnNv
 blN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz
 4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjQ1Ij4NCiAgICAg
 ICAgICA8RW1haWxTdHJpbmc+dWJpempha0BnbWFpbC5jb208L0VtYW
 lsU3RyaW5nPg0KICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFp
 bHM+DQogICAgICA8Q29udGFjdFN0cmluZz5Vcm9zIEJpemphayAmbH
 Q7dWJpempha0BnbWFpbC5jb208L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjgzIj
 4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iODMiPg0KICAgICAg
 ICA8UGVyc29uU3RyaW5nPkpvYW4gQnJ1Z3VlcmE8L1BlcnNvblN0cm
 luZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAg
 ICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjEwMyI+DQogICAgICAgIC
 AgPEVtYWlsU3RyaW5nPmpvYW5icnVndWVyYW1AZ21haWwuY29tPC9F
 bWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW
 1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+Sm9hbiBCcnVndWVy
 YSBNaWPDsyAmbHQ7am9hbmJydWd1ZXJhbUBnbWFpbC5jb208L0Nvbn
 RhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICA8L0NvbnRhY3Rz
 Pg0KPC9Db250YWN0U2V0PgEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMC
 wxO1JldHJpZXZlck9wZXJhdG9yLDExLDE7UG9zdERvY1BhcnNlck9w
 ZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG
 9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9z
 dFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbn
 Nwb3J0V3JpdGVyUHJvZHVjZXIsMjAsNw=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 3061
X-MS-Exchange-Forest-EmailMessageHash: 35AF81FD
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> Adjust the IP passed to `emit_patch` so it calculates the correct offset
> for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
> Otherwise we will skip some instructions and most likely crash.
>
> Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
> Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@=
gmail.com/
> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a7ba8e178645..09f7dc9d4d65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *i=
p)
>
>  static int emit_rsb_call(u8 **pprog, void *func, void *ip)
>  {
> +       void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       x86_call_depth_emit_accounting(pprog, func);
> -       return emit_patch(pprog, func, ip, 0xE8);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);

Why not just
ip +=3D x86_call_depth_emit_accounting(pprog, func);

?

> +       return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
>  static int emit_jump(u8 **pprog, void *func, void *ip)
> --
> 2.44.0
>

X-sender: <linux-kernel+bounces-125445-steffen.klassert=3Dcunet.com@vger.ke=
rnel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAtpHp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBsAAAAi4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 15923
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:27:17 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:27:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id A01F52032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:27:17 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3774IfGRhS4 for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:27:13 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
75.80.249; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-kernel+bounces-=
125445-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klass=
ert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com AC91D200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3D02OONrK"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id AC91D200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB71F24381
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5013CAAE;
	Fri, 29 Mar 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3D02OONrK"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221=
54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E138FAD;
	Fri, 29 Mar 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
85.221.54
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711747613; cv=3Dne; b=3DhT6rBlhYRPp3nILeYSgLH5jgw3/ahNcI+sDsQW7a6Oq02j3=
c5prNzS0n5vJx9TVbZQcqIgvdV9HTstLuoPtW/jT0vcYIvofBPyJUl7qtv3N1ZcCALaUGLdrgZB=
APv1JUH+kyrmT9ybQHjLzeMASpgNwI0hFSXpPucdmpDSanwARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711747613; c=3Dlaxed/simple;
	bh=3D2kYFst4z/jzDluAZKuRs3VnNLG/lJw8nm0VcFYikM=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DWQ2A0CseIsL9FgYjN6zPufVIpQqiRzxpxfWWir2S2bRrkalHe=
IYKni2SW9MnB9+iKThkvwKO+Zn5Zssl7qqHveQk51ff9EJpUn5NhPHVmY4QJ0TF4i9BP87FJsd1=
aA9g47SAdGsUrEEJEsLIDX4ANMZG8S1Gjnd1qw8tZdsRMARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D2OONrK; arc=3Dne smtp.client-ip 9=
85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341c9926f98=
so1441462f8f.1;
        Fri, 29 Mar 2024 14:26:51 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711747610; x=1712352410; darn=3Der.kernel=
org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=3D=0A=
        b=3D2OONrKn+4k88m3UEDllV8o8JUuB2NguuTGHZzCXHNiOAa9yBQIiaGmfQsGVV86q=
3
         vwTm5pN9qCEJWhO3/1dihonK9iCD1MV6zVd13EikzldfB4dxhYg+3Wg6vO0czEsr1H=
Ac
         Xnut8+4zSVKD/nOdEua3WuEO6t2FYuiIILMfvrA145eDAhyL+bLHHiztPM0IEukc3e=
MT
         QwkIybVK8O22yg5D4IKFhCt9QnTfLrqtSCdTICpGqqxHghVj4Ift5u/IfjSrR2EkEV=
Ne
         CwHVBQEan1clULUfxVR4imy+rZpP4IILFDkrBGL8rfHg7ZbgGF/FY9ZH05/vNFFyN9=
i4
         L+ZQ=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711747610; x=1712352410;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dv9NiziDyCYu9Ssy1MqwcYz3Obg+5qR7kJAYV5rLhc=3D=0A=
        b=3Dml1tLtFlyP9+6qzsr/Y/Kp5igFrK2oUC/WIz//Zmu/5fSRzhVpw37aRWeKK6hdX=
/
         FxsJBUEiOwP7rnH9cVh0eWtHbz2qaashwfXDE6sVeXzEDIGZGpGu23nNdVQXdmSsPo=
ym
         +exTdbi8fY0pCW6bB8Bl9QHeCnAfsqlPKJyaAjnrOHw5Qw9qdI1S9gC2eq0WbnVy6i=
HQ
         7tLKPnU50UXa4ii7btWPm2rqB3S45MtzAeOOLaaKgubovEhMNhC+usRZ5ijfKdVYpI=
hu
         bTcuciA022kGsoViz3poqnsJ0p8W9ojwHusnFV0FwDvrqrw9MTAV+LH+DM//g3kcby=
jr
         T4ig=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCUms6Y8mQXobn6Doc4LggzSXZfoQDIm/IKPAkO+/bg=
Lih/BXEZjjKJJx2V38SsUeCaJy1R/1BisLsDktGAF092Q8+cQmdOHd3i65roTYjtnFDPo2/M4Zl=
O8bb6wJr5fOR5UJWeLxlciGCxFLtE/mIj3WRxJMuCKajUX
X-Gm-Message-State: AOJu0YwDLEfVDuSKNNImIfCehbMu01XecTBUg/BxEe3Dr2BLV02Sld8=
L
	HnQdjTLXkZXA3IHu11Z7n/x+G0xL6V5UIl2p3WAyQ6nodkCzPQbShE13cVc4xK07Mw0KAcUpPf=
T
	hd4UbQzqEaNrmK52fddVQ5NxZI1IX-Google-Smtp-Source: AGHT+IEhPG1B/8mDvGNpkDj4=
PWCUpLjQ708pGc8G6bha6o2gM1Lwf8UNLZI5EJ57kTgt1wZPIajCKtTg1SeDSsMj41AX-Receiv=
ed: by 2002:a05:6000:24a:b0:33e:4238:8615 with SMTP id
 m10-20020a056000024a00b0033e42388615mr1774070wrz.40.1711747609718; Fri, 29
 Mar 2024 14:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.1814=
7-2-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-2-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:26:38 -0700
Message-ID: <CAADnVQLZnkm8psPvmUOS1FDacXdJPxQ79rQJ33F00dkS9czw1Q@mail.gmail=
com>
Subject: Re: [PATCH RESEND bpf 1/2] x86/bpf: Fix IP after emitting call dep=
th accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kern=
el.org>,=20
	=3DTF-8?Q?Joan_Bruguera_Mic=C3=B3?=3Doanbrugueram@gmail.com>,=20
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net=
>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125445-steffen.klassert=3Dcunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:27:17.6856
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: cbecf88b-6e62-4b3a-91cd-08dc=
5037029a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D424|SMR=3D371(SMRDE=3D050|SMRC=3D320(SMRCL=3D=
102|X-SMRCR=3D320))|CAT=3D051(CATOS=3D011
 (CATSM=3D011(CATSM-Malware
 Agent=3D010))|CATRESL=3D020(CATRESLP2R=3D001)|CATORES=3D018
 (CATRS=3D018(CATRS-Index Routing Agent=3D017)));2024-03-29T21:27:18.099Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10057
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-02.secunet.de:TOTA=
L-FE=3D007|SMR=3D007(SMRPI=3D005(SMRPI-FrontendProxyAgent=3D005))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAWoEAAAPAAADH4sIAAAAAAAEAJVU227b=
RhAd6i5Zkls3Rd
 GXYpAnX3Q3fZHqpLYTF3Vhw0GStkBf5BW5ktaiSHa5iu1egP5RH/rY
 x/5Jv6SzS8o24MhOhAU1mjlz5szMUv+Uz3z8VooanjKJnW4NO62OjU
 xhp2d3//vzr4NT/EEGER6KXy/YBPdmA2Psj6ZMeA0nmD7HSxko3quU
 ntMhrmDaw+8D5uOhnI1mXDI8Fc6/f+PeBTkHiW96hyDJPHAvZpFCNe
 Z4/ApDFkXcRRXgOZ8K1Q+ZcsbnGAUoFDrMc2YeUzwycCeQkjsKg+Ew
 4kpzDQNpIi8OTk5Q+JGSM0eJwEcxxPOr3e0+MXh9l4dq3Df0zHGCma
 +EPzpH7YiI1OUNzXVGRPJSRBwv6QjPw2giQlIy5XepI2S+i9OAWvDE
 hHvX6EgWjRvzuYgrHvVw0OFdd8i37AG3cfUpSWkOwmEPj6ZxWx4aUX
 irR0uW/JeZkNx9uqapToQ/6eFYqTDqNZteIHljwqXPvUYgR01vMvWa
 tMTNVru11Wnb3U6n0dlq2Tub9XZ9wQqamvaNGPncrdMQ64Prj18hvn
 B6eODxKy7wjWIyeBcIFbzDPRap/Vt9N9CXzBfcw8NATqbM93HPNY59
 EYw4k4PgquFzZdD1el1/IZPOuKknRgE9tf4FLY6qhw0Hf8ct3NjYSJ
 BtHAqP7sWY+SPu1nBTL4pLs6bVjTW65DRmj8e/62vJilwxHFKxEW2C
 NR8qNngoqpmE7/IrZDsDtsvbO7vb9laj0eoOd1yn69ru9ha2W61t20
 6ae7iaBlFnjxfd38e6vdOtdXFDf7Vb2hMppoRDgpS51uber852cX09
 DGUwqiFtycX14cx35rYI5wO5ly2jwYczIP5mtGP8iUPMvOTc7Yvwa4
 NJPmev3h6fHv989Lr/3fHLo/6PB69XNeOaAdUT0MMv7mqi536e5Gom
 fbz9H7kLraEIa9i6OtqNk+Z67yjFZ4ShwMfVr5R+Gl+jHyjURJWSpn
 j20Rzf6MetqkdauSP6bk/4x6KNXsym4YdtM361Og3bbrQMW6UEkIJ0
 GrJpC8p0IJOCTAayKSudB8hDgewcFPIWfAqFLOQImYVKBnLkL0CRjI
 oFX0DVhJZykE9rhjQZmseCksaTnaZTgiWKEmcOSmSkTaElKBOSqn9l
 fmYNcwnKxigWoUSJ5IlPGSpxFvGTDGIuw7KhSgCURVUopQBV0pa14D
 RpIR8nVmGZbAtSlURzIWdBJZGdeV9TBfJTyhKVtqBq7BtnAUqU/gTy
 Rd3RJ5Qe95U2k4wrWhaNASyrrJ+QIk/eKsZ2yVqOjSJ8ljEaYsB7SC
 C1OKS7LkO1bFVyADmoLkYWF4YsmhKVzxqpqdhO6buRS0ZHyWbCKbNQ
 cwH0Sc2XntFjzMZs9zCf07NgwRIUU7BMIlaglEnAK/dWv2RyV4h2fn
 9yMZtZ0MqcR1dZkHtzuygltwDz5X3+OTOBnzzStVWJB6VHZKW1/T+V
 3ePHhQkAAAEKnwQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPS
 J1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4w
 LjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YX
 J0SW5kZXg9IjQ1Ij4NCiAgICAgIDxFbWFpbFN0cmluZz51Yml6amFr
 QGdtYWlsLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCi
 AgICA8RW1haWwgU3RhcnRJbmRleD0iMTAzIj4NCiAgICAgIDxFbWFp
 bFN0cmluZz5qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNvbTwvRW1haWxTdH
 Jpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRl
 eD0iNjA1IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3
 RyaW5nPmFzdEBrZXJuZWwub3JnPC9FbWFpbFN0cmluZz4NCiAgICA8
 L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI2NDUiIFBvc2
 l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+ZGFuaWVs
 QGlvZ2VhcmJveC5uZXQ8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haW
 w+DQogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BC6ACPD94bWwgdmVy
 c2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8VXJsU2V0Pg
 0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPFVybHM+
 DQogICAgPFVybCBTdGFydEluZGV4PSI0MzciIFBvc2l0aW9uPSJPdG
 hlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdHJpbmc+aHR0cHM6
 Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDEwNTIxNDkyMi4yNT
 A0NzMtMS1qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNvbS88L1VybFN0cmlu
 Zz4NCiAgICA8L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQzjBj
 w/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0K
 PENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW
 9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRl
 eD0iMzIiPg0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIzMiI+DQ
 ogICAgICAgIDxQZXJzb25TdHJpbmc+VXJvcyBCaXpqYWs8L1BlcnNv
 blN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz
 4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjQ1Ij4NCiAgICAg
 ICAgICA8RW1haWxTdHJpbmc+dWJpempha0BnbWFpbC5jb208L0VtYW
 lsU3RyaW5nPg0KICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFp
 bHM+DQogICAgICA8Q29udGFjdFN0cmluZz5Vcm9zIEJpemphayAmbH
 Q7dWJpempha0BnbWFpbC5jb208L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjgzIj
 4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iODMiPg0KICAgICAg
 ICA8UGVyc29uU3RyaW5nPkpvYW4gQnJ1Z3VlcmE8L1BlcnNvblN0cm
 luZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAg
 ICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjEwMyI+DQogICAgICAgIC
 AgPEVtYWlsU3RyaW5nPmpvYW5icnVndWVyYW1AZ21haWwuY29tPC9F
 bWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW
 1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+Sm9hbiBCcnVndWVy
 YSBNaWPDsyAmbHQ7am9hbmJydWd1ZXJhbUBnbWFpbC5jb208L0Nvbn
 RhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICA8L0NvbnRhY3Rz
 Pg0KPC9Db250YWN0U2V0PgEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMC
 wxO1JldHJpZXZlck9wZXJhdG9yLDExLDE7UG9zdERvY1BhcnNlck9w
 ZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG
 9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9z
 dFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbn
 Nwb3J0V3JpdGVyUHJvZHVjZXIsMjAsNw=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 3061
X-MS-Exchange-Forest-EmailMessageHash: 35AF81FD
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> Adjust the IP passed to `emit_patch` so it calculates the correct offset
> for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
> Otherwise we will skip some instructions and most likely crash.
>
> Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
> Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@=
gmail.com/
> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a7ba8e178645..09f7dc9d4d65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -479,9 +479,10 @@ static int emit_call(u8 **pprog, void *func, void *i=
p)
>
>  static int emit_rsb_call(u8 **pprog, void *func, void *ip)
>  {
> +       void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       x86_call_depth_emit_accounting(pprog, func);
> -       return emit_patch(pprog, func, ip, 0xE8);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);

Why not just
ip +=3D x86_call_depth_emit_accounting(pprog, func);

?

> +       return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
>  static int emit_jump(u8 **pprog, void *func, void *ip)
> --
> 2.44.0
>


