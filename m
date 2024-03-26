Return-Path: <linux-kernel+bounces-118591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D188BCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033C92E32DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC481C698;
	Tue, 26 Mar 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L2s3b6qV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4221B948
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443508; cv=none; b=usWLCNkTjLxAIXdJ0ZAuJL4UX97aLiOVi1vjfqnHMSiVJ/rHifsAtj2yeoyvsGRTeevTN/pRqXnEl7JdsdXCFvsiAJZKoTHrPhb1lMRkOV9nAISIV/aHqbxyOn1AH+MaL5xPAhDiqwWOMk2OmLuK2lCGWtQvhUw6HEeqY9CH1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443508; c=relaxed/simple;
	bh=n4G3Pxgl7Q9i82J6sK8SAiR5VfV6Vmb7zW7/xd8y8hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWzeZwMLQ60HC0UxitY5hZhvt/Ih20yCviL4q3ip34KY2NbJtnMjuvdnivTdZ7rKPsK+illIruZ3+1hpU/DiOg/MIM/reXsffe1qzE+SpuUC1Hdfxio9p7zP2dsZS+iqpFPhl41veoBV6ESbNrye3q9tLQNHXg/7hU4/gQxnc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L2s3b6qV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso73098961fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711443505; x=1712048305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pPV8N1R6vzmSjl6Uwoo/hXMqUFTVOsFF3LrLWnsiMo=;
        b=L2s3b6qVLx74juqMfvpYQSLrUPMczmGo2C9MvY5HTcVFAGq0CIOvmdOYEOw0K2p6kS
         D/MI5GE9DOvMUdBtiH8Ku4PZVrmxQ7Ql3il5/F3zf3oF5zduinUBiUhrp8gtgqnmpvE/
         fgzDiX3Qu0xkauPYrZCR7SKvcaospsYSnuLgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443505; x=1712048305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pPV8N1R6vzmSjl6Uwoo/hXMqUFTVOsFF3LrLWnsiMo=;
        b=dxMySa0f0jWbXyePt3vdiiK/pCKc5v3cng7/lCC9JMKdll5dC/0nxDPiRbahaax5Xg
         OM3c+jYAM3OZA9EtP+4Xt5O5gV7EfYLfn2g0ucABAdT8CPBxDKVqx29zPCPtgEdMg3Fd
         cblkeajYpPjWOMS543YYlhKp/SDHngIuwL/uRrV7LIzMUifKu0T4y6vvHtpomhQzJjfF
         +LJhVDdkVgTSY+Kws36+U2RuFn7udEoQGhlp3j4Pqt08nIzUd8uYfYvUvSP7hB/gFB2l
         mlTGi8wRePUWKmJWVHGbuWezZnk0zkhjwEpfaAH6F875fZFLgbRUBGAFhK8ByHkrryaY
         tHUA==
X-Forwarded-Encrypted: i=1; AJvYcCXTiQrjOUev98tMzKTTLe+tehq/VjlM0tXtFS3q+ZfypMaz/MQfSQSTx/qHkwJxjccAXc26fueOYXwis9X34SUAM5oXtyr5YX18q7rd
X-Gm-Message-State: AOJu0YwlmwNNYfOE5DDfcq7VIg/cdepKd+6uzb+aEilMffeleXGiJzkZ
	44TVZYBy90oq3jj0eQKMQ/jeV5l5CnQdBe/Pv/ddEutgLyS0Vnkzc/54H4XzNg8cU33yufLXIZJ
	7J9T3m4PCw7c9qAV32LSJhQbDAW+Ax7VeHAw/DNIpzAUPLU7abyMV
X-Google-Smtp-Source: AGHT+IGgjEHB//9LYudrHBhU92JAua1xIsExhovLAxvA8FaCVPRVpU+2JP2IIRNltDvxh0MCJ7PmoJyqfaNH5qmEIYw=
X-Received: by 2002:a2e:834e:0:b0:2d4:3c32:814d with SMTP id
 l14-20020a2e834e000000b002d43c32814dmr461489ljh.26.1711443504690; Tue, 26 Mar
 2024 01:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325105452.529921-1-lma@chromium.org> <CAD=FV=VHps2d4dqLXCqE=hNMbk4pxeN607nFA0nEkd7chNAr3A@mail.gmail.com>
In-Reply-To: <CAD=FV=VHps2d4dqLXCqE=hNMbk4pxeN607nFA0nEkd7chNAr3A@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Tue, 26 Mar 2024 09:58:12 +0100
Message-ID: <CAE5UKNpob9dT4YXSYKsrKGQ3cZP7o3OF7y-eb925Xd-gH3BEXA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> nit: checkpatch should have yelled at you saying that you should
> specify a commit in the format:
>
> commit b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before
> really probing")
>
I will do it, but I did run the checkpatch (with --strict option) and
it didn't complain about anything.

>
> nit: I believe your sign off should be last. It's also unclear why two
> signoffs. Did Radoslaw author it and you changed it? ...or was it
> Co-Developed-by, or ...? You'll probably need to adjust your tags a
> bit depending on the answers.
>
Yes, we've discussed this patch together and the original
investigation was done by Rad.

> Having both ends of the usleep be 400 is iffy. In this case it's at
> probe time so I wonder if udelay() is better? If not, maybe give at
> least _some_ margin?
>
>
> > +       } while (tries-- > 0 && ret < 0);
>
According to Documentation/timers/timers-howto.rst:
" SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
                * Use usleep_range"
It was also pointed out by checkpath (when I initially used msleep).
I think giving some margin (eg. 400,500) would be ok.

> I'm not a huge fan of having to check "tries" and "ret" twice.
> Personally I'd rather see a "while (true)" loop and test the condition
> once to break out. AKA:
>
> while (true) {
>   ret = i2c_...
>   tries--;
>   if (tries == 0 || ret >= 0)
>     break;
>   udelay(400);
> }
>
> ...if you feel very strongly about the way you have coded it, though,
> I won't stand in your way.
I don't have emotional bond to this code ;), thanks.
>
> Pretty much all my comments are just nits and, since I'm not the
> maintainer here, my opinion is just an opinion. I'd wait at least a
> little while for the maintainers to comment before posting v2. I'm
> happy to give a Reviewed-by tag when some of the nits are fixed.
>
> -Doug
Thank you Doug for all your input.

Best regards,
Lukasz

