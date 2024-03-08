Return-Path: <linux-kernel+bounces-96581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D802875E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58810281CBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC84F200;
	Fri,  8 Mar 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb3e7Oss"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB74EB4F;
	Fri,  8 Mar 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882937; cv=none; b=Ai+ZbsPYdNrsbMk6dHyDtvMJJtD+8mv83Ql6W1CXBxLh5VMwVTjIEQz7gk8Var7SbS3Wr6zbvFlY+Lti9HAcUDDZk7luYUSmDmjHGJt/TrjxRqzMdww/yBkLPRBAo8Gp+Sv8z2q4+Q92tmzIC8gGm9Vi6xQ6EOP1byohehDlgvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882937; c=relaxed/simple;
	bh=MF4b4nducu9UpwkVQfVrHdqtUevThpbVwwUeQGdVqcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHLrQyLJQ6nCSunLY1aGEqZeeVfBmtNk6Mp94Z88g6/jS2JTFOTb+Cr73HMdsDvcEic41JnFNYwtdYgQYJUqSa1IW14g9Euf9hv2MQqpU6M7vdyyyaRkpPy9LKsfX/qvP5sx1ITLbgZFL5H+ltApPPHokzK4tR42Mo8u7JFmJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb3e7Oss; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c2138463ccso882603b6e.2;
        Thu, 07 Mar 2024 23:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709882934; x=1710487734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxA3nLt/slK6np8PAwN24d1fWlNcPVJNRrobVCunY/Y=;
        b=Lb3e7OssH+5YxMJ3idk3BHyvpIwrutvVJy1QcNelVS6M4Rpbxvm/mYuxpBsiVQ7fFP
         0O78RqufGktDReTaGSvZIKcGJGY0NXlvQZeoB4zkRERjzoHASTjQSfTibkvrvXbEpnhc
         Sd2CxJFfmxQyB450EKDJoZYWty6Hp8hRpz2p5FpHXiD0NULwwLvo5FaapMhyei7NmSX/
         m90ENRIWFUHurzBGttKbp2Y+jIS//l5zyQNNepIVNb+7I3PATIK2AKQ0QJyNgW6SlyKC
         d2nFmc0r67qA2st3iJvhzr56mp9tzKNIgpji00vg7fyTDxFRZp3ApKs8cC6alrH3Qoc6
         J3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882934; x=1710487734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxA3nLt/slK6np8PAwN24d1fWlNcPVJNRrobVCunY/Y=;
        b=ZcBqm6x2lN8/2bl4aelS9LTxXRfqG6rmoMXM8MfAnEkl664YHuh/g18dqH+Q2yuQbr
         XnhTIZ3g0l6nkafh2+GtvX/2T2kaYOHsPY7qCNARgNzNJJ1jTRM1vu4rOMpR0RnewtpM
         dOGughXZ6jciNZElVIOseqNPjOcGh+8SzZca6GPjommQKKbE6X0VLIQkdl06C4jZsfXN
         JJ0nSK9czoiqSRL21sHFggtSPW+Nb7h4nk6SZCVingz7jNdVy34kK8U5D85cUGWo6lUP
         kBZ/E88YCr5QIgUMu3onkYYduPe1kwBVVergLd5pPbAbL/j37cSCCMTkQ7FHBfVu6Row
         JEmw==
X-Forwarded-Encrypted: i=1; AJvYcCVtlXsj3dmziLcLmcIZa/5LdIfxY+BaHROuY6UN0bVdPpT9qwFUBloqY0xvQURbRyv6sFk6uxiuxFwifIforhqyJb9DiA1MSsQtb1K68XocHGJWDZe0YHHELgjBLlELuvdqTGqwIfh2WXuHAVeLnokgW3HtSS64g8wSN7erGZGM4tTHiCY=
X-Gm-Message-State: AOJu0YyIv9vT+D3lhYqwIUeweEAO0Qrsr5XWmBANqiM8boyuhC02P8fE
	LHsfbB/DwwQHD0O6xj+qy+KqxSFW1q+maH4232MKH8ZTZVN/1HxuZJmD3Pwd7vT90vAet0HK2EC
	hZO1Ghj52F+Af+VYbchRj98ooexs=
X-Google-Smtp-Source: AGHT+IF/CT/cGV7lkH/o5dPPj66u8VzhHm0XCmD8xMiPjei56jMRMTWRgisFzg0z75mEclO+H4kGcFmSDScYl66i91Q=
X-Received: by 2002:a05:6870:9712:b0:221:8915:1cc4 with SMTP id
 n18-20020a056870971200b0022189151cc4mr2507945oaq.12.1709882934739; Thu, 07
 Mar 2024 23:28:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za> <20240307190408.23443-3-justin.swartz@risingedge.co.za>
In-Reply-To: <20240307190408.23443-3-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 8 Mar 2024 08:28:42 +0100
Message-ID: <CAMhs-H-5Y7iutnqtJX3dfzAj_Dw9DhJPjUKZBZU+1Tqhidx_6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mips: dts: ralink: mt7621: add serial1 and serial2 nodes
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:05=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Add serial1 and serial2 nodes to define the existence of
> the MT7621's second and third UARTs.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

