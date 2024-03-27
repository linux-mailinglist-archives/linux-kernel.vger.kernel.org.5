Return-Path: <linux-kernel+bounces-120273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2C88D52A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7011F2C138
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4976C22F19;
	Wed, 27 Mar 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDXyIYB4"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8122616
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511233; cv=none; b=qkqG40Y/ZnM3F6CPyUfNCbjQ64/st+Tj+MzIQIH6IxdaBtJavZgDy6+FHX7BH2OeYQU6McUdp0lpA2A8yWnMMjjz4Xx+ipYa/3xeqoULRF/WZMZltsBHDbkAtXkdTLyKFVAr0ygXK5WbXxHkqBopDq0GzuIzypQRZNRPuryQmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511233; c=relaxed/simple;
	bh=NzemdoyjALEp5Ne0oRNHFHMDDDAlBGl0VlU9gOElQdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8z8vEGj2EGN/mSTZzOoSYpaHfC33m2iBo+PkR7SW6evFWpKB3/OjfukQ/zzr2JporO7Rk8uxieFdLz1t/ynmekZPbtLAkwpBspY+Ew2O9oWrQZtWETTf4lFRKjN8hZGbXSTyvd2cmjiNxuUjR4Uh41X5RGTYkG87vj52LSayyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NDXyIYB4; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e09e1871fdso1631194241.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711511231; x=1712116031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzemdoyjALEp5Ne0oRNHFHMDDDAlBGl0VlU9gOElQdc=;
        b=NDXyIYB4XXx4IX9pA4qsNgpit4srwr3pxzp2kG0qm8GUP6I38ToFaAnU4bYVyscbiU
         gRx+BdE13rCkSXrq/i08hMLWNOJpvJYvD8R3jXwit6Di05kDkaWfcStVM7ktv2WBO79Z
         u7UvB1l1qPNVSwAWafQJ7rUNizCemvWZtJ1FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711511231; x=1712116031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzemdoyjALEp5Ne0oRNHFHMDDDAlBGl0VlU9gOElQdc=;
        b=Pl1UHQhYF48BPCmZutLygb20F/u54uyRwhYLWQsm05HFwtbLk66BqEzhaQBslOtmRy
         PN4sG15rB9bvzXWZ84iXu21GkTxDdHqYxaOZBhqGKrYSccf+3UWhPGDpUXewYbxWdXRP
         xef4yFiG/jJY8XaONaebw5CKhZ0Wwbu4dWty98k6thk+9ahCxHerocySmEel5X+mIUv6
         udi/c2kmprgxegGUlp9PmuWhRisTohRjjLx6zWkSkTqaPNbTEEQ6QfcY45oAbNUTDSuy
         adSyWrHxA4j11UXl9il7IHtbaD+v8f9xbPjI86iP7j9Vxw+bGRF83OwhuIipGIK7TQNQ
         no/A==
X-Forwarded-Encrypted: i=1; AJvYcCXwCEWaR092JBGjme9j5IMFxCygJp1TAeZycGabgZSodjI6gJ1HSkuWnoiZkl+J/4vMB5oIJA/plL/9vOGm5SzQ+bRx+V+ZVIDbD+xw
X-Gm-Message-State: AOJu0YwMlcisuc4CT67SSYujhbCt4SX3g50bn36hnLTDpvNQ9XtTIzUs
	YwzieMgrnFIZDRK/GwMLn5AtxRKAcgCSnjHsBVpRxpJBjEs2wGpYvHCQN+qxuR0XGgnJmx6Y49X
	2nLe3JGCViFPHBgYnuflbuJj20QPsaid0x/0V
X-Google-Smtp-Source: AGHT+IEnAe/XEivX0tpGpVeOk/Y1JjQzcaU0hnYqVCd0bNPmDAgKWMvmA6VqDC4R+aIAB8lzbhuYESGZN3G6h+iEosI=
X-Received: by 2002:a05:6122:8c6:b0:4cc:29cf:a1fa with SMTP id
 6-20020a05612208c600b004cc29cfa1famr1744790vkg.4.1711511231123; Tue, 26 Mar
 2024 20:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org>
 <20240325-public-ucsi-h-v1-2-7c7e888edc0a@chromium.org> <CACeCKaehH3Qs8y-W_jsyOdnTYWVzgsGj5_wGujjYT2Sr8xxqkA@mail.gmail.com>
In-Reply-To: <CACeCKaehH3Qs8y-W_jsyOdnTYWVzgsGj5_wGujjYT2Sr8xxqkA@mail.gmail.com>
From: Pavan Holla <pholla@chromium.org>
Date: Tue, 26 Mar 2024 20:46:35 -0700
Message-ID: <CAB2FV=662xWkfEJf0eqnrn6mBPFM88oy7QTTSYMkLo=6wPeoHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Import interface for UCSI transport
To: Prashant Malani <pmalani@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:11=E2=80=AFPM Prashant Malani <pmalani@chromium.o=
rg> wrote:
> Can you squash Patch 1/3 and this Patch (2/3)? It sounds like an
> atomic change that doesn't need two patches.

Acknowledged. Will do it in the next version.

Thanks,
Pavan

