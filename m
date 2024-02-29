Return-Path: <linux-kernel+bounces-86348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EB86C439
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A589C28A1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B25577C;
	Thu, 29 Feb 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpEBHYwp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB854BFC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196760; cv=none; b=eUzxv+fe5RlfPB0ASRr4n5FHUumG6XWP3LpjmIJQWpM4EQBHk2PegWfTIYWtKMH2gdxoaVQXYz4wwNsxzudPnJwQeMpspZ3wh9jZEMY1rxasANpmAIQo3rkRMhIMLnZU0NJgzX1W105fWrUQfhMOFqICtvH41WNlJGWM0vxe1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196760; c=relaxed/simple;
	bh=9nYXiuyRyM5DbtFyVILh4g2b2FdEhMst0eyZ1e04d0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIaZ4Wosux39rIvhrTp3LPPA8I2WoHxSy51PVA0cba9umbRCYsynKWmermC87aP2b96ZKzq6DhZsNidmgvSMlrF+MXfdyg5iov+mJgA2tkH/PTD8kRyWO1xQpnEEuGHHHOS+xylUcHHdJNC6XOPxlv1iLnBTZszJ0wjyMsDHOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpEBHYwp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nYXiuyRyM5DbtFyVILh4g2b2FdEhMst0eyZ1e04d0M=;
	b=CpEBHYwpP5vMb4Xlh8H7GVYmlVgGIvC9Kh4byU4ynehcM3GThUf8HxxxYeQeYSfgTZxJ/W
	mcy+XueQYllxH0qP8QW/t4weD4J0WUyyfy3bbCAVjCkBUJcHdRPxcNKusvFZcAWwLzHvQn
	1WCPmBUAGNzzdTAqApD6NwKqdMwq1tI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-gquJRxlDMniWYtjKIsVXew-1; Thu, 29 Feb 2024 03:52:36 -0500
X-MC-Unique: gquJRxlDMniWYtjKIsVXew-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a436a38bf5bso5173266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196755; x=1709801555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nYXiuyRyM5DbtFyVILh4g2b2FdEhMst0eyZ1e04d0M=;
        b=rv2tY+c2QZiJVapZyyzVv6xh+ylsOwgjo78OH001rcFeCafhPeMWmxqdl2Kcn3YACi
         Xw9mYUkbIH4OcSkhyfqAlA935aASdlzV5ujremLAGmVCYwpwRBvX6hX99ogxpcLCQSbV
         3D5rsJTtAA1GHlTilyy/hekrP25dd4RPOlH2HHCbbPp8TiXar2CSWAfab+k6JGnAfoEj
         LK+cJXTv9c77aPsrSoDmbDIAQvoq8T6+Q7eBT8TudUs2IZPOp3uxj3xpkB0vP1E+1t3Z
         t9rCa+WlnSj4JLy686RWIqPsv2LWcNhpsZA0LJnkfS4S4INT7B3kN2VK9lJP/eiyJE8R
         QlTg==
X-Forwarded-Encrypted: i=1; AJvYcCW2lYmTKT/K+pOdtON2XYxYapdImmBTiQl5yax02smsqJ6QGSgOc1kLasH/BMeBbeIngu/lqDl5LcC95IiJZdDxafbs1uLB7XTh0/mY
X-Gm-Message-State: AOJu0YyDjGfUpTIKfvukfnf6/GVs/vjqNokLLfuQq/3S6WmhJkqeB+C6
	W0OTnZedwmaUBZ9dxqmyD0M+yhfkZ8S+DQiuG00kDCDm302teg4XpESyRhzUwUBLxghFbh3KRpq
	ws2iW9rWba06/+uFxgj6D2myvxpTnFAaUuPbyBKkbc1fxiLDQ4We+6+Cu9nMwdw==
X-Received: by 2002:a17:906:3183:b0:a3f:161b:cc13 with SMTP id 3-20020a170906318300b00a3f161bcc13mr846577ejy.7.1709196755596;
        Thu, 29 Feb 2024 00:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGGv0ofUlENqBf350+fnsDSlxXIzU6QNZdE9WhrCe7AfFFb8sWeMwYmApPfW6fAwc0VsM4UA==
