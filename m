Return-Path: <linux-kernel+bounces-77790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977C860A46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FE01C2279A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD911CBB;
	Fri, 23 Feb 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9vYX+C3"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED4101E3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666459; cv=none; b=VZtwxIdv0HNfETjJ/YOecpijMDviHVIK6eon9P9Dj/Ylax9ARtCRA8Xi6FTh1SEQYCpG4zq33Fptw2Wb4oqWX4ARrkPxv8f2g4v8mSF+pRgUev6K7SJ/5mi3xY6/dLcabENp6K5VzYNU32XbB1w/R+ox3ZoLnN7Cy/tblu7FF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666459; c=relaxed/simple;
	bh=i2JifP25a53XHtwcXig/NwceTcdJ0ADWfEzWQ/IWSdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH/IxdRyg6KrHv/5F5xtRwDkMlWXg6viuavxQGl3X+AVpypMRPmW/JlDy/JLccFkzngKARqe7vbzfqF/ndN0/880g2OeNrNdeUCbOKDTazq+nMQGZHdyXjeIRbbkJM7oQYSLe+pQXBAOXCePas0U+ggVQOGUFkLi2Lq1D1T6z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9vYX+C3; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso523836276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708666457; x=1709271257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+4f7N01YGRuzC3H7YfM29rrKfvtFFpp035VmvYqKh8=;
        b=K9vYX+C3qtdFJXupZc9GnFEvy5DrONW8wDQj24DmNevZu5MfJ6XvF9sfkJPYzel8eS
         lEdVKlxf6LYQDoIEDZeMXjKSDAtb/38VE2cYGmDtLk/uFTOceVRfNJ9Iqd5sbz+pz7xu
         qFoH26TKZN4REWpd3x61A8V85g+ejrKf0WyV7Y794xEm7ZACz789V9S9UoZma4h5UAJ0
         9HjpBoFoTKM5xIpWjxNWNeLEu5gVee2DxGGbmf+8r7KiwtoxWL5O7qouDdq090XJxqrN
         UOtlo7+hciOW4aCmZNuLlAqxuewfMznOJw2vOKx+J74wLPTZuO2nBnDTDyF8yL1lKCG/
         dy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708666457; x=1709271257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+4f7N01YGRuzC3H7YfM29rrKfvtFFpp035VmvYqKh8=;
        b=tDkjhXdYbCW5ew9uXShnRXOqMc4ivUjmDM3VyiTBwpYk8w/Gbq3HrOfFL0yuwEY6rR
         Nq1+pyKQPjHjF63P84EznfeHoFKbtZio7aZyKPOiG98sxvtQrdcl3XWXNkb3npaWpCd0
         QQcM5T5G3+Ri3yW/J+91GQXQ3CO/kfD4U+IZXEK0G/Gc+0uB/WTUc/Z8BPPQtts0GA+Z
         l5Smw2w0RUMHloiQLqcicFUgB+cwkkbyPD5VjIebty/f7/CpfGiCRzAG20Z9Ka8saWsX
         pq+002BNoxV/3z194DfEJbCBfA6OA3SUmiF/S0VhjagIrAc3sFlV3VeRC3gKmM9/JmvE
         smMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpZV7f35q3vsHdcJhfSM1hZkgde8u7UO5z+LUhpNFP/LsCYRbOgB3bPOZG9br4MjFCmj8DIvbMpkSbR5mrGT6QHjcGP4/T+EAJonCA
X-Gm-Message-State: AOJu0YxN1r/6osIoCavAI0sWSuferh3G0tczgUYz+zC/v7rP6oZFHEwV
	ZugwQPnCRRVw5c5YH95ZPAhkPh5hutVPydFcCT2hVSCBiVPhTXUEhkjGc7rJx440vu+b4yulK/l
	BFDXeCreDjgEQonTI6jEL/Ox0iTNyEDuicBKGWQ==
X-Google-Smtp-Source: AGHT+IEIoWhbAWndlBi8oVDHO2DKmfrv13BTSSEDbAyCI/96CgFgGNUl2BDpjrXGck56iGDlhhcC2mBehcpO4kLorjk=
X-Received: by 2002:a05:6902:565:b0:dc7:45df:a04c with SMTP id
 a5-20020a056902056500b00dc745dfa04cmr1246211ybt.43.1708666457014; Thu, 22 Feb
 2024 21:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com>
In-Reply-To: <20240223010328.2826774-1-jthies@google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 07:34:05 +0200
Message-ID: <CAA8EJpqwAg-qenTq3MZCb74rn8rRaMxrsnmZGMwff+ABGENEGg@mail.gmail.com>
Subject: Re: [PATCH 0/4] usb: typec: ucsi: Expand SOP/SOP' Discovery
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jameson,

On Fri, 23 Feb 2024 at 03:04, Jameson Thies <jthies@google.com> wrote:
>
> Hi Heikki,
>
> This patch series expands support for partner and cable discover in the
> UCSI driver. There are a few pieces here.
>
> 1. Some cleanup of the GET_CABLE_PROP definitions in ucsi.h.
> 2. Cable discovery and registration with the USB Type-C connector class.
> 3. Partner/Cable identity registration with the USB Type-C connector
> class.
> 4. SOP' alternate mode registration with the USB-C connector class using
> a cable plug.
>
> These have been tested on a v6.6 kernel build running a usermode ppm
> with a Realtek EVB. Let me know if you have any questions.

First and the most obvious comment: 6.6 is four months old. I see that
your base commit is the usb-testing tip, however you declare that you
tested only on 6.6. Now I'm confused. Did you test your patches on top
of usb-testing before sending them?


-- 
With best wishes
Dmitry

