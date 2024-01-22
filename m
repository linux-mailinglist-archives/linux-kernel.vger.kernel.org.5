Return-Path: <linux-kernel+bounces-32309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5C8359D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AC828170A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BC1FC1;
	Mon, 22 Jan 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRF/mFIH"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0F4C6F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895131; cv=none; b=N6Hx0wp9VF47cVoYq05bSEXpEXb3jQZe/cPfSvOKgL3yfPhLOElM0URHlrIUxUC6STSAiC9s1VQMCTQCK2eJU9I12ye061tElMOzDuosbj46tGJpu+y18+9PQFdxg93vlAJfr5iOul75LAaTI+UFzJfQJGCdj7XTny5k/wueHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895131; c=relaxed/simple;
	bh=eUc28hxFSOjAp6vDpl8grw083rrwKd7v+61OGCuTiAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy2/9/lDumOydXVVD0H+rmFC+aagfe08AcLoYp8oQCygmcbc9mzMOx1caOjl7hngsAJ7532l6X/GNA9mlGZnH/SlAFD4UxXmS29if7gEQdAQWINYaPDYI3ffrp9rMUyHfXrbSoSlsYMiwktC+WS9KgiDirB/SZK3/FExek8IQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRF/mFIH; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b978e5e240so471149e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705895128; x=1706499928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE8ms7ryFZW9Ht/e6NRcvd7QnzuOU18cg/pk9kEcOj4=;
        b=CRF/mFIHn0kioGg+daZMGNnlkdnmaV+XpseK/om4YD4KAPx7wxouJ3iwQm1XrhPStI
         4PclLukdUsWyzHl5IWPpwd6Zg4zzEBeMrysmrwUDFPALlVXoHcwa7K624lkCsGvDrdNt
         uhO63/bAYYtPoQQLwlGVI9Aswb+CwntC7w7b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705895128; x=1706499928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE8ms7ryFZW9Ht/e6NRcvd7QnzuOU18cg/pk9kEcOj4=;
        b=Dmt6lZH58ulgyGEA3g5bLdhezna9Mn7OkSSRYWEpyTAfGqbMJsXIdM3qOWh/L7TnFH
         xYxrbG/ZYfErxI3EAQgjjMMo6IJdAfkINNwfGlBjlCqMSxjvFJ3zXgwlYs9HPVp09PYK
         j6N9GXmFS2hCdWWfdy5hJoabpVIg9hl+mXZBQUw2O+n3dQkiBslngf9PuRdMp4YPHxcv
         6wAJh/JV3+auN9tPNIwDapu0yEEJolibLQtihD7XprufmsJJq2Kua1nY5IB7KqQ92knm
         7iLEwtNuqUfF4XaS7a5qykgKk7XF3iyYChx+6T4WK521JRMLCvtCoLNG266AWtM9vEPU
         cAnQ==
X-Gm-Message-State: AOJu0Yz/BKmoUooVw01HsqgdGYzDkvMz+LAg8wpThvYYu8OqUlN9hqNl
	kzgmnDLiUHzXehWfsZrUiHEMxjigbhJhMivH0d5yGQlnyQzgRE6YCvqsJsKzvgdQKRkCVlnfm2A
	Qzw==
X-Google-Smtp-Source: AGHT+IHa1FGDd/43yrMthp8xHwj3s3ldiP1SnQEP9P51qnBGn46xtQ2P74mzgfYnCKlxHcofpAetXQ==
X-Received: by 2002:a67:c906:0:b0:468:ee8:8943 with SMTP id w6-20020a67c906000000b004680ee88943mr1037651vsk.9.1705895128330;
        Sun, 21 Jan 2024 19:45:28 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id c5-20020a0561023c8500b00467e78138e9sm984660vsv.28.2024.01.21.19.45.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 19:45:27 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-49618e09f16so418930e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:45:26 -0800 (PST)
