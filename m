Return-Path: <linux-kernel+bounces-118142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EC88B485
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388FC300A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D47FBC4;
	Mon, 25 Mar 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/PgK3S+"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B93398B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407043; cv=none; b=W1WB49CQkz/VusDaYCprZ9WMRkEG6kuNFTufwU0bOccO3LnhF5RCoHHg0O9S5Kvg4+Mqme5QjbtSP1raCL31/dWwCBpDldGjxsqVMzcHYWY4yz4cTtfGZN+mJZUw9UL5DYzbhleVxrKcrqqIrLLyHMenJhO8MkY6Y8SsO+UZgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407043; c=relaxed/simple;
	bh=fdj5WC4WczRnsrMDwrvmZ5LSi6FYFmAloHkmxhIb2Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsEvyJ6jLUw78k8mnR3omf8+f+9IY5lZSkCmbyYfcbsMybuaL5rFU3TRk66BmRnuMQzqk+7ClrK7o682XyliPGnXwhRYpnQksxrIo2364iz8olKeSW66BKaZws3uaNuutrzNLotZNGGCtLYnFr26EW71nDh8zModvZ8H7fWScGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d/PgK3S+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789e2bf854dso293335885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711407038; x=1712011838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yawrovRasVBRHceCsqRRDcxsuqGTGGt+XKEa9F3SZL8=;
        b=d/PgK3S+LsssiW7CzMOFh7iSzpkdJilMdKCHXcH9iUTWj+TV29UKWEHncjdF4NOmPp
         kSHX98sYCj4Sx/RKY5oVGE31Siu5jNEkpXhL3pibu3bPe/7WA02ov0JtKV13hPXjokbH
         zFDEyN/c5AWUFWaRzdKJTlH09NyWDwi+vhnCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711407038; x=1712011838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yawrovRasVBRHceCsqRRDcxsuqGTGGt+XKEa9F3SZL8=;
        b=PL62YJnM+hAU8gyaksXU1585Y5p7NWyFb81lfiRp/8Iyc/xI7Du0Pe+fURSHTKrFVs
         ytfM9WCho9DVkslBjwmkEeS3LG8dC6PIcof4y++SAK/rTvi/N0z5qBi4QykSalbSuiTs
         aT6Jd43/xGEjB5BZHotJ0lwTfDNVe6wZYjLnfMFMpayu9wEhWeVaN/xomIhS/3pUGjoS
         GOdjgvoTH6h2nrHF7HpNgRQzhawRACspRdt5qAX++q2B1copc61Bs78uB5b6VYIERJFA
         OJtzKG0JfSRY2g7vHbYsX1az5pTPImHKYCasgLxW6iP9tpIUOueOxwtQ3qO1lVaiXdd5
         /z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq7O278KRTiK1nL5wKI6f8GyiwTIIQO6g2AmURa9gU0Wt50Wk+uBHONHtsEGnvKdO/viBZBOZfost6DaDowpr4Dsny4No0CDYgHnpS
X-Gm-Message-State: AOJu0YwQeY9f0Sd4SKGDt0r0s/RXVOtf77Xjd+D7Ov+ZplGarqAzZRCx
	WvrgLgvU2xXVR11Kb/rHbn/ayE5AYNS12ZYWnX/BruanXuUVivpKDytWQcGTd2NqYwznv+vS4Eg
	=
X-Google-Smtp-Source: AGHT+IHMBAWz6bdkR+o35I5aGInvKYHGfNZlwkazLTQ3d3bXhAUZsLF1XX1fMCoYIyekN+dPYTNtrw==
X-Received: by 2002:a05:620a:1375:b0:789:e6cc:5f7b with SMTP id d21-20020a05620a137500b00789e6cc5f7bmr8087605qkl.48.1711407038567;
        Mon, 25 Mar 2024 15:50:38 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id bl18-20020a05620a1a9200b0078a5de83e15sm524064qkb.30.2024.03.25.15.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:50:37 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430d3fcc511so56771cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwmdOL4dDBdjbCh9k8qHM7Y1nWz4g0j2kVqe2FDl74VRHKf9kUlUQMlHzF0S66GyLVZ+YZUKsMpFWtyHP/KVILBuwM+lKW30ux7zv/
X-Received: by 2002:a05:622a:22a5:b0:431:3887:ace6 with SMTP id
 ay37-20020a05622a22a500b004313887ace6mr57851qtb.26.1711407037327; Mon, 25 Mar
 2024 15:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325125901.2524752-1-treapking@chromium.org>
In-Reply-To: <20240325125901.2524752-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 15:50:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcYZEpOkKL=7EsPKvo-Adfwx8kqrZWPJuwjk5TyTHGvQ@mail.gmail.com>
Message-ID: <CAD=FV=WcYZEpOkKL=7EsPKvo-Adfwx8kqrZWPJuwjk5TyTHGvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B120XAN01.0
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 5:59=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add support for the AUO B120XAN01.0 panel.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Looks fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied to drm-misc-next:

1864c45deb77 drm/panel-edp: Add AUO B120XAN01.0

