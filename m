Return-Path: <linux-kernel+bounces-117634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A988AD87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E61FA27CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA71C6B6;
	Mon, 25 Mar 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKWmtIvI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F43DABE7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388797; cv=none; b=Ai9EA2QxiBLuek8h7chHE9xN6ky/YIOR+Pugg1RzDG4yZ2a5rvM6DCvRho+aveIlcrVsLj7xKtT8AqFzoEXA1uOXiAhyCtb+9ySDZsPyB8STdNnImF4oRcRJkJg4pG+jZO2iGoYKxPM6QGsP8TnNY1Uha69tPYLiJUY7iVINapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388797; c=relaxed/simple;
	bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SbLiDUG+kaQTQr5+RBBlEqVatSeQ5x8F3hmNr6W1w/qMrMAozVHKoT9NNA7YstFalzfJOxkYPwicg/tHDg9PwTrx6F7IuII7BD6RPFyOCIAGVOFjjDs5DirOOhErHFJHQeLeukpvMqRbp+01g/bSdwPnosYE4iCb1kSXiYK5POo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKWmtIvI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711388795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
	b=BKWmtIvI3KXLeIZ4MgkFSLXMbLGHtnTk5BzQ+WvT5+GSfza0+8TVJZpYuCFhckjSHWl7tP
	5C1JvSKe5zL+Q/P8jHmObukRnZ8rWyrbTuaJMYqkPSF0MDr7p/pJWs/ahLa0wLDvKBVZk2
	MpEtLiDC3d/d2IprkX822DUvNmaiwmg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-W8_43nIVPCqwxSVbnL3ryQ-1; Mon, 25 Mar 2024 13:46:33 -0400
X-MC-Unique: W8_43nIVPCqwxSVbnL3ryQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4765f316435so1576440137.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388793; x=1711993593;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kdik9RytyXLzGtCppyniJaYvSU/T1O3jKHnyaV1mJ0U=;
        b=HD1GxJtJpy/1k3s5sts+Dlb8HbT51HVA3NdUvqqY+lu7S520WuQN0pIS/vNni9gqya
         F2B+KDmEmMuxVsMdx/NvmQfTcA3zpC7MX9IeWLkHsbuoUvFq6vjk7eCGKRttlcSLrpes
         ru+lkyfXGuvhtJPAiQWeSaOMSKdRfHD7OhKcKCbiGmmsEqKtnBTA6SsoSgr2oPKgty+o
         CWVkPVMZDi7Chv6xDsKxaOmdCGfW72th+9aiiue6kdN8jcntg/1SOcshmlu4zQep0orR
         zlacDoF3G0yqfWU8mxbgyXK3cgAPvfkOlUtt5yQbCC0X0pDd1fc+oSkvRkonERCuzxYD
         G96Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3G6YpsVWI272XMXOYPby2v9f1bVWeRBatc9HhLlFFSouOFuN6hXfDyLNeI3ru/R+Z7HFIXqlj1X+lpdcZy4z8smSAEY3uu/5jAR8z
X-Gm-Message-State: AOJu0YzcrWNH/DEAcNPUB0l9CqNeRMdx2qQ6cMyKyf1f4GmAf/mxX/d/
	HRvzgnAXSF/PnLW8ZlIUsggnMaDfZF1pLb1aZ/5XS96ZQVE+31cnI7ta8kicogczb68P4PHfkGP
	sHNQUzl92ZnQrDLYIZYEXAjOSE/qaMe1XHgrlmSOqkNIXIGFSPBrGCPFl41C6ZQ==
X-Received: by 2002:a05:6102:24b8:b0:476:9ac0:e8c4 with SMTP id s24-20020a05610224b800b004769ac0e8c4mr6424220vse.34.1711388793001;
        Mon, 25 Mar 2024 10:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRAPyMUUN927QUcejE1283d1/sx417oRydtG1Ws7LvvoFsKo7zkANOvXQauHyj5s+uSj9o1Q==
