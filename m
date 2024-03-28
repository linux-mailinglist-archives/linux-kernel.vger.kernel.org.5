Return-Path: <linux-kernel+bounces-123584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C9890B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB4CB218CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BA4594C;
	Thu, 28 Mar 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0+n9amV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A317EF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657889; cv=none; b=h68gh9e8BjZ/GxOKkmH6Mz6BeB2hRqdZ+xtz67p8KLV3AxkhJudfZF7LAFUMnDxN5evkPPOrkUgVwnPdrXq8Sk5JsId2W/ZEp5iwHFVDzgWkUbAGVgClhHLYJf2VxzSMLb8IQLIETFh28stlVjnwOPrGyZgEaMzWifn+SdJb80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657889; c=relaxed/simple;
	bh=YzGQt/G2u3Ya5Vtinp0gLWvB5+yODvi9RN7jYw6xki8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alDgGwR9K0ICLeDdbiMHln72etHkfiROghnW+hikGzZmjSld1I6SykObckYAWJbmkzKtHu+WumUqGoklS6a6VVuIIU82h8eZQLI+T5Mwcsvn0RunUHg8A5Vt7gSGhmopO/8BjcEHB4AvVqjjC89UPspodc/+mXg9+b34X2lpYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0+n9amV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711657886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WaoYC1FAMHc/FfYWm4Pea8fphtZHEcZ3FdsLlbNS0g=;
	b=X0+n9amVHSvP3QmOYftgUiXYIh8JzRqdNggs3VbAv1i/XO6qrjIMCSbYtbmthrjCdb7gsg
	1Brln3oMGZbbV7jJ81jVIZU+yphn41V6QYTlL/bE/xMdksY03qVew4LQ8Vq7Mbejb3TDRU
	r1T2aVfkqH54DbnLfoPF2lpqf2242fE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-lhdzWS2mOjCCV5Cb4bstWg-1; Thu, 28 Mar 2024 16:31:24 -0400
X-MC-Unique: lhdzWS2mOjCCV5Cb4bstWg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ec6c43a9cso1026166f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657883; x=1712262683;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WaoYC1FAMHc/FfYWm4Pea8fphtZHEcZ3FdsLlbNS0g=;
        b=M2X4xVdbp7BDe0LivT2KRIB7g4XeKw2Se6piL7upvEOj0jGOo0j0iGEP54zCyjXzXu
         oxxOQTW1WRE4ktWtqZnQZfFN5voCwCt5pubnnNDKtCNQfR+9V+PBpCrXIk7CXd9vN5S9
         xgsEZKkzkBZbX8PZ5YUN8j52NLcIvIQ/t9/oeHdW2ZfwVEBY4MEFkQHEJzCyQVilHQRj
         cB+XGhCDfLg6CrH49sE6OEpY5hhaVw+r1oc9SQY5jR347gRIJ5Pjxwbqa47ra6a98UKG
         lOZdyIPvVLp7BBvSAN6Txk89svtN2/s60ZkvOQIHdYWo+qI2vUlhr+ckRRx63uPytlNL
         0jog==
X-Forwarded-Encrypted: i=1; AJvYcCUi1moXYY2qIalDDBh95mcTEvIjGYBPhQ6wL2Cj6DzBXw2O3mhdzkQisBFedOtTuHUVxbpfyGhZfwFRMamywSKGl+1gYkWVT2HA98zF
X-Gm-Message-State: AOJu0Yx8gVpWtf0gw93RtwGdg2yK2cvzqZjO0TRimNATBdKNaoNnrsg1
	Tu82Wmy0KGag4xLuNFZwCQAaBFKCiQwoyJZ1lS8i8pJo9CFfneUK7bOBGZiU8P9aJOQ/FuG1k19
	1DSXHcRuBpCjTWon46Gu4BOe/Iagao0ejAfxXdqSFangEPS04ndlcAM2pn9y3Vg==
X-Received: by 2002:a5d:6384:0:b0:341:bda1:f650 with SMTP id p4-20020a5d6384000000b00341bda1f650mr134273wru.15.1711657883633;
        Thu, 28 Mar 2024 13:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8JfplNS/6rEuW7imtdc4ZXn2rcPjLV0iMZLsUe2RfEaxJ/mCfK1k6cQevngu4j5A+L5c88g==
