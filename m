Return-Path: <linux-kernel+bounces-132110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1B898FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE22831C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6013BADA;
	Thu,  4 Apr 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGHQ9Otk"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAC13AD33
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263508; cv=none; b=k08RrOmzsBsKW/UcY6FVcOY6exGGW7ix9KJ5B89yVHKWH5TmCDCMxrEbpHR0IQn3SkVIxzNR8OvVU0vGVyEe4DPyRPHjHkvD8NBf25y3OCjYMccAP6s18YJC8kufhfGtZ6FHy2b8e6baEgwZW+VINQSiDAYcXvdM4Ym4hN8UJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263508; c=relaxed/simple;
	bh=4UO1VMYWun6t0P6nH+mG+xdFydZVyE+pOaRYVYx4yog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRMsZlP42Et94xpdCAfFPHRd76oKxtKGjv77uLoDcUmU6bYKo9sbw5Km8K7rJdbzgxxShrz0a6S38FqKB3ZnX+0e9HB4E1BP1pQXed2CmX0klS1+AkFBGn9PDxxhZsFxmZBt6j/sSN3nB0jOP3kizcf3TY+zPsVzj5nXrHHwsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OGHQ9Otk; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4daa91c0344so269728e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712263505; x=1712868305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF8FNJKbIf/Wqy3NgLHLUIDfVpXMUebZHQXlpWQnHwE=;
        b=OGHQ9Otk51j3QkwxtNFs3R5EmKGoHTZB6h4lLf0rwEowgUeyMnIIhevJ5+qcroer9t
         FQQWNmLgX1L+7qAqFa5L5aHmcDr2uIc4nUYPOYj7prGRk+fdrC5awWKBSQUfFtlaS0G/
         MkmFjoqOOTOnslZKxXdxi6SnBKrGOto2s8lTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263505; x=1712868305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF8FNJKbIf/Wqy3NgLHLUIDfVpXMUebZHQXlpWQnHwE=;
        b=RA0PpeA6CE0I0CeNQQ/8kpJ4xxJZN1TGrFAnbN1M0FRhEM+K8nQfaam+Rlo2nYZkfw
         SIf2NkPUxzw2yrsbZIRsd1ACmFa4TQs6BA3ZVEBJ/gX5DUQiC7sKR0BteV8Vx0cB0Y+A
         1F3TMxWYSuIi50hfVUiO8IaPu2dD8FDhFRljHckG0Vidifed1sLFR9j60LgBoSJVIQ46
         44jJvLA8L2q2GN2OhwEmo0zEW1xQ4741MNHSY8M3cExKrI+P3OCY1IsLL4dj3mEd0U8p
         tuQNhNwPIEMtH4znrqu5xTQ6KYxTQyfwilwenJ9C/WkYpwbC2qZoYEbRy5/mV6Yl300m
         5yDg==
X-Forwarded-Encrypted: i=1; AJvYcCWpL/Zf8kO1DRJgXl9EZeZtv0sgrNJjhEIE63lyW8lEkMnVtt0TLC/ip6WlV6Ao0XwbUYJrV/G1ctxpsTUarvfBzkmOL1pSeqeU3kOn
X-Gm-Message-State: AOJu0Yzdt0EcLXTKYbZilo5o+D4BcFLorAkHIuZ+v0wwkLSxZTCipB68
	OpTYijW5kqbtNEfoH3HuSDwDY69o4lt10BMJLOWj/RQ+q0nkx8Op/HewyvsoSCrNr3UIjlI2tTN
	JDFnO4WQ4Y+CMkGupltei/KDljWFAxnvux5Ie
X-Google-Smtp-Source: AGHT+IE1aT12rSJQsk49m0s1WDAmGtg1boyflA0mWV27eiMvdQWflqasXIA0kULyhEfYJsr1EVtT0Cfl08bXuJZCc+c=
X-Received: by 2002:a1f:f2c6:0:b0:4d3:3adc:b639 with SMTP id
 q189-20020a1ff2c6000000b004d33adcb639mr3392151vkh.6.1712263505418; Thu, 04
 Apr 2024 13:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org> <3ezjocthsigo3t746slmgzffnmpxw7wwf3s535basiaf2qy6io@7ocxva6ndsbt>
 <2024040449-average-foyer-defa@gregkh>
In-Reply-To: <2024040449-average-foyer-defa@gregkh>
From: Pavan Holla <pholla@chromium.org>
Date: Thu, 4 Apr 2024 13:44:29 -0700
Message-ID: <CAB2FV=4TQZwM6bRSeBhieqU2H8yxt3NWsey55a5my_i1La0fJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 03, 2024 at 09:58:33PM +0300, Dmitry Baryshkov wrote:
> > I think it's better be written as
> >
> > if (WARN_ON_ONCE(val_len > MAX_EC_DATA_SIZE))
> >       return -EINVAL;
>
> So if you trigger this, you just rebooted all boxes that have
> panic-on-warn enabled (hint, the HUGE majority in quantity of Linux
> systems out there.)
>
> So don't do that, just handle it like this.
>
> BUT, if this can be triggered by userspace, do NOT use dev_err() as that
> will just allow userspace to flood the kernel log.
>
> Pavan, who calls this?  If userspace, this needs to be fixed.  If it's
> only a kernel driver, it's fine as-is.

This code is only called by a kernel driver.

Thanks,
Pavan

