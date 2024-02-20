Return-Path: <linux-kernel+bounces-73458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5185C2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A01C2215A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46BB78682;
	Tue, 20 Feb 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUtbcg6I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340B78674
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450714; cv=none; b=dLdhFHLTEnQYWgmbMXByTc6sZATmTGS8Jv5Khvz1Xoyc07iv2a2fnfHzkO+9OXYyu/h+Yt1X9Mwcb4cNrqjkJQH1gIrMDy4lzyBPqhLJThb4n6ti6pkJJvJPjG8W235uDm0++YuutpbBcqT4Ms4fwV2ZyNUF/HtZqnML52Tk+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450714; c=relaxed/simple;
	bh=sWPQxpJ5JhFTeEb001dgjhbqbJO6mGNTN4LhH7v9mso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqU/D0JB5F6NoU+mZcGn8tcFbaFj44m5scw5ZwCalGCJYjhOkgENEZ5BY1N6eAAB1xtWK1ozOlNIakqlVsrIOA7Qmolsjzs6BPfST4nZ4qJbghGvBSLPE3VFNmkBB3T+sPEjIEZhpj7rkcXmvGigIwQUSr/g40hpiWdyVHTqezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUtbcg6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
	b=CUtbcg6I7RQiiJQl4ovHoybHixIkZ09p8DF65nRVNrpzwwD12p2/6/Xmn9hs1FPB3oeTTQ
	18ewXrAWan/aLIyzqqT7l/irXQqMZSbXF/35wYiot7m6DGWOjCmx3ISKhKo22jMBXIwwMh
	QmAQag6qb0A+6+OW22qDFG6cLEf6m1k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-NlnKt7PDOla8uxhmcMUxsg-1; Tue, 20 Feb 2024 12:38:30 -0500
X-MC-Unique: NlnKt7PDOla8uxhmcMUxsg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6800aa45af1so78043506d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450709; x=1709055509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
        b=evB2wOe5/Cx9k8xCRueOdGiSrQKZXn35YAcPuwV9u7W72fJqX5rrK9Ifs7aMrnS5oY
         cjSg5vwDYmcyocbXQr5f2qlmYN8ErbNXpYSf719G3W9+L2Vcc11kIr3V5Y+tqWtCT4aj
         mU9xUsOk0t6rrvFJBKQyyC/sPvu0JexDv+lg3QvUl45++68g0OPencc0ecY6sRLlkty4
         8unInT69yDX6GcIr2q0y05aQHEt1F+b4GlMykfV/1BUsLBkSizo1KfsVqAN05b/Z7BQa
         CVo2hqNawzaTUbJEkeHW7jNt1jlVv6LYsCttBUfFJ9j9FCJlzepVR1E34dF+Z01pXe8q
         tkPA==
X-Forwarded-Encrypted: i=1; AJvYcCXSfCR5tqAhLVrdb1ku3SG5ttv+TAsV337z4MAsoW+uUSYAIMrZLS4ySQXJv90eUISm+QsDO8dnrbnb4N6Xn+SMBsQwGFjG465yaSDD
X-Gm-Message-State: AOJu0YytooOCit8lL3Vkm1PCC3KSbV1c6z/g24FQIxx6oZkrIdRK+YK1
	p1HaA/VcpE8k/mHhJ92fv3bRFKhTGW/45XGXrch8eLlcQahP/0jHIUZ5HcADWzq6Itgri0rTtil
	tGsfaAGdhMpRg7I66xJ0idYWDWP6rqv42ry7pswUe3XvbIR+KhY2s5dfpWBH2vA==
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978330qvb.49.1708450709587;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPEiisDHYagQqfgdyTO0C+ZU+atUpAKG/0i+pMgPq3cIPMfW9JW9MVlTXN5kfFRL0jV660rA==
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978308qvb.49.1708450709254;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id nc9-20020a0562142dc900b0068f58a8e09csm3498212qvb.108.2024.02.20.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:38:28 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bigeasy@linutronix.de, davem@davemloft.net, dccp@vger.kernel.org,
 dsahern@kernel.org, edumazet@google.com, juri.lelli@redhat.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, mleitner@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, tglozar@redhat.com,
 tglx@linutronix.de, kuniyu@amazon.com
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <20240219185537.13666-1-kuniyu@amazon.com>
References: <20240219095729.2339914-2-vschneid@redhat.com>
 <20240219185537.13666-1-kuniyu@amazon.com>
Date: Tue, 20 Feb 2024 18:38:25 +0100
Message-ID: <xhsmhmsrvf33i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/02/24 10:55, Kuniyuki Iwashima wrote:
> From: Valentin Schneider <vschneid@redhat.com>
>> @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
>>  		if (state == DCCP_TIME_WAIT)
>>  			timeo = DCCP_TIMEWAIT_LEN;
>>  
>> -		/* tw_timer is pinned, so we need to make sure BH are disabled
>> -		 * in following section, otherwise timer handler could run before
>> -		 * we complete the initialization.
>> -		 */
>> -		local_bh_disable();
>> -		inet_twsk_schedule(tw, timeo);
>> -		/* Linkage updates.
>> -		 * Note that access to tw after this point is illegal.
>> -		 */
>> +	       local_bh_disable();
>
> This line seems not correctly indented, same for TCP change.
>
>
>
>> +
>> +		// Linkage updates
>>  		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
>> +		inet_twsk_schedule(tw, timeo);
>> +		// Access to tw after this point is illegal.
>
> Also please use /**/ style for these comments, same for TCP too.
>

Will do, thanks!


