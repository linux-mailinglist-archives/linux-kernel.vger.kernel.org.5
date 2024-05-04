Return-Path: <linux-kernel+bounces-168436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08DC8BB893
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F51CB231AA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC0A34;
	Sat,  4 May 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FEwrd4G6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442218D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780888; cv=none; b=ew9TPCSxdjAWvB2ne+sRit6vz0RDBNZqC7KNgdv9Z+PQcZw5ww0PGTkcH7AC9/Q/TdoFqmWx4o2LnaWVPmB4vND2myeiKS9kNTpPp+CsMWILF+DqrSusl+LQZ1L/UIYJjIfgImESyCpIL+60K7wR+0s3xKTKjsJENA8IXO+rQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780888; c=relaxed/simple;
	bh=JOnUs/cDkvCsfrqxpv24/4mkhYVMsG8hK3M4zrenr3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFNNJiV+THyrMs84552wf/L+HVjWHRs9frfeFSCg7kSget2mWSIjQUulhK9rfbbuAv6LcY1TrlI50aeIT+Q88srcPaiJQ5AnjESWTXoI8wE7TKEIghBBXiHx5XYEF3Bs+ONDDdy+N+2kzNspBmDDj0+GWx/5U/roRdBQ8LNJwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FEwrd4G6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55bf737cecso28065866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714780885; x=1715385685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3S2pPJAcdgcUXZnUGJB4Or55d9W10bkJHNjzVKONxZo=;
        b=FEwrd4G6NET1J6G++pfnBElmVNTypUdOV4fGEgW2E878FxYZ0a1l5fcJWIabORi7qx
         riieBRCsnfawb0qVjLKlSJLh96Hu49Xwmmaz9DYFpF5kw+zwU14wHZUpY73f+YVGxVIf
         +/mP1++nnOTpZfW13oMODvnpUyVjXWdm/B0/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714780885; x=1715385685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3S2pPJAcdgcUXZnUGJB4Or55d9W10bkJHNjzVKONxZo=;
        b=kzBmjSiypdTT/0YDrdwpwakjRbQn04zfFqxLzi0hQElZ/Soo5LuhY7SG6TDpSDPRP3
         YLGS97PjVfveibj+Krwn/sNKQmY9uvM6odhCqKMXzZt35rPen6bBMx/t6Q3opbp/SXAS
         13b8+UJl4jbLBsQL49qBwddPrjivMfqy7t9TUANs8f4YI7IWtUjOXMzdVj6W+lLdAb5D
         ohVasHhtuPMM3yDRXRfYpCcdx4+LvQuHWrO2Bts8KNwn/2TAjuxywDinv6DgNbA7/+A7
         w2ppud9w/4Oz+qev/ufOjD1RDpIILAOvkTojP6czQhw47tECR4m2jtiWPW2wBgV5CnsK
         QnsA==
X-Gm-Message-State: AOJu0YwZYKg7WyiqVh+urEMqMkVXrYMYsgP0Cr/kI6lMUUPWIxQ2C3rM
	V72uHAzbXZZ6l6IL2q2VBHFzgKlCcC3ODvloJ3mmmRb0/pXxIEKYmdIi94Xa7YDK2zF2e7aFqrr
	nhVOdtg==
X-Google-Smtp-Source: AGHT+IFDyJxdleBOmXo95x29aTqFHeaDBLKsim4qNwCNGRZcXGB4rdryKzjGpHMECtGy30JctrTy/A==
X-Received: by 2002:a50:d4dd:0:b0:572:6ae4:a9ac with SMTP id e29-20020a50d4dd000000b005726ae4a9acmr2277820edj.21.1714780885112;
        Fri, 03 May 2024 17:01:25 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0056e718795f8sm2265928eds.36.2024.05.03.17.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 17:01:24 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599eedc8eeso30196866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:01:24 -0700 (PDT)
X-Received: by 2002:a17:906:714d:b0:a59:a2c0:3252 with SMTP id
 z13-20020a170906714d00b00a59a2c03252mr457386ejj.76.1714780884173; Fri, 03 May
 2024 17:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503190728.7510af9a@gandalf.local.home>
In-Reply-To: <20240503190728.7510af9a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 17:01:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMSaivGRNk55fd8F3yODqOYUtY=d+vnXmY2buUKewd8Q@mail.gmail.com>
Message-ID: <CAHk-=wgMSaivGRNk55fd8F3yODqOYUtY=d+vnXmY2buUKewd8Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/tracefs: Fixes for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Minor fix for user_events interface
>   The ABI of creating a user event states that the fields
>   are separated by semicolons, and spaces should be ignored.
>   But the parsing expected at least one space to be there (which was incorrect).
>   Fix the reading of the string to handle fields separated by
>   semicolons but no space between them.

This is the opposite of a fix.

A fix would have fixed the documentation to match reality.

Instead, this relaxes our existing parsing. Are there any old kernels
that had that relaxed parsing? Is there any actual reason to not just
fix documentation to match reality?

Because when reality and documentation do not match, it is not
*REALITY* that is buggy.

               Linus

