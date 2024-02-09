Return-Path: <linux-kernel+bounces-59750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10884FB37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEEB1C243A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5C7EF03;
	Fri,  9 Feb 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="1wmw+rAT"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D47EF06
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500564; cv=none; b=LZnekOPGjZopp9GsVjvetUyxRH/ST+z1U2Iz4LGUm6CTvBjN7Orl3K9p6VAcVfi71i/WZI3bN0WtJOa8gDQS5wsjUMVZa1v9co+BMuJQhcTcNx/Ci5Lafj8oD1uOspexzenSW+rfVFvO4I4QkIUWLPwLlRD/2T0hgxFOa8JbqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500564; c=relaxed/simple;
	bh=FSI1Mh4o+qY7S7xE+Fstp8ZeO0Mlv7Vtk+LUOdR9Vew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPU0oWdu5gsyer2+g/zDX/vNfOavx9r+gmy/lB4rhjlCMQ2rt0QW4uQSQl5DIPajgRX4C9V0WiMI/i9fsC/RwZBGTzoNZZuFqG+c7Wa+aMxFzfEteRzBxrikGMgKQHKNm2snjzbKId1tElAYh1Vjts6VrBF8yoygWheDKE0pbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=1wmw+rAT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ab4f89bdbso6666351cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707500562; x=1708105362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSI1Mh4o+qY7S7xE+Fstp8ZeO0Mlv7Vtk+LUOdR9Vew=;
        b=1wmw+rATn0KNTb3bd4OnSTya9a24l3zmY42EW3YbWxO2dkNRdhVmbsx7+K62pEuf7c
         AKJwPLRN4Okhp0lPxtCeFrs/R3E/Muhv8/3iKTIoQMwN2oTL5JgeVLF9kD+uMLGOw/bP
         tWB7gmPrFlQJDF2cw+TtxwKKf4IQjxLoH1yY6IPpQWFIeqxXNHLxMrVFTyf+HSWRY9oi
         c+SHyek5jSVZVcEQsUFMcyWjlPHrxEFoCEUswsFfXXx0PJ5R4J97GMRgcnoVMn+5fI6/
         KK3vI64VPNdIh14yIp0Cl4hzkpRTt7idcLF/CfPXITjxi9T9MAX2Yqg0h7zQLvkKntVu
         MQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707500562; x=1708105362;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSI1Mh4o+qY7S7xE+Fstp8ZeO0Mlv7Vtk+LUOdR9Vew=;
        b=AEStVWlYz65aB89YbnedsSSW399UBKpd845To84nALfo0Xd3pGxiKZDKY5An/0UUhx
         lF3gkP9qvKmh6QqcLtAYguAnKKKPKY6iF1o5rUB+pFYpM11MM5EW2M6gvg4EPY4hkGAh
         aEWqzrbZoC1J11+XXTbn7VXS7QQ+F0j7Mhem/P1i6/ythk1VclJiLR7TPe63EHYiClEe
         Ft4oS0k5EaIfuBcxe2lnEhBeDK51VAzwm/CYNr8FN5WrlY/u5iSvOdQV9+0p3dei8cCK
         Gr/y74dHIlcU66f+uoTuoXZ/6zYud0LXh1J2lRXHpEvjENrrZNcuoDvN/A1cWFvU+bNU
         SQkA==
X-Gm-Message-State: AOJu0YzW/MKIrW4dFfXTy9fZtFJpyWLaJXkO3P0L3PAV/rsJ2rllxDL2
	2cduIZY2qIgbsN/npl433bbti90UAhg072CaDUnSsi8zOjvb+ejEg1vkCRqF7As=
