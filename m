Return-Path: <linux-kernel+bounces-116755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B088A361
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DBF1F3CCA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AF179964;
	Mon, 25 Mar 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVg5hlAH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239A1836E5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359492; cv=none; b=tZp/TYAW5tlNPANMzQ53kL1sqalOdMICLo+zWp3sS1tYNi7RP52nO4qVNcMLYbL7juMOORzWN8HrV+z2I45S7n7uW5WfFKybuXqiMrXWWr3H+4KKVwxzIwkUrrpX9VI2AKEA6Pd2KFsSKa54ffZQSVqXkd8BvKGrCXzJVg1rMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359492; c=relaxed/simple;
	bh=EQ1HsO6QIJqTmKkFeylF6AirsxTv+6QlkXiDRloCcTY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gP2iZ9Bb2LFDExWJ03aFI4mw+6toTd7UPYumZ7w2A23eJft65iyD/pQfkVShsO8u5NCAyZyUfkLcjv1lmaGnpPi7cwOgz9QIPLz8jgaezQUg+fmW+eK5YIPtCGngXrIuNJYPmGEDKk5lhrxX3rZL+FAIFAapM3VcP2HOyVxIgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVg5hlAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711359489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ1HsO6QIJqTmKkFeylF6AirsxTv+6QlkXiDRloCcTY=;
	b=MVg5hlAHfYp1iP+LiNwWs0mL9yDAhljtVVnSB3xD1e1uea+cno5ne7Kz4wmQ+024CdPvo2
	QSAtyrH+sGS+e13Ld+z4oHvc8xJoxd2MMmCtt+4bnYtna6C6rF1uFglfjgDYbHSyiW0iwV
	c7M4Hg9Uv4kkk6FMEMSCM4XC1sWcKOQ=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-rSAIAT5DOWGKQDqd9KrkNA-1; Mon, 25 Mar 2024 05:38:07 -0400
X-MC-Unique: rSAIAT5DOWGKQDqd9KrkNA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4d45ccdc53aso1369614e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359486; x=1711964286;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EQ1HsO6QIJqTmKkFeylF6AirsxTv+6QlkXiDRloCcTY=;
        b=lbWWEEwD93lSN4/V/dwcYwAEG8VQ4wBTk0cRUv39VUslHq10qHtqrr1JH+ovO3ZvtF
         R+p7X0BXK/z1880tDdA+jWLOTmV90ehO9/YBG4L0bMlZTQ1WqcVCUWP+YDLOEXW3mwg2
         i873HIa0kwsJgXGknxNLi5/UGNjDOZjaKJNESTxdP3+erIcqU7Jp5nvlePOXaRG6j/Pd
         SStlaH/vIwrWb9uXbA2X1Wb7MAcrXx/YygqfTVvUZ85QdXAwIY4aVsDZMdjCFbWJYCXZ
         iwBtHMs34Kt2mE4nbsbL5qjV+UxaLBlvl4nOhXRh5Pq6u2aZXTeyah4N/psZDukTaUsO
         5SNw==
X-Forwarded-Encrypted: i=1; AJvYcCW88wasK2aVo0sIv+0QpLmq3H9GLobou12fDSOEuv8V/iPRcwU9Gkk+ErhEs1T9cM3Y/P99OzyhTZctzu/xmP6RfGI61VKri0Zciv0k
X-Gm-Message-State: AOJu0Yx8A6YyrYKcTPVUJ1HaTVaNvEgI393b9x1vGiJlprH5ffYkgSTZ
	WWrediXsj2Rz5AUgvNBMK/sqNY/P+QfMU7gB58ZA6qWYKPMUPuPq3SmknkvILxGHIFeTsWKiD/M
	qKZYANJMlUYSz/fsFPfbKyyjlEinyZ0G+EkiaQVb1JDjzIL49DZ0k4MqiM1Xv1Q==
X-Received: by 2002:a05:6122:4594:b0:4d3:499a:830c with SMTP id de20-20020a056122459400b004d3499a830cmr4117582vkb.13.1711359486572;
        Mon, 25 Mar 2024 02:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YNGaICpGp87RsYUtIz9nsu1fIT7ut0MuIB4f2MT3vsSGIvB1pXmrEjaKH+XInKHMiPDQNw==
