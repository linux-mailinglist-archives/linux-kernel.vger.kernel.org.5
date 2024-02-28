Return-Path: <linux-kernel+bounces-85825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCEC86BBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BECB25BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F737D06F;
	Wed, 28 Feb 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzXS6S0E"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27E76F1D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161200; cv=none; b=tMxgNiZI4/M5oTu7wfD0CMQW3K9KPn/kHGKfw7FdXsqR6Haardr2uopOyqQYVGax5n6Q12yQpXuBSnulrXswa0CHNFFRBE2/a/+bfUrymUxTAMp9+F4xqW7MwnS13uPDBCvgMaC2kOoAq4mAyx9HIN4BSDCyQ6yqfh3Qqe6/cSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161200; c=relaxed/simple;
	bh=KLhVl79WXN9Ubg4coyQwz8bkIRdnew0Yg2ZrB2f1ZII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSI7HTWG/nu2JjVHlTQ1ZA1xGNIJhgj3j14aATcA8SxQbHni7PpnikkyYEB3GT9D24KmGprRBC+e4ugpLkfPlXMBl5FTjGtUaUxnkbP+VeQN2kAdSlIH150PitlKqccepz5qKFiRDL9M6STp51m/zIS6BdTfYkc+tGyc6kevvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzXS6S0E; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso4980a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161197; x=1709765997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcAcp9JyXZdmgBhUYq0E0dm3aQzmCgek1VqMgRhoKKo=;
        b=EzXS6S0EUoEGGHhnHGckWrAK1X0BLkXrXBlcpmmS8D2gGxYqFRX2BC5O52xMPEoiFw
         5/B8n0Wjjsc+nN7Q/DidplqCm36KqbF1sI9XOJ2xiPf+OmqiJopwUaAcU5nEubcHooPR
         RnhXG/JJFSzzzlsXaMw1oV6Kbg9olUErGz3kNIUOGVe+easPX62td4rQlnSA8m7vzF+u
         vglxZzUIHwwfjPaegOsS8/IxkofB0lyTpQ/WNDfgjOJJ+QXFElW1xVFoi0GBD8hoSt8Z
         dRvgjhHXtc7YdGDJ+jk3Fha++pk2t4a2KQpQZemg8ozeRHhialdjMjQ3cqyV/0+97dO2
         aJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161197; x=1709765997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcAcp9JyXZdmgBhUYq0E0dm3aQzmCgek1VqMgRhoKKo=;
        b=KZALiw4ucm1MIDW4GV0TwXS1s0IIJGZjG4btd/6NFSjcXek56qR+tM09rFqx+2CRyD
         ViW34BxMD8YySEGaWR5IoOc11uqYLe+wZnIvnHlL2u+P4TX3tfw2180LS3SRM03IVz1a
         CVJ3GeNx2b6I89zDK6epaCyspWSNoWaCXG6bb7b1cE0ZfQZn4gzHgsK3EWvu44ZxCJ5+
         dUFsfTI7DpG3Sn3tmu4dAQgFaRByTSArYSVZy1nNKlkHB8cNL4rPW+7gFTsDBr4kt2e0
         6MsZ6VwtR/dz2cleQqyj5x3IHBgm5J3RiYhgYZqB0iPrRAtR24IAavSP4wBmvt6loi7e
         LMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuLY0vIj1xxhKbcDX9T429wPn80ZZf50/PoEW8WZ6rhF6kf3EeDxz7W+bgt1JZ+e16ZXvfuPkhOOtO2f3sLPGNjWkMR/2V4u1DIrzc
X-Gm-Message-State: AOJu0YyopZEmVUq4kvFjok3WJeFIFrzGcMhBvLiWbidVgB8XA9BwcnHd
	mmWcpIlyUFtVSmPNGpZO5YOCIdtoj23wGIysLi7SXyQsU0+b78YnTS7WQfRTElZM2PRXIMwxmZ1
	/jEtmZFHUp7kM5H/muW5GZpxQCSf1lY20dch5Y+nSILGfwVRsXw==
X-Google-Smtp-Source: AGHT+IHpWZIU1zgRNJtryo1mYw56VDLKbEU1Iy+VtWWnb6Sjvu4R0v+EL3GOAZSsTEhy8UEVROA9gSxr+SGcYbNvZRo=
X-Received: by 2002:a05:6402:5206:b0:565:4f70:6ed with SMTP id
 s6-20020a056402520600b005654f7006edmr27867edd.6.1709161197359; Wed, 28 Feb
 2024 14:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226234228.1768725-2-rdbabiera@google.com> <2024022731-dusk-posture-b83f@gregkh>
In-Reply-To: <2024022731-dusk-posture-b83f@gregkh>
From: RD Babiera <rdbabiera@google.com>
Date: Wed, 28 Feb 2024 14:59:45 -0800
Message-ID: <CALzBnUHyUz2NoBxrj1m+W-Wuc23fLP7NBbJq=qpHx1oQcX8KRw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: altmodes/displayport: create sysfs nodes
 after assigning driver data
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:20=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> Now I am going to push back again and ask why you are even attempting to
> create sysfs files "by hand" here at all?
>
> Why is this just not set to be a default group?  That way the group is
> managed properly by the driver core and the driver doesn't have to worry
> about ANY of this at all.  Bonus is that you remove the "you raced with
> userspace and lost" problem that this code still has even with the
> change you made here.

To answer both questions, the driver had always created its sysfs
nodes manually so I did not suspect this was not the preferred way
to handle driver sysfs creation until I found your article on default attri=
butes
after your email. Will fix the patch up.

thanks again,
rd