X-Google-Smtp-Source: AGHT+IHmBh5iGyCEJfUi2Zo6vP4G/rkkvhn03Pzi3seOf3VLPbXkuva3sgmIKrgDkFRCjZ0H9srz6A==
X-Received: by 2002:a05:622a:11cc:b0:42c:3ea0:a40f with SMTP id n12-20020a05622a11cc00b0042c3ea0a40fmr2471830qtk.66.1707500562015;
        Fri, 09 Feb 2024 09:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkxmuDBFPvaIvCT0HhBrPxrMoccTTlt4vbP+TS5e/V3k0mUjcTmaGGURinLon19Fv787nriGjJgTsRADMacJTUpgnPm8t936FneSjlTUdrO7bLNaoaFKts15rdhNjqRDfhZCQZ118zMIzsr8993YIbgw5Lh4IqzH6SE+Rb/UPN+RW1PF/qFiNGD3Edj38FmA+F4bVyUY3jRicrdKVJ8CWgU4274yfuc1dVCKWu84haQFXEbKcw1E43tGER06wRQZohjN9aAqvrJdmkmlbs0YFO39JZq8uI1QP451wzd/Or44y4SHopMJABzLR/iRwDLwJHIySXYhm/WqmMI+KsxX6isIEM3sRTSAlutJlx6bC91/5SbAFbTXbMtQUnheCH0l/r+PSGXwcFAC1N9OPabOuP21mqh5oevdZRnQ==
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id j18-20020ac84412000000b0042c3b08cc6csm879078qtn.71.2024.02.09.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:42:41 -0800 (PST)
Message-ID: <fccdc181727307f52a36f3bb621d6a4e192096da.camel@ndufresne.ca>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Devarsh Thakkar <devarsht@ti.com>, Brandon Brnich <b-brnich@ti.com>, 
	Nishanth Menon
	 <nm@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nas Chung
 <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Darren
 Etheridge <detheridge@ti.com>
Date: Fri, 09 Feb 2024 12:42:40 -0500
In-Reply-To: <ab029558-fc04-854e-1f97-785f5cec0681@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
	 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
	 <20240202125257.p4astjuxpzr5ltjs@dragster>
	 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
	 <20240202155813.szxvi7bfp5xh7rvw@babble>
	 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
	 <20240205141255.z5kybm42qld44tdz@portfolio>
	 <20240205192003.3qns6cxqurqnnj7c@udba0500997>
	 <ab029558-fc04-854e-1f97-785f5cec0681@ti.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 08 f=C3=A9vrier 2024 =C3=A0 11:52 +0530, Devarsh Thakkar a =C3=A9c=
rit=C2=A0:
> I think even with the approach selected in [1] i.e. referring the
> mmio-sram node using DT property, you can still use dynamic SRAM
> allocation.
> The driver can still allocate from global sram pool dynamically using
> of_gen_pool API as being explained here [3] i.e allocate when first
> instance is opened and free up later when no instances are running.
>=20
> But I agree with Nishanth's point too that we may not want to give all
> of SRAM to VPU. For e.g. on AM62A we have 64KiB SRAM and a 1080p
> use-case requires 48KiB and even higher for 4K so if there is another
> peripheral who is referring this sram node, then it may not get enough
> as VPU will hog the major chunk (or all) of it while it is running and
> this is where an optional property like sram-size will help to cap the
> max sram usage for VPU and so this helps especially on platforms with
> limited SRAM availability.
>=20
> As I understand, the sram size allocation is dependent on resolution and
> once programmed can't be changed until all instances of VPU are done,
> and we can't predict how many instances user will launch and with what
> resolutions.
>=20
> So here's the flow we had thought of some time back :
> 1) Define worst case sram size (per 4K use-case as I believe that's the
> max for CnM wave521c) as a macro in driver
>=20
> Then the condition for determining sram size to be allocated should be
> as below=C2=A0 :
>=20
> 2) When first instance of VPU is opened, allocate as per sram-size if
> sram-size property is specified.
>=20
> 3) If sram-size is not specified then :
> =C2=A0=C2=A0 -> Allocate as per worst case size macro defined in driver f=
rom sram
> pool,
> =C2=A0=C2=A0 -> If worst case size of SRAM > max SRAM size, then allocate
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max SRAM size
>=20
> 4). When all of the instances of VPU are closed, then free up all
> allocated SRAM.
>=20
> [3] :
> https://wiki.analog.com/resources/tools-software/linuxdsp/docs/linux-kern=
el-and-drivers/sram

Only issue here is that DT is not a use case configuration file. That DT
parameter is meant for HW that simply cannot be operated without it. This i=
s
also edgy, because it also means that it should only be used if that inform=
ation
is not static and vary unpredictably per SoC, which seems generally unlikel=
y.=C2=A0

The Wave5 IP *can* work without it, so it should resort to something more
dynamic. User configuration should be sorted out at the OS level.

Nicolas


