Return-Path: <linux-kernel+bounces-104698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A787D287
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8816B28375B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAD47A67;
	Fri, 15 Mar 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPEZYIRn"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1945BE7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522755; cv=none; b=Y09bCeL/DtrwGnokKoOalR0/IdGDFNnPuD5hIiVD1V1MQFN/7W/W5Bt3E5IgCddlcgzAqSFauQPqbtXSdgu7Bt3hrNE6iFfqBojP/yLue9e7jH5X/twaEsucBhcVhOTaacURiirxiOIktN4fsSwXc5RqWJiBsdiXC22dBhQk3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522755; c=relaxed/simple;
	bh=kWzlo4AaZeWtEkzCy8TJZmtsYDqVVCm/XwSPAebW3DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEqnblwugt/GmqB/szBEZYl6Lh5nzKPFJRA0+fIavpv5dOEwbDXTcDh5Ow+1J3hvrTmolgGzeoBRO71uOmcpHswRhieo5s96KRGkNjVz5hkybCjPtIGhnuDgOzbcnxSn3Ic3/WYTXdaTd+4AM0V8NmHNS4CKGegK8V94eNbE+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gPEZYIRn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6914101079eso16183876d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710522750; x=1711127550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBgzsheMyMt2wDXPPT0VYLjrPGEmgjQ97XLNs9yUYLg=;
        b=gPEZYIRn5TOzx0CD9MhYMJE8IegTBXts89PPitzmyLGrdBw75k3GCrAzWUGDbcNl8Q
         B8hQLWkxemwXLOOcU8SfGLnzXI3KlCe5CUUcVMGE8cMvskTEkEJRNCLPMKZSTqOtMgRc
         scBeMdTNyeGA6jWvK7rI/aQCeIEXtzS4emclA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522750; x=1711127550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBgzsheMyMt2wDXPPT0VYLjrPGEmgjQ97XLNs9yUYLg=;
        b=DHQ+KcxgNmVCqMzLpvqg0FgLUykDtVZXwf0uFai67iInzQBg+fNqJq+5JVMY6r+rJc
         tcpNHez2RwbOko0ZOL0gbjsk1JxW8p+aGj/GTwqRSy3S2VsQCgeP/p0mBnBdDFV71N3Y
         +eMKGSd22NvXUQu05AxZ67b4X5JHyncl6GlMkC1aXi/MZ7ErOA7xwhqBmqEV8CFF+cvs
         FhZK/RHJkeBV/YttH4yi1LNqmfFWz31/7jF08H+DShvCcdCrWZKlIWQuLfxQrMfcUfVd
         i8dz9gtYXw4/GDzl382PhPYZsrlOmECt3sJ3dXRBivyU/Ou2Woj4X4fPi8hT26TvMMj9
         /0nA==
X-Forwarded-Encrypted: i=1; AJvYcCVbpfQGxoSC2u7UCvV8oPq1a7U6xLVlRf3uMcHq47CnTBa22wshi/ceopPJokAS/oCKeQnI8bnJMnekznsJqxnkAeeb3sT6K0Oopuv0
X-Gm-Message-State: AOJu0Yx4EUocCicjczJTq+DMAJGP0OvDCpnW3INcT79RO9blOAh4hi1/
	oXNmjTdmppw8uPl3asuBfl733Q4KTf1eXjWzZG6KDM42djFZRzaL9nLz4IZLteKBI4cGmqXAPbc
	=
X-Google-Smtp-Source: AGHT+IFMKEktyqxgPuphVdBObAtojMqpAe0CA5/Fn9r/rzIpJQzRmnOYGZgv6qsqotQ8jMF3ikOaXg==
X-Received: by 2002:a0c:f2cf:0:b0:691:8552:fd0a with SMTP id c15-20020a0cf2cf000000b006918552fd0amr1050912qvm.60.1710522749691;
        Fri, 15 Mar 2024 10:12:29 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ca00b00690d43db164sm2230674qve.44.2024.03.15.10.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:12:29 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee0c326e8so9491cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:12:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxnthlet3MCssOI0FndR25JdtOZ551MuotUMRnArmBgdPu+jFGbLcxZh2REYz+CZh+0h3BTcHTxa69Bg5KuVzsEymoVDCc9YZxwKQx
X-Received: by 2002:a05:622a:1706:b0:42f:a3c:2d53 with SMTP id
 h6-20020a05622a170600b0042f0a3c2d53mr822108qtk.20.1710522747755; Fri, 15 Mar
 2024 10:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com> <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
 <20240315152431.sckqhc6ri63blf2g@bogus>
In-Reply-To: <20240315152431.sckqhc6ri63blf2g@bogus>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Mar 2024 10:12:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
Message-ID: <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org, ulf.hansson@linaro.org, 
	swboyd@chromium.org, wingers@google.com, daniel.lezcano@linaro.org, 
	rafael@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jwerner@chromium.org, 
	quic_lsrao@quicinc.com, quic_rjendra@quicinc.com, devicetree@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 15, 2024 at 8:24=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Mar 14, 2024 at 04:20:59PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc=
com> wrote:
> > >
> > > Add power-domains for cpuidle states to use psci os-initiated idle st=
ates.
> > >
> > > Cc: devicetree@vger.kernel.org
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-----=
--
> > >  1 file changed, 73 insertions(+), 25 deletions(-)
> >
> > FWIW, I dug up an old sc7280-herobrine board to test some other change
> > and found it no longer booted. :( I bisected it and this is the change
> > that breaks it. Specifically, I can make mainline boot with:
> >
> > git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> > domain-idle-states for cluster sleep
> > git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> > power-domains for cpuidle states
> >
>
> IIRC, this could be issue with psci firmware. There were some known
> issues which were discussed few years back but I am not aware of the
> details and if/how it is applicable here.
>
> Not sure if you are getting any logs during the boot, if you do have
> worth look at logs related to PSCI/OSI/Idle/...

Given that the new firmware fixes it I'm going to say it's not worth
looking into any longer.

-Doug

