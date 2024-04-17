Return-Path: <linux-kernel+bounces-148796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28D8A878A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414D6B25C52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92308147C6B;
	Wed, 17 Apr 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJqty7dO"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A513A265;
	Wed, 17 Apr 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367575; cv=none; b=llgTF6/CY+dteC+LrZry//LfOgIbWtONsj9tiHLqsDgMb3ufNWtXB48jPcYG9bVs6PpkjdQ+97G8aGacVZIodFRQ43i9GTtmDEpUc5L850G2OqANp2cypGOjb4PD78msiy6b8Oh2DmDabrPNXNcr0FipVkQll4jcVO1nx/+rOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367575; c=relaxed/simple;
	bh=66HHTs/2NdCUJhw/VTXrtHbgKW6feJo+E59Bk3vfng4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxg1EcdPXfM96wTVVPSHYx50876ORcv7Ii9UEZ7eWtsdoFgX9OEHJ1s7D2LhO6Fsg0qCIRM+D4LIjUPltgci/U7VsE65Se/XA3WacsCb5TlKcI8lE8PUZNrYGsrKjNz3EsMAD3VbaCiVJc/z2sp3dz1yCI3H9WxylKPuJPyLfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJqty7dO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so715639a12.0;
        Wed, 17 Apr 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367574; x=1713972374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66HHTs/2NdCUJhw/VTXrtHbgKW6feJo+E59Bk3vfng4=;
        b=KJqty7dOuK6gfwV4RuK/L2iKQLS2Oob4rYvSRb5ovTrxKiK6EKjup5mjpjRMrFxeGA
         0kKjDWgJtlOmo710B3T9udrc+WljSJtkDuxQhgEE8RINc7HBSJIYrsfyAreW9toa9/rK
         a9RwGIqhqR8l0w0TijKEwLvUWIjNi1taod97Lnh4BDllM/Kn4FouKPWx/sPY9MxJMpSE
         OJjxj0K4hezztm4lQgzK2tKfUMhjTMuhiyLb/sSqlXGo3n7ilgsrUnZ0mlhQ4P9q0A7e
         879rwffmXj6UV6tG1s4kYYfYLzUzqRa44Wy2bHAdxVLFrqwKHsjxYyWk5yBlTwpGqlEI
         kvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367574; x=1713972374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66HHTs/2NdCUJhw/VTXrtHbgKW6feJo+E59Bk3vfng4=;
        b=D7k86VzsB5uO+sHXQxUfRyyhF5gN3Qb6AyPKIlVhMzDHmKG1w+ArvM/FZkOcgp79yM
         N74k/vn5b8jnhbbXDoXy6qkYl7/OU8uL6PueYkMWFrTOITAtcgOIWKgMBXLCtk1Feh0l
         QyFdnqTM7wfy5PLGC7g5THip+gXEfNz8fv0obbvc6WB92VC99Rb8aG+NeRA4IO4INq7V
         yg5iX7qrC7hsnfGJtDzIf/6NNmn09tioUCYH85VMjNVOb1FGrIGFSAaBQlbbDa1/ABlR
         FDeuZooaX8Ed9bp1HWkO21zQOKlHaob4oalmMeAfXNg9v6bxQLgkbOYZR2AndmKIDhRJ
         gZsA==
X-Forwarded-Encrypted: i=1; AJvYcCXl6thyoBX6NQllCYUPhSXmcQ7E/79+2BP7Io92hKsWtwkY7pN1Tu1UhjBaSjjB39IgnnQX7GjpdY3UBbuHb3N0OcUaQx2RyxcA2ZbIumArxbUlmutLMHVfUXPfueN3Q+IQTzx7hKZetCkIx7W2h1cU31kaoDuMz+iuh1g+Xdba
X-Gm-Message-State: AOJu0YyFFnWTMsRBemnmA+lgDOdcrJu+GyYVCRZDNbR/o/gz8ZmnijmW
	b9/bTQEPZLuf3jw5JfyeFimlcvhIvZixUAn2TiIHxaMSFZEvI2515QG7X1zZBPJp/Un+V1lv4wI
	YX6djlHmf0i7UmBcil4CdApmLrJMoSw==
X-Google-Smtp-Source: AGHT+IF4i0SrzyxsnPtLYiNicbYtOM4Q2ZIHhP8ToGBtaB2RlbVmAYmZGYXvLP2KLwY5nRo6rW5De+g0EbZ3thBOyqo=
X-Received: by 2002:a17:90a:5289:b0:29b:c31:1fe1 with SMTP id
 w9-20020a17090a528900b0029b0c311fe1mr7822149pjh.10.1713367573788; Wed, 17 Apr
 2024 08:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com> <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <Zh6m3jkRovDutKnZ@fedora>
In-Reply-To: <Zh6m3jkRovDutKnZ@fedora>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Thu, 18 Apr 2024 00:26:01 +0900
Message-ID: <CAMZ6RqJF7P1rGMwejmF_FM25Xtjo+R+zEGkkWnh3=hiShB_piw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO 15765-2:2016
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Content-Type: text/plain; charset="UTF-8"

On Wed. 17 Apr. 2024 at 01:27, Francesco Valla
<valla.francesco@gmail.com> wrote:
> Hi Vincent,
>
> thank you for the review!

You are welcome.

> I'll omit from this reply the issue about the standard to be referenced
> and the CAN-CC naming (discussed in another thread also with Oliver).
>
> About the typos and formatting observations: rst is not my native
> language (I'm more on the Markdown side), I'll apply all the corrections
> you suggested. Thank you.
>
> Some other considerations follow.

Aside from the 2024 year bump on which I replied separately, I
acknowledge all of these. Thanks.

Yours sincerely,
Vincent Mailhol

