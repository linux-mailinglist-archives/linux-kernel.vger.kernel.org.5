Return-Path: <linux-kernel+bounces-107778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFA88018C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944F7B2251D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1481AD5;
	Tue, 19 Mar 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACZj6wQt"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC481AC4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864658; cv=none; b=JmtFwzThhIM3MPi261e9mMlFXslXLQ+FL6A3PO8xSMNKehRYUedq17Ski7IMrmy9a1mKTp46pkCmKI7B6nPO6234Qwg/NQ4dQNpD0J42Off08r0DQAmlXa4YoQoEuyYl9D8tCEKX+CDHsHxOg0NrnazxCNS2zaowOW6TnFyEWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864658; c=relaxed/simple;
	bh=fKSF8pzEMf4QAy0lGBTclAV9vz3vznJXW70/aPT4oU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwwQYxm50+OT0Vt2Y1IsHwCSOlHxpfO2fAgP5BXLLMLRbXPLcjZQ970R3Xnip5KuujJNt18xeg32ZUCRaL0UmkScsPBNDjojLGTWc7qIzW/JyHTnGtIGrnm4C+BE3ehdLk8Xj3tJ0dJP/vK+GDMmdE7A1v4EEYyEFnDdlryXkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACZj6wQt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789e70d7c07so255385285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864655; x=1711469455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=ACZj6wQtlMqTdVwXJum25tZRyuTmVxudPJltxtfEhZK9w65jlcpxig4KYeJUtoeFgF
         fLS4tnuZt17nLYG13RJlYstBIryk1v/GM8GEHTpV9O2sAObgfcpkOuSh/aITtaDYXGLt
         pGFCXiWp+qujniZRuX4XcsKVxNgWy5auPjltg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864655; x=1711469455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=GY1yVTFYCNhCxW62v1hp6nQiU6B2PTg2bgjrNDnAU6J/UENnrNInaPtBZkfPhMX/ya
         Y1LB3URTFPDR+t3RxOzY+SnHqZ7Md4u6QBuyMOLXI7ogStkjuj78vJNx02euTkrj0Fdi
         F/cudR3Mz11pgbnFpJwVmBgB7UdOvmt8cE94rWsnCJCOb5x9rQsKk+jsbI+bcE0Zrwoa
         TJqNGz3DYubBNlDX7/yhh38U62aqv5i5de+/m/Z+HuZ/6Of1qfnoajP5gtwaGBDNU+OJ
         ZgJEm72vh5nvCJyLtDLAlsBEdGm6r78HqevZln0EWEe8dqz0WX1l1LUWaheeM5Grv38D
         Bm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVridadjaSZl74B8T+1KK+hU3lJWgg4o/kKE/iJiUUvcU+w+f0xRsnWeE4pcXCGrncZCO69YpIl8GnqMX3r8AWYfqaA5JCnmvbSdRgD
X-Gm-Message-State: AOJu0YxYFSaZ4lBo24P4Z8/zLofMKY6+bq7F/ov6Uo+u8gz0HNXAOq6U
	5NuUcvk0FS4EAVHTlEPvesAm5KNA1cZJdS0T3SQJ1pMH5YjvMzHITWlDv2Tr4rOFNtNcSTztqAM
	=
X-Google-Smtp-Source: AGHT+IHKYlZiNRL1ZFCvEZyL1iRURNKa7zBqw+RdqZJj9ETKODTvRU7plpiQ3VBhlMVxzzUmmB0D1Q==
X-Received: by 2002:ae9:e01a:0:b0:788:2e94:ead8 with SMTP id m26-20020ae9e01a000000b007882e94ead8mr15640298qkk.42.1710864655112;
        Tue, 19 Mar 2024 09:10:55 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id h9-20020a37de09000000b0078a0bfaec5bsm1162894qkj.51.2024.03.19.09.10.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430e1e06e75so435071cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLh8d7WnS7Fbx4wywio9ZndyrO1W418hVyv6QVfv/G7OWd9HK6Cxu643QdhwkNCVmiVFcq0m5MvxkR7G31RNWHLudUnwnTm8B5wS7y
X-Received: by 2002:a05:622a:1648:b0:430:e26f:4bfb with SMTP id
 y8-20020a05622a164800b00430e26f4bfbmr262803qtj.19.1710864653792; Tue, 19 Mar
 2024 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-4-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in big-endian order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
>
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in little-endian order).
>
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
>
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in big-endian order.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Personally, I'd prefer it if you didn't break bisectability with your
series. As it is, if someone applies just the first 3 patches they'll
end up with broken Bluetooth.

IMO the order should be:
1. Binding (currently patch #1)
2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
3. Bluetooth subsystem patch handling the quirk (currently patch #2)
4. Qualcomm change to fix the endianness and handle the quirk squashed
into 1 patch (currently patch #3 + #4)

..and the patch that changes the Qualcomm driver should make it
obvious that it depends on the trogdor DT patch in the change
description.

With patches #3 and #4 combined, feel free to add my Reviewed-by tag
as both patches look fine to me.

-Doug

