Return-Path: <linux-kernel+bounces-127875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2B89521D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F05C1C2288B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24092664AB;
	Tue,  2 Apr 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyOFvxxJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775569945
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058220; cv=none; b=jvg4HASP8R5lR7V0MoNRInUrswjJJyDT2pjyyyQ0kByV8LWAx2ZvY+bIW+Lt9RxFBUCJPzfSjCWDzYA5tGf3obYjNXKet3xJWE//tqcFXN4H+LP2T+EEWeXj2o3kWGbG3I/+qPsZzZLNoVeeNa7Z0hF7BAun5ukVg/99lKFiWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058220; c=relaxed/simple;
	bh=iMkAhuUU/al48UoHiTw/+mu5bf4d6o5qpZtlV4r74p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvZBYe97CL9nHgLU0TTApITjRu1aD77qYrL+9zhhVXHacqJS7SM60MwiFt1PZMHEYoi+d6MLICDV+jgI/YNikvvAOWxS0LO1Wy6OKiC2XCqEcyOErhzxPbw+iUFqiVNLYsLS1Yp7MG0U/mpYM3/2cZomSpadN1mbPUgdg7x3MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyOFvxxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712058217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXSimKNEDF9TDHj2e7uB69oP261aG/+4o76R5CJVdOc=;
	b=fyOFvxxJHsE5yWqDj6PXLFekjpE2zrFcbnOEjnGicr7gJNXfkDP9zv9ymuQ6v/FoktuM/V
	2v/EaP/CGlaAZevdAPTWnbxcUsfr8W1F5+Ql9xgMVn8Ew9kxcnjU4pbRDeQAZ5OMQijV9G
	8hln6wVqtQH70VcimawFC2WjUAmIVF8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-66v79HtHPsWscHctlbhCbQ-1; Tue, 02 Apr 2024 07:43:35 -0400
X-MC-Unique: 66v79HtHPsWscHctlbhCbQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56c25ebc347so1680994a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712058214; x=1712663014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXSimKNEDF9TDHj2e7uB69oP261aG/+4o76R5CJVdOc=;
        b=ccLpSvOeFKJCu1ilK7qHiwc4sSdIf7P607FozgcNxLCQB5j7Pv+V9/Af2xvZadSzEU
         Po2DiPzV5fzHr9FZhc0VcdgQ4xRPKLcA2PAVtLwLj+bR3GjSS3KgKpGbzcj83Uo/1zjW
         w1OXvSIWZcvVGkM5UrBMSd0m9pDBPuOqMDSwCQ9wBXAfhXB7d3Un+ZzyFxRLyLViJFwH
         2pe2d668nFUEGNX/VASEqV6+4OfvoaDQ5iG7eVBkrgl4NMZqFOTLUKN4cC3WqSgUIzTJ
         WWZl6JVfLg+lOsyTIQvxjP/kJAReVWTyyBxSqsXMB7RMA0xgE46rLj6Bk4Z18pXX8bNI
         ZhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBJDKJcaazGGD3i/U5MgRNtL8wPcdseTkflayKHMvHDD3wbBluk77oamqdFfoj04rYiJY56XQc+wXnMYXGiTl5O5zI6SH28QgxeiJN
X-Gm-Message-State: AOJu0Yy5wx5cwj9zy9BJDjCSTh3+zOFxHHg9qd7D8+OMlTet5ZYk4efe
	AsvgCTbeKUDOKJRQUdgIZ/WPuzhhlRPlaBsZgZ+ObHBzfEptqAjtg0rWUSapQmRXii7JKurS06w
	3/XFFMxKyqa8GHOzuLLqVuv5jci4Y/g2rHMnEiSTMVHlzl8WG9ZGGUI4MrfdQ8A==
X-Received: by 2002:a50:cd02:0:b0:56d:c721:d0b2 with SMTP id z2-20020a50cd02000000b0056dc721d0b2mr6216169edi.33.1712058214678;
        Tue, 02 Apr 2024 04:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL+DiNQX4odVVBWGVTTJDWVnJ/DTH5CCQEceUrk2SSaDUrgeEFnbBlJOVVZUallwSdqjNguA==
X-Received: by 2002:a50:cd02:0:b0:56d:c721:d0b2 with SMTP id z2-20020a50cd02000000b0056dc721d0b2mr6216154edi.33.1712058214422;
        Tue, 02 Apr 2024 04:43:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0056c443ce781sm6662979edo.85.2024.04.02.04.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:43:34 -0700 (PDT)
Message-ID: <c5ee5eec-b00e-41b3-bbef-6f0d58d70d66@redhat.com>
Date: Tue, 2 Apr 2024 13:43:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading
 report descriptor
Content-Language: en-US, nl
To: Kenny Levinsen <kl@kl.wtf>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240331182440.14477-1-kl@kl.wtf>
 <391c60a4-b86f-48e4-ba64-abdcb79d71ef@redhat.com>
 <cae66cad-e49a-4fa7-83cc-70aaf3346419@kl.wtf>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cae66cad-e49a-4fa7-83cc-70aaf3346419@kl.wtf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/2/24 1:30 PM, Kenny Levinsen wrote:
> On 4/2/24 1:06 PM, Hans de Goede wrote:
>> One small remark comment below. In the hope of getting this merged
>> soon I'll prepare a v3 addressing this myself (keeping you as the author).
> 
> 
> A-OK from my side, the abort_reset label is indeed redundant now.
> 
> (The split between start and finish is also technically redundant when we always finish after start, but I wanted to keep the change minimal.)

Right actually for undoing the moving of the finish-reset
you could also have done a straight forward revert:

git revert af93a167eda9

My v3 is pretty close to this, but not exactly a full revert
since I kept your minimal approach.

Undoing the split however does not cleanly revert.

Regards,

Hans