X-Received: by 2002:a05:6102:24b8:b0:476:9ac0:e8c4 with SMTP id s24-20020a05610224b800b004769ac0e8c4mr6424145vse.34.1711388791353;
        Mon, 25 Mar 2024 10:46:31 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a214400b00789e49808ffsm2289432qkm.105.2024.03.25.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:46:31 -0700 (PDT)
Date: Tue, 26 Mar 2024 02:46:26 +0900 (JST)
Message-Id: <20240326.024626.67077498140213947.syoshida@redhat.com>
To: edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
References: <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
	<20240325.183800.473265130872711273.syoshida@redhat.com>
	<CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyNSBNYXIgMjAyNCAxMTowNTozMyArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBNb24sIE1hciAyNSwgMjAyNCBhdCAxMDozOOKAr0FNIFNoaWdlcnUgWW9zaGlkYSA8c3lv
c2hpZGFAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gTW9uLCAyNSBNYXIgMjAyNCAxMDow
MToyNSArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPj4gPiBPbiBTdW4sIE1hciAyNCwgMjAy
NCBhdCA2OjA24oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9zaGlkYUByZWRoYXQuY29tPiB3cm90
ZToNCj4+ID4+DQo+PiA+PiBLTVNBTiByZXBvcnRlZCB1bmluaXQtdmFsdWUgYWNjZXNzIGluIF9f
aXBfbWFrZV9za2IoKSBbMV0uICBfX2lwX21ha2Vfc2tiKCkNCj4+ID4+IHRlc3RzIEhEUklOQ0wg
dG8ga25vdyBpZiB0aGUgc2tiIGhhcyBpY21waGRyLiBIb3dldmVyLCBIRFJJTkNMIGNhbiBjYXVz
ZSBhDQo+PiA+PiByYWNlIGNvbmRpdGlvbi4gSWYgY2FsbGluZyBzZXRzb2Nrb3B0KDIpIHdpdGgg
SVBfSERSSU5DTCBjaGFuZ2VzIEhEUklOQ0wNCj4+ID4+IHdoaWxlIF9faXBfbWFrZV9za2IoKSBp
cyBydW5uaW5nLCB0aGUgZnVuY3Rpb24gd2lsbCBhY2Nlc3MgaWNtcGhkciBpbiB0aGUNCj4+ID4+
IHNrYiBldmVuIGlmIGl0IGlzIG5vdCBpbmNsdWRlZC4gVGhpcyBjYXVzZXMgdGhlIGlzc3VlIHJl
cG9ydGVkIGJ5IEtNU0FOLg0KPj4gPj4NCj4+ID4+IENoZWNrIEZMT1dJX0ZMQUdfS05PV05fTkgg
b24gZmw0LT5mbG93aTRfZmxhZ3MgaW5zdGVhZCBvZiB0ZXN0aW5nIEhEUklOQ0wNCj4+ID4+IG9u
IHRoZSBzb2NrZXQuDQo+PiA+Pg0KPj4gPj4gWzFdDQo+PiA+DQo+PiA+IFdoYXQgaXMgdGhlIGtl
cm5lbCB2ZXJzaW9uIGZvciB0aGlzIHRyYWNlID8NCj4+DQo+PiBTb3JyeSwgSSB1c2VkIHRoZSBm
b2xsb3dpbmcgdmVyc2lvbjoNCj4+DQo+PiBDUFU6IDEgUElEOiAxNTcwOSBDb21tOiBzeXotZXhl
Y3V0b3IuNyBOb3QgdGFpbnRlZCA2LjguMC0xMTU2Ny1nYjM2MDNmY2I3OWIxICMyNQ0KPj4gSGFy
ZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1Mg
MS4xNi4zLTEuZmMzOSAwNC8wMS8yMDE0DQo+Pg0KPj4gPj4gQlVHOiBLTVNBTjogdW5pbml0LXZh
bHVlIGluIF9faXBfbWFrZV9za2IrMHgyYjc0LzB4MmQyMCBuZXQvaXB2NC9pcF9vdXRwdXQuYzox
NDgxDQo+PiA+PiAgX19pcF9tYWtlX3NrYisweDJiNzQvMHgyZDIwIG5ldC9pcHY0L2lwX291dHB1
dC5jOjE0ODENCj4+ID4+ICBpcF9maW5pc2hfc2tiIGluY2x1ZGUvbmV0L2lwLmg6MjQzIFtpbmxp
bmVdDQo+PiA+PiAgaXBfcHVzaF9wZW5kaW5nX2ZyYW1lcysweDRjLzB4NWMwIG5ldC9pcHY0L2lw
X291dHB1dC5jOjE1MDgNCj4+ID4+ICByYXdfc2VuZG1zZysweDIzODEvMHgyNjkwIG5ldC9pcHY0
L3Jhdy5jOjY1NA0KPj4gPj4gIGluZXRfc2VuZG1zZysweDI3Yi8weDJhMCBuZXQvaXB2NC9hZl9p
bmV0LmM6ODUxDQo+PiA+PiAgc29ja19zZW5kbXNnX25vc2VjIG5ldC9zb2NrZXQuYzo3MzAgW2lu
bGluZV0NCj4+ID4+ICBfX3NvY2tfc2VuZG1zZysweDI3NC8weDNjMCBuZXQvc29ja2V0LmM6NzQ1
DQo+PiA+PiAgX19zeXNfc2VuZHRvKzB4NjJjLzB4N2IwIG5ldC9zb2NrZXQuYzoyMTkxDQo+PiA+
PiAgX19kb19zeXNfc2VuZHRvIG5ldC9zb2NrZXQuYzoyMjAzIFtpbmxpbmVdDQo+PiA+PiAgX19z
ZV9zeXNfc2VuZHRvIG5ldC9zb2NrZXQuYzoyMTk5IFtpbmxpbmVdDQo+PiA+PiAgX194NjRfc3lz
X3NlbmR0bysweDEzMC8weDIwMCBuZXQvc29ja2V0LmM6MjE5OQ0KPj4gPj4gIGRvX3N5c2NhbGxf
NjQrMHhkOC8weDFmMCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo4Mw0KPj4gPj4gIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDZkLzB4NzUNCj4+ID4+DQo+PiA+PiBVbmluaXQgd2Fz
IGNyZWF0ZWQgYXQ6DQo+PiA+PiAgc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2x1Yi5jOjM4MDQg
W2lubGluZV0NCj4+ID4+ICBzbGFiX2FsbG9jX25vZGUgbW0vc2x1Yi5jOjM4NDUgW2lubGluZV0N
Cj4+ID4+ICBrbWVtX2NhY2hlX2FsbG9jX25vZGUrMHg1ZjYvMHhjNTAgbW0vc2x1Yi5jOjM4ODgN
Cj4+ID4+ICBrbWFsbG9jX3Jlc2VydmUrMHgxM2MvMHg0YTAgbmV0L2NvcmUvc2tidWZmLmM6NTc3
DQo+PiA+PiAgX19hbGxvY19za2IrMHgzNWEvMHg3YzAgbmV0L2NvcmUvc2tidWZmLmM6NjY4DQo+
PiA+PiAgYWxsb2Nfc2tiIGluY2x1ZGUvbGludXgvc2tidWZmLmg6MTMxOCBbaW5saW5lXQ0KPj4g
Pj4gIF9faXBfYXBwZW5kX2RhdGErMHg0OWFiLzB4NjhjMCBuZXQvaXB2NC9pcF9vdXRwdXQuYzox
MTI4DQo+PiA+PiAgaXBfYXBwZW5kX2RhdGErMHgxZTcvMHgyNjAgbmV0L2lwdjQvaXBfb3V0cHV0
LmM6MTM2NQ0KPj4gPj4gIHJhd19zZW5kbXNnKzB4MjJiMS8weDI2OTAgbmV0L2lwdjQvcmF3LmM6
NjQ4DQo+PiA+PiAgaW5ldF9zZW5kbXNnKzB4MjdiLzB4MmEwIG5ldC9pcHY0L2FmX2luZXQuYzo4
NTENCj4+ID4+ICBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0L3NvY2tldC5jOjczMCBbaW5saW5lXQ0K
Pj4gPj4gIF9fc29ja19zZW5kbXNnKzB4Mjc0LzB4M2MwIG5ldC9zb2NrZXQuYzo3NDUNCj4+ID4+
ICBfX3N5c19zZW5kdG8rMHg2MmMvMHg3YjAgbmV0L3NvY2tldC5jOjIxOTENCj4+ID4+ICBfX2Rv
X3N5c19zZW5kdG8gbmV0L3NvY2tldC5jOjIyMDMgW2lubGluZV0NCj4+ID4+ICBfX3NlX3N5c19z
ZW5kdG8gbmV0L3NvY2tldC5jOjIxOTkgW2lubGluZV0NCj4+ID4+ICBfX3g2NF9zeXNfc2VuZHRv
KzB4MTMwLzB4MjAwIG5ldC9zb2NrZXQuYzoyMTk5DQo+PiA+PiAgZG9fc3lzY2FsbF82NCsweGQ4
LzB4MWYwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjgzDQo+PiA+PiAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NmQvMHg3NQ0KPj4gPj4NCj4+ID4+IEZpeGVzOiA5OWU1YWNhZTE5
M2UgKCJpcHY0OiBGaXggcG90ZW50aWFsIHVuaW5pdCB2YXJpYWJsZSBhY2Nlc3MgYnVnIGluIF9f
aXBfbWFrZV9za2IoKSIpDQo+PiA+PiBSZXBvcnRlZC1ieTogc3l6a2FsbGVyIDxzeXprYWxsZXJA
Z29vZ2xlZ3JvdXBzLmNvbT4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFNoaWdlcnUgWW9zaGlkYSA8
c3lvc2hpZGFAcmVkaGF0LmNvbT4NCj4+ID4+IC0tLQ0KPj4gPj4gSSB0aGluayBJUHY2IGhhcyBh
IHNpbWlsYXIgaXNzdWUuIElmIHRoaXMgcGF0Y2ggaXMgYWNjZXB0ZWQsIEkgd2lsbCBzZW5kDQo+
PiA+PiBhIHBhdGNoIGZvciBJUHY2Lg0KPj4gPj4gLS0tDQo+PiA+PiAgbmV0L2lwdjQvaXBfb3V0
cHV0LmMgfCAyICstDQo+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+PiA+Pg0KPj4gPj4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L2lwX291dHB1dC5j
IGIvbmV0L2lwdjQvaXBfb3V0cHV0LmMNCj4+ID4+IGluZGV4IDFmZTc5NDk2NzIxMS4uMzkyMjlm
ZDA2MDFhIDEwMDY0NA0KPj4gPj4gLS0tIGEvbmV0L2lwdjQvaXBfb3V0cHV0LmMNCj4+ID4+ICsr
KyBiL25ldC9pcHY0L2lwX291dHB1dC5jDQo+PiA+PiBAQCAtMTQ3Myw3ICsxNDczLDcgQEAgc3Ry
dWN0IHNrX2J1ZmYgKl9faXBfbWFrZV9za2Ioc3RydWN0IHNvY2sgKnNrLA0KPj4gPj4gICAgICAg
ICAgICAgICAgICAqIGJ5IGljbXBfaGRyKHNrYiktPnR5cGUuDQo+PiA+PiAgICAgICAgICAgICAg
ICAgICovDQo+PiA+PiAgICAgICAgICAgICAgICAgaWYgKHNrLT5za190eXBlID09IFNPQ0tfUkFX
ICYmDQo+PiA+PiAtICAgICAgICAgICAgICAgICAgICFpbmV0X3Rlc3RfYml0KEhEUklOQ0wsIHNr
KSkNCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgIShmbDQtPmZsb3dpNF9mbGFncyAmIEZMT1dJ
X0ZMQUdfS05PV05fTkgpKQ0KPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgaWNtcF90eXBl
ID0gZmw0LT5mbDRfaWNtcF90eXBlOw0KPj4gPj4gICAgICAgICAgICAgICAgIGVsc2UNCj4+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgIGljbXBfdHlwZSA9IGljbXBfaGRyKHNrYiktPnR5cGU7
DQo+PiA+PiAtLQ0KPj4gPj4gMi40NC4wDQo+PiA+Pg0KPj4gPg0KPj4gPiBUaGFua3MgZm9yIHlv
dXIgcGF0Y2guDQo+PiA+DQo+PiA+IEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgZW5vdWdoLCBhcyBm
YXIgYXMgc3l6a2FsbGVyIGlzIGNvbmNlcm5lZC4NCj4+ID4NCj4+ID4gcmF3X3Byb2JlX3Byb3Rv
X29wdCgpIGNhbiBsZWF2ZSBnYXJiYWdlIGluIGZsNF9pY21wX3R5cGUgKGFuZCBmbDRfaWNtcF9j
b2RlKQ0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LiBCdXQgSSBkb24ndCB1bmRl
cnN0YW5kIGl0IGNsZWFybHkuIFdoYXQNCj4+IGV4YWN0bHkgZG8geW91IG1lYW4gYnkgImdhcmJh
Z2UiPw0KPj4NCj4+IHJhd19wcm9iZV9wcm90b19vcHQoKSBpbW1lZGlhdGVseSByZXR1cm5zIDAg
aWYgZmw0LT5mbG93aTRfcHJvdG8gaXMNCj4+IG5vdCBJUFBST1RPX0lDTVA6DQo+Pg0KPj4gc3Rh
dGljIGludCByYXdfcHJvYmVfcHJvdG9fb3B0KHN0cnVjdCByYXdfZnJhZ192ZWMgKnJmdiwgc3Ry
dWN0IGZsb3dpNCAqZmw0KQ0KPj4gew0KPj4gICAgICAgICBpbnQgZXJyOw0KPj4NCj4+ICAgICAg
ICAgaWYgKGZsNC0+Zmxvd2k0X3Byb3RvICE9IElQUFJPVE9fSUNNUCkNCj4+ICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4+DQo+PiBJbiB0aGlzIGNhc2UsIHRoZSBmdW5jdGlvbiBkb2Vzbid0
IHNldCBmbDRfaWNtcF90eXBlLiBEbyB5b3UgbWVhbiB0aGlzDQo+PiBjYXNlPw0KPiANCj4gVGhl
cmUgYXJlIG11bHRpcGxlIHdheXMgdG8gcmV0dXJuIGVhcmx5IGZyb20gdGhpcyBmdW5jdGlvbi4N
Cj4gDQo+IEluIGFsbCBvZiB0aGVtLCBmbDQtPmZsNF9pY21wX3R5cGUgaXMgbGVmdCB1bmluaXRp
YWxpemVkLCBzbyBzeXpib3QNCj4gd2lsbCBmaW5kIHdheXMgdG8gdHJpZ2dlciBhIHJlbGF0ZWQg
YnVnLA0KPiBpZiB5b3UgYXNzdW1lIGxhdGVyIHRoYXQgZmw0LT5mbDRfaWNtcF90eXBlIGNvbnRh
aW5zIHZhbGlkIChpbml0aWFsaXplZCkgZGF0YS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5
LiBJIHNlZSB5b3VyIHBvaW50Lg0KDQpmbDQtPmZsNF9pY21wX3R5cGUgaXMgcGFydCBvZiBmbG93
aV91bGkgdW5pb24gaW4gZmxvd2k0IHN0cnVjdHVyZSwgYW5kDQpmbG93aTRfaW5pdF9vdXRwdXQo
KSBpbml0aWFsaXplcyBmbDRfZHBvcnQgYW5kIGZsNF9zcG9ydCB0byB6ZXJvLg0KDQpJIHRob3Vn
aHQgdGhpcyBhbHNvIGluaXRpYWxpemVzIGZsNF9pY21wX3R5cGUgYW5kIGZsNF9pY21wX2NvZGUu
IERvDQp5b3UgdGhpbmsgd2Ugc2hvdWxkIGluaXRpYWxpemUgZmw0X2ljbXBfdHlwZSBhbmQgZmw0
X2ljbXBfY29kZQ0KZXhwbGljaXRseSwgb3RoZXJ3aXNlIGFtIEkgbWlzdW5kZXJzdGFuZGluZz8N
Cg0KVGhhbmtzLA0KU2hpZ2VydQ0K


