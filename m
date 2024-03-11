Return-Path: <linux-kernel+bounces-98429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934F8779F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E61C20BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4D1C33;
	Mon, 11 Mar 2024 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1bYAQ2X"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91C1388;
	Mon, 11 Mar 2024 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710127102; cv=none; b=Dy254naKTalMr+3jBi/SVZNySwFq1vMh0ZicgYHhV/2niskIfjMRd2Tm4Gnl/bYi7/yqD1GM5UFQO+xQ+O6oDV6rh+V2tfBtUnn4zI+RLWmnQDZg8VsR0PP4GD1JdIjiYN2Hb0DuAdgjEP4md9ftR808RUIEzafLffc1lovCTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710127102; c=relaxed/simple;
	bh=Em8q5RFNMQ3hda8XWlTWLtBXuFZmesQeXsLND0FJqDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F33Fbu/+yXPse8p/R6gjLe8isaKyUq/UZ5gDe3vglY+69Z+3yrDq4etBzLXovEvg/OZ4g19SExDvbWZiunEVmBd80FdMAtsgkjUV57F8zMK0zPeCNe6TmYq4+xfg4UHvR6PowAyNA64owclcafWSK591kGy7ydXBBedS97+7LqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1bYAQ2X; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c24ef5eebfso95649b6e.2;
        Sun, 10 Mar 2024 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710127100; x=1710731900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em8q5RFNMQ3hda8XWlTWLtBXuFZmesQeXsLND0FJqDY=;
        b=A1bYAQ2XkB2zNgCFonma189WkZwSvkwAsMuYFBfcf9656sejGSJPUSj0aJsrinsGQH
         nmJjfRUQh+tUC5Jx5DqcZGW87HTwEYT8RgWdKxTDZBf6eTkbUC/nBKsDyHyhZSCq5C4B
         B7Qe9+fd5S2qaigR3MFsreN3/Ksrv+Z0WAqa2RoKJDHtVXZVLYqwIMNxpMOgrLjIBn73
         tFHHh+wlZzAj2QSpbzhA3Ms0QVlwuHXwn1hpmf+T0cU9k6SQ86dNgLflX0DnntniwWG/
         e88GdVtqdxYfnMB+g9lGtBOnlrZSMzjyKR3NwItX41N1nMhiXAZPuiUe8TOrrAdnhrcc
         /7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710127100; x=1710731900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em8q5RFNMQ3hda8XWlTWLtBXuFZmesQeXsLND0FJqDY=;
        b=u4U9W4NDC6lm2aAHW70GlvdoJ+cKN/Ra7iGG2WE1zj4/WHOMlb4Ce9CC6Th+dT2Y0G
         c1vlZCvgN3iA3WwvFAT5izA/IGhHsj1HbX/JButXinF7Z3nbHDXmZ16ne56Cvi5kwBKD
         LKNfUJjVV89+4VqL+17Grn0Os+8nhhkEfWC6xjVmh5+S0qSRISuOQP2uPWOdyltWIX2I
         cvrjLMe1XrEuiHuW6/o/BnH7Qrq8ry9wj54ZDcjAl9o4ccnv9KsECzYBnEcXu8cb9Zv9
         r7kM+OQ6iZXN5z3+hzehoBmWsoP3/m/sHBD7WrlTDbayC8ftcbORHMaHh309KIyS2ZGo
         VKWg==
X-Forwarded-Encrypted: i=1; AJvYcCU310FNmPyEYtGdDtJcdnrbuZBQZ78RGEQhussLLFSgntVFt1xW1gGwE1/U4UWXvkPo7llSDnZVdK05VYYRD5UUcD9bnUyy7QU6Xx2eSn3EoYFLlnKxddu6IlzpHJduABmxTdMmWDa4pWM3oZ1fAixECobcbjmHGuB+ZYdFCZ5s+jinow==
X-Gm-Message-State: AOJu0Yzun7TfrYuB6vrxE4+jWFmH6qb9o+Yw4fu4G+MTu+PKUVfFVKCG
	inyu14Fp5VaTsYxcx5Kn7FjNxUHlR5e987wjepES+Cu8nE1Rwe0HY+YqCkTUWxph0J80iXDTogX
	vEdLHLl7HmoSba4FmK5XTKolcPNU=
X-Google-Smtp-Source: AGHT+IGLTUqIROvm8m6wXsl9zwO/j/F3Fa3Sgo6xcQW3OKxRChtqDuthLsnSF/AvubRnhFD8ANsiHgZrsBrclXYfj4s=
X-Received: by 2002:a05:6870:6592:b0:21e:8590:6a5 with SMTP id
 fp18-20020a056870659200b0021e859006a5mr6095394oab.2.1710127099715; Sun, 10
 Mar 2024 20:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
 <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org> <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
 <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org> <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
 <ba834984-d0d7-4b46-81f6-5a2df8e74944@linaro.org>
In-Reply-To: <ba834984-d0d7-4b46-81f6-5a2df8e74944@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 11 Mar 2024 08:48:15 +0530
Message-ID: <CAE3Oz8353cPXgZa3BhtjyfdFfu+XPUhHXf=qWxWQ7sbvVK7gcg@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:55=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> What changelog? Read carefully what I asked you few versions ago:
Below the sign off I have added changes done in all the versions
before and explained why imx51-pata was added.

> "Please explain the differences done during conversion in the commit
> msg. There was no imx51 compatible in the binding before."

""
Changes in v4:
- added fsl,imx31-pata in compatible property as enum
- imx31-pata was not listed in compatible in original txt binding
- adding imx31-pata in enum ensures the node compiles to imx31.dtsi
Changes in v3:
- added fsl,imx51-pata in compatible property as enum
- imx51-pata was not listed in compatible in original txt binding
- adding imx51-pata in enum ensures the node compiles to imx51.dtsi
- fsl,imx27-pata is added as a const to ensure it is present always
""
Aren't these lines enough for the said explanation?

Thanks & Regards
Animesh

