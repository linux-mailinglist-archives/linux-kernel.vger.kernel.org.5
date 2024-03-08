Return-Path: <linux-kernel+bounces-97319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72718768BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B72CB22448
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E435175BE;
	Fri,  8 Mar 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPv69Igo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB479D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916317; cv=none; b=SNR6Z92/KB0x4XSjd5VWLIYmyIimMcOEqQ2trs6jsjJ/BD0yuDp6PACEpCzKpePWgpyYXMSPxLeuCc8SpkHQvg9v4YAF8uDPQn0vcrLJj1gnAJkCLM21JFbI6t+fj2tFELTuyCorYjelsJ74iNwor9d0aw6yk1Cm1CZwc2kwooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916317; c=relaxed/simple;
	bh=nN+2s17bGMEvoQuaiKBlF3P0GJo2KMa8vWaEHh8JXO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eli8N0+dv0BFyH9j4jLY/QmEf5i2GwZDXKO7Z12pFqo30OvR9I+oDnF5ldbVrGxcbaXT3ablEIopZj3Rj2ZoO2yKYGsCWSphd0P5BNweAtTsb+znyR0A/jvA0zGy+Hdu0Kb6PoVp2tkVFk7jUgE/WJ6sYHytvZxlINK7GecAfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPv69Igo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709916314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNxpcJwkq+8jphHfIqHRAzoVt7usXLxm4Lf9RfDpJUs=;
	b=gPv69IgoYgQd4iLgLtTDi0GaQPu0fH3znAL5vaIzvGFMwWEJ4WdZC1caBj6Ea2fhUi3Bh5
	8oTMtbunOpL6NVYZ+LkcPnEmKz6lC07keRDLhw+CCs/tL2/oeJO5Tbys+j3OGyefIL7hIQ
	MCHVmbEBiFueJ0u59cgRMlwFxrpUdBw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-GdfhrcdDNE-KRJeQN7KCAA-1; Fri, 08 Mar 2024 11:45:12 -0500
X-MC-Unique: GdfhrcdDNE-KRJeQN7KCAA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5133f5243d7so1169490e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916311; x=1710521111;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNxpcJwkq+8jphHfIqHRAzoVt7usXLxm4Lf9RfDpJUs=;
        b=SJAxjU66n7PWDE/Z7pdBdRljsMtgrZD48iXX+vJaXwXmEt/2Pnh3Lj/F1jwXEMeMCH
         C4KaE18F/NKKCZK0NVgm7chv00kSfnD6kltVoRmlAYfKPB5jqZiUDUnkHJRqQXeddSxV
         3n5Vxxp3j0HKUO7oL8bsZBsdEDVf8NbF1pl/ZilKl3s2l8NZgJ4oqYLNrPdRGC5tprJu
         AmoKI9ANfjWAWQM7y/ZwCHwR696uLLhJnyA2yAWGcy/BP09uJCHFvS6q4MADeB++5QBi
         +rF+dqBJuTcLtQ+iXUXvdfQsLCQ01trj5QpfvuHvyxBmegSDhltsyVNIUjmnNLHI5kBl
         f72Q==
X-Gm-Message-State: AOJu0YxvWT/9RcXKS+28/60ggmpEbGQUkE9teB3Mf/pckPaeOW+1Rsng
	v5xzDOigMJLixm/6ZchMshUUdysiEOtEhvPozq5cZUUiRNHva/X/9nC1SxSM1NImZVIZaLXY/dR
	Czp8h+ThRJVmHMlUbz0TdvKHpDw3g58ZqNA1ygU6U8TFSO8DWZDY3nVubDXsVAA==
X-Received: by 2002:ac2:4e09:0:b0:513:4495:7ccc with SMTP id e9-20020ac24e09000000b0051344957cccmr5153330lfr.16.1709916311447;
        Fri, 08 Mar 2024 08:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuMaDvMuP9bC63TihxBtU0mVkpALAy/kxQHFSm2kG5DzvfWZRPa2G9pivSWf7w593uOAnMvg==
X-Received: by 2002:ac2:4e09:0:b0:513:4495:7ccc with SMTP id e9-20020ac24e09000000b0051344957cccmr5153312lfr.16.1709916311104;
        Fri, 08 Mar 2024 08:45:11 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b004131b2f3958sm1722950wmq.13.2024.03.08.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:45:10 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar
 <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/9] sched/balancing: Update run_rebalance_domains()
 comments
In-Reply-To: <CAKfTPtAwh-khpNw-=oku3VU8xR6qVpoL2hrzEF6u1AZ7WQ+3Cw@mail.gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-7-mingo@kernel.org>
 <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtCNnTVFdf85sRdJxPhdNZxc8qKcnHL3sznjg-KBVn8Bew@mail.gmail.com>
 <ZerlUU4kAv580rLh@gmail.com>
 <CAKfTPtAwh-khpNw-=oku3VU8xR6qVpoL2hrzEF6u1AZ7WQ+3Cw@mail.gmail.com>
Date: Fri, 08 Mar 2024 17:45:09 +0100
Message-ID: <xhsmhy1asd65m.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 08/03/24 12:57, Vincent Guittot wrote:
> On Fri, 8 Mar 2024 at 11:15, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> Okay - I updated it to:
>>
>>   /*
>>    * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
>>    *
>>    * - directly from the local scheduler_tick() for periodic load balancing
>>    *
>>    * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
>>    *   through the SMP cross-call nohz_csd_func()
>>    */
>>   static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>>
>> Does this work with everyone?
>
> yes looks good for me
>

Ditto!


