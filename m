Return-Path: <linux-kernel+bounces-117744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7A88AF00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574151C37710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CDA50;
	Mon, 25 Mar 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+KwXKLn"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A51BC4C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392334; cv=none; b=MjSGxABGAxgJhjvEZDHxUNedQlgLWg+e+bMDu1BIBGh38Z9BT5C+IBL0twNBlLUu7SWRhXPpxWoVvOTLMGmFGqPpjRR5g+8t5n8hZXrofkNaof3wyy9RnTEzKg7GVCO6Onh3f6575LrJMp/KB8A1/xjhgq5Dhc5MKQNxrpvlcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392334; c=relaxed/simple;
	bh=hqfeXNrriRE+vaPKUWSarAmC5GZL1ffLl1p6HZH7H0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMH9dEddos+kfmICtu55HdvgXPGpOkhOFnMyWBJIr0I8g8nEGvW1vMH2c9tLnkaZWE9u74yhwqtrVdE4ldV+rrFs/NtjT0xWyGOB/ZrGp5JnxAWOC7i1Wsc0l+y1L0u3CASOaOjzC83WJmfMlVzVhew2dsxSAv8MQ8tyKvOBDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+KwXKLn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso1227802a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711392330; x=1711997130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqfeXNrriRE+vaPKUWSarAmC5GZL1ffLl1p6HZH7H0Y=;
        b=W+KwXKLnHiVB5ug13vVAKueIrf7naLnnSsrWb5f+JU/97ZTL9XMi03rSJw5OqWgGBb
         9X10PgLACVkvlh6H147qAh/cFDVALhPuAgRWcygMCTSimGKo5LjUughh7Cd12EOmH88Z
         pyLnjx5dNficG34mlCiBUBL5XZPXPvOmb9kJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711392330; x=1711997130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqfeXNrriRE+vaPKUWSarAmC5GZL1ffLl1p6HZH7H0Y=;
        b=xMMf5+gURZHSPSqhhaE+VUG5+qlhfD5oUwUEkgrZzsaA1kbu5VdKEbmYc8E66suKdE
         gou6a/WcQU83pUu3EBax/YVzs1gS9i3OeNZaqsyRyzucFXlfRkJZL9Q45I5tLrBFqkZS
         utrcoI9dDqtidFeYYpSw4UpPEyF8idYK35dYDVPAIF3Wxb+7+Ah3iTy3EZM/X/JNC2gT
         UNNEc3MlJg2WOcxb7zwTNxHt6cdRlUUm3WJTdvXhyjtz/5z7bXFU2Tydn3Z60YlRX78m
         vBuCHIK8hN0Lzt7T/Sl2SfdZmgeV0+8bI1IWdbSDBUitlxMaOY9M43jLRpQroLAoy3xh
         Dg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUAe8TkGRyr8fqeUh4uqcHMgZAdGayz6chr+NSJtRFc5z1o+7OSpqq5XHha5XpqttW7ZHsjlMF9jCB5zdcZsVvyJWD52Rt0oszK8ziA
X-Gm-Message-State: AOJu0YzgJpNsufRdN59inisun0/nQJp67/xNND8JrMMh0tHqlVbVwCr2
	8YFdeSAz6rIQG28gkQHT9+aFo50LmIa+Y1xJVWoTw8aozS3DdUXew1JCLMtjgG5QfF/Lkk0aipo
	=
X-Google-Smtp-Source: AGHT+IHKXb3FSb4AaUiqxYIeDQgFYp7CilhAq1HHDuJ203RlzKIJSjk2Leso9/mi24xT2cH67WdmEg==
X-Received: by 2002:a17:906:f90e:b0:a47:31c8:81f5 with SMTP id lc14-20020a170906f90e00b00a4731c881f5mr5165473ejb.47.1711392330423;
        Mon, 25 Mar 2024 11:45:30 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id c19-20020a1709060fd300b00a45ff5a30cesm3339324ejk.183.2024.03.25.11.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:45:29 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148c04396dso4399025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:45:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4HAG5k1iV91IwrfNZM+eRpCLxetI3kA3B+aXblDtSipZg14Spq4OjL5Dy/kvCAHYPAAdSq1JcfimAaovcA0DS1itkOCeavVJ4AI/+
X-Received: by 2002:a7b:c4cb:0:b0:414:24b:2f4e with SMTP id
 g11-20020a7bc4cb000000b00414024b2f4emr5741343wmk.39.1711392329122; Mon, 25
 Mar 2024 11:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102800.1322022-1-s.horvath@outlook.com.au> <SY4P282MB3063D447DA09D35F5FBD4721C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB3063D447DA09D35F5FBD4721C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 25 Mar 2024 11:45:13 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9=0jQA=MWpBOttUT7k67wmEDFGoOObQfYm=ca_HL8GQ@mail.gmail.com>
Message-ID: <CA+ASDXM9=0jQA=MWpBOttUT7k67wmEDFGoOObQfYm=ca_HL8GQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_kbd_led_backlight: Remove
 obsolete commands (EC_CMD_PWM_*_KEYBOARD_BACKLIGHT)
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:34=E2=80=AFAM Stephen Horvath
<s.horvath@outlook.com.au> wrote:
>
> EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT and EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT
> are marked as obsolete in `cros_ec_commands.h`, this patch removes the
> usage of these commands from the driver.

Just because the EC firmware repository marks these as obsolete (and
yes, we copy that header mostly as-is into the kernel repository ...
but it's still a firmware header) doesn't mean it's truly ready to be
removed. I believe the intention is to direct *firmware* developers
not to use them -- any new developments should be using the new
commands.

From a kernel perspective, we could still be supporting old firmware
on old devices, and so we may want/need to continue to support these
commands.

I don't know off the top of my head which firmware branches support
which commands, on devices that have such keyboard backlights. (The
Chromium EC repository is open source though, with various firmware-*
branches still around, so this information is available.) But without
a better explanation as to why these are truly ready to be removed,
I'll say "NAK."

Brian

