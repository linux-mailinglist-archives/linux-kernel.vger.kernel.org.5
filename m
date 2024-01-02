Return-Path: <linux-kernel+bounces-14310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E8821B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2682E282EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842CEAE3;
	Tue,  2 Jan 2024 11:46:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70FEAD3;
	Tue,  2 Jan 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-12 (Coremail) ; Tue, 2 Jan 2024 19:38:31 +0800 (GMT+08:00)
Date: Tue, 2 Jan 2024 19:38:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: inappropriate capability checks in tty_ioctl()
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
Message-ID: <19ed91a4.10d80.18cc9f7d2ea.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tgCowADXTs+39ZNlWUMCAA--.21635W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiBwAEE2WTyAWMFwAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSB3b3VsZCBsaWtlIHRvIHByb3Bvc2UgYW4gYWRqdXN0bWVudCB0byB0aGUgY2FwYWJp
bGl0eSBjaGVja3MgaW4gdGhlIHR0eV9pb2N0bCgpIGZ1bmN0aW9uLiBDdXJyZW50bHksIHRoZSBm
dW5jdGlvbiB1c2VzIENBUF9TWVNfQURNSU4gdG8gcHJvdGVjdCB0aHJlZSBzdWJjb21tYW5kczog
VElPQ0NPTlMsIFRJT0NTVEkgYW5kIFRJT0NWSEFOR1VQLiBXZSBwcm9wb3NlIHVwZGF0aW5nIHRo
aXMgdG8gdXNlIENBUF9TWVNfVFRZX0NPTkZJRyBpbnN0ZWFkIGZvciB0aGUgZm9sbG93aW5nIHJl
YXNvbnM6CgooMSkgQ0FQX1NZU19UVFlfQ09ORklHIGlzIG1vcmUgcmVsZXZhbnQgdG8gdGhlIGZ1
bmN0aW9uczogVGhlIHRocmVlIHN1YmNvbW1hbmRzIGFyZSByZXNwb25zaWJsZSBmb3IgdHR5LXJl
bGF0ZWQgZnVuY3Rpb25zOiByZWRpcmVjdGluZyBjb25zb2xlIG91dHB1dCAoVElPQ0NPTlMpLCBm
YWtpbmcgaW5wdXQgdG8gYSB0ZXJtaW5hbCAoVElPQ1NUSSksIGFuZCBtYWtpbmcgdGhlIHRlcm1p
bmFsIGJlIGh1bmcgdXAgKFRJT0NWSEFOR1VQKS4gQXMgdGhlIGRlZmluaXRpb25zIGluIHRoZSBj
YXBhYmlsaXR5IG1hbnVhbCBwYWdlWzFdLCBDQVBfU1lTX1RUWV9DT05GSUcgaXMgc3BlY2lmaWNh
bGx5IGRlc2lnbmVkIGZvciAiZW1wbG95aW5nIHZhcmlvdXMgcHJpdmlsZWdlZCBpb2N0bCgyKSBv
cGVyYXRpb25zIG9uIHZpcnR1YWwgdGVybWluYWxzLiIgVGhpcyBhbGlnbnMgbW9yZSBjbG9zZWx5
IHdpdGggdGhlIGludGVuZGVkIHVzYWdlIHNjZW5hcmlvIGNvbXBhcmVkIHRvIENBUF9TWVNfQURN
SU4uCgooMikgQ29uc2lzdGVuY3k6IENBUF9TWVNfVFRZX0NPTkZJRyBpcyBhbHJlYWR5IGVtcGxv
eWVkIGluIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwgdG8gcHJvdGVjdCBUSU9DVkhBTkdVUC1s
aWtlIGZ1bmN0aW9uYWxpdHkuIEZvciBpbnN0YW5jZSwgaW4gdHR5X2lvY3RsKCkgQ0FQX1NZU19B
RE1JTiBpcyB1c2VkIGJlZm9yZSB0dHlfdmhhbmd1cCgpLCB3aGlsZSBpbiBTWVNDQUxMX0RFRklO
RTAodmhhbmd1cCksIHdoaWNoIGxvY2F0ZWQgaW4gZnMvb3Blbi5jLCB0aGUgY2hlY2sgaXMgZG9u
ZSB3aXRoIENBUF9TWVNfVFRZX0NPTkZJRyBiZWZvcmUgdHR5X3ZoYW5ndXAoKS4KCigzKSBNYWlu
dGFpbmluZyBMZWFzdCBQcml2aWxlZ2U6IENBUF9TWVNfQVNNSU4gaXMgYWxyZWFkeSBvdmVybG9h
ZGVkIGFuZCBrbm93biBhcyB0aGUgbmV3ICJyb290IlsyXS4gQWNjb3JkaW5nIHRvIHRoZSBtYW51
YWwgcGFnZVsxXSDigJxkb24ndCBjaG9vc2UgQ0FQX1NZU19BRE1JTiBpZiB5b3UgY2FuIHBvc3Np
Ymx5IGF2b2lkIGl04oCdLCBzd2l0Y2hpbmcgdG8gQ0FQX1NZU19UVFlfQ09ORklHIGNvdWxkIGJl
IGhlbHBmdWwgZm9yIHN0YW5kYXJkaXppbmcgdGhlIHVzZSBvZiBjYXBhYmlsaXRpZXMgYW5kIGlt
cGxlbWVudGluZyBsZWFzdCBwcml2aWxlZ2VzLiAKClRoaXMgaXNzdWUgZXhpc3RzIGluIHNldmVy
YWwga2VybmVsIHZlcnNpb25zIGFuZCB3ZSBoYXZlIGNoZWNrZWQgaXQgb24gdGhlIGxhdGVzdCBz
dGFibGUgcmVsZWFzZShMaW51eCA2LjYuOSkuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciB0aG91
Z2h0cyBhbmQgZmVlZGJhY2sgb24gdGhpcyBwcm9wb3NhbC4gVGhhbmsgeW91IGZvciB5b3VyIHRp
bWUgYW5kIGNvbnNpZGVyYXRpb24uCgpCZXN0IHJlZ2FyZHMsCkppbmd6aQoKcmVmZXJlbmNlOgpb
MV0gaHR0cHM6Ly93d3cubWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjcvY2FwYWJpbGl0aWVz
LjcuaHRtbApbMl0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzQ4NjMwNi8K

