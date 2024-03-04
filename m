Return-Path: <linux-kernel+bounces-90995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB866870826
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802781F222B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63860266;
	Mon,  4 Mar 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5os689B"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956960258
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572639; cv=none; b=I5NJ4YfcxDWsr6WTEH/zkm/yNKqmao93kmlQpe1E+l9gnnqW6sTFl3Cet/nlF873UcBoNHRilamUFYNbsU/Rty2LDe1mQ+xHnsuc4tpGkJzA/6Q0ZESeTW2zX2tT65vJe4QKPtiW82R7Itqj6p9koWBJ8uqAkG9I4iQogoFQvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572639; c=relaxed/simple;
	bh=JtJhYl2/Ov/X2p2X9Lrev62ssGeSJmqFi8grIBFq+mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF3xNSJyWdFO8EYGQCoRkzNp7GBicLZCZYy/RCrVYV+KxuCqc6ju0EF7GDARZMjcRNGQTLt9ouFPbQeiDP2elgbvYL5HUa6BusYfF8fMcKjALPoQgo76WPw2wCT/e3Y2KtoN3J0x/mkILTMB9hXN2QXmebLLEVSuKIP7DkK11D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O5os689B; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44ad785a44so367141866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709572634; x=1710177434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf2GCMAMCZVgBPTFhp5oiB/JxG7pAEQpQpgTp9OZnBc=;
        b=O5os689BliCPS9modgaf5xr5dye/jrXOBVx/EAzwjouDZynNFHAjXj+pdz3lvXqAgT
         qgEOsvHLhcXiXKmzZ3O2X5o2EJTvD9JE8uLMvCVnBNFHhKRhFPVeC8y/0G7LwNk0FWIN
         mjaL6GmzS5VLXhwGhA4gNtM1WowoPoJtlig08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572634; x=1710177434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf2GCMAMCZVgBPTFhp5oiB/JxG7pAEQpQpgTp9OZnBc=;
        b=vgQepXYK3GFLOl317AcVUcEeAdgAki2lpv5Wg2Fb9A2icCAYnZcn5Zyls31W9pUdFT
         zmAXZ51FzYvbCSWgrzjEcfh6HTik8nWFQpFHCKQsKiBAUMCrsWqJsa9MN95K9X+74dyn
         zpcw5Bs5r+fjd7AzDcDPcdjwg+TL/nTopeKAnJOWEE+o/Ofwyp+Z7vnlPAUyGtBkf/nI
         2G3OO6qRn507h8duNi3RvPENSO066oFLvzqfTpj/BDrZsEYLF8SqiU0ybTlLFn9R5Uwo
         +YwL+KtMkgkTzSNcvCCOlZ5etbvMX9yCk7Pdaz0qojeN9shWe/ulmK/nlN1I4MO53Yy7
         d5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUGSXbk+VKYET0MLWr4HMDbqOtJlXVEcuURpgamcvR0b3QyGH4ZDHKWEeZc8utRnlelbpIBw4buUYiCYcyHgueDNTNL4pDQcNDbrvX2
X-Gm-Message-State: AOJu0YyI4qhTAKktpp4epJ2oLN0yU42C60xF3jipRU0kJm/2aAkEJX+z
	L9UP28bP3VJmMxqy+f43mPlgEb/lkKLC27FCMLtCfBJ7j9E5oD3jB1mIxx/kL3reKA8pxMzzCZw
	Ya+oh
X-Google-Smtp-Source: AGHT+IHtd3FyBPXkYz+2U06vXTLJ/gM1JLn3TZ7ayFlrvOaIZ6uL+/XIcVmm8MXU0uEMDcpshG+Meg==
X-Received: by 2002:a17:906:35c9:b0:a45:64c1:cb01 with SMTP id p9-20020a17090635c900b00a4564c1cb01mr1881906ejb.26.1709572633816;
        Mon, 04 Mar 2024 09:17:13 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm5044251ejj.169.2024.03.04.09.17.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:17:13 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so187695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1bElLVY8oUBlWsgq7wIzAxCNSrPbhAHw5LI7XDcGo8FXkCuK4SEvX4lF3QFUecgh6qzSGLAceukyUIv34uuePw+H1bG/H8kOIfE+U
X-Received: by 2002:a05:600c:49aa:b0:412:dbba:ca67 with SMTP id
 h42-20020a05600c49aa00b00412dbbaca67mr300900wmp.4.1709572632243; Mon, 04 Mar
 2024 09:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084006.14422-1-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20240301084006.14422-1-xiazhengqiao@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 09:16:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UK7Npa0S6NC1uxoWppZ28xN1j6yY+zpERQU6-XTbFNAQ@mail.gmail.com>
Message-ID: <CAD=FV=UK7Npa0S6NC1uxoWppZ28xN1j6yY+zpERQU6-XTbFNAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: panel-edp: Add prepare_to_enable to 200ms for MNC207QS1-1
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 1, 2024 at 12:40=E2=80=AFAM Zhengqiao Xia
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> For MNC207QS1-1 panel, Splash screen occur when switch from VT1 to VT2.
> The BL_EN signal does not conform to the VESA protocol.
> BL_EN signal needs to be pulled high after video signal.
> So add prepare_to_enable to 200ms.
>
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com=
>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Should have:

Fixes: 0547692ac146 ("drm/panel-edp: Add several generic edp panels")

Also note that the subject tag "drm/panel-edp" is much more common
than others for this file and probably better to use that than
"drm/panel: panel-edp".

Other than that this looks fine to me. Applying to drm-misc-next since
the patch this is fixing isn't in mainline yet and this doesn't seem
massively urgent.

e635b7eb7062 drm/panel-edp: Add prepare_to_enable to 200ms for MNC207QS1-1

-Doug

