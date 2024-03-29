Return-Path: <linux-kernel+bounces-124177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67123891370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9181F223DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD43D964;
	Fri, 29 Mar 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sylAsleB"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6938FA1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691779; cv=none; b=GlznNIIorGsSmCm5tsTAqnqZXy2QNKa1aHbmc1BzgbO3wRGa9YTeqKx+YHeS9ZfGppy7v7uvo25ylMuXuIARKP4Gyrm9yOy8tbM9SGsBWcgXETgMiU5HwVGas8cJMLZhFnaknGG0bDfYiXwTKTjgaFQB3vPhQtl2YtH7ufB5V0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691779; c=relaxed/simple;
	bh=I6gb3mouBEmAFWwdt7bCZ0uEsJC1XXBgedFnEv3UMV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFV/JVNuarYRHYYbtmp3t757NAEUOdm5gm5KBB8e3t+mj/iVjFX1K0PE67VT7osfsr+Kuy97fUb0AkisVx/PpHcsIFwwRpXT4PsJmAW9ykaJErWfjg2nswYY6UXo9P9ffe0nyQ+Ivvo++E7v20m/2g+dKShUZ1pcW2nolq4CW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sylAsleB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609eb3e5a56so17983397b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711691775; x=1712296575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2dkJ/eB3NE7gH7tgLxZzt30oH7th5QfRjoRtkA4jvFo=;
        b=sylAsleBhCd7XU52STkKnCfojR5GokLfwMmmNU/nOCnePdSp5kpaZlHnDvvoz/ZzTB
         f30qGEM8naNXu6/aV1JSNY0z+YtpQObZ++tcRJGXgLX7odn7CLRpT28u/GEQTKLG0hHY
         ZJaSCRL9+BPblab3UCEjXLjf9oaRLIkQkgkBZw2MIQNS3ilFE6OHcXIfk+jxc6PVJxCN
         lHBIMgmETZu3nRcSSuL+efnMVakwznhpYyUfsyzetXVyUHRqQbYnqgZ0eNg9TQjPNWEt
         aBEAhPchjrnW/bQD+ao6LOAG+osNZuHVGp3mYUTgtIlRCPuZjFiZ0Bd4XTdEk+yoh9W5
         h5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711691775; x=1712296575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dkJ/eB3NE7gH7tgLxZzt30oH7th5QfRjoRtkA4jvFo=;
        b=AzRIdbbJLMXxc3ddTXM5vVRIOUHe6pzQS19xuWDQ2Wmj/dP5XlQOBcsD34UZgdsh5b
         mSc7Ome4Y/gmwpSnKAACjRwjXgz7ivBEn/qXbfXtHHjFeKljnYlAl5Ou7EPHEeefZLei
         TG5KIFpOPE3AGhwH4ll5fE/btHMnf8ffd21GbuBkuojrjwdXRN9TEQ9AfLpXCck6/j0r
         AhTFzTXJILDJXRba3CGXH08wnURhw8XIfwbgFaqh89maEcZWBN4ms3WTZRBhdGfk230x
         aa/ngQL44WOtWRPRLTOC/HN5GF3POb3M1AlGzVr1l0dXi98OM/x/mt87OtLXkUTgxfxw
         ziig==
X-Gm-Message-State: AOJu0YyM0FLQ9MrFs5cwXzhAzhaHWGWoNDTr+8CPbN059OJYZLzT0QUK
	1nwJhdCdfhbyyaXPLG4lbjhFMT0KmN+tARVj3b6NghuhSZq9Fi7CnvF9gTUBPqAt1pJBGLWeHW6
	wiiz89J8q7qRqn3RDCYoTfbCyUOPRCfscxUM34w==
X-Google-Smtp-Source: AGHT+IHHPjLY3QHFoCuxDon1afxB+hpjMxW50BARoEUlh5RXsRY1+R/40uIOSlea3+3DGKzjg7tBBEkp0xqTH57xTwo=
X-Received: by 2002:a25:6f89:0:b0:dc7:465d:c06d with SMTP id
 k131-20020a256f89000000b00dc7465dc06dmr1354548ybc.28.1711691775003; Thu, 28
 Mar 2024 22:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327224554.1772525-1-lk@c--e.de>
In-Reply-To: <20240327224554.1772525-1-lk@c--e.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 07:56:03 +0200
Message-ID: <CAA8EJppvmaFN1Q5neVSU76gApxm55YfwmxRg=1Z85LcdDEW+og@mail.gmail.com>
Subject: Re: [PATCH 0/3] usb: typec: ucsi: Ack connector change early
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Prashant Malani <pmalani@chromium.org>, 
	Jameson Thies <jthies@google.com>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	=?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 00:46, Christian A. Ehrhardt <lk@c--e.de> wrote:
>
> As briefly discussed here
>   https://lore.kernel.org/lkml/Zf1XUrG1UbVJWzoz@kuha.fi.intel.com/
> acknowledge connector change events along with the first command
> in ucsi_handle_connector_change(). The connector lock should be
> sufficient to protect the rest of the function and the partner
> tasks.
>
> This allows us to remove the Dell quirk in ucsi_acpi.c.
> Additionally, this reduces the number of commands that are sent
> with an un-acknowleged connector change event.
>
> Christian A. Ehrhardt (3):
>   usb: typec: ucsi: Stop abuse of bit definitions from ucsi.h
>   usb: typec: ucsi: Never send a lone connector change ack
>   usb: typec: ucsi_acpi: Remove Dell quirk
>
>  drivers/usb/typec/ucsi/ucsi.c         | 48 ++++++++++-------------
>  drivers/usb/typec/ucsi/ucsi.h         |  2 -
>  drivers/usb/typec/ucsi/ucsi_acpi.c    | 56 ++-------------------------
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c |  1 +
>  4 files changed, 25 insertions(+), 82 deletions(-)

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #
SM8450-HDK, sc8180x-primus


-- 
With best wishes
Dmitry

