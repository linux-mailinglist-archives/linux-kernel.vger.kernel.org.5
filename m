Return-Path: <linux-kernel+bounces-23385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686482AC07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799C31C234F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BDB14A92;
	Thu, 11 Jan 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEbM+B6C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6514F61;
	Thu, 11 Jan 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5589cfe4b88so469900a12.2;
        Thu, 11 Jan 2024 02:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969110; x=1705573910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c96eHGeRMy0FA5YmUP0POLqi/6OSA4NTqHeMHP6wHhc=;
        b=SEbM+B6CPnjiBr+8eUq2VFtygVxQbF+qShorEGwMkWbJpquAjGxKlI5WHh+8Dv7Yy3
         oPmxeC9aND1pOzaA/aRxIj0usEAbXgu/MlugzvDBPxRCV2HnX/vpBJUqG6rcVH5rJgs1
         QJ3bVuMLCrUNck3bCOCp3ubGvC06tElY+vc4ib4W56T+pxpCx/bOLhco6RjmyuVbkawB
         U/xye9aGZtXwpjlVjPj5Wqdw7kMzY7Ku2/TODl2qgODnAdaq2vVRZOehTQ/w04wADLmx
         VotUlHbU/5c/FcsqTGFalU9LpWMObbAuGp62XJ8eRQGUeGO1Hz1SG++C9kg/DFpVeCqY
         JPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969110; x=1705573910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c96eHGeRMy0FA5YmUP0POLqi/6OSA4NTqHeMHP6wHhc=;
        b=HKPepzRwLYVQKvZ84ena2AYSleeo4dPk9zeC0zcJwFPQ/boiA7t6PL0H1UOgLgblfk
         5N9zh3lCHiiv3gS6Nr2wWXmgifocy/UKQt7upZsgnin7cfMs5KFwkCPuFBnF1/1uqDcF
         WRMJDjCQ/hMef9v1ClPhs4HhJ7hLxyR2vInF0+973hBdFs8ozpPEN1Add8EOXjR7XuQs
         Sr3cB52itfFYZQlyXl9inkHU81oH2ryPEWCaw+fCaf0AcB8QaujS0BsmoXlOMM60MBye
         JsRMIG+swxkD9zbBIleLucHF/6RyzKRcAbre6eHqONk9RogGv8TdypXifo4UUBHcBzjS
         gTGw==
X-Gm-Message-State: AOJu0Yy/G62wXKCM5yiA0wvNwPpW7JdbYug2tMaXPKLSonkPIg1/U3kf
	sjrt4EsJ8kUZJt94o+kwNP0=
X-Google-Smtp-Source: AGHT+IG1bsDJjT+tCb6RsDzpYr+HZg8W8eOGQ5g6FgdP2xO4ZZeFbzslfzXkR//fI092SnqELgkksA==
X-Received: by 2002:a17:907:842:b0:a28:fd0e:6051 with SMTP id ww2-20020a170907084200b00a28fd0e6051mr697695ejb.33.1704969110140;
        Thu, 11 Jan 2024 02:31:50 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906c18600b00a2a9ddd15b8sm409460ejz.173.2024.01.11.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:31:49 -0800 (PST)
Date: Thu, 11 Jan 2024 12:31:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20240111103146.t5fzr2wlw2tyrkkb@skbuf>
References: <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
 <20240109145740.3vbtkuowiwedz5hx@skbuf>
 <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>
 <20240110182358.ci7pg7ipcbsjxqjf@skbuf>
 <009fec43-0669-419e-a3a9-ce54c676a324@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <009fec43-0669-419e-a3a9-ce54c676a324@arinc9.com>

On Thu, Jan 11, 2024 at 01:22:12PM +0300, Arınç ÜNAL wrote:
> > BTW, besides OpenWrt, what other software is deployed on these SoCs
> > typically?
> 
> Other than OpenWrt which is widely used for these SoCs for its ease of
> flashing and upgrading, compatibility with legacy U-boot versions that
> usually come with any vendor making a product out of these SoCs, I can only
> talk about what I deploy to run Linux. I use mainline U-Boot along with the
> device trees from the Linux repository to boot mainline Linux kernels with
> Buildroot as the filesystem.
> 
> Arınç

I meant what other software (operating system) _instead_ of OpenWRT.
I'm trying to figure out what other users of PHY muxing there might be.

