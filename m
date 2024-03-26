Return-Path: <linux-kernel+bounces-119876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E488CE12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70B71C66A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B313D53D;
	Tue, 26 Mar 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOqibT+o"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDE13D2B4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484097; cv=none; b=qMkIPH2xgtidlNXE8YDtusMMiQORAdMJEDwCFI4WbTgN1X/uWnosqibpoDNhuZDK2MOj86PRhItWJl/NQQ+s+Ox9FrZUcwF8LOBUB/qYAP0D1883yB9iyM3Aar3ObcalbmWUFSkoDlkxO39mS+/Wgx7Ar25YJ0+hgQ4ncPkXfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484097; c=relaxed/simple;
	bh=yjbveC3/sVvc0YuwNullMml87tRF1pHPon8KDzUdJq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edxveVy+yYM1lb7H5fcNsk5woCWlXE/WF8tFVvVyyNcy9puBVUw3h2hif+4q5XZXhuoYh68Syhm2/R4I1qnbe+YaAb/AyVLpeoAdyzzLKqE/dVyuPOoYNDOIWVkQWSDYkBu0k2SrcB2o4iUAKuEvIYtIHObT2A1z9HFPBR9VPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOqibT+o; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so5419647276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484094; x=1712088894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmPgefE26rhr79NqXAgIqb/l9m7Ev6xlwT5t75HGYd8=;
        b=xOqibT+o+0KGb+IHjBavY+bFV2qymYgZPOt/0BZ5Akk90DsTPY953v6LH/Db37J06K
         E+jvbKNfMh0YtydRaDGDkVr0XtpZZojiyb73JgKe5Ubw08bKFAm0N8PGPgpvnsHJleCk
         cGLsNPEzMxPbC7QStH03NQ37t2nwD+Y8Snj+JLuekgYB44uqWzMjW3IkEQJ9kJh67HW3
         dXOHxpVxZYwZ6nSqFqX7XXmWb6769EEsaCJEZ3FCADEsPrBQANnEj/le0yS+A7pl1v9q
         t/T0xoChks1YKNKQdC/SprfhGcygZcdDw80L3udAF40YkQXLUdTjC4XF/h1jI+HAQwov
         J3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484094; x=1712088894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmPgefE26rhr79NqXAgIqb/l9m7Ev6xlwT5t75HGYd8=;
        b=h1lmewywlatk8rbceMGZ7CCEdlkVsc4aIZmPCMK98bfHLzWw42WZnIURFAmkn9GaL5
         VX5iBWtVYxuGuSSgeDf1n/D85pm8E8rDzPo3VnLiEfQy05nqHnpw1JexSSFPImD+a9HC
         33L2e6RUGikp8mnauj8KNwg2riHvdZ7YNJ0YXlhlnmXvR4w/JHcmpmSmXLQR7edTroQU
         aAqfgGVYfECiFkONluUS3iVPg6bwHrFp7drp9JXfL3Jeqwy2fhrnnitlOzahFlyJ8BFR
         DWeZjn7PKm6WDWIi7xk2HI5Aq27icoDNMNFQlSqoyn81Q8h2AM+RpR5KUudK+kCyYN7r
         /Yfw==
X-Forwarded-Encrypted: i=1; AJvYcCWpY3r5Rar3QNBy1hBWuBf1AeH/+LeCVIJziCtdvGAEBJGcrxjAsR2TN1P/jDn1Ce2jzPBRkB27cq0jaCTmiNRBPLuPhSqNDcgMU2xO
X-Gm-Message-State: AOJu0Yx1/HmY3JDCddlO5sOb+tzxxvjU/vJCjb9vkPxNGgNxUKi0FJGC
	mVixhqCIC1OS2kzC18XpdYfGSoexmpE+Dbj3cO7CfoqfEi5IM9DFOFlJcBAXe3fn1ZZGyjz78WY
	log1NGl4+ztQ12TQANzIeocdEu/SpxM0rTdt6Fg==
X-Google-Smtp-Source: AGHT+IEgqefmBkcJJP+48bvWirN9imUigtJZiRJWcEvqUkXtLAjkJ0dlr5Paor1wjIVn1yDprWfj9TE7zMxuEes/6vU=
X-Received: by 2002:a25:ef52:0:b0:dcc:eb38:199c with SMTP id
 w18-20020a25ef52000000b00dcceb38199cmr790117ybm.56.1711484093804; Tue, 26 Mar
 2024 13:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org> <20240326-topic-rpm_icc_qos_cleanup-v1-3-357e736792be@linaro.org>
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-3-357e736792be@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 22:14:43 +0200
Message-ID: <CAA8EJppT5P+CPZg-=8jyxebFHoOUCAGK7tm-_u0zB275ZjHaAA@mail.gmail.com>
Subject: Re: [PATCH 3/4] interconnect: qcom: icc-rpm: Make simple functions
 return void
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Shawn Guo <shawn.guo@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 21:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Register accesses can't just randomly fail. Change the return type of
> functions that only do that to void.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 110 +++++++++++++++---------------------
>  1 file changed, 47 insertions(+), 63 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




-- 
With best wishes
Dmitry

