Return-Path: <linux-kernel+bounces-82466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36B8684FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C0B233EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCEEA4;
	Tue, 27 Feb 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8EUuULo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAFC36D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993750; cv=none; b=ITlS96YQrO8g9W0nhpn3zjIKr3Y2n0lKi3RfryT5luUHAIJX7qRRHUA16M21P4S1IfkoQx58WUkZLIHFwL2lU9g3f9/I4+k9stx6rmeGfkB5ellx4A8+FrzDuUdgUIgdczr8QSCeY2ok3H+TRrEURNCrywPaA5gpikP3pVsg/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993750; c=relaxed/simple;
	bh=ShKKi6TlgSxWUVIb93iZNgwwSea0qBzgXYFrAL077W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaUZna5wiQG94fDf5c+VtJU/O4xHP6rJz3mLacDTgJqSwEuXyf/A1waWImG3V8x0ALSdQXYO+/LCl/NmU0OHhfip7mI/17ILbSrCokd6lm1G6qjehMOHXMfeKItLzXkZxdt7ZSTgfWFOohFt6W+UhpZdnhh62Rl2gmSW1ZdTjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8EUuULo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4129a748420so18955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708993747; x=1709598547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ShKKi6TlgSxWUVIb93iZNgwwSea0qBzgXYFrAL077W8=;
        b=g8EUuULom+3XOmcrPap6hK5iYmBa2nsLr0VBh8jOVLzJWYkEcx3lE06JI1M15Vxqh7
         i/vXsdqzS9aK0EQVztcw9LA9o/9O1J5OQ2y3lsrowNrGXy1TbTatRet9dHp/ZaZGBmC9
         oOClmakX7SCLamV0T+bSyVbnqRkjvAuNVkbp08SA1jLtrwfaYdw8QiHcMT2/vsvOpP5m
         s+LB4zSrmohDmH6GGWxFpmdO2gZg+/fJQMOvJCdzKxDg1vH49b3jhVfaN9Ko9bzCGpgi
         d+n9Lc+5mfvoRRzMayWL9MaTAknSm9jVgOuoJlbpQZmTJ3t+V3M0QKdcZj1doKS4hBYh
         pxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993747; x=1709598547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShKKi6TlgSxWUVIb93iZNgwwSea0qBzgXYFrAL077W8=;
        b=Jg27lKv34CzzJAWOGi3WTBm4gOPUI095Wpc1dTxGWqTfErduiBtP0JS7BKwpHdUm5Z
         8gePJi3TeyiVuKR2DcLywpTSCComZi08Ql7Gp4o2H9Q9I4nyffzCB18Zo8jBkRX+hoPy
         sgQ05n0VrDsAjQQ/hHivBRW+HTFJsoLOjIKHK94/squAH1XcPGLOSSZM04JI+Ns+7jjP
         O3S1VWq2Ybrb83/THGVeqNeMll1BD8it61U/Vo6yFYNRisHMup8FtDgDMIeZcfCUQYXp
         +i9qe1bg+mH6yCHOw3Vr34PJDEM5KdWGBJacNEwQiE4+IQv3PRL5lESgdTEQn1zXhK13
         AYsw==
X-Forwarded-Encrypted: i=1; AJvYcCWhA5/Fkvpm7vFDH9GvLCo7FWv/srUTEM1+2sogGJqUPbj/FfMbjNaG38gOKbYUSqE0TadRb1GFPRaZIBziAUN69ANWfdKpOf5yrgaO
X-Gm-Message-State: AOJu0YyjvhBAtVZb0Ce8rfK9LYfDTBioMbc3HMTV9W+lQXQZiv1TYnlv
	GnGpozA/NQFcBKeuoV+nQfx1pUSgT9GWVx751z9+PK+6yo/fAvhflEaS8CFjvZ5agcjRQlQdoZh
	MMLqfAYRHRsgp0hRPuHP9L8fxdyIH6LH+afaO
X-Google-Smtp-Source: AGHT+IEHBIxVsYsqqx1KNVOvqC0cQcgpUH2DaF+E/L7XUVB3GgMGSN5f+p6Y+/0OBfhDM1iBRyndhoFvC+Yz2LrOIZg=
X-Received: by 2002:a05:600c:a3a3:b0:412:9829:2dd5 with SMTP id
 hn35-20020a05600ca3a300b0041298292dd5mr46040wmb.7.1708993746739; Mon, 26 Feb
 2024 16:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <CAA8EJpqwAg-qenTq3MZCb74rn8rRaMxrsnmZGMwff+ABGENEGg@mail.gmail.com>
In-Reply-To: <CAA8EJpqwAg-qenTq3MZCb74rn8rRaMxrsnmZGMwff+ABGENEGg@mail.gmail.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 26 Feb 2024 16:28:54 -0800
Message-ID: <CAMFSARfs4x2+rkdk_Ns4dSbKUZ_YbAvjsxUa+395b+wLwrNzPA@mail.gmail.com>
Subject: Re: [PATCH 0/4] usb: typec: ucsi: Expand SOP/SOP' Discovery
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> First and the most obvious comment: 6.6 is four months old. I see that
> your base commit is the usb-testing tip, however you declare that you
> tested only on 6.6. Now I'm confused. Did you test your patches on top
> of usb-testing before sending them?

Hi Dmitry, sorry for the confusion. I tested this on a v6.6 kernel build
with a few dependent commits cherry-picked to it. I'll re-validate the
series on top of usb-testing.

