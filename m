Return-Path: <linux-kernel+bounces-94881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94E874644
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BD71F23F87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7EDDC9;
	Thu,  7 Mar 2024 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Aq8vVxWq"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639D63D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779445; cv=none; b=ub/34E7Frlxgq9H5310W9/sfgdCCzI+VEoMGAZrGc366B3EYXiDsoIKgXKPbGAapPwmzjTZJM1jGzeVr2kvXCjeOdhTctJU3qUaSYwauTzsQiYiy6nPMYjT8Wtg6lls3MPurJZgNY2rtj76Wr47UNCVIFzCinIzng2NDJHoABAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779445; c=relaxed/simple;
	bh=zV/eWO1YR+/MLdUcmWtn+zHFWG88UIj9WbZI1A7krRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqZGyFIiDE95m5hg8oH+KFR3yLhx+/dzNc6TP3w4KAEpSZpLYzaw5irf5XmfvVdma07LjQDLl93l9UJxML8gNJKAOTqEbvQaf6TpNVwz8S9G9c6DkuqxDCOrDLXkwlMtsbkQtQv3XPTVjT9S/pAGZrtiEOCYxf5S7NxPV+AQVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Aq8vVxWq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5132010e5d1so545107e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 18:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709779442; x=1710384242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8aBTmS0uzOVB2zuwBnhmAk7ClNR7ZgZluXdpxoMOVc=;
        b=Aq8vVxWqGmj9KULj3ewAucEOAXDpTM4Jme1LON/i7Q7bc//Msa9EUBFIK/VdBspxHO
         dqWHmCZeqPfxlyTx4+IFSD72Ykah0IB4Dz0kPmuhK9Ioa0ylF5wv+LDCYXTZf2z4/m8n
         SJ1BddWH69PImtgKsmioY6JcKo4Ou9CZz4bJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709779442; x=1710384242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8aBTmS0uzOVB2zuwBnhmAk7ClNR7ZgZluXdpxoMOVc=;
        b=gEU7kZrQJGs1b0IBpLn6nGfTY8Q6BgtUv85kb6ITby4D3wp56ROVORbbILVg7efAdW
         q6EzaMG52l8uAchJD322IImAShiDl5E9XcHO1PuWyVKTT9PrDx+PQAqxDF6wcuuV8sjp
         nPtQMV5eG2g1eq1l0OCNk31QwuzAl5PeUB1K/bObD7cbElYox2pQopzP6k3fSJA1BWDx
         0Ky+8RElu80Kx5m5QDnZhY1acLmBqu/tu4nlM08RETd/MbhJzPLRZvmELrTdbXWNU/qH
         WX3rf11PaZtJpm+23D/YLcaIC6Oxon4mrltZFyU4wteOiKgPneI0g/vfXmq++Sjl88Xa
         LjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE61mr1mNh422svPn1P39lf18HHhZpFq+UDNcEvc+DQPVJawaaJ9/m9UTRI8xl7/1wTJ7karZXMYVpezXspvSeT3Ky5d5SGE5Z3F2j
X-Gm-Message-State: AOJu0YxKfSJIvfWTO7e1TWfPnIzyGpWrNxGo7G4L1rNj9rapB/mXICDW
	3KspvAXykwCbNERaRe/1YuxVtu1gXYjwuVKfsF9WoCV4fe+ptwx8FomBmybzltgbYNRMZsCEqFw
	R6VHp0A==
X-Google-Smtp-Source: AGHT+IEKGEyzy5YwO2NEKr6Ae3Ezu3ilj3ncZaSBl5El4Nes1BShvSqscMw0wfGyfJVmZZd1hlQUIw==
X-Received: by 2002:a05:6512:546:b0:513:5991:1482 with SMTP id h6-20020a056512054600b0051359911482mr483680lfl.35.1709779441640;
        Wed, 06 Mar 2024 18:44:01 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m25-20020a194359000000b00512e3924539sm2901979lfj.309.2024.03.06.18.44.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:44:00 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513298d6859so358487e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 18:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIjxtAqd3ufZnSCvKMdH7NUyJ4HUS5Pt/AMgJ8V0cZKeJNTmT8grf0W+HeVd1AVq1ljdKXm/4M9VnXQ0V4hamRF1K/osLPg/MsCU/6
X-Received: by 2002:a05:6512:3daa:b0:513:6543:d2a8 with SMTP id
 k42-20020a0565123daa00b005136543d2a8mr586305lfv.16.1709779440068; Wed, 06 Mar
 2024 18:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
In-Reply-To: <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 18:43:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Message-ID: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002c51840613090c9d"

--0000000000002c51840613090c9d
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:29, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> TL;DR:  Those ->rtort_pipe_count increments cannot run concurrently
> with each other or any other update of that field, so that update-side
> READ_ONCE() call is unnecessary and the update-side plain C-language
> read is OK.  The WRITE_ONCE() calls are there for the benefit of the
> lockless read-side accesses to rtort_pipe_count.

Ahh. Ok. That makes a bit more sense.

So if that's the case, then the "updating side" should never use
READ_ONCE, because there's nothing else to protect against.

Honestly, this all makes me think that we'd be *much* better off
showing the real "handoff" with smp_store_release() and
smp_load_acquire().

IOW, something like this (TOTALLY UNTESTED!) patch, perhaps?

And please note that this patch is not only untested, it really is a
very handwavy patch.

