Return-Path: <linux-kernel+bounces-117449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5788AB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C941C3D77E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632312EBE3;
	Mon, 25 Mar 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COAq4fVs"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2312DDA2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383563; cv=none; b=ZYerA6YAkg5oLBATx4Bb6eioJwFUYdWllIMbw5EK6BiWpHK8IXsPqyhbCWJ0e1q5RUOn1ILd9GoTqrhd3E2RSqKPdS2s3ErRad3HVHGBB7/Q832x9XsJWUCc7cUl1VU0Gbi2kWdi8XXAaEtOE0SzoPtNXkqDm1MHsFE1A/h1Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383563; c=relaxed/simple;
	bh=6utOFEwbdwWyQcN7SLxfqSV+M2t5uCbikbD6Z3HiO1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCB92e87wawCxfEdb3AQV6h3QxOkzreiKGfBMhsI+Etlzd8WZ4iILxco60oKxwFptNgnl7MNdT4Tf74Kv9tZHRQX6JFobJaa5V+Uc6Hq0XiWIpZRKbSA1gVzcp+V+Yf6ef+raKML1MhKCwTbUGb/h5V28XJeWOiqQ8+MISi9Hv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=COAq4fVs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430dcd64e58so30748781cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711383559; x=1711988359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsgsfaYuhO9HIMjIvNDS3p/KRrPkbJlG84J7jcdFiPU=;
        b=COAq4fVs8WLSyhzuZWdojy9732BJkeHAxZ0dB7XPbkCJ+/CVWXgKb/eI2oxfxUNwoi
         2V4n8uuq5JhI3aE8B9SYGBBJGlu9KcmmTbJ5xkurkDXcNBFdZdqj7df0PiOvQwbKvKre
         RnzbZx7pExxulfKCffnMEByko/GZOmini2HWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383559; x=1711988359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsgsfaYuhO9HIMjIvNDS3p/KRrPkbJlG84J7jcdFiPU=;
        b=mgvGJcb0bkocyuppVgS/SnbxcJGVmyPnAevEjYy/mfuIcpOmZq8L6DDP1i/rIB5Jwj
         jqg3bKJveO2Dz7k+HkLr5bs2k7yGYLJ2piKYywP3B5DKEXqz08JGNIz6Ke7nAF4ZIOdr
         lenD3EmGQbOJ+pwxUXdTLEyL7tlzz0d65vQwr/1KkXQWUdVkC5hkfD59ICRKH8BTmH7N
         iZxG66eyoL54oUsgdaf2P0gEeE6nXagBiA+bEoh9sqpxd3nqcs3gmRtLUc6U8uo/1yWG
         6z1F/lK4NiUDJuPoWDP/1xlGycCZRtQ855WkRza876yTNa8aULXUfZfcriwN3XgDz70c
         LuCw==
X-Forwarded-Encrypted: i=1; AJvYcCX4zw7R9JPTB1zTGlezHkODQWPGej25uoq0kJQeCPBjhMio/fwbWOINDVBcaXo4LzbnZiquIRPouvDYuNAXEYz+vlY9bytmiF+EjrpE
X-Gm-Message-State: AOJu0YyFB3jto1nhvbMJJmvpL0zq7r0JKNLurU081Mp2Awd6sy2okQqB
	lQU5svZ7Mn+pUGrixoRsusNarMC65noS24n561m2ivddOYtV+qIMwWd4D1x2E+3uzuwBp3lL1pI
	=
X-Google-Smtp-Source: AGHT+IHAL3qSq+dyzADtplpw5l8OQZoQwfpNATJ/DZTfJ8lY12DV8lHQ3iJSCAqBxxdUujQLGFqAfA==
X-Received: by 2002:a05:622a:1115:b0:431:4983:885d with SMTP id e21-20020a05622a111500b004314983885dmr8546198qty.33.1711383559386;
        Mon, 25 Mar 2024 09:19:19 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84754000000b0042f30e63b1fsm2729594qtp.49.2024.03.25.09.19.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:19:18 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430d3fcc511so467641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqy0uP+zpYhEVFznARe4P7vbMGY/oCBX9fE1Hb7hXrvCgo3P3oGBBv1P/BsRXcnv90A7U+3JzpftM4Gel4ItV4A92Zn89GF1THVUtu
X-Received: by 2002:a05:622a:588e:b0:431:56bb:2347 with SMTP id
 fh14-20020a05622a588e00b0043156bb2347mr265739qtb.21.1711383558167; Mon, 25
 Mar 2024 09:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-3-sboyd@kernel.org>
In-Reply-To: <20240325054403.592298-3-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 09:19:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wu_SuLcHYQ1bLC-zhV1FnoFor84t-=EERT9mnDdm5Q2A@mail.gmail.com>
Message-ID: <CAD=FV=Wu_SuLcHYQ1bLC-zhV1FnoFor84t-=EERT9mnDdm5Q2A@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: Don't hold prepare_lock when calling kref_put()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> We don't need to hold the prepare_lock when dropping a ref on a struct
> clk_core. The release function is only freeing memory and any code with
> a pointer reference has already unlinked anything pointing to the
> clk_core. This reduces the holding area of the prepare_lock a bit.
>
> Note that we also don't call free_clk() with the prepare_lock held.
> There isn't any reason to do that.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

