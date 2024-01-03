Return-Path: <linux-kernel+bounces-15040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE6822694
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91CAB2265C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4091379;
	Wed,  3 Jan 2024 01:37:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623F10EE;
	Wed,  3 Jan 2024 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 09:32:17 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 09:32:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: missing capability check in __rfcomm_release_dev()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20dc58ee.bf74.18cccf32c62.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowADXOuoiuZRlrAkDAA--.32362W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAgFE2WUJeXn3AABsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSBvYnNlcnZlZCBhIHBvdGVudGlhbCBlbmhhbmNlbWVudCBpbiB0aGUgX19yZmNvbW1f
cmVsZWFzZV9kZXYoKSBmdW5jdGlvbi4gQ3VycmVudGx5LCB0aGUgZnVuY3Rpb24gY2hlY2tzIENB
UF9ORVRfQURNSU4gYXQgbGluZSA0NTIsIHByaW1hcmlseSBzYWZlZ3VhcmRpbmcgcmZjb21tX2Rs
Y19jbG9zZSgpIGZvciBjbG9zaW5nIGEgZGF0YSBsaW5rIGNvbm5lY3Rpb24uCldlIGNvbnNpZGVy
IGFuIGV4dHJhIENBUF9TWVNfVFRZX0NPTkZJRyBtYXliZSBuZWVkZWQgZm9yIGhhbmdpbmcgdXAg
YSB0dHkgYXQgbGluZSA0NjkodHR5X3ZoYW5ndXAoKSkuIAoKT24gdGhlIG9uZSBoYW5kLCB0aGUg
ZGVmaW5pdGlvbiBvZiBDQVBfU1lTX1RUWV9DT05GSUcgaW5jbHVkZXMgImVtcGxveSB2YXJpb3Vz
IHByaXZpbGVnZWQgaW9jdGwgb3BlcmF0aW9ucyBvbiB2aXJ0dWFsIHRlcm1pbmFscyIoY2hlY2sg
Y2FwYWJpbGl0eSBtYW51YWwgcGFnZSBodHRwczovL3d3dy5tYW43Lm9yZy9saW51eC9tYW4tcGFn
ZXMvbWFuNy9jYXBhYmlsaXRpZXMuNy5odG1sKTsgb24gdGhlIG90aGVyIGhhbmQsIHRoZSBzaW1p
bGFyIGZ1bmN0aW9uYWxpdHkgaXMgYWxyZWFkeSBwcm90ZWN0ZWQgYnkgQ0FQX1NZU19UVFlfQ09O
RklHIGluIGZzL29wZW4uYy4KClRoZSBjYWxscGF0aCBpbiBuZXQvYmx1ZXRvb3RoL3JmY29tbS90
dHkuYyBpczoKcmZjb21tX2Rldl9pb2N0bCgpIC0mZ3Q7IHJmY29tbV9yZWxlYXNlX2RldigpIC0m
Z3Q7IF9fcmZjb21tX3JlbGVhc2VfZGV2KCkgLSZndDsgdHR5X3ZoYW5ndXAoKQoKVGhlIGNhbGxw
YXRoIGluIGZzL29wZW4uYyBpczogClNZU0NBTExfREVGSU5FMCh2aGFuZ3VwKSAtJmd0OyBjYXBh
YmxlKENBUF9TWVNfVFRZX0NPTkZJRyktJmd0OyB0dHlfdmhhbmd1cF9zZWxmKCkgLSZndDsgdHR5
X3ZoYW5ndXAoKS4KClRoaXMgaXNzdWUgZXhpc3RzIGluIHNldmVyYWwga2VybmVsIHZlcnNpb25z
IGFuZCB3ZSBoYXZlIGNoZWNrZWQgaXQgb24gdGhlIGxhdGVzdCBzdGFibGUgcmVsZWFzZShMaW51
eCA2LjYuOSkuIAoKV2Ugd291bGQgbGlrZSB0byBwcm9tb3RlIHRoZSBwcm9wZXIgdXNlIG9mIGNh
cGFiaWxpdHkgdG8gZW5oYW5jZSB0aGUgcHJvdGVjdGlvbiBvZiBrZXJuZWwgcmVzb3VyY2VzLiBZ
b3VyIGluc2lnaHRzIGFuZCBmZWVkYmFjayBvbiB0aGlzIHByb3Bvc2VkIGFkanVzdG1lbnQgd291
bGQgYmUgaW52YWx1YWJsZS4gVGhhbmsgeW91IGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gY29uc2lk
ZXIgdGhpcyByZXF1ZXN0LgoKQmVzdCByZWdhcmRzLApKaW5nemkK

