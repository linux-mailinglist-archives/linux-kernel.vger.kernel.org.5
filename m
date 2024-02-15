Return-Path: <linux-kernel+bounces-66898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27085634E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECFD1F25BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF012D740;
	Thu, 15 Feb 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0HO3StJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3797869B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000548; cv=none; b=aIImHEvyj8PODisqzPcefH3FtpXyg3jU1qNLwQSPlJWzQ6e1BNG0vF+HhoCkfJmgrZtjRop4waGBqbal7/xkCxhQqIRCWRXZTLZwNkxlw1yo66WCEhBnoRLtRPcaCa7tvgPf9OsDST3vm0JM9+95SYxT8/KGDjjt16C/MDgcTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000548; c=relaxed/simple;
	bh=xN/gGVlhPbprw7thWBYczZVWs94pwbgvQ6SbrG1p7SM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzPtatiK7Ka5nEJvlkjQnJ2JAZ60+qJD3UP2t9ZtAIiR631SastGW5KAq0GKxPEDUtCOh9+EjbQRYiMU5vwvu8Owc/Whe/bDxIxjj59ecImfTsSYxChg6FK1V5b6tfOMO0yaQLG1KYM46yuO8wXwD4ymHDTPBjbpZxfAppCfUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0HO3StJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708000545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xN/gGVlhPbprw7thWBYczZVWs94pwbgvQ6SbrG1p7SM=;
	b=i0HO3StJxuypHex9DfvpJ4V2tRYDws2W6GNenBkP4xgH4vWoENn+hTGqYPMxABfJlJ2OpV
	agx3jA9vSj0A1uhrG+1EGyT1/l+HcjCxbwsnIXPk5ZY1xDpKwF3r09565CLbU2p41kavZx
	LORX38PpbDl5N/WQ6UsXj+jY7TIQRqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-R_Gy5zQWNK6UZbtsW39Npw-1; Thu, 15 Feb 2024 07:35:43 -0500
X-MC-Unique: R_Gy5zQWNK6UZbtsW39Npw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-411e27d561dso1939055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000542; x=1708605342;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xN/gGVlhPbprw7thWBYczZVWs94pwbgvQ6SbrG1p7SM=;
        b=i9az8QtvYprFB3VQ7pZYodxSrKXKNYP4XACHROGKJMKQrwhxsbsq1xGpzzjuojPmLD
         dRxXLuSl5j2vBYjse0aBtzzH2OAOJ28NaFTHcnPUVcEXo/2tHwapP/Wt9/vsWjJJghk8
         uNXCAK+11YVeGnHRBHBtascZOvBYX9I3ZsW/QqrCWJquJjm6nFtJ+ETASz1/TXSEHD7X
         4ynYk+1OSn+2NxQljvzxBxlPkfW/2CMFxgcttWYwN0v2beJ8Gz2MwQ+G3HiXd6NDtb5G
         qoYEFfinxSNGNUIPcUEBypDzRuH3ttWuCC7ls9QTb249atDwAQVOMk1X9Vgslw/KiQ6c
         08Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUuHlLn2yBulDShJ7qi0aIOMcG2DWlW1eqev5vK7+lAXemZ2o9XFU9mLXAI2NZ0EJi/YaPLKAoWJpCCLomDnYYfem6kdynAzrw4DaSK
X-Gm-Message-State: AOJu0YxynaMENsvoyTzYqnlSWOJk3yNqIuyhmkv2F5os3oHRce/pk/Mx
	17CZOxfhJ6pY19PUc1oOtLS1LyGfe2TCoSxFc17XGRiIDUzZauFxqs7FypbQO9jh8hIF9aCkm59
	ZZXnboU71a4Ayvtb7TNDGPQf5HHbXcYY61NJ84rQaXe3yCj+Ji9pW6oeYytOjWg==
X-Received: by 2002:a05:6000:1e13:b0:33c:f9e0:77bc with SMTP id bj19-20020a0560001e1300b0033cf9e077bcmr1428521wrb.0.1708000542410;
        Thu, 15 Feb 2024 04:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhUeUVatfqrthDCzJ71j/wlST0Bl6jpO3E6AL5F7MFgE5J331qefqB9ipOKc+pv/bPE+vTbg==
X-Received: by 2002:a05:6000:1e13:b0:33c:f9e0:77bc with SMTP id bj19-20020a0560001e1300b0033cf9e077bcmr1428497wrb.0.1708000542039;
        Thu, 15 Feb 2024 04:35:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id bp21-20020a5d5a95000000b0033b5ee36963sm1778823wrb.23.2024.02.15.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:35:41 -0800 (PST)
Message-ID: <e9c0e96314a36ca4320ff215c03d5f7dc0e01235.camel@redhat.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR113 PHY ID
From: Paolo Abeni <pabeni@redhat.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Robert
 Marko <robimarko@gmail.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Date: Thu, 15 Feb 2024 13:35:40 +0100
In-Reply-To: <1d30f923-8391-4e36-bf3f-2cdb733d464c@lunn.ch>
References: <20240213180228.15859-1-ansuelsmth@gmail.com>
	 <1d30f923-8391-4e36-bf3f-2cdb733d464c@lunn.ch>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-02-14 at 19:05 +0100, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 07:02:26PM +0100, Christian Marangi wrote:
> > Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant=
 of
> > the already supported AQR133C where the only difference is the PHY ID
> > and the hw chip size.
> >=20
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This does not apply cleanly anymore after "net: phy: aquantia: add
AQR111 and AQR111B0 PHY ID". Could you please rebase it?

Thanks!

Paolo


