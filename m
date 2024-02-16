Return-Path: <linux-kernel+bounces-68726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6B857F12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2A0281606
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8E12D754;
	Fri, 16 Feb 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVnEpKND"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3512CDA5;
	Fri, 16 Feb 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092855; cv=none; b=iWTqbZ1lANo5Q3T0NPDFYrcDe4gIw0SOUitDHaRhpMfBeemkKj4y84VQE/JOsrdIr1mFVKQFlGhdWGUzAY8Sypl0xQjKgtJ6K7ptls3I6evNsrU/ZZhRIRmbBGskEsLEL3+hP7zJC+cS26Zg2eODi83g/mNVKb+KJ8USVt1Ebvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092855; c=relaxed/simple;
	bh=/DxwTOf5kx7rr7gaBgtPBS5c57nxY8Bp64eyQ45LJhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYguqPSOg0rP/N4tEQuF1axF+qNTHPb9TYchp3eOE3nw3UnaiRNhOeqnFG2ynIeQ0DheHgiaF5e7lAzNczC6cpBtVKnIu0O0dThZJezruBr3S8FYbbCA4he4zyhRFO0afCb4o0C16I3kERha+MJPvskWa5Cm2jmvYN4ORIbjpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVnEpKND; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso2187536276.2;
        Fri, 16 Feb 2024 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708092853; x=1708697653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DxwTOf5kx7rr7gaBgtPBS5c57nxY8Bp64eyQ45LJhg=;
        b=eVnEpKNDaoRJUN5ybxrkYL0WLXLcgpyRIBrRgA8Tk5N8ZdotVhMmqgozatvZzmxzkU
         qb3ck6yD54WqhPGSEi34eDoM9Hn5B5vpjIK6lVBJXxPT2TMtvbBYtZenXNolm98nGGXi
         hNNJEKyJ2GcwJGjVPIP2H0HWeeiLdSfNTTM5y7aWsaoR5HvjduH8469ogX+G7V4mxFBV
         2iLIKrzSlbhnJYleo5qU0fhF2BXzEvmGqxUWRr5HG1AddTn009uCosWjMNHMkP9a8jo3
         QQ4JTHLut1s/hY8aMwOFlM7j1ipYzLxy1IhbJNQDIpm4F3JwzN2/qMbdj6xEV1eoSMhr
         hJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092853; x=1708697653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DxwTOf5kx7rr7gaBgtPBS5c57nxY8Bp64eyQ45LJhg=;
        b=fRshqHNZ3iP8HqakDlDYp+iZxGxRKzDII2gJUPOpFF1oV/N1W/qT6MrjQ9TuA7heLn
         +M3ndQnsvuOqW/t0vXMEtiJuiIlTnSLEUqbpKvZBaq0V97+pGa+dEg2RTe9CtKk6Pq3U
         POYm+A9xDSv8CiiQ/x1/8wq/jPAQJdbYgoNn+s3lwUwxExJZegzzx67mn8K8gysq/0b5
         kNMrqlnZWk5XfxWGnRpJPYc427WKmINd5r4x2EG1cc/5WMi52uZWKPdzGuUl8f6qch/W
         xdfQNoRZU8XQD0aiyvEZDGQShwLEVqsK32LSy+TjO6cPIuc18JxZV3WG67l0LSsqhu3f
         JmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2BPXcSqviUMzzt2yWOQ58+VJqU1sbMLQIwgcSKKHT9ljtZksgxyFdrjLG6r5bJijqNTKSnOywFIleNRddO1+ibFGrksGEavVNATqBD+Uv4mSsh7HMXXySXPIJ/eXwGfrg/0VGIDyhPS3Cn5nbx5665k8ABsWtSOMCDxFIm0Nk
X-Gm-Message-State: AOJu0YwqY6+qDVsKnqD+VQADLluuaHb+q/wGbNpSqwj31c7Qr+n8dEps
	L6bIi7b6PqRQUIfcd7P+0FCZzgksiodnIEpZR1HWeOjryVrjMp05EhFrxCm5MxcS8Hmrd8zJzSe
	iz9JFntAR9cXo/J7/Dg55tyDctFk=
X-Google-Smtp-Source: AGHT+IGQeDpO3qLCUtbOk3p+jTtxbU6hWaP/Iz24wCfOyfu8LY3PZiARuxQt9DyBevQPnS648u0las74DokIjDihun4=
X-Received: by 2002:a25:d3cf:0:b0:dc7:4c92:16a3 with SMTP id
 e198-20020a25d3cf000000b00dc74c9216a3mr4371146ybf.27.1708092853137; Fri, 16
 Feb 2024 06:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212020403.1639030-1-hayatake396@gmail.com>
 <CADFiAcL+2vVUHWcWS_o3Oxk67tuZeNk8+8ygjGGKK3smop595A@mail.gmail.com>
 <8eb6384a82fc4c4b9c99463a6ff956f04c9d5e33.camel@redhat.com> <bad0da2c-546b-2e05-feea-d395439a0bb0@intel.com>
In-Reply-To: <bad0da2c-546b-2e05-feea-d395439a0bb0@intel.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Fri, 16 Feb 2024 23:14:02 +0900
Message-ID: <CADFiAc+RP91PfEBAnwbABjrHJkdLc0=nm3_TE=+ZaN1AiVQEEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] ethtool: Add GTP RSS hash options to ethtool.h
To: anthony.l.nguyen@intel.com
Cc: Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	vladimir.oltean@nxp.com, laforge@gnumonks.org, 
	Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tony-san and Paolo-san!

> > The series LGTM. I *think* the series should go first in the intel

Thank you both for picking up on the topic!

> I agree. I think it would make sense for this to go through IWL.

I understand. So, it means that it will go through the IWL branch and
then through net-next.
Is there any assistance I can provide to facilitate this process?

Thanks,
Takeru

