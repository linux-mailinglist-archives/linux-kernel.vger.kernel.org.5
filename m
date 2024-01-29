Return-Path: <linux-kernel+bounces-42766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB280840668
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250191F26426
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87763122;
	Mon, 29 Jan 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwa/t1BX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C3634F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533937; cv=none; b=MpzZwIXS7uRQOECeKsFBAGGM9y4tHxHe1owE+VtuNt0x0gd6iIDfy8snEpvZ0+bpFMbtWrguF9UBjBSXpCC4r2QWWb3Gbuz92C2WJgl1T5xAGApN4kZy1qyjgb57XrtLCOMzZMRTfJu822xn+AElUbM4KLfZIXoQZsQG62zS8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533937; c=relaxed/simple;
	bh=Tg/RTki1YiWMWeWeiVLm15dTG+VCsEe0JZ4GfZ9Mero=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeDQ5KfSWEiRELYda/spC2HpZiZ9n4XHh/LRnUlYv6Zt1aKLOUqXqXWaIzzPoHnkcTFsCUq15zvWETaTD6HDiyp/Nwm0ToWNTI1Rl5y+qokoWq790NJ89GIWIgVt4yvhsoiGRyq8rsKOK1FlR4CUz9VxLUnvnF3pohE3Aub9y+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nwa/t1BX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg/RTki1YiWMWeWeiVLm15dTG+VCsEe0JZ4GfZ9Mero=;
	b=Nwa/t1BXf8MfUQxN0DyHblnfJNl9J4VOIGqJANjY6kVvuWZLt1ZggMgghqTcffa1Q0lhs+
	z7UPGY8tmGDne/+bchPECk6pfSTQDYSTjKmJiRjTp+ulMUKqFH5MBGZrZLpDLq+OBikxoS
	s8CbBJkR+owd+M8LFwuYQ2tiWxk6m10=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-qXasfJSsMQCKyBdhJDPhtg-1; Mon, 29 Jan 2024 08:12:13 -0500
X-MC-Unique: qXasfJSsMQCKyBdhJDPhtg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68c3ad8c59eso6256556d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533932; x=1707138732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg/RTki1YiWMWeWeiVLm15dTG+VCsEe0JZ4GfZ9Mero=;
        b=k2dFLwITb8bvKai38TH+HOlb0Yr/IgGkTi/K1jlTRiMi12dlBQTrdbYkHQZjVIKN3e
         3vx2bZhQH/KNsBILZeIArvGDxU5TbPBWoi7WxVZT8x0arONOJ+cwcTJlNcbbxL88rrTG
         mR/4AczYVdReiJjc0DGau2g9MQgMRNQ+D1qCAZdf9IA0GZeNw94VSwZDfayguEvimumQ
         8uScTgAuIqKYhdvZgO28j9dGA5/Ro0wCi+OdRhqMPoWR0FEFOqdVt2jzAjh8HpZdarr1
         2xyTuSZP1GMat6ZLUl0rbgGRNRfy45UOo2Bv3CkeHqsCjgkHxQZyRgD1TrFA7g0HIq9S
         bnKQ==
X-Gm-Message-State: AOJu0YxijQReLO31klOuMaWK0VJtazM6dsD0JXfccYrFB3IkFqI1kYpx
	ryAvZf5i4DJLQvhP+IREwQNs6mGcOplKuVLJbADXcMRIXexiYh3IuGUqfBz2+Z7hQxkKhefb29X
	XIDAKSwlr8HkkKl8BHCUZYDuTjxPyAFViLcw8YItyOICldfwIlNzAJWJQLtn2ZQ==
X-Received: by 2002:a05:6214:4019:b0:685:aa1e:7cec with SMTP id kd25-20020a056214401900b00685aa1e7cecmr8171063qvb.0.1706533932667;
        Mon, 29 Jan 2024 05:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWDNbI/jHDMtAqqYCfjMSp2/DuPBUeXxgboABgVwrapdaantFbhMu7SKWdHGPapU6evDhguw==
X-Received: by 2002:a05:6214:4019:b0:685:aa1e:7cec with SMTP id kd25-20020a056214401900b00685aa1e7cecmr8171042qvb.0.1706533932380;
        Mon, 29 Jan 2024 05:12:12 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id op32-20020a05621445a000b0068c4917df76sm1482033qvb.130.2024.01.29.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:12:11 -0800 (PST)
Message-ID: <82e7ac1c879d66b3aa931b36a18189ac30255735.camel@redhat.com>
Subject: Re: [PATCH v2 10/10] drm/vboxvideo: fix mapping leaks
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas
 <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	stable@kernel.vger.org
Date: Mon, 29 Jan 2024 14:12:08 +0100
In-Reply-To: <e21c0853-d10a-44b5-917a-3f3c08102b87@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
	 <20240123094317.15958-11-pstanner@redhat.com>
	 <e21c0853-d10a-44b5-917a-3f3c08102b87@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksCgpPbiBNb24sIDIwMjQtMDEtMjkgYXQgMTI6MTUgKzAxMDAsIEhhbnMgZGUgR29lZGUgd3Jv