X-Received: by 2002:a5d:6384:0:b0:341:bda1:f650 with SMTP id p4-20020a5d6384000000b00341bda1f650mr134249wru.15.1711657883181;
        Thu, 28 Mar 2024 13:31:23 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id du9-20020a0560000d4900b00341bdd87fcasm2542365wrb.103.2024.03.28.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:31:22 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex
 Shi <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Barry Song
 <song.bao.hua@hisilicon.com>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
In-Reply-To: <ZgWhteHzLb8Jutp3@localhost.localdomain>
References: <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZgQULtxy0UnoXfGi@localhost.localdomain>
 <xhsmhttkrbvfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhr0fubgaf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZgWhteHzLb8Jutp3@localhost.localdomain>
Date: Thu, 28 Mar 2024 21:31:21 +0100
Message-ID: <xhsmhmsqiayjq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/03/24 17:58, Frederic Weisbecker wrote:
> Le Thu, Mar 28, 2024 at 03:08:08PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 27/03/24 15:28, Valentin Schneider wrote:
>> > On 27/03/24 13:42, Frederic Weisbecker wrote:
>> >> Le Tue, Mar 26, 2024 at 05:46:07PM +0100, Valentin Schneider a =C3=A9=
crit :
>> >>> > Then with that patch I ran TREE07, just some short iterations:
>> >>> >
>> >>> > tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07=
" --allcpus --bootargs "rcutorture.onoff_interval=3D200" --duration 2
>> >>> >
>> >>> > And the warning triggers very quickly. At least since v6.3 but may=
be since
>> >>> > earlier. Is this expected behaviour or am I right to assume that
>> >>> > for_each_domain()/sched_domain_span() shouldn't return an offline =
CPU?
>> >>> >
>> >>>=20
>> >>> I would very much assume an offline CPU shouldn't show up in a
>> >>> sched_domain_span().
>> >>>=20
>> >>> Now, on top of the above, there's one more thing worth noting:
>> >>>   cpu_up_down_serialize_trainwrecks()
>> >>>=20
>> >>> This just flushes the cpuset work, so after that the sched_domain to=
pology
>> >>> should be sane. However I see it's invoked at the tail end of _cpu_d=
own(),
>> >>> IOW /after/ takedown_cpu() has run, which sounds too late. The comme=
nts
>> >>> around this vs. lock ordering aren't very reassuring however, so I n=
eed to
>> >>> look into this more.
>> >>
>> >> Ouch...
>> >>
>> >>>=20
>> >>> Maybe as a "quick" test to see if this is the right culprit, you cou=
ld try
>> >>> that with CONFIG_CPUSET=3Dn? Because in that case the sched_domain u=
pdate is
>> >>> ran within sched_cpu_deactivate().
>> >>
>> >> I just tried and I fear that doesn't help. It still triggers even wit=
hout
>> >> cpusets :-s
>> >>
>> >
>> > What, you mean I can't always blame cgroups? What has the world come t=
o?
>> >
>> > That's interesting, it means the deferred work item isn't the (only)
>> > issue. I'll grab your test patch and try to reproduce on TREE07.
>> >
>>=20
>> Unfortunately I haven't been able to trigger your warning with ~20 runs =
of
>> TREE07 & CONFIG_CPUSETS=3Dn, however it does trigger reliably with
>> CONFIG_CPUSETS=3Dy, so I'm back to thinking the cpuset work is a likely
>> culprit...
>
> Funny, I just checked again and I can still reliably reproduce with:
>
> ./tools/testing/selftests/rcutorture/bin/kvm.sh --kconfig "CONFIG_CPUSETS=
=3Dn CONFIG_PROC_PID_CPUSET=3Dn" --configs "10*TREE07" --allcpus --bootargs=
 "rcutorture.onoff_interval=3D200" --duration 2
>
> I'm thinking there might be several culprits... ;-)

Hmm, frustrating that I can't seem to reproduce this...

Could you run this with CONFIG_SCHED_DEBUG=3Dy and sched_verbose on the
cmdline? And maybe tweak the warning to show which CPU we are scanning the
sched_domain of and which one we found to be offline in the span.


