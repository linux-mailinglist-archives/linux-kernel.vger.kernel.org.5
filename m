Return-Path: <linux-kernel+bounces-82095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4F867F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B7A1F2EDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEE612DDA8;
	Mon, 26 Feb 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PJoocdLE"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041E12B167
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969664; cv=none; b=Yka37Y+qCr7K4ScZThOiAiR4bfdQGJWrixZukCf6BvKXHk6zUocCCrndjMMbgPjjswK1wEGT34HfldcR0B/5JnSvwmMoOgW7FjyrAA1ho5sIqF51NUXCiezzfhPY0xSXGy+aYhxKEO7rz5GsaDTDr1PeRIdwRmAHQ6/9AXF4c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969664; c=relaxed/simple;
	bh=4wcegm+FrHnOWAQeGINRXP3mpmA+GrZM/54FU/bpXa4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ivFvyQUGjxvAVgYZ2Ufd3AEGcwQJyEBAgmETEvpZl7h9VmYUe60nR6u/xAZomAYovWJVdM9OvsKaN7IpZTSfSDcmItpYBW1XqMcDZBwphfFyWGBI7L5CxUWkHczXyO0wUBSsMhrW/GicrPhW4yQ9/lYChyIYBcKwG6fp1S099xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PJoocdLE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9DDD43FB72
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708969590;
	bh=qlG1XXfMSTJgylXzlZx6s+GnEuZ5LCkwrjatFG2+AN0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=PJoocdLEYnTS3N5qe1haJgwwypCwDAWQo6Ys3FdAew1Agtv0yOpIQtfDVrfWgFxJs
	 l2iPBrtvufhf22G0bgXYML6vbl4ZzNPIDvz1bAFc5Z4YB/NI6phNoGyAhj7D6Pw0ne
	 Exm7KCJVw4uVPEMRVt40OIBMzGN4oA502EP1fzlmsMa2IsdcrKrUNwjQhW8Gmz49Dk
	 R6i4Wnv/88EN9gaXHOlZOlbwQodKwoeov81wUte4+laaljzOLmQlDP1imAeDaxhL+7
	 eIJo36D1RRgCX5P7prDBzKVMFcsZBqttZumBfUK8mBvLdHayCnCaIqHvq6cqg4svOr
	 SzbfGPWBqspTg==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e54421b20eso229506b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969516; x=1709574316;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlG1XXfMSTJgylXzlZx6s+GnEuZ5LCkwrjatFG2+AN0=;
        b=klqYoVmXdhGHcSUkl6wp1TTNG6dLIXR9Ifz5tLQvhA9k7iqAQQ93ZaVMJI8py3m3CT
         HHSEv0+gRG5q/ZGaklTSGYSJ3ClsU9iRaR8Fn3p6QzosfZBIfRdZ/4tBaEBvQtHJiNpM
         Fx1IYJTr0bfKrSrvPpVQdSLk7pEZLKDdHDr7EFoy/dsecELOOKRChpz2w39ULwY5LfkZ
         tmwUckEZZ41r6lor+ubPjSfyfFxM7wXYC8TIPl2o2SgDXw9y/xw/G6DBx2uDETfdMTsU
         awH7I79sK1u8bAz11Lkr9NuKNKPGurB4Lyocybv2QmcXd7uY7/Dt8r6vjxLZwyxzIGbS
         ea6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+m4pHNvqC6jnq9tNgy0fC8FZ8EJdg7J3npLLfeBHEESqviHVgt0noLeSxPkzsRjScKfRJnZKgGhF6AZ+YtP5ULzDwhp4/trEmfWLa
X-Gm-Message-State: AOJu0YwjODewiSAGZoDtN89Bqnj3fHwLpK+u8wkdnmtHuCIEodqXpp1X
	uyO7aofnXi44qgvC5OpsMIAJzU3Rd4f5rQFvR/SsM+bTLDeTxI6F5nHdOvtABxrxGKs8oI3c3bp
	9N225X9OMYdOeWdE42+E5fhM+/o2hQQxN4l7g2X/FlbDVKElMrsfIoxyESeF/HUikFDgEbXHM8z
	6gcA==
X-Received: by 2002:a05:6a20:93a6:b0:1a0:e4ac:9c7a with SMTP id x38-20020a056a2093a600b001a0e4ac9c7amr8729907pzh.1.1708969516013;
        Mon, 26 Feb 2024 09:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwrH70fY1lfDhaL/wJvKiyVY14zTHKwXoKQrun8J7qB0UIM8KzO1Ma3oQtc6YCvbaQNxkCvA==
X-Received: by 2002:a05:6a20:93a6:b0:1a0:e4ac:9c7a with SMTP id x38-20020a056a2093a600b001a0e4ac9c7amr8729891pzh.1.1708969515647;
        Mon, 26 Feb 2024 09:45:15 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006e50c083b90sm2817375pfu.212.2024.02.26.09.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:45:15 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C3BDF604B6; Mon, 26 Feb 2024 09:45:14 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id BB48C9FAAA;
	Mon, 26 Feb 2024 09:45:14 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: =?us-ascii?Q?=3D=3Fiso-2022-jp=3FB=3FSm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI?= =?us-ascii?Q?=3D=3F=3D?= <jonessyue@qnap.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "andy@greyhouse.net" <andy@greyhouse.net>,
    "davem@davemloft.net" <davem@davemloft.net>,
    "edumazet@google.com" <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "pabeni@redhat.com" <pabeni@redhat.com>,
    "corbet@lwn.net" <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with __agg_has_partner
