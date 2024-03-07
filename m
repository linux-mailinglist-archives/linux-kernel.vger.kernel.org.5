Return-Path: <linux-kernel+bounces-96364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7B875B22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B711C21326
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526CB4644F;
	Thu,  7 Mar 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz/LTjNx"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95861E86E;
	Thu,  7 Mar 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854184; cv=none; b=n0j6t9IO6vRClPLaGMrT3e6MNQo/RwVhzY9A7SmFDuCCXWF+NySsk8kvHeF25Irt2k3B9xils67tKc0KrfUHdngw7HXdo5V3FbT52FZ6FJBPhadAv48+cGpcBWwkOFhLcbLOXGKoXmgskLxLSql3UEigvcvLFaOWgyMuVOkVMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854184; c=relaxed/simple;
	bh=aeHq1OyaXPkgeCtznwopsKLF6LnvI8P90UUePt6+ECg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yfjq57ZC/ljXwe64zGbB7oQSAct0+3WKgjz3a2jzMKkEhohnzftaNm9jtXmeIPBYWAiGZRGn4MV8sEsAHGdTU09qyQdO1u/Z5UMOcqiwbqjYIqXtMOmoV1fw0BCVTEfmxw8VSapjfc4pp2F2l560JkYjdRK/+uB5sKgchQHucnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz/LTjNx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131f3fc695so372558e87.1;
        Thu, 07 Mar 2024 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709854181; x=1710458981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsO3+oD8Cc/lz53BTg7OETqqdWmZVVWf9UF6Y4QPW8A=;
        b=dz/LTjNxEub9Ed5XuPzoQeoJCGzRjOGoVvnSDkxImkWiiNBbdqt2sK5NpVxIKHuZlG
         CaPYFGfvdJEBRMEGZ8JBajMlJqSoDLxC/45FIRs5bdhAUs1Ur3sniT3BoZws3ulfJNWd
         uljLs+aQhqP6++1DmjmNpYjxq16hkf/SFdK+j2sIQlh/58RSfugss5z9szE2FQkkxcTU
         6q8lM/XxcaMbYYv3mm5AERd97rAYGKOjo26vTGpNdn0P8UMO1jhub+HpISaKlrMaLqS/
         rkmEmfhXEh3rkzuhRaJyR9v9nDaxAhblM3GOJcEplXtADLpZ34K+LeRUoV8L1nEpRS5n
         oTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854181; x=1710458981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsO3+oD8Cc/lz53BTg7OETqqdWmZVVWf9UF6Y4QPW8A=;
        b=i/2Llac0/N70NwKw3XRVILuLDTdl1tI6ES+ww486l6Gv9d6HCPepeR2NLmrH1suRqU
         omHj8O8Q08gNIa4see+yF121LNWBjCymlnREHx7IXJZLADImmZcPV6dMYeyCaDAD/4Ts
         1CVWxNhPrCHFJ3lLA01uIox+cm0XF4pS6ZR+w7fFvZT8ZNrgjtAzqrZOT2clfSge/4iq
         OxWdV/KnzLeTLEsFicpoCzYNiGpQ760qXAKrpdAhkEUn0fb6Wb9drkJ/5y72uHypFwZk
         pjpV/5h3uyno26VrG5wetiwYw42+p9YZEJoxxwABpiX9tKNPo2iC02O/0ZDVmH/bKDHw
         UhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB2y8im7ldKd2sF6mrkt40ONsVjFghRzsb1DDk9S0sg5fkxVnJgfcQ5thstdG/r8ZIprkjeJ5ffymP5GlwWhYI1dEe8Fk1sHDu+6EeChErV53tQH+FWHwQF6Pr5Q3j1gPCqi9cEKM2qNs6wyY=
X-Gm-Message-State: AOJu0YxTFQshEjs1QCKqZ2T8XZe+zQ4phCZXYl8DJwy4IjeaJNJmHy53
	/d66yybH/JAl89QNWeD043z84TPGsJh4CICLnbFJ3xAWZce91LOF
X-Google-Smtp-Source: AGHT+IHGCpQOQdNOKxfYEvGXuyXZFqoTDSIL7IPqeRB3wkKFGN4K/x3zziobvt+uAqfMerT7QcprFA==
X-Received: by 2002:ac2:46d2:0:b0:513:2c6c:4cc8 with SMTP id p18-20020ac246d2000000b005132c6c4cc8mr2300995lfo.63.1709854180622;
        Thu, 07 Mar 2024 15:29:40 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512324b00b00512d2453210sm3247126lfr.101.2024.03.07.15.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:29:40 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: m@bues.ch
Cc: deeb.rand@confident.ru,
	jonas.gorski@gmail.com,
	khoroshilov@ispras.ru,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	rand.sec96@gmail.com,
	voskresenski.stanislav@confident.ru,
	james.dutton@gmail.com
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Fri,  8 Mar 2024 02:29:27 +0300
Message-Id: <20240307232927.171197-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307223849.13d5b58b@barney>
References: <20240307223849.13d5b58b@barney>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Mar 8, 2024 at 12:39 AM Michael Büsch <m@bues.ch> wrote:

> The point is that leaving them in is defensive programming against future changes
> or against possible misunderstandings of the situation.

Dear Michael, I understand your point. It's essential to consider defensive
programming principles to anticipate and mitigate potential issues in the 
future. However, it's also crucial to strike a balance and not overburden 
every function with excessive checks. It's about adopting a mindset of 
anticipating potential problems while also maintaining code clarity and 
efficiency.

> > I understand and respect your point of view as software engineer but it's a
> > matter of design problems which is not our case here.
>
> No, it very well is.

I'm talking about your phrase "Not having these checks is a big part of why
security sucks in today's software."
I think it's a matter of design problem, when you don't have a good design 
of course you'll need to add so many checks everywhere.
Let me explain my point of view by example, 

// Good design
CHECK(x){
	if x != null && x is a number
		return true;
	else return false;
}
MULTIPLY(a, b){
	return a*b;
}
SUM(a, b){
	return a+b;
}
...
MAIN(){
	// input a, b
	CHECK(a);
	CHECK(b);
	// now do the operations
	SUM(a, b)
	MULTIPLY(a, b)
}

// Bad design
SUM(x, y){
	if x != null && x is a number
		return x+y;
}
MULTIPLY(x, y){
	if x != null && x is a number
		return x*y;
}
..


> A NULL pointer dereference is Undefined Behavior.
> It can't get much worse in C.

Again, If we adopt this approach, we'll find ourselves adding a null check 
to every function we write, assuming that such changes may occur in the 
future.


> Your suggestion was about REMOVING a null pointer check.
> Not about adding one.
> I NAK-ed the REMOVAL of a null pointer check. Not the addition.

My suggestion was to remove a (REDUNDANT) null pointer check, and not a 
null pointer check, there is a big difference.
Would you please check the link in the previous comment about a similar 
situation got accepted and applied.


> Absolutely wrong.
> Not having a NULL check complicates reviews.
> Reviewers will have to prove that pointers cannot be NULL, if there is no check.
> Removing this check would improve nothing.

With all due respect, I respectfully disagree with you on this point. In 
your prior comment, you stated, "it is clearly documented that the pointer 
can never be NULL" However, if the reviewer encounters this check, they 
might mistakenly assume that 'dev' could indeed be NULL before the function
call. Conversely, if they read that 'dev' cannot be NULL, it could lead to 
confusion, and perhaps they want the actual null check. Removing redundant 
checks could mitigate confusion and minimize the risk of overlooking the 
actual null check for example.

--
Best Regards
Rand Deeb

