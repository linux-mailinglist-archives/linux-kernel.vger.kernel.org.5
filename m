Return-Path: <linux-kernel+bounces-29895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0638314D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AD928787B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9B2577D;
	Thu, 18 Jan 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJZOZ+8e"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBF2576A;
	Thu, 18 Jan 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566544; cv=none; b=RMhM0xF5/lzjEGPbmLn9ZwHPdlzSZMHGDxHoVhcrqr+10xnBiGiul1OIZWrPqOWfKoQnYykZgVeu8q+pX3yLt31x0exJjKnsVstddZYMT5pfwblbekItX+Et44W+RLZubr+s77yvq+P+hJmw0u6Lf2WurjjGZremCjo4L9eM7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566544; c=relaxed/simple;
	bh=IogBl3L09kV2fz3jVnil+MefPIx4RdTr5CjD15YUYck=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=jDRJZOpWS9vNeJqOckvHs8J3jhVOp7AnWslXOOJKmS29p1zN0wv/KWGJZB5pOBcBzvKbR28RLt+xQWcKUwnDQ8spn/VHiYoQ6vjBVGDiVf/nBqEARcRbKycah60si8fqnQg4aILEmxKcfESzwnnMTsIXYsSkCUBKK3uMP9RkPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJZOZ+8e; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a025bca6eso455023a12.1;
        Thu, 18 Jan 2024 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705566542; x=1706171342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IogBl3L09kV2fz3jVnil+MefPIx4RdTr5CjD15YUYck=;
        b=DJZOZ+8eZ6Sqp3scOWcO47rXXe4R3Ih1ga5yBTnp6Es0TW1BDn7qWEmEhLpwjGXqY/
         1rKQtoyhFYJ7z9N1USPpTLBkn8MYDKB1CNnoOpmDdpQ3Bx+cYW1KPtYg4JtGgRj2p2xV
         2hNFSCNfTYXq5tJOR/2XYtw4+j84/nN6vEhuWk/RB/Qsr0M1KLjLFMZr/tAHfP0bI6Qy
         ZoNIeC8Zd96n4TsjPzTlmG1utI+EGfTmjmZ3/OUaOTj9P+ixZn5ZtaVR/DJ2WQ9JwVYI
         l0D+nr3tDAoDFEwM02BP8f66O8NdpRmB+uOn/FXuy+oxA+f7x/+3a4WS3SZ1nwBarnMM
         t3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705566542; x=1706171342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IogBl3L09kV2fz3jVnil+MefPIx4RdTr5CjD15YUYck=;
        b=EBVnAotQ3a3DrVjow3aIZFGsn3bLJzk6WUiqVRq6e5HXXoVmTaZ6gz2Gpw1xbgg5Rw
         cQb/Z+/dx60jWN4ZX+OVOXxC1vApdWf8EqCBotTZ1ZBu7ZQcmCpibfJZtrw6lEyrM9xf
         BDESPOXLobtVTzbLInqzMsXvJB5t06E6r9YHJKjxgm1by9YAOt1uh924QxTwSwyno9xg
         QdF/gEsn1ejd2NjH2q7y6iQsfPe1Wz0t3YpBvHFq4G66n+8VGYDed5T4fcHi3nYHPfDU
         N0q+BIFNEK5rKRLdaLuSgEdwl2NXFgnogbMO86qLNtxz1aFWtgI16oc8SAN0t1sIDULw
         D0vw==
X-Gm-Message-State: AOJu0YzuPgzN0EWoAnrrfReq4o+758lJkGEd3QOpnGUhILeumooM4q0T
	fVxPmpGOwALHOQjr9mB0htmWJC6GLMHEVITteJcHAaiHwqRwsg2JbgW7HaTWp7LSR/PgQ7P1mnu
	mmcmFf/mL2FzhZGq7qgw+KwE7sYA=
X-Google-Smtp-Source: AGHT+IH9H2p6KTwKfxddPgYFPrIjTM6GZ6+Ya8C01JucEeRqcSSBPduY4qRR3h3RXngKFE9O2rkCRdUM/HhtijbDDKA=
X-Received: by 2002:a17:906:ae8c:b0:a28:a67f:c7aa with SMTP id
 md12-20020a170906ae8c00b00a28a67fc7aamr126289ejb.187.1705566541569; Thu, 18
 Jan 2024 00:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com>
 <8cce0dee8588b9f3cd0c1a3f073466b01905a703.camel@sipsolutions.net>
In-Reply-To: <8cce0dee8588b9f3cd0c1a3f073466b01905a703.camel@sipsolutions.net>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 18 Jan 2024 09:28:49 +0100
Message-ID: <CAKXUXMzbQwupfy2JGxx2a0qY372Wr3KMkL4zq25xF6g_b+ooxQ@mail.gmail.com>
Subject: Re: Question about reference to config KERNEL_6_2
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	kernel-janitors <kernel-janitors@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> > Can we just delete this dependency in these two config options?
>
> Yes, we should.
>

Johannes,

In case, you did not fix it up yourself yet, here is a quick patch for
you to pick up:

https://lore.kernel.org/lkml/20240118082545.22262-1-lukas.bulwahn@gmail.com/


Lukas

