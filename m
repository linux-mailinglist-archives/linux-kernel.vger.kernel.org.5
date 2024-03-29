Return-Path: <linux-kernel+bounces-126218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C008933D8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C37B22836
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32649155A5D;
	Sun, 31 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8dykE3"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B9148FE6;
	Sun, 31 Mar 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903209; cv=fail; b=emk7zWNxs4GX6itnIrC8LDNaAt2b5heRu8lAaWe2gPmIBCwp8vq4vu6GHq5pgL+3e/VAMwP49vWb5k91GzB6eXkLMMbpD/hlTM1pnqBvpjsTytskAAmbcKwRIGDhp/+H3i2PhJWQiDl0+iXu9LGb0+o8ZB/UoCzDMeFFnRc0Pn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903209; c=relaxed/simple;
	bh=Aglw51ozxyL+Nb7NTU3G4Q3Be5+sgsyKhcNnpxXAUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gE8HaZviskBPtuDMW7Z+AUZOLH5SV6FTDxMHyenD57sqNikImghXw/LIBI20pLdXDPIWIdaQ5sTdLXqlTYpCkRH/oTDzfHwVMKEtac0iX5Rv+RTQO3Vc+3VVdieedtU+ZgA4QZAL6U8M4sqg5igL3f+MGqRGqquPJ26egVZihr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3 reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 56027208B7;
	Sun, 31 Mar 2024 18:40:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjt7Rfzb3QJz; Sun, 31 Mar 2024 18:40:04 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C674A208A2;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C674A208A2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B459A80004A;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:00 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83469-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAKkimlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAMEAAADMigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 8850
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83469-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DD01A20883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749319; cv=none; b=XVQFfHeE9c0xnyYx07Syowd5TeLXf3pto5rmG1SsHR7H+7AOzfy4pspo9LNKbgLlZFu9KQybTmplG3h69Cegz7JISgOhrER2TsLV7W3vzMOiXj2onDyVxSLJsB/Qki+wTDKdSxSYjsLsMCEiRZOGxrKZplOoqofXF/YJUuJMwiY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749319; c=relaxed/simple;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIQ99dvb6UMV/aWTov9pUyTkMiTogmsGmcvwczu67NkrjPWL8dg5sp9t1PCUVSj5xTeqZ7n4cIap9pbON1zNasJv3lQ0K72dJFPSLEOA5XhVLMjRS30kIGcFqD5niDdQ4EzDBrWDioiwpKdq1Sr9iUGnZUWvslbiA8ACObaUw1Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749319;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+8dykE3YQdY+53+8POC4U17NyrlajsaBHru/9ULCn8ZmHHgjv6YhubjUAVssnGn7
	 9gdfmdlrdeqSQsdEs+TqJXpADkQZZWLiOO7dIaOZAI7dbu8yKWvYHv6WrRT6ZFQrHx
	 D/I4ma82Tn/VN/p7+hO9u5INnF4+b8tIolpHEl+k6HT9IOMlPWENg0c8cYK4L74bN1
	 22isDn6kmwlgOHnzWF08arFawoiHlUdA+oSLOonYtrVg5dFp6q4KgleAb+oSYoBcyL
	 DbMiAYDpwjVwkCZeC4eL0eUpVpoM7rVsfxekupwlZuXqR+EUguXEzifK4bFgeg2yRW
	 Scvby6W1H5WyA==
Date: Fri, 29 Mar 2024 14:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
Message-ID: <20240329145517.7b46a15a@kernel.org>
In-Reply-To: <20240327054234.1906957-3-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-3-c-vankar@ti.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.

Is there a reason this is not part of the previous patch?

X-sender: <netdev+bounces-83469-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoANUimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 7224
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:56:21 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:56:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 76554208AC
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:56:21 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -3.099
X-Spam-Level:
X-Spam-Status: No, score=-3.099 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099, DKIM_SIGNED=0.1,
	DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MAILING_LIST_MULTI=-1,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=kernel.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id heU5X3KzshSJ for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 22:56:21 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83469-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ED91620883
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ED91620883
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C231F25113
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638413CC60;
	Fri, 29 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8dykE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AC28DCA;
	Fri, 29 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749319; cv=none; b=XVQFfHeE9c0xnyYx07Syowd5TeLXf3pto5rmG1SsHR7H+7AOzfy4pspo9LNKbgLlZFu9KQybTmplG3h69Cegz7JISgOhrER2TsLV7W3vzMOiXj2onDyVxSLJsB/Qki+wTDKdSxSYjsLsMCEiRZOGxrKZplOoqofXF/YJUuJMwiY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749319; c=relaxed/simple;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIQ99dvb6UMV/aWTov9pUyTkMiTogmsGmcvwczu67NkrjPWL8dg5sp9t1PCUVSj5xTeqZ7n4cIap9pbON1zNasJv3lQ0K72dJFPSLEOA5XhVLMjRS30kIGcFqD5niDdQ4EzDBrWDioiwpKdq1Sr9iUGnZUWvslbiA8ACObaUw1Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F4C433C7;
	Fri, 29 Mar 2024 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749319;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+8dykE3YQdY+53+8POC4U17NyrlajsaBHru/9ULCn8ZmHHgjv6YhubjUAVssnGn7
	 9gdfmdlrdeqSQsdEs+TqJXpADkQZZWLiOO7dIaOZAI7dbu8yKWvYHv6WrRT6ZFQrHx
	 D/I4ma82Tn/VN/p7+hO9u5INnF4+b8tIolpHEl+k6HT9IOMlPWENg0c8cYK4L74bN1
	 22isDn6kmwlgOHnzWF08arFawoiHlUdA+oSLOonYtrVg5dFp6q4KgleAb+oSYoBcyL
	 DbMiAYDpwjVwkCZeC4eL0eUpVpoM7rVsfxekupwlZuXqR+EUguXEzifK4bFgeg2yRW
	 Scvby6W1H5WyA==
Date: Fri, 29 Mar 2024 14:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
Message-ID: <20240329145517.7b46a15a@kernel.org>
In-Reply-To: <20240327054234.1906957-3-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-3-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83469-peter.schumann=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:56:21.4987
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: aa7cbb0f-675a-402f-5799-08dc503b11ff
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.023|SMR=0.023(SMRPI=0.021(SMRPI-FrontendProxyAgent=0.020));2024-03-29T21:56:21.522Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 6678
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.

Is there a reason this is not part of the previous patch?


