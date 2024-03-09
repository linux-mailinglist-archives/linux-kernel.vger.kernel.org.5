Return-Path: <linux-kernel+bounces-97962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E6877267
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6272C282083
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BED9224DC;
	Sat,  9 Mar 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pYrS0Ln3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254401CD1D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004175; cv=none; b=iEoR3Rj3+UmmaeE/TCXTnMXzsKJnhcqGwOE8/Q1y+MvuorD6QrYGjj58mUSOK9fGDgsj+Jr5OkMn6udHlrhDm3vgpD66eFO3jMcJm7Uzw+olr33cQbuVOfCNu+QluSTCyovTzT0Hhg+BAMFTIrcy2MLKRZM8rQ5rsBY/WG5yT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004175; c=relaxed/simple;
	bh=3LtTJJAKkMJi9k3pEnpGML//0wkNiAxpHKQG7njIq9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKMZEO03eXJ3vBTH+aK9PwsEAQoZhUW7mNk/hUYlqJ6dAE7+PvWp/QWv4RdZyEPFxuSsizYd9XKSK9C99LJpjcIJ7aXPkOzUQw+iQfFSnOhVtzP/3Nz2V0Zvo6kbgfCMIKw1GmZjBIei72Fa3MSxetktXjFcD8g/C1w38iKMh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pYrS0Ln3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5eb3dd2f8so2436377b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710004173; x=1710608973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHqXXAD6Bd7td3uOYjMjmxkJMM3dnF/Fwmd9qHYiur0=;
        b=pYrS0Ln3FOrgu1/Ay3ClydxWzWAzU7HqtDMvH1aWIND0MUnGCW58TcxF1EtXfRIKG+
         +T0t1YaYbzDzLn3Q6G+VN0tuKRbPFfSd988coqYh15IXpUfJySE9JbiSAn6i76SGBQMc
         8R3hPIXDVD5EGpUiTyygvghwQCoKKXHPaaluu2JssS5H8OkAv8vqc9Jx1JnZ7Z536NhL
         aAuNhBu+ZGY/W+Pm5xeEv5vHmQTzTNFE+WwMZHfE15LOTXEM4VR2AMH6luMo0TX47slD
         K6TWeyEFYY1dBsTaSQ9Q+JFWgaLmjbcv8yzdJXDMhxQl2na9lyauNpNJEQlVLKvYkD7t
         zBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710004173; x=1710608973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHqXXAD6Bd7td3uOYjMjmxkJMM3dnF/Fwmd9qHYiur0=;
        b=fbkC8HTh8t2n3R+eaUo6Z2hChh/F+mvSYZf0tGAQEoLvD6S7hco7w5VgiBNhDFG9Vq
         7wC+QK0Lfq3oaBFwLai8nC7wuiMFg7pnigUIz1711Eg2aqELzV12UqhIwl1wnc8JUYG9
         zGhoDQQfktYEycuothC8TwlJ5I3ZC9nzGa47TCpetzIgorEECFVWCV8rvgJrx8RTAqzX
         fpMkfMze4oOaqF1NDqCoVz1MY8R+VLc+FCLndwuHvNZesEyRWHoykNIiRGFfXJD4RDAg
         2AWuUd72uaSuuhb1fskenQ6HiqAoCQHOcwf9JhrnAs2NmSJo0BIHTt0G/Wk/LgLNibvt
         8e/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVihiOoRppkKFr5UjDr+jRSzns/AFfjapzcb8Lg4diJ50RMHx3BYajPabmJubwC5iHyxPGRcIw4pbv0+U0nCm44cr/Tj2Qz4GJaishe
X-Gm-Message-State: AOJu0YykRYTV8Pe1GleV2PbhbR7S5FzDiXzfRLYtrLFvevpJtWqkBoRP
	1P5hpwRGcDmPmXC2qosC1IpQx6elKu3yzBWlxYzjtL3/cFm9kVezwK/uoXi3CgM=
X-Google-Smtp-Source: AGHT+IF7Y1eftpCPunNKY4Vn+a7kmwiaPKByHoRXD9GXTyR07mOXokjvYu/FJibk+pnPc32Q/3RgTg==
X-Received: by 2002:a05:6a00:812:b0:6e6:3920:7a26 with SMTP id m18-20020a056a00081200b006e639207a26mr2502722pfk.3.1710004173335;
        Sat, 09 Mar 2024 09:09:33 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78390000000b006e5dc1b4866sm1500380pfm.144.2024.03.09.09.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 09:09:33 -0800 (PST)
Date: Sat, 9 Mar 2024 09:09:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joe Perches <joe@perches.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Simon
 Horman <horms@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
Message-ID: <20240309090931.16d8d58a@hermes.local>
In-Reply-To: <4f38500b4d798ad8effd59fef41353439f76fec3.camel@perches.com>
References: <20240308104725.2550469-1-o.rempel@pengutronix.de>
	<4f38500b4d798ad8effd59fef41353439f76fec3.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 09 Mar 2024 06:26:28 -0800
Joe Perches <joe@perches.com> wrote:

> > +		problem = "Attempted operation is undefined, indicating a "
> > +			  "possible programming error.\n";  
> 
> My preference would be to write
> 		problem = "Attempted operation is undefined indicating a possible programming error\n";

ETOOWORDY.
Be concise please.
		problem = "Operations is undefined\n";


