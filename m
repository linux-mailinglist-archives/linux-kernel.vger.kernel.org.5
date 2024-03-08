Return-Path: <linux-kernel+bounces-96528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B6875D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6151F22CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BDF31A82;
	Fri,  8 Mar 2024 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t/VYp1VT"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414E2C84C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709875804; cv=none; b=Stwt0Hd7HG8eq+JdMdWvDYPDzDBQ49GCvlAYKLUVDFx/l+iouu9eVGJOZCWows95FPAef7VqxZ0Zqaut8edWKLfhkpG2efG+NYzuLjOgrp0uOeSsWxdB8l59Vy/SBy1tqBfTkwEFEk/9SOmWFQ0hNvR9vTELissbr0i27WqIZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709875804; c=relaxed/simple;
	bh=Ee8xsda7Vwi+bOMTAQh/advAL1XK/mCGrmDNiFEbggI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAlvu4ms/lSG6y6pkaQ9pRyhjVyS5Qum5oznFEeChNrjUs88jRiJwqa+O3BT5PagnLArgiNTXM7eed3NVDfsOOFlIFdWqD4n3CemLPHdlueoG6dh+zwtbJfVqIbkTOOBvZ0N+cxcABPWtNHCBusNnIBEkSbMc6UJsenY8plyJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=t/VYp1VT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so22522371fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 21:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709875801; x=1710480601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee8xsda7Vwi+bOMTAQh/advAL1XK/mCGrmDNiFEbggI=;
        b=t/VYp1VTSVit3Ed1XllxfnJt8CTRcgZ8TlBm5UUqIo0tOolA/nNjPQ3cHTF1HXhJP4
         jPASakA5UCs/iaD+8oN6uvwM/FN2sBqZKUWbErJ24heoxkReB7fmmJPk1WJ2YKZ5m+50
         aRP7PH1wISAPduRM+iO4RfBrGbLvKj66USQak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709875801; x=1710480601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee8xsda7Vwi+bOMTAQh/advAL1XK/mCGrmDNiFEbggI=;
        b=sxDZvd9HG4bya8FF5sb/pO9I+ht/UO1eDRFdCprS8nOblwKU4pqlBDr3LlmE7mXBf0
         M7DR2+oujXXr8JQU7GK4uU3LUt5TSw5uzru9+QanvZkcVSVJ5+sUQgBVdmVMvZl0MSv+
         eI+T4LoXW7N8GVk5KRYRfcONnr15zdrqLc/KgBM8gA8pGrue18Gjk20aO78/n2yogZAi
         HkMegIn/+D08DZdbTPYWAC4soextWpvxJlXxlf1AP9TElG2712Al9g/wzBGGfq1Oa3e1
         PQXi5rbZH2R+Mr+buH+TDc2UnrkgcUoyv0S4P2yWDksTr5XZdeeYb/sX7MFKMGbqB1vX
         qrgA==
X-Forwarded-Encrypted: i=1; AJvYcCVU8Eu4jYJHp+H4zD9o9d5NtyOn+fxl8QDIrulc/FR0aJN5yBcGk9MKbYVpUVqT8ZzdktTDqJBQeRJ/7OzffSUoCuXMlAkhXQsMhZ13
X-Gm-Message-State: AOJu0YxI6fQsZtwP8g6sFhdeBAh4HeM4WYgALR9q4/3ygXjrqWpARSZG
	AbEuuIcvhQo2MT2ZRoSN/5JutEzZNdoF6Vi06D9ZxMFrOyR3avPJK8OVZiH9T47u60QnacOPOkT
	xA//MNOeHAY30UO0psKQEQba9g3af453u0FoURg==
X-Google-Smtp-Source: AGHT+IEk14Ets9T/0XdhIqCtCWHZ6FH0YQ8by2Jg27AfMws7BIiXiLLvAT/tT0G/cK69V7wHAGM9eEOKI3nqgY0H7Nc=
X-Received: by 2002:a2e:98d5:0:b0:2d3:4b85:5734 with SMTP id
 s21-20020a2e98d5000000b002d34b855734mr2837290ljj.36.1709875800709; Thu, 07
 Mar 2024 21:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com> <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com> <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop> <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <87edclqt6a.fsf@oracle.com>
In-Reply-To: <87edclqt6a.fsf@oracle.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 8 Mar 2024 00:29:49 -0500
Message-ID: <CAEXW_YRaDSXp9eSbhwq==npecbUsWkoxggZk40adG0BhVv9_cw@mail.gmail.com>
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	peterz@infradead.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org, 
	mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, bristot@kernel.org, mathieu.desnoyers@efficios.com, 
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de, 
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com, 
	krypton@ulrich-teichert.org, rostedt@goodmis.org, David.Laight@aculab.com, 
	richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:49=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>

> The PREEMPT_AUTO, preempt=3Dnone policy in this series will always
> cause preemption to be at user exit or the next tick. Seems like
> it would be worse for higher scheduling classes more often.

Ok, sounds good. I believe we are on the same page then.

Thanks.

