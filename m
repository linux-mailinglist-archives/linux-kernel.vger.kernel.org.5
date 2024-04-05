Return-Path: <linux-kernel+bounces-133467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CB89A421
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325211C224B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ADF172779;
	Fri,  5 Apr 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ACe5f0S"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF7171E6C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341299; cv=none; b=TVLEkeaw+705wYLf2ofwXxB0J5+UQz761Cj+fh2jucGPIL5e/r4Gh0wkRhMjPNwKvJMMHFwNU9v1ViFzWaf5ipxNNhGThU66IVKtAC8R0Nkb5qifUPMU07Ge0SWWuum9aC1sP9vvgbCWUD3YqWTV4+toictvDedY870ArqcJB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341299; c=relaxed/simple;
	bh=1ExWG6lnq6Jb9Dq5C8ieewhWbtqdhaSVWPy/xy8ZHcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5g2yOkvbWY3oRxoVWMMKQbkyBybFlPsIxlY4GTBQXhJ7ur/iEVkUUexIX2BP10sMpEmxqetPKtoEZ58eRKtfkcWW7D8kqzwBl1iB9UbDGqK3xHF+0VoPqbeK81zcKoXDz2ZxX7taU1KFeURbzvJZ0Zrc2KS1xNxcivc7tUe3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ACe5f0S; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so1895a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712341296; x=1712946096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ExWG6lnq6Jb9Dq5C8ieewhWbtqdhaSVWPy/xy8ZHcg=;
        b=0ACe5f0SGLHB4Y9zBhen3KIZ3UQ6WTPJA04JDnrsqZqWlMLcv8kqWX6tmIdS3RfamY
         GnXrAuMCAFuMEvMspXtATTz6wJKn+O5QlxXmV65CqN/YExcf1hShY+F4SviMJiVf5Eed
         XJBXOrMMSq192xq977SNHGbsF6AEtZFMi4US7wSrfayzoPJchnrVZxyFsc08qtUTs/FL
         iKY1Lw8OoZE//93qZyOO+lRAQKixXtrgUXZaRQ0yM/Yz2qR9m3FeOZO3JLE5HQhahT3R
         D/27m6XuhmUCgB1WgyUC4MDmK8gCEoJdDbPp4x+mqXMaYH2KSAEd063S8m1y10/Z6GD9
         chZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341296; x=1712946096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ExWG6lnq6Jb9Dq5C8ieewhWbtqdhaSVWPy/xy8ZHcg=;
        b=v4fxKsm+IVYLLa7/TGIGiIoizC+Onw+KQCPSNmcwsDiXgp2iB/Nyj1fqGvIFDRoGuS
         07tyMaLhCKbOCoMnKsojXJNHdSDFhA38fgLanY64Iv76EczkaoeZn2xksY9SuMyxUeM9
         oDBIY5f+FteGpOeqyOXdbvd2CzSobUAI2aM4mr2rTlpxIt1kBOgLbFE93pdBTACRxCwE
         HSRz+4EU3Gxt1PtN8UbVBdqS4sE/IEhRYhldMCAkLXNCgrn7Y6zZAcnpQ+Uo7ySue1/0
         KzqcKWNI5bcmOhH8IddESeSNgAF5lMj7txUIz2nkrLwFt9xbx6U/YFPls4z7plLg9G7z
         O0cA==
X-Forwarded-Encrypted: i=1; AJvYcCUTGWA5xOCeHO1Kmpjdjo/M5Ay+bg2KVWPtQMoOLE+ZHiEYbxpb6710vT7fttJ69FMUJW0QJJtWpo+tyaVge9lAf1P23DrUPVowo72v
X-Gm-Message-State: AOJu0Yxbhg25ZVLDL3jePdAl/VSmZUcjYcjSTkX1bY1R7F9CwvT9/eJj
	RQrCcrh7VdJ37DAtn6BAN5MzJwrHzPeNNPVEwW+un4Sau1SKOYIYVss4lYm3B1XlYm5+BWV9ap6
	MEzZYoo6RQp5ZU1Mpjt7hGrpeK2hTMW8aP4Q02OV60TXqhzP9uw==
X-Google-Smtp-Source: AGHT+IF0TOxjhh5ptizvwkzErgFTDNG5iNFpHj4BGn2JdhSEi6qEJVwGphBia9rQJBd6eGz0eyMP/9i0yD159Z1bewI=
X-Received: by 2002:a05:6402:3d8:b0:56e:22bc:754a with SMTP id
 t24-20020a05640203d800b0056e22bc754amr17913edw.0.1712341296037; Fri, 05 Apr
 2024 11:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712340972-13643-1-git-send-email-venkat.x.venkatsubra@oracle.com>
In-Reply-To: <1712340972-13643-1-git-send-email-venkat.x.venkatsubra@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 20:21:25 +0200
Message-ID: <CANn89iK2Yq9NSruRQaB3408seaBpah_KHjjeXOtzw7i0-_NX9A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipvlan: handle NETDEV_DOWN event
To: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maheshb@google.com, kuba@kernel.org, gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:16=E2=80=AFPM Venkat Venkatsubra
<venkat.x.venkatsubra@oracle.com> wrote:
>
> In case of stacked devices, to help propagate the down
> link state from the parent/root device (to this leaf device),
> handle NETDEV_DOWN event like it is done now for NETDEV_UP.
>
> In the below example, ens5 is the host interface which is the
> parent of the ipvlan interface eth0 in the container.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks.

