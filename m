Return-Path: <linux-kernel+bounces-126270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB4893481
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096911F21A1A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68815ECC5;
	Sun, 31 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h02OONrK"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900915E5DD;
	Sun, 31 Mar 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903421; cv=pass; b=aR8K6VZ9ZMgdTBXB/7901zkzwKiECp5aP1e+Y83uz34h09R09sCyJueTBOa3opSsbFA9tCd6BTYB/FgBD2X/mTkH88PRNJjkxLPywvbAG/l6SPJM3bFhOrJ+jn0VG62etzJaCs996PAb5jVUR0XQSi0VguA4hHb14EXZ80klaag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903421; c=relaxed/simple;
	bh=GY2kYFst4z/jzDluAZKuRs3VnNLG/lJw8nm0VcFYikM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLDRIWY5SW5f4KShKZE1ZxzjB4AT7CRR8qYlFGWyh2uzrmbM4OApbKuzwVC1AzjJV5+u2Rfn/Gkt6VDw85Lo5uMcnwURgGh5417R6HgeVD4tBq1B5hB6eQGocRlOcXBZQgdy/V68cCs10ETQzgb2xMWXyKKsIod1bzGDP0WPHTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h02OONrK; arc=none smtp.client-ip=209.85.221.54; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3BFE3208B8;
	Sun, 31 Mar 2024 18:43:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtO42jLyj0i9; Sun, 31 Mar 2024 18:43:37 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E4BEE208C7;
	Sun, 31 Mar 2024 18:43:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E4BEE208C7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id D61C4800060;
	Sun, 31 Mar 2024 18:43:34 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:34 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:41 +0000
X-sender: <netdev+bounces-83464-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAdkemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 10456
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


