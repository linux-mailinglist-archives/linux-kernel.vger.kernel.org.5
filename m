Return-Path: <linux-kernel+bounces-135657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09189C957
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C45285BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A71422B9;
	Mon,  8 Apr 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="h4LBflJg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188B13E3E7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592385; cv=none; b=atf8AtXTOlw7ORxEgGs6Gy2TqDV2xiPuh3QdWwoZXh+yQ7idXwL0CauoFVJCntg/l5B1VGxMsSmZA+2GTgiKfhA5w9TVBhCqzwm9n8Bm9FoENuC/qUlVTV8m75T6REjMg0938y0zLdrvrtz5djXeWzKt7qW0eEc+ldFBt78D0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592385; c=relaxed/simple;
	bh=EHGyqHY9v++W1MuSnMW3pb0Ag9yRHxOl0H8XDfQ14Js=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=kzcMN7m0J9/i9DmA4StmhTbT0KrsmdtcHJ/s+LW5mwx6/NHBubUaL708Rf/M5Zq5qKbeaKPEXzl9Uuovg5gho9/bVPDRCEMLMrSuP98zhShQrJLVZ/AXjK5b31sv7O/epQbENZgYf8/YRPqPa1/bKiJq2rGcpgdeyyhnR3JzgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=h4LBflJg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2523E3FB6C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712592375;
	bh=Qi/UC6J504JL4p4+SSyJBGVVdfDEf7nzpgfz+ECmA10=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=h4LBflJgUEsRkZ+HimVxB9XdOgig7/JFDWjSYe+5GUPAmlCKbSN/oYk5nwqpZzQqo
	 biHG1s465fP7D0pYdc9tGThlLiLSspAUGo8IwzEwiP/y5DymVclBjEzut6fyDtXb34
	 1tDUFhnaM6+rQs8dOJrHhGJ41d4/vXRp1iDCNm2Qaru9NB8fM6/JfI+rvfBM7nQtz7
	 vcJftbMf7pDdsW9g6mbb5x/jBQX0TEha4/MwYkW7qNEQ/jXm6Job4cesNf4KyRXME4
	 BDQ2SsnE93kQn8nhq8l6BlhXLY9imMCsunz9nlZIWP4PdRdJe4tVOfBlXW+fHrROcx
	 Am/7MvVHk+m2g==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so3304748a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 09:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592373; x=1713197173;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi/UC6J504JL4p4+SSyJBGVVdfDEf7nzpgfz+ECmA10=;
        b=LHa8G2xZJBberx1xpdoclag8oo7lvk2OPdFUvTZmNbyjFnjhyP1adAKsvNmwZ/xZGV
         ZAWaaHXHUMke//A54yKRbZiksjylgBOq/K2AQwxoxYHvt+O2xQvlY6DdrRf3700cVokB
         bsMNSQBH3aFtgYkZ/54Quyw9QxNPDJRCwjsPmUyX8Oh2S1LbAwvFCF91iaONXDdhYNT1
         HoIqDBgo5Dcwi1+bVyEEHydORLpRkKOyaMI4Mdm2XofuySKDPWMAglSyQ8zv1KLqcvUU
         BLDB5RbaLATqjpa7lCmAsrnI6XOLsfq3rej40rUbb5nttBlJm4jNpqn0aFVyK1zKzuAi
         fCQA==
X-Forwarded-Encrypted: i=1; AJvYcCWuMvf8Xa2ZEDRCnoXbAlo9ZmbajD69swGRlixOKToIjS1y7rqrD3JfmCS9OXdurReqKH9Gz0SIWiOgmHEpgeEy4sJJl3ZNZTf6qc7+
X-Gm-Message-State: AOJu0Yx6MdwsxLGQRg7DcTtZdXURbCDDV7GWP6X734O2CujEX+3wYq/r
	UHIoafK+p2iHgUlNppMt8FL95QE/8IZC4EI4kGN35ZX9/ifbRup7Hc3V6acfCYINJ9cvzhsinUs
	tamWMpN2CG7lDLfAL2ndzI1HosCDHLicn2Dn7IW/0DHAioNsux4X1W/JuVRQ3HwzN6K5vRglgGO
	mRXg==
