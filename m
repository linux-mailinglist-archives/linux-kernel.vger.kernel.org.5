Return-Path: <linux-kernel+bounces-160340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977718B3C22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B47287743
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D914AD3D;
	Fri, 26 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h7PHiu1v"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B75149E17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147140; cv=none; b=mB9LxoB8JvFrsfqtAPvg4LwlSgxgrUdPtlcHNgOgKwAvsNHQkobB+u5pY4CVHemhrI5x0tnzEv2vgCeLAqaoaKQpdzK2BBq+Ta8TnJ85HlGtgXTphJO9ALoqNB3jLM2pycn0iDbJlnOwpFBZccXnACu9DSvdmiUqaJoCYcJ2Wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147140; c=relaxed/simple;
	bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ9KafQVkBMLqYUc1ag3ofzq5FiWAJnWVkfQ12trThy1tISszmBVjxCh1ndgj61LYnJEbjDubWz831xHexDQPs1odfjQ2Rs4Gco5a6Jx56hPtAhPOOKUGQTNBcGlTAQbxrXrYW5XCOVTXIn2+PRdlUm2rRW1aGs9GrMCxucte7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h7PHiu1v; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso980439241.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714147137; x=1714751937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
        b=h7PHiu1vgM8DDosVZNErQyADNkAe9MNRGVia9ZWA6nXnPliRuX61Olnynob+KX1gav
         5tYmo7sdcWQekko3QoevJblcl2ydZ0I+vy7kUYKoR22/Gn+c94XLRf0gwXrIwMc5jKlT
         1UZ6XPCq4kfByjg98Toj1erd16VxCa/bmrCSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147137; x=1714751937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
        b=oPxvDv9E2ew2bzDqQ+YGIlSrTyZjrWflA4HbVa44tI9bCl/dpGCIIlUQSFtuOtZqRX
         mbygKfT4pClCW5OqD2uzD3o9Tc0kuN3L2lg12ny+qtjFec5B2tu4JzgavPAQylSIViUG
         jrSpj+3LuZSbZLZHyZCUMWh82RUsyeCZQd/J6yHkpsqWkW+qqo7bLn7PzJShNMCjgTto
         hjjWHvuY2H7oDyjtQMsQmPDceNS0+ubTP/izJAkvutSQeyp/FkuKzgdo+MHrC+bbEfId
         JEO0aobusJGKUUY3clb1AP0+k8X6GBpPVcfXV5UsXPEU6dFu+x/PmQgLZ5+PIdwFMwyG
         Lkyw==
X-Forwarded-Encrypted: i=1; AJvYcCXZhH5LiDz0Kxd5PI+uxs1zNkJxFPlPc9k2fgaWODjV3v80MZvw4yAf+Ff23E0BJ1FckykVRlNCjvIrfpT9DZ/MIP8FxUMbxz8Vjgq2
X-Gm-Message-State: AOJu0Yw00jKLhBGDuXEsuz2/89fCrBRm4eG8iSBmIg9dFD9J4Nxqndif
	i6bZKTtftGSpDPmZ+jellao8S5i5/zsbjGTlIDOu2osZG/U/OnivzGVTXFFaj3nTDrDRLowKtJN
	SEDUYcLGDp74rhdMxiiagky8uHzeu7ItfgL2VL7klmy7wOLo=
X-Google-Smtp-Source: AGHT+IGRy0gu7DJBvWKqWoz9wMaZQl6qm+9GyPL+x14BBkTcpVqF+6SVukjVmu4uMkeojXS8ScmMTTt9kUPIJCorAGg=
X-Received: by 2002:a05:6122:4113:b0:4bd:32c9:acb with SMTP id
 ce19-20020a056122411300b004bd32c90acbmr3187376vkb.7.1714147137594; Fri, 26
 Apr 2024 08:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com> <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com> <20240426045207.GI112498@black.fi.intel.com>
In-Reply-To: <20240426045207.GI112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 26 Apr 2024 11:58:46 -0400
Message-ID: <CA+Y6NJHzr7x-0S0fbgKJyRjvHMSrbyBNert83g_qVZDS=2wA2g@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> This way you can identify the xHCI (well and NHI) that are not behind
> PCIe tunnel so that should mean they are really part of the host system
> (being soldered or plugged to the PCIe slot or so). If I understood
> right this is what you were looking for, correct?

Yes! Thank you for the explanation.