X-Received: by 2002:a05:6122:4594:b0:4d3:499a:830c with SMTP id de20-20020a056122459400b004d3499a830cmr4117571vkb.13.1711359486253;
        Mon, 25 Mar 2024 02:38:06 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id fo15-20020ad45f0f000000b0069680284380sm2075628qvb.56.2024.03.25.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:38:06 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:38:00 +0900 (JST)
Message-Id: <20240325.183800.473265130872711273.syoshida@redhat.com>
To: edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
References: <20240324050554.1609460-1-syoshida@redhat.com>
	<CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyNSBNYXIgMjAyNCAxMDowMToyNSArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBTdW4sIE1hciAyNCwgMjAyNCBhdCA2OjA24oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9z
aGlkYUByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+PiBLTVNBTiByZXBvcnRlZCB1bmluaXQtdmFs
dWUgYWNjZXNzIGluIF9faXBfbWFrZV9za2IoKSBbMV0uICBfX2lwX21ha2Vfc2tiKCkNCj4+IHRl
c3RzIEhEUklOQ0wgdG8ga25vdyBpZiB0aGUgc2tiIGhhcyBpY21waGRyLiBIb3dldmVyLCBIRFJJ
TkNMIGNhbiBjYXVzZSBhDQo+PiByYWNlIGNvbmRpdGlvbi4gSWYgY2FsbGluZyBzZXRzb2Nrb3B0
KDIpIHdpdGggSVBfSERSSU5DTCBjaGFuZ2VzIEhEUklOQ0wNCj4+IHdoaWxlIF9faXBfbWFrZV9z
a2IoKSBpcyBydW5uaW5nLCB0aGUgZnVuY3Rpb24gd2lsbCBhY2Nlc3MgaWNtcGhkciBpbiB0aGUN
Cj4+IHNrYiBldmVuIGlmIGl0IGlzIG5vdCBpbmNsdWRlZC4gVGhpcyBjYXVzZXMgdGhlIGlzc3Vl
IHJlcG9ydGVkIGJ5IEtNU0FOLg0KPj4NCj4+IENoZWNrIEZMT1dJX0ZMQUdfS05PV05fTkggb24g
Zmw0LT5mbG93aTRfZmxhZ3MgaW5zdGVhZCBvZiB0ZXN0aW5nIEhEUklOQ0wNCj4+IG9uIHRoZSBz
b2NrZXQuDQo+Pg0KPj4gWzFdDQo+IA0KPiBXaGF0IGlzIHRoZSBrZXJuZWwgdmVyc2lvbiBmb3Ig
dGhpcyB0cmFjZSA/DQoNClNvcnJ5LCBJIHVzZWQgdGhlIGZvbGxvd2luZyB2ZXJzaW9uOg0KDQpD
UFU6IDEgUElEOiAxNTcwOSBDb21tOiBzeXotZXhlY3V0b3IuNyBOb3QgdGFpbnRlZCA2LjguMC0x
MTU2Ny1nYjM2MDNmY2I3OWIxICMyNQ0KSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAo
aTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNi4zLTEuZmMzOSAwNC8wMS8yMDE0DQoNCj4+
IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBfX2lwX21ha2Vfc2tiKzB4MmI3NC8weDJkMjAg
bmV0L2lwdjQvaXBfb3V0cHV0LmM6MTQ4MQ0KPj4gIF9faXBfbWFrZV9za2IrMHgyYjc0LzB4MmQy
MCBuZXQvaXB2NC9pcF9vdXRwdXQuYzoxNDgxDQo+PiAgaXBfZmluaXNoX3NrYiBpbmNsdWRlL25l
dC9pcC5oOjI0MyBbaW5saW5lXQ0KPj4gIGlwX3B1c2hfcGVuZGluZ19mcmFtZXMrMHg0Yy8weDVj
MCBuZXQvaXB2NC9pcF9vdXRwdXQuYzoxNTA4DQo+PiAgcmF3X3NlbmRtc2crMHgyMzgxLzB4MjY5
MCBuZXQvaXB2NC9yYXcuYzo2NTQNCj4+ICBpbmV0X3NlbmRtc2crMHgyN2IvMHgyYTAgbmV0L2lw
djQvYWZfaW5ldC5jOjg1MQ0KPj4gIHNvY2tfc2VuZG1zZ19ub3NlYyBuZXQvc29ja2V0LmM6NzMw
IFtpbmxpbmVdDQo+PiAgX19zb2NrX3NlbmRtc2crMHgyNzQvMHgzYzAgbmV0L3NvY2tldC5jOjc0
NQ0KPj4gIF9fc3lzX3NlbmR0bysweDYyYy8weDdiMCBuZXQvc29ja2V0LmM6MjE5MQ0KPj4gIF9f
ZG9fc3lzX3NlbmR0byBuZXQvc29ja2V0LmM6MjIwMyBbaW5saW5lXQ0KPj4gIF9fc2Vfc3lzX3Nl
bmR0byBuZXQvc29ja2V0LmM6MjE5OSBbaW5saW5lXQ0KPj4gIF9feDY0X3N5c19zZW5kdG8rMHgx
MzAvMHgyMDAgbmV0L3NvY2tldC5jOjIxOTkNCj4+ICBkb19zeXNjYWxsXzY0KzB4ZDgvMHgxZjAg
YXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODMNCj4+ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg2ZC8weDc1DQo+Pg0KPj4gVW5pbml0IHdhcyBjcmVhdGVkIGF0Og0KPj4gIHNsYWJf
cG9zdF9hbGxvY19ob29rIG1tL3NsdWIuYzozODA0IFtpbmxpbmVdDQo+PiAgc2xhYl9hbGxvY19u
b2RlIG1tL3NsdWIuYzozODQ1IFtpbmxpbmVdDQo+PiAga21lbV9jYWNoZV9hbGxvY19ub2RlKzB4
NWY2LzB4YzUwIG1tL3NsdWIuYzozODg4DQo+PiAga21hbGxvY19yZXNlcnZlKzB4MTNjLzB4NGEw
IG5ldC9jb3JlL3NrYnVmZi5jOjU3Nw0KPj4gIF9fYWxsb2Nfc2tiKzB4MzVhLzB4N2MwIG5ldC9j
b3JlL3NrYnVmZi5jOjY2OA0KPj4gIGFsbG9jX3NrYiBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjEz
MTggW2lubGluZV0NCj4+ICBfX2lwX2FwcGVuZF9kYXRhKzB4NDlhYi8weDY4YzAgbmV0L2lwdjQv
aXBfb3V0cHV0LmM6MTEyOA0KPj4gIGlwX2FwcGVuZF9kYXRhKzB4MWU3LzB4MjYwIG5ldC9pcHY0
L2lwX291dHB1dC5jOjEzNjUNCj4+ICByYXdfc2VuZG1zZysweDIyYjEvMHgyNjkwIG5ldC9pcHY0
L3Jhdy5jOjY0OA0KPj4gIGluZXRfc2VuZG1zZysweDI3Yi8weDJhMCBuZXQvaXB2NC9hZl9pbmV0
LmM6ODUxDQo+PiAgc29ja19zZW5kbXNnX25vc2VjIG5ldC9zb2NrZXQuYzo3MzAgW2lubGluZV0N
Cj4+ICBfX3NvY2tfc2VuZG1zZysweDI3NC8weDNjMCBuZXQvc29ja2V0LmM6NzQ1DQo+PiAgX19z
eXNfc2VuZHRvKzB4NjJjLzB4N2IwIG5ldC9zb2NrZXQuYzoyMTkxDQo+PiAgX19kb19zeXNfc2Vu
ZHRvIG5ldC9zb2NrZXQuYzoyMjAzIFtpbmxpbmVdDQo+PiAgX19zZV9zeXNfc2VuZHRvIG5ldC9z
b2NrZXQuYzoyMTk5IFtpbmxpbmVdDQo+PiAgX194NjRfc3lzX3NlbmR0bysweDEzMC8weDIwMCBu
ZXQvc29ja2V0LmM6MjE5OQ0KPj4gIGRvX3N5c2NhbGxfNjQrMHhkOC8weDFmMCBhcmNoL3g4Ni9l
bnRyeS9jb21tb24uYzo4Mw0KPj4gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDZk
LzB4NzUNCj4+DQo+PiBGaXhlczogOTllNWFjYWUxOTNlICgiaXB2NDogRml4IHBvdGVudGlhbCB1
bmluaXQgdmFyaWFibGUgYWNjZXNzIGJ1ZyBpbiBfX2lwX21ha2Vfc2tiKCkiKQ0KPj4gUmVwb3J0
ZWQtYnk6IHN5emthbGxlciA8c3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBTaGlnZXJ1IFlvc2hpZGEgPHN5b3NoaWRhQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+
IEkgdGhpbmsgSVB2NiBoYXMgYSBzaW1pbGFyIGlzc3VlLiBJZiB0aGlzIHBhdGNoIGlzIGFjY2Vw
dGVkLCBJIHdpbGwgc2VuZA0KPj4gYSBwYXRjaCBmb3IgSVB2Ni4NCj4+IC0tLQ0KPj4gIG5ldC9p
cHY0L2lwX291dHB1dC5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC9pcF9vdXRwdXQu
YyBiL25ldC9pcHY0L2lwX291dHB1dC5jDQo+PiBpbmRleCAxZmU3OTQ5NjcyMTEuLjM5MjI5ZmQw
NjAxYSAxMDA2NDQNCj4+IC0tLSBhL25ldC9pcHY0L2lwX291dHB1dC5jDQo+PiArKysgYi9uZXQv
aXB2NC9pcF9vdXRwdXQuYw0KPj4gQEAgLTE0NzMsNyArMTQ3Myw3IEBAIHN0cnVjdCBza19idWZm
ICpfX2lwX21ha2Vfc2tiKHN0cnVjdCBzb2NrICpzaywNCj4+ICAgICAgICAgICAgICAgICAgKiBi
eSBpY21wX2hkcihza2IpLT50eXBlLg0KPj4gICAgICAgICAgICAgICAgICAqLw0KPj4gICAgICAg
ICAgICAgICAgIGlmIChzay0+c2tfdHlwZSA9PSBTT0NLX1JBVyAmJg0KPj4gLSAgICAgICAgICAg
ICAgICAgICAhaW5ldF90ZXN0X2JpdChIRFJJTkNMLCBzaykpDQo+PiArICAgICAgICAgICAgICAg
ICAgICEoZmw0LT5mbG93aTRfZmxhZ3MgJiBGTE9XSV9GTEFHX0tOT1dOX05IKSkNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGljbXBfdHlwZSA9IGZsNC0+Zmw0X2ljbXBfdHlwZTsNCj4+ICAg
ICAgICAgICAgICAgICBlbHNlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpY21wX3R5cGUg
PSBpY21wX2hkcihza2IpLT50eXBlOw0KPj4gLS0NCj4+IDIuNDQuMA0KPj4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaC4NCj4gDQo+IEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgZW5vdWdoLCBh
cyBmYXIgYXMgc3l6a2FsbGVyIGlzIGNvbmNlcm5lZC4NCj4gDQo+IHJhd19wcm9iZV9wcm90b19v
cHQoKSBjYW4gbGVhdmUgZ2FyYmFnZSBpbiBmbDRfaWNtcF90eXBlIChhbmQgZmw0X2ljbXBfY29k
ZSkNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuIEJ1dCBJIGRvbid0IHVuZGVyc3RhbmQg
aXQgY2xlYXJseS4gV2hhdA0KZXhhY3RseSBkbyB5b3UgbWVhbiBieSAiZ2FyYmFnZSI/DQoNCnJh
d19wcm9iZV9wcm90b19vcHQoKSBpbW1lZGlhdGVseSByZXR1cm5zIDAgaWYgZmw0LT5mbG93aTRf
cHJvdG8gaXMNCm5vdCBJUFBST1RPX0lDTVA6DQoNCnN0YXRpYyBpbnQgcmF3X3Byb2JlX3Byb3Rv
X29wdChzdHJ1Y3QgcmF3X2ZyYWdfdmVjICpyZnYsIHN0cnVjdCBmbG93aTQgKmZsNCkNCnsNCglp
bnQgZXJyOw0KDQoJaWYgKGZsNC0+Zmxvd2k0X3Byb3RvICE9IElQUFJPVE9fSUNNUCkNCgkJcmV0
dXJuIDA7DQoNCkluIHRoaXMgY2FzZSwgdGhlIGZ1bmN0aW9uIGRvZXNuJ3Qgc2V0IGZsNF9pY21w
X3R5cGUuIERvIHlvdSBtZWFuIHRoaXMNCmNhc2U/DQoNClRoYW5rcywNClNoaWdlcnUNCg==


