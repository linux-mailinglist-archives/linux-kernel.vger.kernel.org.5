Return-Path: <linux-kernel+bounces-126238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525289341E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE52AB22C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA70158A0B;
	Sun, 31 Mar 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3C158D62;
	Sun, 31 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903261; cv=fail; b=LMaTMWrhV42mFAZtlBRDT8KBNwPS/BjDPIJqRUm91Rr9JGScAHmka8f5iYiqJeFsdR1wZuNtxKH8RF56QMPyzRGjIFb7QHtzE3238QJKIty+TkL5HDY7fLktzNvr4No7Z6c8epxilBUPWl8To5BFA9uWeeAv2RBb9mragKwgkNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903261; c=relaxed/simple;
	bh=r/zJyrWXRNbsPJOoEMM9go2wb1kQMYvLI1npaqCdy0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSireG4+MMz0ysRChVAD+c4gQMSlgGWFTY1V9QpBxAjAil33Gyne4gxN9LwkZnFCdISoEkla/4+vqr+7T8p6vVo7I5CrT7033nZzPw2hyEYpUFErnTJSKDj26qOPHzSsh605uxHR42ZyyXYoHe5cYKRaldsiVuGQ43GrHlVrpIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.44; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CB6C6201E5;
	Sun, 31 Mar 2024 18:40:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ip2aUE9Y6LHX; Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 52892208CB;
	Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 52892208CB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4570380005E;
	Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:55 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:05 +0000
X-sender: <netdev+bounces-83533-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAWGQFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9849
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83533-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4679320520
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=WrQhQxRo6DfULhTj6TsCGB6LofQfoBuxDCt2D/TtQew1L1J8171bWygFIKyOoQr7jolBlWGKRWWQL6Mm1ZSXEpIyNFS9d8CikM9Ato82v4bA52dusuXprGdxVA3QyM9KyQrsK9krR8oRQ18Etl+x9HAcK2/rNyWlmgujRB9Pkcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=Z3V/da6Xz3DRp1xb2kWJvS4XMbNXnBs3jNIiApzfHCED05rvbFlBzMG46PmYth9sgO
         +SvEIZGIjOMJ4yHJTqFIvf9K4xFIfssfD8Fq5Ib8PzmyN8ahKgBdVbDKrM8Gzi9Ujp8H
         Yj55CnL6Uc/WHdSnI2bDfW28ZKFHjMFpJH+aanyiUtxtzf9OkFvm9Sm6GbQNlJccCz9+
         Pe7IczzArNBu+gADF538Ynxg9IWJQIvizj/AsaOSVma2Hgr+nB4CKFQXS25GD9flxh/U
         xN474rnGNVBCjAfhQoLXjz5PHQrmKoLdmYYD0OrxhiGUPy3FVvYv4fz/go1DY9HuJsaF
         DBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTrI+i6c4KpEmf2l6yQ2FBhPUFcqZKLVGzCKLZrjWBIbfBuFG2Pn9O2Q1s4+aZAxdvd0qmTRY2CJwUU9hbjJtoC4QlhNe
