Return-Path: <linux-kernel+bounces-82420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F68683FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104C91C23E69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1B135A5C;
	Mon, 26 Feb 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CFK+xaIU"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533613541B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987644; cv=none; b=HCJevJF8VJnRgZMIqL6HQstiAhsyVDanya6MrWCrUwhg95re6rmhbevQRURfcXC33rRBie/PJ768x20WDwN3JQVnSYPtGKdcqpO73zUza9wGDwJAKw3f63eWgvmnsxtLOcRVwlAdtDrrkuraS0QIR3qNdIfGoQphzMnAq6Af8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987644; c=relaxed/simple;
	bh=6S2iaa1ziWP/+AZL5PVpvzk6dQnjcMLBdQBD+N8qB+8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=lqMapeXG8nLLAkVMzamWd1RQ5beYvAO5DrD8c5h/WsNkepUYliQu1BmDjSbC+lGZg98ROtXZBSgBWAwlQGOyXvjMWvNAMxuBBWhnIbxs0/Kn0nmRPbrQgwbxFQkwN9UaYnnme5etHTAk82UVVO7V+tgGvpf1DKtgJ2HD7wyzQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CFK+xaIU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E52BD40DB8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708987622;
	bh=gr+WKKnlHjOQT4Ki8d0xTGUPBtTeKxzlDsfRKLcxP1U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=CFK+xaIUPcUVSrnbVbdF3m479yeP54jHtemC76LrpmDLsFUidpJRXa4CAtDyvVgQO
	 1B3nED1s88jiiCnKtMPwMufPaO5tAemgUC7DJhEt8OmYx2XnJ5zAKDUfsMC86ug++z
	 AHJbEVBqCF/2zdIduVE5d00frrvVpaOCyeT82wYB08X0+POSvzoZn97LzykTw6naT3
	 FmMSdVP+pGa19bJNgvDdRxcUBtC79xuaU6/P78XUOeLtepyggDpVBQqHd1UDA3zkv8
	 UrQ8qZgub8P2VdUKJ1/Vdv4kdtkCO7ACgJ7C1BKvIW2Ii0AIjc/GJ8GC/PEwfnNitW
	 TAJgMS3KVsMJQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29a90e49c67so2001779a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987621; x=1709592421;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gr+WKKnlHjOQT4Ki8d0xTGUPBtTeKxzlDsfRKLcxP1U=;
        b=mfIw6Y9giFdqH5NCWKY74mMtYoosFT6ZNT3jgzrY1pwZLrRBDe9Yp2IaUD1I8HspWq
         O+ZYhV5aIHtEBVTjtD4/eUBcepeNLNnz+1G8lGo5kh90a7w7nD5534OlmcIodFrQz9zH
         yyYqo1przJ5mVNp1rE5wGKwnpkIYXavHvhxSysIe7MdxHvrrU5QPCVow8e/Bj53Wp8/p
         R3ZZet1dSdVe0C/pN5aFKOhx8Ez3ln7VvYeXbRAHQtWia0tfZG665d4QWojOttVzNNjD
         Oq4fI9BWo+d8mnpj4HnDrFV9jil5iSL6XrpIMq+w8XQTqsg3RCkZLRwq3LQXVPJXadEt
         KQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkxQpXu9VIY/Q8jvLKtYMFS4i2gLm/k1KMD+SVVSWaUV5mC/fUYp9+b7pAnPMKeH/c88gQ4LxhhH4QVtm1OrxgcTGQ4bn7PI1u9I+J
X-Gm-Message-State: AOJu0YwahKGk5MZYnXyCr7J10uz8cY1FMYKFKw4q4XySTeviS56t1D9+
	qh/pSul1mv24lWZ9zguzUjZUFtL0x2VKxogUQOCjbyTHjEAGRVIHtTAjVqyC37aalkSBvIHgBJq
	OWj6L68erVxkqZhQPCQESsZ56jXV8UxHTpmVmkCqX5uLBQ8dnZIt79yxcOzgC1Q1epq/t3tUerm
	Szcw==
X-Received: by 2002:a17:90a:1210:b0:29a:adb5:b045 with SMTP id f16-20020a17090a121000b0029aadb5b045mr4473993pja.9.1708987621430;
        Mon, 26 Feb 2024 14:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfO8b7Km0xOTYWEQV0dBP+d4tg1/74p4NInrzrufP6TwLpfyBM1I5NvyZZu8SzCRkTtprVwA==
X-Received: by 2002:a17:90a:1210:b0:29a:adb5:b045 with SMTP id f16-20020a17090a121000b0029aadb5b045mr4473974pja.9.1708987621028;
        Mon, 26 Feb 2024 14:47:01 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b0029a75101532sm4909195pjr.50.2024.02.26.14.47.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:47:00 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 34BF0604B6; Mon, 26 Feb 2024 14:47:00 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2EF979FAAA;
	Mon, 26 Feb 2024 14:47:00 -0800 (PST)
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
Date: Mon, 26 Feb 2024 14:47:00 -0800
Message-ID: <16063.1708987620@famine>

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

	Ok, I missed this bit when I read the patch this morning, so you
can ignore my earlier email's question.  Patch looks good to me, glad to
see null_mac_addr get the boot.

>Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
>all references to it are gone.
>
>Signed-off-by: Jones Syue <jonessyue@qnap.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

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

