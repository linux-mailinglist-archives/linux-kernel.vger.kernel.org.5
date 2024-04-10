Return-Path: <linux-kernel+bounces-138480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B989189F1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C0A281D09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015415B14A;
	Wed, 10 Apr 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggI7H0Ba"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2215530C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751861; cv=none; b=UdKIRArTqjX+Xecd5muLPVZ6iiqVb2OUaUaFI0F3CslD/vFjWVbg/s9gwR7QDuREq8hk0H8aORevJPtn8yDfTECZeaMzTZGEYqvggiU6wjpU0xthVRL8kMM5YEKynQsxt0VRsDMGKMXX/5uGDklsKwsLh47nIZNTkyclHfJ2Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751861; c=relaxed/simple;
	bh=UnmOqMZXlkkNhcT1d85UwBRUeAne0HW/X8tfs2LcQb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW5LomplDkX00AJNc7hKv9HE3mF6GybQn98LjBDoHG5CciD9IxO2mhcn5qqBDs8KNpmk1ekREKvDHRWCEOcl6/IvodT6qAkO57hhASD/I+VDcqlCXhZLCifsUXZnP75VxP4NL4anMIviruBNKl66FO4EUg9i9FCPwzJOzrNv/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggI7H0Ba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712751858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prnpMYvGmfBZVhuyy9WAFJxzoO03O3wrk1EmdwlswVQ=;
	b=ggI7H0BaSu8KAbGrZutxhpQsBcsgDIDgxGe/nyP0AqLOFaMd6vgDiPVq8BreKI/J0Y9laV
	8jnL8k7HkBIeQh1cQGWYijmPUEaHqrr+UFgz1xP8kQIPic23F24oXNkHjpSnT0gPjEsTUq
	xfwvnwb6S7okYSBhW2DZxW9S7lFOF7k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-j4-sejf3OEyI6FBQLNadfg-1; Wed, 10 Apr 2024 08:24:17 -0400
X-MC-Unique: j4-sejf3OEyI6FBQLNadfg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46bae02169so706113666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751856; x=1713356656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prnpMYvGmfBZVhuyy9WAFJxzoO03O3wrk1EmdwlswVQ=;
        b=bpLqxJsU400iu1Bd/wynt+S8cQlB59bXIMDKOwIW3u6+64TGDa28r+s3o8u3v4jcpq
         ODub/gkNIRRKY2oGUyyHhy4vIX/p+fwKqnHeiVGB2ePORGo+L54Ry4MpgQwy8zAaY8g0
         EwvCUlGaaHcZRsb0zk8qssm8tdEGuIkNou/wy9dzMPkozAHzL3ZcStIJv9S4UD2MMmm3
         22k6qeejq4qVLDPe+daFnlz60AmnBV9qhKPDsyDBBIGUGuHhj78bzwVAfPErqROsASL6
         7onkuSx8LYJOPJ9BKaHvpuHtFV2NZAo3vEwmtwLc5Ve+fVng0nUozsmHz+K5qguD1fAC
         O3GA==
X-Forwarded-Encrypted: i=1; AJvYcCUyH5wI8fpauIisaj6qSu9fZy+w5fP4lAV1YcPXN4HO6C7lOEeiM3Cy1d9leFZfNxQUm/B5ND1HL02Y0h+4c0X57C/7wBdCR6KoCjiA
X-Gm-Message-State: AOJu0YwWEWnp0g9mKS0tOeM7Ee5fh9xD5wRZ2uPed+TgeA34TfpS9SkW
	soCVt81s7LKh2LB6OLuZtnlI14MNRSEmyGoPoSOOb8RBkm8/T2NGHXd726Ln46Mz5cdijQHSKQT
	1jHjYsnhogo0+qk3CiwN2qcYhfQvcTPokgF+U1BDzkgxluZg7ouRzwh5rQadPAg==
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr2092179ejq.19.1712751856428;
        Wed, 10 Apr 2024 05:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+NCPZWeCOkmRpbzUy9LzzQApNIuXHHEWpmzVLAMZf1BHGFYXbO6mOeHd02i/UMhSes9ABoA==
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr2092152ejq.19.1712751856107;
        Wed, 10 Apr 2024 05:24:16 -0700 (PDT)
Received: from [192.168.0.182] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709061f1300b00a4e03823107sm6925730ejj.210.2024.04.10.05.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:24:15 -0700 (PDT)
Message-ID: <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
Date: Wed, 10 Apr 2024 14:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Content-Language: en-US, pt-BR, it-IT
To: Peter Zijlstra <peterz@infradead.org>,
 Atul Kumar Pant <quic_atulpant@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net>
 <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
 <20240410114609.GA40213@noisy.programming.kicks-ass.net>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240410114609.GA40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 13:46, Peter Zijlstra wrote:
> Also, we'll be replacing the throttling code with DL servers 'soonish'
> at which point all this will stop working anyway, since DL will preempt
> anything FIFO, including your idle injection crud.

+1

also, given that the code spins with preempt disabled, with dl server it could
even become a non-rt thread...

FIFO RUNNING
	DL_SERVER activates
		their loop
			disables preemption()
			run()
			enable preemption()
	DL_SERVE throttled
FIFO BACK

So, there will be no need for this busy loop to be RT.

Anyways, it breaks RT and DL if it keeps running for too long... It can
also cause complaints like RCU stalls and loong wait on locks, e.g., on
kworkers...

-- Daniel






