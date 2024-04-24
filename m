Return-Path: <linux-kernel+bounces-156058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1618AFD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7161F23A91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD52119;
	Wed, 24 Apr 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1iFiOUfD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68E800
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918590; cv=none; b=MZAwMNuX2aFSmmrpkZYUR0XxfgmL5vNe3JQjxTkjXP5yVypGiOxfP/kFGrjpW9uoBenJpvRrHEFEu3jFJ/g+2tuodvZ0D+eHpZI4FaDCiCXfTTZRqckRr23bSeTEduxc475Zh7XWuPMt9XJbLWadynoOKtICyW4QEYe8BvCwCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918590; c=relaxed/simple;
	bh=ZU2dyypC35hTtMaDNugRfvH+64b+VBcAIVyJtYe7dgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXPn1vuGrJWgBIA28qDqicxuSE6bQTUVJvPoeEv4LGmmAtiR7urpl1uH/th+4barSl+OI9FkRHbwJqXqMoFmcHHBbmGw5q7gjFNBK0JmO4O9L9C0WNnvTP8x5htmyazwANZ+tGEXc6gMmCnKAOn6pPDJ+Tv93jckkc2b2wvRuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1iFiOUfD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so3293a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713918587; x=1714523387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU2dyypC35hTtMaDNugRfvH+64b+VBcAIVyJtYe7dgc=;
        b=1iFiOUfDqYlEmFiefm1hpNlf9brmTcOAwgcz3pRfxqvHZkS7H+eJ70NpFTWK/nXyL2
         VH6D7Dr2WRiFFnZlhwSqSw8YOvU8cxzo8xGTZXW5w48sr1y64c55kMlBx9wv5a8/ixEL
         SajEQgxydURJdufcZv1HU5DFVJ252C97SusSBJAQY01Rp/koka52u+1dm7w+Zy+FSEcc
         4GXe1IFNjTUBETEgGzoS9qgt6R0ar25+0MNdLpzWbWJN2Yxc+52g+XyzEgpUcrhVhOjr
         Xj9fhfHPfGBRDLSMt9Rmvz+1Yf5Q7Qa5JYapmSZccBlqIHDm+rFTuLX/yJ+Rh55NU17c
         Rs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918587; x=1714523387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU2dyypC35hTtMaDNugRfvH+64b+VBcAIVyJtYe7dgc=;
        b=fMb7/8gf8U/imNswN+SVElyPMme0f6MfETnu/aGwcZjmJmvSZMK06Jfi/kaU5SXZfZ
         9EYLOrG3qHJroLdRHshc49KTSX4jIQgtSuDth0pwkvP20jUrjPIjL7C666ljerr+6GKX
         Dxm9l5ImWgiwsMJ1NPJusmOgNNUD9CRBNtsmbq/ta1LDjRvgXCMJiKInr/69GU/yPXwi
         3bQB2Etno1VIq3YPu2HbpyXuAILuWnxojKQu9UJixbTr4iG2ZLyYwExoDp0atts8aX8E
         vUsxQQ6KoRRP/ptC7tBz5fKa5lLixGnaCO38Xv1Cicat9Ee1uJWVpX5dMN4ySoNTpWSg
         0Tqw==
X-Forwarded-Encrypted: i=1; AJvYcCX6m/8uaem9soHakWLiberp1SrwC4IqnvytdgG8hY4ESzpN9CrEjACMcEeliSbGdAD+K2eVUPIiDDjkn9pQHoe2ITPOJ2zYyYrjiQBj
X-Gm-Message-State: AOJu0YzX3tnYlmjARJfnnxoRtLpaI0s19oOPIY97UgxHYBZ9NN2xMg1v
	AUNJQmfGikiQCFIOK5xy2RPWh517li/5VUDKB00R606o2Mnqq9H7QNdz7wZGgI/an+sEugWZJI4
	K0j0XRHLCzvwDMwtlKrZI9VPbGFwqcruuSKb3
X-Google-Smtp-Source: AGHT+IGPCUO5yAr/FMUmarCqMkGLRTzcErLX5Ff15XJVqyHEp9rslTTmK/kMgmjxRJxqaIojPuuoWd/JoUaERypvdpE=
X-Received: by 2002:a50:d6ca:0:b0:571:b2c2:5c3e with SMTP id
 l10-20020a50d6ca000000b00571b2c25c3emr41728edj.1.1713918587067; Tue, 23 Apr
 2024 17:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419211650.2657096-1-jthies@google.com> <20240419211650.2657096-2-jthies@google.com>
 <ZiTcqZYS53ITwNLy@cae.in-ulm.de>
In-Reply-To: <ZiTcqZYS53ITwNLy@cae.in-ulm.de>
From: Jameson Thies <jthies@google.com>
Date: Tue, 23 Apr 2024 17:29:33 -0700
Message-ID: <CAMFSARfTa59yueKY4bVQvCL4KuQAeQFBDBBVDRkhhwRD4+zxmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] usb: typec: ucsi: Fix null deref in trace
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,
thank you for catching this. You are correct, this would prevent
correct altmode registration if CONFIG_TYPEC_DP_ALTMODE is not set.
There was a miscommunication on our end when setting up this series.
The intention was to check for the EOPNOTSUPP response and fall back
to default altmode registration when CONFIG_TYPEC_DP_ALTMODE is not
set. Sorry about the confusion, I'll fix this in a v2 series shortly.

Thanks,
Jameson