I'm sending it as a patch just because it's a more precise way of
saying "I think the writers and readers could use the store-release ->
load-acquire not just to avoid any worries about accessing things
once, but also as a way to show the directional 'flow' of the data".

I dunno.

           Linus

--0000000000002c51840613090c9d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ltgmgj3o0>
X-Attachment-Id: f_ltgmgj3o0

IGtlcm5lbC9yY3UvcmN1dG9ydHVyZS5jIHwgMTEgKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3Jj
dS9yY3V0b3J0dXJlLmMgYi9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYwppbmRleCA3NTY3Y2E4ZTc0
M2MuLjYwYjc0ZGYzZWFlMiAxMDA2NDQKLS0tIGEva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMKKysr
IGIva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMKQEAgLTQ2MSwxMiArNDYxLDEyIEBAIHJjdV90b3J0
dXJlX3BpcGVfdXBkYXRlX29uZShzdHJ1Y3QgcmN1X3RvcnR1cmUgKnJwKQogCQlXUklURV9PTkNF
KHJwLT5ydG9ydF9jaGtwLCBOVUxMKTsKIAkJc21wX3N0b3JlX3JlbGVhc2UoJnJ0cmNwLT5ydGNf
cmVhZHksIDEpOyAvLyBQYWlyIHdpdGggc21wX2xvYWRfYWNxdWlyZSgpLgogCX0KLQlpID0gUkVB
RF9PTkNFKHJwLT5ydG9ydF9waXBlX2NvdW50KTsKKwlpID0gcnAtPnJ0b3J0X3BpcGVfY291bnQ7
CiAJaWYgKGkgPiBSQ1VfVE9SVFVSRV9QSVBFX0xFTikKIAkJaSA9IFJDVV9UT1JUVVJFX1BJUEVf
TEVOOwogCWF0b21pY19pbmMoJnJjdV90b3J0dXJlX3djb3VudFtpXSk7Ci0JV1JJVEVfT05DRShy
cC0+cnRvcnRfcGlwZV9jb3VudCwgaSArIDEpOwotCWlmIChycC0+cnRvcnRfcGlwZV9jb3VudCA+
PSBSQ1VfVE9SVFVSRV9QSVBFX0xFTikgeworCXNtcF9zdG9yZV9yZWxlYXNlKCZycC0+cnRvcnRf
cGlwZV9jb3VudCwgKytpKTsKKwlpZiAoaSA+PSBSQ1VfVE9SVFVSRV9QSVBFX0xFTikgewogCQly
cC0+cnRvcnRfbWJ0ZXN0ID0gMDsKIAkJcmV0dXJuIHRydWU7CiAJfQpAQCAtMTQwOCw4ICsxNDA4
LDcgQEAgcmN1X3RvcnR1cmVfd3JpdGVyKHZvaWQgKmFyZykKIAkJCWlmIChpID4gUkNVX1RPUlRV
UkVfUElQRV9MRU4pCiAJCQkJaSA9IFJDVV9UT1JUVVJFX1BJUEVfTEVOOwogCQkJYXRvbWljX2lu
YygmcmN1X3RvcnR1cmVfd2NvdW50W2ldKTsKLQkJCVdSSVRFX09OQ0Uob2xkX3JwLT5ydG9ydF9w
aXBlX2NvdW50LAotCQkJCSAgIG9sZF9ycC0+cnRvcnRfcGlwZV9jb3VudCArIDEpOworCQkJc21w
X3N0b3JlX3JlbGVhc2UoJm9sZF9ycC0+cnRvcnRfcGlwZV9jb3VudCwgKytpKTsKIAogCQkJLy8g
TWFrZSBzdXJlIHJlYWRlcnMgYmxvY2sgcG9sbGVkIGdyYWNlIHBlcmlvZHMuCiAJCQlpZiAoY3Vy
X29wcy0+Z2V0X2dwX3N0YXRlICYmIGN1cl9vcHMtPnBvbGxfZ3Bfc3RhdGUpIHsKQEAgLTE5OTEs
NyArMTk5MCw3IEBAIHN0YXRpYyBib29sIHJjdV90b3J0dXJlX29uZV9yZWFkKHN0cnVjdCB0b3J0
dXJlX3JhbmRvbV9zdGF0ZSAqdHJzcCwgbG9uZyBteWlkKQogCXJjdV90b3J0dXJlX3JlYWRlcl9k
b19tYmNoayhteWlkLCBwLCB0cnNwKTsKIAlydHJzcCA9IHJjdXRvcnR1cmVfbG9vcF9leHRlbmQo
JnJlYWRzdGF0ZSwgdHJzcCwgcnRyc3ApOwogCXByZWVtcHRfZGlzYWJsZSgpOwotCXBpcGVfY291
bnQgPSBSRUFEX09OQ0UocC0+cnRvcnRfcGlwZV9jb3VudCk7CisJcGlwZV9jb3VudCA9IHNtcF9s
b2FkX2FjcXVpcmUoJnAtPnJ0b3J0X3BpcGVfY291bnQpOwogCWlmIChwaXBlX2NvdW50ID4gUkNV
X1RPUlRVUkVfUElQRV9MRU4pIHsKIAkJLyogU2hvdWxkIG5vdCBoYXBwZW4sIGJ1dC4uLiAqLwog
CQlwaXBlX2NvdW50ID0gUkNVX1RPUlRVUkVfUElQRV9MRU47Cg==
--0000000000002c51840613090c9d--

