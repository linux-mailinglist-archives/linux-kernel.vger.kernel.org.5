Return-Path: <linux-kernel+bounces-26506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55A82E23E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D748A1F22EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920BF1B299;
	Mon, 15 Jan 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGwvkKR9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF11B26E;
	Mon, 15 Jan 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2c67be31edso516773066b.0;
        Mon, 15 Jan 2024 13:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705354961; x=1705959761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=55NEIJBXCpIIIZWtPRCLfdLr/foh8lYBwfef4urHTYE=;
        b=mGwvkKR9CyPgREa+dshpQK7mBmIdLO1BRl8JG+eKgJej/DYmI4Kbz9PcBdlzHVewM3
         dML1GjwLJJos9EzYbhMZXe2IW7942NAGUVhgnf1VnPgIZPTpYcS++KNXMS65EJhFHTGF
         sWt25Dp14bkeqZDrClo+Gl5R9R0oDZ/z6wrdaMxgbj/DbMzAmjPG0/Ttf+3D07uTZIIG
         U+iCwyvG5f6FxW4g/PxahqI+BrbJhesfBEZJjir9+tFcKXWuSbKIMDibi1pA1mgdb+o3
         7HhomqnoZVCKhU2+51Aq2A8VUNDA20Ayt6eZNloMCT/1kJ21kRN9wZ50IJmq/v28bifQ
         DXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705354961; x=1705959761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55NEIJBXCpIIIZWtPRCLfdLr/foh8lYBwfef4urHTYE=;
        b=DzIkSxhnwSA/2727J7NK6ncAv2/ysBh+VEu1HYJ8kXPHa/oae/5ISANLpn6/BJSHCt
         JkdA4bmqiS5hU+LUio5+0xSuS2355JZfC63ZAuXoPDo8YRM+C7ctQ8wDb4Ujumy/d52N
         xawAMw4Syp7fCmJRuG+EaGoG0vXvSs++XaG8W7jy/tvb5eMH/gNlDqRUxJWs3OrFV8TZ
         M5Qmw1blH0+YOY0JtEW7iv/r1gOxcdT3VPIwIUm6UC5Ry8oo//YHleUziHRPlHU2MOAj
         /bGL4IMJuIob3VKHxftfFlSU6y4HhT9vD0Mo5sFHnLvsdzYd9euPcgVeAyP3jhP4Khb5
         U2JA==
X-Gm-Message-State: AOJu0YwgY7CGx+wXA+I0Xze6HIlKniTV7tDIjFgafgihderSb7H/a5Xt
	VVPUeEuviWWy4yAnR6X25R8=
X-Google-Smtp-Source: AGHT+IFVXESXnZ5hXNPi66V18lKI+85ApHMSsnxuhoou/MRvRXnGDbW8FPlG037wrslaHLypJx/8dQ==
X-Received: by 2002:a17:906:d044:b0:a28:1916:6cc9 with SMTP id bo4-20020a170906d04400b00a2819166cc9mr1609989ejb.270.1705354961355;
        Mon, 15 Jan 2024 13:42:41 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170907770700b00a29dcbe1e72sm5693853ejc.56.2024.01.15.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:42:41 -0800 (PST)
Date: Mon, 15 Jan 2024 23:42:38 +0200
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
Subject: Re: [RFC PATCH net-next 7/8] net: dsa: mt7530: correct port
 capabilities of MT7988
Message-ID: <20240115214238.bnlvomatududng6l@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-8-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113102529.80371-8-arinc.unal@arinc9.com>

On Sat, Jan 13, 2024 at 01:25:28PM +0300, Arınç ÜNAL wrote:
> On the switch on the MT7988 SoC, there are only 4 PHYs. That's port 0 to 3.
> Set the internal phy cases to '0 ... 3'.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

For this patch to be obviously correct, please make a statement in the
commit message about port 4. It doesn't exist at all?

