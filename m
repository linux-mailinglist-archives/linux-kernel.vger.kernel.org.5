Return-Path: <linux-kernel+bounces-59154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD384F231
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBC21F23AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63466B56;
	Fri,  9 Feb 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkUW9vZN"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA18664CB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470538; cv=none; b=YYTD3lEVMWOfr7XOA4dWnOa/kzBxbvZPB5tqrvZ8d21T8eDNMVswdg0zRuF2vGFNR3tLzQ5yXRvr7tUNsjAMCHC+e9jb+iRY5U/x1kNwuL7U3rR/AArjeQdC6Y8wNB0RvIKw+PnbnNYtZ0KvCcWCEv3bzgElSlYs0ZXRBQgsjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470538; c=relaxed/simple;
	bh=e1KWj7ChASzrRiDmZPwMOrmy0d6A+CytRDz/mDR6qWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Emd6FzGfoN0SCnYEIWjfupcmkIJc7ZxU7pT6+oMKSFQkUGejbFc1z9kWjkLNEl8fnkwY7AtqoWjsJ/MlTNtohfcZhZYneFh27WhxVTUYTif4JZN8oxWYnUPt/HL2IeVF6J5UnABAYFe0dLogi4NSxOJJoG19ltzxtEiKfs9lXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkUW9vZN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bda4bd14e2so480904b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 01:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707470536; x=1708075336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWHq1zXQ8MmhzUO08ghr2JTcELiMF8c3pam8DLxJkkk=;
        b=TkUW9vZN7eNRo/AwS5eOWqSqE0EbCTENMwku4FNoebw6hBCkFfNC6hjk9zlVZhfMA3
         M0y7NslxfQq7h4qFVTCubLYrChxWU4r0Nj1h6ZyQRi2/vuN1oxEf5Ha393lCcnCbFN1i
         ssiMzshX0YT7DUJSkjvRA6z3TxbwyZVy9TO1iutoDyzpcGppbXcLr2h+zlNnt9IHcLy3
         3vM8S9YBIylUfZArI4NbZBp/irpskhz73zMVtRM/wIzhIA5nDFTQZ32q8hiagL7lOX/E
         NhfODvActTq81kEu0Bj47ZeYSlfjgQ1E1bMYtKNQyapBkaA8GgnH6mHkwlmbhZV6JLuT
         HkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707470536; x=1708075336;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWHq1zXQ8MmhzUO08ghr2JTcELiMF8c3pam8DLxJkkk=;
        b=w/xLjj5tzTuCXgjQbvZuRvoU1foVUU3HX8t+GOsbjYmXF7/P+6ky3hIDxzac1RUQ+C
         q+4cs8uqLpJEo0myHMGc3VRN/+OVJfRnYhreaREupZxDHK4R952N7Sn0Z/qhpF30Us1U
         SVEfgaLxtS1HSmnwoE5FjTxM1lLY0t2iskchKgkT40xkzqwY8J9YFw1koDgpKItRto4d
         oP/H+Xj9C/H73xlKN6F6mAQc9gJ5jYlAWk0rhvzoTEHkR/w+EoYxF1y+Sy9nM9S6dgab
         yb9XbOtyWdfe+VPn39zhwZhE6hY+YfnF9JbpgpZGd3t6QcNRykqE+2JEVRN2IvUrin0T
         yNNA==
X-Forwarded-Encrypted: i=1; AJvYcCVp8UOzzD+0CioEX2uy6S+PTdbkOumURmjqHLgk+KeQSnOv0GPc4f8ajt55+kEEUbVSwV9HcR/EQ6bghp9usgj3M8hwdS6OZN5OqxAg
X-Gm-Message-State: AOJu0YzjHwDwdWbIPC7St7c4xi2seqzMYBChEtxtwaW1j1q4rimgJF+Y
	Us2GgY7NP7UeUUg5BXcOOmOcK+IWpTO6QklCzNGyZ2yTMxfZ2hoGkZD7BpDol1M=
X-Google-Smtp-Source: AGHT+IHwi3tEYCJ7uk67V4MsxL34IR3runYuZPc1NFV4wH8CNIJkeJqE/9aIJOdDKRSiIf31XL1eFg==
X-Received: by 2002:a05:6808:1211:b0:3be:5d77:cfa7 with SMTP id a17-20020a056808121100b003be5d77cfa7mr1446843oil.1.1707470536371;
        Fri, 09 Feb 2024 01:22:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLFule9pZiW1RhWdAS93L9OMCNavd107i/l+lViJTyj4wMiOuIgH+dn5aAyDtyonI5xxBJ+wqTASb+j2iGfH8HQXk5Ioi9yurnt0Xx
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w3-20020a63fb43000000b005d880b41598sm1254924pgj.94.2024.02.09.01.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 01:22:15 -0800 (PST)
Message-ID: <81f2df0b-0780-458c-b432-5d61b78e8157@gmail.com>
Date: Fri, 9 Feb 2024 16:22:12 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: add boot param to disable stack dump on panic
Content-Language: en-US
To: Nir Lichtman <nir@lichtman.org>, linux-kernel@vger.kernel.org
References: <20240206213902.GA1490631@lichtman.org>
 <ZcLmjrBxE2BA_hLG@archie.me> <20240208081425.GA1511946@lichtman.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20240208081425.GA1511946@lichtman.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 15:14, Nir Lichtman wrote:
> In a lot of cases when there is a kernel panic it obscures on the display the previous problem that caused it and the main
> reason is that the call stack prints a lot of lines on the display - and there is no way to scroll back up.
> What led me to make this patch is that I was working on running the kernel on my old computer and when I passed root=/dev/sda
> to the kernel there was a panic and it could not start init, but since the call stack took almost all the space on the screen,
> I couldn't see the available partitions the kernel does detects.
> 
> After this patch, I could just pass in the new boot parameter I added here and then it would not print the call stack,
> and I saw the line in which the kernel prints the available partitions.
> 

Please don't top-post; reply inline with appropriate context instead.

Thanks for the explanation. Now please send v2 with appropriate maintainers
and lists Cc'ed (use scripts/get_maintainer.pl to find ones). Also read
Documentation/process/submitting-patches.rst before sending.

Ciao!

-- 
An old man doll... just what I always wanted! - Clara


