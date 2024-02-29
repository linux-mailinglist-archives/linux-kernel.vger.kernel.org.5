Return-Path: <linux-kernel+bounces-86383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA986C4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA71C23265
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6057896;
	Thu, 29 Feb 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/M83K47"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42F57863
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198066; cv=none; b=mjTvACE+T7Tp9LHDCLSfEcwVm36CsZGmTqvaeo6jTMK4XWeKYu7LIT+uKezADrYuXApONp897SqaB4Zn/dNlylpLqISpIKQM52ItXRnzq+PYvl7KommDs7//5EKjzucxlLORIk6hSQ6AUwtTODHa+FxyPqXdHkOckARq2d0/pVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198066; c=relaxed/simple;
	bh=IofrlesPZkCsPELzdwViFTVoKzE+kRJ9CF/vMqoCaKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsDibarTxJqK5VV/725rmbdATaXAElRQK+deJH4TExMdHvPomyqte77Hs0o/Q2/yMdKXhztX1t9V6wjazVFJrbxPnKnl5PVWpKHLIHWfkatW7a94ExWwdgm2ox90Jy8CbyCUxmtlWpjvdkfHH8xGkpegU6WqnE1uq9CdgozT5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/M83K47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709198063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IofrlesPZkCsPELzdwViFTVoKzE+kRJ9CF/vMqoCaKk=;
	b=H/M83K47+j17ruX/yEAGcfB+1l5+8Mb1qJSOtAvL7DpLeFitpLNyW8XoynoGRBFzLy3q3A
	QmKl32XFrGpmj5PNdAJVRnXdh3vWjMZwdqi6ldzNjMGKAt1aHKjjBzficrwhndVQmRh+a9
	ItgkMJuMFIM2xIaPn6IyuO/8VLboJZc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-8tGYiZQuOYGHqsF8IPPGjg-1; Thu, 29 Feb 2024 04:14:21 -0500
X-MC-Unique: 8tGYiZQuOYGHqsF8IPPGjg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d2a83b6628so610371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198060; x=1709802860;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IofrlesPZkCsPELzdwViFTVoKzE+kRJ9CF/vMqoCaKk=;
        b=t1x0E16/dgKH0c6wO/qbQuiqq9fwq4D5wLCasz5TT1x1ZH9KM386BqkLL34GT0Cluy
         zWIzzDuPRHKa5j35qslEFUUawyNmYEDeRFXU8d4SXnsw8FIW0WPyLJ4hzXQi/eBLktXn
         FkxIn730XyQf+Yoi1chD5Sk78LXJzC/1QaK+tLUJX1GTBYqxKfrRQAWfzD9sMKZR1q3O
         QRjYzOkmTwowCpogGworeLK/ynjxtVi6DsFtr3haPXLnXZ7tX4cuZhuh0zrGYRB/Lk07
         4srq8wB/MAe3iRCUUwustCgHoD8lqEK6HhCXhAWJjpqxyneYRINpaUEYAyKhSCOkbMOF
         uLrg==
X-Forwarded-Encrypted: i=1; AJvYcCWLS2brn6sjWgXyAfShbsTZd/7VMeu7SORseRlOM8IjzmQGREBXNclsHVy6GQi5evOR03SsBzfc7J9S2WJKIav36vllaMVn38tkmMs3
X-Gm-Message-State: AOJu0YxFDowdkSB4jP3IEc8K5JAldp1dym6zj92a8FlAmt/HHKX68SpB
	xixlTr4/baekR7rAFwEdB9ly0a7PNbr2ZTvDKfgWOgdjLFG9VDxVxtsSd7QL+ao+VkZOzUpZDJT
	99HqUcjiNkRRX7Sx+nrIOJCOoYXpswMVzQO8MqntMzcTocmB6KDMrybbQFpgE9g==
X-Received: by 2002:a05:651c:b0f:b0:2d3:fca:dae6 with SMTP id b15-20020a05651c0b0f00b002d30fcadae6mr345117ljr.2.1709198060523;
        Thu, 29 Feb 2024 01:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDj9/d68YTQW3CJqI8K7VC8uW6GKMoJK9VuxnNvnrMgK2/AUvHi6LwMNwj1x0iHhqlCQvSEQ==
X-Received: by 2002:a05:651c:b0f:b0:2d3:fca:dae6 with SMTP id b15-20020a05651c0b0f00b002d30fcadae6mr345104ljr.2.1709198060122;
        Thu, 29 Feb 2024 01:14:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b004129867fae8sm1489037wmq.1.2024.02.29.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:14:19 -0800 (PST)
Message-ID: <b1d6d86e0d31910abeb4c0d9c43b98947835d316.camel@redhat.com>
Subject: Re: [net-next PatchV3] octeontx2-pf: Add support to read eeprom
 information
From: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
 edumazet@google.com, davem@davemloft.net, sbhatta@marvell.com,
 gakula@marvell.com,  sgoutham@marvell.com
Date: Thu, 29 Feb 2024 10:14:17 +0100
In-Reply-To: <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
References: <20240227084722.27110-1-hkelam@marvell.com>
	 <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 16:47 +0100, Andrew Lunn wrote:
> On Tue, Feb 27, 2024 at 02:17:22PM +0530, Hariprasad Kelam wrote:
> > Add support to read/decode EEPROM module information using ethtool.
> > Usage: ethtool -m <interface>
> >=20
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > ---
> > V3 * remove redundant checks as stack is already doing it.
>=20
> So still only access to the first 256 bytes, using the old internal
> API.
>=20
> Disappointing.
>=20
> And the Signed-of-by: appear to be in the wrong order.

To clarify: If Sunil is the author of this patch, you should put his
SoB first and add a From: tag before the changelog, see:

https://elixir.bootlin.com/linux/v6.8-rc6/source/Documentation/process/6.Fo=
llowthrough.rst#L199

@Andrew: it looks like the firmware interface is going to be limited
for the time being, are ok with that?

Cheers,

Paolo