X-Received: by 2002:a17:906:3183:b0:a3f:161b:cc13 with SMTP id 3-20020a170906318300b00a3f161bcc13mr846569ejy.7.1709196755180;
        Thu, 29 Feb 2024 00:52:35 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e0:8800:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906bc4f00b00a433634ba03sm461623ejv.43.2024.02.29.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:52:34 -0800 (PST)
Message-ID: <e2f49a1f1877550c4ca733bbca26949836d4fef1.camel@redhat.com>
Subject: Re: [PATCH v1 1/2] devres: Switch to use dev_err_probe() for
 unification
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
	 <linux@rasmusvillemoes.dk>, pstanner@redhat.com
Date: Thu, 29 Feb 2024 09:52:34 +0100
In-Reply-To: <20240227175910.3031342-2-andriy.shevchenko@linux.intel.com>
References: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
	 <20240227175910.3031342-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTAyLTI3IGF0IDE5OjU4ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVGhlIGRldm1fKigpIEFQSXMgYXJlIHN1cHBvc2VkIHRvIGJlIGNhbGxlZCBkdXJpbmcgdGhl
IC0+cHJvYmUoKQo+IHN0YWdlLgo+IE1hbnkgZHJpdmVycyAoZXNwZWNpYWxseSBuZXcgb25lcykg
aGFzIHN3aXRjaGVkIHRvIHVzZQoKaGFzIC0+IGhhdmUKCj4gZGV2X2Vycl9wcm9iZSgpCj4gZm9y
IGVycm9yIG1lc3NhZ2luZyBmb3IgdGhlIHNha2Ugb2YgdW5pZmljYXRpb24uIExldCdzIGRvIHRo
ZSBzYW1lIGluCj4gdGhlIGRldnJlcyBBUElzLgoKTm8gb2JqZWN0aW9ucyBvbiBwcmluY2lwbGUu
IEp1c3Qgb25lIHRoaW5nIGFib3V0IHRoZSBpbXBsZW1lbnRhdGlvbjoKCj4gCj4gU2lnbmVkLW9m
Zi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
Cj4gLS0tCj4gwqBsaWIvZGV2cmVzLmMgfCAxNyArKysrKysrKystLS0tLS0tLQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvbGliL2RldnJlcy5jIGIvbGliL2RldnJlcy5jCj4gaW5kZXggZmUwYzYzY2FlYjY4Li4yN2Yy
ODBhMzlkY2EgMTAwNjQ0Cj4gLS0tIGEvbGliL2RldnJlcy5jCj4gKysrIGIvbGliL2RldnJlcy5j
Cj4gQEAgLTEyNSwxMiArMTI1LDEzIEBAIF9fZGV2bV9pb3JlbWFwX3Jlc291cmNlKHN0cnVjdCBk
ZXZpY2UgKmRldiwKPiBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywKPiDCoMKgwqDCoMKgwqDC
oMKgcmVzb3VyY2Vfc2l6ZV90IHNpemU7Cj4gwqDCoMKgwqDCoMKgwqDCoHZvaWQgX19pb21lbSAq
ZGVzdF9wdHI7Cj4gwqDCoMKgwqDCoMKgwqDCoGNoYXIgKnByZXR0eV9uYW1lOwo+ICvCoMKgwqDC
oMKgwqDCoGludCByZXQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgQlVHX09OKCFkZXYpOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcmVzIHx8IHJlc291cmNlX3R5cGUocmVzKSAhPSBJT1JF
U09VUkNFX01FTSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRl
diwgImludmFsaWQgcmVzb3VyY2UgJXBSXG4iLCByZXMpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gSU9NRU1fRVJSX1BUUigtRUlOVkFMKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gZGV2X2Vycl9wcm9iZShkZXYsIC1FSU5WQUwsICJpbnZh
bGlkIHJlc291cmNlCj4gJXBSXG4iLCByZXMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gSU9NRU1fRVJSX1BUUihyZXQpOwoKU28gYXMgSSBzZWUgaXQgLUVJTlZBTCBp
cyBqdXN0IHBpcGVkIHRocm91Z2ggZGV2X2Vycl9wcm9iZSgpIGFuZCBpcwpuZXZlciBjaGFuZ2Vk
LgpEb24ndCB5b3UgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGRyb3AgdmFyaWFibGUgJ3Jl
dCcgYW5kIGp1c3QgZG8KcmV0dXJuIElPTUVNX0VSUl9QVFIoLUVJTlZBTCk7CmFzIGJlZm9yZT8K
ClRoYXQgd2F5IGl0IHdvdWxkIGJlIG9idmlvdXMgdGhhdCB0aGUgZXJyb3IgY29kZSBpcyBuZXZl
ciBjaGFuZ2VkIGFuZAppdCB3aWxsIGFsd2F5cyByZXR1cm4gLUVJTlZBTC4gT3RoZXJ3aXNlIHlv
dSBoYXZlIHRvIGxvb2sgdXAgdGhlCmZ1bmN0aW9uIGRlZmluaXRpb24gb2YgZGV2X2Vycl9wcm9i
ZSgpLgoKVGhlIHNhbWUgd291bGQgYXBwbHkgYmVsb3cuCgpSZWdhcmRzLApQLgoKPiDCoMKgwqDC
oMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0eXBlID09IERFVk1fSU9SRU1B
UCAmJiByZXMtPmZsYWdzICYKPiBJT1JFU09VUkNFX01FTV9OT05QT1NURUQpCj4gQEAgLTE0NCwy
MCArMTQ1LDIwIEBAIF9fZGV2bV9pb3JlbWFwX3Jlc291cmNlKHN0cnVjdCBkZXZpY2UgKmRldiwK
PiBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywKPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJldHR5X25hbWUgPSBkZXZtX2tzdHJkdXAo
ZGV2LCBkZXZfbmFtZShkZXYpLAo+IEdGUF9LRVJORUwpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
IXByZXR0eV9uYW1lKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIo
ZGV2LCAiY2FuJ3QgZ2VuZXJhdGUgcHJldHR5IG5hbWUgZm9yIHJlc291cmNlCj4gJXBSXG4iLCBy
ZXMpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gSU9NRU1fRVJSX1BU
UigtRU5PTUVNKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gZGV2X2Vy
cl9wcm9iZShkZXYsIC1FTk9NRU0sICJjYW4ndCBnZW5lcmF0ZQo+IHByZXR0eSBuYW1lIGZvciBy
ZXNvdXJjZSAlcFJcbiIsIHJlcyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiBJT01FTV9FUlJfUFRSKHJldCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIWRldm1fcmVxdWVzdF9tZW1fcmVnaW9uKGRldiwgcmVzLT5zdGFydCwg
c2l6ZSwKPiBwcmV0dHlfbmFtZSkpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGV2X2VycihkZXYsICJjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2UKPiAlcFJcbiIs
IHJlcyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJT01FTV9FUlJf
UFRSKC1FQlVTWSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRldl9l
cnJfcHJvYmUoZGV2LCAtRUJVU1ksICJjYW4ndCByZXF1ZXN0Cj4gcmVnaW9uIGZvciByZXNvdXJj
ZSAlcFJcbiIsIHJlcyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJ
T01FTV9FUlJfUFRSKHJldCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDC
oMKgwqBkZXN0X3B0ciA9IF9fZGV2bV9pb3JlbWFwKGRldiwgcmVzLT5zdGFydCwgc2l6ZSwgdHlw
ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghZGVzdF9wdHIpIHsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJpb3JlbWFwIGZhaWxlZCBmb3IgcmVzb3VyY2Ug
JXBSXG4iLAo+IHJlcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZtX3Jl
bGVhc2VfbWVtX3JlZ2lvbihkZXYsIHJlcy0+c3RhcnQsIHNpemUpOwo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkZXN0X3B0ciA9IElPTUVNX0VSUl9QVFIoLUVOT01FTSk7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCAtRU5P
TUVNLCAiaW9yZW1hcCBmYWlsZWQgZm9yCj4gcmVzb3VyY2UgJXBSXG4iLCByZXMpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gSU9NRU1fRVJSX1BUUihyZXQpOwo+IMKg
wqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGRlc3RfcHRyOwoK



