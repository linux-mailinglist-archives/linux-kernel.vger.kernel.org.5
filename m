Return-Path: <linux-kernel+bounces-96556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74AA875E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405712832EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8674EB20;
	Fri,  8 Mar 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJUI8PVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D61D699
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709880865; cv=none; b=gL9tnifWOkoMwAVEoUnAAO5/xmEDOD3Y6fcOaXsqllAok5xSRgDqvmPEfQJ3clxhzVTi4TKRRJnnSZlieMU6SSx5zp+UN5r3ie6TfaK+Z0jlpVZAi18xTuRSpN2sGvZe4w5iNorNojkBa585pCO7V0vdUL1Wt0nMrp5JOQcLSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709880865; c=relaxed/simple;
	bh=xuIF277pS+y5c3blkDWZHPXDqgniXKzFLfOr8v4pbp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQkMpAi3+7uwM7MMyGxSroo/UHLq2Cj+0YsArRXiO6P8EKtHH/hcWsxtDICWpB34y102cZ7JhIZQXR3ntTflzpd/IbAezt+BEPDUuiuaBcpSp2I2wx5cGjxRZOzWcNE9dGK19a4HV6ucNoVNo4lbMNfYAi8J/6cJFrxWqjReAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJUI8PVN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709880863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuIF277pS+y5c3blkDWZHPXDqgniXKzFLfOr8v4pbp4=;
	b=DJUI8PVNRyTQAaStfsYJ6r2edt73lZnsR/C+mPGGUnPA3GZ4/MDJbzhETmbKNmrKLH4Ntq
	9XD6RU3KIVxmfL9d2jWJSyLnso5GF3x+VXSqVsJOBqb7xnvlPfmKT2yBNjQDa8ha0F9Jfc
	Fzm+uNF9s3+DPrBPXpnaWTjtIG9x+ms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-xnGrOeTrN0mJ-F6xoco7Qw-1; Fri, 08 Mar 2024 01:54:19 -0500
X-MC-Unique: xnGrOeTrN0mJ-F6xoco7Qw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d19951a9bso139302f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709880858; x=1710485658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuIF277pS+y5c3blkDWZHPXDqgniXKzFLfOr8v4pbp4=;
        b=YISEIv53OVwD9OnBFl8JW2TeOujLESKfoE52UQLBji7NuUS8sj8h8gsjUuSZq11g1h
         wQHPvw8OkEEn5VLD0VwezlUbBC2LioVcaPp0ft7X5cl33KpylKp1LillB8f7K52seCS6
         CG5rwwTsHEvLAgomyhKkzjwh8KU+Pq8AlM+Cjbh2ywywHNCzQCfETs12juM2hqDP20om
         U6CkqkQmWUOMalFvc1ei/oQCrzGhV51kQ+e86siMorri2MeRR1+BHElJgjcNRETW66Ik
         3XNmbLwqmv3efNs5nw/pKd89G2uLf5mlScN3YmusyFUY6SZwya5LYFAhfd8bUHovdv1J
         WiMg==
X-Forwarded-Encrypted: i=1; AJvYcCX31K1WljqwCUg0cYvjlnJKYIJPIEM4fTScFEOwrGnlIb6B2gJVyXUwLeLukZsskEe7VBh3LjSy95k6zCn7Q6d6K+bnbl3DbXSxVRgG
X-Gm-Message-State: AOJu0YxPHPFCTpakDbYT6yJh2jWn9+isiRV2/PfTYgJUryYrpD0Tiy5D
	INXJqVV3RcJUp5nKWyK+e0Z+eUs6g+MpR2J1P2Td/MVfoQ5l3EuNaVivCOv7x4rtWuxwIsz77y1
	weBGbZnAqYGadQXf4fbREWRei8dNeTKMw01LPy6o/QNG9OCN5aiVYFw5aB7TBhw==
X-Received: by 2002:a5d:5651:0:b0:33d:6bd5:9f00 with SMTP id j17-20020a5d5651000000b0033d6bd59f00mr13722711wrw.41.1709880858518;
        Thu, 07 Mar 2024 22:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIkNCg8dS5+UGICKGXMGApzhV6Hrk7DKyKGQ9+Rcd2E4JwkHDtrlxvL3WtchQu0F7ibaof5g==
X-Received: by 2002:a5d:5651:0:b0:33d:6bd5:9f00 with SMTP id j17-20020a5d5651000000b0033d6bd59f00mr13722692wrw.41.1709880858169;
        Thu, 07 Mar 2024 22:54:18 -0800 (PST)
Received: from localhost.localdomain ([176.206.22.187])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600003cc00b0033e451a9b64sm10813308wrg.61.2024.03.07.22.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 22:54:17 -0800 (PST)
Date: Fri, 8 Mar 2024 07:54:13 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Message-ID: <Zeq2FUkU4nVSjY7I@localhost.localdomain>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <87edclqt6a.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edclqt6a.fsf@oracle.com>

On 07/03/24 19:49, Ankur Arora wrote:
> Joel Fernandes <joel@joelfernandes.org> writes:

..

> > Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
> > he seems to be suggesting preempting instantly for higher scheduling CLASSES
> > even for preempt=none mode, without having to wait till the next
> > scheduling-clock interrupt.
>
> Yes, that's what I was suggesting.
>
> > Not sure if that makes sense to me, I was asking not
> > to treat "higher class" any differently than "higher priority" for preempt=none.
>
> Ah. Understood.
>
> > And if SCHED_DEADLINE has a problem with that, then it already happens so with
> > CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
> > more than the treatment given to higher priority within same class. Ankur/Juri?
>
> No. I think that behaviour might be worse for PREEMPT_AUTO.
>
> PREEMPT_NONE=y (or PREEMPT_VOLUNTARY=y for that matter) don't
> quite have a policy around when preemption happens. Preemption
> might happen quickly, might happen slowly based on when the next
> preemption point is found.
>
> The PREEMPT_AUTO, preempt=none policy in this series will always
> cause preemption to be at user exit or the next tick. Seems like
> it would be worse for higher scheduling classes more often.
>
> But, I wonder what Juri thinks about this.

As I was saying in my last comment in the other discussion, I'm honestly
not sure, mostly because I'm currently fail to see what type of users
would choose preempt=none and have tasks scheduled with SCHED_DEADLINE
(please suggest example usecases, as I'm pretty sure I'm missing
something :). With that said, if the purpose of preempt=none is to have
a model which is super conservative wrt preemptions, having to wait one
tick to possibly schedule a DEADLINE task still seems kind of broken for
DEADLINE, but at least is predictably broken (guess one needs to account
for that somehow when coming up with parameters :).

Thanks,
Juri


