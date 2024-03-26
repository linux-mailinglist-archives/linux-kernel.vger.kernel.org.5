Return-Path: <linux-kernel+bounces-119563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4388CA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AF81C66243
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7831CD2D;
	Tue, 26 Mar 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1Naru1UQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93301C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473165; cv=none; b=XrNVmiBpbu8Lz7uyuIkcv9ng1OFQhfxTBC335i2XsYUE1I8uQzb6JW1sUAKg7pNrgzzJY8+H+9QaYipCFAIHA637/xgt5ye4rBjn2x54EMqz2UI54xOqmMwxk7fT5OI0zD07OLiEUkVVZVbJNR909tifaOVmai9lT7QmfXqp1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473165; c=relaxed/simple;
	bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIeDG0eytpZyMjS+QiE6tRSy5lox0eahFtjywmPLd/YqUxzP7iQ59GzliQ05A5/N/f4Yi7DUsBc+E8Wq8YgTZjGzclDhoDKoWKnzjihEo/5UpPTBwgpZcT33lEiPdFgeTFUMWLI4rQijbTLs9k1nQQovacBZrwqVQmLU6hOJHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1Naru1UQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e8f765146fso4414364b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711473163; x=1712077963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
        b=1Naru1UQWTn0v6LNMsAhGaXxzxkukwBOOpniibHlqnvlBDZWtjZaovT+JkD72nwI78
         OeaOcfW8W+mmVa8XqZnNLGMa3Fk3DS32edtZklkW3jdGfABMi2Do8BtGNAPclNVSVd/2
         cO2oHvmjcI34bmDlSS0qR+lsh3ytM2m4bMyHxR3yXFaGu5uJYDlCQ9uocAyhDBFnQFIu
         X+V7fayFBN8h1mCGjxEf2iuiBeU9CA1b6ioeb+QqKbe2OzFNiSgpJazW+YSNW3XUZL6X
         JkSBVSWLTz8u8CncKvg5cSsJYSip9pXDtciQ07A3DeSlLdv5CHPhoiWtngfj4IsB65jX
         K0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473163; x=1712077963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68zkLJbxYYmwUoOB0L6Mut+xqSnMcNf2y/wAtt/JDdk=;
        b=Hk4BxYXV3nu/z1hMNDGM6oFJMvoHCBH00/9BssNn3Qd89na09VV7Wwti3LLQrOGvC7
         ItZA0HihQa6ND3HHyxGnayXP6t2ERDmidxZWEYUs0hEeTKBB+tOg/fOg3VqeD4b02MDg
         qy5tKKa1GJeC76tITUYggOnutQEipeiCO1e70oQvxFU/UKR4KuL3dqDQun+gpMBMbqE+
         3u9X9K1pTyEXlswMp2LlAK2KmMDP4c1bpJDBJtn490Y5GnbN0med15lHigVf3mgyD42F
         MqRg6JY94E3PGSg539pwnGCAsQnLxvH5LwlcAPJeibvXnRIm2nTVRlGs/vWlw9jzow/y
         7bOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFzrepPAOiRFtVPgt6wAKHCnYfW0VMv0EUXBC9KeGWFYDLAFOnBx10YKwP1A9lIXSZnpohnLibjhTLd6jeH0Li5x2ujwcXRPWRmip
X-Gm-Message-State: AOJu0YzhAne3b3KY3DexSYcZmhkrVu981S6r5/CSfX6iUINeTD80xlBW
	m6AanpxYZn0h5NV0ZYJA7otwbUbEMYG0honD7ECmjkG7GBenFIUKRAJ+J1b7L4o=
X-Google-Smtp-Source: AGHT+IECOLNLA33Fh1Dtl1xN+3+um96Kiy22pZAzpu9xyTE92JwCPZuR7PyVH2KwaoFfaTWWhbwu0A==
X-Received: by 2002:a05:6a20:4d94:b0:1a3:6833:1cf5 with SMTP id gj20-20020a056a204d9400b001a368331cf5mr2559992pzb.29.1711473163178;
        Tue, 26 Mar 2024 10:12:43 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id it13-20020a056a00458d00b006ea80a9827dsm6199912pfb.82.2024.03.26.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:12:42 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:12:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan Carpenter
 <dan.carpenter@linaro.org>, Ziyang Xuan <william.xuanziyang@huawei.com>,
 Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240326101240.65c28519@hermes.local>
In-Reply-To: <20240326090220.3259927-1-lukma@denx.de>
References: <20240326090220.3259927-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:02:20 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> Configuration - RedBox (EVB-KSZ9477):
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig lan3 up
> ifconfig hsr1 192.168.0.11 up

Learn to use ip instead of ifconfig...

ip link set lan4 up

