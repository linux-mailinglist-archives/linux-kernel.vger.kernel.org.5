Return-Path: <linux-kernel+bounces-35689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC93839529
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7654B1F2BB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF085C60;
	Tue, 23 Jan 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nz1cxjcp"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7785C58
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028172; cv=none; b=lAoCwQedoUxnVH8oQ6zlUhtUfytgYFTyBgybDA4hfMRhQgfa7v/14Bx7OqSavpVUMnyXB0i83PhsenWnQPvRyr10LmMh6Szbl9q4XVfheWWSy/NN13qFCawwhSlHuv6dnKoZAt4kuxYwW+5Zrro+53DFcYjL1O3nFba1FWZ+mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028172; c=relaxed/simple;
	bh=ppl6t55Xb3yOStVS40Xp8F1eM7eIkdjEKB+PuByQGwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn1DAygtVCk1pi+FMQMG5291k1kLnNHRH0JHlM3iuYaIQcx9kioMo0V+/saI0cDV0hw5KQSZFGw5fRUWJB7fb8nsIYNZL4N7e8aySzsJvrWKDhJgrV67FswsCxexZ8J8cDEZX/Wg32P/UEjAle6yZB/OwHoWAjr9ZRXK/WvfFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nz1cxjcp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dae7cc31151so3299239276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706028170; x=1706632970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+SegmqWvJB84QfkO7HYF4stG1Ls5HB6F1q0TGJJxxY=;
        b=Nz1cxjcpS2lVUmmqF1FwRQqZpR0r4apym+Zcq81Xc0WXR/+qi/zBjCmhftxdTF6gbS
         PGzp1e8+sZmH/MwpmkfLAYZk29YSOpsmkAZuGPMmF4A8vLJGCt43WBPjHb7KJLM2B+Ed
         l40pJo1xUrHjapIb2M9IR93ydfrAk9cOpvS3IhJTcEpdwwPQ7hD6/hChjUuZXVnIVAaZ
         Fy2ELtmySxXJuP7A7YKsdKo8r32V+wk5mnYUPCGBtBwOJ4tI9J4u+GVEFiqUFljDHSGs
         FEB5CEdm81/ogwVlHMchkEyywwfGUFdUW7YP1kbh7q88ZcYTzjnIfbIXc+ryKUBdUoaB
         wVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028170; x=1706632970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+SegmqWvJB84QfkO7HYF4stG1Ls5HB6F1q0TGJJxxY=;
        b=cFWShwt0eLu1RsblG9dyGqJZgqcJp4ZOuhMnAs6GX7Lx0Pshq3X6AwR1wA+SEgjxtP
         k00nuNllFh+s95kS9nP8SXIUoVe5AMyI3UjYQ/m0sHpuE0sjUB8StIid+mgoNvP5IT1v
         bZi4LuZ/1tYkawtvclFNj+e4wrTYf1kaWfYLBqZFcthT4/QSc0HazNpa+o9hHuHQXehg
         5JmnrhPZRrzKxXTPKClxlLDuaas7ku6u1+2/nG4zoSYmLoBypPhY8LjWhMfXtEO+mELN
         rRI94M1UX1olaV8OJD9KtOOiBppScb//KGrgAI4sw2I1gM9z3CYFr/2/ucClYbEWP8K0
         RoEA==
X-Gm-Message-State: AOJu0Yzp/bJaPsJOe/+VloyP4czzsecR73R90M8w6yCPCEqPLjd5n8VO
	ipXWpDVJjzIoxBCFVVAYxqnbb/ciANFZiSrxPbp34082iXxYU9t+PJ+FVQRtZ2EzUJiWZEg8Bf9
	iIUL4BvtoV2GKghgN4PoOMFTPSwDttf2Urkr6Dw==
X-Google-Smtp-Source: AGHT+IEQN3J7JB7vnvZwm8y5ORGd/llGa6+d57uttEwVUWxB9BL4Gq3n6tYT2DOWB422Q+ECgHkVa0zQQ1yxbN7Aiuc=
X-Received: by 2002:a05:6902:1b87:b0:dc2:1743:be55 with SMTP id
 ei7-20020a0569021b8700b00dc21743be55mr4241873ybb.112.1706028169807; Tue, 23
 Jan 2024 08:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706026160-17520-1-git-send-email-mantas@8devices.com> <1706026160-17520-2-git-send-email-mantas@8devices.com>
In-Reply-To: <1706026160-17520-2-git-send-email-mantas@8devices.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 18:42:38 +0200
Message-ID: <CAA8EJpqRvLE3pjkALv_hP9UJjFmEhni_vU5RDYovbpmjv-Sy-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
To: Mantas Pucka <mantas@8devices.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 18:09, Mantas Pucka <mantas@8devices.com> wrote:
>
> Commit 2be22aae6b18 ("phy: qcom-qmp-usb: populate offsets configuration")
> introduced register offsets to the driver but for ipq8074/ipq6018 they do
> not match what was in the old style device tree. Example from old
> ipq6018.dtsi:
>
> <0x00078200 0x130>,     /* Tx */
> <0x00078400 0x200>,     /* Rx */
> <0x00078800 0x1f8>,     /* PCS */
> <0x00078600 0x044>;     /* PCS misc */
>
> which would translate to:
> {.., .pcs = 0x800, .pcs_misc = 0x600, .tx = 0x200, .rx = 0x400 }
>
> but was translated to:
> {.., .pcs = 0x600, .tx = 0x200, .rx = 0x400 }

Even worse, it was translated to { ... .pcs = 0xc00, .pcs_misc = 0xa00 ... }

With this fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> So split usb_offsets and fix USB initialization for IPQ8074 and IPQ6018.
> Tested only on IPQ6018
>
> Fixes: 2be22aae6b18 ("phy: qcom-qmp-usb: populate offsets configuration")
> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)


-- 
With best wishes
Dmitry

