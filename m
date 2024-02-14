Return-Path: <linux-kernel+bounces-64630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F485410B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB48B1F280BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DC290C;
	Wed, 14 Feb 2024 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bveaKCvz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD88625
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873475; cv=none; b=XXLXATg/nBjy/bcQ6BorqNXmvbvnsnmehIWPR2WHcvJ1ssSrNoJckMCzMe5jQrcs30dusgUIIFc4GC7TJiSgjwaGfsbRdK6HHDWTAZ95DQ6nhp9KeGfNaL30jWtWzBw90KqKzqitC/PJu+ztSHRCBDVRDLwqsl+Wi92B986vebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873475; c=relaxed/simple;
	bh=rBM05EwNb5zPmJZsUcrviXxJFm4T/Pw0l7QiMDppS5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT1qHKoGwv/l1R/H4e+pJu4eFKbt1awFGZnpdAHbodCg9ILxNxcPK8btZhXDNHs06f0Xz/UOoAi8nJswKxuhzn4zBfUinaqa4j/e7itE8DQU5z2uWMGk/UKup+/KxSobftIBlMKkkqpPErtk8wKV4NgmyaWOMajGpOif5iZrSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bveaKCvz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3122b70439so635560866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707873471; x=1708478271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBM05EwNb5zPmJZsUcrviXxJFm4T/Pw0l7QiMDppS5M=;
        b=bveaKCvzlrMd0vxaArv+rLMs218PWPG20i6R9TfycTGArfIY0YqptaMqeW5BvYmo4o
         uyxGH+QFPrlk2LsZqT/vULXQNDJn8Yp/jrNG/iWRFN62vmu/FNkVUhbHu/FcC+QdijKF
         qP1INmSb6kmfrT8Swj3O7y308E5gWHQkneoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873471; x=1708478271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBM05EwNb5zPmJZsUcrviXxJFm4T/Pw0l7QiMDppS5M=;
        b=vDGmj3b19tidgrDP1BVIcCHbpFEugUy1j6OjBE5YhPD9E2qOzrDdxbYab54oc7LvGc
         VRrDO3tEC72vg+RV7Knjf2bkiFaw6N7ruEbq2VX4cWXUb+yeAJlxJ/PMbRoUO2bU0kKF
         m3q1rxSYCdwTG09hrFVWwf61n5tZ7A88qCuVKkQC6KirMu0VofuK+0g7JxRyveDpJh1F
         iS/fZBG1lepETWQgD7IaShK+albpEqv8H+4z9hjlCitoCbmtIvh4cR6GfEjXn0cBnpaz
         NYc99cNUhI28X1guIyPXgkRDZCh4sHzbDvfJgV+vlNpoT2u7RD9pM6yygDBBx8ZQJQ/0
         BFuA==
X-Forwarded-Encrypted: i=1; AJvYcCUpSGDKY4bui2zDMNi+TDCTyUywvfowKcyeiQeDsytJGFc0eDm3kGq5b5SXkXOkwoLO2A1HKDAtaGHWI+Z/1XRWiI0Y1LLN51PwVyIO
X-Gm-Message-State: AOJu0YzMYEqsaeYoyo/AyEjK5fo/HlueNY2a4CT/8/zlTcvD28lUSOee
	wfNq07EWutRJTvXB1P8AGZcmN367t6JKPh+PV/GDAiybnldhNG+OKi1jk6AcYAxcED+4qlVw1oS
	fi9vY
X-Google-Smtp-Source: AGHT+IE4jDF0LaBySPqGZ50EzKqHmAee/hg1anJ+KtAiOiZgxjg882c7WEVmMJcVpZGYQ/p6qkwY9w==
X-Received: by 2002:a17:906:6946:b0:a3d:15f4:6118 with SMTP id c6-20020a170906694600b00a3d15f46118mr703246ejs.13.1707873470972;
        Tue, 13 Feb 2024 17:17:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbKEEumimVX0CMMa1YnwUsKBkYddNC6tkIfruNBTiH4B0IpxDvkEGDePQusdJyILZBIGKmfQpr8RQCI+ROFqWPQ73ZfkRWQVkduzNX
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id vo2-20020a170907a80200b00a3cf66ec008sm1309198ejc.166.2024.02.13.17.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 17:17:50 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso45505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:17:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa8b95og7PGzHc0/jAdlXw8iPdxS+vW5iW+tTf6YNpgQkxm4MX3vSni2IhWLScSw8tLlhUb+DAtsmfpPUxXZRzXTAHQqFnPiSHo94W
X-Received: by 2002:a05:600c:4e4d:b0:411:62c:b4ae with SMTP id
 e13-20020a05600c4e4d00b00411062cb4aemr75039wmq.7.1707873469959; Tue, 13 Feb
 2024 17:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-19-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-19-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 17:17:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WE4bgwTWTKjPbQR9RCt-SEVZXfQtXoaXAjvTiZiMr=wA@mail.gmail.com>
Message-ID: <CAD=FV=WE4bgwTWTKjPbQR9RCt-SEVZXfQtXoaXAjvTiZiMr=wA@mail.gmail.com>
Subject: Re: [PATCH 18/22] dt-bindings: chrome: Add binding for ChromeOS Pogo
 pin connector
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 9, 2024 at 11:10=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Describe the set of pins used to connect the detachable keyboard on
> detachable ChromeOS devices. The set of pins is called the "pogo pins".
> It's basically USB 2.0 with an extra pin for base detection. We expect
> to find a keyboard on the other side of this connector with a specific
> vid/pid, so describe that as a child device at the port of the usb
> device connected upstream.

Can you remind me what the side effects would be if a different
VID/PID shows up there? I know it's not an end-user scenario, but I
have a pre-production "coachz" keyboard that's actually programmed
incorrectly and shows up as the wrong PID. Presumably I could either
throw the old hardware away or figure out a way to re-program it and
it's really not a big deal, but just curious what happens...


-Doug