X-Received: by 2002:a05:6a20:244d:b0:1a7:4ec2:fb20 with SMTP id t13-20020a056a20244d00b001a74ec2fb20mr5130756pzc.0.1712592373165;
        Mon, 08 Apr 2024 09:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWOOgQmG4OvLR0u05aXzy0qbRkNFTK0fHXlDI+xx+rXrPw17t7bIi/He0DVj9VnHWE6DSsJw==
X-Received: by 2002:a05:6a20:244d:b0:1a7:4ec2:fb20 with SMTP id t13-20020a056a20244d00b001a74ec2fb20mr5130701pzc.0.1712592372516;
        Mon, 08 Apr 2024 09:06:12 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006ecceed26bfsm6693109pfb.219.2024.04.08.09.06.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 09:06:12 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id AE33C604B6; Mon,  8 Apr 2024 09:06:11 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A672A9FA74;
	Mon,  8 Apr 2024 09:06:11 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
cc: Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching aggregator
In-reply-to: <20240404114908.134034-1-tbogendoerfer@suse.de>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
Comments: In-reply-to Thomas Bogendoerfer <tbogendoerfer@suse.de>
   message dated "Thu, 04 Apr 2024 13:49:08 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21528.1712592371.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 09:06:11 -0700
Message-ID: <21529.1712592371@famine>

Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

>If selection logic decides to switch to a new aggregator it disables
>all ports of the old aggregator, but doesn't enable ports on
>the new aggregator. These ports will eventually be enabled when
>the next LACPDU is received, which might take some time and without an
>active port transmitted frames are dropped. Avoid this by enabling
>already collected ports of the new aggregator immediately.
>
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>---
> drivers/net/bonding/bond_3ad.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c6807e473ab7..529e2a7c51e2 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggregat=
or *agg,
> 				__disable_port(port);
> 			}
> 		}
>+
>+		/* enable ports on new active aggregator */
>+		for (port =3D best->lag_ports; port;
>+			port =3D port->next_port_in_aggregator) {
>+			__enable_port(port);
>+		}
>+

	I think this will do the wrong thing if the port in question is
not in a valid state to send or receive (i.e., it is not one of
COLLECTING_DISTRIBUTING, COLLECTING, or DISTRIBUTING).


	As it happens, this situation, except for the case of individual
ports, is handled just below this code:

	/* if the selected aggregator is of join individuals
	 * (partner_system is NULL), enable their ports
	 */
	active =3D __get_active_agg(origin);

	if (active) {
		if (!__agg_has_partner(active)) {
			for (port =3D active->lag_ports; port;
			     port =3D port->next_port_in_aggregator) {
				__enable_port(port);
			}
			*update_slave_arr =3D true;
		}
	}

	rcu_read_unlock();

	FWIW, looking at it, I'm not sure that "__agg_has_partner" is
the proper test for invididual-ness, but I'd have to do a bit of poking
to confirm that.  In any event, that's not what you want to change right
now.

	Instead of adding another block that does more or less the same
thing, I'd suggest updating this logic to include tests for C_D, C, or D
states, and enabling the ports if that is the case.  Probably something
like (I have not tested or compiled this at all):

	if (active) {
		if (!__agg_has_partner(active)) {
			[ ... the current !__agg_has_partner() stuff ]
		} else {
			for (port =3D active->lag_ports; port;
			     port =3D port->next_port_in_aggregator) {
				switch (port->sm_mux_state) {
				case AD_MUX_DISTRIBUTING:
				case AD_MUX_COLLECTING_DISTRIBUTING:
					ad_enable_collecting_distributing(port,
							update_slave_arr);
					port->ntt =3D true;
					break;
				case AD_MUX_COLLECTING:
					ad_enable_collecting(port);
					ad_disable_distributing(port, update_slave_arr);
					port->ntt =3D true;
					break;
				default:
					break;
		}


	Using the wrapper functions (instead of calling __enable_port,
et al, directly) enables logging for the transitions.

	-J



> 		/* Slave array needs update. */
> 		*update_slave_arr =3D true;
> 	}
>-- =

>2.35.3
>
>

