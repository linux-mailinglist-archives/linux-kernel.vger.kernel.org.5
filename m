Return-Path: <linux-kernel+bounces-84451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E912886A6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68A6287540
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A31CF81;
	Wed, 28 Feb 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W7k6hiFy"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6211CD0F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088666; cv=none; b=WeZ7n4i9Vn5gOWZXTFC4UPgjyWbuYce9/kPzC/z/keh0rVsZfBOJ6JQPUjIuZYWkdKV7LxkUhfh+BcRrEHb0iN7cp4t0m7d+vPVsM84GouXsa8/G0Mqz26Dys8MaPxwZMrEBX17zJ3niS2i8umyiLuZodjGiuguimIJhLwRx59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088666; c=relaxed/simple;
	bh=kx5LCqUuIYQ9KdpDTmjjLIzHshpz1YkwrkM7+Lzgshw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQQXuYdJcgqKjCnW7b1fa+H4fhTsmvmbDQ8uvOF+OzZHq6aVsDJq9Vg7mZDljkHJW68uGJjjq+JjdMDtNrqoOhwvPMm4ThI5P7B/BhtjJyNjUVtiJM44VPRLdDz98L4opUqUC8CthtRXIidqyNWMsU2rcKBUYn0xCXucS/sgbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W7k6hiFy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso4005143b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088664; x=1709693464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4FqA67RdXu7Wc6aPbe8nrEQlAnfIV6tiLcrDtl1Sb0=;
        b=W7k6hiFyP9m5jeUSqCmCA0MhzX5pqdl3NIQOItCUUnFZILnc/ue4aD7Fb4GgHY9heD
         aBMrMoAOVzRKzZFfmoH0TgGwUJESo+F6Id3n5juOSWmIXe0FixJT5QFexF3P3/SCnFR9
         pYbYJlQasYzA35c0/5cx/70jjokx97XbfinrUwGyw5co6tgZo33pzoLhZoNt/6i0wXGf
         lEhaQNVVn8KcrPKvq1tYRaqm2N6RimrMciikBSI6QEiTXlAzUXsn9j70sO8vLF2xd36Q
         JLqb1WxC2oadUAA7Dz+OZWCwNMETCQNJLPcJ670pgY0FL/LBXMwvl5KfF9rWBqqcDQPT
         P67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088664; x=1709693464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4FqA67RdXu7Wc6aPbe8nrEQlAnfIV6tiLcrDtl1Sb0=;
        b=Zuf2Ej5EJ9IFItW6JJyQiwvAFCcVMWYCExNnaZrZzEt6LTAV3+MH/cZxd8h0kXFP8/
         8L++OyqOpU0HDQixPLBAKK5oIfIz3rNDMbIwcJu0JpWS45Q6+LaB0sKYFDjKDWIGAKPz
         mSTap198T1FcbW5WUOdIlpSotPIBNhGdeeyaaS9bUtk2/OBWI4Qdoq4aU5nYDiJkeZ42
         tpXhReY85EHrqMK6UThgey1eQHQb6qv8E7L8xV+3EfOvFmjDbZXYs9GY9oPn9UhB/wLW
         qZHIUOPu3KZf70tULDAqJ6X4cH4PvshQAB8WCASVJgir8R9Nf62+8LTK22Yd2wByNUpH
         TVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtcbM05wVZBI8x3FJVzpPw7ehhLApCFW3x4DQHlNjsHaXPTOISsF5zfFVRBCiQ6TUrL4DRvy/yTs6cdP/HK9S1ECItxwUwVhTfZxkD
X-Gm-Message-State: AOJu0YyvbjKwUqodTcJ6eni1ZJzBbYE5rpAIZ04rSeGCeSOZTJ95Wx2b
	Dah9SzZCi3jGZtR22imOA/LgjUuct7WPICQdibKwDoa2Mrpql96YfQTumZRM0Ww=
X-Google-Smtp-Source: AGHT+IGeReZ3Y5NxIZlAaM8Enqxn/OFrYcimk/GW8M9PDaThxvj9F6RTHN7tdifb5hp9OSU+TOS9Wg==
X-Received: by 2002:a05:6a20:f29:b0:19f:f059:c190 with SMTP id fl41-20020a056a200f2900b0019ff059c190mr3572652pzb.24.1709088664240;
        Tue, 27 Feb 2024 18:51:04 -0800 (PST)
Received: from ?IPV6:fdbd:ff1:ce00:1d7c:876:e31b:5d3a:49d6? ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id j18-20020a63e752000000b005e17cad83absm6521340pgk.74.2024.02.27.18.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 18:51:03 -0800 (PST)
Message-ID: <72b3f614-aeef-473f-9496-6a5ed81916a4@bytedance.com>
Date: Wed, 28 Feb 2024 10:50:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 0/3] Support intra-function call validation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 alexandre.chartre@oracle.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240226094925.95835-1-qirui.001@bytedance.com>
 <f516eb83-c393-af67-803f-4cf664865cf8@bytedance.com>
 <20240226172843.52zidtcasjw4wbmh@treble>
From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20240226172843.52zidtcasjw4wbmh@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I tested the mainline kernel v6.8-rc5 without this problem, as I said before, this problem only occurs in 5.4 LTS, to be precise, it can occur from v5.4.217, with CONFIG_RETPOLINE and CONFIG_LIVEPATCH enabled

BTW: The patch for V2 version has been sent out. We can discuss based on that. Thank you!
https://lore.kernel.org/stable/20240228024535.79980-1-qirui.001@bytedance.com/T/#t

On 2/27/24 1:28 AM, Josh Poimboeuf wrote:
> On Mon, Feb 26, 2024 at 07:33:53PM +0800, qirui wrote:
>> This issue only occurs in 5.4 LTS versions after LTS 5.4.250
>> (inclusive), and this patchset is based on commit
>> 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269)
> 
> Does the bug also exist in mainline?  If not, why?
> 

