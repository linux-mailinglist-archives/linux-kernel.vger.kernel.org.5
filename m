Return-Path: <linux-kernel+bounces-91581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1998713E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6921F23939
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC92940B;
	Tue,  5 Mar 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq0xxxYd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E14C94
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606958; cv=none; b=UwBAYHSFKHInk/WupDREiHLF0PHPIK5guGt55tbnyS+4SreLHivYV3PPh5HPOkteOBTLyJMcnppnCq9jC1bzudacwhdI8X8C6azyazXDkllyX7wKM9q0HaIJ/d1MDEQQtxBezKHAxUG8TaUiLBpa9G6/eBxEARJ5t5ghvEMmX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606958; c=relaxed/simple;
	bh=5npVjRuoZCxof/KpvJ5AFhHAI0dWO3jIQsfzqezpP/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEMLIsyqG+VfYU7QVkfFnV2fYgBL+GPPnxQVDVPOihQG9wr9jKk1nMul7yLwv6xCZwgcA6QGdHyL3z16x8lUC2apPH5ceTPk1TGiluZ+DgyVfdszdPKUZneEU7c9OZ1aP1XMTDYpGwacYPWUchRDxCWsTN5XtFrX1drB8rPTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq0xxxYd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso7089a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709606955; x=1710211755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5npVjRuoZCxof/KpvJ5AFhHAI0dWO3jIQsfzqezpP/8=;
        b=iq0xxxYdzYlaRbC1sTBPiz/UFu5/B/ggmwtvU9zhQ1AyM5BsG36fd+aqqKh8R+Iobi
         +U/W4PIl/s8AtxgHzmNdNaNYxtl7+GevJELwj0ipjAswYdpRFzUN+2Sfaah5pFEWQ8Zq
         3kvyQwbNhG5ZZ7IZ18YKEweNV+nUjh2ptPyCLpbXHkwUyOveyyT2NXr2hrrsySDNra+q
         8NOR0eHTkj/JD1KyOOhMn+iJUyZtl2O9J0uKZvWU51wnf7RgjEFjJITt8E0A6i1XSKsz
         4iZw2/SOB9cAs3WleJ3FC1nULkM7MUrd5Dh1Lm6YcFBQ5jCgZxtXHjvU/xgW1xe2b7rv
         fE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709606955; x=1710211755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5npVjRuoZCxof/KpvJ5AFhHAI0dWO3jIQsfzqezpP/8=;
        b=cMZY4s2sxSArqnB5V5NBKKs817op05OB99vyi/wukli8PvvvesHohkLzTkMnqwyuyA
         Pw8bdHaCzzy0MR/YJHjk8tgXKQ8OyML/wBcT2H32lMZeAVpQE3xXAyAsXT/8WmqgAJs8
         iuwyLVOaOwxbskwRSvqA48HpqtSsW8kNmzKmwyEBeKr36FDbC2DVKTllOPnxNMZra4LC
         wnWleq6utIbJxR8jmZhbFJIl6ytUyxSKYsLIbD8H0Mv8UFn5CKNn1D7i98U7buWn5w+E
         asILqKWamhyXxgqq4W2BcOo3lDMpvvogBLHGqOR4b/D/ejUBkAMYVhHqfxL/kJ+qCvsD
         f+nA==
X-Forwarded-Encrypted: i=1; AJvYcCXsKKqP4auQEzss+0vYduKr9ZyuITjJeGoPVnC7UixnU1FDnwcpBNEE+OzUYWRjd4QrkLWLO4cAmXzxqtX94SjA3y4xTrE4dyUUoqIj
X-Gm-Message-State: AOJu0Yyt+EReO7PsqgeZFtUWsMsF+EeyckRHbzrN3xJyh9IiMh7KL6Px
	x/uwp+bBZemDPFgky2Xdg73SKqLYZMJ18gfslp8pWrqYBliQ/eg3hgeahD0iUMcAcNjQoKrdPkx
	+niye9m7Fn66T/WYCpHnRoFy4aPBAF7Sz853U
X-Google-Smtp-Source: AGHT+IFcltzWvMIxQ7KdiMsKI61kKpaT9reAutI1eu8w34PMmAmcXT5tF9kfatThrkmIVDWP7m0zA4Tsurbzd4lCVj0=
X-Received: by 2002:a05:6402:22c4:b0:567:3840:15be with SMTP id
 dm4-20020a05640222c400b00567384015bemr12693edb.1.1709606955149; Mon, 04 Mar
 2024 18:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232625.3944115-1-jthies@google.com> <20240229232625.3944115-4-jthies@google.com>
 <CACeCKaeSdAwS5NJd0UtwZKvfvWMJmrJAg73e8SB+ToM5exOVUg@mail.gmail.com>
In-Reply-To: <CACeCKaeSdAwS5NJd0UtwZKvfvWMJmrJAg73e8SB+ToM5exOVUg@mail.gmail.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 4 Mar 2024 18:49:02 -0800
Message-ID: <CAMFSARfv6=BMS3Uvg-S8fLRztZzccBNpKBxRp-Jp4-Jt5ZARGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] usb: typec: ucsi: Register SOP/SOP' Discover
 Identity Responses
To: Prashant Malani <pmalani@chromium.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> There is some repetition here, both with the "if" block and the
> UCSI command itself. You can factor out the command setup code into a separate
> function (it can take offset and size as arguments). Then, factor out
> common parts in the "if" block. For example:

Hi Prashant,
thank you for the feedback. I'll upload a v4 series to resolve this redundancy.

