Return-Path: <linux-kernel+bounces-93858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C228735E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0402C1C21EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BE27FBBF;
	Wed,  6 Mar 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="PW6PppIz"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830484C6E;
	Wed,  6 Mar 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726086; cv=none; b=swYnCrZjUKPZE4g3YwiG7kIHymrQc2TzyfA952/I694JC4i70LRB/FHRoDA++wNYNWnGWUfeEQ2HBrn5G3aPzhZVhtfft7tzdpjbIoZbE94ep/JK5iv+tCBZ/EhiPIb6iKhGYaRbzAhdHZV/PRSk4iWRI4nmpSSSwHhQfNxk6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726086; c=relaxed/simple;
	bh=5qaSKPwwlU43YitcA8WvPLxxCip9CdLarnd5qIbTfZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rC0mUIaQ1wA3N1jDwdTvWtirGUq1reGOppLNLEBOL2odD4BFieUCZWcO18i1nIiF2eOK+L5L5QJZ6J/+KljKvaXsNX1xG533cmADykoe2eLXo4U/mwHz49QH2EeSeUF/aVQW5Km5xDh2tbm9zbcb+frmhk2lds01+/pN8/9mSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=PW6PppIz; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 298D4144D6E2;
	Wed,  6 Mar 2024 14:54:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 298D4144D6E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709726081; bh=5qaSKPwwlU43YitcA8WvPLxxCip9CdLarnd5qIbTfZQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PW6PppIzlgL1hUBIZgPHA0kku5a2aKK+IgjRyHFl0kR44xXE6pQrMeLZ+kfo7bNHS
	 CaZByLnfhwhfzTpnULUHM+XHxDGLM4B3gX0n0jfP53AjYAem86mDVMo2bUpyUhTYc5
	 YpnrhACUx+FttfwJ/OKj+aOy5UZSY8mVIg1MN9AM=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 2746D31900FC;
	Wed,  6 Mar 2024 14:54:41 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Topic: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Index: AQHab70S18MNsTZpK0u/u8cQHIg1Dg==
Date: Wed, 6 Mar 2024 11:54:40 +0000
Message-ID: <e8b2287f-bf25-4a95-aef2-58067c893b4f@infotecs.ru>
References: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru>
 <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
In-Reply-To: <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <4409D5C8B8D2B74EBCE8E73A5CCB8C78@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/06 10:26:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/06 07:15:00 #24010220
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMy82LzI0IDE0OjM2LCBQYW9sbyBBYmVuaSB3cm90ZToNCj4gVGhlIGFib3ZlIGlzIGluY29y
cmVjdCwgYXMgdGhlICdsZW4nIHZhcmlhYmxlIGlzIGEgc2lnbmVkIGludGVnZXINCg0KSSBtZWFu
LCBpZiAnbGVuJyBpcyBuZWdhdGl2ZSB0aGVuIGFmdGVyIHRoaXMgZXhwcmVzc2lvbg0KbGVuID0g
bWluX3QodW5zaWduZWQgaW50LCBsZW4sIHNpemVvZihpbnQpKTsNCnRoZSAnbGVuJyB2YXJpYWJs
ZSB3aWxsIGJlIGVxdWFsIHRvIHNpemVvZihpbnQpID09IDQNCmFuZCB0aGUgc3RhdGVtZW50DQpp
ZiAobGVuIDwgMCkgcmV0dXJuIC1FSU5WQUw7DQptaWdodCBiZSB1bnJlYWNoYWJsZSBkdXJpbmcg
cHJvZ3JhbSBleGVjdXRpb24uDQo=

