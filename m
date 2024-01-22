Return-Path: <linux-kernel+bounces-33399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9176683693C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BBF283619
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB73E486;
	Mon, 22 Jan 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKQrMPZE"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6563E46E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936186; cv=none; b=hBhPrXQaf5l04XZLxkpZn/kKbw+XM/J4Zu5aHsO4OrAbJ6+eOeSd4r6scw5BQ1xEHlpDsXJ2mJtXuGniCo1YZyPi9XNMaLROB10oBCWiy9E4DMmRwHv1e2LSEcJYNMUE4f04o09synzV6YTEp6CWmbmEG8JEpC5XQh++3+AYfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936186; c=relaxed/simple;
	bh=jRrHgiEv5YrpuZPjYjnGtdk6oRN9GqngHkVDqIa9fq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPW9r4JS//PpQLFEAK7ih0OZiY1COLKUa8+81YCmT65fRiG2jZb3mKoTOaDitAYyvIl9tA/4U4AlVYZQzbnZTJfv5RvnOWn/IQCayK/Kv3jrv0OAyogicywhbOiLApwTT+qUIrREVGCYR3eu+qrJsgoLi+GWhrCGsDbm1fIj9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eKQrMPZE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso42062561fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705936183; x=1706540983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6qCq9mjgzXIcyyu8Xldo3rtV6iy8jAQllHcjOflIOk=;
        b=eKQrMPZEGyYeZtG2vgzfUwhqS92QzC99jymhERUWJJ5uO5ohRoluqqQJOnVDyCzv8z
         J4CsTHr1ONmE6UPX+Z67J2E79uZK26VSSnfEguFyQcDYH9UQmA3FnwLiiqFVAKFEI77z
         ttK9GwubKIkz6jVYh6lIw8ZF/ASMdU8SxRAWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936183; x=1706540983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6qCq9mjgzXIcyyu8Xldo3rtV6iy8jAQllHcjOflIOk=;
        b=LDRjz2jYYRnvYafcvKPOacOLm4kc7Ev+Ix2D5b+m2XjO9AP14tvI9M0n/bnJ/575O0
         61o9/EX8ct0Cuulw1RtGhl92U+pogOE78qlmOHsEL2KS7LVphGM6J6qcF54fNDchAQbm
         3AL54lPvEyHlosbu7ojY2V/jh2YN7IAD3b5Ti1zvXsBBCqVxn6zoXZFkDrGdHAL8ePCf
         oABn9m1quU07Jda0M6k/CRVW2n0N8txrX+ziSUxG/zsbAt7+7VBbW5+b9STpTz/dO8cn
         F9720c5rXihhwmpgO73UHx8+LeUBMFeikN0PryCDh4lTIw+ozlIuOgOODHHJiRff+7mE
         P5Vg==
X-Gm-Message-State: AOJu0Yz3uNRaW+vN5qyzPRDiVn5CRRUdllF3L4T6A3GUGP7r5WNEHGsT
	YuYEz8WZejlQTF/qefJ9jL7hn4QanROEnBN242iyy8bZyq2Wjdv9PuYSrZMIVoAEe3JbfbrPZE2
	iFPynBc+O0HlvpGA6nnf8rT0wBultq8LtVqdV
X-Google-Smtp-Source: AGHT+IH5Di7gCKwIzxDI07ur5JWxCa0Zy2fz4w+FDojoTf5Vohxn0BkqSkHrzamnSL2FdOcvdK/g7QH5prbur3jeycY=
X-Received: by 2002:a2e:a408:0:b0:2ce:fd80:210b with SMTP id
 p8-20020a2ea408000000b002cefd80210bmr890160ljn.3.1705936183235; Mon, 22 Jan
 2024 07:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084328.3135503-1-lma@chromium.org> <20240119084328.3135503-3-lma@chromium.org>
 <1e7b8590-7dc7-47a8-8105-6d01db627f85@kernel.org>
In-Reply-To: <1e7b8590-7dc7-47a8-8105-6d01db627f85@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Mon, 22 Jan 2024 16:09:32 +0100
Message-ID: <CAE5UKNqF1h5SCrVEjGR_5jeDZGBkbSZGxZTJ39Wb2vONHLdk2Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] watchdog: Add ChromeOS EC-based watchdog driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:31=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> > +     wdd =3D devm_kzalloc(&pdev->dev, sizeof(struct watchdog_device), =
GFP_KERNEL);
>
> sizeof(*)
>
ACK.

> > +MODULE_DEVICE_TABLE(platform, cros_ec_wdt_id);
>
> device_id is not placed here, please open existing drivers for
> reference. Why this isn't referenced in driver structure?
>
ACK, I will take s3c2410_wdt.c as an example, thank you.

Best regards,
Lukasz

