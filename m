Return-Path: <linux-kernel+bounces-81902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBC867C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6F628C8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B4A12EBF6;
	Mon, 26 Feb 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkwIMLu2"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A112C7E2;
	Mon, 26 Feb 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964714; cv=none; b=laExBUVHsqEk+sNUcBGIQpSKWVHejDiyxfvgXO1i1Hpjguvb6Pkabse7OIeNQuilSKNM/npJphDm4iSKUqfze6tIa0VdBC1hgGs3zrz2esS85zE8TzezbNxKk79dwfVfvepzI+bShkiylRygdpi4BzBnAI9f01rXFb4K9bq6rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964714; c=relaxed/simple;
	bh=Zha9MTer1+ivlDWWnbhfFfwPZpnIbtl+PNMA/+71lL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjioWndvyblWHrtlKdY4NGcdspzidyiSrnK2ttxByA25+jixm6OJ1Mb94AdkRvN3js0OY3lZLQQJRSI+hSE1Dt4nLIIBm7q1R6iMBPR/pzYVTYU9K1V9PCTpLTb2OsrJA9aOrImCm9bipetPG/cfdqtWaviLgt315SRzcPwh0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkwIMLu2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2573405a12.1;
        Mon, 26 Feb 2024 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708964713; x=1709569513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKzSA2YeBsQVoAG/zw8293MLkS2N7cW4zmSYPw7lkcI=;
        b=WkwIMLu2eIcFchAz4W3MRuLcIYmHKhJzW1USCUy9ahAIwtcSf6BJVmiRyj252igIwC
         Knezu0q7rSHZIPm9jY8QKRj8SyH/9xZUB26IDDcZnWhpXUtXxxB4VlBWV6ZzN+cCtKhJ
         9xGZCzEQcne5f/cJpy43kD02sY2rknF2nWNnz1g+pOMOrhGq6wmci+tISDskhtUhl2+d
         fOm23YpG+1P8AE2IZh+M8AYz2PfXSIDWczl4Ac7EvyYIsLKXPzaKZwoswWQo3jQj1QIr
         iDk//FVdh9TCsPFSGlUI8QH1iKDV5W2F5dH/E2Krt8s/XcA6yyavJC4qxSpvJfYPoZJf
         551Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964713; x=1709569513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKzSA2YeBsQVoAG/zw8293MLkS2N7cW4zmSYPw7lkcI=;
        b=BYaKzVcwUKanuziAz6xjJUOKKvXhmKAVB5eqfd4qpJJh8XxBx9vKaECnkVP/7s/fAd
         9gUDuLJpaRV6gG7cnmnH4+8t0CXDchmp+B26D3lKqvMXf5k1/Nxa6P0NUsfTtuW8gv/j
         eQFucWmidt0zbxSrmkyTibaxjNVdmAQxzTfPUGbz5MthQnKHixr/fsXHaKTbhRvUHx4K
         0YmKBpzFgGBFbZM1ZzxgD705hoqM6EAtwUU7SJKYhEUOA2gTUzAqw4Yf+fFUCbmu6Y+L
         6WT8HVk/m5v/3/PqSdfgNSoeP0lPRVTGJA1HeoQaCD61vJthBYygqcjJdb2gj1AZchjg
         YRgA==
X-Forwarded-Encrypted: i=1; AJvYcCVw7sohP+Ac9jS+gvF9YuEa0LxG67TSTYqFK2Rhq4wkUKg192Yz9u42f1NdCqyJYFcHk/BGei8y5OAz6RQ6205q92eKZi/b2b2D+YVi3am29L6BKwjdhCXYz3Q4bto3tIkz+4Q9
X-Gm-Message-State: AOJu0YwTNU5GQ+29shaUKEkIOVVlT2yiDM78/9nYwE59XYNCC9SIELYp
	Cou9303sfJCWhzCA5vuEcacxI9kEHSDo5KKOut/hdtRjlKFT3NG42lFzbgUtQqwqku9qVdB2UWc
	qNPrXWVQYaeWujRu3r7Pfloe7hyXUSgV0Kmw=
X-Google-Smtp-Source: AGHT+IGOXpY4O8BIzcr9S1OBjFMDtYrl2tpYRREP8DHO0Yl73utTwzqwIYVznJEMBHxUvHZ9WDt+xa90ai4WWJ3fuGk=
X-Received: by 2002:a17:90a:ce97:b0:29a:1ed5:18a2 with SMTP id
 g23-20020a17090ace9700b0029a1ed518a2mr4659219pju.47.1708964712608; Mon, 26
 Feb 2024 08:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224203349.1358064-1-robimarko@gmail.com> <cb5c185f-1946-4548-9918-01548e9dd9cf@lunn.ch>
In-Reply-To: <cb5c185f-1946-4548-9918-01548e9dd9cf@lunn.ch>
From: Robert Marko <robimarko@gmail.com>
Date: Mon, 26 Feb 2024 17:25:00 +0100
Message-ID: <CAOX2RU7xKM6ywGbzfB2ZCmYadJYG1uq=doTBfPGNnaYaocmG4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: add Amethyst specific SMI
 GPIO function
To: Andrew Lunn <andrew@lunn.ch>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 14:57, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Feb 24, 2024 at 09:33:09PM +0100, Robert Marko wrote:
> > The existing mv88e6xxx_g2_scratch_gpio_set_smi() cannot be used on the
> > 88E6393X as it requires certain P0_MODE, it also checks the CPU mode
> > as it impacts the bit setting value.
> >
> > This is all irrelevant for Amethyst (MV88E6191X/6193X/6393X) as only
> > the default value of the SMI_PHY Config bit is set to CPU_MGD bootstrap
> > pin value but it can be changed without restrictions so that GPIO pins
> > 9 and 10 are used as SMI pins.
> >
> > So, introduce Amethyst specific function and call that if the Amethyst
> > family wants to setup the external PHY.
>
> This looks good. The only comment i have is maybe we should rename
> mv88e6xxx_g2_scratch_gpio_set_smi() to something more specific. It
> seems it is only applicable to MV88E6XXX_FAMILY_6390, so maybe
> mv88e6390_g2_scratch_gpio_set_smi()?

That sounds like a good idea, want me to send a v2 with the rename as well?

Regards,
Robert
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

