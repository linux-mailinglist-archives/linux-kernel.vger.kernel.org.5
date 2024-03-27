Return-Path: <linux-kernel+bounces-120778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923088DCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA10D1F2A4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366612CDA3;
	Wed, 27 Mar 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O/l9iLdp"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105F12CD80
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540530; cv=none; b=AgH2M/UCavrOljV2dWXCsaZPsq8Bf1GVavPbQrCmGftJXRkUz+3b+YFoL3Filbv/VB9kL439e04XYh/zHX+xKiDJdjFfQ4YYIVEANCznvinIEDl2t06Q5gVnbdu1n/+f566e71euV0BNxrQDnnA82+i3RO2J3wpLM4BVxwCU1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540530; c=relaxed/simple;
	bh=/6DQtZIdINr8Zz1d3DyYjqg0d/ubRVDgVQg0j3uAYiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzXYI0l9W4gqCinixjXsYaccP3Qj5TYmfZmDr52O1AnQFuzh0Db9X+91iqXtunnUb4B+vHY5+whW1kMf4LRpdy03OmI3vtoWC3huDxOlXkoxQN7+UkxLpnCxGsXef5uiqgQB1maAxWQYtLpXOmrh1KL9CS+rg2c2MsbaAFSpg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O/l9iLdp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so6688840276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711540528; x=1712145328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J224BoJrNGTFOuXukBbi0+FhCHvvUryxq1OLTe+bDRo=;
        b=O/l9iLdprY8DKqXUICPibg6TFlSI5nbulyH6sotWmU9qRBZn3p6aZuw55fDhCecg5+
         7MCzO0FNFmQkp4LZwSfe/CkNu0Ws//seNjwQ3KoWiAgk813YkzMCWXnWhGuIWu50/s9u
         VCF6zi0Y2ED/Vy8PKDH90QXdqBh4OSip8s5Z5TqPAGmxl2ElAP9P7EPZml+bM5BrDuxi
         hRk1YXmzp3ggQ18DjnwNogcfM75ZDG1H8M4RtulhqTXGNPX9AwNUr+LUtEWzvoBdX6Nn
         tVHp0jG6FGZqLSAska3l5qcGIGW86HoIx8hHhpKn6tyex8ZkE1UBz4m60l8q7ahtwGcj
         fWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540528; x=1712145328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J224BoJrNGTFOuXukBbi0+FhCHvvUryxq1OLTe+bDRo=;
        b=rsZ1L4ijiIVGoQC+2U/d6B9T5sLMKloMFD2yHXR+bDxA9ksRQh0p2B4Vg20TehFvsW
         kc2CzWokXcVn103axlfsFg9vfBEc9OcmtkeKpEdIH0gnIyHV9Ag/IgEdVRFHpQv2pYm+
         OzxMpVNSigC4QBjRilyJB9AWc7kMtOIN0mq3zMXVKB5PVp1Vm/+bclTK+dsOuayvWLF9
         tCUTXqsT5AOEQnpR6CT1RLd1hop1fsdhZe4GkQhaoC8QgWBB5EZp8x5Sxeg5puPanIOH
         3RBtaGPfalzJbEyxutyLtjCINWfNVChTYNADNvCiA+0SaAz9ZrNKhEn3IwmArvu17Qg4
         h3lw==
X-Forwarded-Encrypted: i=1; AJvYcCV9oazfrvGZ07FiegLkUzgbSIzaOEVf323vICDwVFMNjWa5yYhb0Senqe7EWIxVoalbbKvUJ1WDYlxDwEk4E3EHOa/YSy5LWhJGNRul
X-Gm-Message-State: AOJu0Yw8OAtZVxDDEEQ3sjQYbNjM98E8t5b9bthZXDsubnF5ZfYc78hp
	dVOgWYPuEt/quO2NXZnS/itTlMRcdpz62pncIn+5VSc4LsYBZfAtDbiCA8wGkCAtpYMx2lTkSL1
	UpwKNyGcAXIdVEyaCOtz8WHtXrIAI5H92+X+mvg==
X-Google-Smtp-Source: AGHT+IFgg8nhk4AaTwEdQScNnj0lCNbPtx/6BKknBGcKv6QaXtQ3UUhwr0ao7SYZYJqXqXdru/t/sWxXHWLNFIXrVzM=
X-Received: by 2002:a25:144:0:b0:dcc:417f:a85c with SMTP id
 65-20020a250144000000b00dcc417fa85cmr2285561ybb.50.1711540527892; Wed, 27 Mar
 2024 04:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
 <20240327055732.28198-3-yu-chang.lee@mediatek.com> <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org> <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org> <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org> <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
 <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
In-Reply-To: <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Wed, 27 Mar 2024 12:55:16 +0100
Message-ID: <CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	=?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <yu-chang.lee@mediatek.com>
Cc: =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	=?UTF-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yu-chang Lee,

SMI LARB must have a power domain, according to "mediatek,smi-larb.yaml"
Now you try to create a link from power domain to larb.

Here is my understanding: when you enable/disable power domain, the
larb linked to this power domain may have an issue. Then you want to
retrieve de LARB linked to the power domain though the dts to manage
the LARB. IMHO, using the dts to have this information into the power
driver isn't necessary and may introduce some bugs if the LARB node
and power node in the DTS aren't aligned.

It seems not implemented today but during the LARB probe, it should
"subscribe" to the linked power domain. Then, when the power domain
status is changing, it is able to "notify" (callback) the LARB, then
implement the good stuff to handle this power domain status change
into LARB driver.

Regards,
Alexandre

On Wed, Mar 27, 2024 at 12:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/03/2024 11:56, Yu-chang Lee (=E6=9D=8E=E7=A6=B9=E7=92=8B) wrote:
> > On Wed, 2024-03-27 at 11:43 +0100, Krzysztof Kozlowski wrote:
> >>
> >> External email : Please do not click links or open attachments until
> >> you have verified the sender or the content.
> >>  On 27/03/2024 11:39, Yu-chang Lee (=E6=9D=8E=E7=A6=B9=E7=92=8B) wrote=
:
> >>>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I will double check the format of yaml for the next version,
> >> sorry
> >>>> for
> >>>>> inconvenience. But I did test it on mt8188 chromebook, the reason
> >>>> why
> >>>>
> >>>> How do you test a binding on chromebook?
> >>>>
> >>>>> power domain need larb node is that when mtcmos power on, signal
> >>>> glitch
> >>>>> may produce. Power domain driver must reset larb when this happen
> >>>> to
> >>>>> prevent dummy transaction on bus. That why I need larb node in
> >> dts.
> >>>>
> >>>> No one talks here about larb node...
> >>>
> >>> Sorry, May you elaborate on what information I need to provide to
> >> you
> >>> or it is just a syntax problem I need to fix?
> >>
> >> Please explain the purpose of this property (how is it going to be
> >> used by drivers)and what does it represent.
> >>
> >
> > It represent SMI LARB(Local ARBitration). In power domain driver when
> > power on power domain, It need to reset LARB to prevent potential power
> > glitch which may cause dummy transaction on bus. Without taking care of
> > this issue it often leads to camera hang in stress test.
>
> That sounds rather like missing resets... or something else connecting
> these devices. Maybe the explanation is just imprecise...
>
> Best regards,
> Krzysztof
>
>

