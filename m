Return-Path: <linux-kernel+bounces-37427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BF83B020
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD61AB236D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75481ABA;
	Wed, 24 Jan 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvGXjCdW"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230317E78A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117275; cv=none; b=IJ+GOrxkCso2rMnlOgxu677s4b+LKjx7AchZzMDYiFZuN1maUkdw2UJ70c2sfFYzaVit9fTiSYa1xZM5wbEAjEhOYxEDPZfgsGABRGV61lUKG3EUZPe+a7S+YkvDlDyzBu3q71K2tOO3B5YXVoTxT/doEnOIDMOmLYYfZCISq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117275; c=relaxed/simple;
	bh=z6BjyMQCnB/4rQCdDjotQhHRjXz7UoU01MQEf+XrLlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaBjE3Vt8QH++ftEbcKePo7Ip6T7tOrL2PCCcbWJPHOb+N8Pu/85TjDg+TLo5bYA4d6bsbjNs9VZ2vktsBaD8TADNUpPGk0+C7Aoy0O3zKwfTa4rO/tr2cwN2OT1fOQRbvIAS0/x5FvSdtQPqnaQAfITxyxuZby5lcebNGFpxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvGXjCdW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso6330463a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706117271; x=1706722071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=SvGXjCdWQ583KEVmiYYexUS3zEIYuWQ4wPEPRQhydsb2+08ONPZqteuABDBSVeB9aU
         dIQbevDGSW2O6AHiAezGooZEAgVzm8YuDTC7blChWGde0dRCM2EIc39b67mLjwXF+jMP
         IqFpwja29nj6xc50P9fJ5UiosHhGFgiUFQUgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117271; x=1706722071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=pUzBJLabnp7XBXstFXQlN9DYxDrbdgDZU8Qu/oUwqBs65O06MiJBvGBaVcmMIf3/gZ
         xQKoJPYsYLHBofIYEDPRvgpE3Y8QNOIP3bLsELgGDPCP1MBUdXiu1BoWRsP5H1VqzAUd
         zcfQHD5ja8i5MsJFFqd66FV1yg9tASD0jk8+QtEWDiQOdDyIbLEixpkoAu0NQ04buzek
         7787YP+NkctSrb7zGk2urj5JL2+JlqrM0MZPeFdGO/caLU5PCenZPTtvj957FKTtYAC3
         Q1zo4f0Zar3GdkaUskZOvtUUs/V/tOi14knQ5NfKYx/W6tbDjZwByfvGvKryD0C/ZKir
         yjmg==
X-Gm-Message-State: AOJu0YyLb3wezI44I4p0KH0jAnt1IiwAfPb4KUOE799CAr9IGfhFdBnu
	oR53uIcMJKArxYLGCzZrnjVbUbLJyt8yLYGrYE/HaSXKgaWwWwiKGmCxGhbOMJroPVfBQmYhJ9B
	VIdd97A==
X-Google-Smtp-Source: AGHT+IHHmGbTGxSDyJ8fW5/LdV+yb4lQJXRWwgWM5OzdpgVrFejON5xNW1SjjHCfR8lREZ5kSETVbg==
X-Received: by 2002:a05:6402:2744:b0:55c:c851:4595 with SMTP id z4-20020a056402274400b0055cc8514595mr958226edd.42.1706117271124;
        Wed, 24 Jan 2024 09:27:51 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id p11-20020a056402500b00b005598ec568dbsm10620148eda.59.2024.01.24.09.27.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:27:50 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso3624028a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:27:50 -0800 (PST)
X-Received: by 2002:a05:6402:34d4:b0:55c:7444:153f with SMTP id
 w20-20020a05640234d400b0055c7444153fmr2637292edc.60.1706117270433; Wed, 24
 Jan 2024 09:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com> <202401240916.044E6A6A7A@keescook>
In-Reply-To: <202401240916.044E6A6A7A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 09:27:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 09:21, Kees Cook <keescook@chromium.org> wrote:
>
> I opted to tie "current->in_execve" lifetime to bprm lifetime just to
> have a clean boundary (i.e. strictly in alloc/free_bprm()).

Honestly, the less uinnecessary churn that horrible flag causes, the better.

IOW, I think the goal here should be "minimal fix" followed by "remove
that horrendous thing".

              Linus

