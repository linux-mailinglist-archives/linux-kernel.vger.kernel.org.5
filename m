Return-Path: <linux-kernel+bounces-26500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368CC82E22C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1372282EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F591B27A;
	Mon, 15 Jan 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPRx8b8m"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BB1AADF;
	Mon, 15 Jan 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso9696823a12.0;
        Mon, 15 Jan 2024 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705353623; x=1705958423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39ozkC0HqQZ+Edap3Ljm8Xvwn44jjjAD+L2Y5G1YxR4=;
        b=FPRx8b8metkJYINl5JNHd7k+WMBSgfOrpipy4cSCnml4rlQtbxC93FMPc6hvSixIbj
         jpswHTUPBZoZCTPsJS3iV5S0emPcwC7sZ5IfrvrfDrosso+pPTcknMm6aKC4Nvxp7dx7
         QJzVugUOg8a10aUsu17qt+ml6VBySC26OVu3WfFPidvX0XgeSolV+yJLKNwFGowxSbzf
         kzdrzUwtI6TIzdhj7EtSmChUb7k3G/aRaogNZfr0yirccY/pvxyZeXrgXM/xm+cK983o
         L2cGLRd24DtJXT+oM2sKe4D4QwNDTwBKAvHc7OIAB9dRjis8loAvEKF9XNpDDq5FD88P
         IHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705353623; x=1705958423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39ozkC0HqQZ+Edap3Ljm8Xvwn44jjjAD+L2Y5G1YxR4=;
        b=OyN6yC42kTRzxAFIPCVsYruaioUsCgufHTbGfk6arZu43v6UJLvECErq0Aq9tHWj6S
         39UsyspHmbry7UKod7bG+NyDWieho6dhyxV6XXiA0qF++WunOOwL82GfjSzBghbCG1sR
         GLysGYqSA3TiijqCFHQ0XfReO8qSdMmKh4WbolCD3tx+p2zgFM3GZOSIl6lFOD0xXNz1
         QAvVH2LM2vikPOQWN1OXosuI6wCi6WIvtqWgJBkQuTEjr2dIGWIwRh3ZEWkSyIaBFxga
         xG9moBd8Bv/X6bfwUdCup8NVlPlax0GQMHmowtvyeoMnlVDeaJvfcU0hvJMF+SBBEnvU
         1sLw==
X-Gm-Message-State: AOJu0YxJEKaWIaUfneVohV/AHbUqLpfbtNHwtXLZecvA7/OTmG0cwYPD
	tS2EXFRvNnuIbvCO/36PTQI=
X-Google-Smtp-Source: AGHT+IHv3NyJLuT0FGCd+kbmIzXlKGmCwoOcQxRz6260TRiuR4kLFOFZNS/jjOerZLceilUQrzbFDw==
X-Received: by 2002:a05:6402:b12:b0:54c:b24d:a3b6 with SMTP id bm18-20020a0564020b1200b0054cb24da3b6mr2793991edb.20.1705353623234;
        Mon, 15 Jan 2024 13:20:23 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id c25-20020a50d659000000b00557c51910e4sm6104974edj.85.2024.01.15.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:20:22 -0800 (PST)
Date: Mon, 15 Jan 2024 23:20:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net-next 4/8] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Message-ID: <20240115212020.oaw3hx65feetplve@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-5-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113102529.80371-5-arinc.unal@arinc9.com>

On Sat, Jan 13, 2024 at 01:25:25PM +0300, Arınç ÜNAL wrote:
> The crystal frequency concerns the switch core. The frequency should be
> checked when the switch is being set up so the driver can reject the
> unsupported hardware earlier and without requiring port 6 to be used.
> 
> Move it to mt7530_setup(). Drop the unnecessary function printing.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