X-Gm-Message-State: AOJu0YyipnUvvoL4YBTQ3jANCs6RsHGG8mK0cx4Ss72Fj2Lhl6zkk2OV
	zQQain5LobUn1FL24TAHzy3J+rz3cROArg3/5CIXmctNs/UQ1R4czd/2Q27h+3o=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver = {
 	.driver = {
 		.name  = "sja1105",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table = sja1105_spi_ids,
-- 
2.34.1


X-sender: <netdev+bounces-83533-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAWWQFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9867
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:10:50 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sat, 30 Mar 2024 22:10:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 664D320883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:50 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=-5.051 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
	SPF_PASS=-0.001] autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=linaro.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmavyplIyy-Z for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:10:50 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83533-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A1F9520520
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A1F9520520
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E83283300
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F164E1D5;
	Sat, 30 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA82AF13
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=WrQhQxRo6DfULhTj6TsCGB6LofQfoBuxDCt2D/TtQew1L1J8171bWygFIKyOoQr7jolBlWGKRWWQL6Mm1ZSXEpIyNFS9d8CikM9Ato82v4bA52dusuXprGdxVA3QyM9KyQrsK9krR8oRQ18Etl+x9HAcK2/rNyWlmgujRB9Pkcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2153952f8f.3
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=Z3V/da6Xz3DRp1xb2kWJvS4XMbNXnBs3jNIiApzfHCED05rvbFlBzMG46PmYth9sgO
         +SvEIZGIjOMJ4yHJTqFIvf9K4xFIfssfD8Fq5Ib8PzmyN8ahKgBdVbDKrM8Gzi9Ujp8H
         Yj55CnL6Uc/WHdSnI2bDfW28ZKFHjMFpJH+aanyiUtxtzf9OkFvm9Sm6GbQNlJccCz9+
         Pe7IczzArNBu+gADF538Ynxg9IWJQIvizj/AsaOSVma2Hgr+nB4CKFQXS25GD9flxh/U
         xN474rnGNVBCjAfhQoLXjz5PHQrmKoLdmYYD0OrxhiGUPy3FVvYv4fz/go1DY9HuJsaF
         DBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTrI+i6c4KpEmf2l6yQ2FBhPUFcqZKLVGzCKLZrjWBIbfBuFG2Pn9O2Q1s4+aZAxdvd0qmTRY2CJwUU9hbjJtoC4QlhNe
X-Gm-Message-State: AOJu0YyipnUvvoL4YBTQ3jANCs6RsHGG8mK0cx4Ss72Fj2Lhl6zkk2OV
	zQQain5LobUn1FL24TAHzy3J+rz3cROArg3/5CIXmctNs/UQ1R4czd/2Q27h+3o=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: netdev+bounces-83533-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:10:50.4834
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: db0e16b5-1689-4885-1590-08dc50fde099
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.024|SMR=0.024(SMRPI=0.022(SMRPI-FrontendProxyAgent=0.022));2024-03-30T21:10:50.507Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 9293
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver = {
 	.driver = {
 		.name  = "sja1105",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table = sja1105_spi_ids,
-- 
2.34.1


X-sender: <linux-kernel+bounces-125887-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAXGQFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9886
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:11:04 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sat, 30 Mar 2024 22:11:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 15EDD20883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:11:04 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=-5.051 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
	SPF_PASS=-0.001] autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=linaro.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQlJW_h2trGg for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:11:03 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125887-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 53C5820520
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 53C5820520
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BCA2832BC
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C353379;
	Sat, 30 Mar 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C1DFC6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=B54a9I9KLm7YZF44WhNh/VUVKOFwt5wPPd4l6u6tmbGIqRbelrSguCLOhuu6SUJOJ5u6ne4hh7GYtNl9laZhpupbJrHNnNDdtDjFCkS0hsVM46JCZbAfv5YdzjMjVm39aNWlDgET1vCKJyH7lf9M8rgg6eWPSKmAb38oD4K9TP4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341e3682c78so1744688f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=LN6EukO7x/miFXgVzeYBWPBHF5MKaL0/k2usNgFo64rZ+FRZIQg4gENQFEslrLZU3B
         ZslJ2cup96D8c8UluDpZPJzJV64/fKhb9YpCEaDC3X0ZH74RD+lXJ/OTlqxbvDyz6cLc
         eVCqMvicLLr6WTcAxQQGsEBmAoX5nLlQHRzC0GluGPRf+qoCr4GUhpoh+39dGWc6vYQ8
         eRyNe5ifDeY4F/om3TpVDUuUWNYJc47Ttyb8oPqbePV5uPMtx59Mu8AIUHvGuv6J6SCL
         gl9SaszuWA1emQeHafmY4MZdh4AIx4mlRFljqScFOYNODFEtkrS8a+qtq4xcY0O97Hez
         2iUw==
X-Forwarded-Encrypted: i=1; AJvYcCXeykk8WUuo+zuaSq0RZqJlkKLk1Y8uoPTtm5QI278pmyQIKEBoiY2SRzd908hejYalPQRYHj33KLaZKdmOYUlKk9t1FFnsTockcry/
X-Gm-Message-State: AOJu0Yy9THjSYK62Bav46nhST3lX5lfWLL8OIAJIbAf6W6cj047LIyzC
	MLYQYXly+7uMuSNBatu187U8OsQvhNyalLY3RdW8EvhJr88VU2JCCHKEH2BSKfQ=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: linux-kernel+bounces-125887-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:11:04.1354
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 91acc90a-aaf7-41d3-3699-08dc50fde8bc
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.006|SMR=0.006(SMRPI=0.005(SMRPI-FrontendProxyAgent=0.005));2024-03-30T21:11:04.142Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 9314
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver = {
 	.driver = {
 		.name  = "sja1105",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table = sja1105_spi_ids,
-- 
2.34.1



