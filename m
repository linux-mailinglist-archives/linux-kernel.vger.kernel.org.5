Return-Path: <linux-kernel+bounces-95016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C8874830
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE71C227F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1771D546;
	Thu,  7 Mar 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/I3SFol"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB721CD21
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793001; cv=none; b=WOvcgRrgNfSTBroMwNZcTinUYlVNH1bTeuUQPMXTXX/dVEw7rVxT+KBi/AIiHwEIW12GuXfD2rZo01Rc7SeTbsNxhngm+YhIzu5KGf4VozPa9Fu3EwIkSu4gPmoBZAQ1bn9rwGd947bqN5gRxMPYA6k0ClVCf7yhl2BmLXjrGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793001; c=relaxed/simple;
	bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE/pukx7/bCza05cAdtgTj9bAQ9n2eTtjVmr4Ha5WKdhTAL9kS7qEX/Kbca9+RZiLxLGYvo8eW0pdijAU3TO1H5rKW7DncWl8vwoQnE9GeySZME1WEMZD6JYMRlY3VNSOmCELp7iuWAeVK2Fm/ZFpu/DPzVeyT7++IusGGYJCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/I3SFol; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so5336a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709792998; x=1710397798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
        b=Q/I3SFol/5kKf6WEHNP8m3bGEpy98Teh8cyAcei7QTtZ5GaULoAUcvdFf5+GOo8sq0
         OGz9+hsZ/pgJ/1WmBk+dzcmi8CIHb30C4nli2txWNeLeclHylnD5oOoq8jZjlaL1LC1G
         FFzsyHAUomBh3rij92jhOaBZh6DUDMWfaUn0KdwrDSbjATrX+BCBloCQSLsHHg3nqU5E
         qRCBFY+dx9f0DhYBm9CgGc9Q3CPrdnpb8sh7/ksBoCQe8wLzplJ+RQ9cD4jljHLQi/yq
         iEtI/OMqYr8UVlsSJGQkZB/ZCAkkYrbniSUw/a8bXN6kBKi+YO0lsE5jGjybYTSFXJR/
         eCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792998; x=1710397798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQudPlGkZi7nLdd3r5u27oEC5zqBvNR6AkcRY0RjzpI=;
        b=hHtn+QoU0IcNbe45yV3IBXkAMDQVBsetsIvA0x9lrkIDWWDVWB2TtlCkR/0hBvpNPV
         YJX6IqY4b3P7UsiiAODtB5Cf2Y0twqyjjpUN67hsF16GKtseVMQI6ie0cRMchSbhz1uu
         OfiOVhDMZnnz8LpBo6BD2whCgKb+QzxqJIjNZfaRreSC9V5qG8ol50wzMcXOfGm7kujB
         gQ4s9cc03Hm5jU5m/L2Q/qM1Bz9OYZ17qKe8ybSsAK64XFXiZOLtIXIjgpX9SvMI7+6O
         AOj1l/0x8lbNJEZXc/7WsDJGlBgXMth3Q1mLzByXamw7NySX7pl1wDHLcqLFHd8JujY3
         bUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsvO0gwPjysZ+GIHfViH/5om0tYX2FopblxD+wgSbuuhWAMnQ8uwLUBOgTAFuAxWtFOV4nb6DQUdcKS7eLH3q6wKQrm0Z5iT68E2FT
X-Gm-Message-State: AOJu0YxorT3XkEJ+e4xsUZ6WCtNLk3gi8a2rbQrimbRkBFXPBpSYKJ8a
	tmanHlvDe+493uO00Aqn4FMmY5XASwtlye4qGi2tNOtIEyOdGHnRCgT1zLow4uTnru5ARuwfMeH
	nj2TjlZvBMQ2tnbjnTZOI5U346eaYUrZKHcCtcfo6EvkT0t/Qxw==
X-Google-Smtp-Source: AGHT+IH2cmzKIcTqYzHvj2RhWmNsfFi4INJ+wIiSdSx3AVm/nDp7Fur/zyU80RzkdZmIhZm2+sMez+i8jmufZYJ8Ts8=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr142537edd.6.1709792998269; Wed, 06 Mar
 2024 22:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061143.989505-1-gaoxingwang1@huawei.com>
In-Reply-To: <20240307061143.989505-1-gaoxingwang1@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 07:29:47 +0100
Message-ID: <CANn89iKJSGek0vKtH-0QhFgZ9S4Cb1jTmpTq1ZmUFd0G0+b3ng@mail.gmail.com>
Subject: Re: [PATCH] net: fix print in skb_panic()
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, liaichun@huawei.com, yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:12=E2=80=AFAM gaoxingwang <gaoxingwang1@huawei.com=
> wrote:
>
> skb->len and sz are printed as negative numbers during the panic:
> skbuff: skb_under_panic: text:ffffffff8e2d3eac len:-1961180312 put:-19611=
80408 head:ffff88800b6ac000 data:ffff887f804ffe78 tail:0x1e0 end:0xec0 dev:=
team0
>

This was on purpose.

I prefer the negative values, I find this more useful to immediately
spot the issue.

Thank you.

