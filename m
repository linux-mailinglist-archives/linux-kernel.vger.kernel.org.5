Return-Path: <linux-kernel+bounces-102571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B987B401
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8314C2853FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45C55E6E;
	Wed, 13 Mar 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="OCTLWt+E"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455C54BCF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367131; cv=none; b=XkcZHHQv2uHCloMGTZKFwDKfBelkvykwOrWA8Pb/Jxt8HhdiAmlrihbmZCOtO75Z5V33wLwKIwJhDcRpSysQ0NeAjF9M2ws3oUtvrDRmjIo/1Tnm9nAZU09QPK+zWAyOkatnCsACuSQryDEH4XMuQPaeYJVN8ZFTgh6YRTUa7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367131; c=relaxed/simple;
	bh=mr233kmYQvQ0cZG7aNTOq+2559t3369Edstg1GpCS9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lx0z51Q06eNVT15kM6hBl9HV8BIu0ILG89l8O1kb1qRa06wU62yWOlN1/aoUm+t+KKVo18EXgN4XcMlWoh/2m5AVKGFdgOF5NLgwhgTyMt1f2TTGxwQoMvb5KrLCXOXPN4+sADjanZOBnXFKWWcPc50LQNqS5ymPj9eFAdmF15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=OCTLWt+E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e966f56c7so259444f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1710367127; x=1710971927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mr233kmYQvQ0cZG7aNTOq+2559t3369Edstg1GpCS9E=;
        b=OCTLWt+EmPbkXhtzS7ZHXOfLwndH84IzCuENAqFZLiLV7wADbzylyXJugxnz+jRBHT
         nKH6ZO8NI0y3M77sbsFlO5KoZvwzqkoWi+6UFpdFEbDv1Qprxca9iR73mk8T6We86ccy
         tZesUsR1a0mmKNTq5QRPRtwbrK9Oe6qVX7QfsA7/TDrWqmwFIarUKWCLyFaj5m8OJv42
         iKGz00+wFGMFYPgsjuICnhs+xOknjaoB5EprtAinSAL33CWOnpkw0MSX5sFjhcy142Lo
         vMSVEXQAUn01+WENQq/p/sBwb9BxBoXZA/nAp0ziCF/IrtHmnFdzOdGm8B6fq4gI6XPV
         dp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710367127; x=1710971927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mr233kmYQvQ0cZG7aNTOq+2559t3369Edstg1GpCS9E=;
        b=Y1Y/UeqwqIDjecOZl7hVAISWgvEfI5oeh4oSMuQQDxY+MSxk90rjHjW5eE20tA4FR8
         iD+DztHVTmSJe/9xY1O48BD6lYdkOfzebA/5aZmMrbIpyYghaf0+L87VmjcQZm0VSWc+
         dQTAto8zRSDM/9M9GtubhDChxBjkN9hXw1rF1JSA3AndrE7oJQz7wMXEXNxmJmE/g9rE
         xr8zvBY64sWnX4tQD393e8iyATQN2R7Q+6w1SBY2Jfo9H9AR0JM0bOwVnIUh38GgOkye
         7f0G4j2lVflAmw5E05jakjqUmMyxaSx/zd3+PPaMtpzGaq8gFYx6vmd0sVSdqvABf6j2
         NWfg==
X-Gm-Message-State: AOJu0Yx+NTuznmqBD1DFWVRzK3STleX/t4EiV244gmA7YPkWafy8NzTH
	d2afP2dAwftyp55hBSd1WASyBAUx97XIpN+SLqj1CW5ZdLkES42J/0TKhBxBYUqEhP6jk3WMCdA
	h2+EjCEIUMgE4D73+saqOdjOwYohWDNhQE4HA+pFQv43AxrKjXoTs+ftH3Uza7wNSsWjtCQwCti
	n9aCWGoHuBatHzIwZA3ZHoLKyijp4T01H1owvI+DXuNeuZsHWnVwLURCJ7EppD7BaxRveK5KkeW
	mjytkBeA7UjUltxWGL+ycXduVnqn28BMRcH6mcG1Jxo0oCH8U1l9UCYqpqxiaPQm/ieZ6VmEz0z
	3apbr/u2cvstmrZZ7S+BJVPjLVAv25iXDu2Dqo57FYSbCw==
X-Google-Smtp-Source: AGHT+IFr3YjxaL5z3EOknY50vzW2ARohxjcIJEuW4ogMqiMgHsxF4dFq7/Z68oUWzf2c3h3R/jn5Ag==
X-Received: by 2002:adf:eec7:0:b0:33d:7afa:fb0b with SMTP id a7-20020adfeec7000000b0033d7afafb0bmr2677991wrp.15.1710367127199;
        Wed, 13 Mar 2024 14:58:47 -0700 (PDT)
Received: from avi.scylladb.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d4a11000000b0033e8c50fc3fsm95079wrq.90.2024.03.13.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:58:46 -0700 (PDT)
Message-ID: <96325519f8f05d7289ec9b0af4e89da28c432e4f.camel@scylladb.com>
Subject: Re: [RFC PATCH 0/2] Introduce serialized smp_call_function APIs
From: Avi Kivity <avi@scylladb.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Oskolkov
	 <posk@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng
 <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,  Maged Michael
 <maged.michael@gmail.com>, gromer@google.com, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Wed, 13 Mar 2024 23:58:44 +0200
In-Reply-To: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

[resend in plain text for the list]

On Wed, 2024-03-13 at 16:56 -0400, Mathieu Desnoyers wrote:
> commit 944d5fe50f3f ("sched/membarrier: reduce the ability to hammer
> on sys_membarrier")
> introduces a mutex over all membarrier operations to reduce its
> ability
> to slow down the rest of the system.
>=20
> This RFC series has two objectives:
>=20
> 1) Move this mutex to the smp_call_function APIs so other system
> calls
> =C2=A0=C2=A0 using smp_call_function IPIs are limited in the same way,
>=20
> 2) Restore scalability of MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
> =C2=A0=C2=A0 MEMBARRIER_CMD_FLAG_CPU, which targets specific CPUs with IP=
Is.
> =C2=A0=C2=A0 This may or may not be useful, and I would welcome benchmark=
s from
> =C2=A0=C2=A0 users of this feature to figure out if this is worth it.
>=20

I see this doesn't restore scaling of MEMBARRIER_CMD_PRIVATE_EXPEDITED,
which I use (and wasn't aware was broken).

I don't have comments on the patches, but do have ideas on how to work
around the problem in Seastar. So this was a useful heads-up for me.

