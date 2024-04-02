Return-Path: <linux-kernel+bounces-128069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6838955A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A242820E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76786252;
	Tue,  2 Apr 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6r5D6bI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E186251
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065378; cv=none; b=nCweMXRFPjY4bPl0LofQj0k8Q4wTfoE202QKkq3wPgA7GvyCS+fPihAu23ESxyhhP+2YaIHQ44CiVbi4FBxntUuFj5TXD+Gm+PWxjnH7UHwA3YtmOwTkdKOpuZ9hzBIfBE05ML8HUjmhFVPtiI5H7/GLPdQL3ltB1Tc1hjd6yEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065378; c=relaxed/simple;
	bh=i+b1uHVl9rRn+1rrSUi2nuadkeRDlrk+KQBy0RwN1AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeHmV0gjq24jf3YDQQyQjxJ9NMPGmw0wX0j/kSXHf15GaZp56Tjrjoo50PqPfHyCxC4OyLAIJRiLEcycyTqz1BYg5vIvSJvKKUSuGG4psb14nJHPuVyRtr6NjUTKaUmdX1T9J4Dr1F1pJpvZSQ4Fiu8RmtuNf08UxClxXBYmX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6r5D6bI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so62867a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712065375; x=1712670175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+b1uHVl9rRn+1rrSUi2nuadkeRDlrk+KQBy0RwN1AE=;
        b=p6r5D6bIPmyLErQhE/9qVAWKOrKo7F9mgPQd18uZsLU/rklwA8TZ1JcU6TbJYkhA6D
         anim8c7fFnqS5VN9H+naHjjhPPUkwi2nDVM23ljMRWQXqyKOOMGWjmYbV8w2u0GnO09k
         svVPkq7hw+dIiuVAjKWNB91mQnuucYShfBI/paGHyFtGlaq4sUZ86pPiXRKYF2nFAJod
         aBcqa7jvkE1+6qCQnHUq7i4kEOGT9KMq8nN5xR0gcBgASH/r2Vu3dTuuQmbiOL6x4luT
         VBnpD+/4rQT+XH5+VEuLaBZttcxlTNQCJAmZtqYR1EAGunzQ8t821ByZrBxWV6TaoQWz
         nTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065375; x=1712670175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+b1uHVl9rRn+1rrSUi2nuadkeRDlrk+KQBy0RwN1AE=;
        b=F98UD5czW/yGTDufyftjJPcAhMct9XaYPMdxWmREhj/OpeNl2buULaZmYlQYzTgEte
         HTF1/W1AkNI1N/k4ZHdAGkU6+C+wmEeZLM8xTYWFgMxmCF017oDQmh857amMqdIRopiL
         ao86YJiGF+I3n8H1oMV3OWREd+M64ZfKPlsugc6P8jceyMjH75Ot/hjEqYLJ6cMravSD
         K8YADR6JIlBUqhiChpTwuJ05IY+nwVqAb6VU0jYfSym2xZToDONEpjx2u+P7URk2jdXJ
         LvwWeJcumWPybWA8g0MRgolrtVUvMjIPoFmuse7Ov/OEDL7g8/LJYS54bgvTB/t0JqAN
         WidA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pHsAnxjkt6AGWQbbiotXTyPNk8I7eoLjZ2+aIVPr56MoiUZ/OaSpsR4v3xKi8GkJGoV+crOl31vIaEnVtb+F+A9N0VEddba2yMu9
X-Gm-Message-State: AOJu0YwTXHwqziNf8LrdgsbZF+nP++y7w8w/zinVJ4RKb1+474+bpmp5
	Rdpxjg12c8SO9Z4eiPxv+pl0oo7NoJjC5ggJxgzJNOoDLL6/ZKD+Cn2C75tJPq3oRXcvOndkZkg
	3IPNY/G6MuldlfHAeU59jNgy3qnWhrRMWJGVR
X-Google-Smtp-Source: AGHT+IGhJs/xxLuIQ5mlNdSVPp6/sP0TMNItnsrSUwbE9ucDH0CPqmo3gxOVreWdtd51AqX7mTFBgMz53LdQb8hx9z4=
X-Received: by 2002:aa7:c752:0:b0:56c:522f:6799 with SMTP id
 c18-20020aa7c752000000b0056c522f6799mr552042eds.5.1712065374969; Tue, 02 Apr
 2024 06:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306111157.29327-1-petr@tesarici.cz> <20240311182516.1e2eebd8@meshulam.tesarici.cz>
 <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
 <20240311192118.31cfc1fb@meshulam.tesarici.cz> <764f2b10-9791-4861-9bef-7160fdb8f3ae@leemhuis.info>
 <72e39571-7122-4f6a-9252-83e663e4b703@leemhuis.info>
In-Reply-To: <72e39571-7122-4f6a-9252-83e663e4b703@leemhuis.info>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 15:42:44 +0200
Message-ID: <CANn89iKfMTGyyMB-x74J5bgzhM1RxSvuNhvXyWWv4DO8MZakSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	"David S. Miller" <davem@davemloft.net>, open list <linux-kernel@vger.kernel.org>, stable@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:40=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi. Top-posting for once, to make this easily accessible to everyone.
>
> Hmmm, looks like Petr's patch for a (minor) 6.8 regression didn't make
> any progress in the past two weeks.
>
> Does nobody care? Did nobody merge it because no tree feels really
> appropriate? Or am I missing something obvious and making a fool out of
> myself by asking these questions? :D

It happens, please resend the patch.

