Return-Path: <linux-kernel+bounces-87403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C086D3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3944B1F23597
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D813F447;
	Thu, 29 Feb 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoBXlUlu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BE7A15D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237516; cv=none; b=oi9Nx8hDPDX/G1neny3EZQ8d62zPtRORZvLVShWSq3QVDP8ax69WpcJyiZfp1/H808hEGzNWVf9jEVJGXtTaPWZNAKCgwK3RYdtmSKNLV42cghBA9ORedaZQPW07nwhgIyJoBFjUM9nWkU55CP8w28DhGzPuqtv+kxuKMxEYd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237516; c=relaxed/simple;
	bh=wCUWyls+QFCRmEtlXcXoqeAoKADv0cByfRKfHfum7OI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auSBKbYArqzooIasMi31sGhqz9akM1BWYkztz5dqSC/31wN9NOuNkLhsUl5FFqKNqs632/06363UqVA+opK0yTrxLLc4Zl23BlMSwglhU6Hlt8K0nS7fXfoAQGEU6PjpRIJLwZEHAUgfXUokWX3ckqpL4LGfZrW6ERBHZbZOzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoBXlUlu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709237513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCUWyls+QFCRmEtlXcXoqeAoKADv0cByfRKfHfum7OI=;
	b=SoBXlUlu8WfxjFVE0ggNkX+MScB6ovuWNLfN9EUXbOF0gEjWtY4xf9Riu1CwrPZUzDWueo
	gr7hRyCYL3DAvKu7TicSGltpbZQ/V5au71DDb54YWLA2sJWJWxNNXF9lHgoznDGwutXaRc
	ucQa0PfpXoAN8pyYafx5f/WlZKl/cuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-pqscT9idMzmglvPqdHi69g-1; Thu, 29 Feb 2024 15:11:50 -0500
X-MC-Unique: pqscT9idMzmglvPqdHi69g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-565a2d89b81so197023a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709237509; x=1709842309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCUWyls+QFCRmEtlXcXoqeAoKADv0cByfRKfHfum7OI=;
        b=bof65Pfji6YwoH2oaFPzif4K3p4FLCkyB0NsPbKdoGoxuKXu6LzliN8556sGr4MVSu
         CheP2j1hE8bQuqd+e/38pcCKFrr01IW+qc1QBfjg86BXnNNq2rXnWfEAcNS+7ZmJYri9
         bz6puZoMkFDeDsc7hWpx4HiscdO6gyAxFoXGoCQsWm+9Uc2oPUqC15EoHkBHq8w6VjYp
         WWyNZPnWw+NRuFWJctBKzcYjJi6OY+P+8kkNUwxsLJWYbKY8Oz87kZ6sLhMQ0GTbOrqF
         fB6z3nuY+8+C45uAHQbdKHb+eQYG1eNp2/K2XTpMhdHY1UtFBs9w8cjNt7dqrlLxqsGB
         Z3EA==
X-Forwarded-Encrypted: i=1; AJvYcCUCvPgWOfTThzEI57EIpjSSK9S8of3H8P2AI2bJwFPR59SHDSI5SjRxfWipW682lhvVdAgjHt+B5S8jixzT8sNr44o519CCC2L/WPCF
X-Gm-Message-State: AOJu0YxjwW2nsQUeICDcDbgvwOFIVNgUKUk19c/v28Eky2KZ7irvn2Ga
	R4xxRfcMBJrbVoSoZIYXBC2xByFDncvSqkh+eKEfHE+kISfIaTbXLVa2BBih/9+iT6qImLfO63Q
	emjTO5UnPPHdefgP7xnrW0UKg/3mAdV6TFDooKOEnbgEVATbfOSHUXJEUkF3S1Q==
X-Received: by 2002:a05:6402:b52:b0:566:c1bb:c53 with SMTP id bx18-20020a0564020b5200b00566c1bb0c53mr467714edb.2.1709237509145;
        Thu, 29 Feb 2024 12:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8NN24HZTzR588zZC0R3aEgVxSM4UGrAXnRC4akUbhRcCGPf/9hwW8yGGuX+EaAUlBc2UFKA==
X-Received: by 2002:a05:6402:b52:b0:566:c1bb:c53 with SMTP id bx18-20020a0564020b5200b00566c1bb0c53mr467706edb.2.1709237508845;
        Thu, 29 Feb 2024 12:11:48 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e0:8800:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id ij26-20020a056402159a00b00562d908daf4sm897563edb.84.2024.02.29.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:11:48 -0800 (PST)
Message-ID: <c278272a64926716cdc5a0a8ca008017c6696d44.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] devres: Switch to use dev_err_probe() for
 unification
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
	 <linux@rasmusvillemoes.dk>
Date: Thu, 29 Feb 2024 21:11:47 +0100
In-Reply-To: <20240229155507.3853059-2-andriy.shevchenko@linux.intel.com>
References: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
	 <20240229155507.3853059-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAyLTI5IGF0IDE3OjUzICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVGhlIGRldm1fKigpIEFQSXMgYXJlIHN1cHBvc2VkIHRvIGJlIGNhbGxlZCBkdXJpbmcgdGhl
