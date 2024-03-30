Return-Path: <linux-kernel+bounces-126146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B68932CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147FF1C20AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594714600A;
	Sun, 31 Mar 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2tp6sQa"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9B146000;
	Sun, 31 Mar 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902380; cv=fail; b=H6T7oT9V76GBIqIpSjDXFa0SbdKY27rcLSEr1UMeXJYhAhHfu4hNedingZxFJoMg3+T7AgsR/jGpBHzku58VCh6M75EYvmIzlAaZj2ruNPg2f8WgKPXLXE1aACiZ6azwQSGPUV+bcDqqiYwa3Usy62DaJ4JyCueiFHE/mfSVQpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902380; c=relaxed/simple;
	bh=8S7GlK29NB9SItzdrNDqBufqekgEpMd3kpeb0UktTfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F59HM5jBlZZQ/tXtsszyDfpOl8O2omw9gS4esmUaYTW52T4vctyHWvo4I4L4XxNsBdY18LympODN4ZSKmF/F6FLycqsirAg7vep8khDXn+3jfO3rs3o1T9lWZqF7e21hh3DSz/6tXfje9U/TAmqNeAtZyRpneJCJpXZWv1TZ20w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=fail (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2tp6sQa reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.133; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2DEC92084C;
	Sun, 31 Mar 2024 18:26:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F85MJJb9DxuO; Sun, 31 Mar 2024 18:26:14 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D836E207C6;
	Sun, 31 Mar 2024 18:26:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D836E207C6
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id CB2D380004E;
	Sun, 31 Mar 2024 18:26:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:51 +0000
X-sender: <netdev+bounces-83514-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoABdvp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgA0AAAAnooAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13893
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83514-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 524E72084C
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815653; cv=none; b=mS6rVh5T/lZGK8wYPPxiInu59YJakJ7q1MXTMZzo+xYZwJGtSraU8JC5CpDXqofLK+Yp6Vt37MZIksZ4m3e1uACyQEnWLLtAT42lQXIqiaWAts8ZHDF3wNH6RRyLaSFLqHUPp5VjK6ZtJszYL/DUBgOMRVfEY5vozRoc0kwNnmg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815653; c=relaxed/simple;
	bh=JNC8qozkgWlE+Q6kdtHfr0XlvCkJCAqLu0MAE1TEAq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+WrL2f7eXA8QKozheTgtynh9tR1Mkhmu0+yvSb/Waw66WKvAnc6YogIpWcM2U7GOSLy5Zn2f9hWYhwc0eQp2nA3c6dARB4QsGQuBesijf+qVWtaWiw5AfCQf3A1pP6jGz+TFDZYo4VIzWrvKRIyD+NoxFUtE6EHzLeocwsMVw4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2tp6sQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cDTgdTBVRUAZH0p6pwQw4KmwuQ/wNotFO0UsYy13RVs=; b=Y2tp6sQaaVk+sBrRRF0N2ANzw+
	DJpIXWD4/mDjC2onipuC4uQQKeMs9aRsg/HT1VDwSIKGc3eP+vcLSjAkEbNMPmxTFdVHs6lWfg7Gw
	MRd9D7hy/FJ+Fu6galftDA1RcyU74rR0nEHQh8Q4Cxw6xr3YPPMLQOXe5cjp/5oS3B9U2a8qsTQYh
	/hPhHfrFJzmqDas7HWCJG9CrAVgTtD/r+gVTNc9TggRnbyE2zKQl5LZKhL3JxZMjhuQXGolftCOkc
	NuOgeZu/HfHF4oCfUz6DmYc0A3cejB9ptDTqCWReNGWxbCCDxIVLAhruxGaoU9AB6p90lRi48gqLZ
	zMJ8rFMw==;
Message-ID: <1c69304c-abaf-46e4-b58d-a4f9b30a8f5f@infradead.org>
Date: Sat, 30 Mar 2024 09:20:45 -0700
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
 <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10



On 3/29/24 13:27, Jeff Johnson wrote:
> While fixing kernel-doc issues it was discovered that the
> ieee80211_set_hw_80211_encap() prototype doesn't actually have an
> implementation, so remove it.
>=20
> Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
> rework tx encapsulation offload API").
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/net/mac80211.h | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 353488ab94a2..e6a11a982ca8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw =
*hw,
>  u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>  			      struct ieee80211_tx_info *info,
>  			      int len);
> -/**
> - * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloadi=
ng.
> - *
> - * This function is used to notify mac80211 that a vif can be passed raw=
 802.3
> - * frames. The driver needs to then handle the 802.11 encapsulation insi=
de the
> - * hardware or firmware.
> - *
> - * @vif: &struct ieee80211_vif pointer from the add_interface callback.
> - * @enable: indicate if the feature should be turned on or off
> - */
> -bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable=
);
> -
>  /**
>   * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
>   * @hw: pointer obtained from ieee80211_alloc_hw().
>=20

--=20
#Randy

X-sender: <linux-kernel+bounces-125778-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoABdvp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgA2AAAAnooAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13979
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 17:21:18 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 17:21:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 16FB320322
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 17:21:18 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dinfradead.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7ounvpW89vG for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 17:21:17 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125778-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 3D5952025D
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dinfradead.org header.i=3D@infradead.=
org header.b=3D"Y2tp6sQa"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 3D5952025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA928368F
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79F3D984;
	Sat, 30 Mar 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dinfradead.org header.i=3D@infradead.=
org header.b=3D"Y2tp6sQa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.=
133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DDEAC6;
	Sat, 30 Mar 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D198.137.202.133
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711815653; cv=3Dnone; b=3DmS6rVh5T/lZGK8wYPPxiInu59YJakJ7q1MXTMZzo+xY=
ZwJGtSraU8JC5CpDXqofLK+Yp6Vt37MZIksZ4m3e1uACyQEnWLLtAT42lQXIqiaWAts8ZHDF3wN=
H6RRyLaSFLqHUPp5VjK6ZtJszYL/DUBgOMRVfEY5vozRoc0kwNnmg=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711815653; c=3Drelaxed/simple;
	bh=3DJNC8qozkgWlE+Q6kdtHfr0XlvCkJCAqLu0MAE1TEAq8=3D;
	h=3DMessage-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=3Dm+WrL2f7eXA8QKozheTgtynh9tR1Mkhmu0+yvSb/Waw=
66WKvAnc6YogIpWcM2U7GOSLy5Zn2f9hWYhwc0eQp2nA3c6dARB4QsGQuBesijf+qVWtaWiw5Af=
CQf3A1pP6jGz+TFDZYo4VIzWrvKRIyD+NoxFUtE6EHzLeocwsMVw4=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dnone (=
p=3Dnone dis=3Dnone) header.from=3Dinfradead.org; spf=3Dnone smtp.mailfrom=
=3Dinfradead.org; dkim=3Dpass (2048-bit key) header.d=3Dinfradead.org heade=
r.i=3D@infradead.org header.b=3DY2tp6sQa; arc=3Dnone smtp.client-ip=3D198.1=
37.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dnone (p=3Dnone di=
s=3Dnone) header.from=3Dinfradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dnone smtp.mailfrom=
=3Dinfradead.org
DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxed;
	d=3Dinfradead.org; s=3Dbombadil.20210309; h=3DContent-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3DcDTgdTBVRUAZH0p6pwQw4KmwuQ/wNotFO0UsYy13RVs=3D; b=3DY2tp6sQaaVk+sBrRR=
F0N2ANzw+
	DJpIXWD4/mDjC2onipuC4uQQKeMs9aRsg/HT1VDwSIKGc3eP+vcLSjAkEbNMPmxTFdVHs6lWfg=
7Gw
	MRd9D7hy/FJ+Fu6galftDA1RcyU74rR0nEHQh8Q4Cxw6xr3YPPMLQOXe5cjp/5oS3B9U2a8qsT=
QYh
	/hPhHfrFJzmqDas7HWCJG9CrAVgTtD/r+gVTNc9TggRnbyE2zKQl5LZKhL3JxZMjhuQXGolftC=
Okc
	NuOgeZu/HfHF4oCfUz6DmYc0A3cejB9ptDTqCWReNGWxbCCDxIVLAhruxGaoU9AB6p90lRi48g=
qLZ
	zMJ8rFMw=3D=3D;
Received: from [50.53.2.121] (helo=3D[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqbRm-00000003mZz-0NbX;
	Sat, 30 Mar 2024 16:20:46 +0000
Message-ID: <1c69304c-abaf-46e4-b58d-a4f9b30a8f5f@infradead.org>
Date: Sat, 30 Mar 2024 09:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_enca=
p()
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com=
>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
 <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125778-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 16:21:18.1289
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 3ba90035-25e3-4e23-285a-08dc=
50d56dde
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.410|SMR=3D0.349(SMRDE=3D0.036|SMRC=3D0.31=
3(SMRCL=3D0.101|X-SMRCR=3D0.313))|CAT=3D0.059(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.022(CATRESLP2R=3D0.019)|CATORES=3D0.023
 (CATRS=3D0.023(CATRS-Index Routing Agent=3D0.022)));2024-03-30T16:21:18.57=
1Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8603
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.031|SMR=3D0.008(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.024
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAacEAAAPAAADH4sIAAAAAAAEAI1UbW8a=
RxCe4w44zsZ5af
 0hVStNE7W1MRzmJTamkUWlqlWiqq2SSP2Ilrs9buNjl94dxkj9y/0P
 nd0DYhLHqWUdO7PPPPO68+9+3at7f0jstbsX7W4fO71h97yJr3gU4S
 sVy0xJXKYq58O6d4l/xSLhGIkbIad4xVPJk1aoAhRZtuAZihyXLMNQ
 ZIG65ikPMY9ZTh+ujQXnfHDa7XTGGc/H8XJcCFwGbH50jHPyovLVnG
 OoeCZ/yJEF+YIlyQpjds2RSUMymyd8xmXOcqFkEzOFKZ+RN3LuE0Bj
 fqdwtdMPwCa2dMYJHKKQOGd5EOMZ46x7FvDnrB/g0dMZC0xYJt2UL1
 V6hfkNmiCzRVIQqShKFAvxpz9fPj3eeH0jppKHLbprTVbD3Qq++Hsh
 gvG7d4U40pKQgR+o2aWu/2t+LfiSjLXhaybDFf68kAmb44s0NIeRkF
 HKQs5CX6VTY/Q2ZvIq8/XxElutlv6htIJkEfK25Hl7k4of4z/Y6WrM
 9s+AO9RJamdARFMeNjUm5AnXKWZHreN1XqGgRFqtKTWXtT/BP/nEhe
 mYDPkN9p73+oMBm1z0Wdf3+RnrdNjFoBuwAXZOT8/6/XUWn/Sh709O
 Tu51NRph67x/Pmh2BnhiDmdat+h1bw1fwJJgnN6MmUhzMeNHWZ4ugv
 wWIF5iI142TYnuMM3/p+k9fx/ZESc1WGFDfz9rLmSOCZfHP5qatRsN
 84uNe18YAbhkE+p3zNJwyVJ+91DTy/bXfBvat7HIMFrIwODovMj001
 YoVS6iFW6aULx2htciwoBJnHB6Y5nGpmyJBPF7G0oa5hnPfKKm554K
 WhYoOQ8zzUovV1KQMkyKV6wNiXw3WiEzEfLNatGU27RUSnOdzvT5w0
 xGFNoQv/+o/jriuaK6UhxRqmbGLwvDsVFFLKBXQptowoIrf8tVlHOo
 B1wEjFYOkWi7iLN8QXFksVokoa4CibQaUBc51XVeU7TN70Sp5P7deG
 e4Dfo00RgXgazHwQzPeiZwZyamxEwPPhtv9vNqnNOCpEh+5Tn+8vK3
 N9vNvcKc0xUl5W94RvFyuK2RmuRM6JRMsd67oBqpgMI/Wm/FuqdXzT
 Oz0rQETglsy4Jq8Q8lEkuWXQYoQ9WBchXcMnhlqFSgWrHAg6oNDp0J
 RgcP9ghjQ7VmwdfgkWZjWymDWwOPzF2oEaYElQN4SFbG1jNWzgE8oC
 9hSE8m+/DAhXpBXocD0tskWlA3TkvgmHhqjgVPoEy0BuC6FuxBjW5N
 kC5lcWhc01UFDg3GIbBlEQOUrC8tAAtKmsqqaQ3YNfjCMS5I/x5P2B
 2xbCI82LcoQqjAwe5tbUe0XF0Eq2I82sXZ+NVZ13T8nqmJXdVB6urt
 g1fSObqfAzwrxEdatB2oOPAdmdhweGcLCEzxUDE9+MoxRTNW5aIRRW
 socsPgFErbcow5pekWvSaqwqq4NelXiVOLsFdwuvDENkNS0/3yirYW
 Xba1xqGOuPC4YuahGJ4itc1I2Eb5kEzuSuQ2M3GWTTDfkOZbg9RWum
 LV7Zl8lYyLIkdCPjZjXIJH5f8AG1YsPGMJAAABCtkCPD94bWwgdmVy
 c2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8RW1haWxTZX
 Q+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1h
 aWxzPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSIzNTgiPg0KICAgIC
 AgPEVtYWlsU3RyaW5nPnF1aWNfampvaG5zb25AcXVpY2luYy5jb208
 L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjQxNSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQog
 ICAgICA8RW1haWxTdHJpbmc+cmR1bmxhcEBpbmZyYWRlYWQub3JnPC
 9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4N
 CjwvRW1haWxTZXQ+AQytBzw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2
 Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJzaW9u
 PjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogICAgPE
 NvbnRhY3QgU3RhcnRJbmRleD0iMzQ0Ij4NCiAgICAgIDxQZXJzb24g
 U3RhcnRJbmRleD0iMzQ0Ij4NCiAgICAgICAgPFBlcnNvblN0cmluZz
 5KZWZmIEpvaG5zb248L1BlcnNvblN0cmluZz4NCiAgICAgIDwvUGVy
 c29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIFN0YX
 J0SW5kZXg9IjM1OCI+DQogICAgICAgICAgPEVtYWlsU3RyaW5nPnF1
 aWNfampvaG5zb25AcXVpY2luYy5jb208L0VtYWlsU3RyaW5nPg0KIC
 AgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8
 Q29udGFjdFN0cmluZz5KZWZmIEpvaG5zb24gJmx0O3F1aWNfampvaG
 5zb25AcXVpY2luYy5jb208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9D
 b250YWN0Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjQwMSIgUG
 9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8UGVyc29uIFN0YXJ0
 SW5kZXg9IjQwMSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgIC
 AgIDxQZXJzb25TdHJpbmc+UmFuZHkgRHVubGFwPC9QZXJzb25TdHJp
 bmc+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogIC
 AgICAgIDxFbWFpbCBTdGFydEluZGV4PSI0MTUiIFBvc2l0aW9uPSJT
 aWduYXR1cmUiPg0KICAgICAgICAgIDxFbWFpbFN0cmluZz5yZHVubG
 FwQGluZnJhZGVhZC5vcmc8L0VtYWlsU3RyaW5nPg0KICAgICAgICA8
 L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8Q29udGFjdF
 N0cmluZz5SYW5keSBEdW5sYXAgJmx0O3JkdW5sYXBAaW5mcmFkZWFk
 Lm9yZzwvQ29udGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogID
 wvQ29udGFjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJpZXZlck9w
 ZXJhdG9yLDEwLDA7UmV0cmlldmVyT3BlcmF0b3IsMTEsMDtQb3N0RG
 9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0
 b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3
 IsMTAsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3Is
 MTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwxMw=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 2707
X-MS-Exchange-Forest-EmailMessageHash: 2EE2F216
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent



On 3/29/24 13:27, Jeff Johnson wrote:
> While fixing kernel-doc issues it was discovered that the
> ieee80211_set_hw_80211_encap() prototype doesn't actually have an
> implementation, so remove it.
>=20
> Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
> rework tx encapsulation offload API").
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/net/mac80211.h | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 353488ab94a2..e6a11a982ca8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw =
*hw,
>  u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>  			      struct ieee80211_tx_info *info,
>  			      int len);
> -/**
> - * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloadi=
ng.
> - *
> - * This function is used to notify mac80211 that a vif can be passed raw=
 802.3
> - * frames. The driver needs to then handle the 802.11 encapsulation insi=
de the
> - * hardware or firmware.
> - *
> - * @vif: &struct ieee80211_vif pointer from the add_interface callback.
> - * @enable: indicate if the feature should be turned on or off
> - */
> -bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable=
);
> -
>  /**
>   * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
>   * @hw: pointer obtained from ieee80211_alloc_hw().
>=20

--=20
#Randy


