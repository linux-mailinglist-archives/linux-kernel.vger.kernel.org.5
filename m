Return-Path: <linux-kernel+bounces-74887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362D85DF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F10628423B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D587C6E9;
	Wed, 21 Feb 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvh4Qw3D"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458D7BB1F;
	Wed, 21 Feb 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525518; cv=none; b=Chrk484GbU8JLq6l+UsVFESnEg+TJxa1/YMaaOdfzBmNx7fds/BrCKltJDMMzDGwrHEQ2CVf0NPQAO5TOrJNJrHU+mffn/0I3p+dRHmsxbURUV1ZGiYCvw2izHfeh60CwJ40+ZluVNznkQZzs5nuUgBoLriPGHImUyaBe/w4jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525518; c=relaxed/simple;
	bh=UVM0DRZ1oHezOdCtXDvvLtQjlYsIzZsQr3fBsdoISKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tml/Cx7Kxr9VnHx8wgPRZwoZpk+vz4S660mSegl6WbuijAw68Qe4v9exso5LId5Q7+W1em6yknkdYSQH+r2A8dfCCIzsGt8jya7IYYndoB9BClYRC+E8sgCRCowIWO0RrHSHiea5vmqLu3GG0tfh+QjiPM7jEBI/OKDWwrCdLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvh4Qw3D; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so5331145a12.1;
        Wed, 21 Feb 2024 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708525516; x=1709130316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCA1LRzpzSkzkscIXqCxM/LOuGsDIqBacOMOBHxNRPM=;
        b=Lvh4Qw3DvbARRwXVpygaaHLicz8jmM4PFLgA4KjYzIeErkXEs4Bp80kEcqWLwztUFx
         6qQ52ZW8V4lMqj30/7JBAsLaEnjjRjhcfOXfuS9JLlkQnb+EtzOwNQuyML2R7d6A93s/
         ZVEMwAmgVA6RgQ3WCSRUypRBnFxujLUc3+s28lX7Lzb5JVvp5/QMi9OSRHc914OgzPJb
         GIeLDQKSCHCIOBQ0sV4pD662VXLsScG40i3eAiG8Jsiu9t6YjSbaliRaqJlbJEleN1kp
         tXNXS/htxPZ9qVdkwU5Lv7312+t3GON4NOoF8NQdEXbXnNlrE6po/6HV8Sd9vgc+U9qq
         v9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525516; x=1709130316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCA1LRzpzSkzkscIXqCxM/LOuGsDIqBacOMOBHxNRPM=;
        b=R2kg3WUK7T9yZonm79dezrRO0Vg4owygM/gL9sohZUbwXGaRSJjfuGHcReVxIfM2C0
         fVJvbwntUMdUCy/D9eqnoi8G8G6zOYC0hFvmFEJ6kAqSrZigDJeOHuw+ziWOh+EIPSZi
         jTmoHshuNWkyP0DfFJoB15TO1nFLMAElZIIKBCTY3sIr9M/eyrn6rm46ei9TDZoI/GFX
         M4lYy9gbtiANrnzzjhgy28us9DkoskR7O84UB/S1msuLf1wje+v/hLUhX8qTT+p2e2zf
         7UNzRmLGloChVcCfh6iy0NNSssTzaub9dhTIoeSNSEWI6mDD6UtraGHwORkw94Cpbqo4
         EH8g==
X-Forwarded-Encrypted: i=1; AJvYcCX7Tb08B6mnfj4XfunlwR3EZ6Iyv1sA+2DvZHXVSC8lUq9m1PEQAgX97ioSHTYUcqWLgIB2uHxD7p6x54+l3JRgfxWqa4Q29MMbg+yFaJgPUJKezX1tPeb+550g3/gX1hagkIGQ
X-Gm-Message-State: AOJu0YxY3kLIShgNvKhwbKbFXEJ46dQ0W2s1JZtdp1RzcJ31tQkjzT7r
	fDuGZXpphcQFfbFhl6jrA0ENTbGjwo03PdLPndvi5utTrzl4O5krsxjQ/KxzK5NIfACJqk7F9a3
	vZAgcTC8EfOJHk1W0A1ytSC1f+l0=
X-Google-Smtp-Source: AGHT+IGFya7agp5XWmTngJI8TfZ+xY7NrVXGQtyLMJU55/2t2PsmFK2GT/ZR6116dVJEk24agBbHnlfaeZDEau/2KF0=
X-Received: by 2002:a17:90a:ae12:b0:298:ae3d:eb8c with SMTP id
 t18-20020a17090aae1200b00298ae3deb8cmr24420239pjq.22.1708525516507; Wed, 21
 Feb 2024 06:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
In-Reply-To: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 21 Feb 2024 15:25:03 +0100
Message-ID: <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
To: Ronald Warsow <rwarsow@gmx.de>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Works fine on my desktop with model name    : AMD Ryzen 5 5600 6-Core
Processor and Arch Linux

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 21 feb. 2024 kl 14:33 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi Greg
>
> *no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>
>

