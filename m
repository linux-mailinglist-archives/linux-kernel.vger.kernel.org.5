Return-Path: <linux-kernel+bounces-73887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4385CD28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850531F236A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAC23DE;
	Wed, 21 Feb 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWOT7l0O"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDE1C20
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476792; cv=none; b=cZAftpa3i7E5azt7MgtOy+o9ZYILEo1QB1fq/YQMefGHepD3EHTQhdUCNbmMjCjGJMpWqr8PK+cNarYpvnsF4UJ1o4VHCGpiIl+I1LPVY2swKZVe2t58gWlFiSnuOYT4wVR0FPXTrKIHu8D226wv7WQBCdWCKhMi5PVYH/muKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476792; c=relaxed/simple;
	bh=hd0lhH+wZU4zitJitsjtcio44xa5sDrhwLIhJx54M48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNW8x+6g9kpFumMQlQNOFkKY2qhAJ5JEKWudZX1UfxLrYXdFMAx1vl//z7vlbOf7fQSQKnpCOJC/tboGorBk1TOQfKaaoMa6iBD6Sw2vjl8NHBu8h6Z1GdNAwSPvObccmgFl9sa5tmln6AFx+EzJGuWjA+ZXWLmy1aSvzKqr2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWOT7l0O; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so86751cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708476789; x=1709081589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3aliKXEbglyQXiBZG3IVeVy5el2cZXqVD0gVl1TNUU=;
        b=kWOT7l0OVNXQJZGbA0M2wa8mXmNF1FzbDVMSzI8aBoJlPp8DAsoPt5ay+l9NA0qIDN
         ST85QDVzD2RnqQnK2kkylX5HySvD6oj+ys2U/pPzHCih2jwfFd5OjD41xjMTlPTSY0Gd
         vtmDD8G+imhgluv4ZRtdPo/F2xG8rbhPOAoWM4Gi37eNTscCafk2/N5devtB7AS2b1cr
         hKOCsm+VcJKUN3+owsqWk4/PYWJ5npvYrkA1/14SQknr72D43w1VsbmKGwK29j337cHx
         8tjup32fJy0MOEowzOcRrMJalOoULQCoqeyBB2qjueWfVSLLmrjjEyNfaUfSAn9vVfaN
         rhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476789; x=1709081589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3aliKXEbglyQXiBZG3IVeVy5el2cZXqVD0gVl1TNUU=;
        b=X8DuZfXNEVl0cPtt7hDvcNCxKGPidzNPc143q/LFpK3ei9I9fZfBhunAVCC/HcVwDp
         APOdzZPeaB5wBkn65RwhM6JuLSxaIfYyZGlTZZbyDevVpqbQt3qnM4hCVV/9Khu8EboS
         tADlpoB8Uvw1XQup0F3oghQSwWS9l78cRPzY2B6+pkcLjObD1DvePv9hDVBw7HLioLE7
         htDMxA3yzLqFump0qZkTJYXnyQnad3JPmO/BiJ/YXjE22dWtKimEIqJ60GLF9QvJIW9F
         W6FEacVBOAn29Sy1WKwtTkzugNQVPpmFOoFzkpVKaf19mBPfvFwZPhe4lBf7aTvAOqmF
         8ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Krm6TWKi7Foac3xlj7jp3wYFN+4MJFGTtdjDjfATNGs3xrtrT9k/4rD71ZJgmm+pDaESbiN5HWakdrAMk6mPktQlDO0PW3g5mHKf
X-Gm-Message-State: AOJu0YzKvg7DOomQAZqzgkJjW+ZL/d0f6LLiRr0Efz+c7ETgy2NWQl8t
	FvnQ96E9AbxaKhgqBmvfSBKlp3LeAS+sWoQbSoYiVF6sqOisYanU0Dk+96jfdqYaQX7AiyqlY6y
	4t5c2k0SSKK4ZA4vW3zeQ0NNzg4yFtBWup8bW
X-Google-Smtp-Source: AGHT+IGuojBOIL3NwHNGp1txCVvfo0pbzvMxcixAlnHZkwYRAeUSF6WVNWbxiaJVoKHnLXQs66Ob2cvkY1Z84vxB6qY=
X-Received: by 2002:ac8:7c47:0:b0:42e:36fe:df90 with SMTP id
 o7-20020ac87c47000000b0042e36fedf90mr46324qtv.1.1708476789278; Tue, 20 Feb
 2024 16:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:52:31 -0800
Message-ID: <CAGETcx8w8YhC89JOYkQgcXrZgqfXOUXHXq5+86OdHGSfqz0D=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] driver core: Drop unneeded 'extern' keyword in fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:53=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We do not use 'extern' keyword with functions. Remove the last one
> mistakenly added to fwnode.h.
>
> Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Saravana Kannan <saravanak@google.com>

> ---
> v2: fixed a couple of typos in the Subject
>  include/linux/fwnode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 2a72f55d26eb..2d23a14857c7 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -209,9 +209,9 @@ static inline void fwnode_dev_initialized(struct fwno=
de_handle *fwnode,
>                 fwnode->flags &=3D ~FWNODE_FLAG_INITIALIZED;
>  }
>
> -extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup=
);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +bool fw_devlink_is_strict(void);
>
>  #endif
> --
> 2.43.0.rc1.1.gbec44491f096
>