dGU6Cj4gSGkgUGhpbGlwcCwKPiAKPiBPbiAxLzIzLzI0IDEwOjQzLCBQaGlsaXBwIFN0YW5uZXIg
d3JvdGU6Cj4gPiBXaGVuIHRoZSBQQ0kgZGV2cmVzIEFQSSB3YXMgaW50cm9kdWNlZCB0byB0aGlz
IGRyaXZlciwgaXQgd2FzCj4gPiB3cm9uZ2x5Cj4gPiBhc3N1bWVkIHRoYXQgaW5pdGlhbGl6aW5n
IHRoZSBkZXZpY2Ugd2l0aCBwY2ltX2VuYWJsZV9kZXZpY2UoKQo+ID4gaW5zdGVhZAo+ID4gb2Yg
cGNpX2VuYWJsZV9kZXZpY2UoKSB3aWxsIG1ha2UgYWxsIFBDSSBmdW5jdGlvbnMgbWFuYWdlZC4K
PiA+IAo+ID4gVGhpcyBpcyB3cm9uZyBhbmQgd2FzIGNhdXNlZCBieSB0aGUgcXVpdGUgY29uZnVz
aW5nIGRldnJlcyBBUEkgZm9yCj4gPiBQQ0kKPiA+IGluIHdoaWNoIHNvbWUsIGJ1dCBub3QgYWxs
LCBmdW5jdGlvbnMgYmVjb21lIG1hbmFnZWQgdGhhdCB3YXkuCj4gPiAKPiA+IFRoZSBmdW5jdGlv
biBwY2lfaW9tYXBfcmFuZ2UoKSBpcyBuZXZlciBtYW5hZ2VkLgo+ID4gCj4gPiBSZXBsYWNlIHBj
aV9pb21hcF9yYW5nZSgpIHdpdGggdGhlIGFjdHVhbGx5IG1hbmFnZWQgZnVuY3Rpb24KPiA+IHBj
aW1faW9tYXBfcmFuZ2UoKS4KPiA+IAo+ID4gQWRkaXRpb25hbGx5LCBhZGQgYSBjYWxsIHRvIHBj
aW1fcmVxdWVzdF9yZWdpb24oKSB0byBlbnN1cmUKPiA+IGV4Y2x1c2l2ZQo+ID4gYWNjZXNzIHRv
IEJBUiAwLgo+IAo+IEknbSBhIGJpdCB3b3JyaWVkIGFib3V0IHRoaXMgbGFzdCBjaGFuZ2UuIFRo
ZXJlIG1pZ2h0IGJlCj4gaXNzdWVzIHdoZXJlIHRoZSBwY2ltX3JlcXVlc3RfcmVnaW9uKCkgZmFp
bHMgZHVlIHRvCj4gZS5nLiBhIGNvbmZsaWN0IHdpdGggdGhlIHNpbXBsZWZiIC8gc2ltcGxlZHJt
IGNvZGUuCj4gCj4gVGhlcmUgaXMgYSBkcm1fYXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX3Bj
aV9mcmFtZWJ1ZmZlcnMoKQo+IGNhbGwgZG9uZSBiZWZvcmUgaHdfaW5pdCgpIGdldHMgY2FsbGVk
LCBidXQgc3RpbGwgdGhpcwo+IGhhcyBiZWVuIGtub3duIHRvIGNhdXNlIGlzc3VlcyBpbiB0aGUg
cGFzdC4KPiAKPiBDYW4geW91IHNwbGl0IG91dCB0aGUgYWRkaW5nIG9mIHRoZSBwY2ltX3JlcXVl
c3RfcmVnaW9uKCkKPiBpbnRvIGEgc2VwYXJhdGUgcGF0Y2ggYW5kICpub3QqIG1hcmsgdGhhdCBz
ZXBhcmF0ZSBwYXRjaAo+IGZvciBzdGFibGUgPwoKWWVzLCB0aGF0IHNvdW5kcyByZWFzb25hYmxl
LiBJJ2xsIHNwbGl0IGl0IG91dCBhbmQgZGVhbCB3aXRoIGl0IG9uY2UKSSdsbCBzZW5kIHRoZSBv
dGhlciBEUk0gcGF0Y2hlcyBmcm9tIG15IGJhY2tsb2cuCgpHcmVldGluZ3MsClAuCgo+IAo+IFJl
Z2FyZHMsCj4gCj4gSGFucwo+IAo+IAo+IAo+IAo+IAo+ID4gCj4gPiBDQzogPHN0YWJsZUBrZXJu
ZWwudmdlci5vcmc+ICMgdjUuMTArCj4gPiBGaXhlczogODU1OGRlNDAxYjVmICgiZHJtL3Zib3h2
aWRlbzogdXNlIG1hbmFnZWQgcGNpIGZ1bmN0aW9ucyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXBwIFN0YW5uZXIgPHBzdGFubmVyQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy9n
cHUvZHJtL3Zib3h2aWRlby92Ym94X21haW4uYyB8IDI0ICsrKysrKysrKysrKystLS0tLS0tLS0t
Cj4gPiAtCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92Ym94dmlkZW8vdmJv
eF9tYWluLmMKPiA+IGIvZHJpdmVycy9ncHUvZHJtL3Zib3h2aWRlby92Ym94X21haW4uYwo+ID4g
aW5kZXggNDJjMmQ4YTk5NTA5Li43ZjY4NmEwMTkwZTYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vdmJveHZpZGVvL3Zib3hfbWFpbi5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
dmJveHZpZGVvL3Zib3hfbWFpbi5jCj4gPiBAQCAtNDIsMTIgKzQyLDExIEBAIHN0YXRpYyBpbnQg
dmJveF9hY2NlbF9pbml0KHN0cnVjdCB2Ym94X3ByaXZhdGUKPiA+ICp2Ym94KQo+ID4gwqDCoMKg
wqDCoMKgwqDCoC8qIFRha2UgYSBjb21tYW5kIGJ1ZmZlciBmb3IgZWFjaCBzY3JlZW4gZnJvbSB0
aGUgZW5kIG9mCj4gPiB1c2FibGUgVlJBTS4gKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqB2Ym94LT5h
dmFpbGFibGVfdnJhbV9zaXplIC09IHZib3gtPm51bV9jcnRjcyAqCj4gPiBWQlZBX01JTl9CVUZG
RVJfU0laRTsKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqB2Ym94LT52YnZhX2J1ZmZlcnMgPSBw
Y2lfaW9tYXBfcmFuZ2UocGRldiwgMCwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2Ym94LQo+ID4gPmF2YWlsYWJsZV92cmFtX3NpemUsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdmJveC0+bnVtX2NydGNzICoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBWQlZBX01JTl9CVUZGRVJfU0laRSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXZi
b3gtPnZidmFfYnVmZmVycykKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gLUVOT01FTTsKPiA+ICvCoMKgwqDCoMKgwqDCoHZib3gtPnZidmFfYnVmZmVycyA9IHBjaW1f
aW9tYXBfcmFuZ2UoCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBkZXYsIDAsIHZib3gtPmF2YWlsYWJsZV92cmFtX3NpemUsCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZib3gtPm51bV9jcnRjcyAqIFZC
VkFfTUlOX0JVRkZFUl9TSVpFKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIodmJveC0+
dmJ2YV9idWZmZXJzKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
UFRSX0VSUih2Ym94LT52YnZhX2J1ZmZlcnMpOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBm
b3IgKGkgPSAwOyBpIDwgdmJveC0+bnVtX2NydGNzOyArK2kpIHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdmJ2YV9zZXR1cF9idWZmZXJfY29udGV4dCgmdmJveC0+dmJ2YV9p
bmZvW2ldLAo+ID4gQEAgLTExNSwxMiArMTE0LDE1IEBAIGludCB2Ym94X2h3X2luaXQoc3RydWN0
IHZib3hfcHJpdmF0ZSAqdmJveCkKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgRFJNX0lORk8o
IlZSQU0gJTA4eFxuIiwgdmJveC0+ZnVsbF92cmFtX3NpemUpOwo+ID4gwqAKPiA+ICvCoMKgwqDC
oMKgwqDCoHJldCA9IHBjaW1fcmVxdWVzdF9yZWdpb24ocGRldiwgMCwgInZib3h2aWRlbyIpOwo+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gcmV0Owo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIE1hcCBndWVzdC1o
ZWFwIGF0IGVuZCBvZiB2cmFtICovCj4gPiAtwqDCoMKgwqDCoMKgwqB2Ym94LT5ndWVzdF9oZWFw
ID0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfaW9tYXBfcmFuZ2UocGRldiwgMCwgR1VF
U1RfSEVBUF9PRkZTRVQodmJveCksCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHVUVTVF9IRUFQX1NJWkUpOwo+ID4gLcKgwqDCoMKgwqDC
oMKgaWYgKCF2Ym94LT5ndWVzdF9oZWFwKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgdmJveC0+Z3Vlc3RfaGVhcCA9
IHBjaW1faW9tYXBfcmFuZ2UocGRldiwgMCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgR1VFU1RfSEVBUF9PRkZTRVQodmJveCksIEdVRVNUX0hFQVBf
U0laRSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHZib3gtPmd1ZXN0X2hlYXApKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKHZib3gtPmd1
ZXN0X2hlYXApOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBDcmVhdGUgZ3Vlc3QtaGVh
cCBtZW0tcG9vbCB1c2UgMl40ID0gMTYgYnl0ZSBjaHVua3MgKi8KPiA+IMKgwqDCoMKgwqDCoMKg
wqB2Ym94LT5ndWVzdF9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUodmJveC0+ZGRldi5kZXYs
IDQsCj4gPiAtMSwKPiAKCg==