IC0+cHJvYmUoKQo+IHN0YWdlLgo+IE1hbnkgZHJpdmVycyAoZXNwZWNpYWxseSBuZXcgb25lcykg
aGF2ZSBzd2l0Y2hlZCB0byB1c2UKPiBkZXZfZXJyX3Byb2JlKCkKPiBmb3IgZXJyb3IgbWVzc2Fn
aW5nIGZvciB0aGUgc2FrZSBvZiB1bmlmaWNhdGlvbi4gTGV0J3MgZG8gdGhlIHNhbWUgaW4KPiB0
aGUgZGV2cmVzIEFQSXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogUGhpbGlwcCBTdGFu
bmVyIDxwc3Rhbm5lckByZWRoYXQuY29tPgoKPiAtLS0KPiDCoGxpYi9kZXZyZXMuYyB8IDE3ICsr
KysrKysrKy0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9saWIvZGV2cmVzLmMgYi9saWIvZGV2cmVzLmMK
PiBpbmRleCBmZTBjNjNjYWViNjguLjI3ZjI4MGEzOWRjYSAxMDA2NDQKPiAtLS0gYS9saWIvZGV2
cmVzLmMKPiArKysgYi9saWIvZGV2cmVzLmMKPiBAQCAtMTI1LDEyICsxMjUsMTMgQEAgX19kZXZt
X2lvcmVtYXBfcmVzb3VyY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+IGNvbnN0IHN0cnVjdCByZXNv
dXJjZSAqcmVzLAo+IMKgwqDCoMKgwqDCoMKgwqByZXNvdXJjZV9zaXplX3Qgc2l6ZTsKPiDCoMKg
wqDCoMKgwqDCoMKgdm9pZCBfX2lvbWVtICpkZXN0X3B0cjsKPiDCoMKgwqDCoMKgwqDCoMKgY2hh
ciAqcHJldHR5X25hbWU7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldDsKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqBCVUdfT04oIWRldik7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFyZXMgfHwg
cmVzb3VyY2VfdHlwZShyZXMpICE9IElPUkVTT1VSQ0VfTUVNKSB7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiaW52YWxpZCByZXNvdXJjZSAlcFJcbiIsIHJl
cyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJT01FTV9FUlJfUFRS
KC1FSU5WQUwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZfZXJy
X3Byb2JlKGRldiwgLUVJTlZBTCwgImludmFsaWQgcmVzb3VyY2UKPiAlcFJcbiIsIHJlcyk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJT01FTV9FUlJfUFRSKHJldCk7
Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodHlwZSA9PSBE
RVZNX0lPUkVNQVAgJiYgcmVzLT5mbGFncyAmCj4gSU9SRVNPVVJDRV9NRU1fTk9OUE9TVEVEKQo+
IEBAIC0xNDQsMjAgKzE0NSwyMCBAQCBfX2Rldm1faW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgZGV2
aWNlICpkZXYsCj4gY29uc3Qgc3RydWN0IHJlc291cmNlICpyZXMsCj4gwqDCoMKgwqDCoMKgwqDC
oGVsc2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByZXR0eV9uYW1lID0gZGV2
bV9rc3RyZHVwKGRldiwgZGV2X25hbWUoZGV2KSwKPiBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFwcmV0dHlfbmFtZSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZXJyKGRldiwgImNhbid0IGdlbmVyYXRlIHByZXR0eSBuYW1lIGZvciByZXNvdXJjZQo+
ICVwUlxuIiwgcmVzKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIElP
TUVNX0VSUl9QVFIoLUVOT01FTSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dCA9IGRldl9lcnJfcHJvYmUoZGV2LCAtRU5PTUVNLCAiY2FuJ3QgZ2VuZXJhdGUKPiBwcmV0dHkg
bmFtZSBmb3IgcmVzb3VyY2UgJXBSXG4iLCByZXMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gSU9NRU1fRVJSX1BUUihyZXQpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFkZXZtX3JlcXVlc3RfbWVtX3JlZ2lvbihkZXYsIHJl
cy0+c3RhcnQsIHNpemUsCj4gcHJldHR5X25hbWUpKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiY2FuJ3QgcmVxdWVzdCByZWdpb24gZm9yIHJlc291cmNl
Cj4gJXBSXG4iLCByZXMpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
SU9NRU1fRVJSX1BUUigtRUJVU1kpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgLUVCVVNZLCAiY2FuJ3QgcmVxdWVzdAo+IHJlZ2lvbiBm
b3IgcmVzb3VyY2UgJXBSXG4iLCByZXMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gSU9NRU1fRVJSX1BUUihyZXQpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDC
oMKgwqDCoMKgwqDCoMKgZGVzdF9wdHIgPSBfX2Rldm1faW9yZW1hcChkZXYsIHJlcy0+c3RhcnQs
IHNpemUsIHR5cGUpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWRlc3RfcHRyKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiaW9yZW1hcCBmYWlsZWQgZm9y
IHJlc291cmNlICVwUlxuIiwKPiByZXMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZGV2bV9yZWxlYXNlX21lbV9yZWdpb24oZGV2LCByZXMtPnN0YXJ0LCBzaXplKTsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzdF9wdHIgPSBJT01FTV9FUlJfUFRSKC1FTk9N
RU0pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZfZXJyX3Byb2Jl
KGRldiwgLUVOT01FTSwgImlvcmVtYXAgZmFpbGVkIGZvcgo+IHJlc291cmNlICVwUlxuIiwgcmVz
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIElPTUVNX0VSUl9QVFIo
cmV0KTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBk
ZXN0X3B0cjsKCg==


