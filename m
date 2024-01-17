Return-Path: <linux-kernel+bounces-29175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE8830A12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E8A2878F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3B21A19;
	Wed, 17 Jan 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ0ZMg3W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A521A15
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506834; cv=none; b=VMf8OyJK/lAKrhywPTlKWn8uNa6DG6y11b/rJyX+mmII/yuZ3gda/LciqbXIzefjlemsRXxBkOIC6YkaiBeuGQlCMysdGrLGvQ8dXr/TECPU98r7S53qPRkKm/njvY6sDK6qC9Ac0hfO01zlKiI4ppeuUUwcqT2iSW982HWI6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506834; c=relaxed/simple;
	bh=Fh9cIeA0K8/SqNd3wNFEzsVCf23bj/fib93cJg6HPCk=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=quOXmJn2DONPsZilEubUFRgQx1+BUdjGqjsq7ET52kUAY5Wxtwr0fc0kSMyhUI4g9F6hHlMudDy4Tqlshi3z1C7mK7lbqnynEktTvsifLexyoIh5Mdl8kwotRfWDl5q28RYstd9Aju+hdna1A3ZrcqOyI3oY4+zSrFtdnn0U3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ0ZMg3W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705506831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eWdv9dNBbaT5qKvD8ncdQgKzFw85DhSf3YVCG7hTeak=;
	b=KJ0ZMg3W0fh5G63zL0VpqQzdjAqUvBBlmQIjgH/gQttrDdh1/1xtzFpXgAztllg5j3Kzuw
	56SVbPSkbRENqwm3LcuLOrhoCZfoXJdNaHbGOxXj/6IJX/ilWSh4KgcYJ8+3L5xaDvyymp
	mbD1Z62bZ4PfqE/etZS0Bi8AE+UKg14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-gyfprHNTNUKynkHIbhmBmA-1; Wed, 17 Jan 2024 10:53:50 -0500
X-MC-Unique: gyfprHNTNUKynkHIbhmBmA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337c530949aso372453f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506826; x=1706111626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWdv9dNBbaT5qKvD8ncdQgKzFw85DhSf3YVCG7hTeak=;
        b=O9VVaQwcdl5o+Cb7yGB6sdRDCWvLKzxxWVyvWn5NN7/ectcw9H9UtWtCQ2Dny+68cn
         kg1LnH5IDrf3v4qnK0QCWJHVrddg6glaG8KKoyCfK409kamy/LBf60UzS8RKR+VCqlkz
         /mJVHE2fY51BPRW42uZwu8tb52B92/eiHNGT9yyDDw47bW50KwvwRaxj/0l8vixUl5b6
         CAjPs9+Gsi8ZNPqDcIHHnPJLE2kaYbGdrermbJfUdJKuKYvZPxi36vgJ1gGGi2rLKDb8
         BmirIyp/NKAhKrJqLb6fnIvW12lRselFufcl6xsyPH1rkLOCxoxvoJO98H0r18j4pYP2
         Ulwg==
X-Gm-Message-State: AOJu0YzSmuKmWQO5OeYql46dL0FlIfquMoyVYt7H60CW7sZi+e0kXPKa
	ChJDEqOWhS3TjyhgYJ+rWKzy7xU1qTWhwk9wAfhTmyBGoQKkLNrlDkobK3KqgkYOdtckzfnJ3zD
	IVr2t5MXyZGpwYXmWxwApSeN51OmvIyvI
X-Received: by 2002:a5d:474a:0:b0:337:bded:898a with SMTP id o10-20020a5d474a000000b00337bded898amr1491735wrs.0.1705506826089;
        Wed, 17 Jan 2024 07:53:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw/TMpENFJktEGUmBYWHI0nKFlOMGzkvOulo4KamHQE+q4nDl23K7bo2QXocGrMudgonNlhQ==
X-Received: by 2002:a5d:474a:0:b0:337:bded:898a with SMTP id o10-20020a5d474a000000b00337bded898amr1491731wrs.0.1705506825718;
        Wed, 17 Jan 2024 07:53:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:b700:5a87:3a7a:c28d:2cff? (p200300cbc70bb7005a873a7ac28d2cff.dip0.t-ipconnect.de. [2003:cb:c70b:b700:5a87:3a7a:c28d:2cff])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d5341000000b003378e67fd2asm1962396wrv.86.2024.01.17.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:53:45 -0800 (PST)
Message-ID: <0998c7cc-8480-4e4e-8c29-4e9718354cc3@redhat.com>
Date: Wed, 17 Jan 2024 16:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Debug: mm: meminfo reports 222GiB of AnonPages but sum of RSS in
 ps is barely 400MiB
Content-Language: en-US
To: Karim Manaouil <kmanaouil.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <CA+uifjNcZbb6=9-o9_cWCMyXRFZPHhyvWS2mys-YhfP9gaJ75w@mail.gmail.com>
 <97843013-7e06-449c-8418-3890657b2e26@redhat.com>
 <CA+uifjNw0W=EaUHbhq_CN8uOj0H_Yfu9JKSL1=EH6dnYkN3-ng@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+uifjNw0W=EaUHbhq_CN8uOj0H_Yfu9JKSL1=EH6dnYkN3-ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.01.24 16:50, Karim Manaouil wrote:
> On Wed, Jan 17, 2024 at 2:15 PM David Hildenbrand <david@redhat.com> wrote:
> 
>> Maybe we have something call mmget(mm) but never mmput(mm)? Are you
>> running any OOT drivers or "special" hw?
> 
> That's exactly the reason! I was writing some code to count the number
> of empty page tables in the system
> at any given point in time. I called get_task_mm(), but I forgot to
> call mmput() after that, and thus
> the memory was never released.

If you want to work on reclaiming empty page tables, please talk to me :D

-- 
Cheers,

David / dhildenb