In-reply-to: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
References: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
Comments: In-reply-to =?us-ascii?Q?=3D=3Fiso-2022-jp=3FB=3FSm9uZXMgU3l1ZSA?=
 =?us-ascii?Q?bJEJpLVhnPSEbKEI=3D=3F=3D?= <jonessyue@qnap.com>
   message dated "Mon, 26 Feb 2024 02:24:52 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2024 09:45:14 -0800
Message-ID: <29939.1708969514@famine>

Jones Syue =E8=96=9B=E6=87=B7=E5=AE=97 <jonessyue@qnap.com> wrote:

>Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline
>function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying
>aggregator's partner mac addr with null_mac_addr, means that seeing if
>aggregator has a valid partner or not. Using __agg_has_partner() makes it
>more clear to understand.
>
>In ad_port_selection_logic(), since aggregator->partner_system and
>port->partner_oper.system has been compared first as a prerequisite, it is
>safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking
>with __agg_has_partner().
>
>Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
>all references to it are gone.
>
>Signed-off-by: Jones Syue <jonessyue@qnap.com>
>---
>v3:
>  - replace macro with inline function in ad_port_selection_logic()
>  - delete static variable null_mac_addr in bond_3ad.c
>  - re-phrase patch description with more precise text
>  - re-phrase patch description in imperative mood
>v2: https://lore.kernel.org/netdev/SI2PR04MB5097AA23EE6799B3E56C0762DC552@=
SI2PR04MB5097.apcprd04.prod.outlook.com/
>  - add correct CC list by 'get_maintainer.pl -f .../bonding.rst'
>v1: https://lore.kernel.org/netdev/SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@=
SI2PR04MB5097.apcprd04.prod.outlook.com/
>---
> drivers/net/bonding/bond_3ad.c | 14 +++-----------
> 1 file changed, 3 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad=
c
>index f2942e8c6c91..c6807e473ab7 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -82,10 +82,6 @@ enum ad_link_speed_type {
> #define MAC_ADDRESS_EQUAL(A, B)	\
> 	ether_addr_equal_64bits((const u8 *)A, (const u8 *)B)
>=20
>-static const u8 null_mac_addr[ETH_ALEN + 2] __long_aligned =3D {
>-	0, 0, 0, 0, 0, 0
>-};
>-
> static const u16 ad_ticks_per_sec =3D 1000 / AD_TIMER_INTERVAL;
> static const int ad_delta_in_ticks =3D (AD_TIMER_INTERVAL * HZ) / 1000;
>=20
>@@ -1588,7 +1584,7 @@ static void ad_port_selection_logic(struct port *por=
t, bool *update_slave_arr)
> 		     (aggregator->partner_system_priority =3D=3D port->partner_oper.sys=
tem_priority) &&
> 		     (aggregator->partner_oper_aggregator_key =3D=3D port->partner_oper=
key)
> 		    ) &&
>-		    ((!MAC_ADDRESS_EQUAL(&(port->partner_oper.system), &(null_mac_addr)=
) && /* partner answers */
>+		    ((__agg_has_partner(aggregator) && /* partner answers */

	I'm not sure this is an equivalent swap, as it is replacing a
test for non-empty of the port's partner MAC with a test of the
aggregator's partner MAC.

	In the port case, it is validating that this specific port has
received a response from its link partner.

	In the aggregator case, it's checking that the aggregator as a
whole has received response from the link partners of members of the
aggregator, which does not include the port under consideration for
inclusion into the aggregator.

	As the port is not yet a member of the aggregator, how is
checking the aggregator's MAC for being non-empty an equivalent test to
the one it replaces?

	-J

> 		      !aggregator->is_individual)  /* but is not individual OR */
> 		    )
> 		   ) {
>@@ -2036,9 +2032,7 @@ static void ad_enable_collecting(struct port *port)
>  */
> static void ad_disable_distributing(struct port *port, bool *update_slave=
_arr)
> {
>-	if (port->aggregator &&
>-	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
>-			       &(null_mac_addr))) {
>+	if (port->aggregator && __agg_has_partner(port->aggregator)) {
> 		slave_dbg(port->slave->bond->dev, port->slave->dev,
> 			  "Disabling distributing on port %d (LAG %d)\n",
> 			  port->actor_port_number,
>@@ -2078,9 +2072,7 @@ static void ad_enable_collecting_distributing(struct=
 port *port,
> static void ad_disable_collecting_distributing(struct port *port,
> 					       bool *update_slave_arr)
> {
>-	if (port->aggregator &&
>-	    !MAC_ADDRESS_EQUAL(&(port->aggregator->partner_system),
>-			       &(null_mac_addr))) {
>+	if (port->aggregator && __agg_has_partner(port->aggregator)) {
> 		slave_dbg(port->slave->bond->dev, port->slave->dev,
> 			  "Disabling port %d (LAG %d)\n",
> 			  port->actor_port_number,
>--=20
>2.1.4
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