X-Received: by 2002:a05:6122:410b:b0:4b7:1658:e66b with SMTP id
 ce11-20020a056122410b00b004b71658e66bmr994565vkb.23.1705895125827; Sun, 21
 Jan 2024 19:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com> <20240119063224.29671-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20240119063224.29671-2-jason-jh.lin@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 22 Jan 2024 11:44:48 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng5v5-LSq6d-R-89N35qiKd7qa8FEo6qakWxrzibYvgSQ@mail.gmail.com>
Message-ID: <CAC=S1ng5v5-LSq6d-R-89N35qiKd7qa8FEo6qakWxrzibYvgSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>, 
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:32=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek=
com> wrote:
Hi Jason,

Just few nitpicks about typo:
>
> Add mediatek,gce-props.yaml for common GCE properties that is used for
> both mailbox providers and consumers. We place the common property
> "mediatek,gce-events" in this binding currently.
>
> The property "mediatek,gce-events" is used for GCE event ID corresponding
> to a hardware event signal sent by the hardware or a sofware driver.
software

> If the mailbox providers or consumers want to manipulate the value of
> the event ID, they need to know the specific event ID.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/mailbox/mediatek,gce-props.yaml  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gc=
e-props.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-props=
yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
> new file mode 100644
> index 000000000000..68b519ff089f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,gce-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Global Command Engine Common Propertes
Properties

> +
> +maintainers:
> +  - Houlong Wei <houlong.wei@mediatek.com>
> +
> +description:
> +  The Global Command Engine (GCE) is an instruction based, multi-threade=
d,
> +  single-core command dispatcher for MediaTek hardware. The Command Queu=
e
> +  (CMDQ) mailbox driver is a driver for GCE, implemented using the Linux
> +  mailbox framework. It is used to receive messages from mailbox consume=
rs
> +  and configure GCE to execute the specified instruction set in the mess=
age.
> +  We use mediatek,gce-mailbox.yaml to define the properties for CMDQ mai=
lbox
> +  driver. A device driver that uses the CMDQ driver to configure its har=
dware
> +  registers is a mailbox consumer. The mailbox consumer can request a ma=
ilbox
> +  channel corresponding to a GCE hardware thread to send a message, spec=
ifying
> +  that the GCE thread to configure its hardware. The mailbox provider ca=
n also
> +  reserved a mailbox channel to configure GCE hardware register by the s=
pcific
s/reserved/reserve/
s/spcific/specific/

Regards,
Fei


> +  GCE thread. This binding defines the common GCE properties for both ma=
ilbox
> +  provider and consumers.
> +
> +properties:
> +  mediatek,gce-events:
> +    description:
> +      GCE has an event table in SRAM, consisting of 1024 event IDs (0~10=
23).
> +      Each event ID has a boolean event value with the default value 0.
> +      The property mediatek,gce-events is used to obtain the event IDs.
> +      Some gce-events are hardware-bound and cannot be changed by softwa=
re.
> +      For instance, in MT8195, when VDO0_MUTEX is stream done, VDO_MUTEX=
 will
> +      send an event signal to GCE, setting the value of event ID 597 to =
1.
> +      Similarly, in MT8188, the value of event ID 574 will be set to 1 w=
hen
> +      VOD0_MUTEX is stream done.
> +      On the other hand, some gce-events are not hardware-bound and can =
be
> +      changed by software. For example, in MT8188, we can set the value =
of
> +      event ID 855, which is not bound to any hardware, to 1 when the dr=
iver
> +      in the secure world completes a task. However, in MT8195, event ID=
 855
> +      is already bound to VDEC_LAT1, so we need to select another event =
ID to
> +      achieve the same purpose. This event ID can be any ID that is not =
bound
> +      to any hardware and is not yet used in any software driver.
> +      To determine if the event ID is bound to the hardware or used by a
> +      software driver, refer to the GCE header
> +      include/dt-bindings/gce/<chip>-gce.h of each chip.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 1024
> +
> +additionalProperties: true
> --
> 2.18.0
>
>

