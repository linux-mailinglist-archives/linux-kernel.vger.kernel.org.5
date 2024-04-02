Return-Path: <linux-kernel+bounces-128089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7358955F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153A61F22F77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2398593A;
	Tue,  2 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwFFhTts"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DA82893
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066388; cv=none; b=CP1NucTOaNdunTBpa5UbmfWVIdL9apFdn45vRFebvJdMErEhwjw9LxYnbyRvn1zPCBY6yXYUITQq6D521JPvUVZ1Xe/9SroXHcj6L6Cl9wyU4O7lMwx5DMpwrCihAtX1fpFm5FW/RECDxWlb/eCLBSg74TuvfX6SImYGDABeskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066388; c=relaxed/simple;
	bh=42K8nROeT6dOc/vahsjMTQ2TJejhqqvIR62/11kWiD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3SdADPnM1TvlQ0I8BmegXkAZqjj90+SxFmLYeu4MsILIhnOtMa484V77+VNCvlVxt1ZRxmJXaEtu8EzjV/ZrRQ8RQDXUNdZJ4SmSwv6ZICSMUEuOK4Asas7RVPwuY9o2edSG2INqzCZudrs0NMdjtxii8RWDS+AlDqZ9eIKNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwFFhTts; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3678285a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712066387; x=1712671187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuuVrZPyzr64KS5dQg/A1NNJWj7HElaPDjPANjVr5sU=;
        b=iwFFhTtsOfRtnzILfAnMaCELL8Ykbpt6rXSGu0hxiuItpMBt6jVVRmhmLy6MPvCQnM
         ST6R9/iNyfpg5B/8S4BP1eaZdKlCMkcxhaN2yBq7rVWOJd+B1OsvOAphCqTDVDMryzLR
         dNDydw4fRdx6rx85LIIwwOO8JeX6Qn3iKiRXsHiVPA4jS44hC745BjoOEJFrKjnEw0Bn
         DHEip07J/l66r7qmnC+BAY1Qv1/T9bsiKAPv5ZaAlxYsbKQ0nhfpH+0BuR6YIfjtzt7G
         8lo2ixbS4UcV8oGfarX1ki9PLRrOlqW3zdbkvcea/coLTubDKBuBO5PrSOAQgiNy8B3w
         blJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066387; x=1712671187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuuVrZPyzr64KS5dQg/A1NNJWj7HElaPDjPANjVr5sU=;
        b=mX6RvKeReR4pGieBvaC/EfWg5KHOQyL8UvCchI5xbmqfktsnW0FkNXblcy9CP+tZ4h
         4luWS7pzHMVSS23KGWs8/KP161I2J4UEfMBSKYOHgCpJixDUQbIpRTWgSyxi+1JXiUuo
         sii4h80MRjYFp3XirNfGCvmp5BBHI12PteVnOWrbXZGR52JcuVqko0Eu8LhMykwR6dAs
         uKIivvIB1wd2m0UPgVWygLJBxY/KnXCXEjFWfFKNRJdt5c8HXiMVqnrAGPuO1Arbmg0r
         radfRU9l9NKBbiIg5upUOCMmkB3lwSMoLOHUZFPMXVdg3CKp07MyR6sHa6eK/2Wndrlr
         4vVw==
X-Forwarded-Encrypted: i=1; AJvYcCW/KGFuNlNiGgUKy47gqoIFs43ZBMcBldFO1y9qu2vQfUpHQw6gxKQIX4REMDfOB0ChI/P54tmODsdqIIxaSz7Ho6L/BI9G9+g+K+rc
X-Gm-Message-State: AOJu0Yzg+BbUTDPVEXVGr76/D+8HqnAq+7OUZDC0EnNRrZCJj7BxFSiM
	1rCSBki+hJ+LdxRYzOR7xgrm2rU4xkw3faSZbJwzuBiE8/xhqIrprtgNdKEsb1MOsPH+7Q1+pIn
	4rKRhTyDCmjleMhQDiNNNaV6LcGk=
X-Google-Smtp-Source: AGHT+IE6qUICTNOSpzFpnEgWw1aZpDkMOxwpZZfJ7CwYPASbAghPZ0S5E/rKol7m6M75I5a3WTJVLsqMMIJoZuFdjsI=
X-Received: by 2002:a17:90a:4294:b0:2a2:3223:1903 with SMTP id
 p20-20020a17090a429400b002a232231903mr5147022pjg.47.1712066386686; Tue, 02
 Apr 2024 06:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <z2ewk44rjutv24i6lqau3adrmlprj524ulqtqbncvfaj44dwcg@2dnnbm75abbp>
 <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com> <qnljnwccqvqzilxuoat2s6md2zwcuhfruzbpepxebk65k34t3g@cyl67lk5lsoe>
 <fdc25599-f8a7-4d66-9535-494de8439da0@moroto.mountain>
In-Reply-To: <fdc25599-f8a7-4d66-9535-494de8439da0@moroto.mountain>
From: eretmochelys imbricata <shresthprasad7@gmail.com>
Date: Tue, 2 Apr 2024 19:29:35 +0530
Message-ID: <CAE8VWiJbjQ-LmeNRsVkXtTEbytqux-7Xv0c5JT86=FSxemgGSw@mail.gmail.com>
Subject: Re: [PATCH] staging: axis-fifo: align arguments to open parenthesis
 in axis-fifo.c
To: dan.carpenter@linaro.org
Cc: christophe.jaillet@wanadoo.fr, frank.li@vivo.com, 
	gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, luca.ceresoli@bootlin.com, me@wantyapps.xyz, 
	prathubaronia2011@gmail.com, robh@kernel.org, shresthprasad7@gmail.com, 
	skhan@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

>No, we're always taking patches.  You just had bad luck/timing where you
>sent the patch 2 days before Greg went on vacation.

>Greg is back now, but I imagine he has a long list of stuff to catch up
>with.  It's possible that he also accidentally dropped your patch
>because of the vacation...  I could imagine a situation where that
>happened.

That's quite unfortunate. It's good to know that you guys are still
taking patches tho!

Regards,
Shresth Prasad

